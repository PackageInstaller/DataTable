local panelNames = {"HeadFramePanel1", "HeadFramePanel2", "HeadFramePanel3", "HeadFramePanel4"}
local panels = {}
local curPanel
local curIndex

function Awake()
    tab = ComUtil.GetCom(tab, "CTab")
    tab:AddSelChangedCallBack(OnTabChanged)
    -- 红点刷新
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RedPoint_Refresh, SetRed)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    tab.selIndex = openSetting or 0
end

function OnTabChanged(_index)
    if (curIndex and curIndex == _index) then
        return
    end
    curIndex = _index

    if (curPanel) then
        CSAPI.SetAnchor(curPanel.gameObject, 0, 10000, 0)
    end
    if (panels[curIndex + 1]) then
        curPanel = panels[curIndex + 1]
        CSAPI.SetAnchor(curPanel.gameObject, 0, 0, 0)
        curPanel.Refresh()
    else
        ResUtil:CreateUIGOAsync("HeadFrame/" .. panelNames[curIndex + 1], bg, function(go)
            local lua = ComUtil.GetLuaTable(go)
            panels[curIndex + 1] = lua
            curPanel = lua
            curPanel.Refresh()
        end)
    end
    SetRed()
    --
    CSAPI.SetGOActive(imgR, curIndex ~= 3)
end

function SetRed()
    -- red 1
    local _pData1 = RedPointMgr:GetData(RedPointType.HeadFrame)
    UIUtil:SetRedPoint(page1, _pData1 ~= nil, 112, 21, 0)
    -- red 2
    local _pData2 = RedPointMgr:GetData(RedPointType.Head)
    UIUtil:SetRedPoint(page2, _pData2 ~= nil, 112, 21, 0)
    -- red 3
    local _pData3 = RedPointMgr:GetData(RedPointType.Title)
    UIUtil:SetRedPoint(page3, _pData3 ~= nil, 112, 21, 0)
    -- red 4
    local _pData4 = RedPointMgr:GetData(RedPointType.Face)
    UIUtil:SetRedPoint(page4, _pData4 ~= nil, 112, 21, 0)
end

function OnClickClose()
    view:Close()
end

---返回虚拟键公共接口
function OnClickVirtualkeysClose()
    view:Close()
end
