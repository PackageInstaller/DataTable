-- {x1 = index, x2 = i, v}
function Refresh(data)
	--count
	local str =(data.x1 ~= data.x2) and string.format("%s - %s", data.x1, data.x2) or data.x1 .. ""
	CSAPI.SetText(txtCount, str)
	--count
	CSAPI.SetText(txtMoney1, data.costs[1] [2] .. "")
	--icon 
	local cfg = Cfgs.ItemInfo:GetByID(data.costs[1] [1])
	ResUtil.IconGoods:Load(icon, cfg.icon .. "_1")
end 