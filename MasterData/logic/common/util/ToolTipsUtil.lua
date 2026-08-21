-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/ToolTipsUtil.lua

module("logic.common.util.ToolTipsUtil", package.seeall)

local convertTempVec
local ItemType = GameEnum.ItemTypeEnum
local PropSubType = GameEnum.PropSubTypeEnum

local function fn(type, subType)
	if type == ItemType.FurnitureItemType or type == ItemType.DiceItem then
		return type * 100000
	else
		return ItemUtil.getItemKeyByTS(type, subType)
	end
end

local itemTipsFuncMap = {}
local itemTipsViewList

function init()
	itemTipsFuncMap[16001] = ToolTipsUtil.createBackgroundTipsData
	itemTipsFuncMap[fn(ItemType.HeroType, PropSubType.None)] = ToolTipsUtil.creatHeroTipsData
	itemTipsFuncMap[fn(ItemType.EquipItemType, PropSubType.None)] = ToolTipsUtil.createEquipTipsData
	itemTipsFuncMap[fn(ItemType.EchoItemType, PropSubType.None)] = ToolTipsUtil.createEchoTipsData
	itemTipsFuncMap[fn(ItemType.DiceItem, PropSubType.None)] = ToolTipsUtil.createD6TipsData
	itemTipsFuncMap[fn(ItemType.ProtomerItemType, PropSubType.None)] = ToolTipsUtil.createProtomerPreviewData
	itemTipsFuncMap[fn(ItemType.FurnitureItemType, PropSubType.None)] = ToolTipsUtil.createFurnitureItemData
	itemTipsFuncMap[fn(ItemType.OnlyShowItem, CommEnum.ItemOnlyShowSubType.SkillItem)] = ToolTipsUtil.creatSkillItemShowTipsData
	itemTipsFuncMap[fn(ItemType.AirBuilding, PropSubType.None)] = ToolTipsUtil.createAirBuildingItemData
	itemTipsFuncMap[fn(ItemType.AirSeasonCup, 1)] = ToolTipsUtil.createAirCupItemData
	itemTipsFuncMap[fn(ItemType.AirAchievementCup, 1)] = ToolTipsUtil.createAirCupItemData
end

function getAllItemTipsView()
	if not itemTipsViewList then
		itemTipsViewList = {
			ViewName.ToolTipsSimpleView
		}

		local _itemData = ItemUtil.createItemData({
			uuid = -1,
			itemId = CommEnum.CurrencyCodeEnum.LzbCode
		})

		for _, _func in pairs(itemTipsFuncMap) do
			local info = _func(_itemData, nil)

			if info and not string.nilorempty(info.viewName) then
				table.insert(itemTipsViewList, info.viewName)
			end
		end
	end

	return itemTipsViewList
end

function convertToTipsPos(obj)
	local convertPX, convertPY, convertPZ = 0, 0, 0

	if obj then
		convertPX, convertPY, convertPZ = Astral.TransformUtil.GetPos(obj.transform, 0, 0, 0)
	end

	return convertPX, convertPY, convertPZ
end

function convertToTipsPivot(obj)
	local pivotX, pivotY = 0.5, 0.5

	if obj then
		pivotX, pivotY = RectTransformUtils.GetPivot(obj.transform, pivotX, pivotY)
	end

	return pivotX, pivotY
end

function createTipsBaseData(itemData, obj, viewName)
	local info = {}

	info.viewName = viewName
	info.baseData = itemData
	info.obj = obj
	info.posX, info.posY, info.posZ = convertToTipsPos(obj)
	info.ownerNum = ItemModel.instance:getItemCountByItemId(itemData:getItemId())

	return info
end

