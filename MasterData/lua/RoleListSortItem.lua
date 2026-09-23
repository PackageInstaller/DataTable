--筛选词条
function SetClickCB(_cb)
	cb = _cb
end

-- {index = _index, name = _name, isSelect = _isSelect}
function Refresh(_data)
	data = _data
	local str = data.isSelect and "green_click" or "frame_click"
	CSAPI.LoadImg(node, "UIs/RoleList/" .. str .. ".png", false, nil, true)
	
	local colorName = data.isSelect and "000000" or "bdbdbd"
	StringUtil:SetColorByName(txtDesc, data.name, colorName)
end

function OnClick()
	if(cb) then
		cb(data.index)
	end
end
