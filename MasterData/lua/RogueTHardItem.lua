function SetIndex(_index)
    index = _index
end
function SetClickCB(_cb)
    cb = _cb
end

function Refresh(data)
    CSAPI.SetText(txtName, data:GetCfg().hard .. "")
end

function OnClick()
    cb(index)
end

function SetColor(isM)
    --CSAPI.SetGOActive(line, isM)
    CSAPI.SetTextColorByCode(txtName, isM and "ffc146" or "AAA69E")
end

--------------------------------------------------------------
function GetIndex()
    return index
end

function SetSelect(isSelect)

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
    CSAPI.SetScale(clickNode, s, s, s)
end

function GetPos()
    local pos = {100000, 100000, 0}
    local x, y, z = CSAPI.GetPos(clickNode)
    pos = {x, y, z}
    return pos
end
--------------------------------------------------------------
