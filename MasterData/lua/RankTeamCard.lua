function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    data = _data
    card = data.isEmpty and {} or data:GetCard()
    SetAssist()
    SetItem()
end

function SetAssist()
    CSAPI.SetGOActive(assistImg,index == 6)
end

function SetItem()
    if item == nil then
        ResUtil:CreateUIGOAsync("RoleLittleCard/RoleLittleCard",itemParent,function (go)
            item= ComUtil.GetLuaTable(go)
            item.SetClickCB(cb)
            item.Refresh(card,{disDrag = true})
            item.SetFormation(nil,true)
            item.SetCanClick(true)
        end)
    else
        item.SetClickCB(cb)
        item.Refresh(card,{disDrag = true})
        item.SetFormation(nil,true)
        item.SetCanClick(true)
    end
end

-- function OnClick()
--     if cb then
--         cb(this)
--     end
-- end