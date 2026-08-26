-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_HeroExpandBondsItem.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_HeroExpandBondsItem", package.seeall)

local V3a9_BossRush_HeroExpandBondsItem = class("V3a9_BossRush_HeroExpandBondsItem", ListScrollCellExtend)

function V3a9_BossRush_HeroExpandBondsItem:onInitView()
	self._go = gohelper.findChild(self.viewGO, "bondsitem")
	self._imageicon = gohelper.findChildImage(self.viewGO, "bondsitem/#image_icon")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_HeroExpandBondsItem:addEvents()
	self._btnClick:AddClickListener(self._btnclickOnClick, self)
end

function V3a9_BossRush_HeroExpandBondsItem:removeEvents()
	self._btnClick:RemoveClickListener()
end

function V3a9_BossRush_HeroExpandBondsItem:_editableInitView()
	self._items = self:getUserDataTb_()

	gohelper.setActive(self._go, false)
end

function V3a9_BossRush_HeroExpandBondsItem:_editableAddEvents()
	self.addEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.onSwitchHeroExpandBonds, self._onSwitchHeroExpandBonds, self)
end

function V3a9_BossRush_HeroExpandBondsItem:_editableRemoveEvents()
	self.removeEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.onSwitchHeroExpandBonds, self._onSwitchHeroExpandBonds, self)
end

function V3a9_BossRush_HeroExpandBondsItem:_onSwitchHeroExpandBonds(groupId, heroId)
	local isShowSwitch = groupId and heroId and self._items

	for i, item in pairs(self._items) do
		local _groupId = item.groupMo:getGroupId()

		gohelper.setActive(item.goselect, isShowSwitch and groupId == _groupId and self._heroId == heroId)
	end
end

function V3a9_BossRush_HeroExpandBondsItem:onUpdateMO(heroId)
	self._heroId = heroId
	self._groupMos = V3a9_BossRushExpandBondModel.instance:getHeroExpandBondGroupsList(heroId)

	local index = 0
	local groupDict = {}

	for i, mo in ipairs(self._groupMos) do
		if index < 5 then
			index = index + 1

			local groupId = mo:getGroupId()
			local item = self:_getItem(groupId)

			if item then
				local icon = mo:getIcon()

				if not string.nilorempty(icon) then
					UISpriteSetMgr.instance:setV1a4BossRushSprite(item.imageicon, icon)
				end

				item.groupMo = mo
			end

			groupDict[groupId] = index
		end
	end

	for i, item in pairs(self._items) do
		local groupId = item.groupMo:getGroupId()

		gohelper.setActive(item.go, groupDict[groupId] ~= nil)
	end
end

function V3a9_BossRush_HeroExpandBondsItem:_btnclickOnClick()
	local groupmo = self._groupMos[1]
	local param = {
		groupId = groupmo and groupmo:getGroupId(),
		heroId = self._heroId
	}

	ViewMgr.instance:openView(ViewName.V3a9_BossRush_ExpandBondsTipView, param)
end

function V3a9_BossRush_HeroExpandBondsItem:_getItem(groupId)
	local item = self._items[groupId]

	if not item and self._go then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._go)
		item.imageicon = gohelper.findChildImage(item.go, "#image_icon")
		item.goselect = gohelper.findChild(item.go, "#go_select")
		self._items[groupId] = item
	end

	return item
end

function V3a9_BossRush_HeroExpandBondsItem:onDestroyView()
	return
end

return V3a9_BossRush_HeroExpandBondsItem
