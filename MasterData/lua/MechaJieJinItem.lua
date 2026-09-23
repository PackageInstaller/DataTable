function SetClickCB(_cb)
    cb = _cb
end

function SetIndex(_index)
    index = _index
end

function Refresh(_data)
    data = _data
    -- icon
    SetSIcon()
    -- open
    CSAPI.SetGOActive(hasObj, not data:CheckIsOpen())
    -- use 
    --CSAPI.SetGOActive(useObj, data:CheckIsUse())
    --name
    CSAPI.SetText(txt_name, data:GetName())
    -- set 
    CSAPI.SetText(txt_set, data:GetSetStr())
end

function SetSIcon()
    local cfgModel = Cfgs.character:GetByID(data:GetModelID())
    ResUtil.CardIcon:Load(icon, cfgModel.Card_head, true)
end

function SetSelect(isSelect)
    CSAPI.SetGOActive(selectObj, isSelect)
    CSAPI.SetGOActive(border, not isSelect)
    SetAlpha(isSelect and 1 or 0.5)
end
function SetAlpha(val)
    CSAPI.SetGOAlpha(alphaNode, val)
end

function OnClickSelf()
    if cb then
        cb(index)
    end
end

function GetIndex()
    return index
end

function SetSibling(index)
    index = index or 0
    if index == -1 then
        transform:SetAsLastSibling()
    else
        transform:SetSiblingIndex(index)
    end
end

-- 根据X轴距离设置大小
function SetScale(s)
    CSAPI.SetScale(alphaNode, s, s, s)
end

function GetPos()
    local pos = {100000, 100000, 0}
    local x, y, z = CSAPI.GetPos(alphaNode)
    pos = {x, y, z}
    return pos
end
