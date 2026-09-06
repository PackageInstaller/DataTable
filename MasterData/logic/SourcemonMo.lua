-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcemon/model/SourcemonMo.lua

module("logic.extensions.sourcemon.model.SourcemonMo", package.seeall)

local SourcemonMo = class("SourcemonMo")

function SourcemonMo:ctor()
	return
end

function SourcemonMo:init(data)
	self:setData(data.id, data.defineId, data.level, data.mutatedType)
end

function SourcemonMo:setData(id, dId, level, mutatedType)
	self.id = checknumber(id)
	self.defineId = checknumber(dId)
	self.level = checknumber(level)
	self.mutatedType = checknumber(mutatedType)
end

function SourcemonMo:getDefineId()
	return self.defineId
end

function SourcemonMo:getConf()
	return (SourceMonConfig.instance:getCfgById(self.defineId))
end

function SourcemonMo:getFightingPower(ownerRaceId)
	local rate = 1

	if ownerRaceId and ownerRaceId > 0 then
		local cfg = SourceMonConfig.instance:getCfgById(self.defineId)

		if CharactorFacade.instance:isMagicPet(ownerRaceId) then
			rate = cfg.magicalZdlRatio
		elseif CharactorFacade.instance:isPhysicPet(ownerRaceId) then
			rate = cfg.physicalZdlRatio
		end
	end

	return math.floor(SourceMonConfig.instance:getZhandouli(self.defineId, self.level, self.mutatedType) * rate)
end

return SourcemonMo
