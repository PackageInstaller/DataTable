function Awake()
    nameMove = ComUtil.GetCom(nameObj, "TextMove")
end
function SetIndex(_index)
    index = _index
end
function SetSelectCB(_cb)
    cb = _cb
end
function Refresh(_cfg, _curMusicID)
    cfg = _cfg

    isSelect = cfg.id == _curMusicID
    --CSAPI.SetGOAlpha(bg, index % 2 == 0 and 0 or 0.1)
    CSAPI.SetText(txtIndex, index .. ".")
    CSAPI.SetText(txtName, cfg.sName)
    if (isSelect) then
        --nameMove:SetMove()
        nameMove:SetText(cfg.sName)
    else
        --nameMove:ResetAll()
        nameMove.isMove = false
        nameMove:ResetToDefault()
    end

    CSAPI.SetGOActive(icon, not isSelect)
    CSAPI.SetGOActive(bg, isSelect)
    if (not isSelect) then
        CSAPI.LoadImg(icon, "UIs/Bgm/img_02_01.png", true, nil, true)
    end

    -- cloor
    local code = isSelect and "ffc146" or "c3c3c8"
    -- CSAPI.SetImgColorByCode(icon, code)
    CSAPI.SetTextColorByCode(txtIndex, code)
    CSAPI.SetTextColorByCode(txtName, code)
end

function OnClick()
    if (not isSelect) then
        cb(cfg.id)
    end
end
