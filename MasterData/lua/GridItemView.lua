--公用格子
local clickImg = nil;
local removeFunc = nil;--点击删除的回调，素材格子用
local choosieObj = nil;--当前显示的选择物体
local selectType = 1;
local frameList=nil;
local canvasGroup=nil;
local redObj=nil;
function Awake()
	txtCount = ComUtil.GetCom(txt_count, "Text");
	clickImg = ComUtil.GetCom(clickNode, "Image");
	canvasGroup=ComUtil.GetCom(gameObject,"CanvasGroup");
end

--清除
function Clean()
	this.data = nil;
	frameList=GridFrame
	SetAddNum(0);
	CSAPI.SetImgColor(icon, 255, 255, 255, 255);
	CSAPI.SetImgColor(bg, 255, 255, 255, 255);
	SetNewState(false);
	SetClickState(true);
	LoadIcon();
	LoadFrame();
	this.disEvent = false;
	-- CSAPI.SetGOActive(bg,true);
	SetCount()	
	SetDownCount()
	SetLimitTag();
	SetIsUp(false)
	SetDayObj();
	CSAPI.SetGOActive(tBorder,false)
	CSAPI.SetGOActive(tIcon,false)
	if redObj~=nil then
		CSAPI.SetGOActive(redObj,false);
	end
end

--加载框
function LoadFrame(lvQuality)
	local iconLoader=frameList==EquipQualityFrame and ResUtil.EquipSkillIcon or  ResUtil.IconGoods;
	if lvQuality then
		local frame = frameList[lvQuality];
		iconLoader:Load(bg, frame,false);
	else
		iconLoader:Load(bg, frameList[1],false);
	end
end

--加载图标
function LoadIcon(iconName)
	CSAPI.SetGOActive(icon, iconName ~= nil);
	if(iconName) then
		ResUtil.IconGoods:Load(icon, iconName .. "")
	end
end

function SetLimitTag(isLimit)
	CSAPI.SetGOActive(limitObj,isLimit==true);
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

function SetIndex(i)
	this.index = i;
end

