-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/util/ContainmentUtil.lua

module("logic.extensions.containmentzone.util.ContainmentUtil", package.seeall)

local ContainmentUtil = {}

function ContainmentUtil.mathRound(value)
	value = tonumber(value) or 0

	return math.floor(value + 0.5)
end

function ContainmentUtil.sortProtomerCfgCompare(itemA, itemB)
	if itemA == nil or itemB == nil then
		return false
	end

	if itemA.id == itemB.id then
		return false
	end

	return itemA.id < itemB.id
end

function ContainmentUtil.sortHoldRoomReport(orgTable)
	local result = {}

	if orgTable then
		local keyLst = {}

		for k, v in pairs(orgTable) do
			table.insert(keyLst, {
				key = k,
				val = v
			})
		end

		table.sort(keyLst, function(a, b)
			return tonumber(a.val:getUuid()) > tonumber(b.val:getUuid())
		end)

		for key, value in pairs(keyLst) do
			local val = value.val

			table.insert(result, val)
		end
	end

	return result
end

function ContainmentUtil.moduleEnhanceFunc(orgVal, limitEffectId, effectId, param)
	if effectId ~= limitEffectId then
		return orgVal
	end

	local finalVal = orgVal + param

	return finalVal
end

function ContainmentUtil.getPreferenName(preferenTyp)
	if preferenTyp <= 0 then
		return ""
	end

	local cfgPreferen = ContainmentConfig.instance:getPreferenCfg(preferenTyp)

	if cfgPreferen then
		return cfgPreferen.nameattr or ""
	else
		return ""
	end
end

function ContainmentUtil.getTouchDefineName(touchWay, protomerId)
	local cfg = ContainmentConfig.instance:getTouchDefine(touchWay)
	local touchName = cfg and cfg.name or ""

	if protomerId then
		local cfgInfo = ContainmentConfig.instance:getProtomerInfoCoById(protomerId)

		if cfgInfo and cfgInfo.touchname and cfgInfo.touchname[touchWay] then
			touchName = cfgInfo.touchname[touchWay]
		end
	end

	return touchName
end

function ContainmentUtil.getProtomerName(protomerId)
	local backPackConfig = ContainmentConfig.instance:getProtomerBackpackCfg(protomerId)

	if backPackConfig then
		return backPackConfig.name or ""
	else
		return ""
	end
end

function ContainmentUtil.getProtomerSerialNum(protomerId)
	local cfgInfo = ContainmentConfig.instance:getProtomerInfoById(protomerId)
	local degree, serialnum

	if cfgInfo then
		degree, serialnum = cfgInfo.serialdegree, cfgInfo.serialnum
	else
		degree, serialnum = "?", "?"
	end

	return degree, serialnum
end

function ContainmentUtil.getProtomerSerialNumShow(protomerId)
	local degree, serialnum = ContainmentUtil.getProtomerSerialNum(protomerId)

	return string.format("%s-%s", degree, serialnum)
end

function ContainmentUtil.getProtomerPrototypeTableLst(protomerId)
	return
end

function ContainmentUtil.getProtomerProductivitySecond(roomId, protomerId, onlyBase)
	if protomerId > 0 then
		local cfgProtomer = ContainmentConfig.instance:getProtomerCoById(protomerId)
		local productivityNeed = cfgProtomer.productivity
		local second = 0
		local serverScheduleTime = HouseMainEnum.ServerScheduleTime

		second = productivityNeed / ContainmentUtil.getProductivityPer(roomId, onlyBase) * serverScheduleTime

		if second % serverScheduleTime ~= 0 then
			second = second + (serverScheduleTime - second % serverScheduleTime)
		end

		return math.floor(second)
	else
		print(string.format("尝试获取room[%d]生产力,原体id为[%d],将返回0", roomId, protomerId))

		return 0
	end
end

function ContainmentUtil.getProductivityPer(roomId, onlyBase)
	local baseP = ContainmentConfig.instance:getConstByKey("BaseDefaultProduction")
	local roomInfoMo = ContainmentModel.instance:getRoomInfoById(roomId)

	if roomInfoMo then
		local heroProductivity = roomInfoMo:getProductHero()
		local houseProductMulti = roomInfoMo:getProductHouseRatio()

		if onlyBase then
			return baseP
		else
			local serverVal = roomInfoMo:getProductSpeed()

			return serverVal > 0 and serverVal or (baseP + heroProductivity) * (1 + houseProductMulti)
		end
	else
		return baseP
	end
