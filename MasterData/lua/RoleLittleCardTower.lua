--编队卡（塔）
local colors = {"FFFFFF", "00ffbf", "26dbff", "8080ff", "FFC146"}
local stateColors = {"FF265C", "307be9", "3cc7f5", "cc50ff", "f07b09", "11e70b", "FFFFFF"}
local holdTime = 1.5;
local holdDownTime = 0;
-- 用于判定拖拽是上阵还是滑动列表,编队用
local dragScript = nil
local canClick = true
local attrs = {}; -- 光环属性子物体
local isEvent=false;
local isDrag=false;
local eventMgr=nil;
local hpBarImg=nil;
local spBarImg=nil;
local fingerId=nil;
local Input=CS.UnityEngine.Input;
local needToCheckMove = false
function Awake()
    luaTextMove = LuaTextMove.New()
    luaTextMove:Init(txtName)

    eventMgr = ViewEvent.New();
    dragScript = ComUtil.GetCom(btnClick, "DragCallLua");
    cg_format =  ComUtil.GetCom(format, "CanvasGroup");
    hpBarImg=ComUtil.GetCom(hpBar, "Image");
    spBarImg=ComUtil.GetCom(spBar, "Image");
end

function Update()
    if (needToCheckMove) then
        luaTextMove:CheckMove(txtName)
        needToCheckMove = false
    end
end


function OnEnable()
    eventMgr:AddListener(EventType.TeamView_DragJoin_Lost, OnDragLost);
end

function OnDisable()
    eventMgr:ClearListener();
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
    SetAttrs(false)
    SetBlack(false)
    local cg_go = ComUtil.GetCom(gameObject, "CanvasGroup")
    if (cg_go~=nil) then
        cg_go.alpha = 1
    end
    fingerId=nil;
    isEvent=false;
    isDrag=false;
    cb=nil;
    canClick = true
    holdTime = 1.5;
    holdDownTime = 0;
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
    SetState()
    SetFormation()
    SetSelect()
    SetLock()
    -- SetColor(1, 1)
    SetTime()
    SetTipsObj()
    SetNPCObj();
    SetTag();
    SetGridIcon();
    SetBGIcon()
    SetAttrs(false);
    SetBlack(false)
    SetCardInfos();
    -- if #attrs>0 then
    -- 	for k,v in ipairs(attrs) do
    -- 		CSAPI.RemoveGO(v.gameObject);
    -- 	end
    -- end
    -- attrs={};
end

