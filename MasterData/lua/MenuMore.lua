-- 红点和new是同一个位置
local redPoss = {
    ["PlayerView"] = {78, 78},
    ["Achievement"] = {147.4, 51.8},
    ["Dorm"] = {66.3, 50.7},
    ["FriendView"] = {66.3, 50.7},
    ["CourseView"] = {66.3, 50.7},
    ["PlayerAbility"] = {66.3, 50.7},
    ["ArchiveView"] = {66.3, 50.7},
    ["ActivityView"] = {66.3, 50.7},
    ["SettingView"] = {66.3, 50.7},
    ["ActivityListView"] = {74.7, 72.4},
    ["Questionnaire"] = {66.3, 50.7},
}
-- 上锁位置全居中[0,0]
-- 入口拿取红点的key值，没有的特殊处理
local redsRef = {
    ["Achievement"] = RedPointType.Achievement,
    -- ["Dorm"] = ,
    ["FriendView"] = RedPointType.Friend,
    ["CourseView"] = RedPointType.CourseView,
    ["PlayerAbility"] = RedPointType.PlayerAbility,
    -- ["ArchiveView"] = RedPointType.Archive,
    -- ["ActivityView"] = RedPointType.,
    -- ["SettingView"] = RedPointType.,
    ["ActivityListView"] = RedPointType.ActivityList1,
    ["Questionnaire"] = RedPointType.Questionnaire,
}
--
local views = {"PlayerView", "Achievement", "Dorm", "FriendView", "CourseView", "PlayerAbility", "ArchiveView",
               "ActivityView", "SettingView", "ActivityListView","Questionnaire"} -- 统一处理（上锁，红点检查，点击）
--
local timer = 0
local isClickMask = false
local fill_lv
local fill_power
local anim_AdaptiveScreen
local barTime = nil
local barValue = 0
local barLen = 0.5
local isDestroy = false
function Awake()
    fill_lv = ComUtil.GetCom(imgLv, "Image")
    fill_power = ComUtil.GetCom(fillPower, "Image")
    anim_AdaptiveScreen = ComUtil.GetCom(AdaptiveScreen, "Animator")

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RedPoint_Refresh, RefreshPanel)
    
    --英俄
    if (CSAPI.RegionalCode() == 6) then
        local txt1 = ComUtil.GetCom(txtYE1,"Text")
        local txt2 = ComUtil.GetCom(txtYE2,"Text")
        local txt3 = ComUtil.GetCom(txtYE3,"Text")
        txt1.fontSize = 23
        txt2.fontSize = 23
        txt3.fontSize = 23
    end
end

function OnDestroy()
    if (menu and menu.gameObject~=nil) then
        menu.Anim_uis(true, not isClickMask)
        menu.Anim_center(true, not isClickMask)
    end
    eventMgr:ClearListener()
    isDestroy = true
end

function Update()
    if (Time.time >= timer) then
        timer = Time.time + 1
        SetDayPower()
    end
    -- 经验
    if (barTime) then
        Anim_fillLv()
    end
end

function OnOpen()
    SetMenu()
    InitOnClick()
    RefreshPanel()
    --
    anim_AdaptiveScreen:Play("AdaptiveScreen_in")
end

function SetMenu()
    local go = CSAPI.GetView("Menu")
    menu = ComUtil.GetLuaTable(go)
    menu.Anim_uis(false, true)
    menu.Anim_center(false, true)
end

function InitOnClick()
    for k, key in pairs(views) do
        local _name = "OnClick" .. key
        if (key == "Dorm") then
            this[_name] = function()
                local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, key)
                if (not isOpen) then
                    Tips.ShowTips(str)
                else
                    CSAPI.OpenView("DormRoom")
                end
            end
        else
            -- 通用的打开方式
            this[_name] = function()
                local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, key)
                if (not isOpen) then
                    Tips.ShowTips(str)
                else
                    if (key == "ActivityView") then
                        if (not ActivityMgr:IsHaveBoard()) then
                            Tips.ShowTips(LanguageMgr:GetByID(30005))
                        else
                            CSAPI.OpenView(key)
                        end
                    else
                        CSAPI.OpenView(key)
                    end
                end
            end
        end
    end
end

function RefreshPanel()
    if (isDestroy or headParent==nil) then
        return
    end
    -- head
    UIUtil:AddHeadFrame(headParent, 1)
    -- player
    SetLv()
    SetPlayerDetail()
    -- ad
    SetAD()
    -- lock
    SetLocks()
    -- red
    SetReds()
    --
    UIUtil:AddTitle(titleParent, 1)
    --问卷 
    SetQuestionnaire()