function createCenterTipsData(itemData, anchoredPos, padding, width, heigh, moneyShowType, isPassEvent)
	local info = {}

	info.viewName = ViewName.ToolTipsCenterView
	info.baseData = itemData
	info.posX, info.posY, info.posZ = 0, 0, 0
	info.ownerNum = ItemModel.instance:getItemCountByItemId(itemData:getItemId())
	info.getWaysInfo = SystemJumpModel.instance:getJumpData(itemData:getGetWays())
	info.anchoredPos = anchoredPos
	info.padding = padding
	info.width = width
	info.heigh = heigh
	info.moneyShowType = moneyShowType
	info.isPassEvent = isPassEvent

	return info
end

function createSimpleTipsData(itemData, obj)
	local info = createTipsBaseData(itemData, obj, ViewName.ToolTipsSimpleView)

	info.getWaysInfo = SystemJumpModel.instance:getJumpData(itemData:getGetWays())

	return info
end

function createItemTipsData(itemData, obj, isPassEvent, needItemCount)
	local type, subType = itemData:getType(), itemData:getSubType()
	local func = itemTipsFuncMap[fn(type, subType)]
	local info = func and func(itemData, obj) or createSimpleTipsData(itemData, obj)

	if isPassEvent == nil then
		isPassEvent = true
	end

	info.isPassEvent = isPassEvent
	info.passEvent = isPassEvent
	info.needItemCount = needItemCount

	return info
end

function createFackItemTipsData(itemData, obj, isPassEvent)
	local info = {}

	info.viewName = ViewName.ToolTipsFackEquipView
	info.obj = obj
	info.posX, info.posY, info.posZ = convertToTipsPos(obj)

	if itemData:getUuid() == 0 then
		info.baseData = EquipmentData.New({
			itemId = itemData:getItemInfo().id,
			count = itemData:getCount()
		})
	else
		info.baseData = itemData
	end

	if isPassEvent == nil then
		isPassEvent = true
	end

	info.isPassEvent = isPassEvent
	info.passEvent = isPassEvent

	return info
end

function creatSkillItemShowTipsData(itemData, obj)
	local info = createTipsBaseData(itemData, obj, ViewName.ToolTipsSkillShowItemView)

	return info
end

function createChamberTipsData(itemData, obj)
	local info = createTipsBaseData(itemData, obj, ViewName.ToolTipsChamberView)

	return info
end

function createBackgroundTipsData(itemData, obj)
	local info = {}

	info.viewName = ViewName.CharacterPortraitPreivew
	info.baseData = itemData:getItemId()

	return info
end

function creatHeroTipsData(heroId, isConfigOnly, hangGO)
	local info = {}

	info.heroId = heroId
	info.isConfigOnly = isConfigOnly
	info.posX, info.posY, info.posZ = convertToTipsPos(hangGO)

	return info
end

function creatTeamTipsData(data, obj)
	local info = {}

	info.baseData = data
	info.posX, info.posY, info.posZ = convertToTipsPos(obj)

	return info
end

