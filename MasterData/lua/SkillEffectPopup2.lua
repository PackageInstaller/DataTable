function Refresh(data)
	CSAPI.SetText(txt_name, data.sName)
	local color = Cfgs.CfgUIColorEnum:GetByID(data.color or 1)
	CSAPI.SetImgColor(img1, color.r, color.g, color.b, 125)
	CSAPI.SetText(txt_desc, data.sDesc)
end
