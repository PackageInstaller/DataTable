-- local targetPos = {{81.6, 12.2}, {-80.8, 12.2}, {-243.3, 12.2}, {-405.8, 12.2}}
local curShowTime = 0
local oldData
local addExp = 0
local isPress = false
local stepTime = 1
local timer = 0
local curStep = 0
local isBack = true
local cardData

local waitTime = nil -- 升级动画结束延迟100毫秒再重置界面，以便衔接第二次的升级
local svUtil = nil;
local curIndex = 1
local isUp = false
function Awake()
    -- 经验
    bar = Bar.New()
    bar:Init(expBar, CardLevel, "exp", ELv, EExp, stepTime, EEndCB, false)
    slider_Exp = ComUtil.GetCom(expBar, "Slider")

    EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "RoleUp"); -- 引导用

    -- for i = 1, 4 do
    --     this["OnClickBtn" .. i] = function()
    --         local lv = i + 1
    --         local breakLv = cardData:GetBreakLevel()
    --         if (not isUp and breakLv < lv) then
    --             EventMgr.Dispatch(EventType.Role_Jump_Break, {i + 1, false})
    --         end
    --     end
    -- end
    layout = ComUtil.GetCom(hsv, "UISV")
    layout:Init("UIs/Role/RoleUpNum", LayoutCallBack, true)
    layout:AddOnValueChangeFunc(OnValueChange)
    svUtil = SVCenterDrag.New()

    btnL_cg = ComUtil.GetCom(btnL, "CanvasGroup")
    btnR_cg = ComUtil.GetCom(btnR, "CanvasGroup")

    sr_sv = ComUtil.GetCom(sv, "ScrollRect")
end

function Update()
    if (bar ~= nil) then
        bar:Update()
    end

    if (isPress) then
        if (Time.time > timer and isBack) then
            curStep = (curStep - 0.2) < 0.1 and 0.1 or (curStep - 0.2)
            timer = Time.time + curStep
            curShowTime = (curShowTime - 0.2) < 0.1 and 0.1 or (curShowTime - 0.2)
            if (bar ~= nil) then
                bar:ChangeTimer(curShowTime)
            end
            OnClickL()
        end
    end

    -- 动画结束
    if (waitTime ~= nil) then
        waitTime = waitTime - Time.deltaTime
        if (waitTime < 0) then
            waitTime = nil
            oldData = nil
            oldTotalResult = nil
            curIndex = 1
            isUp = false
            Refresh(cardData)
            LanguageMgr:ShowTips(3010) -- 升级成功
            if (upCB) then
                upCB()
            end
            upCB = nil
        end
    end
end

function OnDisable()
    isPress = false
    isBack = true
    oldData = nil
    waitTime = nil
    isUp = false
    SetAudio(false)
    --RoleAudioPlayMgr:StopSound()
end

function OnDestroy()
    RoleAudioPlayMgr:StopSound()
end

function SetOldData(_oldData)
    oldData = _oldData

    waitTime = nil
end

function SetIsUpCB(_upCB)
    upCB = _upCB
end

-- _isBack 从预览突破返回
function Refresh(_cardData, _elseData)
    _lookBreakLv = _elseData and _elseData[1] or nil -- 查看突破等级返回
    _target = _elseData and _elseData[2] or nil
    --
    InitData(_cardData)
    SetBreak()
    SetLv()
    SetStatus()
    SetBtns()
    -- SetIconAnim()
    SetSVBG()

    --初始位置
    if (not isFirst) then
        isFirst = 1
        local x = cardData:GetBreakLevel() > 5 and -321 or 0
        CSAPI.SetAnchor(content, x, 0, 0)
    end
end

function SetSVBG()
    local imgName = cardData:GetBreakLevel() > 5 and "img2_02" or "img2_01"
    ResUtil.RoleCard_BG:Load(svbg, imgName)
end