-- _elseData 根据key来划分数据  elseData:{key,isSelect,showAttr,showTips,isPlus:置空时是否显示加号,sr:当启用dragcalllua时用来解决sr拖拽方法被覆盖的问题}
function Refresh(_cardData, _elseData)
    cardData = _cardData
    elseData = _elseData
    -- 能否点击，不影响拖拽
    if (elseData and elseData.canClick ~= nil) then
        canClick = elseData.canClick
    else
        canClick = true
    end
    ActiveClick(true)
    if (cardData and cardData.data ~= nil) then
        CSAPI.SetGOActive(Image, true)
        local cardInfo=FormationUtil.GetTowerCardInfo(cardData:GetID(),nil,TeamMgr.currentIndex);
        local currHp,currSp=1,0;
        if cardInfo then
            currHp=cardInfo.tower_hp/100;
            currSp=cardInfo.tower_sp/100;
        end
        SetCardInfos(currHp,currSp);
        local state=nil;
        if elseData and elseData.isSelect then
			state=1;
		elseif elseData and elseData.showTips then
			state=2;
		elseif elseData and elseData.disDrag==true  then
			state=4;
            canClick=false;
		elseif teamIndex~=nil then
			state=3;
		end
        if elseData and elseData.key == "TeamEdit" then
            RefreshByTeamEdit()
        elseif elseData and elseData.key == "TeamFormation" then
            RefreshByFormation(state)
        else
            SetIcon(cardData:GetSmallImg())
            SetTag(cardData:GetData().tag)
            local gIconName=nil;
            if (elseData and elseData.key == "Coll") then
                local cur, max = cardData:GetHot(), cardData:GetCurDataByKey("hot")
                cur = cur <= 10 and StringUtil:SetByColor(cur, "FF381E") or cur
                SetHot(cur, max)
            elseif elseData and elseData.key=="AssistPlayerInfo" then
                gIconName=cardData:GetCurCoordIcon();
                SetLv(cardData:GetLv())
            else
                SetLv(cardData:GetLv())
            end
            CSAPI.SetGOActive(pro, false);
            SetName(cardData:GetName())
            local _index = RoleTool.GetStateStr(cardData)
            SetState(_index)
            -- SetFormation(cardData:GetID())
            SetSelect(elseData and elseData.isSelect)
            SetLock(cardData:IsLock())
            -- SetColor(cardData:GetQuality(), _index)
            SetBGIcon(cardData:GetQuality())
            SetTime()
            SetGridIcon(gIconName);
            SetTipsObj(state);
            SetNPCObj(elseData and elseData.showNPC);
            SetAttrs(false);
            SetPro()
            SetBlack(elseData and elseData.isBlack)
            RoleTool.SetWeapon(cardData,objWeapon,imgWeapon,txtWeaponLv)
        end
        if elseData and elseData.sr then
            CSAPI.SetScriptEnable(btnClick, "DragCallLua", true);
            if dragScript then
                dragScript:SetScrollRect(elseData.sr);
            end
        else
            CSAPI.SetScriptEnable(btnClick, "DragCallLua", false);
        end
    else
        Clean();
        local imgName="btn_3_04";
        if elseData and elseData.key=="AssistPlayerInfo" then
            imgName="img_04_01";
        else
            local isPlus=elseData and elseData.isPlus or false;
            imgName=isPlus and "btn_3_04" or "btn_1_061";
        end
        SetEmpty(imgName)
    end
end

function SetCardInfos(hp,sp)
    if hp and sp then
        CSAPI.SetGOActive(infoObj,true);
        hpBarImg.fillAmount=hp;
        spBarImg.fillAmount=sp;
    else
        CSAPI.SetGOActive(infoObj,false);
    end
end

function SetEmpty(imgName)
    imgName=imgName or "btn_1_061";
    CSAPI.SetGOActive(icon, true);
    -- CSAPI.LoadImg(icon, imgName, true, nil, true);
    ResUtil.CardBorder:Load(icon, imgName);
end

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

function RefreshByFormation(state)
    SetIcon(cardData:GetSmallImg())
    SetTag(cardData:GetData().tag)
    SetLv(cardData:GetLv())
    SetPro();
    SetBGIcon(cardData:GetQuality())
    SetName(cardData:GetName())
    local _index = RoleTool.GetStateStr(cardData)
    if _index == 1 then
        -- SetColor(cardData:GetQuality(), _index)
        SetState(_index)
    else
        -- SetColor(cardData:GetQuality())
        SetState()
    end
    -- if elseData and elseData.isFormation then
    --     SetFormation(cardData:GetID())
    -- else
    --     SetFormation();
    -- end
    SetTipsObj(state)
    SetAttrs(elseData and elseData.showAttr)
    SetGridIcon(cardData:GetCurCoordIcon());
    SetSelect(elseData and elseData.isSelect)
    SetLock()
    SetTime()
    SetNPCObj(elseData and elseData.showNPC);
    SetIcon(cardData:GetSmallImg())
    SetName(cardData:GetName())
end

function RefreshByTeamEdit()
    SetIcon(cardData:GetSmallImg())
    SetGridIcon();
    SetLv(cardData:GetLv())
    SetPro();
    SetName(cardData:GetName())
    -- SetColor(cardData:GetQuality())
    SetBGIcon(cardData:GetQuality())
    -- SetFormation()
    SetSelect()
    SetLock()
    SetTime()
    SetTag()
    SetAttrs(elseData and elseData.showAttr)
    if elseData and elseData.showState then
        local _index = RoleTool.GetStateStr(cardData)
        SetState(_index)
    else
        SetState()
    end
    ActiveClick(false);
