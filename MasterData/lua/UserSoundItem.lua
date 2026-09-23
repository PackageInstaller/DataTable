--角色声音按钮
local cb = nil
local data = nil
local index = 3

function SetClickCB(_cb)
	cb = _cb
end

function Refresh(_data)
	data = _data
	if data then
		SetName(data[2])
	end
end


function SetName(str)
	CSAPI.SetText(txtName, str .. "")
end

function SetSel(isSelect)
	CSAPI.SetGOActive(selImg, isSelect)
	local txtColor = isSelect and {255, 204, 0, 255} or {255, 255, 255, 255}
	CSAPI.SetTextColor(txtName, txtColor[1], txtColor[2], txtColor[3], txtColor[4])
end

function GetVid()	
	return data[1]
end

function GetName()
	return data[2]
end

function OnClick()
	if cb then
		cb(this)
	end
end

function OnClickPlay()
	SoundPlay()
end

function SoundPlay()
	if index == #data + 1 then
		index = 3
	end
	CSAPI.PlayCfgSoundByID(data[index],true);
	index = index + 1
end

