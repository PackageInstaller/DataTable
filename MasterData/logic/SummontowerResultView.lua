-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerResultView.lua

module("logic.extensions.summontower.view.SummontowerResultView", package.seeall)

local SummontowerResultView = class("SummontowerResultView", ViewComponent)

function SummontowerResultView:buildUI()
	SummontowerResultView.super.buildUI(self)

	self._btnClose = self:getBtn("btnSure")
	self._txtDesc = self:getTxt("descbg/txtDesc")
	self._btnTxt = self:getTxt("btnSure/Text")
end

function SummontowerResultView:bindEvents()
	SummontowerResultView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function SummontowerResultView:unbindEvents()
	SummontowerResultView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function SummontowerResultView:onEnter()
	SummontowerResultView.super.onEnter(self)

	local tips, btnTxt
	local currStage = SummontowerModel.instance:getCurLevelId()

	if not SummontowerMapModel.instance:isPassGame() then
		tips = "很遗憾，你没有复活石，本次冒险结束了！"
		btnTxt = "知道了"
		currStage = currStage - 1
	else
		tips = "恭喜你，本次冒险通关了所有关卡！"
		btnTxt = "太棒了"
	end

	local currScores = SummontowerMapModel.instance:getResultScores()

	tips = tips .. "\n" .. string.format("本次闯关：%d关\n本次冒险积分：%d", currStage, currScores)
	self._btnTxt.text = btnTxt
	self._txtDesc.text = tips
end

function SummontowerResultView:onExit()
	SummontowerController.instance:resetGame()
	SummontowerResultView.super.onExit(self)
end

function SummontowerResultView:_onClickClose()
	SummontowerController.instance:resetGame()
	self:close()
	UIStateManager.instance:clear(true)

	if SummontowerController.instance:getActivityId() ~= 0 then
		UIStateManager.instance:push(ViewName.SummontowerStartView)
	end
end

return SummontowerResultView