end

function SetBGIcon(_quality)
    local name = "btn_b_1_01";
    if _quality then
        name = "btn_b_1_0" .. tostring(_quality);
        name2 = "btn_1_0" .. _quality
        ResUtil.CardBorder:Load(color, name2);
        CSAPI.SetGOActive(color,true);
    else
        CSAPI.SetGOActive(color,false);
    end
    ResUtil.CardBorder:Load(bgIcon, name);
end

-- 筛选值条
function SetPro()
    if (elseData and  elseData.sortId) then
        local sortData = SortMgr:GetData(elseData.sortId)
        local str, iconName = "", nil
        if (sortData.SortId == 1003) then
            -- 好感
            local cur = cardData:GetFavorability()
            local max = CRoleMgr:GetCRoleMaxLv()
            str = string.format("%s/%s", cur, max)
            iconName = "sort_03"
        elseif (sortData.SortId == 1005) then
            -- 性能
            str = cardData:GetProperty() .. ""
            iconName = "sort_05"
        elseif (sortData.SortId == 1006) then
            -- 属性
            local proCfg = Cfgs.CfgCardPropertyEnum:GetByID(sortData.RolePro)
            local num  = cardData:GetCurDataByKey(proCfg.sFieldName) .. ""
            str= RoleTool.GetStatusValueStr(proCfg.sFieldName, num)
            iconName = proCfg.icon2
        end
        -- txt
        CSAPI.SetText(txtPro, str)
        -- icon 
        if (iconName) then
            ResUtil.AttributeIcon:Load(pro,tostring(iconName))
            CSAPI.SetGOActive(pro, true)
            CSAPI.SetGOActive(lvObj, false)
        else
            CSAPI.SetGOActive(pro, false)
            CSAPI.SetGOActive(lvObj, true)
        end
    else
        CSAPI.SetGOActive(pro, false)
        CSAPI.SetGOActive(lvObj, true)
    end
end

-- 是否激活碰撞体
function ActiveClick(active)
    CSAPI.SetGOActive(btnClick, active)
end

function OnClick()
    -- --新手引导中
    -- if(GuideMgr:IsGuiding()) then
    -- 	return;
    -- end
    -- 新手引导中
    if (not canClick) then
        return
    end

    --CSAPI.PlayUISound("ui_generic_click")
    if (cb ~= nil) then
        cb(this)
    end
end

function OnHolder()
    if elseData~=nil and elseData.disDrag==true then
        return;
    end
    if elseData~=nil and elseData.hcb ~= nil then
        elseData.hcb(this);
    else
        EventMgr.Dispatch(EventType.Role_Card_Holder, this)
    end
end

function OnPressDown(isDragging, clickTime)
    holdDownTime = Time.unscaledTime;
    EventMgr.Dispatch(EventType.Role_Card_PressDown, this)
end

function OnPressUp(isDragging, clickTime)
    if isEvent then
        return
    end
    if not isDragging then
        if Time.unscaledTime - holdDownTime >= holdTime then
            -- 长按
            OnHolder()
        else
            OnClick()
        end
    end
end

-- icon
function SetIcon(_iconName)
    if (_iconName) then
        CSAPI.SetGOActive(icon, true)
        ResUtil.Card:Load(icon, _iconName)
    else
        CSAPI.SetGOActive(icon, false)
    end
end

function SetGridIcon(_iconName)
    if (_iconName) then
        CSAPI.SetGOActive(gridIcon, true)
        ResUtil.RoleSkillGrid:Load(gridIcon, _iconName)
    else
        CSAPI.SetGOActive(gridIcon, false)
    end
end

function SetLv(_lv)
    if _lv then
        local lvStr = LanguageMgr:GetByID(1033) or "LV."
        CSAPI.SetText(txtLv1, lvStr)
        CSAPI.SetText(txtLv2, _lv .. "")
        CSAPI.SetGOActive(lvObj, true)
    else
        CSAPI.SetGOActive(lvObj, false)
    end
end

