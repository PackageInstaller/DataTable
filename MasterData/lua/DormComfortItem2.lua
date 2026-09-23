function Refresh(_cfg)
	--name
	CSAPI.SetText(txtName, _cfg.sName)
	--num
	CSAPI.SetText(txtNum, "+" .. _cfg.comfort)
end 