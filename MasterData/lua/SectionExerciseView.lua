local time, timer, refreshTime = 0, 0, 0
local openNums = nil
local currSel = 1
local isPvpRet = false
local isExerciseOpen, lockStr = false, ""
local isColosseumOpen, lockStr2 = false, ""
local isLimitExerciseOpen, lockStr3 = false, ""
local openGOs = nil
function Awake()
    CSAPI.SetGOActive(clickMask, false)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RedPoint_Refresh, SetRed)
    eventMgr:AddListener(EventType.Exercise_Update, Refresh)
    eventMgr:AddListener(EventType.ExerciseL_New, SetNew)
    eventMgr:AddListener(EventType.Section_Guide_Update, OnGuideUpdate)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function SetClickCB(_cb)
    cb = _cb
end

function OnGuideUpdate(data)
    if data.type == 3 and data.index then
        currSel = data.index
        SetButtonState()
    end
end

function Update()
    if time > 0 and Time.time > timer then
        timer = Time.time + 1
        time = refreshTime - TimeUtil:GetTime()
        if time <= 0 then
            Refresh()
        end
    end
end

function Refresh()
    openNums = {}
    isPvpRet = ExerciseMgr:GetEndTime() ~= 0
    SetExercise()
    SetColosseum()
    SetLimitExercise()
    SetButtonState()
    SetRed()
end

function SetExercise()
    isExerciseOpen, lockStr = MenuMgr:CheckModelOpen(OpenViewType.main, "ExerciseLView")
    if not isPvpRet then
        CSAPI.SetGOActive(eLockImg, true)
        CSAPI.SetGOActive(eLockObj, true)
        LanguageMgr:SetText(txt_eLock1, 15117)
        LanguageMgr:SetText(txt_eLock2, 15118)
    else
        CSAPI.SetGOActive(eLockImg, not isExerciseOpen)
        CSAPI.SetGOActive(eLockObj, not isExerciseOpen)
        LanguageMgr:SetText(txt_eLock1, 1035)
        CSAPI.SetText(txt_eLock2, str)
    end
    openNums[1] = 1
end

function SetColosseum()
    local isOpen, _refreshTime = ColosseumMgr:CheckEnterOpen()
    if _refreshTime ~= nil then
        refreshTime = _refreshTime
        time = refreshTime - TimeUtil:GetTime()
    end

    local sectionData = DungeonMgr:GetSectionData(13001)
    isColosseumOpen, lockStr2 = sectionData:GetOpen()
    if not isColosseumOpen or not isOpen then
        local isExerciseRShow = sectionData:GetOpenState() > -2
        if isExerciseRShow then
            isExerciseRShow = isOpen
        end
        CSAPI.SetText(txt_eLock4, lockStr2)
        CSAPI.SetGOActive(btnExercise2, isExerciseRShow)
        openNums[2] = isExerciseRShow and 1 or 0
    else
        CSAPI.SetGOActive(eLockImg2, false)
        CSAPI.SetGOActive(eLockObj2, false)
        openNums[2] = 1
    end
end

function SetLimitExercise()
    isLimitExerciseOpen, lockStr3 = true, ""
    CSAPI.SetGOActive(eLockImg3, not isLimitExerciseOpen)
    CSAPI.SetGOActive(eLockObj3, not isLimitExerciseOpen)
    CSAPI.SetText(txt_eLock6, lockStr3)

    openNums[3] = 1
    if not g_ArmyPvpShowUi or g_ArmyPvpShowUi == 0 then
        openNums[3] = 0
    end 
end

