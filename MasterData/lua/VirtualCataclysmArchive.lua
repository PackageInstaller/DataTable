local selIndex,curIndex = 0,1
local datas = nil
local layout = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/VirtualCataclysm/VirtualCataclysmArchiveItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = datas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        -- lua.SetClickCB2(OnItemClickCB2)
        lua.Refresh(_data)
        lua.SetSelect(index == curIndex)
    end
end

function OnItemClickCB(item)
    if item.index == selIndex then
        return
    end
    local lua = layout:GetItemLua(selIndex)
    if lua then
        lua.SetSelect(false)
    end
    item.SetSelect(true)
    selIndex = item.index
    curIndex = item.index

    SetButtonState()
end

function OnItemClickCB2(item)
    -- if item.index == selIndex then
    --     local dialogData = {}
    --     dialogData.content = LanguageMgr:GetByID(380074)
    --     dialogData.okCallBack = function()
    --         CrossBossProto:CrossBossModSave(VirCatMgr:GetActiveId(),data.nodeId,item.GetDataIndex(),OnSaveCallBack)
    --     end
    --     CSAPI.OpenView("Dialog",dialogData)
    -- end
end

function OnSaveCallBack()
    OnClickClose()
end

function OnOpen()
    if data then
        SetDatas()
        SetItems()
        SetButtonState()
    end
end

function SetDatas()
    datas = VirCatMgr:GetSaveArr(data.nodeId)
end

function SetItems()
    layout:IEShowList(#datas,OnItemLoadSuccess)
end

function OnItemLoadSuccess()
    local lua = layout:GetItemLua(curIndex)
    if lua then
        lua.OnClick()
    end
end

function SetButtonState()
    CSAPI.SetGOAlpha(btnReplace,selIndex > 0 and 1 or 0.5)
end

function OnClickClose()
    if data and data.closeCallBack then
        data.closeCallBack()
    end
    VirCatMgr:RemoveSaveData(data.nodeId,4)
    view:Close()
end

function OnClickReplace()
    if selIndex <= 0 then
        return
    end
    local _data = datas[selIndex]
    if _data then
        local dialogData = {}
        dialogData.content = LanguageMgr:GetByID(380074)
        dialogData.okCallBack = function()
            CrossBossProto:CrossBossModSave(VirCatMgr:GetActiveId(),data.nodeId,_data:GetIndex(),OnSaveCallBack)
        end
        CSAPI.OpenView("Dialog",dialogData)
    end
end