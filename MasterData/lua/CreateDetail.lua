-- local mTab = nil
-- local curIndex = 0
curIndex1, curIndex2 = 1, 1 -- 父index,子index

-- function Awake()
--     mTab = ComUtil.GetCom(lGrid, "CTab")
--     mTab:AddSelChangedCallBack(OnTabChanged)
-- end
-- function OnTabChanged(index)
--     curIndex = index
--     RefreshPanel()
-- end

function OnInit()
    UIUtil:AddTop2("CreateDetail", gameObject, function()
        view:Close()
    end, nil, {})

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
end
function OnDestroy()
    eventMgr:ClearListener()
end
function OnViewOpened(viewKey)
    if (viewKey == "RoleInfo") then
        CSAPI.SetAnchor(gameObject, 0, 10000, 0)
    end
end
function OnViewClosed(viewKey)
    if (viewKey == "RoleInfo") then
        CSAPI.SetAnchor(gameObject, 0, 0, 0)
    end
end

function OnOpen()
    -- mTab.selIndex = 0
    InitLeftPanel()
    RefreshPanel()
end

function InitLeftPanel()
    if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", leftPoint.transform)
        leftPanel = ComUtil.GetLuaTable(go)
    end
    local leftDatas = {{17058, "Create/btn_11_01"}, {17057, "Create/btn_10_01"}, {17059, "Create/btn_12_01"}} -- 多语言id，需要配置英文
    local leftChildDatas = {} -- 子项多语言，需要配置英文
    leftPanel.Init(this, leftDatas, leftChildDatas)
end

function RefreshPanel()
    -- 侧边动画
    leftPanel.Anim()

    if (curPanelGO) then
        SetCruGOActive(false)
    end
    if (curIndex1 == 1) then
        SetProb() -- 概率
    elseif (curIndex1 == 2) then
        SetRule()
    else
        SetRecord()
    end

    CSAPI.SetGOActive(Image1, curIndex1 == 1)
    CSAPI.SetGOActive(Image2, curIndex1 == 2)
    CSAPI.SetGOActive(Image3, curIndex1 == 3)
end

function SetRule()
    --
    local ruleIDs = data:GetCfg().cardRule
    ruleItems = ruleItems or {}
    ItemUtil.AddItems("Create/CreaterRuleItem", ruleItems, ruleIDs, ruleGrid,nil,1, data:GetCfg().sName)
    --
    curPanelGO = sr
    SetCruGOActive(true)
end

function SetProb()
    if (not probPanel) then
        ResUtil:CreateUIGOAsync("Create/CreateInfoPanel", panelParent, function(go)
            probPanel = ComUtil.GetLuaTable(go)
            probPanel.Refresh(data)
            curPanelGO = go
        end)
    else
        curPanelGO = probPanel.gameObject
        SetCruGOActive(true)
    end
end

function SetRecord()
    if (not recordPanel) then
        PlayerProto:GetCreateCardLogs(data:GetCfg().id, 0, function(proto)
            CreateRecordPanel(proto)
        end)
    else
        curPanelGO = recordPanel.gameObject
        SetCruGOActive(true)
    end
end
function CreateRecordPanel(proto)
    ResUtil:CreateUIGOAsync("Create/CreateRecord", panelParent, function(go)
        recordPanel = ComUtil.GetLuaTable(go)
        recordPanel.Refresh(proto)
        curPanelGO = go
    end)
end

function SetCruGOActive(b)
    if (curPanelGO) then
        CSAPI.SetGOActive(curPanelGO, b)
    end
end
