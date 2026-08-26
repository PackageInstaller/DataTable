-- chunkname: @modules/logic/versionactivity1_4/act132/model/Activity132Model.lua

module("modules.logic.versionactivity1_4.act132.model.Activity132Model", package.seeall)

local Activity132Model = class("Activity132Model", BaseModel)

function Activity132Model:onInit()
	return
end

function Activity132Model:reInit()
	return
end

function Activity132Model:setActivityInfo(info)
	local mo = self:getActMoById(info.activityId)

	if mo then
		mo:init(info)
	end
end

function Activity132Model:getActMoById(activityId)
	if not activityId then
		return
	end

	local mo = self:getById(activityId)

	if not mo then
		mo = Activity132Mo.New(activityId)

		self:addAtLast(mo)
	end

	return mo
end

function Activity132Model:getContentState(activityId, contentId)
	local mo = self:getActMoById(activityId)

	if not mo then
		return
	end

	return mo:getContentState(contentId)
end

function Activity132Model:setSelectCollectId(activityId, id)
	local mo = self:getActMoById(activityId)

	if not mo then
		return
	end

	mo:setSelectCollectId(id)
	Activity132Controller.instance:dispatchEvent(Activity132Event.OnChangeCollect)
end

function Activity132Model:getSelectCollectId(activityId)
	local mo = self:getActMoById(activityId)

	if not mo then
		return
	end

	return mo:getSelectCollectId()
end

function Activity132Model:setContentUnlock(info)
	local mo = self:getActMoById(info.activityId)

	if not mo then
		return
	end

	return mo:setContentUnlock(info.contentId)
end

function Activity132Model:checkClueRed(activityId, clueId)
	local mo = self:getActMoById(activityId)

	if not mo then
		return
	end

	return mo:checkClueRed(clueId)
end

Activity132Model.instance = Activity132Model.New()

return Activity132Model
