--皮肤 data : RoleSkinInfo
function SetIndex(_index)
	index = _index
end
function SetClickCB(_cb)
	cb = _cb
end

-- _elseData 根据key来划分数据
function Refresh(_matrixIndoorRole, _elseData)
	--data = _data
	isSelect = _elseData == index
	--select
	CSAPI.SetGOActive(select, isSelect)
	local size = isSelect and 176 or 141
	CSAPI.SetRTSize(transform, size, size)
	--icon
	SetIcon(_matrixIndoorRole.data:GetBaseIcon())
end

function SetIcon(_iconName)
	if(_iconName) then
		ResUtil.RoleCard:Load(icon, _iconName, false, function()
			CSAPI.SetScale(icon, 1, 1, 1)
		end)
	end
end

function OnClick()
	if(cb) then
		cb(index)
	end
end

