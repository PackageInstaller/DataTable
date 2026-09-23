function SetClickCB(_cb)
    cb = _cb 
end

function Refresh(_data)
    data = _data 
    isEmpty = data.isEmpty ~= nil
    CSAPI.SetGOActive(nilObj, isEmpty)
    CSAPI.SetGOActive(node, not isEmpty)
    if (not isEmpty) then
        SetNode()
    else 
        SetQuality(nil)
    end
end

function SetNode()
    SetTagObj()
    SetName(data:GetName())
    SetLv(data:GetLv())
    SetIcon(data:GetSmallImg())
    SetQuality(data:GetQuality())
end

function SetTagObj()
    if data:IsLeader() then
        CSAPI.SetText(txt_tag, LanguageMgr:GetByID(26007))
        CSAPI.SetGOActive(txt_tag, true)
    else
        CSAPI.SetGOActive(txt_tag, false)
    end
end

function SetName(name)
    CSAPI.SetText(txt_name, name or "")
end

function SetLv(lv)
    CSAPI.SetText(txt_lv, tostring(lv) or "")
end

function SetIcon(iconName)
    if iconName then
        CSAPI.SetGOActive(icon, true)
        ResUtil.Card:Load(icon, iconName)
    else
        CSAPI.SetGOActive(icon, false)
    end
end

function SetQuality(_quality)
    local q1 = _quality or 3
    local q2 = _quality or 1
    local name = "btn_1_0" .. tostring(q1)
    local bName = "btn_b_1_0" .. tostring(q2)
    ResUtil.CardBorder:Load(tagObj, name)
    ResUtil.CardBorder:Load(border, bName)
end

function OnClickSelf()
    if cb then
        cb(this)
    end
end
