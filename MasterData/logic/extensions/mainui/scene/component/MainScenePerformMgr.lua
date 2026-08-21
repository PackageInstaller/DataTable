-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/component/MainScenePerformMgr.lua

module("logic.extensions.mainui.scene.component.MainScenePerformMgr", package.seeall)

local M = class("MainScenePerformMgr", ISceneFlowComp)
local kMainSceneKey = "MainSceneKey"

function M:ctor(flow)
	M.super.ctor(self, flow)
end

function M:onInit(sceneInfo)
	M.super.onInit(self, sceneInfo)

	self._adjutantSeatElement = nil
	self._adjutantHeroId = nil
	self._adjutantSkinId = nil
end

function M:onEnter()
	self:_setEvent(true)
end

function M:onSceneLoadDone()
	return
end

function M:onEnterDone()
	self:_setEnterFeature(true)
end

function M:onExit()
	self:_setEvent(false)
	self:_setEnterFeature(false)
end

function M:onExitDone()
	return
end

function M:onLeaveScene()
	self:_setEvent(false)
end

function M:onReturnScene()
	self:_setEvent(true)
end

function M:onReturnSceneFinished()
	self:_setEnterFeature(true)

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.stage:getHouseRootGo() then
		self:_tryReflashAll()
	else
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_LOADED, self._handleOnSceneLoaded, self)
	end
end

function M:_setEnterFeature(enable)
	RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.WATER_PLANAR_REFLECTION, enable, kMainSceneKey)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.CHANGE_PLAYER_DISPLAYHERO_SUC, self._handleDisplayAdjutantHeroChange, self)
		GlobalDispatcher:addEventListener(EventType.CHANGE_PLAYER_DISPLAYSKIN_SUC, self._handleDisplayAdjutantHeroSkinChange, self)
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_CHANGE_REQ, self._handleHeroChangeReq, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_SET_BG_HERO_SHOW, self._handleBgHeroSetShow, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_POINT_HERO_REMOVE_REQ, self._handlePointHeroRemove, self)
		GlobalDispatcher:addEventListener(EventType.JUMP_VIEW_TO_MAIN, self._handleJumpViewToMain, self)
	else
		GlobalDispatcher:removeEventListener(EventType.CHANGE_PLAYER_DISPLAYHERO_SUC, self._handleDisplayAdjutantHeroChange, self)
		GlobalDispatcher:removeEventListener(EventType.CHANGE_PLAYER_DISPLAYSKIN_SUC, self._handleDisplayAdjutantHeroSkinChange, self)
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_CHANGE_REQ, self._handleHeroChangeReq, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_SET_BG_HERO_SHOW, self._handleBgHeroSetShow, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_POINT_HERO_REMOVE_REQ, self._handlePointHeroRemove, self)
		GlobalDispatcher:removeEventListener(EventType.JUMP_VIEW_TO_MAIN, self._handleJumpViewToMain, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_LOADED, self._handleOnSceneLoaded, self)
	end
end

function M:_handleOnSceneLoaded(e, sceneType, sceneId)
	if sceneType == SceneType.Room then
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_LOADED, self._handleOnSceneLoaded, self)
		self:_tryReflashAll()
	end
end

function M:_handleJumpViewToMain()
	local scene = SceneMgr.instance:getCurScene()

	if not scene or not scene.stage:getHouseRootGo() then
		return
	end

	ViewBlackFadeController.instance:showGadget(true, 0.12, function()
		GlobalDispatcher:dispatchEvent(EventType.ON_MAIN_SCENE_JUMP_MAIN_VIEW_BLACK_FADE_IN)
	end, self, "jumpToMainView", 1, 0.3)

	local displayHero, displayHeroSkin = MainScenePerformUtil.getDisplayAdjutantHeroId()
	local forceSet = false
	local prefix = MainPerformEnum.AnimPrefix.Shafa
	local mixDuration = MainPerformEnum.AnimDefaultMixDuration
	local isChange = false

	MainScenePerformUtil.changeHeroReq(MainPerformEnum.ElementPointAdjutant, displayHero, displayHeroSkin, forceSet, prefix, mixDuration, isChange)
	MainScenePerformUtil.setBgHeroShow(true, true)
	MainScenePerformUtil.setElementShow(MainPerformEnum.ElementIdAirtightClock, true)
	MainScenePerformUtil.setElementShow(MainPerformEnum.ElementIdTelevision, true)

	local elementId = MainPerformConfig.instance:getHeroElementId(displayHero, MainPerformEnum.ElementPointAdjutant, displayHeroSkin)

	if elementId then
		self._flow.elementMgr:showElementHideOtherSamePointElement(elementId, MainPerformEnum.ElementPointAdjutant)
	end
