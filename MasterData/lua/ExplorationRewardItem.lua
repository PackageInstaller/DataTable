local frameList=nil;
local txtCount=nil;
local clickImg=nil;
local canvasGroup=nil;
function Awake()
	txtCount = ComUtil.GetCom(txt_count, "Text");
	clickImg = ComUtil.GetCom(clickNode, "Image");
	canvasGroup=ComUtil.GetCom(gameObject,"CanvasGroup");
end

function Refresh(data, _elseData)
    if (data and data.data~=nil)then
		this.data = data;
		local scale=1;
		local isLoadIcon=false;
        frameList=GridFrame;
		local iconLoader=ResUtil.IconGoods;
		if data:GetClassType()=="GoodsData" then
			local cfg=data:GetCfg();
			if cfg.type==ITEM_TYPE.EQUIP or cfg.type==ITEM_TYPE.EQUIP_MATERIAL then
				frameList=EquipQualityFrame
				iconLoader=ResUtil.EquipSkillIcon;
			elseif cfg.type==ITEM_TYPE.CARD_CORE_ELEM then
				CSAPI.SetGOActive(tIcon,true)
				GridUtil.LoadTIcon(tIcon,tBorder,cfg,false);
			elseif cfg.type==ITEM_TYPE.CARD then
				CSAPI.SetGOActive(tIcon,true)
				GridUtil.LoadCIcon(icon,tIcon,cfg,false);
				isLoadIcon=true;
			end
			scale=data:GetIconScale();
		elseif data:GetClassType()=="EquipData" then
			frameList=EquipQualityFrame
			iconLoader=ResUtil.EquipSkillIcon;
			scale=data:GetIconScale();
		elseif data:GetClassType()=="CharacterCardsData" then
			scale=1;
			CSAPI.SetGOActive(tIcon,true)
			GridUtil.LoadCIconByCard(icon,tIcon,data:GetCfg(),false)
			isLoadIcon=true;
		end
		LoadFrame(data:GetQuality(),iconLoader);
		CSAPI.SetGOActive(icon, true);
		if isLoadIcon~=true then
			data:GetIconLoader():Load(icon, data:GetIcon());
		end
		SetCount(data:GetCount());
		SetIconScale(scale);
	end
end

--加载图标
function LoadIcon(iconName)
	CSAPI.SetGOActive(icon, iconName ~= nil);
	if(iconName) then
		ResUtil.IconGoods:Load(icon, iconName .. "")
	end
end

function SetIconScale(scale)
	CSAPI.SetScale(icon, scale, scale, scale);
end

--自定义的图集加载图片 loader:ResIconUtil.New返回的对象
function LoadIconByLoader(loader, iconName)
	if loader and iconName then
		CSAPI.SetGOActive(icon, true)
		loader:Load(icon, iconName .. "");
	else
		CSAPI.SetGOActive(icon, false)
	end
end


--加载框
function LoadFrame(lvQuality,iconLoader)
	if lvQuality then
		local frame = frameList[lvQuality];
		ResUtil.IconGoods:Load(bg, frame,false);
	else
		ResUtil.IconGoods:Load(bg, frameList[1],false);
	end
end

function SetCountText(num)
	local str = num ~= nil and num .. "" or "";
	if str ~= "" and str ~= nil and str ~= "0" then
		txtCount.text = str;
		CSAPI.SetGOActive(countObj, true);
	else
		CSAPI.SetGOActive(countObj, false);
	end
end

--设置数量
function SetCount(targetCount)	
	local str=nil;
	if targetCount~=nil then
		str=StringUtil:GetShortNumStr(targetCount);
	end
	SetCountText(str);
end

--设置点击状态
function SetClickState(clickState)
	-- CSAPI.SetBtnState(clickNode, clickState);
	clickImg.raycastTarget = clickState;
end

function SetIndex(i)
	this.index = i;
end

--点击
function OnClick()
	if this.callBack then
		CSAPI.PlayUISound("ui_generic_click_daoju");
		this.callBack(this);
	end
end

function SetClickCB(func)
	this.callBack = func;
end