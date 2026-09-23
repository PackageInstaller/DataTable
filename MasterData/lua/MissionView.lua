curIndex1, curIndex2 = 1, 1 -- 父index,子index
local isShowActivity = false
local timer = nil

function Awake()
    layout1 = ComUtil.GetCom(vsv1, "UIInfinite")
    layout1:Init("UIs/Mission/MissionItem1", LayoutCallBack1, true)
    tlua1 = UIInfiniteUtil:AddUIInfiniteAnim(layout1, UIInfiniteAnimType.Normal)

    layout2 = ComUtil.GetCom(vsv2, "UIInfinite")
    layout2:Init("UIs/Mission/MissionItem2", LayoutCallBack2, true)
    tlua2 = UIInfiniteUtil:AddUIInfiniteAnim(layout2, UIInfiniteAnimType.Normal)
    --tlua22 = UIInfiniteUtil:AddUIInfiniteAnim(layout2, UIInfiniteAnimType.MoveUp, nil, false)

    layout3 = ComUtil.GetCom(vsv3, "UIInfinite")
    layout3:Init("UIs/Mission/MissionItem3", LayoutCallBack3, true)
    tlua3 = UIInfiniteUtil:AddUIInfiniteAnim(layout3, UIInfiniteAnimType.Normal)
    -- tlua32 = UIInfiniteUtil:AddUIInfiniteAnim(layout3, UIInfiniteAnimType.MoveUp, nil, false)

    CSAPI.SetGOActive(mask, true)

    anim_txtStar1 = ComUtil.GetCom(txtStar1, "ActionBase")

    CSAPI.PlayUISound("ui_popup_open")
end

-- function Update()
--     if (timer and Time.time > timer) then
--         timer = Time.time + 1
--         local resetTime = nil
--         if (GetTypeIndex() == eTaskType.Daily) then
--             resetTime = MissionMgr:GetInfos() and MissionMgr:GetInfos().dailyResetTime or nil
--         elseif (GetTypeIndex() == eTaskType.Weekly) then
--             resetTime = MissionMgr:GetInfos() and MissionMgr:GetInfos().weeklyResetTime or nil
--         end
--         if (resetTime and TimeUtil:GetTime() >= resetTime) then
--             resetTime = nil
--             MissionMgr:Clear()
--             MissionMgr:GetResetTaskInfo()
--             MissionMgr:GetTasksData()
--             view:Close()
--         end
--     end
-- end

function LayoutCallBack1(index)
    local lua = layout1:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data)
    end
end
function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = curDatas2[index]
        lua.Refresh(_data, cur)
    end
end
function LayoutCallBack3(index)
    local lua = layout3:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data, cur >= max)
    end
end

function OnInit()
    UIUtil:AddTop2("MissionView", gameObject, function()
        view:Close()
    end)

    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Mission_List, function(_data)
        if (not _data) then
            RefreshPanel()
            return
        end
        -- local type = _data[1]
        local rewards = _data[2]
        -- if(type == eTaskType.Daily or type == eTaskType.Weekly) then
        -- 	--做动画再刷新界面
        -- 	SetList23Anim(type, rewards)
        -- else
        RefreshPanel()
        if (#rewards > 0) then
            UIUtil:OpenReward({rewards})
        end
        -- end
    end)
    -- eventMgr:AddListener(EventType.Mission_Tab_Sel, function(index)
    --     leftPanel.Item1Select(index)
    -- end)

    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)

    eventMgr:AddListener(EventType.Mission_ReSet, function ()
        view:Close() --任务重置，关闭界面
    end)
end

function OnDisable()
    eventMgr:ClearListener()
end

function OnOpen()
    -- isShowActivity = MissionMgr:CheckHadActivity() --暂无活动
    -- CSAPI.PlayUISound("ui_generic_click") --与点击音重叠
    InitIndex()
    InitLeftPanel()
    RefreshPanel()
end

function InitIndex()
    if (openSetting == nil) then
        curIndex1, curIndex2 = MissionMgr:GetSelTabIndex()
    else
        curIndex1, curIndex2 = GetIndexs()
    end
end

-- ==============================--
-- desc:初始化侧边栏  
-- 需要RefreshPanel方法，响应侧边按钮点击回调
-- leftPanel.Select()播放动画过程
-- SetRed()可按照需求自定义实现
-- time:2022-04-22 03:24:35
-- @return
-- ==============================--
function InitLeftPanel()
    if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", leftPoint.transform)
        leftPanel = ComUtil.GetLuaTable(go)
    end
    local leftDatas = {{6009, "Mission/btn_1_02"}, {6008, "Mission/btn_1_01"}} -- 多语言id，需要配置英文
    local leftChildDatas = {{6003, 6004}, {6001, 6002}} -- 子项多语言，需要配置英文
    leftPanel.Init(this, leftDatas, leftChildDatas)
end

function RefreshPanel()
    MissionMgr:SetSelTabIndex(curIndex1, curIndex2)
    SetRight()
    if (curIndex1 == 1) then
        SetStars()
        SetTime()
        -- SetCount()
    end
    SetBtn()

    -- 侧边动画
    leftPanel.Anim()
    -- 红点
    SetRed()
