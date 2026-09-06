-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/picker/ScenePickerEx.lua

module("logicscene.scene.component.picker.ScenePickerEx", package.seeall)

local ScenePickerEx = class("ScenePickerEx", SceneComponentBase)

function ScenePickerEx:onInit()
	self._enabled = true
end

function ScenePickerEx:onEnterSceneFinished(sceneId, bornX, bornZ)
	self._unitFactory = SceneMgr.instance:getCurScene().unitFactory
	self._mainPlayer = SceneMainPlayer.instance:getMainPlayer()
end

function ScenePickerEx:enabled(enabled)
	self._enabled = enabled
end

function ScenePickerEx:onExitScene()
	self._findWayFinishedCallback = nil
	self._findWayFinishedCallbackObj = nil

	self:enabled(false)
end

function ScenePickerEx:setFindWayUnit(unit)
	self._mainPlayer = unit
end

function ScenePickerEx:setFindWayFinishedCallback(findWayFinishedCallback, findWayFinishedCallbackObj)
	self._findWayFinishedCallback = findWayFinishedCallback
	self._findWayFinishedCallbackObj = findWayFinishedCallbackObj
end

function ScenePickerEx:onQueryFindWay(x, y)
	if not self._enabled or not self._mainPlayer or self._mainPlayer.transmitPoint then
		return
	end

	if self._mainPlayer.syncPos then
		self._mainPlayer.syncPos:trySyncPosition()
	end

	if MountModel.instance:isTeamMountMember() then
		return
	end

	TaskController.instance:foreceClearState()
	self:_setWalkEff(x, y)
	self._mainPlayer:handleQueryFindWay()

	local action = self:_runPath(x, y)

	if action then
		action.onStoped = self._onMoveFindWayFinish
		action.onStopedObj = self
	end

	if self._mainPlayer.physics2D then
		self._mainPlayer.physics2D:setKinematic(true)
	end

	if self._mainPlayer.physics3D then
		self._mainPlayer.physics3D:setKinematic(true)
	end
end

function ScenePickerEx:_setWalkEff(x, y)
	local scene = SceneMgr.instance:getCurScene()

	if scene.walkEff then
		scene.walkEff:setVisible(true)
		scene.walkEff:setPosition(x, y)
	end
end

function ScenePickerEx:_runPath(x, y)
	return self._mainPlayer:runPath(x, y, self._onMoveFindWayFinish, self)
end

function ScenePickerEx:_onMoveFindWayFinish()
	if self._mainPlayer.physics2D then
		self._mainPlayer.physics2D:setKinematic(false)
	end

	if self._mainPlayer.physics3D then
		self._mainPlayer.physics3D:setKinematic(false)
	end

	if self._findWayFinishedCallback then
		if self._findWayFinishedCallbackObj then
			self._findWayFinishedCallback(self._findWayFinishedCallbackObj)
		else
			self._findWayFinishedCallback()
		end
	end
end

function ScenePickerEx:onQueryObject(go)
	if not self._enabled then
		return
	end

	if MountModel.instance:isTeamMountMember() then
		return
	end

	if go.layer == SceneLayer.Unit_Value or go.layer == SceneLayer.InteractiveObject_Value then
		local name = go.name

		if name == self:_getSceneMainPlayer() then
			self:_selectMainPlayer()

			return
		end

		local idx = string.find(name, "NPC_")

		if idx then
			local npcId = string.sub(name, 5)

			npcId = tonumber(npcId)

			TaskController.instance:foreceClearState()
			self._mainPlayer:gotoNpc(npcId)

			return
		end

		idx = string.find(name, "Monster_")

		if idx then
			local mstId = string.sub(name, 9)

			mstId = tonumber(mstId)

			TaskController.instance:foreceClearState()
			self._mainPlayer:gotoMonster(mstId)

			return
		end

		idx = string.find(name, "Player_")

		if idx then
			local playerId = string.sub(name, 8)

			playerId = tonumber(playerId)

			if SceneMgr.instance:tryClick() then
				self:_selectOtherPlayer(playerId)

				return
			end
		end

		idx = string.find(name, "UnitPet_")

		if idx then
			local petInsId = string.sub(name, 9)
			local pet = self._unitFactory:getUnit(UnitTag.Pet, tonumber(petInsId))

			GlobalDispatcher:dispatch(GlobalNotify.SelectPlayerPet, pet)

			return
		end

		idx = string.find(name, "SceneElement_")

		if idx and not string.find(name, UnitTag.TilingSceneElem) then
			local eleInsId = tonumber(string.sub(name, 14))

			TaskController.instance:foreceClearState()
			self._mainPlayer:gotoElement(eleInsId)

			return
		end

		idx = string.find(name, "SceneElem_")

		if idx and not string.find(name, UnitTag.TilingSceneElem) then
			local eleInsId = tonumber(string.sub(name, 11))

			TaskController.instance:foreceClearState()
			self._mainPlayer:gotoElement(eleInsId)

			return
		end

		idx = string.find(name, "UnitZoo_")

		if idx then
			local animalMoList = ZooModel.instance:getMyAnimalList()

			for i, animal in ipairs(animalMoList) do
				if animal.follow then
					UIStateManager.instance:push(ViewName.ZoofollowView, animal)

					break
				end
			end

			return
		end

		idx = string.find(name, "UnitSpecElem_")

		if idx then
			local eleInsId = tonumber(string.sub(name, string.len("UnitSpecElem_") + 1))
			local evt = self._unitFactory:getUnit(UnitTag.SceneElement, tonumber(eleInsId))

			if evt then
				TaskController.instance:foreceClearState()
				GlobalDispatcher:dispatch(GlobalNotify.SelectSpecialElement, evt)
			end

			return
		end

		idx = string.find(name, UnitTag.TilingSceneElem)

		if idx then
			local eleInsId = tonumber(string.sub(name, string.len(UnitTag.TilingSceneElem) + 2))

			TaskController.instance:foreceClearState()
			self._mainPlayer:gotoTilingElem(eleInsId)

			return
		end
	end
end

function ScenePickerEx:_selectMainPlayer()
	GlobalDispatcher:dispatch(GlobalNotify.SelectMainPlayer)
end

function ScenePickerEx:_selectOtherPlayer(playerId)
	GlobalDispatcher:dispatch(GlobalNotify.SelectOtherPlayer, playerId)
end

function ScenePickerEx:_getSceneMainPlayer()
	return SceneMainPlayer.MainPlayerName
end

return ScenePickerEx
