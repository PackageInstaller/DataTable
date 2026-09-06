-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/controller/ZooSceneController.lua

module("logic.extensions.zoo.controller.ZooSceneController", package.seeall)

local ZooSceneController = class("ZooSceneController", BaseController)

function ZooSceneController:onInit()
	ZooSceneController.super.onInit(self)
	GlobalDispatcher:addListener(GlobalNotify.SelectElement, self._onSelectElement, self)
	GlobalDispatcher:addListener(GlobalNotify.SelectTilingElem, self._onSelectTilingElem, self)
	GlobalDispatcher:addListener(GlobalNotify.EnterSceneTrigger, self._onEnterSceneTrigger, self)
	GlobalDispatcher:addListener(GlobalNotify.LeaveSceneTrigger, self._onLeaveSceneTrigger, self)
	self:onReset()
end

function ZooSceneController:onReset()
	removetimer(self._removeLostAnimal, self)

	self._removeLostList = {}
	self._selectBuildingMo = nil
	self._digFriendTriggers = nil
	self._enteringMyZoo = false
	self._enteringFriendId = 0
end

function ZooSceneController:setSelectBuilding(mo)
	self._selectBuildingMo = mo
end

function ZooSceneController:getSelectBuilding()
	return self._selectBuildingMo
end

function ZooSceneController:setHasDiggedTreasure(friendId, triggerId)
	self._digFriendTriggers = self._digFriendTriggers or {}
	self._digFriendTriggers[friendId] = self._digFriendTriggers[friendId] or {}
	self._digFriendTriggers[friendId][triggerId] = true
end

function ZooSceneController:hasDiggedTreasure(friendId, triggerId)
	return self._digFriendTriggers and self._digFriendTriggers[friendId] and self._digFriendTriggers[triggerId]
end

function ZooSceneController:enterZooScene()
	self._enteringMyZoo = false
	self._enteringFriendId = 0

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.PetZoo then
		return
	end

	TilingSceneMgr.instance:enterPetZoo()
end

function ZooSceneController:leaveZooScene()
	self._enteringMyZoo = false
	self._enteringFriendId = 0

	SceneStatusMgr.instance:popStatus(ViewName.Collection)
	removetimer(self._removeLostAnimal, self)
end

function ZooSceneController:enterMyZoo()
	self._enteringFriendId = 0

	if self._enteringMyZoo then
		return
	end

	local scene = SceneMgr.instance:getCurScene()

	self._enteringMyZoo = true

	if scene and scene:getSceneType() == SceneType.PetZoo then
		self:moveToDoor()

		return
	end

	self:_reallyEnterMyZoo()
end

function ZooSceneController:_reallyEnterMyZoo()
	local myZooInfo = ZooModel.instance:getMyZoo()

	if not myZooInfo then
		ZooController.instance:getMyZooInfo()

		return
	end

	self._enteringMyZoo = false

	ZooController.instance:switchZoo(RoleModel.instance:getUserId())
	self:enterZooScene()
end

function ZooSceneController:isEnteringMyZoo()
	return self._enteringMyZoo
end

function ZooSceneController:enterFriendZoo(friendId)
	local scene = SceneMgr.instance:getCurScene()

	removetimer(self._removeLostAnimal, self)

	self._enteringMyZoo = false
	self._enteringFriendId = friendId

	if scene and scene:getSceneType() == SceneType.PetZoo then
		self:moveToDoor()

		return
	end

	self:_reallyFriendZoo()
end

function ZooSceneController:_reallyFriendZoo()
	if self._enteringFriendId == 0 then
		return
	end

	local myZooInfo = ZooModel.instance:getMyZoo()

	if myZooInfo then
		ZooController.instance:getFriendZooInfo(self._enteringFriendId)
	else
		ZooController.instance:getMyZooInfo()
	end
end

function ZooSceneController:getEnteringFriendId()
	return self._enteringFriendId
end

function ZooSceneController:createPet(petId)
	GlobalDispatcher:dispatch(GlobalNotify.ZooCreatePet, petId)
end

function ZooSceneController:removePet(petId)
	GlobalDispatcher:dispatch(GlobalNotify.ZooRemovePet, petId)
end

function ZooSceneController:getPetUnit(petId)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() ~= SceneType.PetZoo then
		return
	end

	local units = scene.unitFactory:getUnits(UnitTag.TilingSceneElem)

	if not units then
		return
	end

	for k, v in pairs(units) do
		if v.getUnitTag and v:getUnitTag() == "zooAnimal" and v.itemId == petId then
			return v
		end
	end
end

function ZooSceneController:isMyZoo()
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() ~= SceneType.PetZoo then
		return false
	end

	return ZooModel.instance:isMyZoo()
end

