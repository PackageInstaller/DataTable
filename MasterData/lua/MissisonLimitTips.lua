local copyStr = ""

function OnOpen()
    if data then
        RefreshPanel()
    end
end

function RefreshPanel()
    local cfg = Cfgs.ItemInfo:GetByID(data.itemId)
    local str1, str2 = "", ""
    if (cfg.dy_value1 == 2) then
        str1 = LanguageMgr:GetByID(180011)
        str2 = ""
    else
        str1 = LanguageMgr:GetTips(60003, data.quota)
        str2 = LanguageMgr:GetTips(60004)
    end
    CSAPI.SetText(txtDesc1, str1)
    CSAPI.SetText(txtDesc2, str2)
    copyStr = data.code or ""
    if copyStr ~= "" then
        local length, chars = GLogicCheck:GetStringLen(copyStr)
        local _str = ""
        for i, v in ipairs(chars) do
            _str = _str .. v
            if i % 4 == 0 and i ~= #chars then
                _str = _str .. "-"
            end
        end
        CSAPI.SetText(txtCode, _str)
    end
end

function OnClickCopy()
    LanguageMgr:ShowTips(6011)
    UnityEngine.GUIUtility.systemCopyBuffer = copyStr .. ""
end

function OnClickClose()
    view:Close()
end
