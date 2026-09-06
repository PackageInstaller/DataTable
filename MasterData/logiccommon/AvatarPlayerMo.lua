-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/model/AvatarPlayerMo.lua

module("logiccommon.common.avatar.new.model.AvatarPlayerMo", package.seeall)

local AvatarPlayerMo = class("AvatarPlayerMo", AvatarModel)

function AvatarPlayerMo:ctor(skeletonId, isSetDefault)
	AvatarPlayerMo.super.ctor(self, skeletonId, isSetDefault)
end

function AvatarPlayerMo:getAvatarType()
	return AvatarCreateType.Player
end

function AvatarPlayerMo:getOwnNakeParts()
	return {
		AvatarNakePartType.Chest,
		AvatarNakePartType.Forearms,
		AvatarNakePartType.Abdomen,
		AvatarNakePartType.Crotch,
		AvatarNakePartType.Thighs,
		AvatarNakePartType.Foot,
		AvatarNakePartType.Hands,
		AvatarNakePartType.Head,
		AvatarNakePartType.Shanks,
		AvatarNakePartType.Neck,
		AvatarNakePartType.Knees,
		AvatarNakePartType.Upperarms,
		AvatarNakePartType.Face
	}
end

function AvatarPlayerMo:getOwnPartTypeNames()
	return {
		AvatarPartTypeName[AvatarPartType.Top],
		AvatarPartTypeName[AvatarPartType.Pants],
		AvatarPartTypeName[AvatarPartType.Shoes]
	}
end

function AvatarPlayerMo:getOwnPendanttTypeNames()
	return {
		AvatarPendantTypeName[AvatarPendantType.Lhand],
		AvatarPendantTypeName[AvatarPendantType.Rhand],
		AvatarPendantTypeName[AvatarPendantType.Back],
		AvatarPendantTypeName[AvatarPendantType.Hair],
		AvatarPendantTypeName[AvatarPendantType.Flotage],
		AvatarPendantTypeName[AvatarPendantType.PlayerTail],
		AvatarPendantTypeName[AvatarPendantType.HeadWear]
	}
end

function AvatarPlayerMo:getOwnOtherDataNames()
	return {
		AvatarDataTypeName[AvatarDataType.Mount],
		AvatarDataTypeName[AvatarDataType.UIBG],
		AvatarDataTypeName[AvatarDataType.UISpine]
	}
end

function AvatarPlayerMo:reset()
	AvatarPlayerMo.super.reset(self)

	self.isMount = nil
end

function AvatarPlayerMo:copyDataByMo(mo)
	AvatarPlayerMo.super.copyDataByMo(self, mo)

	self.isMount = mo.isMount
end

function AvatarPlayerMo:dressCloth(dressId)
	local id = checkint(dressId)

	if id > 0 then
		local cfg = DressConfig.instance:getDressCfgById(id)

		if cfg and cfg.partId > 0 then
			self:setDataByCfgId(cfg.partId)
		end
	end
end

function AvatarPlayerMo:undressCloth(dressId)
	local id = checkint(dressId)

	if id > 0 then
		local cfg = DressConfig.instance:getDressCfgById(id)

		if cfg and cfg.partId > 0 then
			self:removeDataByCfgId(cfg.partId)
		end
	end
end

function AvatarPlayerMo:isdressById(dressId)
	local id = checkint(dressId)

	if id > 0 then
		local cfg = DressConfig.instance:getDressCfgById(id)

		if cfg and cfg.partId > 0 then
			return self:isExistDataByCfgId(cfg.partId)
		end
	end

	return false
end

function AvatarPlayerMo:dressSuit(suit)
	if not suit then
		return
	end

	for _, v in ipairs(suit) do
		self:dressCloth(v)
	end
end

function AvatarPlayerMo:unDressSuit(suit)
	if not suit then
		return
	end

	for _, v in ipairs(suit) do
		self:undressCloth(v)
	end
end

function AvatarPlayerMo:isDressSuit(suit)
	if not suit then
		return false
	end

	for _, v in ipairs(suit) do
		if not self:isdressById(v) then
			return false
		end
	end

	return true
end

return AvatarPlayerMo
