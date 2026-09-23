
function OnOpen()
    local id = data[1]
    local targetGO = data[2]
    local cfg = Cfgs.CfgEquip:GetByID(id)
    --
    SetPos(targetGO)
    -- name
    CSAPI.SetText(txtName, cfg.sName)
    -- desc
    CSAPI.SetText(txtDesc, cfg.sDesc)
end

function SetPos(targetGO)
	if(targetGO) then
		local pos = transform:InverseTransformPoint(targetGO.transform.position)
		CSAPI.SetAnchor(bg, pos.x, pos.y, 0)
	end
end

function OnClickMask()
    view:Close()
end
