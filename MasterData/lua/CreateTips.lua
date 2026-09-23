

function OnOpen()
	local cfg = Cfgs.CfgCardPool:GetByID(data)
	CSAPI.SetText(txtTips, cfg.tips or "")
end

function OnClickCancel()
	view:Close()
end 