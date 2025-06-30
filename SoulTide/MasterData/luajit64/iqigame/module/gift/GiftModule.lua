-- chunkname: @IQIGame\\Module\\Gift\\GiftModule.lua

GiftModule = {
	isDelayShow = false,
	remainderGiveGiftNum = 0
}

function GiftModule.ReloadGift(data)
	GiftModule.remainderGiveGiftNum = data
	GiftModule.giftsDic = {}

	local giftData

	for k, v in pairsCfg(CfgGiftTable) do
		giftData = GiftData.New()

		giftData:Init(v.Id)

		GiftModule.giftsDic[#GiftModule.giftsDic + 1] = giftData
	end

	table.sort(GiftModule.giftsDic, GiftModule.Sort)
end

function GiftModule.Sort(tb1, tb2)
	local aq = tonumber(tb1.quality)
	local bq = tonumber(tb2.quality)

	return bq < aq
end

function GiftModule.GetGiftDataByID(giftID)
	for k, v in pairs(GiftModule.giftsDic) do
		if v.Id == giftID then
			return v
		end
	end

	return nil
end

function GiftModule.GetAction(giftCid, soulID, isCheckCondition)
	local actionID = 0
	local actionTab = CfgGiftActionTable[soulID]

	if isCheckCondition then
		local conditionID

		for i = 1, #actionTab.Condition do
			conditionID = actionTab.Condition[i]

			if conditionID > 0 and ConditionModule.Check(conditionID) then
				actionID = actionTab.Action[i]

				log("送礼条件检测 conditionID= " .. conditionID .. " actionID = " .. actionID)

				return actionID
			end
		end
	end

	local giftData = GiftModule.GetGiftDataByID(giftCid)

	if giftData ~= nil then
		local id, inclination

		for j = 1, #giftData.cfgGiftInfo.SoulId do
			id = giftData.cfgGiftInfo.SoulId[j]

			if id == soulID then
				inclination = giftData.cfgGiftInfo.Inclination[j]

				if inclination == 1 then
					actionID = actionTab.Dislike
				elseif inclination == 2 then
					actionID = actionTab.General
				elseif inclination == 3 then
					actionID = actionTab.Favourate
				elseif inclination == 4 then
					actionID = actionTab.FavourateFood1
				elseif inclination == 5 then
					actionID = actionTab.FavourateFood2
				elseif inclination == 6 then
					actionID = actionTab.DislikeFood1
				elseif inclination == 7 then
					actionID = actionTab.DislikeFood2
				elseif inclination == 8 then
					actionID = actionTab.GeneralFood1
				elseif inclination == 9 then
					actionID = actionTab.GeneralFood2
				elseif inclination == 10 then
					actionID = actionTab.GeneralFood3
				elseif inclination == 11 then
					actionID = actionTab.CommentFood1
				elseif inclination == 12 then
					actionID = actionTab.CommentFood2
				end

				return actionID
			end
		end
	end

	return actionID
end

function GiftModule.GetItemFavorType(giftData, souldCid)
	local index = 0

	for v, id in pairs(giftData.cfgGiftInfo.SoulId) do
		if id == souldCid then
			index = v

			break
		end
	end

	local giftFavorType = giftData.cfgGiftInfo.Inclination[index]

	giftData.giftFavorType = giftFavorType

	return giftFavorType
end

function GiftModule.GetSoulGiftType(giftID, soulID)
	local type
	local cfgGift = CfgGiftTable[giftID]
	local index = table.indexOf(cfgGift.SoulId, soulID)

	if index ~= -1 then
		local state = cfgGift.Inclination[index]
		local favorTab = CfgDiscreteDataTable[6520055].Data
		local normalTab = CfgDiscreteDataTable[6520056].Data
		local sick = CfgDiscreteDataTable[6520057].Data

		if table.indexOf(favorTab, state) ~= -1 then
			type = Constant.SoulGiftType.Favor
		elseif table.indexOf(normalTab, state) ~= -1 then
			type = Constant.SoulGiftType.Normal
		elseif table.indexOf(sick, state) ~= -1 then
			type = Constant.SoulGiftType.Sick
		end
	end

	return type
end

function GiftModule.giveGift(soulCid, giftCid)
	local soulData = SoulModule.GetSoulData(soulCid)

	GiftModule.lastFavorLv = soulData.favorLv
	GiftModule.isDelayShow = true

	net_girl.giveGift(soulCid, giftCid)
end

function GiftModule.GiveGiftResult(soulCid, giftCid, spAddition, addFavor)
	GiftModule.remainderGiveGiftNum = GiftModule.remainderGiveGiftNum - 1

	for k, v in pairs(GirlModule.girlPODs) do
		if v.soulCid == soulCid and GirlModule.girlPODs[k].feedback == nil then
			GirlModule.girlPODs[k].feedback = {}
		end
	end

	local soulData = SoulModule.GetSoulData(soulCid)
	local isFavorUp = soulData.favorLv > GiftModule.lastFavorLv

	EventDispatcher.Dispatch(EventID.GiftGivingSuccess, giftCid, spAddition, addFavor, isFavorUp)
end
