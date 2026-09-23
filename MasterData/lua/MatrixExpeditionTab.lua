function SetClickCB(_cb)
	cb = _cb
end

function Refresh(_data, _curIndex)
	data = _data
	--icon
	CSAPI.LoadImg(icon, "UIs/Matrix/" .. data.icon .. ".png", true, nil, true)
	--select
	Select(data.id == _curIndex)
end

function Select(b)
	CSAPI.SetGOActive(normal, not b)
	CSAPI.SetGOActive(sel, b)
	local color = b and "ffc146" or "ffffff"
	CSAPI.SetText(txtDesc, StringUtil:SetByColor(data.sName, color))
	
	CSAPI.SetImgColorByCode(icon, color)
end

function OnClick()
	if(cb) then
		cb(data.id)
	end
end

function SetRed(b)
	UIUtil:SetRedPoint(red, b)
end 