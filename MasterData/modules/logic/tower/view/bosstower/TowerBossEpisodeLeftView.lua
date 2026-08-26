-- chunkname: @modules/logic/tower/view/bosstower/TowerBossEpisodeLeftView.lua

module("modules.logic.tower.view.bosstower.TowerBossEpisodeLeftView", package.seeall)

local TowerBossEpisodeLeftView = class("TowerBossEpisodeLeftView", BaseView)

function TowerBossEpisodeLeftView:onInitView()
	self.btnHandBook = gohelper.findChildButtonWithAudio(self.viewGO, "root/Left/#btn_HandBook")
	self.goUp = gohelper.findChild(self.viewGO, "root/Left/#btn_HandBook/#go_up")
	self.bossIcon = gohelper.findChildSingleImage(self.viewGO, "root/Left/Pass/Head/Mask/image_bossIcon")
	self.btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "root/Left/Pass")
	self.txtPassLev = gohelper.findChildTextMesh(self.viewGO, "root/Left/Pass/#txt_PassLevel")
	self.txtTaskNum = gohelper.findChildTextMesh(self.viewGO, "root/Left/Pass/#txt_taskNum")
	self.taskList = {}

	for i = 1, 4 do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self.viewGO, string.format("root/Left/Pass/Point/%s", i))
		item.goLight = gohelper.findChild(item.go, "#go_PointFG")
		self.taskList[i] = item
	end

	self._goTaskReddot = gohelper.findChild(self.viewGO, "root/Left/Pass/#go_RedPoint")
	self._goTaskTime = gohelper.findChild(self.viewGO, "root/Left/Pass/time")
	self._txtTaskTime = gohelper.findChildTextMesh(self.viewGO, "root/Left/Pass/time/#txt_taskTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerBossEpisodeLeftView:addEvents()
	self.addClickCb(self, self.btnHandBook, self._onBtnHandBookClick, self)
	self.addClickCb(self, self.btnTask, self._onBtnTaskClick, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.ResetTalent, self._onResetTalent, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.ActiveTalent, self._onActiveTalent, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerTaskUpdated, self.onTowerTaskUpdated, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerUpdate, self._onTowerUpdate, self)
end

function TowerBossEpisodeLeftView:removeEvents()
	self:removeClickCb(self.btnHandBook)
	self:removeClickCb(self.btnTask)
	self.removeEventCb(self, TowerController.instance, TowerEvent.ResetTalent, self._onResetTalent, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.ActiveTalent, self._onActiveTalent, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerTaskUpdated, self.onTowerTaskUpdated, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerUpdate, self._onTowerUpdate, self)
end

function TowerBossEpisodeLeftView:_editableInitView()
	return
end

function TowerBossEpisodeLeftView:_onTowerUpdate()
	TowerController.instance:checkTowerIsEnd(self.towerType, self.towerId)
end

function TowerBossEpisodeLeftView:_onBtnTaskClick()
	TowerController.instance:openTowerTaskView({
		towerType = self.towerType,
		towerId = self.towerId
	})
end

function TowerBossEpisodeLeftView:_onBtnHandBookClick()
	local bossId = self.towerConfig.bossId
	local mo = TowerAssistBossModel.instance:getById(bossId)
	local isLock = mo == nil

	if isLock then
		local bossMo = TowerAssistBossModel.instance:getTempUnlockTrialBossMO(bossId)

		bossMo:setTrialInfo(0, 0)
		bossMo:refreshTalent()
	end

	ViewMgr.instance:openView(ViewName.TowerAssistBossDetailView, {
		bossId = bossId
	})
end

function TowerBossEpisodeLeftView:_onResetTalent()
	self:refreshTalent()
end

function TowerBossEpisodeLeftView:_onActiveTalent()
	self:refreshTalent()
end

function TowerBossEpisodeLeftView:onTowerTaskUpdated()
	self:refreshTask()
end

function TowerBossEpisodeLeftView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function TowerBossEpisodeLeftView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_leimi_theft_open)
	RedDotController.instance:addRedDot(self._goTaskReddot, RedDotEnum.DotNode.TowerTask)
	self:refreshParam()
	self:refreshView()
end

