-- function Awake()
-- 	dormThemeIcon = ComUtil.GetCom(icon, "DormThemeIcon")
-- end
function SetIndex(_index)
	index = _index
end
function SetClickCB(_cb)
	cb = _cb
end
function Refresh(_data, _elseData)
	data = _data
	local curIndex = _elseData[1]
	local isRoom = _elseData[2]
	if(isRoom) then
		CSAPI.SetText(txtName1, data:GetName())
	else
		CSAPI.SetText(txtName1, data.name)
	end
	Select(index == curIndex)
	
	local fileName = isRoom and data:GetImg() or data.img
	--SetIcon(fileName)
	DormIconUtil.SetIcon(icon, fileName)

	CSAPI.SetScale(icon,0.3,0.3,1)
end

function Select(b)
	CSAPI.SetGOActive(selectObj, b)
	
	local h = curIndex == index and 12 or 0
	CSAPI.SetAnchor(bg, 0, h, 0)
end


function OnClick()
	if(cb) then
		cb(index)
	end
end
