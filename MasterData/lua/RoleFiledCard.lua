function Refresh(cfg)
    if cfg then
        SetName(cfg.name)
        local cfgModel = Cfgs.character:GetByID(cfg.model)
        if cfgModel then
            SetIcon(cfgModel.Card_head)
        end
        SetColor(cfg.quality)
    end
end

function SetName(str)
    CSAPI.SetText(txtName2, str)
end

function SetIcon(_iconName)
    if (_iconName) then
        ResUtil.CardIcon:Load(icon, _iconName)
    end
end

-- 等级
function SetLv(_lv)
    _lv = _lv or 1
    CSAPI.SetText(txtLv3, _lv .. "")
end

-- 颜色
function SetColor(_quality)
    _quality =_quality <=3 and 3 or _quality
    local colorName = "img_x_" .. _quality
    ResUtil.RoleCard_BG:Load(color, colorName)
end