function SetButtonState()
    openGOs = {}
    for i = 1, 3 do
        CSAPI.SetGOActive(this["exercise" .. i].gameObject, openNums[i] == 1)
        if openNums[i] == 1 then
            table.insert(openGOs, this["exercise" .. i].gameObject)
        end
    end
    if #openGOs == 3 then
        CSAPI.SetGOActive(imgObj1,false)
        CSAPI.SetGOActive(imgObj2,true)
        local pos = {0, 449, -449}
        local fades = {1, 0.5, 0.5}
        local scales = {1, 0.8, 0.8}
        local index = 0
        for i = 1, 3 do
            index = (currSel - 1) + i
            index = index > 3 and index - 3 or index
            if i == 1 then
                openGOs[index].transform:SetAsLastSibling()
            end
            CSAPI.SetAnchor(openGOs[index], pos[i], 0)
            CSAPI.SetGOAlpha(openGOs[index], fades[i])
            CSAPI.SetScale(openGOs[index], scales[i], scales[i], 1)
        end
    elseif #openGOs == 2 then
        CSAPI.SetGOActive(imgObj1,true)
        CSAPI.SetGOActive(imgObj2,false)
        CSAPI.SetAnchor(openGOs[1], -378, 0)
        CSAPI.SetGOAlpha(openGOs[1], 1)
        CSAPI.SetScale(openGOs[1], 1, 1, 1)
        CSAPI.SetAnchor(openGOs[2], 378, 0)
        CSAPI.SetGOAlpha(openGOs[2], 1)
        CSAPI.SetScale(openGOs[2], 1, 1, 1)
    else
        CSAPI.SetGOActive(imgObj1,false)
        CSAPI.SetGOActive(imgObj2,true)
        CSAPI.SetAnchor(openGOs[1], 0, 0)
        CSAPI.SetGOAlpha(openGOs[1], 1)
        CSAPI.SetScale(openGOs[1], 1, 1, 1)
    end
end

function SetRed()
    UIUtil:SetRedPoint(btnExercise2, ColosseumMgr:IsRed(), 349, 184)
end

function SetNew()
    UIUtil:SetNewPoint(btnExercise1, ExerciseMgr:IsExerciseLNew(), 340, 190)
end

function OnClickExercise(go)
    local lastSel = currSel
    if go.name == "btnExercise1" then
        currSel = 1
    elseif go.name == "btnExercise2" then
        currSel = 2
    elseif go.name == "btnExercise3" then
        currSel = 3
    end
    if lastSel ~= currSel and cb then
        cb(currSel)
    end
    if #openGOs > 2 then
        ShowButtonClickAnim()
    else
        ShowView()
    end
end

function ShowButtonClickAnim()
    local type = CheckSelPos()
    if type == 0 then -- 无需动效
        ShowView()
        return
    end
    local pos = {0, 449, -449}
    local time = 300
    local index = 0
    local fades = type == 1 and {{0.5, 1}, {0.5, 0.5}, {1, 0.5}} or {{0.5, 1}, {1, 0.5}, {0.5, 0.5}}
    for i = 1, 3 do
        index = (currSel - 1) + i
        index = index > 3 and index - 3 or index
        if i == 1 then
            openGOs[index].transform:SetAsLastSibling()
            -- FuncUtil:Call(ShowView,this,time + 200)
        end
        CSAPI.MoveTo(openGOs[index], "UI_Local_Move", pos[i], 0, 0, nil, time / 1000)
        CSAPI.SetUIScaleTo(openGOs[index], nil, i == 1 and 1 or 0.8, i == 1 and 1 or 0.8, 1, nil, time / 1000)
        UIUtil:SetObjFade(openGOs[index], fades[i][1], fades[i][2], nil, time)
    end
    PlayAnim(time + 200)
end

-- 检测位置
function CheckSelPos()
    local x, y = CSAPI.GetAnchor(openGOs[currSel])
    if x > 0.01 then
        return 1
    elseif x < -0.01 then
        return 2
    end
    return 0
end

function ShowView()
    if currSel == 1 then
        ShowExerciseView()
    elseif currSel == 2 then
        ShowColosseumView()
    elseif currSel == 3 then
        ShowLimitExerciseView()
    end
end

function ShowExerciseView()
    if not isPvpRet then
        LanguageMgr:ShowTips(1019)
        return
    end

    if not isExerciseOpen then
        Tips.ShowTips(lockStr)
        return
    end
    CSAPI.OpenView("ExerciseLView")
end

function ShowColosseumView()
    if isColosseumOpen then
        CSAPI.OpenView("ColosseumView")
    else
        Tips.ShowTips(lockStr2)
    end
end

function ShowLimitExerciseView()
    CSAPI.OpenView("ExerciseRMain")
end

function PlayAnim(time)
    CSAPI.SetGOActive(clickMask, true)
    FuncUtil:Call(function()
        CSAPI.SetGOActive(clickMask, false)
    end, this, time)
end

