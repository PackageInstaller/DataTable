
-- data={
--     id,  --属性的id，对应CfgCardPropertyEnum表中的id
--     val1, --显示的第一个数字
--     val2, --显示的第二个数字
--     val1Color, --不设置默认为FFFFFF
--     val2Color, --不设置默认为1CFF7C
-- } 
function Refresh(_data)
	data = _data
	val1Color = data.val1Color and data.val1Color or "FFFFFF"
	val2Color = data.val2Color and data.val2Color or "1CFF7C"
	
	local cfg = Cfgs.CfgCardPropertyEnum:GetByID(data.id)
	
	--icon
	local iconName = string.format("UIs/AttributeNew/%s.png", data.id)
	CSAPI.LoadImg(icon, iconName, true, nil, true)
	
	--name
	CSAPI.SetText(txtName, cfg.sName)
	
	--val1
	if(cfg.sFieldName == "career") then
		CSAPI.SetText(val1, "")
		if(data.val1) then
			CSAPI.SetText(valStr, StringUtil:SetByColor(data.val1, val1Color))
		else
			CSAPI.SetText(valStr, "")
		end
	else
		CSAPI.SetText(valStr, "")
		if(data.val1) then
			CSAPI.SetText(val1, StringUtil:SetByColor(data.val1, val1Color))
		else
			CSAPI.SetText(val1, "")
		end
	end
	
	--val2
	if(data.val2) then
		CSAPI.SetText(val2, StringUtil:SetByColor(data.val2, val2Color))
	else
		CSAPI.SetText(val2, "")
	end
end 