--data:GridDataBase和它的衍生类
---_elseData格式：
--isClick:是否启用点击，num:设置素材格子的选择数量,isSelect:是否选中，removeFunc:删除方法，selectType:选择的样式类型：1为无法多选的素材，2为可以多选的素材,3为只显示删除按钮的情况,checkRed:检测红点
function Refresh(data, _elseData)
	Clean();
	this.elseData = _elseData
	local isSelect = false;
	local isClick = true;
	local showNew = false;
	local isSelectLock=false;
	local hideLock=false;
	local checkRed=false;
	selectType = 1;
	if _elseData then
		isClick = _elseData.isClick == true;
		isSelect = _elseData.isSelect == true;
		isSelectLock=_elseData.isSelectLock==true;
		hideLock=_elseData.hideLock;
		selectType = _elseData.selectType == nil and 1 or _elseData.selectType;
		checkRed=_elseData.checkRed;
		if _elseData.num == nil and (isSelect == true or isSelectLock==true) then--只要选中了就是1
			SetAddNum(1)
		elseif _elseData.num ~= nil then
			SetAddNum(_elseData.num)
		end
		showNew = _elseData.showNew == true;
		this.removeFunc = _elseData.removeFunc;
	end
	if (data and data.data~=nil)then
		this.data = data;
		local scale=1;
		local isLoadIcon=false;
		if data:GetClassType()=="GoodsData" or (data.GetRandType and data:GetRandType()=="GoodsData")  then
			local cfg=data:GetCfg();
			if cfg.type==ITEM_TYPE.EQUIP or cfg.type==ITEM_TYPE.EQUIP_MATERIAL then
				if cfg.type==ITEM_TYPE.EQUIP_MATERIAL then
					CSAPI.SetImgColor(bg, 255, 255, 255, 0);
					GridUtil.LoadEquipIcon(icon,tIcon,data:GetIcon(),data:GetQuality(),cfg.type==ITEM_TYPE.EQUIP_MATERIAL,false)
					isLoadIcon=true;
				else
					CSAPI.SetImgColor(bg, 255, 255, 255, 255);
				end
				frameList=EquipQualityFrame
			elseif cfg.type==ITEM_TYPE.CARD_CORE_ELEM then
				CSAPI.SetGOActive(tIcon,true)
				GridUtil.LoadTIcon(tIcon,tBorder,cfg,false);
			elseif cfg.type==ITEM_TYPE.CARD then
				CSAPI.SetGOActive(tIcon,true)
				GridUtil.LoadCIcon(icon,tIcon,cfg,false);
				isLoadIcon=true;
			elseif cfg.type==ITEM_TYPE.PROP and (cfg.dy_value1==PROP_TYPE.IconFrame or cfg.dy_value1==PROP_TYPE.Icon or cfg.dy_value1==PROP_TYPE.IconTitle or cfg.dy_value1==PROP_TYPE.Main_Theme_UI) then --头像框/头像
				local dayTips=nil;
				local dyArr=cfg.dy_arr;
				if dyArr and dyArr[2]~=0 then
					local result=TimeUtil:GetTimeTab(dyArr[2]);
					if result[1]>0 then
						dayTips=LanguageMgr:GetByID(46006,result[1]);
					elseif result[2]>0 then
						dayTips=LanguageMgr:GetByID(46007,result[2]);
					elseif result[3]>0 then
						dayTips=LanguageMgr:GetByID(46008,result[3]);
					end
				-- elseif dyArr and dyArr[2]==0 then
				-- 	dayTips=LanguageMgr:GetByID(46009);
				end
				SetDayObj(dayTips);
			end
			scale=data:GetIconScale();
			if checkRed then
				redObj=UIUtil:SetRedPoint(root,this.data:CheckRed(),78,78);
			end
		elseif data:GetClassType()=="EquipData" then
			frameList=EquipQualityFrame
			scale=data:GetIconScale();
		elseif data:GetClassType()=="CharacterCardsData" then
			scale=1;
			CSAPI.SetGOActive(tIcon,true)
			GridUtil.LoadCIconByCard(icon,tIcon,data:GetCfg(),false)
			isLoadIcon=true;
			-- local mCfg= Cfgs.character:GetByID(data:GetCfg().model);
			-- if mCfg~=nil then
			-- 	CSAPI.SetGOActive(tIcon,true)
			-- 	ResUtil.IconGoods:Load(icon, "rolecard_"..tostring(data:GetQuality()));
			-- 	ResUtil.RoleCard:Load(tIcon,mCfg.icon);
			-- 	CSAPI.SetScale(tIcon,0.36,0.36,0.36);
			-- 	CSAPI.SetAnchor(tIcon,-4,-11);
			-- 	isLoadIcon=true;
			-- end
		end
		local isLimit=false;
		if data:GetExpiry()~=nil or data:IsExipiryType() then
			isLimit=true;
		end
		SetLimitTag(isLimit);
		LoadFrame(data:GetQuality());
		-- SetIcon(data:GetIcon());
		CSAPI.SetGOActive(icon, true);
		if isLoadIcon~=true then
			data:GetIconLoader():Load(icon, data:GetIcon());
		end
		SetCount(data:GetCount());
		SetIconScale(scale);
		if showNew then
			SetNewState(data:IsNew());
		end
	else
		SetEmpty()
	end
	choosieObj = selectType == 1 and selectObj or addObj;
	-- SetChoosie(isSelect);
	-- SetSelectLock(isSelectLock);
	SetClickState(isClick);
end

--不传入数据，显示斜杠或者加
function SetEmpty()
	local str = "btn_1_06"
	if(this.elseData~=nil and this.elseData.plus)  then 
		str = "btn_3"
	end 
	CSAPI.LoadImg(icon, "UIs/Grid/" .. str .. ".png", true, nil, true)
	CSAPI.SetGOActive(icon, true)
end

--设置数量
function SetCount(targetCount)	
	local str=nil;
	if targetCount~=nil then
		str=StringUtil:GetShortNumStr(targetCount);
		-- if targetCount>9999 then
		-- 	local n=targetCount/10000;
		-- 	local c=math.floor(n*10);
		-- 	if c%10==0 then
		-- 		str=tostring(math.floor(n)).."W";
		-- 	else
		-- 		str=tostring(c/10).."W";
		-- 	end
		-- else
		-- 	str=tostring(targetCount)
		-- end
	end
	SetCountText(str);