-- 返回动画
function SetIconAnim()
    if (_lookBreakLv and breakNumItems) then
        local index = _lookBreakLv - 1
        local item = breakNumItems[index]
        item.SetItemAnim(_target)
    end
    _lookBreakLv = nil
end

-- 背包更新
function RefreshGoods()
    SetBtns()
end

function InitData(_cardData)
    if (oldBreakLevel and _cardData:GetBreakLevel() > oldBreakLevel) then
        curIndex = 1
    end
    oldBreakLevel = _cardData:GetBreakLevel()

    if (cardData and cardData:GetID() ~= _cardData:GetID()) then
        -- 不同卡
        bar:Stop()
        isPress = false
        isBack = true
        oldData = nil
        waitTime = nil
        isUp = false
        SetAudio(false)
        curIndex = 1
    end

    -- 旧数据
    if (oldData) then
        oldTotalResult = oldData:GetTotalProperty()
        -- 语音播放添加20s间隔
        if (curTime == nil or curTime < TimeUtil:GetTime()) then
            curTime = TimeUtil:GetTime() + 20
            RoleAudioPlayMgr:PlayByType(cardData:GetSkinID(), RoleAudioType.upgrade)
        end
    end
    -- 新数据
    cardData = _cardData or cardData
    totalResult = cardData:GetTotalProperty()
end

function SetBreak()
    local breakLv = cardData:GetBreakLevel() - 1
    -- for k = 1, 4 do
    --     local alpha = breakLv >= k and 1 or 0.3
    --     CSAPI.SetGOAlpha(this["normal" .. k], alpha)
    --     CSAPI.SetGOActive(this["sel" .. k], breakLv == k)
    -- end
    if (not breakNumDatas) then
        breakNumDatas = {}
        local maxBreakLv = RoleTool.GetMaxBreakLv() - 1
        for k = 1, maxBreakLv do
            table.insert(breakNumDatas, k)
        end
    end
    breakNumItems = breakNumItems or {}
    ItemUtil.AddItems("Role/RoleUpBreakNum", breakNumItems, breakNumDatas, content, BreakNumItemClickCB, 1, breakLv,
        SetIconAnim)
end

function BreakNumItemClickCB(item)
    local lv = item.lv + 1
    sr_sv.enabled = false
    sr_sv.enabled = true
    local breakLv = cardData:GetBreakLevel()
    if (not isUp and breakLv < lv) then
        EventMgr.Dispatch(EventType.Role_Jump_Break, {lv, false, item.normal})
    end
end

function SetLv()
    -- 等级
    curLv, maxLv = cardData:GetLv(), cardData:GetMaxLv()
    isMax = curLv >= maxLv
    local str = ""
    if (oldData ~= nil) then
        str = oldData:GetLv()
    else
        str = curLv
    end
    CSAPI.SetText(txtLv1, str .. "")
    CSAPI.SetText(txtLv2, "/" .. maxLv)

    -- exp 
    curExp, maxExp = cardData:GetEXP(), RoleTool.GetExpByLv(cardData:GetLv())
    if (oldData ~= nil and addExp > 0) then
        bar:Show(oldData:GetLv(), oldData:GetEXP(), addExp)
        SetAudio(true)
        isPlay = true
    else
        bar:Stop()
        slider_Exp.value = isMax and 0 or curExp / maxExp
        EExp(curExp, maxExp)
        SetAudio(false)
    end
end

function SetStatus()
    statusItems = statusItems or {}
    statusDatas = {}
    for i, v in ipairs(g_RoleAttributeListT) do
        local cfg = Cfgs.CfgCardPropertyEnum:GetByID(v)
        local _data = {}
        _data.id = v
        _data.val1 = GetBaseValue(cfg.sFieldName)
        _data.val2 = GetAddValue(cfg.sFieldName)
        _data.nobg = true
        table.insert(statusDatas, _data)
    end
    ItemUtil.AddItems("AttributeNew2/AttributeItem9", statusItems, statusDatas, statusGrids)
end

