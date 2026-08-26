-- chunkname: @modules/logic/tower/view/TowerHeroTrialItem.lua

module("modules.logic.tower.view.TowerHeroTrialItem", package.seeall)

local TowerHeroTrialItem = class("TowerHeroTrialItem", ListScrollCellExtend)

function TowerHeroTrialItem:onInitView()
	self.rare = gohelper.findChildImage(self.viewGO, "role/rare")
	self.heroIcon = gohelper.findChildSingleImage(self.viewGO, "role/heroicon")
	self.career = gohelper.findChildImage(self.viewGO, "role/career")
	self.name = gohelper.findChildText(self.viewGO, "role/name")
	self.nameEn = gohelper.findChildText(self.viewGO, "role/name/nameEn")
	self.goSelect = gohelper.findChild(self.viewGO, "go_select")
	self.btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "btn_click")

	gohelper.setActive(self.viewGO, true)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerHeroTrialItem:addEvents()
	self.btnClick:AddClickListener(self.onHeroTrialItemClick, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnSelectHeroTrialItem, self.refreshSelectState, self)
end

function TowerHeroTrialItem:removeEvents()
	self.btnClick:RemoveClickListener()
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnSelectHeroTrialItem, self.refreshSelectState, self)
end

function TowerHeroTrialItem:onHeroTrialItemClick()
	TowerHeroTrialListModel.instance:setCurSelectHeroId(self.mo.trialHeroId)
	TowerController.instance:dispatchEvent(TowerEvent.OnSelectHeroTrialItem)
end

function TowerHeroTrialItem:_editableInitView()
	return
end

function TowerHeroTrialItem:onUpdateMO(mo)
	if mo == nil then
		return
	end

	self.mo = mo

	local heroConfig = self.mo.heroConfig
	local skinConfig = self.mo.skinConfig

	self.heroIcon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))

	self.name.text = heroConfig.name
	self.nameEn.text = heroConfig.nameEng

	UISpriteSetMgr.instance:setCommonSprite(self.career, "lssx_" .. heroConfig.career)
	UISpriteSetMgr.instance:setCommonSprite(self.rare, "bgequip" .. CharacterEnum.Color[heroConfig.rare])
	self:refreshSelectState()
end

function TowerHeroTrialItem:refreshSelectState()
	local curSelectHeroId = TowerHeroTrialListModel.instance:getCurSelectHeroId()

	gohelper.setActive(self.goSelect, self.mo.trialHeroId == curSelectHeroId)
end

function TowerHeroTrialItem:onDestroyView()
	self.heroIcon:UnLoadImage()
end

return TowerHeroTrialItem
