#!/system/bin/sh
#########################################################################
#   AudioLoopback.sh
#   adb push AudioLoopback.sh /system/bin
#   chmod 755 /system/bin/AudioLoopback.sh
#########################################################################

#mode=`getprop debug.audiotest.mode`
#src=`getprop debug.audiotest.src`
#dst=`getprop debug.audiotest.dst`
mode=$1
src=$2
dst=$3
echo "opening loopback:"$2"===>"$3

LOG_TAG="LOOPBACK"
LOG_NAME="${0}:"

loge ()
{
  /system/bin/log -t $LOG_TAG -p e "$LOG_NAME $@"
}

logi ()
{
  /system/bin/log -t $LOG_TAG -p i "$LOG_NAME $@"
}

CODECLOOPBACKSTOP()
{
#        /system/bin/tinymix 'MICBIAS CAPLESS Switch' '0'
        /system/bin/tinymix 'DEC1 MUX' 'ZERO'
        /system/bin/tinymix 'ADC2 MUX' 'ZERO'
        /system/bin/tinymix 'DEC1 Volume' '84'
        /system/bin/tinymix 'ADC1 Volume' '6'
        /system/bin/tinymix 'ADC2 Volume' '6'
        /system/bin/tinymix 'IIR1 INP1 MUX' 'ZERO'
        /system/bin/tinymix 'IIR1 INP1 Volume' '84'
        /system/bin/tinymix 'RX1 MIX1 INP1' 'ZERO'
        /system/bin/tinymix 'RX2 MIX1 INP1' 'ZERO'
        /system/bin/tinymix 'RX3 MIX1 INP1' 'ZERO'
        /system/bin/tinymix 'RDAC2 MUX' 'ZERO'
        /system/bin/tinymix 'HPHL' 'ZERO'
        /system/bin/tinymix 'HPHR' 'ZERO'
        /system/bin/tinymix 'RX1 Digital Volume' '84'
        /system/bin/tinymix 'RX2 Digital Volume' '84'
        /system/bin/tinymix 'EAR_S' 'ZERO'
        /system/bin/tinymix 'EAR PA Gain' 'POS_1P5_DB'
        /system/bin/tinymix 'SPK' 'ZERO'
        /system/bin/tinymix 'Ext Spk Switch' 'Off'
        /system/bin/tinymix 'Loopback MCLK' 'DISABLE'
        /system/bin/tinymix 'LOOPBACK Mode' 'DISABLE'
}

CODECLOOPBACK()
{
    if   [ "$1" == "1" ]; then                               # Builtin_mic
        /system/bin/tinymix 'LOOPBACK Mode' 'ENABLE'
        #/system/bin/tinymix 'MICBIAS CAPLESS Switch' '1'
        /system/bin/tinymix 'DEC1 MUX' 'ADC1'
        /system/bin/tinymix 'DEC1 Volume' '84'
        /system/bin/tinymix 'ADC1 Volume' '6'
        /system/bin/tinymix 'IIR1 INP1 MUX' 'DEC1'
        /system/bin/tinymix 'IIR1 INP1 Volume' '84'
        logi "builtin_mic"
    elif [ "$1" == "2" ]; then                               # Headset_Mic
        /system/bin/tinymix 'LOOPBACK Mode' 'ENABLE'
        #/system/bin/tinymix 'MICBIAS CAPLESS Switch' '1'
        /system/bin/tinymix 'DEC1 MUX' 'ADC2'
        /system/bin/tinymix 'ADC2 MUX' 'INP2'
        /system/bin/tinymix 'DEC1 Volume' '84'
        /system/bin/tinymix 'ADC2 Volume' '6'
        /system/bin/tinymix 'IIR1 INP1 MUX' 'DEC1'
        /system/bin/tinymix 'IIR1 INP1 Volume' '84'
        logi "Headset_Mic"
    elif [ "$1" == "3" ]; then                               # Aux_mic
        /system/bin/tinymix 'LOOPBACK Mode' 'ENABLE'
        #/system/bin/tinymix 'MICBIAS CAPLESS Switch' '1'
        /system/bin/tinymix 'DEC1 MUX' 'ADC2'
        /system/bin/tinymix 'ADC2 MUX' 'INP3'
        /system/bin/tinymix 'DEC1 Volume' '84'
        /system/bin/tinymix 'ADC2 Volume' '6'
        /system/bin/tinymix 'IIR1 INP1 MUX' 'DEC1'
        /system/bin/tinymix 'IIR1 INP1 Volume' '84'
        logi "aux_mic"
    else
        logi "1 exit 0"
        exit 0
    fi

    if   [ "$2" == "3" ]; then                               #Speaker
        /system/bin/tinymix 'EAR PA Gain' 'POS_6_DB'
        /system/bin/tinymix 'RX1 MIX1 INP1' 'IIR1'
        /system/bin/tinymix 'RX2 MIX1 INP1' 'IIR1'
	/system/bin/tinymix 'RDAC2 MUX' 'RX2'
        /system/bin/tinymix 'HPHL' 'Switch'
        /system/bin/tinymix 'HPHR' 'Switch'
	/system/bin/tinymix 'Ext Spk Switch' 'On'
        /system/bin/tinymix 'Loopback MCLK' 'ENABLE'
        logi "Speaker"
    elif [ "$2" == "1" ]; then                               #Receiver
        /system/bin/tinymix 'EAR PA Gain' 'POS_6_DB'    
        /system/bin/tinymix 'RX1 MIX1 INP1' 'IIR1'
        /system/bin/tinymix 'RDAC2 MUX' 'RX1'
        /system/bin/tinymix 'EAR_S' 'Switch'
        /system/bin/tinymix 'EAR PA Gain' 'POS_6_DB'
        /system/bin/tinymix 'RX1 Digital Volume' '80'
        /system/bin/tinymix 'Loopback MCLK' 'ENABLE'
        logi "Receiver"
    elif [ "$2" == "2" ]; then                               #Headset
        /system/bin/tinymix 'EAR PA Gain' 'POS_6_DB'    
	/system/bin/tinymix 'RX1 MIX1 INP1' 'IIR1'
        /system/bin/tinymix 'RX2 MIX1 INP1' 'IIR1'
        /system/bin/tinymix 'RX HPH Mode' 'HD2'
        /system/bin/tinymix 'COMP0 RX1' '1'
        /system/bin/tinymix 'COMP0 RX2' '1'
        /system/bin/tinymix 'RDAC2 MUX' 'RX2'
        /system/bin/tinymix 'HPHL' 'Switch'
        /system/bin/tinymix 'HPHR' 'Switch'
        /system/bin/tinymix 'RX1 Digital Volume' '80'
        /system/bin/tinymix 'RX2 Digital Volume' '80'
        /system/bin/tinymix 'Loopback MCLK' 'ENABLE'
        logi "Headset"
    else
        logi "2 exit 0"
        exit 0
    fi

#   echo "1"
#   echo $1
#   echo $2
}

case $mode in
    "0")
        #CODEC loopback stop
        CODECLOOPBACKSTOP
         logi "stop LOOPBACK"
    ;;
    "2")
        #codec loopback start
        CODECLOOPBACK $src $dst
         logi "start LOOPBACK"
    ;;
esac
