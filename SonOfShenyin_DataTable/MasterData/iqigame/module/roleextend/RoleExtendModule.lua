-- chunkname: @IQIGame\\Module\\RoleExtend\\RoleExtendModule.lua

RoleExtendModule = {
	sortType = {
		EaseNum = 3,
		EaseQuality = 2
	}
}

function RoleExtendModule.InitData()
	RoleExtendModule.CustomItemDic = {}
	RoleExtendModule.isUpSort = true
	RoleExtendModule.TargetCustomDic = {}
	RoleExtendModule.CfgFavorLv = {}
	RoleExtendModule.MinTable = {}
	RoleExtendModule.MaxTable = {}
	RoleExtendModule.OperateData = {
		isAdd = false
	}
	RoleExtendModule.PreviewAddExp = 0
	RoleExtendModule.RoleDevelopment_UIController = nil
	RoleExtendModule.IsMax = false
	RoleExtendModule.ScrollAreaScrollRefresh = false
	RoleExtendModule.FaultItemDataTable = {}
end

function RoleExtendModule.Initialize()
	RoleExtendModule.InitData()
	RoleExtendModule.AddEventListeners()
	RoleExtendModule.GetFavorabilityDefaultConfig()
	RoleExtendModule.GetIntensifyMinLimitExp()
end

function RoleExtendModule.GetFavorabilityDefaultConfig()
	RoleExtendModule.FavorMaterialsConfig = RoleDevelopmentModule.GetItemByActionType(Constant.ActionType.FavorabilityExpAction)

	for i, v in pairs(RoleExtendModule.FavorMaterialsConfig) do
		v.FavorJustSoSo = false
	end
end

function RoleExtendModule.GetFavorabilityIntensifyMaterials()
	local _ret = {}

	RoleExtendModule.TargetCustomDic = {}

	for i, v in pairs(WarehouseModule.AllItems) do
		for k, u in pairs(RoleExtendModule.FavorMaterialsConfig) do
			if RoleExtendModule.FaultItemDataTable[u.Id] == nil then
				RoleExtendModule.FaultItemDataTable[u.Id] = {}
				RoleExtendModule.FaultItemDataTable[u.Id].index = 0
			end

			if v.cid == u.Id then
				RoleExtendModule.FaultItemDataTable[u.Id].index = RoleExtendModule.FaultItemDataTable[u.Id].index + 1

				table.insert(_ret, v)

				RoleExtendModule.TargetCustomDic[v.id] = v
			end
		end
	end

	for k, u in pairs(RoleExtendModule.FavorMaterialsConfig) do
		if RoleExtendModule.FaultItemDataTable[u.Id].index <= 0 then
			local ItemData = ItemData.CreateByCIDAndNumber(u.Id, 0)

			RoleExtendModule.TargetCustomDic[u.Id] = ItemData

			table.insert(_ret, ItemData)
		end
	end

	RoleExtendModule.FavorMaterialsDataList = _ret

	return _ret
end

function RoleExtendModule.FavorQualitySort(tb1, tb2)
	if tb1:GetCfg().Quality > tb2:GetCfg().Quality then
		return true
	elseif tb1:GetCfg().Quality == tb2:GetCfg().Quality then
		if tb1.num > tb2.num then
			return true
		end

		return false
	else
		return false
	end
end

function RoleExtendModule.FavorNumSort(tb1, tb2)
	if tb1.num > tb2.num then
		return true
	elseif tb1.num == tb2.num then
		if tb1:GetCfg().Quality > tb2:GetCfg().Quality then
			return true
		end

		return false
	else
		return false
	end
end

