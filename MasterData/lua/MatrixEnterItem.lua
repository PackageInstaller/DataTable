local viewName = nil
local buildData

function Awake()
    fc_go = ComUtil.GetCom(gameObject, "FacingCamera")
end

function Init(_goCamera)
    fc_go:SetCamera(_goCamera)
    -- local camera = ComUtil.GetCom(_goCamera,"Camera")
    -- ComUtil.GetCom(Canvas,"Canvas").worldCamera = camera
end

function Refresh(_buildData, index)
    buildData = _buildData
    -- viewName = Cfgs.CfgMatrixAttribute:GetByID(index).viewName
    local index = MatrixMgr:GetIDByBuildData(buildData)
    col.name = tostring(index)

    -- pos 
    local pos = buildData:SetBaseCfg().enterPos
    CSAPI.SetPos(gameObject, pos[1], pos[2], pos[3])
end

-- function OnClick()
--     if (viewName) then
--         if (viewName == "MatrixTrading" or viewName == "PlayerAbility") then
--             CSAPI.OpenView(viewName)
--         else
--             CSAPI.OpenView(viewName, buildData)
--         end
--     end
-- end