-- 全部属性
function GetBaseValue(_key)
    if (oldData) then
        local num = oldTotalResult[_key]
        if (num) then
            return RoleTool.GetStatusValueStr(_key, num)
        end
    else
        local num = totalResult[_key]
        if (num) then
            return RoleTool.GetStatusValueStr(_key, num)
        end
    end
    return 0
end

-- 升级加的isUp
function GetAddValue(_key)
    if (oldData) then
        local num1 = totalResult[_key]
        local num2 = oldTotalResult[_key]
        if (num1 and num2 and num1 - num2 > 0) then
            return "+" .. RoleTool.GetStatusValueStr(_key, num1 - num2)
        end
    end
    return nil
end

function SetBtns()
    if (oldData) then
        return
    end
    CSAPI.SetGOActive(up, not isMax)
    CSAPI.SetGOActive(objMax, isMax)

    if (not isMax) then
        SetUp()
        SetMoneys()
        SetArrows()
        --[[
        num1 = maxExp == 0 and 0 or (maxExp - curExp)

        -- 经验
        -- local str1 = storeExp > 10000 and string.format("%.1f", storeExp / 1000) .. "K" or storeExp
        storeExp = RoleMgr:GetStoreExp()
        local str = storeExp < num1 and string.format("<color=#ff8790>%s</color>", num1) or (num1 .. "")
        CSAPI.SetText(txtStore, str)

        -- 金币
        local LVCfg = Cfgs.CardLevel:GetByID(curLv)
        bagCostNum = BagMgr:GetCount(LVCfg.costs[2][1])
        costNum = 0
        if (num1 > 0) then
            costNum = math.floor((num1 / LVCfg.costs[1]) * LVCfg.costs[2][2])
        end
        CSAPI.SetText(txtCost, bagCostNum >= costNum and costNum .. "" or StringUtil:SetByColor(costNum, "ff8790"))
        ResUtil.IconGoods:Load(imgCost2, LVCfg.costs[2][1] .. "_1", true)

        -- alpha 
        if (canvasGroup1 == nil) then
            canvasGroup1 = ComUtil.GetCom(btnUp, "CanvasGroup")
        end
        canvasGroup1.alpha = (storeExp < num1 or bagCostNum < costNum) and 0.3 or 1
        ]]
    else
        isPress = false
    end
end

function SetMoneys()
    needExp = RoleTool.GetExpForLv(curExp, curLv, curLv + curIndex)
    -- 经验
    local storeExp = RoleMgr:GetStoreExp()
    local str = storeExp < needExp and string.format("<color=#ff8790>%s</color>", needExp) or (needExp .. "")
    CSAPI.SetText(txtStore, str)

    -- 金币
    local LVCfg = Cfgs.CardLevel:GetByID(curLv)
    local bagCostNum = BagMgr:GetCount(LVCfg.costs[2][1])
    local costNum = 0
    if (needExp > 0) then
        costNum = math.floor((needExp / LVCfg.costs[1]) * LVCfg.costs[2][2])
    end
    CSAPI.SetText(txtCost, bagCostNum >= costNum and costNum .. "" or StringUtil:SetByColor(costNum, "ff8790"))
    -- alpha 
    if (canvasGroup1 == nil) then
        canvasGroup1 = ComUtil.GetCom(btnUp, "CanvasGroup")
    end
    isEnough = true
    if (storeExp < needExp or bagCostNum < costNum) then
        isEnough = false
    end
    canvasGroup1.alpha = isEnough and 1 or 0.3
end