end

--近显示文本（远征奖励）
function SetCount2(str)
	txtCount.text = str
	CSAPI.SetGOActive(countObj, true)
end

function SetIconScale(scale)
	CSAPI.SetScale(icon, scale, scale, scale);
end

--设置有效天数
function SetDayObj(txt)
	CSAPI.SetGOActive(dayObj,txt~=nil)
	CSAPI.SetText(txt_day,txt);
end

function SetCountText(num)
	local str = num ~= nil and num .. "" or "";
	if str ~= "" and str ~= nil and str ~= "0" then
		txtCount.text = str;
		-- local txt = string.gsub(str, "(<[%p%w]->)", "");
		-- local width = #txt * 16.5;
		-- if width >= 67 then
		-- 	CSAPI.SetRTSize(countObj, width, 29);
		-- else
		-- 	CSAPI.SetRTSize(countObj, 70, 29);
		-- end
		CSAPI.SetGOActive(countObj, true);
	else
		CSAPI.SetGOActive(countObj, false);
	end
end

function OnRecycle()
	if eventMgr then
		eventMgr:ClearListener();
	end
	if goRect == nil then
		goRect = ComUtil.GetCom(gameObject, "RectTransform")
	end
	if canvasGroup then
		canvasGroup.alpha=1;
	end
	if redObj then
		CSAPI.RemoveGO(redObj);
		redObj=nil;
	end
	Clean();
	CSAPI.SetGOActive(gameObject, true);
	goRect.pivot = UnityEngine.Vector2(0.5, 0.5)
	goRect.anchorMax = UnityEngine.Vector2(0.5,0.5)
	goRect.anchorMin = UnityEngine.Vector2(0.5,0.5)
	CSAPI.SetRectSize(gameObject, 222, 222);
	this.callBack = nil;
	this.removeFunc = nil;
end

--移除
function Remove()	
	CSAPI.RemoveGO(gameObject);
end

function SetNewState(isNew)
	if(isNew) then
		CSAPI.SetGOActive(goNew, true);
	else
		CSAPI.SetGOActive(goNew, false);
	end
end

--设置点击状态
function SetClickState(clickState)
	-- CSAPI.SetBtnState(clickNode, clickState);
	clickImg.raycastTarget = clickState;
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

function SetRemoveCB(func)
	this.removeFunc = func;
end

------------------------------------------////add
--字符串显示
-- function SetCountStr(str)
-- CSAPI.SetGOActive(countObj, str and str ~= "")
-- txtCount.text = str
-- --文字长度超出背景长度则重新设置背景图片长度，长度=文字长度+24
-- local width = txtCount.preferredWidth + 24
-- if width > 61 then
-- 	CSAPI.SetRectSize(countObj, width, 31)
-- end
-- end
function SetIconGrey(isGrey)
	local value = isGrey and 100 or 255
	CSAPI.SetImgColor(icon, value, value, value, 255, true)
end

--------------------------------------Stuff
--当前选择的数量
function SetAddNum(num)
	this.currAddNum = num;
	CSAPI.SetText(addNum, tostring(num));
end

--返回当前选择的数量
function GetAddNum()
	return this.currAddNum;
end

--点击减号
function OnClickRemove()
	if this.removeFunc then
		this.removeFunc(this);
	end
end

--空状态待添加
function SetAddType()
	Clean()
	SetClickState(false)
	CSAPI.SetGOActive(icon, true)
	ResUtil:LoadCommonNew(icon, "add_grey")
end

function SetDownCount(str)
	CSAPI.SetText(txtDownCount, str == nil and "" or str)

	if(str~=nil and str~="") then 
		SetCount(nil)
	end 
end

function SetIsUp(b,id)
	if(str~=nil) then 
		LanguageMgr:SetText(txtUp,id)
	end 
	CSAPI.SetGOActive(imgUp, b)
end 
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
clickNode=nil;
root=nil;
nullObj=nil;
bg=nil;
icon=nil;
imgUp=nil;
txtUp=nil;
countObj=nil;
txt_count=nil;
goNew=nil;
txt_new=nil;
txtDownCount=nil;
view=nil;
end
----#End#----