end

function ContainmentUtil.getCharacterProductivityEffect(roomId)
	local roomInfoMo = ContainmentModel.instance:getRoomInfoById(roomId)
	local blueVal = 0
	local redVal = 0

	if roomInfoMo then
		blueVal = roomInfoMo:getProductHero()
		redVal = roomInfoMo:getProductHouseRatio() * 100
	end

	return blueVal, redVal
end

function ContainmentUtil.roomTabSelectCheckFunc(tabIndex)
	local roomId = tabIndex + 1100
	local openType = HouseMainRoomModel.instance:getRoomOpenTyp(roomId)

	if openType == HouseMainEnum.RoomOpenTyp.OpenLock then
		FloatWordMgr.instance:show(langF("tip_house_holdroom_idname", tabIndex) .. lang("tip_not_unlock"))
	elseif openType == HouseMainEnum.RoomOpenTyp.OpenUnActive then
		FloatWordMgr.instance:show(langF("tip_house_holdroom_idname", tabIndex) .. lang("tip_no_activate"))
	end

	return openType == HouseMainEnum.RoomOpenTyp.OpenActive
end

function ContainmentUtil.getHeroHeadIconSrc(heroId)
	local cfgCharacter = CharacterConfig.instance:getCharacterItemInfo(heroId)

	return cfgCharacter and CharacterCOUtil.getIcon(cfgCharacter) or ""
end

function ContainmentUtil.getHeroName(heroId)
	local name = ""

	if heroId and heroId > 0 then
		local heroIntroCfg = PastInfoConfig.instance:getCharacterInfo(heroId)

		if heroIntroCfg then
			name = heroIntroCfg.name
		elseif heroId == PlayerModel.instance:getPlayerRoleCode() then
			name = PlayerModel.instance:getNickName()
		else
			printError(string.format("无法从[t_%s]找到[%s]的信息", ConfigName.CharacterInfo, heroId))
		end
	end

	return name
end

function ContainmentUtil.getHeroRoomMood(heroId)
	local mood = 0
	local heroFeatureMo = HeroHouseFeatureModel.instance:getFeatureMO(heroId)

	if heroFeatureMo then
		mood = heroFeatureMo:getMood()
	else
		printWarn(string.format("无法从HeroHouseFeatureModel获取角色[%d]的数据，发送协议重新获取", heroId))
		HouseAgent.instance:sendGetSingleHeroFeatureRequest(heroId)
	end

	return mood
end

function ContainmentUtil.getHeroMoodCost(heroId)
	local mood_cost = 0
	local heroFeatureMo = HeroHouseFeatureModel.instance:getFeatureMO(heroId)

	if heroFeatureMo then
		mood_cost = heroFeatureMo:getMoodCost() or 0
	else
		printWarn(string.format("无法从HeroHouseFeatureModel获取角色[%s]的数据，发送协议重新获取", heroId))
		HouseAgent.instance:sendGetSingleHeroFeatureRequest(heroId)
	end

	return mood_cost
end

function ContainmentUtil.getHeroMoodRecover(heroId)
	local mood_recover = 0
	local heroFeatureMo = HeroHouseFeatureModel.instance:getFeatureMO(heroId)

	if heroFeatureMo then
		mood_recover = heroFeatureMo:getMoodRecover() or 0
	else
		printWarn(string.format("无法从HeroHouseFeatureModel获取角色[%s]的数据，发送协议重新获取", heroId))
		HouseAgent.instance:sendGetSingleHeroFeatureRequest(heroId)
	end

	return mood_recover
end

function ContainmentUtil.getHeroQuaValByProtomerPreferen(heroId, preferenTyp)
	local val = 0
	local cfgCharacter = CharacterConfig.instance:getCharacterItemInfo(heroId)

	if cfgCharacter then
		local quaIndex = ContainmentEnum.Preferen2CharacterQua[preferenTyp]

		val = cfgCharacter.qua6[quaIndex]
	else
		printError(string.format("无法从[t_%s]获取[%s]的配置", ConfigName.Character, heroId))
	end

	return val
end

