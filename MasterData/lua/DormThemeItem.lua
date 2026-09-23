function Refresh(_cfgID, _needNum)
	id = _cfgID
	cfg = Cfgs.CfgFurniture:GetByID(id)
	--icon
	SetIcon()
	--need
	CSAPI.SetGOActive(txtNeed, _needNum ~= nil)
	if(_needNum) then
		LanguageMgr:SetText(txtNeed, 32029, _needNum)
	end
	--comfort
	CSAPI.SetText(txtComfort, "+" .. cfg.comfort)
	--num
	local cur = DormMgr:GetBuyCount(id)
	local str = string.format("%s/%s", cur, cfg.buyNumLimit)
	StringUtil:SetColorByName(txtNum, str, "ffc146")
	--time/new
	SetNewAndTime()
	--name
	CSAPI.SetText(txtName, cfg.sName)
	--desc
	CSAPI.SetText(txtDesc, cfg.desc)
	--spend
	SetSpend()
	--mask
	isBuy = cur >= cfg.buyNumLimit
	CSAPI.SetGOActive(txtbuy, isBuy)
	CSAPI.SetGOActive(spend, not isBuy)
	if(not cg) then
		cg = ComUtil.GetCom(clickNode, "CanvasGroup")
	end
	cg.alpha = isBuy and 0.3 or 1
end

function SetIcon()
	local iconName = cfg.icon
	CSAPI.SetGOActive(icon, iconName ~= nil);
	if(iconName) then
		ResUtil.Furniture:Load(icon, iconName .. "")
	end
end


function SetNewAndTime()
	local time = nil
	local isNew = false
	if(cfg.theme) then
		local themeCfg = Cfgs.CfgFurnitureTheme:GetByID(cfg.theme)
		if(themeCfg.sEnd) then
			local endTime = TimeUtil:GetTimeStampBySplit(themeCfg.sEnd)--GCalHelp:GetTimeStampBySplit(themeCfg.sEnd)
			local second = endTime - TimeUtil:GetTime()
			second = second <= 0 and 0 or second
			time = second ~= 0 and math.ceil(second / 3600) or 0
		end
		isNew = themeCfg.new
	end
	CSAPI.SetGOActive(txtTime, time ~= nil)
	if(time ~= nil) then
		--LanguageMgr:SetText(txtTime, 32030, time)  --剩余时间小时
		if(time > 24) then
			LanguageMgr:SetText(txtTime, 32069, math.ceil(time / 24))
		elseif(time > 1) then
			LanguageMgr:SetText(txtTime, 32030, math.ceil(time))
		else
			LanguageMgr:SetText(txtTime, 32030, 1)
		end
	end
	CSAPI.SetGOActive(new, isNew)
end

function SetSpend()
	local ids = DormMgr:GetPrice()
	local prices = cfg.price or {}
	SetSpendSrt(imgSpend1, txtSpend1, ids[1], prices[1])
	SetSpendSrt(imgSpend2, txtSpend2, ids[2], prices[2])
end

function SetSpendSrt(go, txt, id, price)
	-- if(not id) then
	-- 	CSAPI.SetGOActive(go, false)
	-- 	return
	-- end
	-- CSAPI.SetGOActive(go, true)
	local cfg = Cfgs.ItemInfo:GetByID(id)
	--local name = cfg.name
	ResUtil.IconGoods:Load(go, cfg.icon .. "_1", true)
	local num = "--"
	if(price) then
		num = price[2]
	end
	CSAPI.SetText(txt, num .. "")
end

function OnClick()
	if(not isBuy) then
		CSAPI.OpenView("DormShopConf", id) --单独够买
	end
end
