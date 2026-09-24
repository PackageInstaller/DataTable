-- chunkname: @modules/logic/assist/model/AssistRecordModel.lua

module("modules.logic.assist.model.AssistRecordModel", package.seeall)

local AssistRecordModel = class("AssistRecordModel", BaseModel)

function AssistRecordModel:onInit()
	self.recordInfoMo = nil
end

function AssistRecordModel:reInit()
	self:onInit()
end

function AssistRecordModel:setRecordInfo(info)
	self.recordInfoMo = GameUtil.rpcInfoToMo(info, AssistRecordInfoMo, self.recordInfoMo)
end

function AssistRecordModel:getRecordInfo()
	return self.recordInfoMo
end

function AssistRecordModel:getDungeonStatByType(dungeonType)
	if self.recordInfoMo == nil then
		return nil
	end

	return self.recordInfoMo:getDungeonStatByType(dungeonType)
end

AssistRecordModel.instance = AssistRecordModel.New()

return AssistRecordModel
