function Refresh1(_data, max)	
	data = _data
	local cfg = Cfgs.ItemInfo:GetByID(data.id)
	local frame = GridFrame[cfg.quality]
	--ResUtil.IconGoods:Load(bg, frame)
	ResUtil.IconGoods:Load(icon, cfg.icon, true)
	local str = data.num >= max and "MAX" or data.num .. ""
	CSAPI.SetText(txt_count, str)
	UIUtil:SetRedPoint(redParent, false)
end

function Refresh2(str, imgName, isRed)
	--ResUtil.IconGoods:Load(bg, "white_new")
	--ResUtil.IconGoods:Load(icon, imgName, true)
	--CSAPI.LoadImg(icon, "UIs/Matrix/" .. imgName .. ".png", true, nil, true)
	ResUtil.IconGoods:Load(icon, imgName, true)
	CSAPI.SetText(txt_count, str)
	UIUtil:SetRedPoint(redParent, isRed)
end

function SetItemCB(_cb)
	cb = _cb
end

function OnClick()
	if(cb) then
		cb()
	end
end 