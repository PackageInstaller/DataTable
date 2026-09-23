local data = nil
local datas = nil
-- time
local targetTime, time, timer = 0, 0, 0
-- left
local sliderNol, sliderHard = nil, nil
-- right 
local layout = nil
local currLevel = 1
local levelTab = nil
local curDatas = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Activity2/MissionContinueItem2", LayoutCallBack, true)
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)

    sliderNol = ComUtil.GetCom(nolSlider, "Slider")
    sliderHard = ComUtil.GetCom(hardSlider, "Slider")

    eventMgr = ViewEvent.New();

    levelTab = ComUtil.GetCom(levelTabs, "CTab")
    levelTab:AddSelChangedCallBack(OnTabChanged)
end

function OnEnable()
    eventMgr:AddListener(EventType.Mission_List, function(_data)
        if gameObject.activeSelf == false then
            return
        end

        if not _data then
            RefreshPanel()
            return
        end

        local rewards = _data[2]
        RefreshPanel()
        if (#rewards > 0) then
            UIUtil:OpenReward({rewards})
        end
    end);

end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data)
    end
end

function OnTabChanged(index)
    if currLevel == index then
        return
    end
    currLevel = index

    SetRight()
end

function OnDisable()
    eventMgr:ClearListener()
end

function Update()
    if time > 0 and Time.time > timer then
        timer = Time.time + 1
        time = targetTime - TimeUtil:GetTime()
        CSAPI.SetText(txtTime, LanguageMgr:GetByID(60001) .. TimeUtil:GetTimeStr3(time))
        if time <= 0 then
            CSAPI.SetText(txtTime, "")
        end
    end
end

function Refresh(_data, _elseData)
    data = _data
    SetTime()
    RefreshPanel()
end

function SetTime()
    targetTime = PlayerMgr:GetOpenTime(ActivityListType.NewPlayerSeven) + (g_NewPlayerSevenDayTaskTimes * 86400)
    time = targetTime - TimeUtil:GetTime()
    if time <= 0 then
        CSAPI.SetText(txtTime, "")
    end
end

function RefreshPanel()
    SetDatas()
    SetLeft()
    SetRight()
end

function SetDatas()
    local _datas = MissionMgr:GetActivityDatas(eTaskType.NewPlayerSeven)
    datas = {}
    if _datas and #_datas > 0 then
        for i, v in ipairs(_datas) do
            local cfg = v:GetCfg()
            if cfg and cfg.type then
                datas[cfg.type] = datas[cfg.type] or {}
                table.insert(datas[cfg.type], v)
            end
        end
    end
end

function SetLeft()
    SetNol()
    SetHard()
end

function SetNol()
    local _datas = datas and datas[1] or nil
    if _datas then
        local cur, max = 0, #_datas
        for i, v in ipairs(_datas) do
            if v:IsFinish() then
                cur = cur + 1
            end
        end

        CSAPI.SetText(txtNum1, cur .. "/" .. max)
        sliderNol.value = (cur / max) or 0
    end
end

function SetHard()
    local _datas = datas and datas[2] or nil
    if _datas then
        local cur, max = 0, #_datas
        for i, v in ipairs(_datas) do
            if v:IsFinish() then
                cur = cur + 1
            end
        end

        CSAPI.SetText(txtNum2, cur .. "/" .. max)
        sliderHard.value = (cur / max) or 0
    end
end

function SetRight()
    SetItems()
    SetRed()
end

function SetItems()
    curDatas = datas[currLevel]
    tlua:AnimAgain()
    layout:IEShowList(#curDatas)
end

function SetRed()
    if datas then
        local isRed = false
        if datas[1] and currLevel ~= 1 then
            for i, v in ipairs(datas[1]) do
                if v:IsFinish() and not v:IsGet() then
                    isRed = true
                    break
                end
            end
        end
        UIUtil:SetRedPoint(redParent1, isRed)
        isRed = false
        if datas[2] and currLevel ~= 2 then
            for i, v in ipairs(datas[2]) do
                if v:IsFinish() and not v:IsGet() then
                    isRed = true
                    break
                end
            end
        end
        UIUtil:SetRedPoint(redParent2, isRed)
    end
end