end

function M:_handlePlayerAttributeUpgrade(e)
	GlobalDispatcher:removeEventListener(EventType.PLAYER_ATTRIBUTE_UPGRADE, self._handlePlayerAttributeUpgrade, self)
	self:loadMainSceneCharacter()
end

function M:loadMainSceneCharacter()
	self._adjutantHeroId, self._adjutantSkinId = MainScenePerformUtil.getDisplayAdjutantHeroId()

	if not self._adjutantHeroId then
		local playerData = PlayerModel.instance:getMyPlayerInfo()

		if playerData == nil or tonumber(playerData.userId) ~= tonumber(PlayerModel.instance:getId()) then
			GlobalDispatcher:addEventListener(EventType.PLAYER_ATTRIBUTE_UPGRADE, self._handlePlayerAttributeUpgrade, self)

			if enableLog then
				printWarn("看板娘数据为空，等待第一次setMyPlayerInfo")
			end

			return
		end
	end

	self:_loadAdjutantHero()
	self:_loadBgHero()

	local lastData = MainUIModel.instance:getLastBgPerformData()

	self._flow.elementMgr:refreshElement(self._adjutantSeatElement, lastData and lastData.pointPerformData or nil)
end

function M:_handleDisplayAdjutantHeroChange(e, displayHero, displayHeroSkin)
	self._adjutantHeroId = displayHero
	self._adjutantSkinId = displayHeroSkin

	if enableLog then
		printWarn(string.format("副官发生变化 heroId[%s] skinId[%s]", displayHero, displayHeroSkin))
	end

	self:_loadAdjutantHero()

	local lastData = MainUIModel.instance:getLastBgPerformData()
	local pointPerformData = lastData.pointPerformData
	local resetPoint

	for point, data in pairs(lastData.pointPerformData or {}) do
		if point ~= 0 and data.heroId == self._adjutantHeroId then
			resetPoint = point
		end
	end

	if resetPoint then
		pointPerformData[resetPoint] = {
			heroId = 0,
			skinId = 0,
			point = resetPoint,
			elementId = MainPerformConfig.instance:getPointDefaultElementId(resetPoint)
		}

		local recordTime = false

		MainUIModel.instance:setLastBgPerformFormula(lastData.formulaId, pointPerformData, recordTime, false)
	end
end

function M:_handleDisplayAdjutantHeroSkinChange(e, displayHeroSkin)
	self._adjutantSkinId = displayHeroSkin

	if enableLog then
		printWarn(string.format("heroId[%s] skinId[%s]", self._adjutantHeroId, displayHeroSkin))
	end
end

function M:_handleAritightStateChange(e, isInAirtightTime, airtightEndTS)
	return
end

function M:_handleHeroChangeReq(e, info)
	local pointId = info.pointId
	local heroId = info.heroId
	local skinId = info.skinId
	local forceSet = false
	local isChange = info.isChange
	local defaultHide = info.defaultHide
	local blockChangeEff = info.blockChangeEff

	if info.forceSet ~= nil then
		forceSet = info.forceSet
	end

	local prefix = info.prefix
	local elementId = MainPerformConfig.instance:getHeroElementId(heroId, pointId, skinId)
	local theUnit = self._flow.unitFactory:getUnitHeroByPoint(pointId)

	if theUnit and theUnit:getHeroId() == heroId and skinId == theUnit:getSkinId() then
		theUnit.meshModel:resetTransform()

		local mixDuration = info.mixDuration and info.mixDuration or MainPerformEnum.AnimDefaultMixDuration

		MainScenePerformUtil.heroAnimSeqPlay(heroId, prefix, mixDuration)

		return
	end

	if not elementId then
		if enableLog then
			printError(string.format("无法找到角色[%s] 对应的elementId", heroId))
		end

		return
	end

	local tag = pointId == 0 and UnitTag.Player or UnitTag.Npc

	self._flow.unitFactory:removeUnitHeroByPoint(pointId)

	local checkHeroExist = not forceSet
	local checkHeroOnline = false
	local ignoreRuntimeCfgCheck = false
	local createInfo = self:getCreateUnitInfo(tag, heroId, skinId, pointId, checkHeroExist, checkHeroOnline, ignoreRuntimeCfgCheck)

	if createInfo then
		createInfo.defaultPrefix = prefix
		createInfo.isChange = isChange
		createInfo.defaultHide = defaultHide
		createInfo.blockChangeEff = blockChangeEff

		local transparency = isChange and 0 or 1

		self:createUnit(tag, createInfo)
		self._flow.elementMgr:showElementHideOtherSamePointElement(elementId, pointId, transparency)
	else
		self._flow.elementMgr:showElementHideOtherSamePointElement(0, pointId)
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_SHOW_UP, pointId, -1, nil, false)
	end
