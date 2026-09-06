-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/city/model/CityModel.lua

module("logic.extensions.city.model.CityModel", package.seeall)

local CityModel = class("CityModel", BaseModel)
local json = require("cjson")

function CityModel:onInit()
	self._playerDict = {}
	self._monsterDict = nil
	self.isMonsterDataReady = nil
	self.curCitySceneId = 0
	self.curSceneId = 0
	self.toSceneId = 9999
	self.fromSceneId = 0
	self.toScenePosX = nil
	self.toScenePosY = nil
end

function CityModel:onReset()
	self:removeAllPlayers()

	self._monsterDict = nil
	self.curCitySceneId = 0
	self.curSceneId = 0
	self.toSceneId = 9999
	self.fromSceneId = 0
	self.isMonsterDataReady = nil
	self.toScenePosX = nil
	self.toScenePosY = nil
	self._hideNpcs = nil
end

function CityModel:setNpcInVisible(npcId, inVisible)
	self._hideNpcs = self._hideNpcs or {}
	self._hideNpcs[npcId] = inVisible

	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.City then
		local unit = scene.unitFactory:getUnit(UnitTag.Npc, npcId)

		if unit then
			unit:setVisible(not inVisible)
		end
	end
end

function CityModel:addPlayerMo(mo)
	self._playerDict[mo.id] = mo
end

function CityModel:removePlayerMo(id)
	self._playerDict[id] = nil
end

function CityModel:removeAllPlayers()
	table.clear(self._playerDict)
end

function CityModel:getPlayerMo(id)
	return self._playerDict[id]
end

function CityModel:getPlayerMoDict()
	return self._playerDict
end

function CityModel:addMonsterMo(zoneId, mstId)
	self._monsterDict = self._monsterDict or {}

	local zones = self._monsterDict[zoneId]

	if not zones then
		zones = {}
		self._monsterDict[zoneId] = zones
	end

	zones[#zones + 1] = mstId
end

function CityModel:removeMonsterMo(zoneId, mstId)
	if not self._monsterDict then
		return
	end

	local zones = self._monsterDict[zoneId]

	if not zones then
		return
	end

	local index = table.indexof(zones, mstId)

	if index then
		table.remove(zones, index)
	end
end

function CityModel:getMonstersMoDict()
	return self._monsterDict
end

function CityModel:removeAllMonsters()
	self._monsterDict = nil
	self.isMonsterDataReady = nil
end

CityModel.instance = CityModel.New()

return CityModel
