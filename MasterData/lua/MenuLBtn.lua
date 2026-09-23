local redPos = {-74, 26.5}

function Refresh(_data,_str)
    data = _data
    if(_str=="")then 
        CSAPI.SetImgColorByCode(bg, data:GetCfg().code, true)
    end 
    --CSAPI.LoadImg(icon, "UIs/Menu/" .. data:GetCfg().icon .. ".png", true, nil, true)
    ResUtil.MenuL:Load(icon, data:GetCfg().icon)
    LanguageMgr:SetText(txtName1, data:GetCfg().Name)
    LanguageMgr:SetEnText(txtName2, data:GetCfg().Name)
    CSAPI.SetGOAlpha(clickNode, data:IsOpen() and 1 or 0.5)
    -- lock
    UIUtil:SetLockPoint(clickNode, not data:IsOpen(), redPos[1], redPos[2])
    -- red
    if (data:GetCfg().nType == 7) then
        data:IsRed7(clickNode, redPos)
    elseif (data:GetCfg().nType == 18) then
        UIUtil:SetNewPoint(clickNode, data:IsNew(), redPos[1], redPos[2])
        if not data:IsNew() then
            UIUtil:SetRedPoint(clickNode, data:IsRed(), redPos[1], redPos[2])
        end
    elseif (data:GetCfg().nType == 20) then
        local isRed=data:IsRed();
        UIUtil:SetRedPoint(clickNode, data:IsRed(), redPos[1], redPos[2])
        UIUtil:SetNewPoint(clickNode, false, redPos[1], redPos[2])
        if not isRed then
            UIUtil:SetNewPoint(clickNode, data:IsNew(), redPos[1], redPos[2])
        end
    else
        UIUtil:SetRedPoint(clickNode, data:IsRed(), redPos[1], redPos[2])
    end
    --
    CSAPI.SetGOActive(particle_exploration, data:GetCfg().id == 1)
end

function OnClick()
    local isOpen, str = data:IsOpen()
    if (not isOpen) then
        if (str and str ~= "") then
            Tips.ShowTips(str)
        end
        return
    end
    if (data:GetCfg().nType == 7) then
        ShiryuSDK.ShowActivityUI(function()
            data:IsRed7(clickNode, redPos)
        end)
    elseif (data:GetCfg().nType==17) then--大富翁
        local activity=RichManMgr:GetCurData();
        if activity~=nil then
            activity:EnterScene();
        end
    else
        CSAPI.OpenView(data:GetCfg().openView, nil, data:GetCfg().page)
    end
end