function ZooSceneController:_onSelectElement(instanceId)
	local scene = SceneMgr.instance:getCurScene()

	if not scene or scene:getSceneType() ~= SceneType.PetZoo then
		return
	end

	local unit = scene.unitFactory:getUnit(UnitTag.SceneElement, instanceId)

	if not unit then
		return
	end

	if ZooModel.instance:isElemBuilding(instanceId) then
		local buildingMO = unit:getBuildingMO()

		if buildingMO then
			if buildingMO.isUnlocked then
				self:setSelectBuilding(buildingMO)
				buildingMO:onSelected()
			else
				buildingMO:onUnlocked()
			end
		end
	end
end

function ZooSceneController:_onSelectTilingElem(instanceId)
	local scene = SceneMgr.instance:getCurScene()

	if not scene then
		return
	end

	local unit = scene.unitFactory:getUnit(UnitTag.TilingSceneElem, instanceId)

	if not unit or unit.willRemoved or not unit.getUnitTag or unit:getUnitTag() ~= "zooAnimal" then
		return
	end

	local currZoo = ZooModel.instance:getCurrZoo()
	local animalMo = currZoo:getAnimalById(unit.itemId)

	if not currZoo:isMyZoo() then
		if animalMo then
			UIStateManager.instance:push(ViewName.ZooanimalView, animalMo)
		end

		return
	else
		if animalMo then
			local myZoo = ZooModel.instance:getMyZoo()
			local inZooInteractTimes = myZoo:getHasInZooInteractTimes()
			local maxInteractTimes = ZooConfig.instance:getInZooInteractDailyTimes()

			if maxInteractTimes <= inZooInteractTimes then
				FloatWordMgr.instance:show(lang("petzoo_interact_times_over"))

				return
			end

			ZooAgent.instance:sendPM_ZooInZooAnimalInteractReq(unit.itemId)

			return
		end

		local lostAnimal = currZoo:getLostAnimal(unit.itemId)

		if lostAnimal then
			if self._removeLostList then
				for i, id in ipairs(self._removeLostList) do
					if id == lostAnimal.animalMo.id then
						return
					end
				end
			end

			UIStateManager.instance:push(ViewName.ZoolostanimalView, lostAnimal.animalMo, lostAnimal.id)
		end
	end
end

function ZooSceneController:moveToDoor(handler, handlerObj)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if not mainPlayer then
		return
	end

	if mainPlayer.triggerId == TilingSceneConfig.ExitranceTriggerId then
		self:_onEnterSceneTrigger(0, mainPlayer.triggerId)

		return
	end

	local scene = SceneMgr.instance:getCurScene()

	if not scene then
		return
	end

	local transpointCo = ZooConfig.instance:getBuildingCoByBuildingType(ZooBuildingType.TransPoint)
	local unit = scene.unitFactory:getUnit(UnitTag.SceneElement, transpointCo.id)

	if unit then
		local px, py = unit.transform:getPos()

		TaskController.instance:foreceClearState()

		local path = mainPlayer:runPath(px, py)

		path.onFinished = handler
		path.onFinishedObj = handlerObj
	end
end

function ZooSceneController:_onEnterSceneTrigger(sceneId, triggerId)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.PetZoo then
		if triggerId == TilingSceneConfig.ExitranceTriggerId then
			UIStateManager.instance:popByName(ViewName.ZooDigView)

			if self._enteringMyZoo then
				self:_reallyEnterMyZoo()
			elseif self._enteringFriendId ~= 0 then
				self:_reallyFriendZoo()
			elseif not ViewMgr.instance:isOpen(ViewName.ZooFriendListView) then
				ViewMgr.instance:open(ViewName.ZooFriendListView)
			end
		else
			if ZooModel.instance:isMyZoo() then
				return
			end

			local friendId = ZooModel.instance:getCurZooUserId()

			if not friendId then
				return
			end

			if self:hasDiggedTreasure(friendId, triggerId) then
				return
			end

			local myZoo = ZooModel.instance:getMyZoo()
			local maxTreasureTimes = ZooConfig.instance:getDigTreasureMaxTimes()
			local hasDigTreasureTimes = myZoo:getHasDigTreasureTimes()

			if hasDigTreasureTimes < maxTreasureTimes then
				UIStateManager.instance:open(ViewName.ZooDigView, friendId, triggerId)
			end
		end
	end
end

function ZooSceneController:_onLeaveSceneTrigger(sceneId, triggerId)
	UIStateManager.instance:popByName(ViewName.ZooDigView)

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.PetZoo and triggerId == TilingSceneConfig.ExitranceTriggerId and ViewMgr.instance:isOpen(ViewName.ZooFriendListView) then
		ViewMgr.instance:close(ViewName.ZooFriendListView)
	end
end

function ZooSceneController:setLostAnimalTimer(id)
	self._removeLostList = self._removeLostList or {}

	table.insert(self._removeLostList, id)

	if #self._removeLostList == 1 then
		settimer(3600, self._removeLostAnimal, self, false)
	end
end

function ZooSceneController:_removeLostAnimal()
	self:removePet(self._removeLostList[1])
	table.remove(self._removeLostList, 1)

	if #self._removeLostList > 0 then
		settimer(3600, self._removeLostAnimal, self, false)
	end
end

ZooSceneController.instance = ZooSceneController.New()

return ZooSceneController
