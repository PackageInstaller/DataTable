--物品信息界面
local useNum = 1;--当前使用的道具数据
local minNum = 1;--最少使用数量
local maxNum = 1;--当前使用的道具最大数量
local enableColor = {225, 116, 0, 255};
local disableColor = {77, 77, 77, 255};
local okBtn = nil;
local addBtn = nil;
local maxBtn=nil;
local minBtn=nil;
local removeBtn = nil;
local itemInfo=nil;
local eventMgr=nil;
local isUse=false;
local defaultSize={0,0};
local endTime=0;
local fixedTime=1;
local upTime=0;
local costNum=0;
local onceLimit=0;

---是否移动平台
local IsMobileplatform=false;
--inpt
local Input=CS.UnityEngine.Input
local KeyCode=CS.UnityEngine.KeyCode


function Awake()
	CSAPI.Getplatform();
	IsMobileplatform=CSAPI.IsMobileplatform;
	addBtn = ComUtil.GetCom(btn_add, "Button");
	removeBtn = ComUtil.GetCom(btn_remove, "Button");
	maxBtn = ComUtil.GetCom(btn_max, "Button");
	minBtn = ComUtil.GetCom(btn_min, "Button");
	-- slider = ComUtil.GetCom(numSlider, "Slider");
	-- CSAPI.AddSliderCallBack(numSlider, SliderCB)
	CSAPI.PlayUISound("ui_popup_open")
    CSAPI.SetText(txt_open,LanguageMgr:GetByID(60111));
    CSAPI.SetText(txt_openTips,LanguageMgr:GetByID(60111,4));
end


function OnViewClose(event)
	if data and data.key==event then
		Close();
	end
end

--data:ItemPoolInfo
function OnOpen()
	if data then
		itemInfo=data:GetCostGoods();
        local costInfo=data:GetCost();
        costNum=costInfo and costInfo[1][2];
        useNum=data:GetDefaultCostNum();
        onceLimit=data:GetMaxCostNum();
	end
	Refresh();
end

function Refresh()
	if itemInfo then
        local cfg = itemInfo:GetCfg();
        local loader=itemInfo:GetIconLoader();
		if loader then
			loader:Load(icon, itemInfo:GetIcon())
		end
		CSAPI.SetScale(icon,1,1,1);
        local count=BagMgr:GetCount(itemInfo:GetID());
        if math.floor(count/costNum)<onceLimit then
            maxNum=math.floor(count/costNum)
        else
            maxNum=onceLimit
        end
        local currRoundMaxNum=data:GetMaxCostNum(true);
        maxNum=maxNum>currRoundMaxNum and currRoundMaxNum or maxNum;
		useNum=maxNum>0 and useNum or 0
        CSAPI.SetText(txt_name, itemInfo:GetName());
		CSAPI.SetText(txt_desc, itemInfo:GetDesc());
		CSAPI.SetText(txt_useNum, tostring(useNum));
        CSAPI.SetText(txt_currNum, tostring(count));
        CSAPI.SetGOActive(tIcon,false);
		CSAPI.SetGOActive(tBorder,false);
    end
end

function OnClickReturn()
	Close();
end

--抽取
function OnClickOpen()
    local count=BagMgr:GetCount(itemInfo:GetID());
    if useNum<=count then
        RegressionProto:ItemPoolDraw(data:GetID(),useNum);
        Close();
    else
        Tip.ShowTips("消耗道具数量不足！")
    end
end

function Close()
	CSAPI.SetGOActive(tweenObj2,true);
	FuncUtil:Call(function()
		if gameObject~=nil and view~=nil then
			view:Close();
		end
	end,nil,180);
end

function OnClickBack()
	CSAPI.SetGOActive(root, true);
end

function SetBtnState(btn, img, enable)
	if btn then
		-- local color = enableColor;
		if enable then
			btn.enabled = enable;
		else
			btn.enabled = false;
			-- color = disableColor;
		end
		-- if img then
		-- 	CSAPI.SetImgColor(img.gameObject, color[1], color[2], color[3], color[4]);
		-- end
	end
end

function OnClickAdd()
	if useNum < maxNum then
		useNum = useNum + 1;
		CSAPI.SetText(txt_useNum, tostring(useNum));
	else
		Tips.ShowTips(LanguageMgr:GetByID(24025));			
	end
	-- SetBtnState(removeBtn, removeImg, useNum > 1);
	-- SetBtnState(addBtn, addImg, useNum < maxNum);
end

function OnClickRemove()
	if useNum > minNum then
		useNum = useNum - minNum;
		CSAPI.SetText(txt_useNum, tostring(useNum));	
	else
		Tips.ShowTips(LanguageMgr:GetByID(24026));	
	end
	-- SetBtnState(removeBtn, removeImg, useNum > 1);
	-- SetBtnState(addBtn, addImg, useNum < maxNum);
end

function OnClickMax()
	useNum = maxNum;
	-- SetBtnState(removeBtn, removeImg, useNum > 1);
	-- SetBtnState(addBtn, addImg, false);
	CSAPI.SetText(txt_useNum, tostring(useNum));	
end 

function OnClickMin()
	useNum = minNum;
	-- SetBtnState(removeBtn, removeImg, useNum > 1);
	-- SetBtnState(addBtn, addImg, useNum < maxNum);
	CSAPI.SetText(txt_useNum, tostring(useNum));	
end

function OnDestroy()    
	-- CSAPI.RemoveSliderCallBack(numSlider, SliderCB);
    ReleaseCSComRefs();
end

---判断检测是否按了返回键
function CheckVirtualkeys()
	--仅仅安卓或者苹果平台生效
	if IsMobileplatform then
		if(Input.GetKeyDown(KeyCode.Escape))then
			--  OnVirtualkey()   调关闭
			if CSAPI.IsBeginnerGuidance()==false then
				OnClickReturn();
			end
		end
	end
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
root=nil;
bg_b1=nil;
layout=nil;
gridNode=nil;
txt_name=nil;
txt_desc=nil;
currNumObj=nil;
txt_has=nil;
txt_currNum=nil;
view=nil;
end
----#End#----