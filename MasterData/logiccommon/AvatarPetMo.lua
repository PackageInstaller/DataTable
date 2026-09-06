-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/model/AvatarPetMo.lua

module("logiccommon.common.avatar.new.model.AvatarPetMo", package.seeall)

local AvatarPetMo = class("AvatarPetMo", AvatarModel)

function AvatarPetMo:ctor(skeletonId, isSetDefault)
	AvatarPetMo.super.ctor(self, skeletonId, isSetDefault)
end

function AvatarPetMo:getAvatarType()
	return AvatarCreateType.Pig
end

function AvatarPetMo:getOwnPartTypeNames()
	return {
		AvatarPartTypeName[AvatarPartType.Top]
	}
end

function AvatarPetMo:getOwnPendanttTypeNames()
	return {
		AvatarPendantTypeName[AvatarPendantType.Tail]
	}
end

function AvatarPetMo:getOwnOtherDataNames()
	return {}
end

return AvatarPetMo
