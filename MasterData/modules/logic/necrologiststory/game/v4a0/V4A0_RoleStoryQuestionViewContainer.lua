-- chunkname: @modules/logic/necrologiststory/game/v4a0/V4A0_RoleStoryQuestionViewContainer.lua

module("modules.logic.necrologiststory.game.v4a0.V4A0_RoleStoryQuestionViewContainer", package.seeall)

local V4A0_RoleStoryQuestionViewContainer = class("V4A0_RoleStoryQuestionViewContainer", BaseViewContainer)

function V4A0_RoleStoryQuestionViewContainer:buildViews()
	local views = {}

	table.insert(views, V4A0_RoleStoryQuestionView.New())

	return views
end

function V4A0_RoleStoryQuestionViewContainer:playCloseTransition(paramTable)
	self:_cancelBlock()
	self:_stopOpenCloseAnim()
	self:startViewCloseBlock()

	local anim = gohelper.findComponentAnim(self.viewGO)

	anim:Play("close_tips")

	local duration = 1

	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, duration)
end

return V4A0_RoleStoryQuestionViewContainer
