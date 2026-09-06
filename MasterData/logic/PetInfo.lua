-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/model/PetInfo.lua

module("logic.extensions.pigraise.model.PetInfo", package.seeall)

local PetInfo = class("PetInfo")

function PetInfo:ctor()
	self.id = nil
	self.defineId = nil
	self.name = nil
	self.hair = 0
	self.tail = 0
	self.skin = 0
	self.modelInfo = nil
	self.intimacy = 0
	self.mood = 0
	self.energy = 0
	self.feedbackEventId = 0
	self.isFollow = false
	self.moodUpdateTime = nil
	self.energyUpdateTime = nil
	self.hasGainPrizeLvs = nil
	self.isTake = false
	self.hasFreeRenameTimes = false
	self.todayHasRename = false
	self.hasOWn = false
	self.cfg = nil
end

function PetInfo:setInfo(info)
	self.id = checknumber(info.id)
	self.defineId = checknumber(info.defineId)
	self.hair = checknumber(info.hair)
	self.tail = checknumber(info.tail)
	self.skin = checknumber(info.skin)
	self.name = info.name
	self.intimacy = checknumber(info.intimacy)
	self.mood = checknumber(info.mood)
	self.energy = checknumber(info.energy)
	self.isFollow = info.isFollow
	self.feedbackEventId = info.feedbackEventId
	self.moodUpdateTime = checknumber(info.moodUpdateTime)
	self.energyUpdateTime = checknumber(info.energyUpdateTime)
	self.hasGainPrizeLvs = {}

	for _, hasGainlv in ipairs(info.hasGainLvPrize) do
		table.insert(self.hasGainPrizeLvs, checknumber(hasGainlv))
	end

	self.isTake = info.isTake
	self.hasFreeRenameTimes = info.hasFreeRenameTimes
	self.todayHasRename = info.todayHasRename
	self.hasOWn = true
	self.cfg = PigraiseConfig.instance:getPetCfgById(self.defineId)
end

function PetInfo:SetCfg(cfg)
	self.cfg = cfg
	self.defineId = cfg.defineId
	self.name = cfg.name
end

function PetInfo:getPetAvatarMo()
	local avatarMo = AvatarPetMo.New()

	if self.cfg then
		avatarMo.skeleton = self.cfg.modelId

		local partCfg = PigraiseConfig.instance:getModelinfoCfgById(self.defineId, 1, self.skin)

		if partCfg then
			avatarMo:setDataByCfgId(partCfg.partId)
		end

		partCfg = PigraiseConfig.instance:getModelinfoCfgById(self.defineId, 2, self.tail)

		if partCfg then
			avatarMo:setDataByCfgId(partCfg.partId)
		end

		partCfg = PigraiseConfig.instance:getModelinfoCfgById(self.defineId, 3, self.hair)

		if partCfg then
			avatarMo:setDataByCfgId(partCfg.partId)
		end

		avatarMo:setDefaultState()
	end

	return avatarMo
end

function PetInfo:getIsAbleUnlock()
	if self.hasOWn then
		return false
	end

	if self.cfg and self.cfg.activateItem and MaterialMgr.getMatEnough(self.cfg.activateItem) then
		return true
	end

	return false
end

function PetInfo:getCurState()
	if self:getIsAbleUnlock() then
		return 1
	end

	if self.hasOWn then
		if self.isTake then
			return 2
		else
			return 3
		end
	end

	return 4
end

function PetInfo:isAbleUnlockOrOwn()
	return self:getCurState() < 4
end

return PetInfo
