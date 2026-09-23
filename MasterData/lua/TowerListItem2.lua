local data = nil
local currLevel = 1
local isLock = false
local lockStr = ""
local isSel = false

function Awake()
    SetSelect(false)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _elseData)
    data = _data
    currLevel = _elseData or 1
    if data then
        local _isOpen, _lockStr = data:IsOpen()
        isLock = not _isOpen
        lockStr = _lockStr
        SetText()
        SetSelObj()
        SetState()
    end
end

function SetText()
    CSAPI.SetGOActive(txtIndex1, currLevel == 1)
    CSAPI.SetGOActive(txtIndex2, currLevel == 2)

    local txtIndex = currLevel == 1 and txtIndex1 or txtIndex2
    CSAPI.SetText(txtIndex, index < 10 and "0" .. index or index .. "")

    local color = currLevel == 1 and {217, 138, 2, 255} or {184, 40, 63, 255}
end

function SetSelObj()
    local selName1 = currLevel == 1 and "img_03_01" or "img_03_04"
    local selName2 = currLevel == 1 and "img_02_02" or "img_02_04"
    if data and data:IsPass() then
        selName1 = "img_03_03"
        selName2 = "img_02_03"
    elseif isLock then
        selName1 = "img_03_03"
        selName2 = "img_02_03"
    end
    CSAPI.LoadImg(selImg, "UIs/Tower2/" .. selName1 .. ".png", true, nil, true)
    CSAPI.LoadImg(selImg2, "UIs/Tower2/" .. selName2 .. ".png", true, nil, true)
end

function SetSelect(b)
    isSel = b
    CSAPI.SetGOActive(selObj, b)
    CSAPI.SetGOActive(nolObj, not b)
    SetState()
end

function SetState()
    local txtCode = "ffffff"
    local iconName = currLevel == 1 and "nol_0" or "hard_0"
    local iconBgName = currLevel == 1 and "nol_04" or "hard_04"
    if data and data:IsPass() then
        iconName = iconName .. 1
    elseif isLock then
        txtCode = "9d9da6"
        iconBgName = isSel and "lock_02" or "lock_01"
        iconName = isSel and iconName .. 3 or "lock"
    else
        iconName = iconName .. 2
    end

    CSAPI.LoadImg(icon, "UIs/Tower2/" .. iconName .. ".png", true, nil, true)
    CSAPI.LoadImg(iconBg, "UIs/Tower2/" .. iconBgName .. ".png", true, nil, true)
    -- text
    local txtIndex = currLevel == 1 and txtIndex1 or txtIndex2
    CSAPI.SetScriptEnable(txtIndex, "Shadow", isSel)
    local txt_index = currLevel == 1 and txt_index1 or txt_index2
    CSAPI.SetTextColorByCode(txt_index, isSel and "ffffff" or txtCode)
    CSAPI.SetTextColorByCode(txtIndex, isSel and "ffffff" or txtCode)
    if not isSel then
        CSAPI.SetGOActive(nolImg1, isLock or (data and data:IsPass()))
        CSAPI.SetGOActive(nolImg2, not isLock and not (data and data:IsPass()))
    end
end

function GetCfg()
    return data:GetCfg()
end

function GetLock()
    return isLock, lockStr
end

function IsPass()
    return data:IsPass()
end

function OnClick()
    if cb then
        cb(this)
    end
end
