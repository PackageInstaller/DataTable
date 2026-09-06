-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/model/AvatarZooMo.lua

module("logiccommon.common.avatar.new.model.AvatarZooMo", package.seeall)

local AvatarZooMo = class("AvatarZooMo", AvatarModel)

function AvatarZooMo:ctor(skeletonId, isSetDefault)
	AvatarZooMo.super.ctor(self, skeletonId, isSetDefault)
end

function AvatarZooMo:getAvatarType()
	return AvatarCreateType.Zoo
end

function AvatarZooMo:getOwnPartTypeNames()
	return {
		AvatarPartTypeName[AvatarPartType.ZooSuit]
	}
end

function AvatarZooMo:getOwnPendanttTypeNames()
	return {
		AvatarPendantTypeName[AvatarPendantType.ZooHead],
		AvatarPendantTypeName[AvatarPendantType.ZooBack],
		AvatarPendantTypeName[AvatarPendantType.ZooFace],
		AvatarPendantTypeName[AvatarPendantType.ZooHeadwear],
		AvatarPendantTypeName[AvatarPendantType.ZooLFoot],
		AvatarPendantTypeName[AvatarPendantType.ZooRHand],
		AvatarPendantTypeName[AvatarPendantType.ZooStar],
		AvatarPendantTypeName[AvatarPendantType.ZooTail]
	}
end

function AvatarZooMo:getOwnOtherDataNames()
	return {}
end

function AvatarZooMo:getOwnNakeParts()
	return {
		AvatarNakePartType.HeadZoo,
		AvatarNakePartType.BodyZoo,
		AvatarNakePartType.ArmZoo1,
		AvatarNakePartType.ArmZoo2,
		AvatarNakePartType.ArmZoo3,
		AvatarNakePartType.HandZoo,
		AvatarNakePartType.LegZoo1,
		AvatarNakePartType.LegZoo2,
		AvatarNakePartType.LegZoo3,
		AvatarNakePartType.FootZoo,
		AvatarNakePartType.TailZoo,
		AvatarNakePartType.HairZoo
	}
end

function AvatarZooMo:setDataByAnimalMo(animalMo)
	if not animalMo then
		print("Get Nil Animal Mo")

		return
	end

	local raceId = checkint(animalMo.raceId)
	local raceCfg = ZooConfig.instance:getAnimalById(raceId)
	local skeId = checkint(raceCfg and raceCfg.skeletonId)

	if skeId > 0 then
		self:setSkeletonByCfgId(skeId)

		for i, geneId in ipairs(animalMo.effectiveGene) do
			self:setShowGeneDataById(geneId)
		end
	else
		print(raceId .. " Get Nil Animal Skc Cfg")
	end
end

function AvatarZooMo:setShowGeneDataById(geneId)
	local geneCfg = ZooConfig.instance:getGene(checkint(geneId))
	local partId = checkint(geneCfg and geneCfg.modelId)

	if partId > 0 then
		self:setDataByCfgId(partId)
	end
end

return AvatarZooMo
