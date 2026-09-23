function SetIndex(_index)
    index = _index
end
function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    data = _data
    if (index == 1) then
        CSAPI.SetText(txtName, data:GetCfg().name)
        CSAPI.SetGOActive(lock, false)
        CSAPI.SetGOAlpha(clickNode, 1)
        CSAPI.LoadImg(imgColor, "UIs/RogueT/img_38_01.png", true, nil, true)
    else
        local cfg = Cfgs.MainLine:GetByID(data:GetInfinityID())
        local isPass = data:CheckInfinityIsPass()
        CSAPI.SetText(txtName, cfg.name)
        CSAPI.SetGOActive(lock, not isPass)
        CSAPI.SetGOAlpha(clickNode, isPass and 1 or 0.5)
        CSAPI.LoadImg(imgColor, "UIs/RogueT/img_39_01.png", true, nil, true)
    end
end

function OnClick()
    if (cb) then
        cb(index)
    end
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
