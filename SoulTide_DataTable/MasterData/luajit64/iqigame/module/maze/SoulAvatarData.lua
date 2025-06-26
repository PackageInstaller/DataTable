-- chunkname: @IQIGame\\Module\\Maze\\SoulAvatarData.lua

SoulAvatarData = {
	entityCid = 0,
	avatarCid = 0
}

function SoulAvatarData.New()
	local obj = Clone(SoulAvatarData)

	return obj
end

function SoulAvatarData:Update(cfgSoulActionData)
	self.avatarCid = cfgSoulActionData.Id
	self.entityCid = cfgSoulActionData.EntityId
	self.headIcon = cfgSoulActionData.HeadIcon
	self.headIcon02 = cfgSoulActionData.HeadIcon02
end
