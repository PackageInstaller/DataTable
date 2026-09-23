local cfg = nil
function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_id)
    cfg = Cfgs.CfgDateChat:GetByID(_id)
    if cfg then
        SetDesc()
    end
end

function SetDesc()
    local str = cfg.dateContent
    local len = GLogicCheck:GetStringLen(str)
    if len > 16 then
        local tab = StringUtil:SubStrByLength(str,16)
        local _str = ""
        for i, v in ipairs(tab) do
            if i == 1 then
                _str = v
            else
                _str = _str .. "\n"  .. v
            end
        end
        str = _str
    end
    CSAPI.SetText(txtDesc,str)
end

function OnClick()
    if cb then
        cb(cfg.id)
    end
end