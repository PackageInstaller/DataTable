function Awake()
    cg_btnOk = ComUtil.GetCom(btnOk, "CanvasGroup")
end

function Refresh(_data, _fid, _cb)
    data = _data
    fid = _fid
    cb = _cb

    -- child
    -- SetIcon(data:GetIconName())
    -- name
    CSAPI.SetText(txtName, data:GetName())
    -- lv
    CSAPI.SetText(txtLv, data:GetLv() .. "")
    -- sign
    local sign = "" -- data:GetSign() --屏蔽签名
    if (sign == "") then
        CSAPI.SetGOActive(txtSign1, true)
        CSAPI.SetText(txtSign2, "")
    else
        CSAPI.SetGOActive(txtSign1, false)
        CSAPI.SetText(txtSign2, StringUtil:SetStringByLen(sign, 8))
    end
    -- lock
    cg_btnOk.alpha = data:IsTradingOpen() and 1 or 0.3
    -- btn 
    local isSelect = false
    if (fid and fid == data:GetUid()) then
        isSelect = true
    end
    CSAPI.SetGOActive(btnOk, not isSelect)
    CSAPI.SetGOActive(btnL, isSelect)
    -- head
    UIUtil:AddHeadByID(hfParent, 0.8, data:GetFrameId(), data:GetIconId(),data:GetSex())
end

-- function SetIcon(iconName)
--     if (roleItem == nil) then
--         ResUtil:CreateUIGOAsync("CRoleItem/MatrixRole", childParent, function(go)
--             roleItem = ComUtil.GetLuaTable(go)
--             roleItem.SetIcon(iconName)
--         end)
--     else
--         roleItem.SetIcon(iconName)
--     end
-- end

function OnClickR()
    if (cb and cg_btnOk.alpha == 1) then
        cb(data)
    end
end

function OnClickL()
    LanguageMgr:ShowTips(2101)
end