end

-- 红点添加或者移除
function SetRed()
    for i, v in ipairs(leftPanel.leftItems) do
        local _datas = i == 2 and  {eTaskType.Main, eTaskType.Sub}  or {eTaskType.Daily, eTaskType.Weekly} 
        local isRed = MissionMgr:CheckRed(_datas)
        v.SetRed(isRed)
    end
    for i, v in ipairs(leftPanel.leftChildItems) do
        for k, m in ipairs(v) do
            local isRed = false
            if (i == 2) then
                isRed = MissionMgr:CheckRed({k})
            else
                isRed = MissionMgr:CheckRed({k + 2})
            end
            m.SetRed(isRed)
        end
    end
end

function GetIndexs()
    if (openSetting) then
        if (openSetting == eTaskType.Main) then
            return 2, 1
        elseif (openSetting == eTaskType.Sub) then
            return 2, 2
        elseif (openSetting == eTaskType.Daily) then
            return 1, 1
        elseif (openSetting == eTaskType.Weekly) then
            return 1, 2
        end
    end
    return 1, 1
end

function GetTypeIndex()
    if (curIndex1 == 1) then
        return curIndex2 + 2
    end
    return curIndex2
end

function SetRight()
    CSAPI.SetGOActive(panel1, curIndex1 == 2)
    CSAPI.SetGOActive(panel2, curIndex1 == 1)
    curDatas = MissionMgr:GetArr({GetTypeIndex()},curIndex1==1)
    RefreshList(GetTypeIndex())
end

function RefreshList(index)
    local isAnimAgain = false
    -- 是否刷新不同页签
    if (oldIndex and oldIndex ~= index) then
        isAnimAgain = true
        CSAPI.SetGOActive(mask, true)
    end
    oldIndex = index
    local posIndex = 0 -- 0：保持原位置，1：初始位置
    if (curIndex1 == 2) then
        if (isAnimAgain) then
            tlua1:AnimAgain()
            posIndex = 1
        end
        layout1:IEShowList(#curDatas, AnimEnd)
    end
    if (curIndex1 == 1) then
        cur, max = MissionMgr:GetDayStars(index)
        curDatas2 = MissionMgr:GetLArr(index)
        if (isAnimAgain) then
            tlua2:AnimAgain()
            tlua3:AnimAgain()
            posIndex = 1
        end
        layout2:IEShowList(#curDatas2, nil, posIndex)
        layout3:IEShowList(#curDatas, AnimEnd, posIndex)
    end
end

-- 动画完成解除锁屏
function AnimEnd()
    CSAPI.SetGOActive(mask, false)
end

function SetStars()
    CSAPI.SetText(txtStar1, cur .. "")
    CSAPI.SetText(txtStar2, "/" .. max)
end

function SetTime()
    local str = ""
    if (GetTypeIndex() == eTaskType.Daily) then
        local time = MissionMgr:GetInfos() and MissionMgr:GetInfos().dailyResetTime or 0
        local timeData = TimeUtil:GetTimeHMS(time, "*t")
        str = string.format(LanguageMgr:GetByID(6005), timeData["hour"])
    else
        local time = MissionMgr:GetInfos() and MissionMgr:GetInfos().weeklyResetTime or 0
        local week, timeData = TimeUtil:GetWeekDay(time)
        local str1 = LanguageMgr:GetByID(week + 1007)
        str = string.format(LanguageMgr:GetByID(6006), str1, timeData["hour"])
    end
    CSAPI.SetText(txtTime, str)

    timer = Time.time + 1
end

function SetBtn()
    isHad = false
    for i, v in ipairs(curDatas) do
        local get = v:IsGet()
        local finish = v:IsFinish()
        if (not get and finish) then
            isHad = true
            break
        end
    end
    -- 如果当天/周奖励已经全部领取
    if (curIndex1 == 1 and cur >= max) then
        isHad = false
    end
    -- CSAPI.SetGOActive(imgGetAll, isHad)
    local canvasGroup = ComUtil.GetCom(btnGetAll, "CanvasGroup")
    canvasGroup.alpha = isHad and 1 or 0.3
end

function OnClickGetAll()
    if (isHad) then
        TaskProto:GetRewardByType(GetTypeIndex())
    end
end

----------------------------------额外动画的实现-------------------------------------------
function OnViewOpened(viewKey)
    if (viewKey == "RewardPanel") then
        if (curIndex1 == 2) then
            layout1:IEShowList(0)
        else
            layout2:IEShowList(0)
            layout3:IEShowList(0)
        end
    end
end

function OnViewClosed(viewKey)
    if (viewKey == "RewardPanel") then
        if (curIndex1 == 2) then
            CSAPI.SetGOActive(mask, true)
            tlua1:AnimAgain()
            layout1:IEShowList(#curDatas, AnimEnd)
        else
            CSAPI.SetGOActive(mask, true)
            tlua2:AnimAgain()
            layout2:IEShowList(#curDatas2, nil)
            tlua3:AnimAgain()
            layout3:IEShowList(#curDatas, AnimEnd)
        end
    end
end
