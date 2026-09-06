-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/season/events/SeasonSceneEventChallengeImpl.lua

module("logicscene.scene.unit.component.season.events.SeasonSceneEventChallengeImpl", package.seeall)

local SeasonSceneEventChallengeImpl = class("SeasonSceneEventChallengeImpl", SeasonSceneEventImplBase)

function SeasonSceneEventChallengeImpl:onActive(evtGo)
	SeasonSceneEventChallengeImpl.super.onActive(self, evtGo)
	self:_loadChallangeModel()
end

function SeasonSceneEventChallengeImpl:onDeactive()
	if self._sceneUnit then
		UnityEngine.GameObject.DestroyImmediate(self._sceneUnit)

		self._sceneUnit = nil
	end

	if self._resObject then
		local go = self._resObject.go

		if not goutil.isNil(go) then
			local boxCollider = go:GetComponent(ComponentType.BoxCollider)

			if boxCollider then
				boxCollider.enabled = true
			end

			go.transform:SetParent(nil)
		end

		self._unit.scene.resCache:recycleObject(self._resObject)

		self._resObject = nil
	end

	if self._shadowObject then
		CommonObjectMgr.instance.shadowPool:returnObject(self._shadowObject)

		self._shadowObject = nil
	end
end

function SeasonSceneEventChallengeImpl:getDependentResources()
	local resPath = self:_getModelResPath()

	if resPath then
		return {
			resPath
		}
	end
end

function SeasonSceneEventChallengeImpl:_getModelResPath()
	local seasonId = SeasonModel.instance:getSeasonId()
	local challengeCfg = SeasonConfig.instance:getMapEvtDetail(seasonId, self.evtData.eventType, self.evtData.eventId)

	if not challengeCfg.isElite then
		return
	end

	local creepCo = self:_getCreepCo(challengeCfg.creepsMasterId)

	if not creepCo then
		return
	end

	if SeasonModel.instance:isOccupied(self.evtData.id) then
		return
	end

	local mapMo = SeasonModel.instance:getMapInfoById(self.evtData.id)

	if mapMo then
		local gridX, gridY = mapMo:getGridPos()

		if mapMo._fogState == SeasonMapDataMO.Fog_Within then
			return
		end
	end

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(creepCo.raceId))

	return (GameUrl.getSpineUrl(modelCo.resName))
end

function SeasonSceneEventChallengeImpl:_loadChallangeModel()
	local resPath = self:_getModelResPath()

	self:_loadModelByResPath(resPath)
end

function SeasonSceneEventChallengeImpl:_loadModelByResPath(resPath)
	if not resPath then
		return
	end

	self._resObject = self._unit.scene.resCache:newObject(resPath)
	self._resObject.loadedHandler = self._onModelLoadedFinish
	self._resObject.loadedHandlerTarget = self

	self._resObject:setParent(self._unit.go.transform)
	self._resObject:setScale(0.12)
	self._resObject:setLocalPos(0, 0, 0)
end

function SeasonSceneEventChallengeImpl:_getCreepCo(creepsMasterId)
	local creepsCo = SeasonConfig.instance:getCreeps(creepsMasterId)

	if not creepsCo then
		return
	end

	local minPosId = 99999
	local creepCo

	for k, v in pairs(creepsCo) do
		if minPosId > v.posId then
			minPosId = v.posId
			creepCo = v
		end
	end

	return creepCo
end

function SeasonSceneEventChallengeImpl:_onModelLoadedFinish()
	if not self._resObject then
		return
	end

	local go = self._resObject.go

	if goutil.isNil(go) then
		return
	end

	local boxCollider = go:GetComponent(ComponentType.BoxCollider)

	if boxCollider then
		boxCollider.enabled = false
	end

	if go.activeInHierarchy then
		GoUtil.PlaySpineAnim(go, "idle", true, true)
	else
		go.transform:SetParent(nil)
		GoUtil.PlaySpineAnim(go, "idle", true, true)
		go.transform:SetParent(self._unit.go.transform)
	end

	self._shadowObject = CommonObjectMgr.instance.shadowPool:fetchObject()

	GoUtil.SetSortingOrder(self._shadowObject, -500)
	GoUtil.SetVisible(self._shadowObject, true)
	goutil.addChildToParent(self._shadowObject, go.transform)
	Framework.GameObjectUtil.SetLayerRecursively(self._shadowObject, self._unit:getLayer())
	Framework.TransformUtil.SetLocalPos(self._shadowObject.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalRotation(self._shadowObject.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(self._shadowObject.transform, 10, 10, 20)
	goutil.setActive(self._shadowObject, true)

	self._sceneUnit = SceneUnit.Get(go, self._unit.scene.stage.wholeScene)

	GoUtil.SetVisible(go, true)
end

return SeasonSceneEventChallengeImpl
