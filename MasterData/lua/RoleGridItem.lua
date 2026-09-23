function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function SetEmpty()
    LoadFrame(1)
    CSAPI.LoadImg(icon, "UIs/Grid/btn_1_06.png", true, nil, true)
    CSAPI.SetGOActive(down, false)
    CSAPI.SetGOActive(select, false)
end

function Refresh(_data, _elseData)
    data = _data[1]
    if (not data) then
        SetEmpty()
        return
    end

    needNum = _data[2]
    needSelect = _data[3] or false

    -- root
    LoadFrame(data:GetQuality())
    LoadIcon(data:GetIcon())
    LoadTIcon()
    -- down
    local str1 = needNum > data:GetCount() and StringUtil:SetByColor(data:GetCount(), "ff8790") or data:GetCount()
    CSAPI.SetText(txtDown, string.format("%s/%s", str1, needNum))
    -- select
    curIndex = _elseData and _elseData[1] or -1
    SetSelect(curIndex)
    -- --kuang
    -- local len = _elseData[2]
    -- CSAPI.SetAnchor(kuang1, - 86 +(len - 1) * 4, 0, 0)
    -- CSAPI.SetAnchor(kuang2, 86 -(len - 1) * 4, 0, 0)
end

-- 加载框
function LoadFrame(lvQuality)
    if lvQuality then
        local frame = GridFrame[lvQuality]
        ResUtil.IconGoods:Load(bg, frame)
    else
        ResUtil.IconGoods:Load(bg, GridFrame[1])
    end
end

-- 加载图标
function LoadIcon(iconName)
    CSAPI.SetGOActive(icon, iconName ~= nil)
    if (iconName) then
        ResUtil.IconGoods:Load(icon, iconName .. "")
    end
end

function LoadTIcon()
    local cfg = data:GetCfg()
    CSAPI.SetGOActive(tIcon, cfg.type == ITEM_TYPE.CARD_CORE_ELEM)
    if cfg.type == ITEM_TYPE.CARD_CORE_ELEM then
        CSAPI.SetGOActive(tIcon, true)
        GridUtil.LoadTIcon(tIcon, tBorder, cfg, false)
    end
end

function SetSelect(_index)
    CSAPI.SetGOActive(select, index == _index)
end

function OnClick()
    if (data and cb) then
        if (needSelect) then
            cb(index)
        else
            -- cb(this)
            local _needNum = needNum - data:GetCount()
            _needNum = _needNum>0 and _needNum or nil
            UIUtil:OpenGoodsInfo(data, nil, _needNum)
        end
    end
end
