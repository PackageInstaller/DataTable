local data = nil
local items = nil
local datas = nil
local isLoadComplete = false

-- anim
local animIndex = 1
local animTime = 0
local isAnim = false
local isAnimEnd = false
local move = nil
local canvasGroup 
local anims ={}

function Awake()
    local actions = ComUtil.GetComsInChildren(gameObject, "ActionBase")
    for i = 0, actions.Length - 1 do
        table.insert(anims, actions[i])
    end

    move = ComUtil.GetCom(moveAction, "ActionMoveTo")
    canvasGroup = ComUtil.GetCom(node,"CanvasGroup")
    canvasGroup.alpha = 0
    CSAPI.SetGOActive(enterAction,false)

    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Equip_SetLock_Ret, OnLockRet)
end

function OnLockRet()
    RefreshItems()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Update()
    if not (isAnim and isLoadComplete) then
        return
    end

    if (items and animIndex > #items) then
        if items[#items].IsAnimEnd() then
            isAnimEnd = true
            isAnim = false
            EventMgr.Dispatch(EventType.Fight_Over_Reward)
        end
        return
    end

    if animTime > 0 then
        animTime = animTime - Time.deltaTime
    else
        local item = items[animIndex]
        CSAPI.SetGOActive(item.gameObject, true)
        animIndex = animIndex + 1
        animTime = 0.2
        local posX, posY = CSAPI.GetLocalPos(itemParent.gameObject)
        if item.index > 4 then
            MoveTo(posX, 17 + (item.index - 4) * (158 + 10), 0, 0.1)
        end
    end
end

function Refresh(_data)
    data = _data
    if data then
        SetDatas()
        SetItems()
    end
end

function SetDatas()
    datas = {}
    if data.rewardList then
        local max = #data.rewardList
        if data.bufRewardList then
            max = max < #data.bufRewardList and #data.bufRewardList or max
        end
        for i = 1, max do
            if data.rewardList[i] then
                local rewards = {}
                if data.rewardList[i].reward then
                    for i, v in ipairs(data.rewardList[i].reward) do
                        table.insert(rewards, v)
                    end
                end
                if data.bufRewardList[i] and data.bufRewardList[i].reward then
                    for i, v in ipairs(data.bufRewardList[i].reward) do
                        table.insert(rewards, v)
                    end
                end
                rewards = RewardUtil.SetShrink(rewards)
                table.insert(datas, rewards)
            end
        end
        if data.specialRewardList and #data.specialRewardList >0 then
            for i, v in ipairs(data.specialRewardList) do
                local index = v.modUpIndex
                if datas and datas[index] and v.reward then
                    for k, m in ipairs(v.reward) do
                        table.insert(datas[index], m)
                    end
                    datas[index] = RewardUtil.SetShrink(datas[index])
                end
            end
        end
    end
end

function SetItems()
    items = {}
    if datas then
        for i, v in ipairs(datas) do
            v = SortMgr:Sort(19, v)
            ResUtil:CreateUIGOAsync("FightOver/FightOverSweepItem", itemParent, function(go)
                local lua = ComUtil.GetLuaTable(go)
                lua.SetNum(i, #datas)
                lua.Refresh(v)
                table.insert(items, lua)
                CSAPI.SetGOActive(go, false)
                if i == #datas then
                    isLoadComplete = true
                end
            end)
        end
    end
end

function RefreshItems()
    if #items > 0 then
        for i, v in ipairs(items) do
            local reward = SortMgr:Sort(19, datas[i])
            v.Refresh(reward)
        end
    end
end

function PlayAnim()
    isAnim = true
    animTime = 0.2
    CSAPI.SetGOActive(enterAction, true)
end

function MoveTo(x, y, z, time)
    move:PlayByTime(x, y, z, time)
end

function IsAnimEnd()
    return isAnimEnd
end

function JumpToAnimEnd()
    isAnim = false
    canvasGroup.alpha = 1
    CSAPI.SetGOActive(enterAction, true)

    if items and #items >0 then
        local posX, posY = CSAPI.GetLocalPos(itemParent.gameObject)
        if #items > 4 then
            CSAPI.SetScriptEnable(sv,"ScrollRect", false)
            MoveTo(posX, 17 + (#items - 4) * (158 + 10), 0, 0.1)
            -- CSAPI.SetLocalPos(itemParent.gameObject, posX, 17 + (#items - 4) * (158 + 10))
            CSAPI.SetScriptEnable(sv,"ScrollRect", true)
        end
        for i, v in ipairs(items) do
            CSAPI.SetGOActive(v.gameObject, true)
            v.JumpToAnimEnd()
        end
    end

    if #anims > 0 then -- 动效跳过
        for i, v in ipairs(anims) do
            if v.gameObject.activeSelf == true then
                v:SetComplete(true)
            end
        end
    end

    isAnimEnd = true
end