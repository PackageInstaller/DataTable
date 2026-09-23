function SetClickCB(_cb)
    cb = _cb
end
function SetIndex(_index)
    index = _index
end

function Refresh(_num)
    num = _num

    -- num
    CSAPI.SetText(txtNum, num .. "")
end

function SetSelect(isSelect)
    local code = isSelect and "ffc146" or "FFFFFF"
    CSAPI.SetImgColorByCode(line, code)
    CSAPI.SetTextColorByCode(txtNum, code)
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


function OnClick()
    if cb then
        cb(index)
    end
end