end

function M:_handleBgHeroSetShow(e, show, includeElement, includeAdjutant)
	local cfgMap = MainPerformConfig.instance:getInteractPointMap()
	local pointMap = {}

	for point, _ in pairs(cfgMap or {}) do
		pointMap[point] = 1
	end

	if not includeAdjutant then
		pointMap[MainPerformEnum.ElementPointAdjutant] = nil
	end

	if show then
		local lastData = MainUIModel.instance:getLastBgPerformData()

		for _, data in pairs(lastData.pointPerformData) do
			local heroId = data.heroId or 0

			if heroId > 0 then
				self:_handleHeroChangeReq(nil, {
					pointId = data.point,
					heroId = heroId,
					skinId = data.skinId,
					forceSet = data.forceSet,
					prefix = MainPerformConfig.instance:getHeroElementPrefix(heroId, data.point, data.skinId)
				})
			else
				local elementId = data.elementId

				elementId = elementId or 0

				self._flow.elementMgr:showElementHideOtherSamePointElement(elementId, data.point)
			end
		end
	else
		for _point, _ in pairs(pointMap or {}) do
			self._flow.unitFactory:removeUnitHeroByPoint(_point)

			if includeElement then
				self._flow.elementMgr:hideAllElementInPoint(_point)
			end
		end
	end
end

function M:_handlePointHeroRemove(e, info)
	local pointId = info.pointId
	local includeElement = info.includeElement

	self._flow.unitFactory:removeUnitHeroByPoint(pointId)

	if includeElement then
		self._flow.elementMgr:hideAllElementInPoint(pointId)
	end
end

function M:getAdjutantSeatElement()
	return self._adjutantSeatElement
end

function M:_tryReflashAll()
	local lastData = MainUIModel.instance:getLastBgPerformData()

	for _, data in pairs(lastData.pointPerformData) do
		local heroId = data.heroId or 0

		if heroId > 0 then
			self:_handleHeroChangeReq(nil, {
				pointId = data.point,
				heroId = data.heroId,
				skinId = data.skinId,
				forceSet = data.forceSet
			})
		else
			self._flow.unitFactory:removeUnitHeroByPoint(data.point)

			local elementId = data.elementId

			elementId = elementId or 0

			self._flow.elementMgr:showElementHideOtherSamePointElement(elementId, data.point)
		end
	end

	local adjutantHeroId, adjutantSkinId = MainScenePerformUtil.getDisplayAdjutantHeroId()

	self:_handleHeroChangeReq(nil, {
		forceSet = false,
		pointId = MainPerformEnum.ElementPointAdjutant,
		heroId = adjutantHeroId,
		skinId = adjutantSkinId
	})
end

function M:_loadAdjutantHero()
	local point = MainPerformEnum.ElementPointAdjutant
	local heroId = self._adjutantHeroId
	local skinId = CharacterSkinUtil.getHeroUsingSkinId(heroId)

	self._flow.unitFactory:removeUnitHero(UnitTag.Npc, heroId, true, true)

	local elementId = MainPerformConfig.instance:getHeroElementId(heroId, point, skinId)

	self._adjutantSeatElement = elementId

	local unitAdjutant = self._flow.unitFactory:getUnitHero(UnitTag.Player, heroId)

	if not unitAdjutant then
		self._flow.unitFactory:removeUnitAdjutant(true)

		local checkExist = MainPerformConfig.instance:getPointCheckHeroExist(point)
		local checkOnline = true
		local ignoreRuntimeCfgCheck = false
		local info = self:getCreateUnitInfo(UnitTag.Player, heroId, skinId, point, checkExist, checkOnline, ignoreRuntimeCfgCheck)

		if info then
			self:createUnit(UnitTag.Player, info)
		else
			if enableErrorLog then
				printError(string.format("看板娘[%s]skin[%s],数据生成失败,无法创建", heroId, skinId))
			end

			GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_SHOW_UP, point, -1, nil, false)
		end
	else
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_SHOW_UP, point, heroId, unitAdjutant, false)
	end

	if not self._flow.elementMgr:getElementIsShowNow(elementId) then
		self._flow.elementMgr:showElementHideOtherSamePointElement(elementId, point)
	end
