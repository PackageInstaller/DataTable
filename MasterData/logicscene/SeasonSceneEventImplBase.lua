-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/season/events/SeasonSceneEventImplBase.lua

module("logicscene.scene.unit.component.season.events.SeasonSceneEventImplBase", package.seeall)

local SeasonSceneEventImplBase = class("SeasonSceneEventImplBase")

function SeasonSceneEventImplBase.createEvtHandler(unit, evtData)
	local sceneEventImplClassMap = {
		[SeasonGridEvtTypes.EVT_CHALLENGE] = SeasonSceneEventChallengeImpl,
		[SeasonGridEvtTypes.EVT_CONVEY] = SeasonSceneEventTransmitPoint,
		[SeasonGridEvtTypes.EVT_MAP_LOCK] = SeasonSceneEventMapLock,
		[SeasonGridEvtTypes.EVT_BOSS_DOPPELGANGER] = SeasonSceneEventBossDoppelganger,
		[SeasonGridEvtTypes.EVT_FIND_KEY] = SeasonSceneEventFindKey,
		[SeasonGridEvtTypes.EVT_DANCE_LION] = SeasonSceneEventDanceLion,
		[SeasonGridEvtTypes.EVT_BOSS] = SeasonSceneEventBoss
	}
	local sceneEventImplChangeMap = {
		{
			[SeasonGridEvtTypes.EVT_BOSS] = SeasonSceneEventBoss
		},
		{
			[SeasonGridEvtTypes.EVT_BOSS] = SeasonSceneEventBossS2,
			[SeasonGridEvtTypes.EVT_CHALLENGE] = SeasonSceneEventChallengeS2Impl
		},
		{
			[SeasonGridEvtTypes.EVT_BOSS] = SeasonSceneEventBossS3,
			[SeasonGridEvtTypes.EVT_BOSS_DOPPELGANGER] = SeasonSceneEventBossDoppelgangerS3
		}
	}

	if sceneEventImplChangeMap[evtData.seasonId] then
		for i, v in pairs(sceneEventImplChangeMap[evtData.seasonId]) do
			sceneEventImplClassMap[i] = v
		end
	end

	if sceneEventImplClassMap[evtData.eventType] then
		return sceneEventImplClassMap[evtData.eventType].New(unit, evtData)
	else
		return SeasonSceneEventImplBase.New(unit, evtData)
	end

	return SeasonSceneEventImplBase.New(unit, evtData)
end

function SeasonSceneEventImplBase:ctor(unit, evtData)
	self._unit = unit
	self.evtData = evtData
end

function SeasonSceneEventImplBase:getDependentResources()
	return
end

function SeasonSceneEventImplBase:getIconSprite()
	if not self._evtGo then
		return
	end

	local curStatus = self:_getCurStatus()
	local stateNode = self._evtGo.transform:Find("state")

	if not stateNode then
		return
	end

	local transform = stateNode
	local childCount = transform.childCount
	local currStatusGo

	curStatus = tostring(curStatus)

	for i = 0, childCount - 1 do
		local statusGo = transform:GetChild(i).gameObject
		local isActive = not not string.find(statusGo.name, curStatus)

		if isActive then
			currStatusGo = statusGo

			break
		end
	end

	if not currStatusGo then
		for i = 0, childCount - 1 do
			local statusGo = transform:GetChild(i).gameObject
			local isActive = not not string.find(statusGo.name, "0")

			if isActive then
				currStatusGo = statusGo

				break
			end
		end
	end

	if not currStatusGo then
		return
	end

	local spRender = currStatusGo:GetComponent(ComponentType.SpriteRenderer)

	if not spRender then
		return
	end

	return spRender.sprite
end

function SeasonSceneEventImplBase:onActive(evtGo)
	self._evtGo = evtGo

	if not self.evtData or goutil.isNil(self._evtGo) then
		return
	end

	self:updateEvtStatus()
end

function SeasonSceneEventImplBase:onDeactive()
	self._evtGo = nil
end

function SeasonSceneEventImplBase:handleBossPhaseChange(prePhaseId, curPhaseId)
	return
end

function SeasonSceneEventImplBase:setPrepareTranspointAnim(prepared)
	return
end

function SeasonSceneEventImplBase:setPlayedDoppelgangerAppear()
	return
end

function SeasonSceneEventImplBase:setPlayedBossAppear()
	return
end

function SeasonSceneEventImplBase:updateEvtStatus()
	local curStatus = self:_getCurStatus()

	self:_updateEvtStatusNodes(curStatus)
end

function SeasonSceneEventImplBase:_getCurStatus()
	return (SeasonModel.instance:isOccupied(self.evtData.id) or nil) and 4
end

function SeasonSceneEventImplBase:_updateEvtStatusNodes(curStatus)
	if not self._evtGo then
		return
	end

	local stateNode = self._evtGo.transform:Find("state")

	if not stateNode then
		return
	end

	local transform = stateNode
	local childCount = transform.childCount
	local currStatusGo

	curStatus = tostring(curStatus)

	for i = 0, childCount - 1 do
		local statusGo = transform:GetChild(i).gameObject
		local isActive = not not string.find(statusGo.name, curStatus)

		statusGo:SetActive(isActive or false)

		if isActive then
			currStatusGo = statusGo
		end
	end

	if not currStatusGo then
		for i = 0, childCount - 1 do
			local statusGo = transform:GetChild(i).gameObject
			local isActive = not not string.find(statusGo.name, "0")

			statusGo:SetActive(isActive or false)
		end
	end
end

return SeasonSceneEventImplBase
