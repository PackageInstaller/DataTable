function OnOpen()
    curData = RogueSMgr:GetData(data)
    RefreshPanel()
end

function RefreshPanel()
    local _datas = curData:GetCfg().globalBuffs or {}
    items = items or {}
    ItemUtil.AddItems("RogueS/RogueSBuffDetailItem", items, _datas, Content)
    CSAPI.SetGOActive(noneObj, #_datas <= 0)

end

function OnClickMask()
    view:Close()
end


---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
