local layout = nil
local topItems = nil
local indexDatas = nil
local currDatas = nil
local slider = nil
local canvasGroup = nil
local isRole = false
local isGetReward = false
local isDayFinish = false

local mType = nil
local mStageType = nil

local currIndex = 0 -- 当前页签
local currDay = 0
local currTopItem = nil

local rewards = nil
local rewardItems = nil

local dayReds = nil

-- anim
local animTime = 0
local nFade = nil
local bFade = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Activity2/MissionContinueItem2", LayoutCallBack, true)
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)

    slider = ComUtil.GetCom(finishSlider, "Slider")
    canvasGroup = ComUtil.GetCom(c, "CanvasGroup")

    eventMgr = ViewEvent.New();

    nFade = ComUtil.GetCom(node, "ActionFade")
    bFade = ComUtil.GetCom(bottom, "ActionFade")

    fade = ComUtil.GetCom(gameObject, "ActionFade")
end

function OnEnable()
    eventMgr:AddListener(EventType.Mission_List, function(_data)
        if gameObject.activeSelf == false then
            return
        end
        currDay = MissionMgr:GetActivityIndex(mType)
        currTopItem = nil
        if not _data then
            RefreshTopItems()
            return
        end

        local rewards = _data[2]
        RefreshTopItems()
        if (#rewards > 0) then
            UIUtil:OpenReward({rewards})
        end
    end);
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = currDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data)
    end
end

function Update()
    if animTime > 0 then
        animTime = animTime - Time.deltaTime
        CSAPI.SetGOActive(animMask, true)
    else
        CSAPI.SetGOActive(animMask, false)
    end

    if rewards and #rewards > 4 then
        local posX = CSAPI.GetAnchor(rewardParent)
        CSAPI.SetGOActive(arrowR, posX >= -30)
        CSAPI.SetGOActive(arrowL, posX <= -222 * 0.7 + 30)
    else
        CSAPI.SetGOActive(arrowL, false)
        CSAPI.SetGOActive(arrowR, false)
    end
end

function OnDisable()
    eventMgr:ClearListener()
end

function Refresh(_data, _elseData)
    -- 初始化
    bFade:SetAlpha(1)

    local cfg = _elseData and _elseData.cfg or nil
    if cfg == nil then
        LogError("未获取到七日或阶段任务的活动列表数据！！！")
        return
    end
    mType, mStageType = GetTaskType(cfg)

    currDay = MissionMgr:GetActivityIndex(mType)
    RefreshTopItems()

    -- red
    CheckRed()
end

function GetTaskType(cfg)
    local type, stageType = eTaskType.Seven, eTaskType.SevenStage
    if cfg.taskType then
        if cfg.taskType == eContinueTaskType.Guide then
            type, stageType = eTaskType.Guide, eTaskType.GuideStage
        elseif cfg.taskType == eContinueTaskType.NewYear then
            type, stageType = eTaskType.NewYear, eTaskType.NewYearFinish
        end
    end
    return type, stageType
end

-- 刷新上方item
function RefreshTopItems()
    local datas = MissionMgr:GetActivityDatas(mStageType) or {}
    currIndex = currIndex < 1 and GetDayIndex(datas) or currIndex
    topItems = topItems or {}
    local selectItem = nil
    if #topItems > 0 then
        for i, v in ipairs(topItems) do
            CSAPI.SetGOActive(v.gameObject, false)
        end
    end
    for i = 1, 7 do
        if i > #topItems then
            ResUtil:CreateUIGOAsync("Activity2/MissionContinueItem", topParent, function(go)
                local lua = ComUtil.GetLuaTable(go)
                lua.SetIndex(i)
                lua.Refresh(datas[i], {
                    isLock = currDay < i,
                    type = mType
                })
                lua.SetClickCB(ClickItemCB1)
                table.insert(topItems, lua)

                if i == currIndex then
                    selectItem = lua
                end

                if i == 7 and selectItem then
                    selectItem.OnClick()
                end
            end)
        else
            local lua = topItems[i]
            lua.SetIndex(i)
            lua.Refresh(datas[i], {
                isLock = currDay < i,
                type = mType
            })

            CSAPI.SetGOActive(lua.gameObject, true)

            if i == currIndex then
                selectItem = lua
            end

            if i == 7 and selectItem then
                selectItem.OnClick()
            end
        end
    end
end

