-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\ContentPanel\\HeroStepUpPanel.lua

local strClassName = "HeroStepUpPanel"
local HeroStepUpPanel = Class(strClassName, UIControls.Child)
local EventConst = require("EventConst")
local ResStep = require("ClientData/ResStep")
local BtnStepUpCell = require("UI/Hero/ContentPanel/BtnStepUpCell")
local STAGE_CELL_HEIGHT = 415
local VIEW_PORT_HEIGHT = 916.2
local SCROLL_MOVE_RATE = 100
local HERO_STAGE_CAMERA_LEFT = {
	10.54,
	11.87,
	109.95
}
local HERO_STAGE_CAMERA_EXPAND_LEFT = {
	8.5,
	11.87,
	109.95
}
local UNLOCK = 1
local CAN_UNLOCK = 2
local UNOPEN = 3

function HeroStepUpPanel:ctor()
	self:initUI()
end

function HeroStepUpPanel:initUI()
	self.btnSkillUp = UIControls.Button(self, "BtnSkillUpGrade")
	self.imgCanSkillUp = UIControls.Image(self, "BtnSkillUpGrade/IconNew")

	self.btnSkillUp:addEventClick(self.onBtnSkillClick)

	self.uiAni = UIControls.UIAni(self, "")

	self.uiAni:addEventAnimateCue(self.skillPanelFold)

	self.cells = {}
	self.scrollStep = UIControls.ScrollViewLoopV(self, "StageUpList")

	self.scrollStep:addEventCellChanged(self.onStepChanged)

	self.slot4RefreshData = Slot(self.refreshData, self)

	EventCenter.addEventListener(EventConst.ITEM_UPDATE, self.slot4RefreshData)
end

function HeroStepUpPanel:setHero(hero, noRefreshPos)
	self.hero = hero
	self.maxStep = self.hero:getMaxStep()

	self.imgCanSkillUp:setVisible(false)

	if noRefreshPos then
		self.scrollStep:setTotalCount(self.maxStep)
	else
		self:refreshScrollContentPos()
	end
end

function HeroStepUpPanel:refreshData(itemId)
	if itemId == Const.MONEY_ID_GOLD then
		for _, cell in pairs(self.cells) do
			cell:refreshForBtnState()
		end
	end
end

function HeroStepUpPanel:onStepChanged(sender, targetCell, newIdx)
	targetCell = targetCell or BtnStepUpCell(sender, "System/Hero/BtnStageUpCell", newIdx)

	targetCell:setHero(self.hero, newIdx)

	self.cells[newIdx] = targetCell

	if self.cells[newIdx].skillPanel.status == CAN_UNLOCK and #self.cells[newIdx].skillPanel.lackInfo == 0 and self.hero.inTeam == 1 then
		self.imgCanSkillUp:setVisible(true)
	end
end

function HeroStepUpPanel:refreshScrollContentPos(step)
	self.scrollStep:setTotalCount(self.maxStep, math.min(step or self:getCurPosStep(), self.hero:getMaxStep()))
end

function HeroStepUpPanel:playScrollMove()
	return
end

function HeroStepUpPanel:timerMoveScrollFunc()
	local curY = self.scroll:getContentY()
	local movePosPerRate = self.tarY - curY > 0 and SCROLL_MOVE_RATE or -SCROLL_MOVE_RATE

	if math.abs(self.tarY - curY) <= math.abs(movePosPerRate) then
		self.scroll:setContentY(self.tarY)
		self.scroll:stopMovement()
		self.timerMoveScroll:Stop()

		return
	end

	self.scroll:setContentY(curY + movePosPerRate)
end

function HeroStepUpPanel:getCurPosStep()
	return self.hero.step + 1
end

function HeroStepUpPanel:getContentYByStep(step)
	if step and step < 2 or self.maxStep <= 2 then
		return 0
	elseif step then
		return math.min(step + 1, self.maxStep) * STAGE_CELL_HEIGHT - VIEW_PORT_HEIGHT - 10
	end
end

function HeroStepUpPanel:getCanUnlockSkillStep()
	local unlockRecharge = 0

	for recharge, cell in ipairs(self.cells) do
		if cell.skillPanel.status == CAN_UNLOCK then
			return recharge
		elseif cell.skillPanel.status == UNLOCK then
			unlockRecharge = recharge
		end
	end

	return unlockRecharge + 1
end

function HeroStepUpPanel:onBtnSkillClick()
	if not self.showSkill then
		self.showSkill = true

		self:playScrollMove()
		self.uiAni:startAni("ShowHeroStageUpSkillWindow")
		self.mWindow.modelStage:moveCameraSmooth(HERO_STAGE_CAMERA_EXPAND_LEFT, 0.6)
	else
		self.showSkill = false

		self:playScrollMove()
		self.uiAni:startAni("HideHeroStageUpSkillWindow")
		self.mWindow.modelStage:moveCameraSmooth(HERO_STAGE_CAMERA_LEFT, 0.5)
	end
end

local BTN_NEXT_POSX_SHOW_SKILL = -515
local BTN_NEXT_POSX_HIDE_SKILL = -160.2

function HeroStepUpPanel:skillPanelFold(aniCom, eventKey)
	if eventKey == "P2" then
		self.mWindow.btnHeroNext:setPosition(BTN_NEXT_POSX_SHOW_SKILL)
	elseif eventKey == "P1" then
		self.mWindow.btnHeroNext:setPosition(BTN_NEXT_POSX_HIDE_SKILL)
	end
end

function HeroStepUpPanel:destroy()
	if self.timerMoveScroll then
		self.timerMoveScroll:Stop()
	end

	EventCenter.removeEventListener(EventConst.ITEM_UPDATE, self.slot4RefreshData)
	HeroStepUpPanel.super.destroy(self)
end

function HeroStepUpPanel:onClose()
	for _, stepCell in pairs(self.cells) do
		stepCell.skillPanel.panelSkillEfx:setVisible(false)
	end
end

return HeroStepUpPanel
