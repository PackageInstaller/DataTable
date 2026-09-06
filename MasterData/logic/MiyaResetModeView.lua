-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaResetModeView.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaResetModeView", package.seeall)

local MiyaResetModeView = class("MiyaResetModeView", MiyaModeView)

function MiyaResetModeView:buildUI()
	MiyaResetModeView.super.buildUI(self)

	self._btnRule = self:getBtn("btnRule")
end

function MiyaResetModeView:unbindEvents()
	MiyaResetModeView.super.unbindEvents(self)
	self._btnRule:RemoveClickListener()
end

function MiyaResetModeView:bindEvents()
	MiyaResetModeView.super.bindEvents(self)
	self._btnRule:AddClickListener(self._onClickRule, self)
end

function MiyaResetModeView:onEnter()
	MiyaResetModeView.super.onEnter(self)

	local curModeId = MiyaGameModel.instance:getCurModeId()
	local modeCfg = MiyaGameConfig.instance:getModeCfg(curModeId)
	local gameTime, passNeedNum = MiyaGameController.instance:getModeBubbleParams(curModeId)

	if gameTime ~= nil then
		self._txtModeDesc.text = string.format(modeCfg.smallBubble, gameTime, passNeedNum)
	else
		local curDifficulty = MiyaGameModel.instance:getCurDifficulty()
		local difficultyCfg = MiyaGameConfig.instance:getDifficultyCfg(curDifficulty)

		self._txtModeDesc.text = "推荐战力：" .. MiyaGameController.instance:getRecommendZdl(curDifficulty)
	end

	self._txtModeName.text = modeCfg.modeName

	self._imgIconChange:SetState(MathUtil.clamp(curModeId, 1, 5) - 1)
end

function MiyaResetModeView:_onClickRule()
	UIStateManager.instance:push(ViewName.RulesView, "miyamoderule")
end

return MiyaResetModeView
