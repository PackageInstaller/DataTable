--核心突破
local index = nil

function Awake()
	
end

function SetOldData(_oldData)
	
end

function Refresh(_cardData)
	if(cardData and cardData:GetID() ~= _cardData:GetID()) then
		index = nil
		oldLv = nil
	end
	
	cardData = _cardData or cardData
	
	isMax = RoleTool.IsMaxCoreLv(cardData)
	CSAPI.SetGOActive(node1, not isMax)
	CSAPI.SetGOActive(node2, isMax)
	if(isMax) then
		SetNode2()
	else
		SetNode1()
	end
	
	-- if(oldLv and cardData:GetMaxLv() > oldLv) then
	-- 	CSAPI.OpenView("RoleTopuSuccess", cardData)
	-- end
	oldLv = cardData:GetMaxLv()
end

-- 背包更新
function RefreshGoods()
	if(isMax) then
		SetNode2()
	else
		SetNode1()
	end
end

function SetNode1()
	--lv1
	local _num1 = cardData:GetMaxLv()
	local lv1 = string.format("<color=#ffc146>%s</color><color=#929296>/%s</color>", cardData:GetLv(), _num1)
	CSAPI.SetText(txtLv1, lv1)
	--lv2
	local _num2 = RoleTool.GetNextLimitLv(cardData)
	local lv2 = string.format("<color=#ffc146>%s</color><color=#ffffff>/%s</color>", cardData:GetLv(), _num2)
	CSAPI.SetText(txtLv2, lv2)
	
	--mat 
	goodsData1 = BagMgr:GetFakeData(cardData:GetCfg().coreItemId)
	local num1 = RoleTool.GetCoreUpgrateCostNum(cardData)
	isEnough1 = goodsData1:GetCount() >= num1
	
	--mat2 
	local cost = RoleTool.GetCoreUpgrateElseCost(cardData)
	local goodsData2 = cost ~= nil and BagMgr:GetFakeData(cost[1]) or nil
	isEnough2 = cost ~= nil and goodsData2:GetCount() >= cost[2] or false
	
	if(index == nil) then
		index =(not isEnough1 and isEnough2) and 2 or 1
	else
		if(index == 2 and not isEnough2) then
			index = 1
		end
	end
	
	datas = {{goodsData1, num1, true}, {goodsData2, cost and cost[2] or 0, true}}	
	items = items or {}
	ItemUtil.AddItems("Grid/RoleGridItem", items, datas, itemParent, ItemClickCB, 1, {index, 1})
	
	--btn
	if(canvasGroup == nil) then
		canvasGroup = ComUtil.GetCom(btnS, "CanvasGroup")
	end
	canvasGroup.alpha = IsEnough() and 1 or 0.3
end

function SetNode2()
	--lv
	local num1 = cardData:GetMaxLv()
	local lv1 = string.format("<color=#ffc146>%s</color><color=#929296>/%s</color>", cardData:GetLv(), num1)
	CSAPI.SetText(txtLv3, lv1)
	--max
	CSAPI.SetText(txtMax, string.format("【MAX：%s】", num1))
end

function ItemClickCB(_index)
	if(index ~= _index) then
		index = _index
		SetSelect()
	end
end

function SetSelect()
	for i, v in ipairs(items) do
		v.SetSelect(index)
	end
end

function IsEnough()
	if(index == 1) then
		return isEnough1
	else
		return isEnough2
	end
end

--突破
function OnClickS()
	if(IsEnough()) then
		local str = index == 1 and "costNum" or "costArr"
		PlayerProto:CardCoreLv(cardData:GetID(), str)
	end
end 