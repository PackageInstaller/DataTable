function Refresh(_datas, isChoise)
    datas = _datas
    local nums = {}
    if (isChoise) then
        nums = {
            [6] = 50,
            [5] = 50
        }
    else
        for k, v in pairs(_datas) do
            nums[k] = 0
            for p, q in pairs(v) do
                nums[k] = nums[k] + q.s_up_probability
            end
        end
    end
    for i = 6, 4, -1 do
        local data = _datas[i]
        data = data ~= nil and #data > 0 and data or nil
        CSAPI.SetGOActive(this["space" .. i], data ~= nil)
        CSAPI.SetGOActive(this["title" .. i], data ~= nil)
        CSAPI.SetGOActive(this["grid" .. i], data ~= nil)
        if (data ~= nil) then
            local str = LanguageMgr:GetByID(17134)
            str = string.format(str, i)
            str = str .. "<color=#ffc146>" .. nums[i] .. "%" .. "</color>"
            CSAPI.SetText(this["txtTitle" .. i], str)
            this["items" .. i] = this["items" .. i] or {}
            ItemUtil.AddItems("RoleLittleCard/CreateProItem", this["items" .. i], data, this["grid" .. i])
        end
    end
end
