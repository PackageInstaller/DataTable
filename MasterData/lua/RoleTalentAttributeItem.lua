function Refresh(data)
	CSAPI.SetText(txtDesc, data.desc)
	CSAPI.LoadImg(icon, "UIs/Attribute/" .. data.iconName .. ".png", true, nil, true)
end