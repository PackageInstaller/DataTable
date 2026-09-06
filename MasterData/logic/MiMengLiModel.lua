-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/model/MiMengLiModel.lua

module("logic.extensions.mimengli.model.MiMengLiModel", package.seeall)

local MiMengLiModel = class("MiMengLiModel", BaseModel)

function MiMengLiModel:onInit()
	self:onReset()
end

function MiMengLiModel:onReset()
	self._msgPool = {}
	self._fightPbMap = {}
end

function MiMengLiModel:onGetInfo(msg)
	local pb = GameUtil.pbToTable(msg)

	self._msgPool[msg.activityId] = pb

	self:updateMaterial(msg.activityId, pb.clgInfo)
end

function MiMengLiModel:updateMaterial(activityId, clgInfo)
	if clgInfo then
		local actCfg = MiMengLiConfig.instance:getActivityCfgById(activityId) or {}
		local fakeItemID = checknumber(actCfg.fakeItemID)
		local score = checknumber(clgInfo.score)

		MaterialModel.instance:UpdateMaterial(MatType.Item_Fake, fakeItemID, score)
	end
end

function MiMengLiModel:getInfo(activityId)
	return self._msgPool[activityId]
end

function MiMengLiModel:onSelectPets(msg)
	local pb = GameUtil.pbToTable(msg)
	local activityId = pb.activityId
	local info = self._msgPool[activityId]

	if info and info.clgInfo then
		info.clgInfo.selectedPetHpInfo = pb.selectedPetHpInfo
	end
end

function MiMengLiModel:onSelectTag(msg)
	local pb = GameUtil.pbToTable(msg)
	local activityId = pb.activityId
	local info = self._msgPool[activityId]

	if info and info.clgInfo then
		info.clgInfo.curStageSelectedTagType = pb.curStageSelectedTagType
		info.clgInfo.tagNumInfo = pb.tagNumInfo
	end
end

function MiMengLiModel:handleFightRes(msg)
	self._fightPbMap[msg.activityId] = GameUtil.pbToTable(msg)
end

function MiMengLiModel:getFightPb(activityId)
	return self._fightPbMap[activityId]
end

function MiMengLiModel:onConfirm(msg)
	local pb = GameUtil.pbToTable(msg)

	if pb.clgInfo then
		local info = self:getInfo(msg.activityId)

		info.clgInfo = pb.clgInfo

		self:updateMaterial(msg.activityId, pb.clgInfo)
	end
end

MiMengLiModel.instance = MiMengLiModel.New()

return MiMengLiModel
