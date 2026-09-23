--公用格子
local clickImg = nil;
local removeFunc = nil;--点击删除的回调，素材格子用
local choosieObj = nil;--当前显示的选择物体
local selectType = 1;
local slotObjs={};
local canvasGroup=nil;
local goNewCanvas=nil;
local holdTime=0;
local longHoldTime=0.8;
local clickPos=nil;
local deviceType = CSAPI.GetDeviceType()
local Input=UnityEngine.Input
local dragDistance=5;--超过这个值则判定为拖拽

function Awake()
	txtCount = ComUtil.GetCom(txt_count, "Text");
	clickImg = ComUtil.GetCom(clickNode, "Image");
    slotObjs={top,left,right,bottom};
	canvasGroup=ComUtil.GetCom(gameObject,"CanvasGroup");
	goNewCanvas=ComUtil.GetCom(goNew,"CanvasGroup");
end

--清除
function Clean()
	this.data = nil;
	SetAddNum(0);
	CSAPI.SetImgColor(icon, 255, 255, 255, 255);
	CSAPI.SetImgColor(bg, 255, 255, 255, 255);
	SetNewState(false);
	SetClickState(true);
	SetIntensify();
	LoadIcon();
	LoadFrame();
	CSAPI.SetGOActive(selectObj, false);
	CSAPI.SetGOActive(addObj, false);
	CSAPI.SetGOActive(exSelect, false);
	SetLockActive(false)
	SetEquipped();
	SetEquipped2(false);
	this.disEvent = false;
	-- CSAPI.SetGOActive(bg,true);
	SetNotMask();
	SetCount()	
	SetDownCount()
	SetIsUp(false)
	SetSlot();
	SetSelectLock(false);
    SetSlotColor();
	SetDisClickMask(false)
	CSAPI.SetScale(clickNode,1,1,1)
	clickPos=nil;
end

--加载框
function LoadFrame(lvQuality)
	if lvQuality then
		local frame = EquipQualityFrame[lvQuality];
		ResUtil.EquipSkillIcon:Load(bg, frame,false);
	else
		ResUtil.EquipSkillIcon:Load(bg, EquipQualityFrame[1],false);
	end
end

function SetSlotColor(lvQuality)
    if lvQuality then
        --设置位置图片的颜色
        CSAPI.SetImgColorByCode(slot,EquipQualityColor[lvQuality],true);
    else
        CSAPI.SetImgColorByCode(slot,EquipQualityColor[1],true);
    end
end

--加载图标
function LoadIcon(iconName)
	CSAPI.SetGOActive(icon, iconName ~= nil);
	if(iconName) then
		ResUtil.EquipSkillIcon:Load(icon, iconName .. "")
	end
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

function SetDisClickMask(disClick)
	CSAPI.SetGOActive(disClickMask, disClick == true);
	CSAPI.SetGOAlpha(root, disClick == true and 0.7 or 1);
end

function OnClickDisClick()
	local dialogdata={};
	dialogdata.content = LanguageMgr:GetTips(76003)
    dialogdata.okText = LanguageMgr:GetByID(56008)
    dialogdata.okText2 = LanguageMgr:GetByType(56008,4)
    dialogdata.okCallBack = function()
        JumpMgr:Jump(20002)
    end
    CSAPI.OpenView("Dialog", dialogdata)
end

function SetIndex(i)
	this.index = i;
end

