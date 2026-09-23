-- data: MatrixTradingInfo
function OnOpen()
    cRoleInfo = data:GetCRoleInfo()
    -- grid
    if (not item) then
        ResUtil:CreateUIGOAsync("CRoleItem/MatrixRole", gridParent, function(go)
            item = ComUtil.GetLuaTable(go)
            item.Refresh(cRoleInfo, true)
        end)
    else
        item.Refresh(cRoleInfo)
    end
    -- name
    CSAPI.SetText(txtName, cRoleInfo:GetAlias())
    -- pl
    InitPl()
    -- txt
    LanguageMgr:SetText(txt1, 10121, cRoleInfo:GetAlias(), math.abs(cRoleInfo:GetAbilityCurCfg().modTired))
    LanguageMgr:SetText(txt2, 10122, cRoleInfo:GetAlias())
end

function OnClickL()
    view:Close()
end

function OnClickR()
    local cur = cRoleInfo:GetCurRealTv()
    local need = math.abs(cRoleInfo:GetAbilityCurCfg().modTired)
    if (need > cur) then
        LanguageMgr:ShowTips(2103, cRoleInfo:GetAlias())
    else
        local buildingData = MatrixMgr:GetBuildingDataByType(BuildsType.TradingCenter)
        BuildingProto:TradeSpeedOrder(buildingData:GetId())
        view:Close()
    end
end

-- =====================================pl=========================================================
function InitPl()
    if (matrixPL == nil) then
        matrixPL = MatrixPL.New()
    end
    matrixPL:Init(cRoleInfo, face, txtPL, slider, imgSlider)
end

function Update()
    if (matrixPL) then
        matrixPL:Update()
    end
end