function createSkillTipsData(skillTipsInfo, isCustom)
	local skillEnhanceMO = isCustom and SkillEnhanceMO.getSharedMO(skillTipsInfo.skillId) or SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(skillTipsInfo.heroId, skillTipsInfo.skillId)

	if isCustom then
		skillEnhanceMO:addSkillEnhanceCodes(skillTipsInfo.enhanceCodes)
		skillEnhanceMO:rebuild()
	end

	local info = {}

	info.heroId = skillTipsInfo.heroId
	info.skillId = skillTipsInfo.skillId
	info.defaultShowAll = skillTipsInfo.defaultShowAll
	info.hangGO = skillTipsInfo.hangGO
	info.obj = skillTipsInfo.hangGO
	info.bindGo = skillTipsInfo.hangGO
	info.skillEnhanceMO = skillEnhanceMO
	info.skillStatus = skillTipsInfo.skillStatus
	info.awakeStatus = skillTipsInfo.awakeStatus and skillTipsInfo.awakeStatus or CommEnum.TalentSkillAwakeStatus.None
	info.popType = skillTipsInfo.popType
	info.posX, info.posY, info.posZ = convertToTipsPos(skillTipsInfo.hangGO)
	info.pivotX, info.pivotY = convertToTipsPivot(skillTipsInfo.hangGO)
	info.direction = Astral.TransformUtil.GetLocalScale(skillTipsInfo.hangGO.transform, 0, 0, 0)

	if skillTipsInfo.isPassEvent == nil then
		skillTipsInfo.isPassEvent = true
	end

	info.isPassEvent = skillTipsInfo.isPassEvent
	info.hideCD = skillTipsInfo.hideCD
	info.hideEnhanceDetail = skillTipsInfo.hideEnhanceDetail
	info.hasDispatch = skillTipsInfo.hasDispatch
	info.level = skillTipsInfo.level
	info.isPreview = skillTipsInfo.isPreview
	info.limitOffsetX = skillTipsInfo.skillTipsInfo
	info.limitOffsetX = skillTipsInfo.limitOffsetX
	info.offsetX = skillTipsInfo.offsetX
	info.offsetY = skillTipsInfo.offsetY
	info.forceAlign = skillTipsInfo.forceAlign
	info.forceTipsAlignVer = skillTipsInfo.forceTipsAlignVer
	info.simulateCloseWhenDraging = skillTipsInfo.simulateCloseWhenDraging
	info.entityId = skillTipsInfo.entityId

	local cameraTarget = CameraTargetMgr.instance:getUICameraTarget()
	local camera = cameraTarget:getCamera()
	local left, right, top, bottom = 0, 0, 0, 0

	left, right, top, bottom = RectTransformUtils.GetViewPortPercent(skillTipsInfo.hangGO.transform, camera, left, right, top, bottom)
	info.viewPortPercent = {
		left,
		right,
		top,
		bottom
	}

	return info
end

function createBattleBuffTipsData(unit, hangGO, forceAlign, forceTipsAlignVer, maskClickClose)
	local info = {}

	info.unit = unit
	info.posX, info.posY, info.posZ = convertToTipsPos(hangGO)
	info.pivotX, info.pivotY = convertToTipsPivot(hangGO)
	info.bindGo = hangGO
	info.forceAlign = forceAlign
	info.forceTipsAlignVer = forceTipsAlignVer
	info.maskClickClose = maskClickClose

	return info
end

function createComposeItemTipsData(itemData, hangGO)
	local info = {}

	info.viewName = ViewName.ComposeItemTips
	info.baseData = itemData
	info.posX, info.posY, info.posZ = convertToTipsPos(hangGO)
	info.ownerNum = ItemModel.instance:getItemCountByItemId(itemData:getItemId())
	info.useBtnTxt = lang("tip_compound")
	info.btnStatus = true
	info.getWaysInfo = SystemJumpModel.instance:getJumpData(itemData:getGetWays())

	return info
end

function createFriendTipsData(data, hangGO, isPassEvent)
	local info = {}

	info.baseData = data
	info.posX, info.posY, info.posZ = convertToTipsPos(hangGO)
	info.pivotX, info.pivotY = convertToTipsPivot(hangGO)
	info.obj = hangGO
	info.isPassEvent = isPassEvent

	return info
end

function createEquipTipsData(itemData, obj)
	local info = {}

	info.viewName = ViewName.ToolTipsEquipView
	info.obj = obj
	info.posX, info.posY, info.posZ = convertToTipsPos(obj)

	if itemData:getUuid() == 0 then
		info.baseData = EquipmentData.New({
			itemId = itemData:getItemInfo().id,
			count = itemData:getCount()
		})
	else
		info.baseData = itemData
	end

	return info
end

function createBattleResultTipsData(itemData, obj)
	local info = {}

	info.viewName = ViewName.ToolTipsBattleResultViewPresentor
	info.baseData = itemData
	info.obj = obj
	info.posX, info.posY, info.posZ = convertToTipsPos(obj)
	info.ownerNum = ItemModel.instance:getItemCountByItemId(itemData:getItemId())

	return info
end