function SetHot(_hot, _totalHot)
    if _hot and _totalHot then
        CSAPI.SetText(txtLv1, "AP.")
        CSAPI.SetText(txtLv2, string.format("%s/%s", _hot, _totalHot))
        CSAPI.SetGOActive(lvObj, true)
    else
        CSAPI.SetGOActive(lvObj, false)
    end
end

function SetName(str)
    needToCheckMove = false
    CSAPI.SetText(txtName, str)
    needToCheckMove = true
end

function SetState(_index)
    if _index then
        CSAPI.SetGOActive(imgState, true)
        local str = LanguageMgr:GetByID(2999 + _index)
        CSAPI.SetText(txtState, "· " .. str)
    else
        CSAPI.SetGOActive(imgState, false)
    end
end

-- 编队使用的设置状态，用于显示卡牌是NPC还是强制出战还是支援
function SetState2(str)
    if str ~= nil and str ~= "" then
        CSAPI.SetGOActive(imgState, true)
        CSAPI.SetText(txtState, "· " .. str)
    else
        CSAPI.SetGOActive(imgState, false)
    end
end

-- 第几编队
function SetFormation(_cid)
    local cid = _cid
    local index = TeamMgr:GetCardTeamIndex(cid)
    if index ~= -1 then
        CSAPI.SetGOActive(format, true)
        index = index < 10 and "0" .. index or index .. ""
        CSAPI.SetText(txtFormat1, index)
    else
        CSAPI.SetGOActive(format, false)
    end
end
function SetSelect(b)
    CSAPI.SetGOActive(select, b)
end

function SetLock(b)
    CSAPI.SetGOActive(lockImg, b)
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

function SetNPCObj(isShow)
    CSAPI.SetGOActive(npcObj, isShow == true);
end

function SetTime()
    if (elseData and (elseData.key == "TeamEdit" or elseData.key == "Coll") and elseData.isSelect) then
        local timer = GCardCalculator:CalCardCoolTime(cardData:GetCurDataByKey("hot"), cardData:GetHot(),
            cardData:GetLv(), cardData:GetBreakLevel(), cardData:GetQuality())
        CSAPI.SetText(txtTime, TimeUtil:GetTimeStr(timer))
        CSAPI.SetGOActive(time, true)
    else
        CSAPI.SetGOActive(time, false)
    end
end

-- tag
function SetTag(tag)
    if (tag and tag ~= 0) then
        CSAPI.SetGOActive(imgTagBg, true)
        ResUtil.AttributeIcon:Load(imgTag,tostring(tag))
    else
        CSAPI.SetGOActive(imgTagBg, false)
    end
end

---------------------------仅传入模型表id---------------------------------------
-- 对手头像
function RefreshByModelID(modelID)
    local cfg = Cfgs.character:GetByID(modelID)
    if (cfg) then
        ActiveClick(false)

        SetIcon(cfg.card_icon)
        SetLv(0)
    end
end

local pressTime=0;
local cDeltaX=0;
local cDeltaY=0;
function OnBeginDragXY(x, y, deltaX, deltaY)
    if isEvent == true or (TeamMgr:GetDragFingerID()~=nil and fingerId==nil)  then
        do return end;
     end
     if elseData and elseData.disDrag==true then
         do return end;
     end
     if Input.touchCount>0 and TeamMgr:GetDragFingerID()==nil then
         fingerId=Input:GetTouch(0).fingerId;
         TeamMgr:SetDragFingerID(fingerId)
        --  for i=1,Input.touchCount do
        --       LogError(Input:GetTouch(i-1).fingerId);
        --   end
      end
    pressTime=0;
    cDeltaX=deltaX;
    cDeltaY=deltaY;
    local stateIndex = RoleTool.GetStateStr(cardData)
    if stateIndex == 1 then -- 战斗中
        isEvent = false;
        Tips.ShowTips(LanguageMgr:GetTips(14000));
        return
    -- else
    --     isEvent=true;
    -- elseif (math.abs(deltaX) > math.abs(deltaY) and math.abs(deltaX) > 5) and
    --     ((elseData and elseData.showTips ~= true) or (elseData == nil)) then -- 判断第一次调用时x值差距较大还是y值差距较大，x值差距大视为向左右滑动&如果显示同角色编成则无法拖拽
    --     isEvent = true;
    --     EventMgr.Dispatch(EventType.Team_Join_DragBegin, {
    --         card = cardData,
    --         x = x,
    --         y = y
    --     });
    --     if elseData and elseData.sr and dragScript then
    --         dragScript:SetScrollRect(nil);
    --     end
    -- elseif (math.abs(deltaX) < math.abs(deltaY)) then
    --     isEvent = true;
    end
