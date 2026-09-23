function SetIndex(_index)
	index = _index
end

function Refresh(log)
	--name
	if(log.pool_id) then 
		CSAPI.SetText(txtName, Cfgs.CfgCardPool:GetByID(log.pool_id).sName)
	else
		CSAPI.SetText(txtName,"") 
	end
	--time
	local str1 = os.date("%Y.%m.%d", log.t)
	local str2 = os.date("%H:%M", log.t)
	CSAPI.SetText(txtTime, string.format("%s <color=#ffc146>%s</color>", str1, str2))
	--count
	local id = #log.cfgIds > 1 and 17003 or 17002
	LanguageMgr:SetText(txtCount, id)
	CSAPI.SetTextColorByCode(txtCount, id == 17003 and "ffc146" or "FFFFFF")
	--countbg
	local imgName = id == 17003 and "img_26_01" or "img_26_02"
	CSAPI.LoadImg(countBg, "UIs/Create/" .. imgName .. ".png", true, nil, true)
	--items
	items = items or {}
	curDatas = {}
	for i, v in ipairs(log.cfgIds) do
		local _data = RoleMgr:GetFakeData(v)
		table.insert(curDatas, _data)
	end
	ItemUtil.AddItems("RoleLittleCard/CreateCacheItem", items, curDatas, grid,nil,1,11)
	--space
	CSAPI.SetGOActive(space, index ~= 6)
end

function SetSelect(b)
	CSAPI.SetGOActive(select, b)
end 