function TowerBossEpisodeLeftView:refreshParam()
	self.episodeConfig = self.viewParam.episodeConfig
	self.towerId = self.episodeConfig.towerId
	self.towerType = TowerEnum.TowerType.Boss
	self.towerConfig = TowerConfig.instance:getBossTowerConfig(self.towerId)
	self.towerInfo = TowerModel.instance:getTowerInfoById(self.towerType, self.towerId)
	self.episodeMo = TowerModel.instance:getEpisodeMoByTowerType(self.towerType)
end

function TowerBossEpisodeLeftView:refreshView()
	local assistBossConfig = TowerConfig.instance:getAssistBossConfig(self.towerConfig.bossId)
	local skinConfig = FightConfig.instance:getSkinCO(assistBossConfig.skinId)

	self.bossIcon:LoadImage(ResUrl.monsterHeadIcon(skinConfig and skinConfig.headIcon))
	self:refreshPassLayer()
	self:refreshTask()
	self:refreshTalent()
	self:refreshTaskTime()
end

function TowerBossEpisodeLeftView:refreshPassLayer()
	local bossMo = TowerAssistBossModel.instance:getById(self.towerConfig.bossId)

	if bossMo then
		if not bossMo.level then
			local bossLev = 0
			local maxLev = TowerConfig.instance:getAssistBossMaxLev(self.towerConfig.bossId)
			local bossLevStr = string.format("<color=#dcae70>%s</color>", bossLev)

			self.txtPassLev.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towerbossepisodepasscount"), bossLevStr, maxLev)
		end
	end
end

function TowerBossEpisodeLeftView:refreshTask()
	local groupId = self.towerInfo:getTaskGroupId()
	local bossTaskList = TowerTaskModel.instance:getBossTaskList(self.towerId)
	local canShowTask = bossTaskList and #bossTaskList > 0 and groupId ~= 0

	gohelper.setActive(self.btnTask, canShowTask)

	if not canShowTask then
		return
	end

	local list = TowerConfig.instance:getTaskListByGroupId(groupId)
	local finishCount = 0

	if list then
		for _, taskId in pairs(list) do
			if TowerTaskModel.instance:isTaskFinishedById(taskId) then
				finishCount = finishCount + 1
			end
		end
	end

	if list then
		if not #list then
			local taskCount = 0

			for i = 1, #self.taskList do
				local item = self.taskList[i]

				if i <= taskCount then
					gohelper.setActive(item.go, true)
					gohelper.setActive(item.goLight, i <= finishCount)
				else
					gohelper.setActive(item.go, false)
				end
			end

			self.txtTaskNum.text = string.format("%s/%s", finishCount, taskCount)
		end
	end
end

function TowerBossEpisodeLeftView:refreshTaskTime()
	self.towerOpenMo = TowerModel.instance:getTowerOpenInfo(self.towerType, self.towerId)

	local timeConfig = TowerConfig.instance:getBossTimeTowerConfig(self.towerId, self.towerOpenMo.round)

	if timeConfig and timeConfig.taskGroupId > 0 and self.towerOpenMo.taskEndTime > 0 then
		self:_refreshTaskTime()
		TaskDispatcher.cancelTask(self._refreshTaskTime, self)
		TaskDispatcher.runRepeat(self._refreshTaskTime, self, 1)
	else
		self:clearTime()
	end
end

function TowerBossEpisodeLeftView:_refreshTaskTime()
	gohelper.setActive(self._goTaskTime, true)

	local date, dateFormat = self.towerOpenMo:getTaskRemainTime(true)

	if date then
		self._txtTaskTime.text = date .. dateFormat
	else
		self:clearTime()
	end
end

function TowerBossEpisodeLeftView:clearTime()
	gohelper.setActive(self._goTaskTime, false)
	TaskDispatcher.cancelTask(self._refreshTaskTime, self)
end

function TowerBossEpisodeLeftView:refreshTalent()
	if not self.towerConfig then
		return
	end

	local bossMo = TowerAssistBossModel.instance:getById(self.towerConfig.bossId)
	local canActiveTalent = bossMo and bossMo:hasTalentCanActive() or false

	gohelper.setActive(self.goUp, canActiveTalent)
end

function TowerBossEpisodeLeftView:onClose()
	return
end

function TowerBossEpisodeLeftView:onDestroyView()
	self.bossIcon:UnLoadImage()
	TaskDispatcher.cancelTask(self._refreshTaskTime, self)
end

return TowerBossEpisodeLeftView