end

function M:_loadBgHero()
	local adjutantHeroId, _ = MainScenePerformUtil.getDisplayAdjutantHeroId()
	local needRefresh = false
	local lastData = MainUIModel.instance:getLastBgPerformData()

	if lastData then
		local offsetTime = ServerTime.now() - lastData.time

		needRefresh = offsetTime >= MainPerformConfig.instance:getBgRefreshTime()

		if enableLog then
			printWarn(string.format("背景交互点配置刷新:[%s / %s]", offsetTime, MainPerformConfig.instance:getBgRefreshTime()))
		end
	else
		needRefresh = true
	end

	local cfgMap = MainPerformConfig.instance:getInteractPointMap()
	local pointMap = {}

	for point, _ in pairs(cfgMap or {}) do
		pointMap[point] = 1
	end

	pointMap[MainPerformEnum.ElementPointAdjutant] = nil

	local formulaId, pointPerformData

	if needRefresh then
		pointPerformData = {}

		local cfgFormula = MainScenePerformUtil.getRandomBgFormula()
		local needRollPoint = cfgFormula and cfgFormula.interactPoints or {}

		if cfgFormula and not string.nilorempty(cfgFormula.forceSet) then
			local arrStep = string.split(cfgFormula.forceSet, "#")

			for index, valueStr in ipairs(arrStep) do
				local arrSingleStep = string.split(valueStr, ";")
				local point = tonumber(arrSingleStep[1])
				local elementId = tonumber(arrSingleStep[2])
				local heroId = tonumber(arrSingleStep[3])

				if heroId ~= adjutantHeroId then
					pointPerformData[point] = {
						forceSet = true,
						heroId = heroId,
						skinId = CharacterUtil.getDepotHeroSkinId(heroId),
						point = point,
						elementId = elementId
					}
				end
			end

			needRollPoint = {}

			for _point, _ in pairs(pointMap) do
				if not pointPerformData[_point] then
					table.insert(needRollPoint, _point)
				end
			end
		end

		local elementIds = {}

		for _, point in pairs(needRollPoint or {}) do
			local cfgElement = MainScenePerformUtil.getRandomInteractElement(point)

			if cfgElement then
				table.insert(elementIds, cfgElement.id)
			end
		end

		if #elementIds > 0 then
			local onlyExist = false
			local includeSP = false

			pointPerformData = MainScenePerformUtil.getRandomElementHeros(pointPerformData, elementIds, adjutantHeroId, onlyExist, includeSP)
		end

		formulaId = cfgFormula and cfgFormula.id or nil
	else
		formulaId = lastData.formula
		pointPerformData = lastData.pointPerformData
		pointPerformData = pointPerformData or {}
	end

	for _point, _ in pairs(pointMap) do
		if not pointPerformData[_point] then
			pointPerformData[_point] = {
				elementId = 0,
				heroId = 0,
				skinId = 0,
				point = _point
			}
		end
	end

	for _, data in pairs(pointPerformData) do
		local checkExist = not data.forceSet
		local checkOnline = true
		local ignoreRuntimeCfgCheck = false
		local info = self:getCreateUnitInfo(UnitTag.Npc, data.heroId, data.skinId, data.point, checkExist, checkOnline, ignoreRuntimeCfgCheck)

		if info then
			self:createUnit(UnitTag.Npc, info)
		else
			data.elementId = 0

			GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_SHOW_UP, data.point, -1, nil, false)
		end
	end

	local recordTime = needRefresh

	MainUIModel.instance:setLastBgPerformFormula(formulaId, pointPerformData, recordTime, true)
end

