-- chunkname: @modules/logic/explore/model/ExploreModel.lua

module("modules.logic.explore.model.ExploreModel", package.seeall)

local ExploreModel = class("ExploreModel", BaseModel)

function ExploreModel:onInit()
	self:clearData()
end

function ExploreModel:reInit()
	self:clearData()

	self.isFirstEnterMap = ExploreEnum.EnterMode.Normal
	self.isJumpToExplore = false
end

function ExploreModel:clearData()
	self._heroControlDict = {}
	self._stepPause = false
	self.isReseting = false
	self._useItemUid = 0
	self.isRoleInitDone = false
	self.isShowingResetBoxMessage = false
	self.mapId = 0
	self.challengeCount = 0
	self.unLockAreaIds = {}
	self._interactInfosDic = {}

	ExploreCounterModel.instance:reInit()
end

function ExploreModel:isHeroInControl(type)
	if type then
		return not self._heroControlDict[type]
	end

	return not next(self._heroControlDict)
end

function ExploreModel:setHeroControl(noLock, key)
	key = key or ExploreEnum.HeroLock.All

	if noLock then
		if key == ExploreEnum.HeroLock.All then
			self._heroControlDict = {}
		else
			self._heroControlDict[key] = nil
		end
	else
		self._heroControlDict[key] = true

		if self.isShowingResetBoxMessage then
			self.isShowingResetBoxMessage = false

			ViewMgr.instance:closeView(ViewName.MessageBoxView)
		end
	end
end

function ExploreModel:setStepPause(isPause)
	if self._stepPause == isPause then
		return
	end

	self._stepPause = isPause

	if not isPause then
		ExploreStepController.instance:startStep()
	end
end

function ExploreModel:getStepPause()
	return self._stepPause
end

function ExploreModel:getMapId()
	return self.mapId
end

function ExploreModel:getNowMapEpisodeId()
	return ExploreConfig.instance:getEpisodeId(self.mapId)
end

function ExploreModel:addChallengeCount()
	self.challengeCount = self.challengeCount + 1
end

function ExploreModel:getChallengeCount()
	return self.challengeCount
end

function ExploreModel:updateExploreInfo(exploreInfo)
	self:clearData()

	local exploreMapInfo = exploreInfo.exploreMap

	self.mapId = exploreMapInfo.mapId
	self.challengeCount = exploreMapInfo.challengeCount

	for i, exploreInteract in ipairs(exploreMapInfo.interacts) do
		self:updateInteractInfo(exploreInteract, exploreMapInfo.mapId)
	end

	for i, areaId in ipairs(exploreMapInfo.areaIds) do
		self.unLockAreaIds[areaId] = true
	end

	ExploreBackpackModel.instance:updateItems(exploreInfo.exploreItems, true)
	ExploreMapModel.instance:updatHeroPos(exploreMapInfo.posx, exploreMapInfo.posy, exploreMapInfo.dir)

	ExploreMapModel.instance.moveNodes = exploreMapInfo.moveNodes

	self:setUseItemUid(exploreInfo.useItemUid)
	ExploreController.instance:dispatchEvent(ExploreEvent.UnitInteractInfoChange)
end

function ExploreModel:updateInteractInfo(interactNO, mapId, dispatch)
	mapId = mapId or self.mapId

	local infoMO = self:getInteractInfo(interactNO.id, mapId)

	infoMO:initNO(interactNO)

	if dispatch then
		ExploreController.instance:dispatchEvent(ExploreEvent.UnitInteractInfoChange)
	end
end

function ExploreModel:updateInteractStatus(mapId, id, status)
	local infoMO = self:getInteractInfo(id, mapId)

	infoMO:updateStatus(status)
end

function ExploreModel:updateInteractStatus2(mapId, id, status2)
	local infoMO = self:getInteractInfo(id, mapId)

	infoMO:updateStatus2(status2)
end

function ExploreModel:updateInteractStep(ExploreInteractSetStepReply)
	local infoMO = self:getInteractInfo(ExploreInteractSetStepReply.id, ExploreInteractSetStepReply.mapId)

	infoMO.step = ExploreInteractSetStepReply.step
end

function ExploreModel:getInteractInfo(id, mapId)
	mapId = mapId or self.mapId
	self._interactInfosDic[mapId] = self._interactInfosDic[mapId] or {}

	if self._interactInfosDic[mapId][id] == nil then
		local mo = ExploreInteractInfoMO.New()

		mo:init(id)

		self._interactInfosDic[mapId][id] = mo
	end

	return self._interactInfosDic[mapId][id]
end

function ExploreModel:hasInteractInfo(id, mapId)
	mapId = mapId or self.mapId
	self._interactInfosDic[mapId] = self._interactInfosDic[mapId] or {}

	return self._interactInfosDic[mapId][id] ~= nil
end

function ExploreModel:getAllInteractInfo(mapId)
	mapId = mapId or self.mapId

	return self._interactInfosDic[mapId]
end

function ExploreModel:getUseItemUid()
	return self._useItemUid
end

function ExploreModel:setUseItemUid(uid, isNoDispatcher)
	local oldId = self._useItemUid

	self._useItemUid = uid

	if oldId ~= self._useItemUid and not isNoDispatcher then
		ExploreController.instance:dispatchEvent(ExploreEvent.UseItemChanged, self._useItemUid)
	end
end

function ExploreModel:getCarryUnit()
	local carryId = self:getUseItemUid()
	local carryUnit = ExploreController.instance:getMap():getUnit(tonumber(carryId), true)

	if not isTypeOf(carryUnit, ExplorePipePotUnit) then
		return nil
	end

	return carryUnit
end

function ExploreModel:isUseItemOrUnit(id)
	return self._useItemUid == id or tonumber(self._useItemUid) == id
end

function ExploreModel:hasUseItemOrUnit()
	return self._useItemUid ~= 0 and self._useItemUid ~= "0"
end

function ExploreModel:isAreaShow(areaId)
	if not areaId or areaId == 0 then
		return true
	end

	return self.unLockAreaIds[areaId] or false
end

ExploreModel.instance = ExploreModel.New()

return ExploreModel
