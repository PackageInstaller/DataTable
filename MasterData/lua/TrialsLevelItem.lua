local isSel = false
local isLock = false
local lockStr = ""
local data = nil
local ids = nil

function Awake()
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
        local isOpen,_lockStr = data:IsOpen()
        isLock,lockStr = not isOpen,_lockStr
        CSAPI.SetGOActive(lockImg,isLock)
        ids = data:GetDungeonGroups()
        SetName()
    end
end

function SetName()
    CSAPI.SetText(txtName1,data:GetName())
    CSAPI.SetText(txtName2,data:GetEnName())
end

function SetSelect(b)
    isSel = b
    SetState()
end

function SetState()
    local color1 = isSel and {255,193,70,255} or {255,255,255,128}
    local color2 = isSel and {255,193,70,255} or {255,255,255,178}
    CSAPI.SetTextColor(txtName1,color1[1],color1[2],color1[3],color1[4])
    CSAPI.SetTextColor(txtName2,color2[1],color2[2],color2[3],color2[4])
    CSAPI.SetGOActive(nol,not isSel)
    CSAPI.SetGOActive(sel,isSel)
end

function IsDanger()
    return ids and #ids > 1
end

function GetCfg()
    
end

function GetCfgs()
    local cfgs = {}
    if ids and #ids > 0 then
        for _, cfgId in ipairs(ids) do
            local cfg =Cfgs.MainLine:GetByID(cfgId)
            if cfg then
                table.insert(cfgs,cfg)
            end
        end
    end
    return cfgs
end

function OnClick()
    if isLock then
        LanguageMgr:ShowTips(24002)
        return
    end
    if cb then
        cb(this)
    end
end