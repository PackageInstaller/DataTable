-- chunkname: @modules/logic/survival/view/map/SurvivalInitTeamView.lua

module("modules.logic.survival.view.map.SurvivalInitTeamView", package.seeall)

local SurvivalInitTeamView = class("SurvivalInitTeamView", BaseView)

function SurvivalInitTeamView:ctor(path)
	self._path = path
end

function SurvivalInitTeamView:onInitView()
	self._root = gohelper.findChild(self.viewGO, self._path)
	self._btnstart = gohelper.findChildButtonWithAudio(self._root, "#btn_Start")
	self._btnreturn = gohelper.findChildButtonWithAudio(self._root, "#btn_Return")
end

function SurvivalInitTeamView:addEvents()
	if self._btnstart then
		self._btnstart:AddClickListener(self._btnstartOnClick, self)
	end

	if self._btnreturn then
		self._btnreturn:AddClickListener(self._btnreturnOnClick, self)
	end
end

function SurvivalInitTeamView:removeEvents()
	if self._btnstart then
		self._btnstart:RemoveClickListener()
	end

	if self._btnreturn then
		self._btnreturn:RemoveClickListener()
	end
end

function SurvivalInitTeamView:setIsShow(isShow)
	gohelper.setActive(self._root, isShow)

	if isShow then
		self:onViewShow()
	end
end

function SurvivalInitTeamView:onViewShow()
	return
end

function SurvivalInitTeamView:_btnstartOnClick()
	self._isNext = true

	self:playSwitchAnim()
end

function SurvivalInitTeamView:_btnreturnOnClick()
	self._isNext = false

	self:playSwitchAnim()
end

function SurvivalInitTeamView:playSwitchAnim()
	self.viewContainer:playAnim("panel_out")
	TaskDispatcher.runDelay(self._delayPanelIn, self, 0.2)
	UIBlockHelper.instance:startBlock("SurvivalInitTeamView.playSwitchAnim", 0.2)
end

function SurvivalInitTeamView:_delayPanelIn()
	self.viewContainer:playAnim("panel_in")

	if self._isNext then
		self.viewContainer:nextStep()
	else
		self.viewContainer:preStep()
	end
end

function SurvivalInitTeamView:onClose()
	TaskDispatcher.cancelTask(self._delayPanelIn, self)
end

return SurvivalInitTeamView
