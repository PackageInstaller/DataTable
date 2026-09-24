-- chunkname: @modules/logic/autochess/main/view/v4a0/AutoChessLeaderSelectView.lua

module("modules.logic.autochess.main.view.v4a0.AutoChessLeaderSelectView", package.seeall)

local AutoChessLeaderSelectView = class("AutoChessLeaderSelectView", BaseView)

function AutoChessLeaderSelectView:onInitView()
	self._goAdventure = gohelper.findChild(self.viewGO, "#go_Adventure")
	self._simageAdventure = gohelper.findChildSingleImage(self.viewGO, "#go_Adventure/#simage_Adventure")
	self._txtName = gohelper.findChildText(self.viewGO, "#go_Adventure/name/#txt_Name")
	self._scrollDesc = gohelper.findChildScrollRect(self.viewGO, "#go_Adventure/#scroll_Desc")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#go_Adventure/#scroll_Desc/viewport/content/#txt_Desc")
	self._btnContinue = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Adventure/#btn_Continue")
	self._goLeaderSelect = gohelper.findChild(self.viewGO, "#go_LeaderSelect")
	self._goContent = gohelper.findChild(self.viewGO, "#go_LeaderSelect/scroll_teamleaderlist/viewport/#go_Content")
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_LeaderSelect/#btn_Start")
	self._goGrey = gohelper.findChild(self.viewGO, "#go_LeaderSelect/#btn_Start/#go_Grey")
	self._goAdventureTip = gohelper.findChild(self.viewGO, "#go_LeaderSelect/#go_AdventureTip")
	self._btnMain = gohelper.findChildButtonWithAudio(self.viewGO, "#go_LeaderSelect/Adventure/#btn_Main")
	self._simageAdventureM = gohelper.findChildSingleImage(self.viewGO, "#go_LeaderSelect/Adventure/#btn_Main/#simage_AdventureM")
	self._btnSub = gohelper.findChildButtonWithAudio(self.viewGO, "#go_LeaderSelect/Adventure/#btn_Sub")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessLeaderSelectView:addEvents()
	self._btnContinue:AddClickListener(self._btnContinueOnClick, self)
	self._btnStart:AddClickListener(self._btnStartOnClick, self)
	self._btnMain:AddClickListener(self._btnMainOnClick, self)
	self._btnSub:AddClickListener(self._btnSubOnClick, self)
end

function AutoChessLeaderSelectView:removeEvents()
	self._btnContinue:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnMain:RemoveClickListener()
	self._btnSub:RemoveClickListener()
end

function AutoChessLeaderSelectView:_btnContinueOnClick()
	self.anim.enabled = true

	self.anim:Play("next", 0, 0)
	TaskDispatcher.runDelay(self.delaySwitch, self, 0.16)
end

function AutoChessLeaderSelectView:delaySwitch()
	gohelper.setActive(self._goAdventure, false)
	gohelper.setActive(self._goLeaderSelect, true)

	if self.actMo.rank < self.invalidLvl then
		gohelper.setActive(self._goAdventureTip, true)
		TaskDispatcher.runDelay(self.delayCloseTip, self, 2)
	end

	local isFinish = GuideModel.instance:isGuideFinish(40016)

	if not isFinish then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.ZTrigger40016)
	end
end

function AutoChessLeaderSelectView:delayCloseTip()
	gohelper.setActive(self._goAdventureTip, false)
end

function AutoChessLeaderSelectView:_btnStartOnClick()
	if not self.selectLeaderId then
		GameFacade.showToast(ToastEnum.AutoChessSelectLeader)

		return
	end

	local param = {
		actId = self.actId,
		moduleId = self.moduleId,
		episodeId = AutoChessConfig.instance:getPvpEpisodeCo(self.actId).id,
		leaderId = self.selectLeaderId
	}

	AutoChessController.instance:openLeaderNextView(param)
	self:closeThis()
end

function AutoChessLeaderSelectView:_btnMainOnClick()
	AutoChessController.instance:openAdventureView()
end

function AutoChessLeaderSelectView:_btnSubOnClick()
	AutoChessController.instance:openAdventureView(false, true)
end

function AutoChessLeaderSelectView:_editableInitView()
	self.anim = gohelper.findComponentAnim(self.viewGO)
	self.leaderItemList = {}
	self.actMo = Activity182Model.instance:getActMo()
	self.actId = self.actMo.activityId
	self.moduleId = AutoChessEnum.EpisodeType.PVP
	self.gameMo = self.actMo:getGameMo(self.actId, self.moduleId)
	self.invalidLvl = AutoChessConfig.instance:getLoseStreakInvalidLvl()

	gohelper.setActive(self._goAdventure, true)
	gohelper.setActive(self._goLeaderSelect, false)
	gohelper.setActive(self._goGrey, true)
end

function AutoChessLeaderSelectView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_yingmen_adventure_get)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.ClickLeaderSelectItem, self.onClickLeader, self)
	self:refreshAdventure()
	self:refreshLeaderSelect()
end

function AutoChessLeaderSelectView:onDestroyView()
	TaskDispatcher.cancelTask(self.delaySwitch, self)
	TaskDispatcher.cancelTask(self.delayCloseTip, self)
end

function AutoChessLeaderSelectView:refreshAdventure()
	if self.gameMo then
		local mutationId = self.gameMo.mutationId

		if mutationId then
			local config = AutoChessConfig.instance:getMutationCfg(mutationId)

			if config then
				local iconPath = ResUrl.getAutoChessIcon(config.icon, "adventure")

				self._simageAdventure:LoadImage(iconPath)

				self._txtName.text = config.name
				self._txtDesc.text = config.desc

				self._simageAdventureM:LoadImage(iconPath)
			end
		end
	end
end

function AutoChessLeaderSelectView:refreshLeaderSelect()
	local masterIds = self.gameMo.masterIdBox
	local cardpackIds = self.gameMo.cardpackIds

	for k, masterId in ipairs(masterIds) do
		local leaderItem = self.leaderItemList[k]

		if not leaderItem then
			local go = self:getResInst(AutoChessStrEnum.ResPath.LeaderSelectItem, self._goContent)

			leaderItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessLeaderSelectItem)
			self.leaderItemList[k] = leaderItem
		end

		leaderItem:setData(masterId, cardpackIds[k])
	end

	gohelper.setActive(self._btnSub, self.actMo.rank < self.invalidLvl)
end

function AutoChessLeaderSelectView:onClickLeader(id)
	self.selectLeaderId = id

	gohelper.setActive(self._goGrey, false)
end

return AutoChessLeaderSelectView
