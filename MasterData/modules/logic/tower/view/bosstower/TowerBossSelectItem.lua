-- chunkname: @modules/logic/tower/view/bosstower/TowerBossSelectItem.lua

module("modules.logic.tower.view.bosstower.TowerBossSelectItem", package.seeall)

local TowerBossSelectItem = class("TowerBossSelectItem", LuaCompBase)

function TowerBossSelectItem:init(go)
	self.viewGO = go
	self.txtName = gohelper.findChildTextMesh(self.viewGO, "root/namebg/#txt_name")
	self.simageBoss = gohelper.findChildSingleImage(self.viewGO, "root/#simage_boss")
	self.simageShadow = gohelper.findChildSingleImage(self.viewGO, "root/#simage_shadow")
	self.goNew = gohelper.findChild(self.viewGO, "root/tips/new")
	self.goSp = gohelper.findChild(self.viewGO, "root/tips/sp")
	self.btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "click")
	self.btnDetail = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_detail")
	self.goTime = gohelper.findChild(self.viewGO, "root/timebg")
	self.txtTime = gohelper.findChildTextMesh(self.viewGO, "root/timebg/#txt_time")
	self.goLev = gohelper.findChild(self.viewGO, "root/level")
	self.txtLev = gohelper.findChildTextMesh(self.viewGO, "root/level/levelbg/#txt_level")
	self.spNodeList = self:getUserDataTb_()

	for i = 1, 3 do
		self.spNodeList[i] = gohelper.findChild(self.viewGO, string.format("root/level/%s", i))
	end

	self.goProgress = gohelper.findChild(self.viewGO, "root/progress")
	self.taskList = {}

	for i = 1, 4 do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self.viewGO, string.format("root/progress/%s", i))
		item.goLight = gohelper.findChild(item.go, "light")
		self.taskList[i] = item
	end

	self.towerType = TowerEnum.TowerType.Boss
end

function TowerBossSelectItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self._onBtnClick, self)
	self.addClickCb(self, self.btnDetail, self._onBtnDetail, self)
end

function TowerBossSelectItem:removeEventListeners()
	self:removeClickCb(self.btnClick)
	self:removeClickCb(self.btnDetail)
end

function TowerBossSelectItem:_onBtnDetail()
	if self.towerConfig then
		TowerController.instance:openAssistBossView(self.towerConfig.bossId)
	end
end

function TowerBossSelectItem:_onBtnClick()
	TowerController.instance:openBossTowerEpisodeView(self.towerType, self.towerId)
	self:checkClearTag()
end

function TowerBossSelectItem:updateItem(towerOpenMo)
	self.towerOpenMo = towerOpenMo
	self.towerId = towerOpenMo and towerOpenMo.towerId

	if not self.towerId then
		gohelper.setActive(self.viewGO, false)
		self:clearTime()

		return
	end

	gohelper.setActive(self.viewGO, true)

	self.towerInfo = TowerModel.instance:getTowerInfoById(self.towerType, self.towerId)
	self.towerConfig = TowerConfig.instance:getBossTowerConfig(self.towerId)
	self.bossInfo = TowerAssistBossModel.instance:getById(self.towerConfig.bossId)
	self.episodeMo = TowerModel.instance:getEpisodeMoByTowerType(self.towerType)
	self.bossConfig = TowerConfig.instance:getAssistBossConfig(self.towerConfig.bossId)
	self.txtName.text = self.towerConfig.name

	self.simageBoss:LoadImage(self.bossConfig.bossPic)
	self.simageShadow:LoadImage(self.bossConfig.bossShadowPic)
	self:refreshLev()
	self:refreshTask()
	self:refreshTag()
end

function TowerBossSelectItem:refreshLev()
	if self.bossInfo and not self.bossInfo:getTempState() then
		gohelper.setActive(self.goLev, true)

		self.txtLev.text = self.bossInfo.level

		local spEpisodes = self.episodeMo:getSpEpisodes(self.towerId)
		local passCount = 0

		for k, v in pairs(spEpisodes) do
			if self.towerInfo:isLayerPass(v, self.episodeMo) then
				passCount = passCount + 1
			end
		end

		for i = 1, #self.spNodeList do
			gohelper.setActive(self.spNodeList[i], i <= passCount)
		end
	else
		gohelper.setActive(self.goLev, false)
	end
end

function TowerBossSelectItem:refreshTask()
	local bossTaskList = TowerTaskModel.instance:getBossTaskList(self.towerId)

	if bossTaskList and #bossTaskList > 0 then
		gohelper.setActive(self.goProgress, true)

		local finishCount = 0

		for _, taskMo in pairs(bossTaskList) do
			if TowerTaskModel.instance:isTaskFinishedById(taskMo.id) then
				finishCount = finishCount + 1
			end
		end

		if bossTaskList then
			if not #bossTaskList then
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
			end
		end
	else
		gohelper.setActive(self.goProgress, false)
	end
end

function TowerBossSelectItem:refreshTime()
	local timeConfig = TowerConfig.instance:getBossTimeTowerConfig(self.towerId, self.towerOpenMo.round)

	if timeConfig and timeConfig.taskGroupId > 0 and self.towerOpenMo.taskEndTime > 0 then
		self:_refreshTime()
		TaskDispatcher.cancelTask(self._refreshTime, self)
		TaskDispatcher.runRepeat(self._refreshTime, self, 1)
	else
		self:clearTime()
	end
end

function TowerBossSelectItem:_refreshTime()
	gohelper.setActive(self.goTime, true)

	local date, dateFormat = self.towerOpenMo:getTaskRemainTime(true)

	if date then
		self.txtTime.text = date .. dateFormat
	else
		self:clearTime()
	end
end

function TowerBossSelectItem:clearTime()
	gohelper.setActive(self.goTime, false)
	TaskDispatcher.cancelTask(self._refreshTime, self)
end

function TowerBossSelectItem:refreshTag()
	local newState = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossOpen, self.towerId, self.towerOpenMo, TowerEnum.LockKey)
	local canShowNew = newState == TowerEnum.LockKey

	gohelper.setActive(self.goNew, canShowNew)

	if canShowNew then
		gohelper.setActive(self.goSp, false)

		return
	end

	local canShowNewSp = self.towerInfo:hasNewSpLayer(self.towerOpenMo)

	gohelper.setActive(self.goSp, canShowNewSp)
end

function TowerBossSelectItem:checkClearTag()
	local newState = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossOpen, self.towerId, self.towerOpenMo, TowerEnum.LockKey)
	local canShowNew = newState == TowerEnum.LockKey

	if canShowNew then
		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.NewBossOpen, self.towerId, self.towerOpenMo, TowerEnum.UnlockKey)

		return
	end

	local canShowNewSp = self.towerInfo:hasNewSpLayer(self.towerOpenMo)

	if canShowNewSp then
		self.towerInfo:clearSpLayerNewTag(self.towerOpenMo)
	end
end

function TowerBossSelectItem:onDestroy()
	TaskDispatcher.cancelTask(self._refreshTime, self)
	self.simageBoss:UnLoadImage()
	self.simageShadow:UnLoadImage()
end

return TowerBossSelectItem
