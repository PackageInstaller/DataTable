-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonbattlesettlementfailView.lua

module("logic.extensions.season.view.SeasonbattlesettlementfailView", package.seeall)

local SeasonbattlesettlementfailView = class("SeasonbattlesettlementfailView", ViewComponent)

function SeasonbattlesettlementfailView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._blurBg = self:getGo("blurBg"):GetComponent(typeof(StaticBluredScreen))
	self._damage = self:getGo("bottom/damage")
	self._damageTxt = self:getTxt("bottom/damage/txt")
	self.btnTotem = self:getGo("bottom/btnTotem")
	self.btnElvenHall = self:getGo("bottom/btnElvenHall")
	self.btnTrainingCourse = self:getGo("bottom/btnTrainingCourse")
end

function SeasonbattlesettlementfailView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	GameUtil.addClickHandler(self.btnTotem, self.onTotemClick, self)
	GameUtil.addClickHandler(self.btnElvenHall, self.onElvenHallClick, self)
	GameUtil.addClickHandler(self.btnTrainingCourse, self.onTrainingCourseClick, self)
end

function SeasonbattlesettlementfailView:unbindEvents()
	self._closeButton:RemoveClickListener()
	GameUtil.rmClickHandler(self.btnTotem)
	GameUtil.rmClickHandler(self.btnElvenHall)
	GameUtil.rmClickHandler(self.btnTrainingCourse)
end

function SeasonbattlesettlementfailView:onEnter()
	self:_playVoice()

	local enumType = BattleSettlementModel.instance:getType()
	local params = BattleSettlementModel.instance:getParams()

	self._damage:SetActive(enumType == BattleSettlementModel.Enum.LongZunChallenge)

	if enumType == BattleSettlementModel.Enum.LongZunChallenge then
		self._damageTxt.text = string.format("本次伤害:<color=#E83A3A>%s</color>", BattleModel.instance.bettleResultData.teamATotalDamage)
	end

	self:_setBlurBg()
end

function SeasonbattlesettlementfailView:onExit()
	self:_removeBlurBg()
end

function SeasonbattlesettlementfailView:_setBlurBg()
	self._blurBg:Release()
	self._blurBg:Capture()
	StaticBluredHook.instance:start(self.mainGO)
	self._blurBg:AddCaptureFinishListener(self._onCaptureScreenFinish, self)
end

function SeasonbattlesettlementfailView:_onCaptureScreenFinish()
	StaticBluredHook.instance:stop()
end

function SeasonbattlesettlementfailView:_removeBlurBg()
	StaticBluredHook.instance:stop()
	self._blurBg:Release()
end

function SeasonbattlesettlementfailView:_onClickClose()
	BattleController.instance:endBattle()
end

function SeasonbattlesettlementfailView:_playVoice()
	AudioBgmPlayer.instance:startPlayEffect(30202)
end

function SeasonbattlesettlementfailView:onTotemClick()
	local buildId = 2
	local unlockLv, jumpTo = SeasonMainCampController.instance:getEntranceLockConfig(buildId)
	local curLv = checknumber(SeasonMainCampModel.instance:getCampLv())

	if curLv < checknumber(unlockLv) then
		TipsFacade.instance:openCommonTips(langPara("主营地%d级解锁", unlockLv))
	else
		UIJumper.instance:pushClearCurStack(ViewName.SeasonTotemPoleView, true)
		self._onClickClose()
	end
end

function SeasonbattlesettlementfailView:onElvenHallClick()
	local buildId = 3
	local unlockLv, jumpTo = SeasonMainCampController.instance:getEntranceLockConfig(buildId)
	local curLv = checknumber(SeasonMainCampModel.instance:getCampLv())

	if curLv < checknumber(unlockLv) then
		TipsFacade.instance:openCommonTips(langPara("主营地%d级解锁", unlockLv))
	else
		UIJumper.instance:pushClearCurStack(ViewName.SeasonelvenhallView, true)
		self._onClickClose()
	end
end

function SeasonbattlesettlementfailView:onTrainingCourseClick()
	local buildId = 1
	local unlockLv, jumpTo = SeasonMainCampController.instance:getEntranceLockConfig(buildId)
	local curLv = checknumber(SeasonMainCampModel.instance:getCampLv())

	if curLv < checknumber(unlockLv) then
		TipsFacade.instance:openCommonTips(langPara("主营地%d级解锁", unlockLv))
	else
		UIJumper.instance:pushClearCurStack(ViewName.SeasontrainingcourseView, true)
		self._onClickClose()
	end
end

return SeasonbattlesettlementfailView
