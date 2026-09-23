local cfg = nil
local isOpen = false

function SetClickCB(_cb)
    cb = _cb
end

function SetIndex(idx)
    index= idx
end

function Refresh(_data)
    cfg = _data
    if cfg then
        isOpen = CheckIsOpen()
        SetTitle()
        SetIcon()
        SetLock()
    end
end

function CheckIsOpen()
    if cfg.goodsId then
        local num = BagMgr:GetCount(cfg.goodsId)
        return num > 0
    end
    return false
end

function SetLock()
    CSAPI.SetGOActive(lockObj,not isOpen)
    CSAPI.SetGOAlpha(node,isOpen and 1 or 0.6)
end

function SetTitle()
    CSAPI.SetText(txtIndex,index < 10 and "0" .. index or index)
    CSAPI.SetText(txtName,cfg.imgName or "")
end

function SetIcon()
    if cfg.icon and cfg.icon~="" then
        ResUtil.LovePlus:Load(icon, cfg.group .. "/" .. cfg.icon)
    end
end

function GetCfg()
   return cfg 
end

function OnClick()
    if not isOpen then
        return
    end
    if cb then
        cb(this)
    end
end