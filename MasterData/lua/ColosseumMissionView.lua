curIndex1, curIndex2 = 1, 1 -- 父index,子index
local isShowActivity = false
local timer = nil

function Awake()
    layout1 = ComUtil.GetCom(vsv1, "UIInfinite")
    layout1:Init("UIs/Mission/MissionItem1", LayoutCallBack1, true)
    tlua1 = UIInfiniteUtil:AddUIInfiniteAnim(layout1, UIInfiniteAnimType.Normal)

    CSAPI.SetGOActive(mask, true)

    CSAPI.PlayUISound("ui_popup_open")
end

function LayoutCallBack1(index)
    local lua = layout1:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data)
    end
end

function OnInit()
    UIUtil:AddTop2("ColosseumMissionView", gameObject, function()
        view:Close()
    end)

    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Mission_List, function(_data)
        if (not _data) then
            RefreshPanel()
            return
        end
        local rewards = _data[2]
        RefreshPanel()
        if (#rewards > 0) then
            UIUtil:OpenReward({rewards})
        end
        -- end
    end)

    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)

    eventMgr:AddListener(EventType.Mission_ReSet, function()
        view:Close() -- 任务重置，关闭界面
    end)
end

function OnDisable()
    eventMgr:ClearListener()
end

function OnOpen()
    InitIndex()
    InitLeftPanel()
    RefreshPanel()
end

function InitIndex()
    if (openSetting == nil) then
        curIndex1 = ColosseumMgr:GetSelTabIndex()
    else
        curIndex1 = openSetting
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
    local leftDatas = {{64002, "Mission/img_09_01"}, {64003, "Mission/img_09_02"}, {64038, "Mission/img_09_03"}} -- 多语言id，需要配置英文
    local leftChildDatas = {} -- 子项多语言，需要配置英文
    leftPanel.Init(this, leftDatas, leftChildDatas)
end

function RefreshPanel()
    ColosseumMgr:SetSelTabIndex(curIndex1)
    SetRight()
    SetBtn()

    -- 侧边动画
    leftPanel.Anim()
    -- 红点
    SetRed()
end

-- 红点添加或者移除
function SetRed()
    for i, v in ipairs(leftPanel.leftItems) do
        local isRed = false
        if (i <= 2) then
            isRed = MissionMgr:CheckRed2(eTaskType.AbattoirMoon, i)
        else
            isRed = MissionMgr:CheckRed({eTaskType.AbattoirSeason})
        end
        v.SetRed(isRed)
    end
end

function SetRight()
    curDatas = {}
    if (curIndex1 == 3) then
        curDatas = MissionMgr:GetArr({eTaskType.AbattoirSeason}, true)
    else
        local _curDatas = MissionMgr:GetArr({eTaskType.AbattoirMoon}, true)
        for k, v in ipairs(_curDatas) do
            if (v:GetCfg().nGroup == curIndex1) then
                table.insert(curDatas, v)
            end
        end
    end
    local isAnimAgain = false
    if (oldIndex and oldIndex ~= curIndex1) then
        tlua1:AnimAgain()
        CSAPI.SetGOActive(mask, true)
    end
    oldIndex = curIndex1
    layout1:IEShowList(#curDatas, AnimEnd)
end

-- 动画完成解除锁屏
function AnimEnd()
    CSAPI.SetGOActive(mask, false)
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
    local canvasGroup = ComUtil.GetCom(btnGetAll, "CanvasGroup")
    canvasGroup.alpha = isHad and 1 or 0.3
end

function OnClickGetAll()
    if (isHad) then
        if (curIndex1 <= 2) then
            TaskProto:GetRewardByType(eTaskType.AbattoirMoon, curIndex1)
        else
            TaskProto:GetRewardByType(eTaskType.AbattoirSeason)
        end
    end
end

----------------------------------额外动画的实现-------------------------------------------
function OnViewOpened(viewKey)
    if (viewKey == "RewardPanel") then
        layout1:IEShowList(0)
    end
end

function OnViewClosed(viewKey)
    if (viewKey == "RewardPanel") then
        CSAPI.SetGOActive(mask, true)
        tlua1:AnimAgain()
        layout1:IEShowList(#curDatas, AnimEnd)
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end

