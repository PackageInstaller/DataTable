-- chunkname: @modules/logic/tower/view/assistboss/TowerAssistBossView.lua

module("modules.logic.tower.view.assistboss.TowerAssistBossView", package.seeall)

local TowerAssistBossView = class("TowerAssistBossView", BaseView)

function TowerAssistBossView:onInitView()
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "bg/txtTitle")
	self.content = gohelper.findChild(self.viewGO, "root/bosscontainer/Scroll/Viewport/Content")
	self.gotips = gohelper.findChild(self.viewGO, "title/tips")
	self.txttips = gohelper.findChildTextMesh(self.viewGO, "title/tips/txt_tips")
	self.items = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerAssistBossView:addEvents()
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerUpdate, self.onTowerUpdate, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.RefreshTalent, self.refreshView, self)
end

function TowerAssistBossView:removeEvents()
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerUpdate, self.onTowerUpdate, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.RefreshTalent, self.refreshView, self)
end

function TowerAssistBossView:_editableInitView()
	return
end

function TowerAssistBossView:_onBtnStartClick()
	return
end

function TowerAssistBossView:onTowerUpdate()
	TowerAssistBossListModel.instance:initList()
	self:refreshView()
end

function TowerAssistBossView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function TowerAssistBossView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mln_day_night)
	self:refreshParam()
	self:refreshView()
end

function TowerAssistBossView:refreshParam()
	if self.viewParam then
		self.isFromHeroGroup = self.viewParam.isFromHeroGroup
		self.bossId = self.viewParam.bossId
	end

	TowerAssistBossListModel.instance:initList()

	if self.isFromHeroGroup then
		self:addHeroGroupEvent()
	else
		self:removeHeroGroupEvent()
	end
end

function TowerAssistBossView:refreshView()
	TowerAssistBossListModel.instance:refreshList(self.viewParam)

	local list = TowerAssistBossListModel.instance:getList()
	local dataCount = #list
	local itemCount = #self.items
	local count = math.max(dataCount, itemCount)

	self.content.transform.pivot = dataCount <= 3 and Vector2(0.5, 1) or Vector2(0, 1)

	for i = 1, count do
		local item = self.items[i]

		if not item then
			local itemRes = self.viewContainer:getSetting().otherRes.itemRes
			local go = self.viewContainer:getResInst(itemRes, self.content, tostring(i))

			if self.viewParam.otherParam then
				if not self.viewParam.otherParam.towerAssistBossItemCls then
					local itemCls = TowerAssistBossItem

					item = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemCls)
					self.items[i] = item
				end
			end
		end

		local data = list[i]

		gohelper.setActive(item.viewGO, data ~= nil)

		if data then
			item:onUpdateMO(data, self.viewParam)
		end
	end

	local limitedTrialLevel = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))
	local curTowerType = TowerModel.instance:getCurTowerType()

	gohelper.setActive(self.gotips, curTowerType == TowerEnum.TowerType.Limited)

	self.txttips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("towerassistbossviewtips"), limitedTrialLevel)
end

function TowerAssistBossView:addHeroGroupEvent()
	if self.hasAdd then
		return
	end

	self.hasAdd = true

	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, self.refreshView, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self.refreshView, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self.refreshView, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, self.refreshView, self)
end

function TowerAssistBossView:removeHeroGroupEvent()
	if not self.hasAdd then
		return
	end

	self.hasAdd = false

	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, self.refreshView, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self.refreshView, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self.refreshView, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, self.refreshView, self)
end

function TowerAssistBossView:onClose()
	return
end

function TowerAssistBossView:onDestroyView()
	return
end

return TowerAssistBossView
