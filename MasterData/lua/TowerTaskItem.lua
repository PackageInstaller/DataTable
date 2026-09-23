local data = nil
function Refresh(_data)
    data = _data
    if data then
        if data.iconName ~= nil and data.iconName~="" then
            ResUtil.RoleStar:Load(icon,data.iconName)
        end
        CSAPI.SetText(txtDesc,data.str or "")
    end
end