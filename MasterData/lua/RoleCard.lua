local holdTime = 1.5;
local holdDownTime = 0;
local colors = {"FFFFFF", "00ffbf", "26dbff", "8080ff", "FFC146"}
-- {"战斗中", "远征中", "冷却中", "训练中", "军演中", "演习中", "助战中"}
local stateColors = {"FF265C", "307be9", "3cc7f5", "cc50ff", "f07b09", "11e70b", "FFFFFF"}
-- local colorOutlines = {"LineGlow_Blue", "LineGlow_Blue", "LineGlow_Blue", "LineGlow_Purple", "LineGlow_Gold","LineGlow_Color"}

local needToCheckMove = false

function OnRecycle()
    if goRect == nil then
        goRect = ComUtil.GetCom(gameObject, "RectTransform")
    end
    goRect.pivot = UnityEngine.Vector2(0.5, 0.5)
    CSAPI.SetGOActive(gameObject, true)
    CSAPI.SetGOAlpha(gameObject, 1)
end

function Awake()
    -- tickAnim = ComUtil.GetCom(tick, "BarBase")
    colorBar = ComUtil.GetCom(colorSlider, "SliderValue")
    --
    luaTextMove = LuaTextMove.New()
    luaTextMove:Init(txtName2)
end

function Update()
    if (needToCheckMove) then
        luaTextMove:CheckMove(txtName2)
        needToCheckMove = false
    end
end

function SetIndex(_index)
    index = _index
end
-- 初始状态应该显示，后面有需要的直接在自我方法你激活
function Clean()
    -- CSAPI.SetGOActive(txtLv, true)
    -- CSAPI.SetGOActive(imgTagBG, true)
    -- CSAPI.SetGOActive(txtMaster, false);
    CSAPI.SetText(txtMaster, "")
    -- CSAPI.SetGOActive(hot, false)
    CSAPI.SetGOActive(posGrid, false)
    CSAPI.SetGOActive(new, false)
    CSAPI.SetGOActive(red, false)
    -- CSAPI.SetText(txtCoolTime, "")
    -- SetTipsObj(false)
    SetSelect(false)
    -- SetChooseImg("minus_sign")
    CSAPI.SetGOActive(state, false)
    CSAPI.SetGOActive(proObj, false)
end

-- _elseData 根据key来划分数据
function Refresh(_cardData, _elseData)
    Clean() -- 正常状态应该显示或隐藏的
    ActiveClick(true) -- 默认开启（可以通过回调来处理点击事件）

    cardData = _cardData
    elseData = _elseData or {}
    local isFormate = false
    if (cardData) then
        SetName(cardData:GetName())
        SetFormation(cardData:GetID())
        SetBgIcon(cardData:GetQuality())
        SetIcon(cardData:Card_head())
        local _index = RoleTool.GetStateStr(cardData)
        SetState(_index)
        -- SetLock(cardData:IsLock())
        -- SetHot(cardData:GetHot(), cardData:GetCurDataByKey("hot"))
        SetLv(cardData:GetLv())
        SetTag(cardData:GetData().tag)
        -- SetGrid(cardData:GetCfg().gridsIcon)
        SetColor(cardData:GetQuality(), _index)
        SetColorBar()
        SetPro()
        SetNew()
        -- 小队
        SetCamp()
        -- break 
        local breakLv = cardData:GetBreakLevel()
        CSAPI.SetGOActive(imgBreakBG, breakLv > 1)
        if (breakLv > 1) then
            ResUtil.RoleCard_BG:Load(imgBreak, "img_1_0" .. (breakLv - 1))
        end
        -- star 
        ResUtil.RoleCard_BG:Load(imgStar, "img_01_0" .. cardData:GetQuality())
        -- red 
        if (elseData.noCheckRed == nil) then
            local isRed = cardData:RoleCardRed()
            UIUtil:SetRedPoint(red, isRed)
            CSAPI.SetGOActive(red, isRed)
        end
        --  
        SetJieJin()
        SetLimitSkin()
        RoleTool.SetWeapon(cardData,objWeapon,imgWeapon,txtWeaponLv)
    end
    SetSelect(elseData.isSelect)
    -- 天赋升级，分解，支援卡,批量锁定  
    -- if(elseData.key == "TalentSelect" or elseData.key == "IsInSell" or elseData.key == "IsInLock") then
    -- SetSelect(elseData.isSelect)
    if (elseData.key == "TeamEdit") then
        CSAPI.SetGOActive(format, false)
        CSAPI.SetGOActive(state, false)
        ActiveClick(false)
    elseif (elseData.key == "Formation") then -- 编队选择
        OnFormation()
    elseif (elseData.key == "Coll") then -- 热值
        -- SetSelect(elseData.isSelect)
        -- CSAPI.SetGOActive(txtLv, false)
        -- CSAPI.SetGOActive(imgTagBG, false)
        -- CSAPI.SetGOActive(hot, true)
        -- SetHot(cardData:GetHot(), cardData:GetCurDataByKey("hot"))
        -- SetCoolTime()
    elseif (elseData.key == "Expedition") then
        -- SetSelect(elseData.isSelect)
        SetTipsObj(elseData.isEqual)
    elseif (elseData.key == "Support") then -- 热值
        -- SetSelect(elseData.isSelect)
        SetTipsObj(elseData.isEqual)
    end

    --[[
    -- 技能完成红点
    if (elseData and elseData.checkRed) then
        CSAPI.SetGOActive(red, true)
        local isRed = RoleSkillMgr:CheckSuccessByCid(cardData:GetID())
        if (isRed) then
            if (redGO == nil) then
                redGO = UIUtil:SetRedPoint2("Common/Red2", red, true)
            end
            CSAPI.SetGOActive(redGO, true)
        else
            if (redGO) then
                CSAPI.SetGOActive(redGO, false)
            end
        end
    else
        if (redGO) then
            CSAPI.SetGOActive(redGO, false)
        end
    end
]]
end

