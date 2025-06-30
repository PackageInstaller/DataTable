-- chunkname: @IQIGame\\Module\\RoleInfoDetails\\RoleInfoDetailsModule.lua

RoleInfoDetailsModule = {}

function RoleInfoDetailsModule.GetHeroCfg(heroCid)
	return CfgHeroTable[heroCid]
end

function RoleInfoDetailsModule.GetHeroAllVoices(heroCid)
	local voicesList = {}

	for _, v in pairsCfg(CfgCVHeroTable) do
		if v.HeroId == heroCid then
			table.insert(voicesList, v)
		end
	end

	table.sort(voicesList, function(a, b)
		return a.Id < b.Id
	end)

	return voicesList
end

function RoleInfoDetailsModule.GetHeroVoicesWithType(heroCid, type)
	local voicesList = {}

	for _, v in pairsCfg(CfgCVHeroTable) do
		if v.HeroId == heroCid and v.Type == type then
			table.insert(voicesList, v)
		end
	end

	table.sort(voicesList, function(a, b)
		return a.Id < b.Id
	end)

	return voicesList
end

function RoleInfoDetailsModule.GetHeroVoicesWithType_old(heroCid, type)
	local voicesList = {}

	for _, v in pairsCfg(CfgHeroSoundTable) do
		if v.HeroId == heroCid and v.Type == type then
			table.insert(voicesList, v)
		end
	end

	table.sort(voicesList, function(a, b)
		return a.Id < b.Id
	end)

	return voicesList
end

function RoleInfoDetailsModule.GetHeroUnLockVoices(heroCid)
	return WarlockModule.WarlockDataDic[heroCid].voices
end

function RoleInfoDetailsModule.GetHeroVoiceIsUnLock(heroCid, HerosoundId)
	local voices = RoleInfoDetailsModule.GetHeroUnLockVoices(heroCid)

	for i = 1, #voices do
		if voices[i] == HerosoundId then
			return true
		end
	end

	return false
end

function RoleInfoDetailsModule.GetHeroAllDeeds(heroCid)
	local deedsList = {}

	for _, v in pairsCfg(CfgHeroStoryTable) do
		if v.HeroId == heroCid then
			table.insert(deedsList, v)
		end
	end

	table.sort(deedsList, function(a, b)
		return a.Id < b.Id
	end)

	return deedsList
end

function RoleInfoDetailsModule.GetHeroUnLockDeeds(heroCid)
	return WarlockModule.WarlockDataDic[heroCid].deeds
end

function RoleInfoDetailsModule.GetHeroDeedsIsUnLock(heroCid, HeroDeedId)
	local deeds = RoleInfoDetailsModule.GetHeroUnLockDeeds(heroCid)

	for i = 1, #deeds do
		if deeds[i] == HeroDeedId then
			return true
		end
	end

	return false
end

function RoleInfoDetailsModule.GetIsUnlockHero(heroCid)
	return WarlockModule.WarlockDataDic[heroCid] == nil
end

function RoleInfoDetailsModule.GetHeroFavorLevelCfg(heroID, level)
	for _, v in pairsCfg(CfgFavorLvTable) do
		if v.HeroID == heroID and v.FavorLv == level then
			return v
		end
	end
end

function RoleInfoDetailsModule.GetHeroFavorLevelMax(heroID)
	local lv = -1

	for _, v in pairsCfg(CfgFavorLvTable) do
		if v.HeroID == heroID then
			lv = lv + 1
		end
	end

	return lv
end

function RoleInfoDetailsModule.GetHeroStoryList(heroID)
	local tb = {}

	for _, v in pairsCfg(CfgWorldMapItemTable) do
		if v.HeroID == heroID then
			table.insert(tb, v)
		end
	end

	table.sort(tb, function(a, b)
		return a.Id < b.Id
	end)

	return tb
end

function RoleInfoDetailsModule.GetHeroFavorGiftList()
	local itemDataList = {}

	for _, cfgItem in pairsCfg(CfgItemTable) do
		if cfgItem.ItemTypes == Constant.ItemType.Item and cfgItem.ItemSubTypes and cfgItem.ItemSubTypes == Constant.ItemSubType[Constant.ItemType.Item].FavorGift then
			local tb = {}

			tb.itemId = cfgItem.Id
			tb.value = cfgItem.ActionParams[1]
			tb.quality = cfgItem.Quality
			tb.count = WarehouseModule.GetItemNumByCfgID(cfgItem.Id)

			table.insert(itemDataList, tb)
		end
	end

	table.sort(itemDataList, function(a, b)
		if a.value ~= b.value then
			return a.value > b.value
		end

		if a.quality ~= b.quality then
			return a.quality > b.quality
		end

		return a.itemId < b.itemId
	end)

	return itemDataList
end
