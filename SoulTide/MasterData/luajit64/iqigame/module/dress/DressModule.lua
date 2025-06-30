-- chunkname: @IQIGame\\Module\\Dress\\DressModule.lua

DressModule = {
	updateFlagSortSoulDress = false,
	dressDataDic = {}
}

function DressModule.Reload(dressPODList)
	DressModule.dressDataDic = {}

	for i, v in pairsCfg(CfgDressTable) do
		local data = DressData.New()

		data:Initialize(i, nil)

		DressModule.dressDataDic[i] = data
	end

	for i, v in pairs(dressPODList) do
		local data = DressModule.dressDataDic[v.dressCid]

		data:Refresh(v)
	end
end

function DressModule.SortSoulDresses()
	if DressModule.updateFlagSortSoulDress == false then
		return
	end

	for i, v in pairs(DressModule.dressDataDic) do
		if v:GetRemnantSeconds() == 0 then
			local soulData = v:GetSoulData()

			if soulData ~= nil then
				local dressType = v.cfgDressRow.Type

				soulData:SortDress(dressType)
			end
		end
	end

	DressModule.updateFlagSortSoulDress = false
end

function DressModule.ChangeSpineSkin(goSpine, dressCid)
	local soulResCid = CfgDressTable[dressCid].SoulResID
	local entityId = CfgSoulResTable[soulResCid].UIEntityId
	local skinName = CfgElementEntityTable[entityId].SpineTexture

	if skinName == nil or skinName == "" then
		skinName = "default"
	end

	local graphic = goSpine:GetComponent("SkeletonGraphic")

	graphic.Skeleton:SetSkin(skinName)
end

function DressModule.CheckDressIsWore(dressCid)
	local soulData = DressModule.GetSoulDataBaseOnDressCid(dressCid)

	if dressCid == soulData.dressCid2D or dressCid == soulData.dressCid3D then
		return true
	end

	return false
end

function DressModule.CheckOwnedDress(dressCid)
	return DressModule.dressDataDic[dressCid].hasOwned
end

function DressModule.GetSoulDataBaseOnDressCid(dressCid)
	return SoulModule.GetSoulData(CfgDressTable[dressCid].SoulID)
end

function DressModule.GetSoulDressDataList(soulCid, dressType)
	local ret = {}

	for i, v in pairs(DressModule.dressDataDic) do
		if v.cfgDressRow.SoulID == soulCid and v.cfgDressRow.Type == dressType and (not v.cfgDressRow.IsHide or DressModule.CheckOwnedDress(v.dressCid)) then
			local show = false
			local curChannel = tostring(PlayerModule.PlayerInfo.baseInfo.channelNo)

			if #v.cfgDressRow.Channels > 0 then
				for i1, v1 in ipairs(v.cfgDressRow.Channels) do
					if curChannel == v1 then
						show = true

						break
					end
				end
			else
				show = true

				for i2, v2 in ipairs(v.cfgDressRow.InvisibleChannels) do
					if curChannel == v2 then
						show = false

						break
					end
				end
			end

			if show then
				ret[#ret + 1] = v
			end
		end
	end

	table.sort(ret, function(a, b)
		return a.dressCid < b.dressCid
	end)

	return ret
end

function DressModule.GetDressSpineBgPath(dressCid)
	return UIGlobalApi.GetElementPrefab(CfgSoulResTable[CfgDressTable[dressCid].SoulResID].BgPrefabs)
end

function DressModule.CheckExistConfigSpineDress(dressCid)
	return CfgSoulResTable[CfgDressTable[dressCid].SoulResID].SpineActionControl ~= 0
end

function DressModule.ReqWearDress(dressCid)
	net_dress.wear(dressCid)

	DressModule.dressCidRequestToWear = dressCid
end

function DressModule.OnResultWearDress()
	local soulData = DressModule.GetSoulDataBaseOnDressCid(DressModule.dressCidRequestToWear)

	soulData:OnWearDressSuccess(DressModule.dressCidRequestToWear)
	EventDispatcher.Dispatch(EventID.DressWearSuccess, DressModule.dressCidRequestToWear)
	NoticeModule.ShowNotice(21041007)
end

function DressModule.ReqViewDress(dressCid)
	net_dress.viewDress(dressCid)

	DressModule.dressDataDic[dressCid].isNew = true
end

function DressModule.OnNotifyUpdateDress(type, dressPOD)
	local dressData = DressModule.dressDataDic[dressPOD.dressCid]
	local soulData = dressData:GetSoulData()

	if soulData == nil then
		return
	end

	if type == 1 then
		dressData:Refresh(dressPOD)
		soulData:OnGetNewDress(dressData)
		EventDispatcher.Dispatch(EventID.DressUnlockNew, dressPOD.dressCid)

		if CfgDressTable[dressPOD.dressCid].InitialDress ~= 1 then
			UIModule.Open(Constant.UIControllerName.DressUnlockUI, Constant.UILayer.UI, dressPOD.dressCid)
		end
	elseif type == 2 then
		dressData:Refresh(dressPOD)
	elseif type == 3 then
		dressData:Refresh(nil)
		soulData:OnDressTimeout(dressData)

		DressModule.updateFlagSortSoulDress = true

		EventDispatcher.Dispatch(EventID.DressDelete, dressPOD.dressCid)
	end
end