function SetCamp()
    local _cfg = Cfgs.CfgTeamEnum:GetByID(cardData:GetCamp())
    local imgName = _cfg.details1 or "01_montagnes"
    ResUtil.RoleClamp:Load(imgCamp, imgName .. "_3", true)
end

function OnFormation()
    -- SetChooseImg("tick")
    SetSelect(elseData.isSelect)
    SetTipsObj(elseData.isEqual);
    local assistData = cardData:GetData().assist;
    if assistData ~= nil then
        -- CSAPI.SetGOActive(txtMaster, true);
        CSAPI.SetText(txtMaster, assistData.name);
    else
        -- CSAPI.SetGOActive(txtMaster, false);
        CSAPI.SetText(txtMaster, "")
    end
    CSAPI.SetGOActive(starP, false)

    SetPosGrid(cardData:GetCfg().gridsIcon)
    if not elseData.isNormal then
        -- CSAPI.SetGOActive(txtLv, false)
        -- CSAPI.SetGOActive(imgTagBG, false)
        -- CSAPI.SetGOActive(hot, true)
        CSAPI.SetGOActive(posGrid, true)
        -- SetHot(cardData:GetHot(), cardData:GetCurDataByKey("hot"))
        -- CSAPI.SetGOActive(ImgChoose, false)
        SetSelect(false)
    else
        CSAPI.SetGOActive(posGrid, false)
        -- CSAPI.SetGOActive(ImgChoose, true)
        SetSelect(true)
    end
end

function SetSelect(b)
    CSAPI.SetGOActive(select, b)
end

function SetSelectAnim(b)
    CSAPI.SetGOActive(select, b)
    -- if(b) then
    -- 	tickAnim:SetFullProgress(0, 1)
    -- end
end

-- 是否激活碰撞体
function ActiveClick(active)
    CSAPI.SetGOActive(btnClick, active)
end

function OnPressDown(isDrag, clickTime)
    holdDownTime = Time.unscaledTime;
end

function OnPressUp(isDrag, clickTime)
    if not isDrag then
        if Time.unscaledTime - holdDownTime >= holdTime then
            -- 长按
            OnHolder()
        else
            OnClick()
        end
    end
end
function OnClick()
    -- CSAPI.PlayUISound("ui_generic_click")
    if (elseData.cb ~= nil and
        (elseData.key == "Expedition" or elseData.key == "TalentSelect" or elseData.key == "Coll" or elseData.key ==
            "Support")) then
        elseData.cb(this)
    else
        EventMgr.Dispatch(EventType.Role_Card_Click, this)
    end
end

function OnHolder()
    if elseData.hcb ~= nil then
        elseData.hcb(this);
    else
        EventMgr.Dispatch(EventType.Role_Card_Holder, this)
    end
end

-----------------------------------------///set
-- icon
function SetIcon(_iconName)
    if (_iconName) then
        ResUtil.CardIcon:Load(icon, _iconName)

    end
end

function SetBgIcon(_quality)
    local colorName = "btn_1_0" .. _quality
    ResUtil.RoleCard_BG:Load(iconBg, colorName)

    -- effect
    CSAPI.SetGOActive(Yvaine_RoleList_Color, _quality >= 6)
end

-- 状态
function SetState(_index)
    -- 用不到了，统一隐藏
    -- if _index then
    --     CSAPI.SetGOActive(state, true)
    --     LanguageMgr:SetText(txtState, 2999 + _index)
    -- else
    --     CSAPI.SetGOActive(state, false)
    -- end
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

