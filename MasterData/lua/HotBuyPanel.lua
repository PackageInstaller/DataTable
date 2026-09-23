
function OnInit()
	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.Player_HotChange, OnOpen)
	
end

function OnDestroy()
	eventMgr:ClearListener()
end

function OnOpen()
	local buyCur, buyMax = PlayerClient:HotBuyCnt()
	if(buyCur >= buyMax) then
		view:Close()
		return
	end
	local costCfg = PlayerClient:GetHotCostCfg()
	local cur = PlayerClient:Hot()
	local max1, max2 = PlayerClient:MaxHot()
	--hot
	CSAPI.SetText(txtHot1, string.format("<color=#ffc146>%s</color>/%s", cur, max1))
	CSAPI.SetText(txtHot2, string.format("<color=#ffc146>%s</color>/%s",(cur + costCfg.hot), max1))
	--tips
	LanguageMgr:SetText(txtTips2, 35008, buyCur, buyMax)
	--
	CSAPI.SetText(txtMoney1, costCfg.costs[1] [2] .. "")
	--icon 
	local cfg = Cfgs.ItemInfo:GetByID(costCfg.costs[1] [1])

	ResUtil.IconGoods:Load(icon, cfg.icon .. "_1")

end

--购买体能
function OnClickSure()
	local costCfg = PlayerClient:GetHotCostCfg()
	if CSAPI.IsADVRegional(3) and costCfg then
		if costCfg.costs[1][1]==ITEM_ID.DIAMOND then
			CSAPI.ADVJPTitle(costCfg.costs[1][2],function()
				PlayerProto:ChangePlrHot()
			end)
		else
			PlayerProto:ChangePlrHot()
		end
	else
		PlayerProto:ChangePlrHot()
	end
end

--明细
function OnClickDetail()
	CSAPI.OpenView("HotDetailPanel")
end

function OnClickMask()
	view:Close()
end
