-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventOpenView.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventOpenView", package.seeall)

local FightTLEventOpenView = class("FightTLEventOpenView", FightTimelineTrackItem)

function FightTLEventOpenView:onTrackStart(fightStepData, duration, paramsArr)
	local viewName = paramsArr[1]

	if string.nilorempty(viewName) then
		return
	end

	self.viewName = viewName

	ViewMgr.instance:openView(self.viewName)
end

function FightTLEventOpenView:onTrackEnd()
	self:closeView()
end

function FightTLEventOpenView:onDestructor()
	self:closeView()
end

function FightTLEventOpenView:closeView()
	if self.viewName then
		ViewMgr.instance:closeView(self.viewName)

		self.viewName = nil
	end
end

return FightTLEventOpenView
