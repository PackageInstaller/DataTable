
function SetIndex(_index)
	index = _index
end

function SetClickCB(_cb)
	cb = _cb
end

--cfg : CfgClothes
function Refresh(_cfg, _isSelect)
	cfg = _cfg
	isSelect = _isSelect
	
	--icon
	--ResUtil.Clothes:Load(icon, cfg.icon)
	ResUtil.IconGoods:Load(icon, cfg.icon)
	--name
	CSAPI.SetText(txtName, cfg.name)
	--new
	CSAPI.SetGOActive(new, false)
	--select
	CSAPI.SetGOActive(select, isSelect)
end


function OnClick()
	if(cb) then
		cb(this)
	end
end