function createEchoTipsData(itemData, obj)
	local info = {}

	info.viewName = ViewName.ToolTipsEchoView

	if itemData:getUuid() == 0 then
		info.baseData = EchoItemData.New({
			itemId = itemData:getItemInfo().id,
			count = itemData:getCount()
		})
	else
		info.baseData = itemData
	end

	info.obj = obj
	info.posX, info.posY, info.posZ = convertToTipsPos(obj)

	return info
end

function createD6TipsData(itemData, obj)
	local info = {}

	info.viewName = ViewName.ToolTipsD6View
	info.baseData = itemData
	info.obj = obj
	info.posX, info.posY, info.posZ = convertToTipsPos(obj)

	return info
end

function createProtomerPreviewData(itemData, obj)
	local info = {}

	info.viewName = ViewName.FacilityHoldingPreviewView
	info.protomerId = itemData:getItemInfo().id
	info.typ = 2

	return info
end

function createFurnitureItemData(itemData, obj)
	local info = {}

	info.viewName = ViewName.ToolTipsFurnitureDetailView
	info.itemId = itemData:getItemInfo().id
	info.itemData = itemData

	return info
end

function createAirBuildingItemData(itemData, obj)
	local info = {}

	info.viewName = ViewName.ToolTipsAirBuildingView
	info.itemId = itemData:getItemInfo().id
	info.baseData = itemData

	return info
end

function createAirCupItemData(itemData, obj)
	local info = {}

	info.viewName = ViewName.ToolTipsAirCupItemPresentor
	info.itemId = itemData:getItemInfo().id
	info.baseData = itemData
	info.bindGo = obj

	return info
end

function createHealthTipsData(itemData)
	local info = {
		itemData = itemData
	}

	return info
end

function createUseItemTipsData(item, maxUseCount, isHandleExpireTime, title, hint)
	local info = {}

	info.item = item
	info.maxUseCount = maxUseCount
	info.isHandleExpireTime = isHandleExpireTime
	info.title = title
	info.hint = hint

	return info
end

function createFacilityHoldingInfoTipsData(roomId, protomerId)
	local info = {}

	info.roomId = roomId
	info.protomerId = protomerId

	return info
end

function createFacilityHoldingBillboardTipsData(rommId)
	local info = {}

	info.roomId = rommId

	return info
end

function createFacilityHoldingModuleTipsData(protomerId, moduleCode, moduleId, moduleLockTyp)
	local info = {}

	info.protomerId = protomerId
	info.moduleCode = moduleCode
	info.moduleId = moduleId
	info.moduleLockTyp = moduleLockTyp

	return info
end

function createFacilityHoldingReportSpeedupTipsData(roomId)
	local info = {}

	info.roomId = roomId

	return info
end

function createFacilityHoldingUnlockConditionTipsData(protomerId)
	local info = {}

	info.protomerId = protomerId

	return info
end

function createHouseRoomActiveTipsData(roomId, focus, callBackFunc, callBackHandler)
	local info = {}

	info.roomId = roomId
	info.focus = focus
	info.callBackFunc = callBackFunc
	info.callBackHandler = callBackHandler

	return info
end

function createDailySignInTipsData()
	local info = {}

	return info
end

function createSevenSignInTipsData(actId)
	local info = {}

	info.actId = actId

	return info
end

function createCurrencyExchangeTipsData(id, minMulti, isMulti, multiStep, titleStr)
	local info = {}

	info.id = id
	info.minMulti = minMulti
	info.isMulti = isMulti
	info.multiStep = multiStep
	info.titleStr = titleStr

	return info
end

function createItemExchangeTipsData(sourceId, targetId, sourceStep, targetStep, isMulti, minMulti, maxLimit, jumpId)
	local info = {}

	info.sourceId = sourceId
	info.targetId = targetId
	info.sourceStep = sourceStep
	info.targetStep = targetStep
	info.isMulti = isMulti
	info.minMulti = minMulti
	info.maxLimit = maxLimit
	info.jumpId = jumpId

	return info
end

function createPoachingPayTipsData(heroId)
	local info = {}

	info.heroId = heroId

	return info
end