function ContainmentUtil.getRoomHeroMoodBaseCost()
	local cost = SupervisorModel.instance:getTotalMoodCost() * 60

	return cost
end

function ContainmentUtil.getDefaultMoodCost()
	local defaultCost = HouseConfig.instance:getDefaultMoodCost() * 60

	return defaultCost
end

function ContainmentUtil.getRoomHeroMoodSkillMinus(heroId)
	local baseCost = ContainmentUtil.getRoomHeroMoodBaseCost()
	local realHeroMoodCost = ContainmentUtil.getHeroMoodCost(heroId) * 60

	if realHeroMoodCost == 0 then
		return 0
	end

	local minusPercent = (baseCost - realHeroMoodCost) / baseCost

	minusPercent = math.floor(minusPercent * 100)

	return minusPercent
end

function ContainmentUtil.getProtomerInfoTitle(typ, isCh)
	local key = ContainmentEnum.ProtomerInfoMsgTitle[typ]

	if key then
		return isCh and lang(key) or lang(key, LanguageType.EN)
	else
		return ""
	end
end

function ContainmentUtil.changeBillBoardIcon(img, protomerId, typ, billBoardId)
	if img == nil then
		printError("尝试更换billboardIcon,传入img为空")

		return
	end

	local cfgProtomerInfo = ContainmentConfig.instance:getProtomerInfoById(protomerId)
	local iconUrl = ContainmentEnum.billBoardIcon[billBoardId]

	if cfgProtomerInfo and cfgProtomerInfo.billboardicon then
		iconUrl = cfgProtomerInfo.billboardicon[billBoardId + 1]
	end

	IconLoader.setSprite(img, IconType.Room, string.format("room_billboard%d/%s", typ, iconUrl))
end

function ContainmentUtil.getBillBoardName(protomerId, billboardId)
	local cfgProtomerInfo = ContainmentConfig.instance:getProtomerInfoById(protomerId)

	if cfgProtomerInfo and cfgProtomerInfo.billboardname then
		return cfgProtomerInfo.billboardname[billboardId + 1]
	else
		return lang(ContainmentEnum.billBoardName[billboardId]) or ""
	end
end

function ContainmentUtil.setProtomerDynIcon(img, protomerId, withBg)
	protomerId = 1901001

	if img then
		local path = withBg and string.format("room_holding_goods1/%d", protomerId) or string.format("room_holding_goods/%d", protomerId)

		IconLoader.setSprite(img, IconType.Room, path)
	end
end

function ContainmentUtil.setProtomerBigBg(img, protomerId)
	protomerId = 1901001

	local bgName = protomerId

	img:SetImage(GameUrl.getBigBgUrlByPrefix("room/room_holding_goods", bgName), nil, self)
end

function ContainmentUtil.setProtomerBigBgPreview(img, protomerId)
	protomerId = 1901001

	local bgName = string.format("srw_bg2_%d", protomerId)

	img:SetImage(GameUrl.getBigBgUrlByPrefix("room", bgName), nil, self)
end

function ContainmentUtil.duelReportLst_Rewards(rewards, rewardsTable)
	local len = rewards and #rewards or 0

	if len > 0 then
		for index, value in ipairs(rewards) do
			local itemCode = value.itemCode
			local itemCount = value.itemCount
			local canPileUp = ContainmentUtil.canItemPileUp(itemCode)

			if canPileUp then
				local index = -1
				local orgItemCount = 0

				for i, v in ipairs(rewardsTable or {}) do
					if v.itemCode == itemCode then
						index = i
						orgItemCount = v.itemCount
					end
				end

				itemCount = itemCount + orgItemCount

				if index >= 0 then
					rewardsTable[index] = {
						itemCode = itemCode,
						itemCount = itemCount
					}
				else
					table.insert(rewardsTable, value)
				end
			else
				table.insert(rewardsTable, value)
			end
		end
	end
end

function ContainmentUtil.canItemPileUp(itemId)
	local ItemTypeEnum = GameEnum.ItemTypeEnum
	local typ, subTyp = ItemUtil.getItemTypeByItemId(itemId)

	return typ ~= ItemTypeEnum.EquipItemType and typ ~= ItemTypeEnum.EchoItemType and typ ~= ItemTypeEnum.RoguelikeEquipType
end

return ContainmentUtil
