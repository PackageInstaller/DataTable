-- chunkname: @modules/logic/tower/view/bosstower/TowerBossSelectView.lua

module("modules.logic.tower.view.bosstower.TowerBossSelectView", package.seeall)

local TowerBossSelectView = class("TowerBossSelectView", BaseView)

function TowerBossSelectView:onInitView()
	self._btnbossHandbook = gohelper.findChildButtonWithAudio(self.viewGO, "bossHandbook/#btn_bossHandbook")
	self.bossContainer = gohelper.findChild(self.viewGO, "root/bosscontainer")
	self._gohandBookNewEffect = gohelper.findChild(self.viewGO, "bossHandbook/#saoguang")
	self._scrollBoss = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_boss")
	self._gobossContent = gohelper.findChild(self.viewGO, "root/#scroll_boss/Viewport/#go_bossContent")
	self._gobossItem = gohelper.findChild(self.viewGO, "root/#scroll_boss/Viewport/#go_bossContent/#go_bossItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerBossSelectView:addEvents()
	self._btnbossHandbook:AddClickListener(self._btnbossHandbookOnClick, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.LocalKeyChange, self.onLocalKeyChange, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerTaskUpdated, self.onTowerTaskUpdated, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerUpdate, self.onTowerUpdate, self)
end

function TowerBossSelectView:removeEvents()
	self._btnbossHandbook:RemoveClickListener()
	self.removeEventCb(self, TowerController.instance, TowerEvent.LocalKeyChange, self.onLocalKeyChange, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerTaskUpdated, self.onTowerTaskUpdated, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerUpdate, self.onTowerUpdate, self)
end

function TowerBossSelectView:_btnbossHandbookOnClick()
	TowerController.instance:openAssistBossView()
end

function TowerBossSelectView:_editableInitView()
	gohelper.setActive(self._gohandBookNewEffect, false)
	gohelper.setActive(self._gobossItem, false)

	self.itemList = self:getUserDataTb_()
end

function TowerBossSelectView:onUpdateParam()
	self:refreshView()
end

function TowerBossSelectView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mln_day_night)
	TowerModel.instance:setCurTowerType(TowerEnum.TowerType.Boss)
	self:refreshView()
	TaskDispatcher.runDelay(self.checkShowEffect, self, 0.6)
end

function TowerBossSelectView:onTowerTaskUpdated()
	self:refreshTask()
end

function TowerBossSelectView:onTowerUpdate()
	self:refreshView()
end

function TowerBossSelectView:onLocalKeyChange()
	if self.itemList then
		for i, v in ipairs(self.itemList) do
			v.item:refreshTag()
		end
	end
end

function TowerBossSelectView:refreshView()
	self:refreshBossList()
	self:refreshTime()
	self:refreshUI()
end

function TowerBossSelectView:refreshUI()
	local bossHandBookOpenLayerNum = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossHandbookOpen)
	local permanentPassLayerNum = TowerPermanentModel.instance:getCurPermanentPassLayer()

	gohelper.setActive(self._gobossHandbook, permanentPassLayerNum >= tonumber(bossHandBookOpenLayerNum))
end

function TowerBossSelectView:refreshBossList()
	self.bossOpenMOList = TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)

	if #self.bossOpenMOList > 1 then
		table.sort(self.bossOpenMOList, TowerAssistBossModel.sortBossList)
	end

	self:initBossList()

	for i, v in ipairs(self.itemList) do
		v.item:updateItem(self.bossOpenMOList and self.bossOpenMOList[i])
	end
end

function TowerBossSelectView:initBossList()
	for i = 1, #self.bossOpenMOList do
		local bossItem = self.itemList[i]

		if not bossItem then
			bossItem = {
				go = gohelper.clone(self._gobossItem, self._gobossContent)
			}
			bossItem.item = self:createItem(i, bossItem.go)
			self.itemList[i] = bossItem
		end

		gohelper.setActive(bossItem.go, true)

		bossItem.go.name = "boss" .. self.bossOpenMOList[i].id
	end

	for i = #self.bossOpenMOList + 1, #self.itemList do
		gohelper.setActive(self.itemList[i].go, false)
	end

	self._scrollBoss.horizontalNormalizedPosition = 0
end

function TowerBossSelectView:createItem(index, parentGO)
	local resPath = self.viewContainer:getSetting().otherRes.itemRes
	local instGO = self.viewContainer:getResInst(resPath, parentGO)

	recthelper.setAnchorY(instGO.transform, index % 2 == 0 and -70 or 0)

	return MonoHelper.addNoUpdateLuaComOnceToGo(instGO, TowerBossSelectItem)
end

function TowerBossSelectView:refreshTime()
	local list = TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Boss)
	local minTime, towerId

	for _, mo in pairs(list) do
		if mo.status == TowerEnum.TowerStatus.Open and (minTime == nil or minTime > mo.nextTime) then
			towerId = mo.towerId
			minTime = mo.nextTime
		end
	end

	for i, v in ipairs(self.itemList) do
		v.item:refreshTime(towerId)
	end
end

function TowerBossSelectView:refreshTask()
	for i, v in ipairs(self.itemList) do
		v.item:refreshTask()
	end
end

function TowerBossSelectView:checkShowEffect()
	local saveHandBookEffect = TowerController.instance:getPlayerPrefs(TowerEnum.LocalPrefsKey.TowerBossSelectHandBookEffect, 0)
	local canShowHandBookEffect = saveHandBookEffect == 0

	gohelper.setActive(self._gohandBookNewEffect, canShowHandBookEffect)
end

function TowerBossSelectView:onClose()
	TowerController.instance:setPlayerPrefs(TowerEnum.LocalPrefsKey.TowerBossSelectHandBookEffect, 1)
	TaskDispatcher.cancelTask(self.checkShowEffect, self)
end

function TowerBossSelectView:onDestroyView()
	TowerModel.instance:cleanTrialData()
end

return TowerBossSelectView