--data:GridDataBase和它的衍生类
---_elseData格式：
--isClick:是否启用点击，num:设置素材格子的选择数量,isSelect:是否选中，removeFunc:删除方法，selectType:选择的样式类型：1为无法多选的素材，2为可以多选的素材,3为只显示删除按钮的情况,4为背包出售样式
function Refresh(data, _elseData)
	Clean();
	this.elseData = _elseData
	local isSelect = false;
	local isClick = true;
	local showNew = false;
	local disNTween=false;
	local isSelectLock=false;
	local hideLock=false;
	local equippdType=1;
	selectType = 1;
	if _elseData then
		isClick = _elseData.isClick == true;
		isSelect = _elseData.isSelect == true;
		isSelectLock=_elseData.isSelectLock==true;
		hideLock=_elseData.hideLock;
		selectType = _elseData.selectType == nil and 1 or _elseData.selectType;
		equippdType= _elseData.equippdType == nil and 1 or _elseData.equippdType;
		if _elseData.num == nil and (isSelect == true or isSelectLock==true) then--只要选中了就是1
			SetAddNum(1)
		elseif _elseData.num ~= nil then
			SetAddNum(_elseData.num)
		end
		showNew = _elseData.showNew == true;
		disNTween=_elseData.disNewTween==true;--是否禁用New动画
		this.removeFunc = _elseData.removeFunc;
	end
	if data then
		this.data = data;
		LoadFrame(data:GetQuality());
		-- SetIcon(data:GetIcon());
		CSAPI.SetGOActive(icon, true);
		data:GetIconLoader():Load(icon, data:GetIcon());
		if hideLock~=true then
			SetLockActive(data:IsLock());
		end
		SetIconScale(data:GetIconScale());
		if showNew then
			SetNewState(data:IsNew(),disNTween);
		end
		if equippdType==1 or equippedObj2==nil then
			SetEquipped(data:IsEquipped());
		elseif equippedObj2 and equippdType~=1 then
			SetEquipped2(data:IsEquipped());
		end
		if data:GetClassType() == "EquipData" then
			eventMgr = ViewEvent.New();
			eventMgr:AddListener(EventType.Equip_Lock, OnLock);
			SetSlot(data:GetSlot());
            SetSlotColor(data:GetQuality());
			if data:GetType()==EquipType.Material then
				SetCount(data:GetCount());
			else
				SetIntensify(data:GetLv());
			end
			SetDisClickMask(data:GetDisClickState());
			-- CSAPI.SetGOActive(bg,false);
		else
			SetIntensify(0);
		end
	else
		SetEmpty()
	end
	SetChoosie(isSelect);
	SetSelectLock(isSelectLock);
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
		if targetCount>9999 then
			local n=targetCount/10000;
			local c=math.floor(n*10);
			if c%10==0 then
				str=tostring(math.floor(n)).."W";
			else
				str=tostring(c/10).."W";
			end
		else
			str=tostring(targetCount)
		end
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


--设置位置图片
function SetSlot(s)
	if s then
		CSAPI.SetGOActive(slot, true);
		-- ResUtil.IconGoods:Load(slot, SlotFrame[s])
        for k,v in ipairs(slotObjs) do
            if s==3 then
                CSAPI.SetGOActive(v,true);
            elseif s==k and s<3 then
                CSAPI.SetGOActive(v,true);
            elseif s==k+1 and s>3 then
                CSAPI.SetGOActive(v,true);
            else
                CSAPI.SetGOActive(v,false);
            end
        end
	else
		CSAPI.SetGOActive(slot, false);
	end
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

--设置强化
function SetIntensify(lvIntensify)	
	-- if type(lvIntensify) == "number" and lvIntensify == 0 then
	-- 	lvIntensify = nil;
	-- end
	
	if lvIntensify and lvIntensify > 0 then
		-- txtIntensify.text = "+" .. lvIntensify;
		-- CSAPI.SetGOActive(intensifyObj, true);
		SetCountText("+" .. lvIntensify)
	else
		SetCountText()
	end
end

function OnRecycle()
	if eventMgr then
		eventMgr:ClearListener();
	end
	if goRect == nil then
		goRect = ComUtil.GetCom(gameObject, "RectTransform")
	end
	Clean();
	if canvasGroup then
		canvasGroup.alpha=1;
	end
	CSAPI.SetGOActive(gameObject, true);
	goRect.pivot = UnityEngine.Vector2(0.5, 0.5)
	goRect.anchorMax = UnityEngine.Vector2(0.5,0.5)
	goRect.anchorMin = UnityEngine.Vector2(0.5,0.5)
	CSAPI.SetRectSize(gameObject, 222, 222);
	this.callBack = nil;
	this.holdCallBack=nil;
	this.holdTime=0;
	this.removeFunc = nil;
end

--移除
function Remove()	
	CSAPI.RemoveGO(gameObject);
end

function SetNewState(isNew,disTween)
	if disTween==true then
		CSAPI.SetScriptEnable(goNew,"ActionFadeCurve",false);
		goNewCanvas.alpha=1;
	else
		CSAPI.SetScriptEnable(goNew,"ActionFadeCurve",true);
		goNewCanvas.alpha=0;
	end
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

