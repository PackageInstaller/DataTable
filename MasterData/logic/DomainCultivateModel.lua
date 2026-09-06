-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domaincultivate/model/DomainCultivateModel.lua

module("logic.extensions.throwshells.model.DomainCultivateModel", package.seeall)

local DomainCultivateModel = class("DomainCultivateModel", BaseModel)

function DomainCultivateModel:ctor()
	return
end

function DomainCultivateModel:onInit()
	self:onReset()
end

function DomainCultivateModel:onReset()
	self.hasGetInfo = {}
	self.resetInfo = {}
end

function DomainCultivateModel:setHasGetInfo(petId, torf)
	self.hasGetInfo[petId] = torf
end

function DomainCultivateModel:getHasGetInfo(petId)
	return self.hasGetInfo[petId]
end

function DomainCultivateModel:setResetInfo(petId, info)
	self.resetInfo[petId] = self.resetInfo[petId] or {}

	for k, v in ipairs(info) do
		self.resetInfo[petId][v.level] = v.tempId
	end
end

function DomainCultivateModel:setResetInfo2(petId, level, tempId)
	self.resetInfo[petId] = self.resetInfo[petId] or {}
	self.resetInfo[petId][level] = self.resetInfo[petId][level] or {}
	self.resetInfo[petId][level] = tempId
end

function DomainCultivateModel:getResetInfo(petId, level)
	if self.resetInfo[petId] and self.resetInfo[petId][level] then
		return self.resetInfo[petId][level]
	else
		return nil
	end
end

function DomainCultivateModel:setActId(id)
	self.actId = id
end

function DomainCultivateModel:getActId()
	return self.actId
end

DomainCultivateModel.instance = DomainCultivateModel.New()

return DomainCultivateModel