function createHandbookMonsterdataEvaluateTipsData(monsterId)
	local info = {}

	info.monsterId = monsterId

	return info
end

function createHandbookCampTipsData(camp)
	local info = {}

	info.camp = camp

	return info
end

function createEchoUpgradeShowViewData(echoItemId, curLevel)
	local info = {}

	info.echoItemId = echoItemId
	info.curLevel = curLevel

	return info
end

function createMultiFightTipsViewData(dungeonId, maxMultiCount, canQuickFight, canProxy, gamePlay)
	local info = {}

	info.dungeonId = dungeonId
	info.maxMultiCount = maxMultiCount
	info.canQuickFight = canQuickFight
	info.canProxy = canProxy
	info.gamePlay = gamePlay

	return info
end

function createControlActionMultiFightData(dungeonId, gamePlay)
	local monitorMo = ControlActionModel.instance:getMonitorMO(dungeonId)
	local dungeonMo = DungeonModel.instance:getDungeonMoById(dungeonId)
	local rewardCodeInfo, rewardCodeZone

	if monitorMo then
		local index = monitorMo:getDungeonIndex(dungeonId)
		local groupCo = monitorMo:getDungeonGroupCo()

		rewardCodeInfo = groupCo.reward[index]
		rewardCodeZone = monitorMo:getZoneCo().reward[index]
	end

	local battleInfo = ControlActionModel.instance:getBattleInfo()
	local info = {}

	info.viewId = battleInfo and battleInfo.viewId or 1
	info.difficultIndex = battleInfo and battleInfo.difficultIndex or 1
	info.rewardCodeConst = ConstConfig.instance:getNumValueByKey("ControlActionReward")
	info.rewardCodeInfo = rewardCodeInfo
	info.rewardCodeZone = rewardCodeZone
	info.dungeonMo = dungeonMo
	info.canProxy = dungeonMo:canRecord()
	info.gamePlay = gamePlay

	if gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		info.maxMultiCount = dungeonMo:getConsecutiveLimit()
	else
		info.maxMultiCount = dungeonMo:getMultiplicityLimit()
	end

	return info
end

function createAirWorkShopRodeoCheckRecordTipsData()
	local info = {
		page = 1,
		type = AirAtkExtension_pb.RecordType.RECORD_RODEO
	}

	return info
end

function createAirWorkShopFreeCheckRecordTipsData()
	local info = {
		page = 1,
		type = AirAtkExtension_pb.RecordType.RECORD_FREE
	}

	return info
end

function createAirWorkShopRodeoRewardTipsData()
	local info = {}

	return info
end

function createAirWorkShopChallengeStatisticsTipsData(id)
	local info = {}

	info.id = id

	return info
end

function createAirWorkShopFreeRankTipsViewData()
	local info = {}

	return info
end

function createOpenFunctionsHintTipsData(code, singleMode, exitFunc, exitHandler)
	local info = {}

	info.code = code
	info.singleMode = singleMode
	info.exitFunc = exitFunc
	info.exitHandler = exitHandler

	return info
end

function createHouseFurnitureSimpleInfoTipsData(itemId)
	local info = {}

	info.itemId = itemId

	return info
end

function createCharacterTopToastData(content, topToastIcon, delayHide, isPermanent)
	local info = {
		content = content,
		topToastIcon = topToastIcon and topToastIcon or CommEnum.CharacterTopToastIcon.Info,
		delayHide = delayHide,
		isPermanent = isPermanent
	}

	return info
end

function createCharacterRoleFileTipsData(heroId)
	local info = {
		heroId = heroId
	}

	return info
end

function createCharacterVoiceTipsData(heroId)
	local info = {
		heroId = heroId
	}

	return info
end

function createCharacterHeartAnchorImpressionUpgradeResultTipsData(heroId, lvBefore, lvAfter)
	local info = {
		heroId = heroId,
		lvBefore = lvBefore,
		lvAfter = lvAfter
	}

	return info
end

function createCharacterHeartAnchorCarryItemInfoTipsData(heroId, carryItemId)
	local info = {
		heroId = heroId,
		carryItemId = carryItemId
	}

	return info