end

-- 左右移动为上阵，上下移动为滑动
function OnDragXY(x, y, deltaX, deltaY)
    -- Log("OnDrag....")
    if  (TeamMgr:GetDragFingerID()~=nil and fingerId==nil)  then
        do return end;
    end
    if elseData and elseData.disDrag==true then
		do return end;
	end
    cDeltaX=cDeltaX+deltaX;
    cDeltaY=cDeltaY+deltaY;
    pressTime=pressTime+Time.deltaTime;
    if isDrag==true and isEvent == true then
        EventMgr.Dispatch(EventType.Team_Join_Drag, {
            card = cardData,
            x = x,
            y = y
        });
    elseif isEvent~=true and isDrag~=true and pressTime>=0.0001 then
        -- LogError(cDeltaX.."\t"..cDeltaY);
        if ((math.abs(cDeltaX) >= math.abs(cDeltaY)) or (math.abs(cDeltaX-cDeltaY)<=10)) and (math.abs(cDeltaX)>=10 or math.abs(cDeltaY)>=10)  and
        ((elseData and elseData.showTips ~= true) or (elseData == nil)) then -- 判断第一次调用时x值差距较大还是y值差距较大，x值差距大视为向左右滑动&如果显示同角色编成则无法拖拽
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
    if  (TeamMgr:GetDragFingerID()~=nil and fingerId==nil)  then
        do return end;
    end
    if elseData and elseData.disDrag==true then
		return;
	end
    TeamMgr:SetDragFingerID(nil);
    fingerId=nil;
    EventMgr.Dispatch(EventType.TeamView_DragMask_Change, false)
    -- Log("OnEndDrag....")
    -- Log("isEvent:"..tostring(isEvent))
    if isEvent == true then
        EventMgr.Dispatch(EventType.Team_Join_DragEnd, {
            card = cardData,
            x = x,
            y = y
        });
        if elseData and elseData.sr and dragScript then
            dragScript:SetScrollRect(elseData.sr);
        end
    end
    isEvent = false;
    isDrag=false;
end

--当拖拽事件丢失的时候触发拖拽结束
function OnDragLost()
    if isEvent or isDrag then
        -- LogError("OnDragLost----------------")
        OnEndDragXY(100000,100000,100000,100000);
    end
end

-- --能否触发点击回调
-- function SetCanClick(b)
-- 	canClick = b
-- end

function SetBlack(b)
    CSAPI.SetGOActive(black,b)
    cg_format.alpha = b and 0.5 or 1
end

function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    node = nil;
    bgIcon = nil;
    icon = nil;
    gridIcon = nil;
    imgTagBg = nil;
    imgTag = nil;
    Image = nil;
    imgState = nil;
    txtState = nil;
    lock = nil;
    lockImg = nil;
    imgLock = nil;
    unlockAnim = nil;
    lockAnim = nil;
    format = nil;
    txtFormat1 = nil;
    txtFormat2 = nil;
    lvObj = nil;
    txtLv1 = nil;
    txtLv2 = nil;
    txtName = nil;
    time = nil;
    txtTime = nil;
    select = nil;
    pro = nil;
    txtPro = nil;
    npcObj = nil;
    tipsObj = nil;
    btnClick = nil;
    txt_noneAttr = nil;
    topmask = nil;
    attrNode = nil;
    view = nil;
    fingerId=nil;
end
----#End#----
