--NP滑动控件
local sdr=nil
local tVal=5;
function Awake()
    sdr=ComUtil.GetCom(Slider,"Slider");
    CSAPI.AddSliderCallBack(Slider,OnSliderChange);
end

function Refresh(data)
    if data==nil then
        LogError("初始化数据不能为Nil");
    end
    CSAPI.SetText(txtTeam,"队伍"..tostring(data.index))
    sdr.value=data.val/tVal;
    SetHandleVal(math.floor(data.val));
end

function OnSliderChange(val)
    SetHandleVal(math.floor(val*tVal));
end

function OnClickRemove()
    sdr.value=sdr.value-1;
end

function OnClickAdd()
    sdr.value=sdr.value+1;
end

function SetHandleVal(val)
    CSAPI.SetText(txtVal,tostring(val));
end

function GetVal()
    return sdr.value*tVal;
end