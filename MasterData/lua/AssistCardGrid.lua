--助战卡牌格子
local colors = {"FFFFFF", "00ffbf", "26dbff", "8080ff", "FFC146"}
local stateColors = {"FF265C", "307be9", "3cc7f5", "cc50ff", "f07b09", "11e70b", "FFFFFF"}
local holdTime = 1.5;
local holdDownTime = 0;
--用于判定拖拽是上阵还是滑动列表,编队用
local dragScript = nil
local attrs={};
local isDrag=false;
local isEvent=false;
local cDeltaX=0;
local cDeltaY=0;
local pressTime=0;
local canDrag=true;
function Awake()
	dragScript = ComUtil.GetCom(btnClick, "DragCallLua");
end

function OnRecycle()
	CSAPI.SetGOActive(gameObject, true)
	if goRect == nil then
		goRect = ComUtil.GetCom(gameObject, "RectTransform")
	end
	goRect.anchorMin = UnityEngine.Vector2(0.5, 0.5)
	goRect.anchorMax = UnityEngine.Vector2(0.5, 0.5)
	goRect.pivot = UnityEngine.Vector2(0.5, 0.5)
	CSAPI.SetAnchor(gameObject, 0, 0, 0)
	cb=nil;
	canDrag=true;
	isEvent=false;
	isDrag=false;
	cDeltaX=0;
	cDeltaY=0;
	pressTime=0;
end

function SetClickCB(_cb)
	cb = _cb
end

function SetIndex(_index)
	index = _index
end


function Clean()
	SetIcon()
	CSAPI.SetGOActive(lvObj, false)
	CSAPI.SetGOActive(Image, false)
	SetName("")
	SetTipsObj()
	SetGridIcon();
	SetBGIcon()
	SetAttrs(false)
	if #attrs>0 then
		for k,v in ipairs(attrs) do
			CSAPI.RemoveGO(v.gameObject);
		end
	end
	attrs={};
	canDrag=true;
end

-- _elseData 根据key来划分数据  elseData:{key,isSelect,ShowHot,showTips,isPlus:置空时是否显示加号,sr:当启用dragcalllua时用来解决sr拖拽方法被覆盖的问题}
function Refresh(_cardData, _elseData)
	cardData = _cardData
	elseData = _elseData
	ActiveClick(true)
	if(cardData and cardData.data ~= nil) then	
		CSAPI.SetGOActive(Image, true)
		SetIcon(cardData:GetSmallImg())
        SetLv(cardData:GetLv())
		SetName(cardData:GetName())
		SetBGIcon(cardData:GetQuality())
		SetGridIcon(cardData:GetCurCoordIcon());
		if elseData and elseData.showNPC then
			SetNPCPlayerInfos(cardData,true);
		else
			SetAssistPlayerInfos(cardData:GetAssistData())
		end
		local teamIndex=TeamMgr:GetAssistTeamIndex(cardData:GetID());
		canDrag=true;
		if elseData and elseData.isSelect then
			canDrag=false;
			SetTipsObj(1);
		elseif elseData and elseData.showTips then
			SetTipsObj(2);
		elseif teamIndex~=nil then
			SetTipsObj(3);
		elseif elseData and elseData.disDrag==true  then
			canDrag=false;
			SetTipsObj(4);
		else
			SetTipsObj();
		end
		SetAttrs(elseData and elseData.showAttr)
		if elseData and elseData.sr then
			CSAPI.SetScriptEnable(btnClick, "DragCallLua", true);
			if dragScript then
				dragScript:SetScrollRect(elseData.sr);
			end
		else
			CSAPI.SetScriptEnable(btnClick, "DragCallLua", false);
		end
		RoleTool.SetWeapon(cardData,objWeapon,imgWeapon,txtWeaponLv)
	else
		Clean();
	end
end

