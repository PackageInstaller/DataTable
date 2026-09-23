--建造列表页签
function SetClickCB(_cb)
	cb = _cb
end

function Refresh(_data)
	data = _data
end

function SetSelect(_curIndex)
	CSAPI.SetGOActive(normal, _curIndex ~= data.id)
	CSAPI.SetGOActive(sel, _curIndex == data.id)
	local color = _curIndex == data.id and "ffc146" or "ffffff"
	CSAPI.SetText(txtDesc, StringUtil:SetByColor(data.sName, color))
end

function OnClick()
	if(cb) then
		cb(data.id)
	end
end

function SetRed(b)
	UIUtil:SetRedPoint(red, b)
end 