local cfg = nil
local colors = {{228,219,213,255},{140,114,84,255},{255,255,255,45}}
local isOpen = false
local index = 1

function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    local idx = b and 1 or 2
    if not isOpen then
        idx = 3
    end
    CSAPI.SetTextColor(txtNum,colors[idx][1],colors[idx][2],colors[idx][3],colors[idx][4])
    CSAPI.SetGOActive(selImg,b and isOpen)
    CSAPI.SetGOActive(img,not b or not isOpen)
end

function Refresh(_cfg)
    cfg = _cfg
    if cfg then
        isOpen = DungeonMgr:IsDungeonOpen(cfg.id)
        CSAPI.SetText(txtNum,index.."")
    end
end

function SetSibling(_index)
    _index = _index or 0
    if _index == -1 then
        transform:SetAsLastSibling()
    else
        transform:SetSiblingIndex(_index)
    end
end

function GetCfg()
    return cfg
end

function OnClick()
    if cb then
        cb(index)
    end
end