-- 获取进入天数
function GetDayIndex(_datas)
    local index = currDay
    if _datas then
        for i, v in ipairs(_datas) do
            if ((not v:IsFinish()) or i == #_datas) then
                index = index > i and i or index
                break
            end
        end
    end
    return index
end

function ClickItemCB1(item)
    if currTopItem == item then
        return
    end
    local lastItem = nil
    if currTopItem then
        lastItem = currTopItem
        currTopItem.SetSel(false)
    end

    currTopItem = item
    currTopItem.SetSel(true)

    isRole = item.IsRoleReward()
    isDayFinish = item.IsFinish()
    isGetReward = item.IsGet()

    currIndex = item.index

    PlayAnim(not isFirst, RefreshPanel)
    isFirst = true

    -- RefreshPanel()
end

-- 刷新下方数据
function RefreshPanel()
    RefreshDatas() -- 重新获取数据
    currDatas = indexDatas[currIndex]

    SetRight()
    SetLeft()
end

-- 右侧任务数据
function RefreshDatas()
    indexDatas = {}
    local datas = MissionMgr:GetActivityDatas(mType)
    if datas then
        local topRedInfos = {} -- 用于上方红点
        for k, v in ipairs(datas) do
            if v:GetIndex() then
                local index = v:GetIndex()
                indexDatas[index] = indexDatas[index] or {}
                table.insert(indexDatas[index], v)

                -- red
                if v:IsFinish() and not v:IsGet() then
                    topRedInfos[index] = 1
                end
            end
        end
        -- 给与上方按钮红点
        for k, v in pairs(topRedInfos) do
            if topItems and topItems[k] and topItems[k] ~= currTopItem then
                topItems[k].SetRed(true)
            end
        end
    end
end

function SetRight()
    if currDatas then
        tlua:AnimAgain()
        layout:IEShowList(#currDatas)
    end
end

function SetLeft()
    CSAPI.SetGOActive(roleObj, isRole)
    CSAPI.SetGOActive(goodsObj, not isRole)
    CSAPI.SetAnchor(rewardParent, 0, 0)

    if not isRole then
        SetGoodPanel()
    end

    SetRewards()
end

-- 物品信息
function SetGoodPanel()
    if currTopItem and currTopItem.data and currTopItem.data:GetCfg() then
        local iconName = currTopItem.data:GetCfg().sIcon
        if iconName ~= "" then
            ResUtil.IconGoods:Load(icon, iconName .. "")
        end
        local cfg = Cfgs.ItemInfo:GetByID(tonumber(iconName))
        CSAPI.SetText(txtGood, cfg and cfg.name or "")
        CSAPI.SetText(txtGoodDesc, currTopItem.data:GetCfg().sRewardDes)
    end
end

-- 奖励信息
function SetRewards()
    CSAPI.SetGOActive(nolObj, not isDayFinish)
    CSAPI.SetGOActive(btnGet, isDayFinish and not isGetReward)
    CSAPI.SetGOActive(txt_Get, isGetReward)
    canvasGroup.alpha = isGetReward and 0.5 or 1

    rewards = {}
    if currTopItem and currTopItem.data then
        local info = currTopItem.data
        rewards = info:GetJAwardId()
        slider.value = (info:GetCnt() / info:GetMaxCnt()) or 0
        CSAPI.SetText(txtNum, info:GetCnt() .. "/" .. info:GetMaxCnt())
        -- red    
        UIUtil:SetRedPoint2("Common/Red2", btnGet, info:IsFinish() and not info:IsGet(), 109, 33)
    end
    -- item
    local gridDatas = GridUtil.GetGridObjectDatas(rewards)

    -- scale
    local scale = #gridDatas > 3 and 0.54 or 0.7
    CSAPI.SetScale(rewardParent, scale, scale, 1)

    rewardItems = rewardItems or {}
    ItemUtil.AddItems("Activity2/MissionContinueReward", rewardItems, gridDatas, rewardParent,
        GridClickFunc.OpenInfoSmiple, 1)
end

function CheckRed()
    local type = ActivityListType.MissionContinue
    if mType == eTaskType.NewYear then
        type = ActivityListType.NewYearContinue
    end
    ActivityMgr:CheckRedPointData(type)
end



function OnClickGet()
    local data = currTopItem.data
    if (data) then
        if (not data:IsGet() and data:IsFinish()) then
            if (MissionMgr:CheckIsReset(data)) then
                -- LanguageMgr:ShowTips(xxx)
                LogError("任务已过期")
            else
                MissionMgr:GetReward(data:GetID())
            end
        end
    end
end

------------------------------------anim------------------------------------

function AddAnimTime(time)
    animTime = animTime + (time / 1000)
end

function PlayAnim(isFirst, cb)
    CSAPI.SetGOActive(first, isFirst)
    if isFirst then
        AddAnimTime(350)
        nFade:Play(0, 1, 150)
        CSAPI.SetGOActive(normal, false)
        if cb then
            cb()
        end
    else
        AddAnimTime(450)
        CSAPI.SetGOActive(normal, false)
        bFade:Play(1, 0, 200, 0, function()
            bFade:Play(0, 1, 250)
            if cb then
                cb()
            end
            CSAPI.SetGOActive(normal, true)
        end)
    end
end

function PlayFade(isFade, cb)
    local star = isFade and 1 or 0
    local target = isFade and 0 or 1
    fade:Play(star, target, 200, 0, function()
        if cb then
            cb()
        end
    end)
end
