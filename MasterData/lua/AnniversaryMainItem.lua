local cfg =nil
local isGet = false
local goodsData = nil
function SetIndex(idx)
    index = idx
end

function Refresh(_data,_elseData)
    cfg = _data
    if cfg then
        isGet = _elseData and _elseData >= cfg.star
        CSAPI.SetGOActive(getObj,isGet)
        SetItem()
        SetTarget()
    end
end

function SetItem()
    if cfg.jAwardId then
        goodsData = GridUtil.GetGridObjectDatas2(cfg.jAwardId)[1]
        SetIcon(goodsData:GetIcon())
        SetNum(goodsData:GetCount())
    end
end

function SetIcon(iconName)
    if iconName and iconName ~= "" then
        ResUtil.IconGoods:Load(icon,iconName)
    end
end

function SetNum(num)
    CSAPI.SetText(txtNum,"x" .. num)
end

function SetTarget()
    CSAPI.SetText(txtTarget,"x" .. cfg.star)
end

function OnClick()
    if goodsData then
        UIUtil:OpenGoodsInfo(goodsData,GridClickFunc.OpenInfoSmiple)
    end
end