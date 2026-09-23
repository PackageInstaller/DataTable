local datas = nil
local layout = nil
local selIndex = 1
local panels = {}
local currPanel = nil
local time, endTime, timer = 0, 0, 0

function Awake()
    layout = ComUtil.GetCom(vsv, "UISV")
    layout:Init("UIs/SkinPassList/SkinPassListItem", LayoutCallBack, true)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Update_Everyday, OnPanelRefresh)
    eventMgr:AddListener(EventType.SkinPass_Update, OnPanelRefresh)
    eventMgr:AddListener(EventType.RedPoint_Refresh,OnRedRefresh)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index);
    if lua then
        local _data = datas[index];
        lua.SetClickCB(OnItemClickCB)
        lua.SetIndex(index)
        lua.SetSelect(index == selIndex)
        lua.Refresh(_data)
    end
end

function OnItemClickCB(item)
    if item.index == selIndex then
        return
    end
    local selItem = layout:GetItemLua(selIndex)
    if selItem then
        selItem.SetSelect(false)
    end

    selIndex = item.index
    item.SetSelect(true)

    RefreshPanel()
end

function OnPanelRefresh()
    datas = OperationActivityMgr:GetSkinPassArr()
    if #datas <= 0 then
        UIUtil:ToHome()
        return 
    end
    selIndex = selIndex > #datas and 1 or selIndex
    SetLeft()
    RefreshPanel()
end

function OnRedRefresh()
    SetRed()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("SkinPassList", topParent, OnClickBack)
end

function OnOpen()
    datas = OperationActivityMgr:GetSkinPassArr()
    CheckJumpState()
    SetLeft()
    RefreshPanel()
    SetNew()
end

function CheckJumpState()
    if data and data.dungeonId then
        if #datas > 0 then
            for i, v in ipairs(datas) do
                if v:HasDungeon(data.dungeonId) then
                    selIndex = i
                    break
                end
            end
        end
    end
end

function SetLeft()
    layout:IEShowList(#datas,nil, selIndex)
end

function RefreshPanel()
    if currPanel then
        UIUtil:SetObjFade(currPanel.gameObject, 1, 0, function()
            CSAPI.SetGOActive(currPanel.gameObject, false)
            SetRight()
        end, 200)
    else
        SetRight()
    end
    SetRed()
end

function SetRight()
    if datas[selIndex] then
        local id = datas[selIndex]:GetID()
        if not id then
            return
        end
        if panels[tostring(id)] then
            currPanel = panels[tostring(id)]
            CSAPI.SetGOActive(currPanel.gameObject, true)
            panels[tostring(id)].Refresh(datas[selIndex])
            UIUtil:SetObjFade(currPanel.gameObject, 0, 1, nil, 200)
        else
            ResUtil:CreateUIGOAsync("SkinPassList/SkinPassView", rightParent, function(go)
                local lua = ComUtil.GetLuaTable(go)
                lua.Refresh(datas[selIndex])
                currPanel = lua
                UIUtil:SetObjFade(currPanel.gameObject, 0, 1, nil, 200)
                panels[tostring(id)] = lua
            end)
        end
    end
end

function SetRed()
    if datas and #datas> 0 then
        local lua = nil
        for i, v in ipairs(datas) do
            lua = layout:GetItemLua(i)
            if lua then
                lua.SetRed()
            end
        end
    end
end

function SetNew()
    if OperationActivityMgr:IsSkinPassNew() then
        OperationActivityMgr:SaveSkinPassNew()
        RedPointMgr:ApplyRefresh()
    end
end

function OnClickBack()
    view:Close()
end
