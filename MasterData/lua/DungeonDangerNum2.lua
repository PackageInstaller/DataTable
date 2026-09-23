local cfg = nil
local colors = {{255,193,70,255},{255,255,255,125},{255,255,255,45}}
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
    -- CSAPI.SetImgColor(img,255,255,255,isOpen and 255 or 128)
    CSAPI.SetGOActive(lock,not isOpen)
end

function Refresh(_cfg)
    cfg = _cfg
    if cfg then
        CSAPI.SetText(txtNum, cfg.chapterID .. "")
        isOpen = DungeonMgr:IsDungeonOpen(cfg.id)
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