-- 生成光环加成属性
function SetAttrs(isShow)
    CSAPI.SetGOActive(topmask, isShow == true);
    if cardData and isShow then
        local curHaloInfo = cardData:GetHaloInfo();
        local attrDatas = HaloUtil.CountHaloAddtion(curHaloInfo, cardData, nil, nil, nil, nil);
        local index = 1;
        local attrs = {{txt_topAdd, txt_topAddVal}, {txt_centerAdd, txt_centerAddVal}, {txt_downAdd, txt_downAddVal}};
        for k, v in ipairs(attrDatas) do
            if v.cfg then
                CSAPI.SetText(attrs[k][1], v.cfg.sName2)
                CSAPI.SetText(attrs[k][2], "+" .. tostring(v.addtive));
            end
        end
        CSAPI.SetGOActive(down, #attrDatas >= 3);
    else
        CSAPI.SetGOActive(topmask, false);
    end
end

--设置支援玩家信息
function SetAssistPlayerInfos(assistData)
	if assistData then
		local frameId=assistData.icon_frame or 1;
		UIUtil:AddHeadByID(fBorder,0.8,frameId,assistData.icon_id,assistData.sel_card_ix);
		-- SetFIcon(assistData.icon_id)
		-- SetFBorder(assistData.icon_frame)
		SetFLv(assistData.level);
		SetFID(assistData.name);
		SetFState(assistData.is_fls==true and 1 or 2);
	else
		-- SetFIcon();
		SetFID();
		-- SetFBorder();
		SetFLv();
		SetFState();
	end
end

--设置NPC显示
function SetNPCPlayerInfos(cardData,isNpc)
	if cardData and isNpc then
		UIUtil:AddHeadByID(fBorder,0.8,1,cardData:GetModelCfg().id);
		-- SetFIcon(cardData:GetModelCfg().id)
		-- SetFLv(LanguageMgr:GetByID(26036));
		SetFLv(tostring(cardData:GetLv()));
		SetFID(LanguageMgr:GetByID(26035));
		SetFState(3);
	else
		-- SetFIcon()
		SetFLv();
		SetFID();
		SetFState();
	end
end

--设置不同类型支援卡牌的显示效果
function SetFState(_s)
	if _s==1 then --好友
		CSAPI.SetGOActive(tBG,true);
		CSAPI.SetGOActive(point,false);
		CSAPI.SetText(txt_title,LanguageMgr:GetByID(26033));
		CSAPI.SetGOActive(btn_info,true);
		CSAPI.LoadImg(tBG,"UIs/RoleLittleCard/img_09_01.png",true,nil,true);
		CSAPI.SetTextColor(txt_title,51,255,166,255);
	elseif _s==2 then--路人
		CSAPI.SetGOActive(tBG,true);
		CSAPI.SetGOActive(btn_info,true);
		CSAPI.SetGOActive(point,false);
		CSAPI.SetText(txt_title,LanguageMgr:GetByID(26034));
		CSAPI.LoadImg(tBG,"UIs/RoleLittleCard/img_09_02.png",true,nil,true);
		CSAPI.SetTextColor(txt_title,255,255,255,255);
	elseif _s==3 then --NPC
		CSAPI.SetGOActive(tBG,true);
		CSAPI.SetGOActive(btn_info,false);
		CSAPI.SetGOActive(point,true);
		CSAPI.SetText(txt_title,LanguageMgr:GetByID(26005));
		CSAPI.LoadImg(tBG,"UIs/RoleLittleCard/img_09_03.png",true,nil,true);
		CSAPI.SetTextColor(txt_title,134,234,233,255);
	else
		CSAPI.SetGOActive(tBG,false);
		CSAPI.SetGOActive(btn_info,false);
		CSAPI.SetGOActive(point,true);
	end
end

function SetFID(fID)
	if fID then
		CSAPI.SetText(txt_id,fID)
	else
		CSAPI.SetText(txt_id,"")
	end
end

-- function SetFIcon(iconId)
-- 	if iconId then
-- 		local cfgModel = Cfgs.character:GetByID(iconId);
-- 		if cfgModel then
-- 			ResUtil.RoleCard:Load(fIcon,cfgModel.icon);
-- 			CSAPI.SetGOActive(fIcon,true);
-- 		else
-- 			CSAPI.SetGOActive(fIcon,false);
-- 		end
-- 	else
-- 		CSAPI.SetGOActive(fIcon,false);
-- 	end
-- end

-- function SetFBorder(borderId)
-- 	UIUtil:AddHeadFrame(fBorderObj,borderId or 1,1.4);
-- end

function SetFLv(_lv)
	if _lv then
		CSAPI.SetText(txt_fLvVal,tostring(_lv));
	else
		CSAPI.SetGOActive(fLvObj,false);
	end
end

function SetBGIcon(_quality)
	local name="btn_b_1_01";
	if _quality then
		name="btn_b_1_0"..tostring(_quality);
	end
	ResUtil.CardBorder:Load(bgIcon,name);
end

--是否激活碰撞体
function ActiveClick(active)
	CSAPI.SetGOActive(btnClick, active)
end

function OnClickInfo()
	if(GuideMgr:IsGuiding())then
        return;
    end

	--CSAPI.PlayUISound("ui_generic_click")
	
	if cardData then
		local assistData=cardData:GetAssistData()
		if assistData then
			CSAPI.OpenView("AssistPlayerInfo",assistData);
		else
			LogError("助战信息为Nil！");
		end
	end
end

function OnClick()
    --新手引导中
    if(GuideMgr:IsGuiding())then
        return;
    end

	--CSAPI.PlayUISound("ui_generic_click")
	if(cb ~= nil) then
		cb(this)
	end
end

function OnHolder()
	if canDrag~=true then
        return;
    end
	if elseData and elseData.hcb ~= nil then
		elseData.hcb(this);
	else
		EventMgr.Dispatch(EventType.Role_Card_Holder, this)
	end
end

function OnPressDown(isDrag, clickTime)
	holdDownTime = Time.unscaledTime;
	EventMgr.Dispatch(EventType.Role_Card_PressDown, this)
end

function OnPressUp(isDrag, clickTime)
	if isEvent then
		return
	end
	if not isDrag then
		if Time.unscaledTime - holdDownTime >= holdTime then
			--长按
			OnHolder()
		else
			OnClick()
		end
	end
end

--icon
function SetIcon(_iconName)
	if(_iconName) then
		CSAPI.SetGOActive(icon, true)
		ResUtil.Card:Load(icon, _iconName)
	else
		CSAPI.SetGOActive(icon, false)
	end
end

function SetGridIcon(_iconName)
	if(_iconName) then
		CSAPI.SetGOActive(gridIcon, true)
		ResUtil.RoleSkillGrid:Load(gridIcon, _iconName)
	else
		CSAPI.SetGOActive(gridIcon, false)
	end
end

function SetLv(_lv)
	if _lv then
		-- CSAPI.SetText(txtLv1, "LV.")
		CSAPI.SetText(txtLv2, _lv .. "")
		CSAPI.SetGOActive(lvObj, true)
	else
		CSAPI.SetGOActive(lvObj, false)
	end
end


function SetName(str)
	CSAPI.SetText(txtName, str)
end

function SetTipsObj(state)
	CSAPI.SetGOActive(tipsObj, state~=nil);
	if state==1 then
		CSAPI.SetText(txt_tips,LanguageMgr:GetByID(26023));
	elseif state==2 then
		CSAPI.SetText(txt_tips,LanguageMgr:GetByID(26024));
	elseif state==3 then
		CSAPI.SetText(txt_tips,LanguageMgr:GetByID(15077));
	elseif state==4 then
		CSAPI.SetText(txt_tips,LanguageMgr:GetByID(49027));
	end
end

function OnBeginDragXY(x, y, deltaX, deltaY)
	if isEvent == true then
		return;
	end
	if canDrag~=true then
		return;
	end
	pressTime=0;
    cDeltaX=deltaX;
    cDeltaY=deltaY;
	local stateIndex = RoleTool.GetStateStr(cardData)
	if stateIndex == 1 then --战斗中
		isEvent = false;
		Tips.ShowTips(LanguageMgr:GetTips(14000));
		return
	-- elseif(math.abs(deltaX) >= math.abs(deltaY) and math.abs(deltaX) > 5) and((elseData and elseData.showTips ~= true) or(elseData == nil)) then --判断第一次调用时x值差距较大还是y值差距较大，x值差距大视为向左右滑动&如果显示同角色编成则无法拖拽
	-- 	isEvent = true;
	-- 	EventMgr.Dispatch(EventType.Team_Join_DragBegin, {card = cardData, x = x, y = y,isAssist=true});
	-- 	if elseData and elseData.sr and dragScript then
	-- 		dragScript:SetScrollRect(nil);
	-- 	end
	-- elseif(math.abs(deltaX) < math.abs(deltaY)) then
	-- 	isEvent = true;
	end
end

--左右移动为上阵，上下移动为滑动
function OnDragXY(x, y, deltaX, deltaY)
	if canDrag~=true then
		return;
	end
	cDeltaX=cDeltaX+deltaX;
    cDeltaY=cDeltaY+deltaY;
    pressTime=pressTime+Time.deltaTime;
	if isDrag==true and isEvent == true then
		EventMgr.Dispatch(EventType.Team_Join_Drag, {card = cardData, x = x, y = y});
	elseif isEvent~=true and isDrag~=true and pressTime>=0.0001 then
        -- LogError(cDeltaX.."\t"..cDeltaY);
        if ((math.abs(cDeltaX) >= math.abs(cDeltaY)) or (math.abs(cDeltaX-cDeltaY)<=10)) and (math.abs(cDeltaX)>=10 or math.abs(cDeltaY)>=10) then -- 判断第一次调用时x值差距较大还是y值差距较大，x值差距大视为向左右滑动&如果显示同角色编成则无法拖拽
            isDrag = true;
            -- isEvent=true;
            EventMgr.Dispatch(EventType.TeamView_DragMask_Change, true)
            EventMgr.Dispatch(EventType.Team_Join_DragBegin, {
                card = cardData,
                x = x,
                y = y
            });
            if elseData and elseData.sr and dragScript then
                dragScript:SetScrollRect(nil);
            end
        -- elseif (math.abs(cDeltaX) < math.abs(cDeltaY)) then
        --     isEvent = true;
        end
    -- else
    --     isEvent=true;
    end
    isEvent=true;
end

function OnEndDragXY(x, y, deltaX, deltaY)
	if canDrag~=true then
		return;
	end
	EventMgr.Dispatch(EventType.TeamView_DragMask_Change, false)
	if isEvent == true then
		EventMgr.Dispatch(EventType.Team_Join_DragEnd, {card = cardData, x = x, y = y});
		if elseData and elseData.sr and dragScript then
			dragScript:SetScrollRect(elseData.sr);
		end
	end
	isEvent = false;
	isDrag=false;
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
node=nil;
bgIcon=nil;
icon=nil;
gridIcon=nil;
txt_noneAttr=nil;
attrObj=nil;
attrNode=nil;
btnClick=nil;
view=nil;
end
----#End#----