-- 同角色编成中
function SetTipsObj(isShow)
    local str = isShow and LanguageMgr:GetByID(1088) or ""
    CSAPI.SetText(txt_tips, str)
    -- CSAPI.SetGOActive(tipsObj, isShow);
end

-- 等级
function SetLv(_lv)
    _lv = _lv or 1
    CSAPI.SetText(txtLv3, _lv .. "")
    local b = _lv >= cardData:GetMaxLv()
    CSAPI.SetGOActive(txtLv1, not b)
    CSAPI.SetGOActive(txtLv2, b)
end

function SetName(str)
    needToCheckMove = false
    CSAPI.SetText(txtName2, str)
    needToCheckMove = true -- 字符串的设置是异步的，所以要隔1帧再计算字符串长度和移动
end

-- 第几编队
function SetFormation(_cid)
    local cid = _cid
    local index = TeamMgr:GetCardTeamIndex(cid)
    if index ~= -1 then
        CSAPI.SetGOActive(format, true)
        index = index < 10 and "0" .. index or index .. ""
        CSAPI.SetText(txtFormat1, index)
        -- CSAPI.SetText(txtFormat2, StringConstant.role_45)
    else
        CSAPI.SetGOActive(format, false)
    end
end

-- 设置占位格子
function SetPosGrid(iconName)
    if (iconName) then
        ResUtil.RoleSkillGrid:Load(gridImg, iconName)
    end
end

-- 颜色
function SetColor(_quality, _index)
    local str0 = stateColors[_index]
    CSAPI.SetImgColorByCode(imgState, str0)
    CSAPI.SetImgColorByCode(stateImg1, str0)

    local str = colors[_quality]
    -- CSAPI.SetImgColorByCode(color, str)
    CSAPI.SetTextColorByCode(txtLv1, str)
    CSAPI.SetTextColorByCode(txtLv2, str)

    local colorName = "img_x_" .. _quality
    ResUtil.RoleCard_BG:Load(color, colorName)
end

function SetNew()
    if(elseData and elseData.noCheckNew) then
        CSAPI.SetGOActive(new, false)
        return
    end
    if (new ~= nil) then
        CSAPI.SetGOActive(new, cardData:IsNew())
    end
end

function SetColorBar(delay)
    if (elseData.isAnimEnd == false and delay) then
        -- colorBar.delayFillTime = delay
        -- colorBar.auto = false 
        -- colorBar:SetCur(0)
        -- colorBar:SetFullProgress(0, 1)
        colorBar:SetFormToValue(0, 1, 0.5, delay)
    elseif (elseData.isAnimEnd) then
        -- colorBar:SetProgress(1, true)
        colorBar:SetPlay(false)
        colorBar:SetValue(1)
        -- SetColorOutline()
    end
end

-- 筛选值条
function SetPro()
    local str = ""
    if (elseData and elseData.listType and elseData.listType == RoleListType.Normal) then
        local sortData = SortMgr:GetData(1)
        CSAPI.SetGOActive(love, sortData.SortId == 1003)
        CSAPI.SetGOActive(pp, sortData.SortId == 1005)
        CSAPI.SetGOActive(att, sortData.SortId == 1006)

        if (sortData.SortId == 1003) then
            -- 好感
            str = cardData:GetFavorability()
            CSAPI.SetText(txtLove, str .. "")
        elseif (sortData.SortId == 1005) then
            -- 性能
            str = cardData:GetProperty() .. ""
            CSAPI.SetText(txtPP2, str .. "")
        elseif (sortData.SortId == 1006) then
            -- 属性
            local proCfg = Cfgs.CfgCardPropertyEnum:GetByID(sortData.RolePro)
            local num = cardData:GetCurDataByKey(proCfg.sFieldName) .. ""
            str = RoleTool.GetStatusValueStr(proCfg.sFieldName, num)
            CSAPI.SetText(txtAtt, str .. "")
            ResUtil.AttributeIcon:Load(imgAtt,tostring(proCfg.icon2))
        end
    end
    CSAPI.SetGOActive(proObj, not StringUtil:IsEmpty(str))
    local y = proObj.activeSelf and -5 or -52
    CSAPI.SetAnchor(objWeapon,-30,y)
end

function SetJieJin()
    if (elseData and elseData.isJieJin) then
        CSAPI.SetGOActive(format, false)
        CSAPI.SetGOActive(state, false)
        ActiveClick(false)
        CSAPI.SetGOActive(new, false)
    end
end

function SetLimitSkin()
    local isLimitSkin = cardData:CheckLimitSkin()
    UIUtil:SetRedPoint2("Common/Red4", node, isLimitSkin, -74, -14, 0)
end
