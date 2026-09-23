local waitTime = 1.5 -- 等待多长时间开始掉落音符
local feverTime = nil -- fever时长 6
local comboLimit = 6
local len = 30
local interval = {0.4, 1}
--
local count = 0
local curFever = 0 -- 阶段
local timerL = nil
local timerR = nil
local anim = nil
local isOver = nil
local FBItems = {}
local clickY = {-1385, -1179}
local audioIDs = {70400119, 70400120, 70400122}

function Awake()
    CSAPI.SetGOActive(topMask, true)
    CSAPI.SetGOActive(node, false)
    fill_imgFever = ComUtil.GetCom(imgFever, "Image")
    anim = ComUtil.GetCom(node, "Animator")
    CSAPI.StopBGM()
    CSAPI.PlayBGM("LycorisRadiata_Music_01")
end

function OnDestroy()
    EventMgr.Dispatch(EventType.Replay_BGM)
end

function Refresh(_CardLive2DItem)
    CardLive2DItem = _CardLive2DItem
end

function Update()
    if (isOver) then
        return
    end

    if (waitTime) then
        waitTime = waitTime - Time.deltaTime
        if (waitTime <= 0) then
            waitTime = nil
            CSAPI.SetGOActive(topMask, false)
            CSAPI.SetGOActive(node, true)
            timerL = Time.time + CSAPI.RandomFloat(interval[1], interval[2])
            timerR = Time.time + CSAPI.RandomFloat(interval[1], interval[2])
        end
    elseif (feverTime ~= nil) then
        feverTime = feverTime - Time.deltaTime
        fill_imgFever.fillAmount = feverTime / 6
        if (feverTime <= 0) then
            if (curFever >= 2) then
                isOver = true
                CardLive2DItem.PlayByIndex(11, nil, nil, true) -- 玩家完成fever2时结束小游戏播的奖励动画
                return
            end
            count = 0
            feverTime = nil
            anim:Play("interface_feverTimeout", 0, 0)
            CSAPI.SetGOActive(topMask, false)
        end
    else
        if (Time.time > timerL) then
            timerL = Time.time + CSAPI.RandomFloat(interval[1], interval[2])
            CreateItem(true)
        end
        if (Time.time > timerR) then
            timerR = Time.time + CSAPI.RandomFloat(interval[1], interval[2])
            CreateItem(false)
        end
        len = len - Time.deltaTime
        if (len <= 0) then
            isOver = true
            CardLive2DItem.PlayByIndex(12, nil, nil, true) -- 按失败退出
            return
        end
    end
end

