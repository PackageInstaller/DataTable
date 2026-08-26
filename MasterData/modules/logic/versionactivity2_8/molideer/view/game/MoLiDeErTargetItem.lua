-- chunkname: @modules/logic/versionactivity2_8/molideer/view/game/MoLiDeErTargetItem.lua

module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErTargetItem", package.seeall)

local MoLiDeErTargetItem = class("MoLiDeErTargetItem", MoLiDeErTargetResultItem)

function MoLiDeErTargetItem:init(go)
	self.viewGO = go
	self._txtTarget = gohelper.findChildText(self.viewGO, "#txt_Target")
	self._txtState1 = gohelper.findChildText(self.viewGO, "#txt_Target/State1/#txt_State1")
	self._goState1 = gohelper.findChild(self.viewGO, "#txt_Target/State1")
	self._goLine = gohelper.findChild(self.viewGO, "#txt_Target/State1/image_Line")
	self._imageActionIcon = gohelper.findChildImage(self.viewGO, "#txt_Target/State1/#txt_State1/#image_ActionIcon")
	self._txtState2 = gohelper.findChildText(self.viewGO, "#txt_Target/State2/#txt_State2")
	self._goState2 = gohelper.findChild(self.viewGO, "#txt_Target/State2")
	self._imageActionIcon2 = gohelper.findChildImage(self.viewGO, "#txt_Target/State2/#txt_State2/#image_ActionIcon")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "#txt_Target/#img_Icon")
	self._sliderProgress = gohelper.findChildSlider(self.viewGO, "#txt_Target/Slider")
	self._goIconFx = gohelper.findChild(self.viewGO, "#txt_Target/#img_Icon/#Star_ani")
	self._goTitleFx = gohelper.findChild(self.viewGO, "#txt_Target/#saoguang")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MoLiDeErTargetItem:_editableInitView()
	self._sliderAnimator = gohelper.findChildComponent(self._sliderProgress.gameObject, "", gohelper.Type_Animator)
	self._goStateFxRed1 = gohelper.findChild(self.viewGO, "#txt_Target/State1/#txt_State1/#saoguang_red")
	self._goStateFxGreen1 = gohelper.findChild(self.viewGO, "#txt_Target/State1/#txt_State1/#saoguang_green")
	self._goStateFxYellow1 = gohelper.findChild(self.viewGO, "#txt_Target/State1/#txt_State1/#saoguang_yellow")
	self._goStateFxRed2 = gohelper.findChild(self.viewGO, "#txt_Target/State2/#txt_State2/#saoguang_red")
	self._goStateFxGreen2 = gohelper.findChild(self.viewGO, "#txt_Target/State2/#txt_State2/#saoguang_green")
	self._goStateFxYellow2 = gohelper.findChild(self.viewGO, "#txt_Target/State2/#txt_State2/#saoguang_yellow")
	self._stateFx1 = {
		self._goStateFxGreen1,
		self._goStateFxYellow1,
		self._goStateFxRed1
	}
	self._stateFx2 = {
		self._goStateFxGreen2,
		self._goStateFxYellow2,
		self._goStateFxRed2
	}
end

function MoLiDeErTargetItem:addEventListeners()
	return
end

function MoLiDeErTargetItem:removeEventListeners()
	return
end

function MoLiDeErTargetItem:getFxTargetTran()
	return self._sliderProgress.transform
end

function MoLiDeErTargetItem:refreshState(targetId, gameInfoMo, realRound, showAnim)
	local curExecution = gameInfoMo.leftRoundEnergy
	local curRound = gameInfoMo.currentRound
	local curProgress = gameInfoMo:getTargetProgress(targetId)

	self._sliderProgress:SetValue(curProgress * 0.01)

	local progressState = MoLiDeErHelper.getTargetState(curProgress)
	local descConfig = MoLiDeErConfig.instance:getProgressDescConfigById(gameInfoMo.gameId, targetId)
	local executionDesc, executionState = MoLiDeErHelper.getRangeDesc(curExecution, descConfig.energyRange, descConfig.energyDesc)
	local executionColor = MoLiDeErEnum.TargetTitleColor[executionState]

	self._txtState1.text = string.format("<color=%s>%s</color>", executionColor, executionDesc)

	UISpriteSetMgr.instance:setMoLiDeErSprite(self._imageIcon, string.format("v2a8_molideer_game_targeticon_0%s_%s", targetId, progressState))
	UIColorHelper.set(self._imageActionIcon, executionColor)

	if self._previousExecutionState and self._previousExecutionState ~= progressState then
		for state, go in ipairs(self._stateFx1) do
			gohelper.setActive(go, state == progressState)
		end
	end

	self._previousExecutionState = progressState

	local showRoundState = realRound ~= nil and realRound ~= 0

	gohelper.setActive(self._goState2, showRoundState)
	gohelper.setActive(self._goLine, showRoundState)

	if showRoundState then
		local roundDesc, roundState = MoLiDeErHelper.getRangeDesc(math.max(0, realRound - curRound), descConfig.roundRange, descConfig.roundDesc)
		local roundColor = MoLiDeErEnum.TargetTitleColor[roundState]

		self._txtState2.text = string.format("<color=%s>%s</color>", roundColor, roundDesc)

		UIColorHelper.set(self._imageActionIcon2, roundColor)

		if self._previousRoundState and self._previousRoundState ~= roundState then
			for state, go in ipairs(self._stateFx2) do
				gohelper.setActive(go, state == roundState)
			end
		end

		self._previousRoundState = roundState
	end

	if showAnim then
		self._sliderAnimator:Play("light", 0, 0)
	else
		self._sliderAnimator:Play("idle", 0, 0)
	end
end

return MoLiDeErTargetItem
