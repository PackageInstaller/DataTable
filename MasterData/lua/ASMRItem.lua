function SetIndex(_index)
    index = _index
end
function SetClickCB(_cb)
    cb = _cb
end

function Awake()
end

function Refresh(_data, _isFirst1)
    data = _data
    local cfg = data:GetCfg()
    -- name 
    CSAPI.SetText(txtName, cfg.name)
    -- cv
    CSAPI.SetText(txtCV, cfg.cvName)
    -- icon
    ResUtil.ASMR:Load(icon, cfg.icon)
    --
    if (not _isFirst1) then
        SetAnimFirst()
    end
end

function SetAnimFirst()
    if (index == 1) then
        UIUtil:SetPObjMove(L, 80, 0, 0, 0, 0, 0, nil, 480, 1)
        UIUtil:SetPObjMove(R, -80, 0, 0, 0, 0, 0, nil, 480, 1)
    else
        UIUtil:SetPObjMove(L, -80, 0, 0, 0, 0, 0, nil, 640, 1)
        UIUtil:SetPObjMove(R, -80, 0, 0, 0, 0, 0, nil, 640, 1)
        UIUtil:SetObjFade(alphaNode, 0, 1, nil, 300, 1, 0)
    end
end

function SetSelect(b)
    -- local imgName = b and "img_01_05.png" or "img_01_03.png"
    -- CSAPI.LoadImg(imgLight, "UIs/ASMR/" .. imgName, true, nil, true)
    -- CSAPI.SetGOActive(imgLight, not b)
    -- CSAPI.SetGOActive(cone_01, b)
    CSAPI.SetGOAlpha(imgLight, not b and 1 or 0)
    CSAPI.SetGOAlpha(cone_01, b and 1 or 0)
end

function SetPush(isPush, curIndex)
    if (isPush) then
        local x = index > curIndex and 150 or -150
        UIUtil:SetPObjMove(alphaNode, 0, x, 0, 0, 0, 0, nil, 800, 1)
    else
        CSAPI.SetAnchor(alphaNode, 0, 0, 0)
    end
end

--------------------------------------------------------------
function OnClick()
    if cb then
        cb(index)
    end
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
    CSAPI.SetGOAlpha(alphaNode, s)
end

function GetPos()
    local pos = {100000, 100000, 0}
    local x, y, z = CSAPI.GetPos(alphaNode)
    pos = {x, y, z}
    return pos
end

------------------------------------------------------------

function SelectAnim(isSelect)
    local form = isSelect and 1 or 0
    local to = isSelect and 0 or 1
    UIUtil:SetObjFade(imgLight, form, to, nil, 520, 0, form)
    UIUtil:SetObjFade(cone_01, to, form, nil, 520, 0, to)
end
