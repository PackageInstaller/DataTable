-- chunkname: @modules/logic/versionactivity3_3/igor/model/IgorCampEnemyMO.lua

module("modules.logic.versionactivity3_3.igor.model.IgorCampEnemyMO", package.seeall)

local IgorCampEnemyMO = class("IgorCampEnemyMO", IgorCampBasedMO)

function IgorCampEnemyMO:onInit()
	self.ruleList = {}

	local gameMo = IgorModel.instance:getCurGameMo()
	local rules = GameUtil.splitString2(gameMo.config.rules, true)

	for _, rule in ipairs(rules) do
		local data = {}

		data.startTime = rule[1]
		data.repeatTime = rule[2]
		data.soldierId = rule[3]
		data.waitTime = data.startTime
		data.deltaTime = 0

		table.insert(self.ruleList, data)
	end
end

function IgorCampEnemyMO:update(deltaTime)
	IgorCampEnemyMO.super.update(self, deltaTime)
	self:updateCreateSoldier(deltaTime)
end

function IgorCampEnemyMO:updateCreateSoldier(deltaTime)
	if not self.ruleList then
		return
	end

	for _, data in ipairs(self.ruleList) do
		data.deltaTime = data.deltaTime + deltaTime

		if data.waitTime and data.deltaTime >= data.waitTime then
			data.deltaTime = data.deltaTime - data.waitTime
			data.waitTime = data.repeatTime

			self:addEntity(data.soldierId)
		end
	end
end

return IgorCampEnemyMO