function OnHold()
	if this.holdCallBack~=nil then
		CSAPI.PlayUISound("ui_generic_click_daoju");
		this.holdCallBack(this);
	elseif this.callBack~=nil then
		OnClick();
	end
end

function SetHoldCB(func)
	this.holdCallBack=func;
end

function SetClickCB(func)
	this.callBack = func;
end

function SetRemoveCB(func)
	this.removeFunc = func;
end

--设置选择状态
function SetChoosie(isChoosie)
	if selectType==nil or selectType==1 then
		choosieObj = selectObj;
	elseif selectType==4 then
		choosieObj = selectObj;
	else
		choosieObj = addObj;
	end
	isChoosie = isChoosie == true and true or false;
	this.isSelect = isChoosie;
	if selectType == 3 then
		CSAPI.SetGOActive(addBorder, false);
	elseif selectType==4 then
		CSAPI.SetGOActive(exSelect,isChoosie)
	else
		CSAPI.SetGOActive(addBorder, true);
	end
	CSAPI.SetGOActive(choosieObj, isChoosie);
end

function SetNotMask(notMask)
	CSAPI.SetGOActive(selectNode, not notMask);
end

function IsSelect()
	return this.isSelect or false;
end

function IsSelectLock()
	return this.isSLock or false;
end

function SetSelectLock(isLock)
	CSAPI.SetGOActive(selectLock, isLock);
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

--------------------------------------Equip
function OnLock(sid)
	if this.data and this.data:GetID() == sid and this.disEvent ~= true then
		SetLockActive(this.data:IsLock());
	end
end

function DisEvent()
	this.disEvent = true;
end

function SetLockActive(isShow)
	isShow = isShow or false;
	CSAPI.SetGOActive(lock, isShow);
end

function SetEquipped(isShow)
	isShow = isShow or false;
	--读取角色头像
	if this.data and isShow then
		local card = RoleMgr:GetData(this.data:GetCardId());
		local cfg = card:GetModelCfg();
		if cfg~=nil then
			ResUtil.RoleCard:Load(equippedIcon,cfg.icon);
		end
	end
	CSAPI.SetGOActive(equippedObj, isShow);
end

function SetEquipped2(isShow)
	if equippedObj2~=nil then
		isShow = isShow or false;
		CSAPI.SetGOAlpha(root,isShow and 0.5 or 1);
		CSAPI.SetGOActive(equippedObj2, isShow);
	end
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

function OnPressDown()
	holdTime = Time.unscaledTime;
	clickPos=GetCurPos();
end

function GetCurPos()
    local vec3 = UnityEngine.Vector2(0, 0)
    if (deviceType == 3) then
        -- 电脑
		vec3.x = Input.mousePosition.x
		vec3.y = Input.mousePosition.y
	elseif Input.touchCount == 1 then
        vec3 = Input.GetTouch(0).position
	else
		return nil;
    end
    return vec3
end

function IsDrag()
	local isDrag=false;
	local clickPos2=GetCurPos();
	if clickPos==nil or clickPos2==nil then
		return isDrag,2;
	end
	local distance=UnityEngine.Vector2.Distance(clickPos,clickPos2);
	-- LogError(tostring(clickPos.x).."\t"..tostring(clickPos.y).."\t"..tostring(clickPos2.x).."\t"..tostring(clickPos2.y).."\t"..tostring(distance))
	if distance>dragDistance then
		isDrag=true;
	end
	return isDrag,1
end

function Update()
	local isDrag,state=IsDrag();
	if holdTime~=0 and Time.unscaledTime - holdTime >= longHoldTime and  not isDrag and state~=2 then
		--长按
		OnHold();
		holdTime=0;
	end
end

function OnPressUp()
	local isDrag,state=IsDrag();
	if Time.unscaledTime - holdTime < longHoldTime and not isDrag and state~=2 then
		--短按
		OnClick();
	end
	holdTime=0;
	clickPos=nil;
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
bg=nil;
slot=nil;
icon=nil;
imgUp=nil;
txtUp=nil;
lock=nil;
equippedObj=nil;
equippedIcon=nil;
selectObj=nil;
txt_select=nil;
countObj=nil;
txt_count=nil;
goNew=nil;
txt_new=nil;
txtDownCount=nil;
addObj=nil;
addBorder=nil;
addNum=nil;
removeIcon=nil;
selectLock=nil;
clickImg=nil;
view=nil;
end
----#End#----