-- chunkname: @modules/logic/versionactivity2_8/act199/model/Activity199Model.lua

module("modules.logic.versionactivity2_8.act199.model.Activity199Model", package.seeall)

local Activity199Model = class("Activity199Model", BaseModel)

function Activity199Model:onInit()
	self._selectHeroId = 0
end

function Activity199Model:reInit()
	self:onInit()
end

function Activity199Model:getActivity199Id()
	return ActivityConfig.instance:getConstAsNum(ActivityEnum.ConstId.SelfSelectCharacterExp, Activity2ndEnum.ActivityId.welfareActivity)
end

function Activity199Model:isActivity199Open()
	local actId = self:getActivity199Id()

	return (ActivityHelper.isOpen(actId) or nil) and true
end

function Activity199Model:setActInfo(msg)
	local heroId = msg.heroId

	if heroId then
		self._selectHeroId = heroId
	end
end

function Activity199Model:updateHeroId(heroId)
	self._selectHeroId = heroId
end

function Activity199Model:getSelectHeroId()
	return self._selectHeroId
end

function Activity199Model:isShowRedDot()
	return self:isActivity199Open() and self._selectHeroId == 0
end

Activity199Model.instance = Activity199Model.New()

return Activity199Model
