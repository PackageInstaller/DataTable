local datas = {}
local items = nil
local selBuff = nil
local currItem = nil

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.VirtualCataclysm_Panel_Update,OnPanelRefresh)
    InitAnim()
end

function OnPanelRefresh()
    selBuff = VirCatMgr:GetSelectBuff()
    SetDatas()
    SetItems()
    if #items > 0 then
        for i, v in ipairs(items) do
            if selBuff == v.GetBuffID() then
                v.OnClick()
                break
            end
        end
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    InitPanel()
end

function InitPanel()
    selBuff = VirCatMgr:GetSelectBuff()
    SetDatas()
    SetItems()
end

function SetDatas()
    datas = VirCatMgr:GetBuffArr()
end

function SetItems()
    items = items or {}
    ItemUtil.AddItems("VirtualCataclysm/VirtualCataclysmBuffItem", items, datas, itemParent, OnItemClickCB, 1, nil,
        OnItemLoadSuccess)
end

function OnItemClickCB(item)
    if currItem and currItem.index == item.index then
        return
    end
    if currItem then
        currItem.SetSelAnim(false)
    end

    currItem = item
    currItem.SetSelAnim(true)
    selBuff = currItem.GetBuffID()
end

function OnItemLoadSuccess()
    if isFirst then
        return
    end
    isFirst = true
    FuncUtil:Call(function()
        if #items > 0 then
            for i, v in ipairs(items) do
                if selBuff == v.GetBuffID() then
                    v.OnClick()
                    break
                end
            end
        end
    end, this, 500)
    PlayAnim(500)
end

function OnClickSure()
    CrossBossProto:ChooseFinalBuff(VirCatMgr:GetActiveId(), selBuff, OnTryShowInfo)
end

function OnTryShowInfo(proto)
    if proto and proto.isok then
        if data and data.okCallBack then
            data.okCallBack()
        end
        OnClickClose()
    end
end

function OnClickClose()
    view:Close()
end

function InitAnim()
    CSAPI.SetGOActive(animMask, false)
end

function PlayAnim(delay)
    CSAPI.SetGOActive(animMask, true)
    FuncUtil:Call(function()
        CSAPI.SetGOActive(animMask, false)
    end, this, delay)
end
