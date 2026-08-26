-- chunkname: @modules/logic/fight/view/FightSuccActView.lua

module("modules.logic.fight.view.FightSuccActView", package.seeall)

local FightSuccActView = class("FightSuccActView", BaseView)

function FightSuccActView:showReward()
	self:_showAstrologyStarReward()
	self:_showExchangeList()
end

function FightSuccActView:_showAstrologyStarReward()
	local list = VersionActivity1_3AstrologyModel.instance:getStarReward()

	if list then
		VersionActivity1_3AstrologyModel.instance:setStarReward(nil)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, list)
	end
end

function FightSuccActView:_showExchangeList()
	local list = VersionActivity1_3AstrologyModel.instance:getExchangeList()

	if list then
		VersionActivity1_3AstrologyModel.instance:setExchangeList(nil)
		VersionActivity1_3AstrologyController.instance:openVersionActivity1_3AstrologyPropView(list)
	end
end

function FightSuccActView:onClose()
	VersionActivity1_3AstrologyModel.instance:setStarReward(nil)
	VersionActivity1_3AstrologyModel.instance:setExchangeList(nil)
end

return FightSuccActView