function M:getCreateUnitInfo(tag, heroId, skinId, pointId, checkExit, checkOnline, ignoreRuntimeCfgCheck)
	if tag == nil or heroId == nil or pointId == nil then
		if enableLog then
			printWarn(string.format("参数错误，tag[%s] 交互点[%s] 角色[%s]", tag, pointId, heroId), debug.traceback())
		end

		return false
	end

	if heroId <= 0 then
		if enableLog then
			printWarn(string.format("交互点[%s] 角色[%s]，不生成", pointId, heroId))
		end

		return false
	end

	local canCreate = true
	local _animStepStr, heroPosData

	if checkExit then
		local herodata = HeroDepotModel.instance:getHeroInfoByID(heroId)

		if herodata == nil or herodata == false then
			canCreate = false

			if enableLog then
				printWarn(string.format("交互点[%s] 玩家未拥有角色[%s]，不生成", pointId, heroId))
			end

			return false
		end
	end

	local modelId = CharacterUtil.getModelId(heroId, skinId)

	if tag == UnitTag.Player then
		local cfgAdjutantR = MainPerformConfig.instance:getLandLadyRConfig(modelId)

		if cfgAdjutantR then
			_animStepStr = cfgAdjutantR and cfgAdjutantR.anim or nil
			heroPosData = cfgAdjutantR and cfgAdjutantR.posData or {}
		else
			if enableLog then
				printWarn(string.format("无法找到副官看板娘[%s]的配置", heroId))
			end

			canCreate = false
		end

		if not cfgAdjutantR and not ignoreRuntimeCfgCheck then
			if enableLog then
				printWarn(string.format("无法找到副官看板娘[%s]的运行时配置", heroId))
			end

			canCreate = false
		end
	elseif tag == UnitTag.Npc then
		local cfgHeroPerformR = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformHeroR, modelId, true)

		if not cfgHeroPerformR and not ignoreRuntimeCfgCheck then
			if enableLog then
				printWarn(string.format("无法找到 交互点[%s] 角色[%s]的配置", pointId, heroId))
			end

			canCreate = false
		end

		_animStepStr = cfgHeroPerformR and cfgHeroPerformR.anim or nil
		heroPosData = cfgHeroPerformR and cfgHeroPerformR.posData or {}
	end

	local elementId = MainPerformConfig.instance:getHeroElementId(heroId, pointId, skinId)
	local elementPosData = self._flow.elementMgr:getElementPosData(elementId)

	if not elementPosData then
		canCreate = false

		if enableLog then
			printWarn(string.format("交互点[%s] 元素[%s] 无法定位，不生成角色[%s]", pointId, elementId, heroId), debug.traceback())
		end
	end

	if canCreate then
		local loadAnimList = {}

		if tag == UnitTag.Player then
			loadAnimList = {
				"shafa",
				"xiangqing",
				"canxiang",
				"iaoshiqi",
				"yishi",
				"xinmao",
				"chouka"
			}
		else
			local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainInteractElement, elementId)

			table.insert(loadAnimList, cfg.animPrefix)
		end

		local info = MainScenePerformUtil.createUnitCreateEntityInfo(heroId, skinId, pointId, loadAnimList)

		info.elementId = elementId
		info.animStepStr = _animStepStr
		info.pos.x = elementPosData.pos.x or 0
		info.pos.y = elementPosData.pos.y or 0
		info.pos.z = elementPosData.pos.z or 0
		info.rotate.x = elementPosData.rotate.x or 0
		info.rotate.y = elementPosData.rotate.y or 0
		info.rotate.z = elementPosData.rotate.z or 0
		info.scale.x = elementPosData.scale.x or 1
		info.scale.y = elementPosData.scale.y or 1
		info.scale.z = elementPosData.scale.z or 1
		info.posOffset.x = heroPosData[1] or 0
		info.posOffset.y = heroPosData[2] or 0
		info.posOffset.z = heroPosData[3] or 0
		info.rotateOffset.x = heroPosData[4] or 0
		info.rotateOffset.y = heroPosData[5] or 0
		info.rotateOffset.z = heroPosData[6] or 0
		info.localScale = heroPosData[7] or 1

		return info
	else
		return false
	end
end

function M:createUnit(tag, info)
	if not info then
		return
	end

	self._flow.unitFactory:createUnit(tag, info)
end

return M
