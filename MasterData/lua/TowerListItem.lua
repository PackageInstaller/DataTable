local data = nil
local isLock = false
local lockStr = ""
local isSel = false
local textIndex1,textIndex2, textState = nil, nil, nil

function Awake()
    textIndex1 = ComUtil.GetCom(txtIndex, "Text")
    textIndex2 = ComUtil.GetCom(txt_index, "Text")
    textState = ComUtil.GetCom(txtState, "Text")
    SetSelect(false)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    data = _data
    if data then
        local _isOpen,_lockStr = data:IsOpen()
        isLock = not _isOpen
        lockStr = _lockStr
        SetText()
        SetState()
    end
end

function SetText()
    textIndex1.text = index < 10 and "0" .. index or index .. ""
    local languageId = 49013
    if data:IsPass() then
        languageId = 49014
    elseif isLock then
        languageId = 49015
    end
    textState.text = LanguageMgr:GetByID(languageId)
end

function SetSelect(b)
    isSel = b
    CSAPI.SetGOActive(selObj, b)
    CSAPI.SetGOActive(nolObj, not b)
    SetState()
end

function SetState()
    local _idx = 1
    local indexColor1, indexColor2 = "ffffff", "ffc146"
    local stateColor1, stateColor2 = "ffffff", "ffc146"
    local color1, color2 = "ffffff", "ffc146"
    if data and data:IsPass() then
        _idx = 3
        indexColor1, indexColor2 = "000000", "ffffff"
        stateColor1, stateColor2 = "000000", "ffc146"
        color1, color2 = "000000", "929296"
    elseif isLock then
        _idx = 2
        indexColor1, indexColor2 = "c2c2c2", "929296"
        stateColor1, stateColor2 = "c2c2c2", "929296"
        color1, color2 = "c2c2c2", "929296"
    end
    if isSel then
        textIndex1.fontSize = 80
        textIndex2.fontSize = 36
        textState.fontSize = 32
        CSAPI.LoadImg(selImg, "UIs/Tower/sel_0" .. _idx .. "_01.png", true, nil, true)
        CSAPI.LoadImg(selImg2, "UIs/Tower/sel_0" .. _idx .. "_02.png", true, nil, true)
        CSAPI.SetTextColorByCode(txtIndex, indexColor1)
        CSAPI.SetTextColorByCode(txtState, stateColor1)
        CSAPI.SetTextColorByCode(txt_index, color1)
        CSAPI.SetAnchor(txtIndex, 20, -9)
        CSAPI.SetAnchor(txtState, 33, -34)
    else
        textIndex1.fontSize = 50
        textIndex2.fontSize = 28
        textState.fontSize = 28
        CSAPI.LoadImg(nolImg, "UIs/Tower/nol_0" .. _idx .. ".png", true, nil, true)
        CSAPI.SetTextColorByCode(txtIndex, indexColor2)
        CSAPI.SetTextColorByCode(txtState, stateColor2)
        CSAPI.SetTextColorByCode(txt_index, color2)
        CSAPI.SetAnchor(txtIndex, -7, 9)
        CSAPI.SetAnchor(txtState, 13, -21)
    end
end

function GetCfg()
    return data:GetCfg()
end

function GetLock()
    return isLock,lockStr
end

function IsPass()
    return data:IsPass()
end

function OnClick()
    if cb then
        cb(this)
    end
end
