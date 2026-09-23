local currIndex = 1
local datas = nil
local items = nil
local currItem = nil
local layout = nil
local datas2 = nil
local stage = 0
local top = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/VirtualCataclysm/VirtualCataclysmSweepItem2", LayoutCallBack, true)
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.VirtualCataclysm_Panel_Update,OnPanelRefresh)
    eventMgr:AddListener(EventType.VirtualCataclysm_Save_Update,OnPanelRefresh)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = datas2[index]
        lua.SetIndex(index)
        lua.Refresh(_data,{isKill = currItem.IsKill()})
    end
end

function OnPanelRefresh()
    RefreshPanel()
end

function OnDestroy()
    CSAPI.SetGOActive(top.btn_home,true)
    eventMgr:ClearListener()
end

function OnInit()
    top = UIUtil:AddTop2("VirtualCataclysmSweep", topParent, OnClickClose);
    CSAPI.SetGOActive(top.btn_home,false)
end

function OnOpen()
    stage = VirCatMgr:GetStage()
    InitPanel()
end

function InitPanel()
    SetDatas()
    SetCurrIndex()
    SetItems()
end

function SetCurrIndex()
    if datas and #datas > 0 then
        for i, v in ipairs(datas) do
            if not v:IsPass() then
                currIndex = i
                break
            end
        end
    end
end

function RefreshPanel()
    SetTopPanel()
    SetBottomPanel()
end

function SetTopPanel()
    SetDatas()
    SetItems()
end

function SetDatas()
    datas = VirCatMgr:GetArr(stage)
end

function SetItems()
    items = items or {}
    ItemUtil.AddItems("VirtualCataclysm/VirtualCataclysmSweepItem",items,datas,topGrid,OnItemClickCB,1,nil,OnItemLoadSuccess)
end

function OnItemClickCB(item)
    if currItem and currItem.index == item.index then
        return
    end
    if currItem then
        currItem.SetSelect(false)
    end

    currItem = item
    currItem.SetSelect(true)

    SetBottomPanel()
end

function OnItemLoadSuccess()
    if isFirst then
        return
    end
    isFirst = true
    if items[currIndex] then
        items[currIndex].OnClick()
    end
end

function SetBottomPanel()
    SetBossName()
    SetDatas2()
    SetItems2()
end

function SetBossName()
    if currItem then
        CSAPI.SetText(txtTitle,currItem.GetName())
    end
end

function SetDatas2()
    datas2 = VirCatMgr:GetSaveArr(currItem.GetID())
end

function SetItems2()
    layout:IEShowList(#datas2)
end

function OnClickClose()
    view:Close()
end