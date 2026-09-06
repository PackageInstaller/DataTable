-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/mainplayer/SceneMonsterMgr.lua

module("logicscene.scene.component.mainplayer.SceneMonsterMgr", package.seeall)

local SceneMonsterMgr = class("SceneMonsterMgr", SceneComponentBase)

function SceneMonsterMgr:ctor(scene)
	SceneMonsterMgr.super.ctor(self, scene)

	self._isReady = nil
	self._mstInsIds = nil
	self._mstNums = nil
	self._tasksMstIds = nil
end

function SceneMonsterMgr:onEnterScene(sceneId, bornX, bornZ)
	GlobalDispatcher:addListener(GlobalNotify.OnCreateSceneMonster, self._onMonsterCreate, self)
	GlobalDispatcher:addListener(GlobalNotify.OnRemoveSceneMonster, self._onMonsterRemove, self)
end

function SceneMonsterMgr:onEnterSceneFinished()
	self._isReady = true

	local monsters = CityModel.instance:getMonstersMoDict()

	self._tasksMstIds = TaskModel.instance:getTaskesMonsters()

	if monsters then
		for k, v in pairs(monsters) do
			local cnt = #v
			local copy = {}
			local random = {}

			table.merge(copy, v)

			local idx0 = 1

			while true do
				local mstId = copy[idx0]

				if not mstId then
					break
				end

				local mstCo = SceneConfig.instance:getMonsterMaskterCo(copy[idx0])

				if mstCo.isSourcemon then
					table.insert(random, copy[idx0])
					table.remove(copy, idx0)

					idx0 = idx0 - 1
				else
					idx0 = idx0 + 1
				end
			end

			while #copy > 0 do
				local idx = math.random(#copy)

				table.insert(random, copy[idx])
				table.remove(copy, idx)
			end

			for i = 1, cnt do
				if self:_isNumLimit(k) and (not self._tasksMstIds or not self._tasksMstIds[mstId]) then
					break
				end

				self:_createMonster(k, random[i])
			end
		end
	end
end

function SceneMonsterMgr:onExitScene()
	GlobalDispatcher:removeListener(GlobalNotify.OnCreateSceneMonster, self._onMonsterCreate, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnRemoveSceneMonster, self._onMonsterRemove, self)

	self._isReady = nil
	self._mstInsIds = nil
	self._mstNums = nil
	self._tasksMstIds = nil
end

function SceneMonsterMgr:_onMonsterCreate(zoneId, mstId)
	if self._isReady then
		self:_createMonster(zoneId, mstId)
	end
end

function SceneMonsterMgr:_onMonsterRemove(zoneId, mstId)
	if not self._mstInsIds then
		return
	end

	local instanceIds = self._mstInsIds[mstId]

	if not instanceIds then
		return
	end

	local scene = SceneMgr.instance:getCurScene()

	for i = 1, #instanceIds do
		local insId = instanceIds[i]
		local unit = scene.unitFactory:getUnit(UnitTag.Monster, instanceIds[i])

		if unit and unit.zoneId == zoneId then
			scene.unitFactory:destroyMonsterById(insId)

			if not self._mstNums[zoneId] then
				local num = 1

				num = self._mstNums[zoneId] - 1
				self._mstNums[zoneId] = self._mstNums[zoneId]

				break
			end
		end
	end
end

function SceneMonsterMgr:_createMonster(zoneId, mstId)
	if self._isReady and (self._tasksMstIds and self._tasksMstIds[mstId] or not self:_isNumLimit(zoneId)) then
		self._scene.unitFactory:createMonster(zoneId, mstId)
		self:_addMstNum(zoneId)

		if self._tasksMstIds then
			self._tasksMstIds[mstId] = nil
		end
	end
end

function SceneMonsterMgr:isReady()
	return self._isReady and CityModel.instance.isMonsterDataReady
end

function SceneMonsterMgr:_isNumLimit(zoneId)
	if self._mstNums then
		local maxNum = SceneConfig.instance:getZoneMonstersMaxNum(zoneId)

		if not maxNum then
			return true
		end

		if maxNum == 0 then
			return
		end

		if not self._mstNums[zoneId] then
			local num = 0

			return maxNum <= num
		end
	end
end

function SceneMonsterMgr:_addMstNum(zoneId)
	self._mstNums = self._mstNums or {}

	if not self._mstNums[zoneId] then
		local num = 0

		self._mstNums[zoneId] = num + 1
	end
end

function SceneMonsterMgr:addMonsterInsIds(mstId, insId)
	self._mstInsIds = self._mstInsIds or {}

	local instanceIds = self._mstInsIds[mstId]

	if not instanceIds then
		instanceIds = {}
		self._mstInsIds[mstId] = instanceIds
	end

	instanceIds[#instanceIds + 1] = insId
end

function SceneMonsterMgr:removeMonsterInsIds(mstId, insId)
	if not self._mstInsIds then
		return
	end

	local instanceIds = self._mstInsIds[mstId]

	if not instanceIds then
		return
	end

	local index = table.indexof(instanceIds, insId)

	if index then
		table.remove(instanceIds, index)
	end
end

function SceneMonsterMgr:getMonsterInsIds(mstId)
	if self._mstInsIds then
		local instanceIds = self._mstInsIds[mstId]

		if instanceIds then
			local scene = SceneMgr.instance:getCurScene()
			local cnt = #instanceIds

			for i = 1, cnt do
				local unit = scene.unitFactory:getUnit(UnitTag.Monster, instanceIds[i])

				if unit then
					return instanceIds[i]
				end
			end
		end
	end
end

return SceneMonsterMgr