function SetUp()
    -- datas 
    curDatas = {}
    for k = curLv + 1, maxLv do
        table.insert(curDatas, k)
    end
    -- items 
    svUtil:Init(layout, #curDatas, {80, 120}, 5, 0.1, 0.6)
    layout:IEShowList(#curDatas, nil, curIndex)
    OnValueChange()
end

function LayoutCallBack(index)
    local _data = curDatas[index]
    local item = layout:GetItemLua(index)
    item.Refresh(_data)
    item.SetIndex(index)
    item.SetClickCB(OnClickItem)
    item.SetSelect(index == curIndex)
end
function OnClickItem(index)
    layout:MoveToCenter(index)
end
function OnValueChange()
    local index = layout:GetCurIndex()
    if index + 1 ~= curIndex then
        local item = layout:GetItemLua(curIndex)
        if item then
            item.SetSelect(false)
        end
        lastIdx = curIndex
        curIndex = index + 1
        local item = layout:GetItemLua(curIndex)
        if (item) then
            item.SetSelect(true);
        end
        if curIndex ~= lastIdx then
            SetMoneys()
        end
        SetArrows()
    end
    svUtil:Update()
end

function SetArrows()
    --
    CSAPI.SetGOActive(txtL, curIndex <= 1)
    CSAPI.SetGOActive(txtR, curIndex == #curDatas)
    --
    btnL_cg.alpha = curIndex > 1 and 1 or 0.3
    btnR_cg.alpha = curIndex < #curDatas and 1 or 0.3
end

function ELv(_lv)
    local str = StringUtil:SetByColor(_lv, "ffc146")
    CSAPI.SetText(txtLv1, str)
end

function EExp(cur, max)
    cur = math.floor(cur)
    if (isMax) then -- and cur >= max) then
        CSAPI.SetText(txtExp, "-/-")
    else
        CSAPI.SetText(txtExp, string.format("%s/%s", cur, max))
    end
end

-- 动画结束回调
function EEndCB()
    waitTime = 0.1
    -- oldData = nil
    -- oldTotalResult = nil
    -- Refresh(cardData)
end

function SetAudio(b)
    if (b) then
        if (isPlay) then
            CSAPI.StopUISound("ui_experience_load_gundong")
        end
        CSAPI.PlayUISound("ui_experience_load_gundong", true)
        isPlay = true
    else
        if (isPlay) then
            CSAPI.StopUISound("ui_experience_load_gundong")
        end
        isPlay = false
    end
end

-- function OnPressDown(isDrag, clickTime)
--     timer = Time.time
--     curStep = stepTime
--     curShowTime = stepTime
--     isPress = true
-- end

-- function OnPressUp(isDrag, clickTime)
--     isPress = false
-- end

function OnClick()
    --[[
    if (storeExp >= num1 and bagCostNum >= costNum) then
        addExp = num1
        RoleMgr:CardUpgrade(cardData:GetID(), num1, nil, nil, CardUpgradeCB)
        isBack = false
    end
    ]]
    if (not isUp and isEnough) then
        isUp = true
        addExp = needExp
        RoleMgr:CardUpgrade(cardData:GetID(), needExp)
    end
end

-- function CardUpgradeCB()
--     isBack = true
-- end

function OnClickL()
    if (not isUp and curIndex ~= 1) then
        layout:MoveToCenter(1)
    end
end

function OnClickR()
    if (not isUp and curIndex ~= #curDatas) then
        local enoughIndex = GetEnoughIndex()
        if (enoughIndex == 0) then
            layout:MoveToCenter(#curDatas)
        elseif (curIndex == enoughIndex) then
            LanguageMgr:ShowTips(3013)
        else
            layout:MoveToCenter(enoughIndex)
        end
    end
end

function GetEnoughIndex()
    local enoughIndex = 0
    for k, v in ipairs(curDatas) do
        -- 经验
        local needExp = RoleTool.GetExpForLv(curExp, curLv, curLv + k)
        local storeExp = RoleMgr:GetStoreExp()
        if (storeExp < needExp) then
            break
        end
        -- 金币
        local LVCfg = Cfgs.CardLevel:GetByID(curLv)
        local bagCostNum = BagMgr:GetCount(LVCfg.costs[2][1])
        local costNum = 0
        if (needExp > 0) then
            costNum = math.floor((needExp / LVCfg.costs[1]) * LVCfg.costs[2][2])
        end
        if (bagCostNum < costNum) then
            break
        end
        enoughIndex = k
    end
    return enoughIndex
end
