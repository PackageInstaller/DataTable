local datas = nil
local items=  nil
local closeCB = nil
local selIndex = nil
local sureIndex = nil

function OnInit()
    UIUtil:AddTop2("Trials2Skill", topObj, OnClickReturn);
end

function OnDestroy()
    if closeCB and sureIndex then
        closeCB(datas[sureIndex].id)
    end
end

function OnOpen()
    if data then
        datas =data.datas
        closeCB = data.closeCallBack
        CSAPI.SetGOAlpha(btnSure,0.5)
        SetItems()
    end
end

function SetItems()
    items = items or {}
    ItemUtil.AddItems("Trials2/Trials2SkillItem",items,datas,itemParent,OnItemClickCB)
end

function OnItemClickCB(item)
    if selIndex then
        items[selIndex].SetSelect(false)
    end
    if item.index == selIndex then
        selIndex = nil
        CSAPI.SetGOAlpha(btnSure,0.5)
        return
    end
    selIndex = item.index
    item.SetSelect(true)
    CSAPI.SetGOAlpha(btnSure,1)
end

function OnClickSure()
    if not selIndex then
        return
    end
    sureIndex = selIndex
    view:Close()
end

function OnClickBack()
    if not selIndex then
        return
    end
    items[selIndex].SetSelect(false)
    CSAPI.SetGOAlpha(btnSure,0.5)
    selIndex = nil
end

function OnClickReturn()
    view:Close()
end