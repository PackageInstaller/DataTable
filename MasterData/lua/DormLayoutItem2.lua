local oldSelect = false

function Awake()
    action_go = ComUtil.GetCom(gameObject, "ActionBase")
end

function SetClickCB(_cb)
    cb = _cb
end
function Refresh(_data, _elseData)
    data = _data
    isSelect = (_data.id - 1) == _elseData
    CSAPI.SetText(txtName, _data.sName)
    if (isSelect) then
        CSAPI.SetGOActive(objSelect, isSelect)
    end
    -- icon 
    CSAPI.LoadImg(icon, "UIs/Dorm2/furniture_2_0" .. (data.id - 1) .. ".png", true, nil, true)

    -- 动画 
    if ((not oldSelect and isSelect) or (oldSelect and not isSelect)) then
        local txtLen = CSAPI.GetTextWidth(txtName, 30, _data.sName)
        local x = txtLen + 79
        local x1 = isSelect and 58 or x
        local x2 = isSelect and x or 58
        UIUtil:SetObjSizeDelta(gameObject, x1, x2, 56, 56, function()
            if (x2 < x1) then
                CSAPI.SetGOActive(objSelect, false)
            end
        end, 300)
    end
    oldSelect = isSelect
end

function OnClick()
    if (not isSelect) then
        cb(data.id - 1)
    end
end
