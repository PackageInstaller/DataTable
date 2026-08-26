-- chunkname: @modules/logic/fight/entity/comp/skill/FightScreenTextByTimeline.lua

module("modules.logic.fight.entity.comp.skill.FightScreenTextByTimeline", package.seeall)

local FightScreenTextByTimeline = class("FightScreenTextByTimeline", FightTimelineTrackItem)

function FightScreenTextByTimeline:onTrackStart(fightStepData, duration, paramsArr)
	self.view = self:addComponent(FightViewComponent)

	local root = PostProcessingMgr.instance:getCaptureView()
	local type = paramsArr[6]

	if type == "2" then
		local url = "ui/viewres/fight/fight3_7qte_bubbleview.prefab"

		self.view:openSubView(FightScreenBubbleDialogView, url, root, paramsArr, duration, fightStepData)
	elseif type == "1" then
		local url = "ui/viewres/fight/fightscreentextview.prefab"

		self.view:openSubView(FightScreenTextView, url, root, paramsArr, duration, fightStepData)
	else
		local url = "ui/viewres/fight/fightscreentextview.prefab"

		self.view:openSubView(FightScreenTextView, url, root, paramsArr, duration, fightStepData)
	end
end

function FightScreenTextByTimeline:onTrackEnd()
	self.view:disposeSelf()
end

function FightScreenTextByTimeline:onDestructor()
	return
end

return FightScreenTextByTimeline
