-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/model/FamilySeasonRankModel.lua

module("logic.extensions.newfamily.model.FamilySeasonRankModel", package.seeall)

local FamilySeasonRankModel = class("FamilySeasonRankModel", BaseModel)

function FamilySeasonRankModel:ctor()
	return
end

function FamilySeasonRankModel:onInit()
	self:onReset()
end

function FamilySeasonRankModel:onReset()
	self._nfsNewMsg = nil
end

function FamilySeasonRankModel:scPushFamilySeasonRankViewRank(msg)
	return
end

function FamilySeasonRankModel:handlePM_FamilySeasonRankViewNewRankRes(msg)
	self._nfsNewMsg = msg
end

function FamilySeasonRankModel:getNfsNewMsg()
	return self._nfsNewMsg
end

FamilySeasonRankModel.instance = FamilySeasonRankModel.New()

return FamilySeasonRankModel
