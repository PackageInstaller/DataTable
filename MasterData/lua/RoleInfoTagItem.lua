function SetClickCB(_cb)
	cb = _cb
end

function Refresh(_data, elseData)
	data = _data
	isSelect = data.id == elseData[1]
	
	if(data.id == 0) then
		CSAPI.SetGOActive(icon, false)
		CSAPI.SetGOActive(imgNo, true)
	else
		CSAPI.SetGOActive(icon, true)
		CSAPI.SetGOActive(imgNo, false)
		local proCfg = Cfgs.CfgCardPropertyEnum:GetByID(data.id)
		ResUtil.AttributeIcon:Load(icon,tostring(proCfg.icon2))
	end
	
	CSAPI.SetGOActive(select, isSelect)
end

function OnClick()
	cb(data.id)
end
