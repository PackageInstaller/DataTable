-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyElementMo.lua

module("modules.logic.sp01.odyssey.model.OdysseyElementMo", package.seeall)

local OdysseyElementMo = pureTable("OdysseyElementMo")

function OdysseyElementMo:init(id)
	self.id = id
	self.config = OdysseyConfig.instance:getElementConfig(id)

	if not self.config then
		logError(self.id .. "的配置为空")
	end

	self.optionEleData = {}
	self.religionEleData = {}
	self.conquestEleData = {}
	self.mythicEleData = {}
end

function OdysseyElementMo:updateInfo(info)
	self.id = info.id
	self.status = info.status

	if self:isFinish() then
		OdysseyDungeonModel.instance:setFinishElementMap(self.id)
	end

	self.optionEleData.optionId = info.optionEle and info.optionEle.result
	self.religionEleData.religionId = info.religionEle and info.religionEle.religionId
	self.conquestEleData.highWave = info.conquestEle and info.conquestEle.highWave
	self.mythicEleData.evaluation = info.mythicEle and info.mythicEle.evaluation
end

function OdysseyElementMo:getOptionEleData()
	return self.optionEleData
end

function OdysseyElementMo:getReligionEleData()
	return self.religionEleData
end

function OdysseyElementMo:getConquestEleData()
	return self.conquestEleData
end

function OdysseyElementMo:getMythicEleData()
	return self.mythicEleData
end

function OdysseyElementMo:isFinish()
	return self.status == OdysseyEnum.ElementStatus.Finish
end

return OdysseyElementMo
