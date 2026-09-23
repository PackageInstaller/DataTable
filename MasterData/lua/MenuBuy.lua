function Refresh(_data)
    data = _data

    -- icon 
    CSAPI.LoadImg(icon, "UIs/Menu/" .. data:GetCfg().img .. ".png", true, nil, true)
    -- time
    local isShowTime = false
    if (data:GetID() == 3) then
        local num = ShopMgr:GetMonthCardDays()
        if (num > 0 and num <= 7) then
            isShowTime = true
            LanguageMgr:SetText(txtTime, 18082, num)
        end
    end
    CSAPI.SetGOActive(imgTime, isShowTime)
    -- red 
    SetRed()
end

function SetRed()
    UIUtil:SetRedPoint(clickNode, data:GetRed(), 130.5, 44, 0)
end

function OnClick()
    CSAPI.OpenView("MenuBuyPanel")
end
