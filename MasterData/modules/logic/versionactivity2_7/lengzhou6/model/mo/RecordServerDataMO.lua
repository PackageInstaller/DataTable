-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/mo/RecordServerDataMO.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.mo.RecordServerDataMO", package.seeall)

local RecordServerDataMO = class("RecordServerDataMO")
local data = {}

data.endLessBattleProgress = nil
data.round = nil
data.endLessLayer = nil
data.playerId = nil
data.playerHp = nil
data.playerSkillList = {}
data.enemyConfigId = nil
data.enemyHp = nil
data.curActionStepIndex = nil
data.skillRound = nil
data.chessData = {}

function RecordServerDataMO:ctor()
	self._data = data
end

function RecordServerDataMO:initFormJson(jsonStr)
	self:_fromJson(jsonStr)
end

function RecordServerDataMO:toJson()
	return cjson.encode(self._data)
end

function RecordServerDataMO:_fromJson(jsonStr)
	self._data = cjson.decode(jsonStr)
end

function RecordServerDataMO:getRecordData()
	return self:toJson()
end

function RecordServerDataMO:record(chessData)
	tabletool.clear(self._data)

	if self._data ~= nil then
		self._data.chessData = chessData
		self._data.endLessBattleProgress = LengZhou6GameModel.instance:getEndLessBattleProgress()
		self._data.round = LengZhou6GameModel.instance:getCurRound()
		self._data.endLessLayer = LengZhou6GameModel.instance:getEndLessModelLayer()

		local player = LengZhou6GameModel.instance:getPlayer()

		self._data.playerId = player:getConfigId()

		local enemy = LengZhou6GameModel.instance:getEnemy()

		self._data.enemyConfigId = enemy:getConfigId()

		local var_6_0 = enemy:getAction()

		var_6_0 = var_6_0 and enemy:getAction():getCurBehaviorId()
		self._data.curActionStepIndex = var_6_0

		local var_6_1 = enemy:getAction()

		var_6_1 = var_6_1 and enemy:getAction():getCurRound()
		self._data.skillRound = var_6_1

		local allActiveSkill = player:getActiveSkills()
		local selectSkillIds = {}

		for i = 1, #allActiveSkill do
			local skill = allActiveSkill[i]

			table.insert(selectSkillIds, skill:getConfig().id)
		end

		self._data.playerSkillList = selectSkillIds
		self._data.playerHp = player:getHp()
		self._data.enemyHp = enemy:getHp()
	end
end

function RecordServerDataMO:getData()
	return self._data
end

return RecordServerDataMO
