local id

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_id, _curId)
    id = _id
    isSelect = _id == _curId
    local cfg = Cfgs.CfgCardPropertyEnum:GetByID(id)

    -- bg 
    local bgName = isSelect and "btn_01_02.png" or "btn_01_01.png"
    CSAPI.LoadImg(bg, "UIs/Sort/" .. bgName, false, nil, true)
    -- text 
    CSAPI.SetText(txtName, cfg.sName)
    local code1 = isSelect and "ffc146" or "929296"
    CSAPI.SetTextColorByCode(txtName, code1)
end

function OnClick()
    if (not isSelect) then
        cb(id)
    end
end