function CreateItem(isL)
    local point = isL and pointL or pointR
    if (#FBItems > 0) then
        local item = FBItems[1]
        table.remove(FBItems, 1)
        CSAPI.SetParent(item.gameObject, point)
        CSAPI.SetAnchor(item.gameObject, 0, 0, 0)
        CSAPI.SetGOActive(item.gameObject, true)
        item.Refresh()
    else
        ResUtil:CreateUIGOAsync("Spine/70400_skin_LycorisRadiata03a_spine/70400_skin_LycorisRadiata03a_spine_item",
            point, function(go)
                local item = ComUtil.GetLuaTable(go)
                item.SetRecycle(SetRecycle)
                item.Refresh()
            end)
    end
end

function SetRecycle(item)
    if (item) then
        CSAPI.SetGOActive(item.gameObject, false)
        CSAPI.SetParent(item.gameObject, AdaptiveScreen)
        table.insert(FBItems, item)
    end
end

function SetCombo(num)
    local nums = SplitNumber(num)
    local len = #nums
    for k = 1, 3 do
        local obj = this["imgNum" .. k]
        CSAPI.SetGOActive(obj, len >= k)
        if (len >= k) then
            CSAPI.LoadImg(obj, "UIs/Spine/70400_skin_LycorisRadiata03a_spine/img_08_0" .. nums[1] .. ".png", true, nil,
                true)
        end
    end
    --
    SetObjAH(combo)
    fill_imgFever.fillAmount = count / comboLimit
end

function SplitNumber(num)
    local str = tostring(num)
    local result = {}
    for i = 1, #str do
        table.insert(result, tonumber(string.sub(str, i, i)))
    end
    return result
end

function OnClick(isL)
    if (feverTime ~= nil) then
        return
    end
    CSAPI.PlayTempSound("LycorisRadiata_effects_01")
    local isMiss = true
    local point = isL and pointL or pointR
    local childCount = point.transform.childCount - 1
    for i = 0, childCount do
        local child = point.transform:GetChild(i).gameObject
        local x1, y1 = CSAPI.GetAnchor(child)
        if (y1 > clickY[1] and y1 < clickY[2]) then
            isMiss = false
            local item = ComUtil.GetLuaTable(child)
            item.Recyclse()
            break
        end
    end
    count = isMiss and count or count + 1
    if (isMiss) then
        SetObjAH(miss)
    else
        CSAPI.PlayTempSound("LycorisRadiata_effects_04")
        SetCombo(count)
        SetObjAH(isL and P_LineWave1 or P_LineWave2) -- 线特效
        PlayAudio()
    end
    if (count >= comboLimit) then
        curFever = curFever + 1
        SetFlappingPos()
        local index = curFever == 1 and 9 or 10 -- 进入fever阶段时的衔接动作
        isChange = true
        CardLive2DItem.PlayByIndex(index, function()
            isChange = false
        end, nil, true)
        -- 
        feverTime = 6
        timerL = Time.time + feverTime + 2
        timerR = Time.time + feverTime + 2
        anim:Play("interface_feverTimein", 0, 0)
        CSAPI.SetGOActive(topMask, true)
        CSAPI.PlayTempSound("LycorisRadiata_effects_03")
    end
end

function SetFlappingPos()
    local x, y = 187, 187
    if (curFever == 1) then
        x, y = 140, 100
    elseif (curFever == 2) then
        x, y = 91, -122
    end
    CSAPI.SetAnchor(P_Flapping1, -x, y, 0)
    CSAPI.SetAnchor(P_Flapping2, x, y, 0)
end

function OnClickL()
    if (isChange or isOver or len <= 0.5) then
        return
    end
    SetObjAH(P_PickSuccess1) -- 按钮特效
    SetObjAH(P_Flapping1) -- 屁股特效
    local index = curFever == 0 and 4 or 6
    CardLive2DItem.PlayByIndex(index, nil, nil, true)
    OnClick(true)
end

function OnClickR()
    if (isChange or isOver or len <= 0.5) then
        return
    end
    SetObjAH(P_PickSuccess2)
    SetObjAH(P_Flapping2)
    local index = curFever == 0 and 5 or 7
    CardLive2DItem.PlayByIndex(index, nil, nil, true)
    OnClick(false)
end

function OnClickBack()
    if (not isOver) then
        isOver = true
        CardLive2DItem.PlayByIndex(12, nil, nil, true) -- 按失败退出
    end
end

function SetObjAH(name)
    CSAPI.SetGOActive(name, false)
    CSAPI.SetGOActive(name, true)
end

function PlayAudio()
    local index = CSAPI.RandomInt(1, 3)
    local audioId = audioIDs[index]
    if (RoleAudioPlayMgr:GetIsPlaying()) then
        RoleAudioPlayMgr:StopSound()
    end
    RoleAudioPlayMgr:PlayById(CardLive2DItem.modelId, audioId)
end

function OnClickTopMask()
    if (isChange or isOver or len <= 0.5) then
        return
    end
    if (feverTime and feverTime > 0) then
        SetObjAH(P_Hit)
        local _index = CSAPI.RandomInt(6, 7)
        if (_index == 6) then
            SetObjAH(P_Flapping1)
        else
            SetObjAH(P_Flapping2)
        end
        local index = curFever < 2 and _index or 8
        CardLive2DItem.PlayByIndex(index, nil, nil, true)
        CSAPI.PlayTempSound("LycorisRadiata_effects_02")
        PlayAudio()
    end
end
