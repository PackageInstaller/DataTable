local top=nil;
local eventMgr=nil;
local useNum=0;
local maxNum=0;
local minNum=0;
local sd=nil;
local maxImg=nil;
local minImg=nil;
local addImg=nil;
local removeImg=nil;
function Awake()
    sd=ComUtil.GetCom(slider,"Slider")
    maxImg=ComUtil.GetCom(btn_max,"Image")
    minImg=ComUtil.GetCom(btn_min,"Image")
    addImg=ComUtil.GetCom(btn_add,"Image")
    removeImg=ComUtil.GetCom(btn_remove,"Image")
    CSAPI.AddSliderCallBack(slider,OnSliderChange);
end

function OnDestroy()
    CSAPI.RemoveSliderCallBack(slider,OnSliderChange);
end

function OnOpen()
    if data then
        useNum=data.curNum
        maxNum=data.maxNum
        CSAPI.SetText(txt_currNum, tostring(data.item:GetCount()));
    end
    sd.minValue=minNum;
    sd.maxValue=maxNum;
    CSAPI.SetText(txt2, tostring(useNum));
    SetSlider(useNum)
end

function OnClickClose()
    view:Close();
end

function SetSlider()
    sd.value=useNum;
end

function OnSliderChange(val)
    if val==nil then
        do return end
    end
    useNum=math.floor(val)
    CSAPI.SetText(txt2, tostring(useNum));
    SetBtnState(btn_min,minImg, useNum >= 1);
	SetBtnState(btn_max,maxImg, useNum < maxNum);
    SetBtnState(btn_remove,removeImg, useNum >=1);
    SetBtnState(btn_add,addImg, useNum < maxNum);
end

function SetBtnState(btn,img, enable)
    if btn and img then
        img.raycastTarget=enable;
        CSAPI.SetGOAlpha(btn,enable and 1 or 0.5);
    end
end

function OnClickAdd()
	if useNum < maxNum then
		useNum = useNum + 1;
		CSAPI.SetText(txt2, tostring(useNum));
        SetSlider()
	else
		Tips.ShowTips(LanguageMgr:GetByID(24025));			
	end
end

function OnClickRemove()
	if useNum > minNum then
		useNum = useNum - 1;
		CSAPI.SetText(txt2, tostring(useNum));	
        SetSlider()
	else
		Tips.ShowTips(LanguageMgr:GetByID(24026));	
	end
end

function OnClickMax()
	useNum = maxNum;
    SetSlider()
	CSAPI.SetText(txt2, tostring(useNum));	
end 

function OnClickMin()
	useNum = minNum;
    SetSlider()
	CSAPI.SetText(txt2, tostring(useNum));	
end

function OnClickOK()
    if data and data.cb then
        data.cb(useNum)
    end
    Close()
end

function OnClickCancel()
    Close()
end

function Close()
    view:Close();
end