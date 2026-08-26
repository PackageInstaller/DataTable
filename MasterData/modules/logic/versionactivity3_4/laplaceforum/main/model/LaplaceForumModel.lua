-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/main/model/LaplaceForumModel.lua

module("modules.logic.versionactivity3_4.laplaceforum.main.model.LaplaceForumModel", package.seeall)

local LaplaceForumModel = class("LaplaceForumModel", BaseModel)

function LaplaceForumModel:onInit()
	self:reInit()
end

function LaplaceForumModel:reInit()
	return
end

function LaplaceForumModel:isActUnlock(actId)
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if not actInfoMo:isOnline() or not actInfoMo:isOpen() or actInfoMo:isExpired() then
		return false
	end

	return true
end

LaplaceForumModel.instance = LaplaceForumModel.New()

return LaplaceForumModel
