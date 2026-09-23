function SetClickCB(_cb)
	cb = _cb
end

-- _id: CfgMatrixAttribute
function Refresh(_id)
	id = _id
	local cfg = Cfgs.CfgMatrixAttribute:GetByID(id)
	CSAPI.SetText(txtName, cfg.sName)
	ResUtil.MatrixIcon:Load(icon, cfg.icon)
	
	
	SetExpedition()
	
	SetRed()
end

--远征
function SetExpedition()
	num3 = 0
	CSAPI.SetGOActive(eInfo, id == 8)
	if(id == 8) then
		local buildData = MatrixMgr:GetBuildingDataByType(BuildsType.Expedition)
		local num1, num2, _num3 = buildData:GetExpeditionCount()
		num3 = _num3
		CSAPI.SetText(txtE1, num1 .. "")
		CSAPI.SetText(txtE2, num2 .. "")
		CSAPI.SetText(txtE3, num3 .. "")
	end
end

--red
function SetRed()
	local isRed = false
	if(id == 6) then
		--战斗
		isRed = true
	elseif(id == 8) then
		isRed = num3 > 0
	end
	UIUtil:SetRedPoint(redPoint, isRed)
end

function OnClick()
	cb(id)
end