function RoleExtendModule.GetSortedSoulDataList(sort_type, dataDic)
	local ret = {}

	for i, v in pairs(dataDic) do
		ret[#ret + 1] = v
	end

	local sortFunction

	if sort_type == RoleExtendModule.sortType.EaseQuality then
		sortFunction = RoleExtendModule.FavorQualitySort
	elseif sort_type == RoleExtendModule.sortType.EaseNum then
		sortFunction = RoleExtendModule.FavorNumSort
	end

	log("当前排序类型    " .. tostring(sort_type) .. "   #ret   " .. #ret)
	table.sort(ret, sortFunction)

	if RoleExtendModule.isUpSort == false then
		local _retTable = {}
		local retLength = #ret

		for i, v in ipairs(ret) do
			local index = i - 1

			_retTable[i] = ret[retLength - index]
		end

		return _retTable
	else
		return ret
	end
end

function RoleExtendModule.PreviewExpAndLv()
	local AddOrSubExp = 0

	if RoleExtendModule.OperateData.isAdd then
		AddOrSubExp = RoleExtendModule.OperateData.Data:GetCfg().ActionParams[1] * RoleExtendModule.OperateData.Data.ItemAddOrSubCount
	else
		AddOrSubExp = -RoleExtendModule.OperateData.Data:GetCfg().ActionParams[1] * RoleExtendModule.OperateData.Data.ItemAddOrSubCount
	end

	RoleExtendModule.PreviewAddExp = RoleExtendModule.PreviewAddExp + AddOrSubExp

	local MinTable = RoleExtendModule.MaxTable
	local PreveiwLv = 0
	local PreveiwLv2 = 0
	local TargetExp = 0
	local PreviewCurExp = 0
	local PreviewNextExp = 0

	if WarlockModule.curWarlockData.favorabilityLevel > 0 then
		TargetExp = WarlockModule.curWarlockData.favorabilityExp + MinTable[WarlockModule.curWarlockData.favorabilityLevel] + RoleExtendModule.PreviewAddExp
	else
		TargetExp = RoleExtendModule.PreviewAddExp
	end

	for i = 1, #MinTable do
		if TargetExp > MinTable[i] then
			PreveiwLv = i
			PreveiwLv2 = i
		elseif TargetExp == MinTable[i] then
			PreveiwLv2 = i
		else
			break
		end
	end

	if PreveiwLv == 0 then
		PreviewCurExp = TargetExp
	else
		PreviewCurExp = TargetExp - RoleExtendModule.MaxTable[PreveiwLv]
	end

	if CfgFavorLvTable[PreveiwLv + 1] ~= nil then
		PreviewNextExp = CfgFavorLvTable[PreveiwLv + 1].FavorExp
	end

	local PreveiwisMax = false

	if PreveiwLv2 == #MinTable then
		PreveiwisMax = true
	end

	RoleExtendModule.PreviewIsMax = PreveiwisMax

	return PreveiwLv, PreviewCurExp, PreviewNextExp, PreveiwisMax, PreveiwLv2
end

function RoleExtendModule.GetIntensifyMinLimitExp()
	local CfgFavorLv = {}

	for i = 1, #CfgFavorLvTable - 1 do
		table.insert(CfgFavorLv, CfgFavorLvTable[i])
	end

	table.sort(CfgFavorLv, function(a, b)
		return a.Id < b.Id
	end)

	local min_exp = 0
	local max_exp = 0

	for i = 1, #CfgFavorLv do
		RoleExtendModule.MinTable[i] = min_exp
		min_exp = min_exp + CfgFavorLv[i].FavorExp
		max_exp = max_exp + CfgFavorLv[i].FavorExp
		RoleExtendModule.MaxTable[i] = max_exp
	end

	return RoleExtendModule.MinTable
end

function RoleExtendModule.UpdateRemoveItemDataDic(deleteItems)
	for i, v in pairs(deleteItems) do
		if RoleExtendModule.TargetCustomDic[v.id] ~= nil then
			RoleExtendModule.TargetCustomDic[v.id] = nil
			RoleExtendModule.ScrollAreaScrollRefresh = true
			RoleExtendModule.FaultItemDataTable[v.cid].index = RoleExtendModule.FaultItemDataTable[v.cid].index - 1

			if RoleExtendModule.FaultItemDataTable[v.cid].index <= 0 then
				local ItemData = ItemData.CreateByCIDAndNumber(v.cid, 0)

				RoleExtendModule.TargetCustomDic[v.cid] = ItemData
			end
		end
	end
end

function RoleExtendModule.AddEventListeners()
	EventDispatcher.AddEventListener(EventID.DeleteItem, RoleExtendModule.UpdateRemoveItemDataDic)
end

function RoleExtendModule.Shutdown()
	EventDispatcher.RemoveEventListener(EventID.DeleteItem, RoleExtendModule.UpdateRemoveItemDataDic)
end

function RoleExtendModule.ResetAll()
	RoleExtendModule.PreviewIsMax = false
	RoleExtendModule.PreviewAddExp = 0

	for i, v in pairs(RoleExtendModule.TargetCustomDic) do
		if RoleExtendModule.TargetCustomDic[i].ItemCustomCount ~= nil then
			RoleExtendModule.TargetCustomDic[i].ItemCustomCount = nil
		end

		if RoleExtendModule.TargetCustomDic[i].ItemAddOrSubCount ~= nil then
			RoleExtendModule.TargetCustomDic[i].ItemAddOrSubCount = nil
		end
	end

	RoleExtendModule.CustomItemDic = {}
end

function RoleExtendModule.SetLimitMaxExp()
	local MinTable = RoleExtendModule.MaxTable

	if WarlockModule.curWarlockData.favorabilityLevel == 0 then
		RoleExtendModule.MaxOwnExp = RoleExtendModule.MaxTable[#RoleExtendModule.MaxTable]
	else
		local exp = 0

		exp = WarlockModule.curWarlockData.favorabilityExp + MinTable[WarlockModule.curWarlockData.favorabilityLevel]
		RoleExtendModule.MaxOwnExp = RoleExtendModule.MaxTable[#RoleExtendModule.MaxTable] - exp
	end
end

function RoleExtendModule.FavorabilityExpItem(heroCid, items)
	net_hero.favorabilityExpItem(heroCid, items)
end

function RoleExtendModule.FavorabilityExpItemResult(code, up)
	EventDispatcher.Dispatch(EventID.HeroFavorRefreshEvent)
	EventDispatcher.Dispatch(EventID.FavorPrepareResetEvent)
end