end

function createBranchUnlockTipsData(dungeonId, inPlotOpen)
	local info = {
		dungeonId = dungeonId,
		inPlotOpen = inPlotOpen
	}

	return info
end

function createTopToastRewardItemNoticeData(itemDataList, delayHide)
	local info = {
		itemDataList = itemDataList,
		delayHide = delayHide
	}

	return info
end

function createSkillBuffTagSideTipsData(skillEnhanceMO, bindGo, isPassEvent, heroId, skillId, skillEnhanceCodeLst)
	local info

	if skillEnhanceMO then
		-- block empty
	else
		local isCustom = false

		if skillEnhanceCodeLst and #skillEnhanceCodeLst > 0 then
			isCustom = true
		end

		skillEnhanceMO = isCustom and SkillEnhanceMO.getSharedMO(skillId) or SkillEnhanceModel.instance:getCharacterSkillEnhanceMO(heroId, skillId)

		if isCustom then
			skillEnhanceMO:addSkillEnhanceCodes(skillEnhanceCodeLst)
			skillEnhanceMO:rebuild()
		end
	end

	if skillEnhanceMO then
		local buffCodes = {}
		local tagCodes = {}

		skillEnhanceMO:buildDescription()
		skillEnhanceMO:fillTagIdList(tagCodes)
		skillEnhanceMO:fillBuffCodesList(buffCodes)

		if #buffCodes <= 0 and #tagCodes <= 0 then
			return
		end

		if isPassEvent == nil then
			isPassEvent = true
		end

		info = {
			heroId = heroId,
			skillId = skillId,
			skillEnhanceCodeLst = skillEnhanceCodeLst,
			skillEnhanceMO = skillEnhanceMO,
			bindGo = bindGo,
			isPassEvent = isPassEvent
		}
		info.posX, info.posY, info.posZ = convertToTipsPos(bindGo)
		info.pivotX, info.pivotY = convertToTipsPivot(bindGo)
		info.direction = Astral.TransformUtil.GetLocalScale(bindGo.transform, 0, 0, 0)

		local cameraTarget = CameraTargetMgr.instance:getUICameraTarget()
		local camera = cameraTarget:getCamera()
		local left, right, top, bottom = 0, 0, 0, 0

		left, right, top, bottom = RectTransformUtils.GetViewPortPercent(bindGo.transform, camera, left, right, top, bottom)
		info.viewPortPercent = {
			left,
			right,
			top,
			bottom
		}
	else
		printError("skillEnhanceMo is nil, code = ", skillId)
	end

	return info
end

function createSkillBuffTagSideTipsWithCodesData(buffCodes, tagCodes, bindGo, isPassEvent, forceAlign, forceTipsAlignVer)
	local info
	local lenBuff = buffCodes and #buffCodes or 0
	local lenTag = tagCodes and #tagCodes or 0

	if lenBuff <= 0 and lenTag <= 0 then
		return
	end

	if isPassEvent == nil then
		isPassEvent = true
	end

	info = {
		buffCodes = buffCodes,
		tagCodes = tagCodes,
		bindGo = bindGo,
		isPassEvent = isPassEvent
	}
	info.forceAlign = forceAlign
	info.forceTipsAlignVer = forceTipsAlignVer
	info.posX, info.posY, info.posZ = convertToTipsPos(bindGo)
	info.pivotX, info.pivotY = convertToTipsPivot(bindGo)
	info.direction = Astral.TransformUtil.GetLocalScale(bindGo.transform, 0, 0, 0)

	local cameraTarget = CameraTargetMgr.instance:getUICameraTarget()
	local camera = cameraTarget:getCamera()
	local left, right, top, bottom = 0, 0, 0, 0

	left, right, top, bottom = RectTransformUtils.GetViewPortPercent(bindGo.transform, camera, left, right, top, bottom)
	info.viewPortPercent = {
		left,
		right,
		top,
		bottom
	}

	return info
end