end

function SetQuestionnaire()
    CSAPI.SetGOActive(btnQuestionnaire,QuestionnaireMgr:IsShowEnter())
end

function SetDayPower()
    local curTime = TimeUtil:GetTime()
    CSAPI.SetText(txtDay, os.date("%Y/%m/%d", curTime))
    CSAPI.SetText(txtTime, os.date("%H:%M %p", curTime))
    --
    local cur = CSAPI.GetElectricQuantity()
    cur = cur and math.ceil(math.abs(cur) * 100) or 100
    CSAPI.SetText(txtPower, cur .. "%")
    fill_power.fillAmount = cur / 100
end

-- 设置等级
function SetLv()
    -- lv	
    local curLv = PlayerClient:GetLv()
    local maxLv = PlayerClient:GetMaxLv()
    CSAPI.SetText(txtLv1, string.format("%d", curLv))
    CSAPI.SetText(txtLv2, "/"..maxLv)
    -- exp
    if curLv == maxLv then
        LanguageMgr:SetText(txtExp1, 34004)
        CSAPI.SetText(txtExp2, "/" .. LanguageMgr:GetByID(34004))
        fill_lv.fillAmount = 1
        return
    end

    local curExp = PlayerClient:GetExp()
    local maxExp = GetMaxExp(curLv)
    CSAPI.SetText(txtExp1, curExp .. "")
    CSAPI.SetText(txtExp2, "/" .. maxExp)
    fill_lv.fillAmount = curExp / maxExp
end
function GetMaxExp(lv)
    local cfg = Cfgs.CfgPlrUpgrade:GetByID(lv)
    return cfg and cfg.nNextExp or 0
end

function SetPlayerDetail()
    CSAPI.SetText(txtName, PlayerClient:GetName())
    CSAPI.SetText(txtUID, "UID:" .. PlayerClient:GetUid())
    --
    barValue = fill_lv.fillAmount
    barTime = 0
end

function SetAD()
    if (isSetAD == nil) then
        isSetAD = 1
        ResUtil:CreateUIGO("Menu/MenuAD", objAD.transform)
    end
end

function SetLocks()
    lockDatasDic = {}
    for i, v in ipairs(views) do
        local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, v)
        if (not isOpen) then
            lockDatasDic[v] = 1
        end
        if (v ~= "PlayerView") then
            local obj = this["btn" .. v]
            UIUtil:SetLockPoint(obj, not isOpen, 0, 0)
            CSAPI.SetGOAlpha(obj, isOpen and 1 or 0.5)
        end
    end
end

function SetReds()
    for i, v in ipairs(views) do
        local isNew = false
        local isRed = false
        if (not lockDatasDic[v]) then
            if (redsRef[v]) then
                local _data = RedPointMgr:GetData(redsRef[v])
                isRed = _data ~= nil
            elseif (v == "PlayerView") then
                local _pData = RedPointMgr:GetData(RedPointType.HeadFrame)
                local _pData2 = RedPointMgr:GetData(RedPointType.Head)
                local _pData3 = RedPointMgr:GetData(RedPointType.Badge)
                local _pData4 = RedPointMgr:GetData(RedPointType.Title)
                if (_pData ~= nil or _pData2 ~= nil or _pData3 ~= nil or _pData4 ~= nil) then
                    isRed = true
                end
            elseif (v == "ArchiveView") then
                isRed = ArchiveMgr:CheckRed()
            end
        end
        local obj = this["btn" .. v]
        local pos = redPoss[v]
        UIUtil:SetNewPoint(obj, isNew, pos[1], pos[2])
        UIUtil:SetRedPoint(obj, isRed, pos[1], pos[2])
    end
end

function Anim_fillLv()
    if (barTime) then
        barTime = barTime + Time.deltaTime
        fill_lv.fillAmount = barTime / barLen * barValue
        if (barTime >= barLen) then
            barTime = nil
            fill_lv.fillAmount = barValue
        end
    end
end

function OnClickMask()
    isClickMask = true
    CSAPI.SetGOActive(topMask, true)
    menu.Anim_uis(true, true)
    menu.Anim_center(true, true)
    anim_AdaptiveScreen:Play("AdaptiveScreen_out")
    --
    FuncUtil:Call(function()
        view:Close()
    end, nil, 500)
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end

