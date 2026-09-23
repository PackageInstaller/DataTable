-- 系统主题
function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

-- _curTabIndex 1:主题 CfgFurnitureTheme   2：家具类型 CfgFurnitureEnum
function Refresh(_curTabIndex, _cfg, _curLIndex, _num)
    curTabIndex = _curTabIndex
    cfg = _cfg
    curLIndex = _curLIndex
    num = _num

    isSelect = index == curLIndex
    SetIcon()
    SetName()
    SetNum()
    Select()
end

function SetIcon()
    local scale = 1
    if (curTabIndex == 1) then
        ResUtil.Theme:Load(icon, cfg.id.."/"..cfg.id, true) 
    else
        CSAPI.LoadImg(icon, "UIs/Dorm2/furniture_1_0" .. (cfg.id - 1) .. ".png", true, nil, true)
        scale = 0.75
    end
    CSAPI.SetScale(icon, scale, scale, 1)
end

function SetName()
    CSAPI.SetText(txtName, cfg.sName)
end

function SetNum()
    LanguageMgr:SetText(txtNum, 32080, num)
end

function Select(b)
    CSAPI.SetGOActive(selectObj, isSelect)
end

function OnClick()
    if (not isSelect and cb) then
        cb(index)
    end
end
