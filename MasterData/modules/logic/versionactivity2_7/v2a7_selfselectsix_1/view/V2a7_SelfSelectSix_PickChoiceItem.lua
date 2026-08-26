-- chunkname: @modules/logic/versionactivity2_7/v2a7_selfselectsix_1/view/V2a7_SelfSelectSix_PickChoiceItem.lua

module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.view.V2a7_SelfSelectSix_PickChoiceItem", package.seeall)

local V2a7_SelfSelectSix_PickChoiceItem = class("V2a7_SelfSelectSix_PickChoiceItem", ListScrollCellExtend)

V2a7_SelfSelectSix_PickChoiceItem.FirstDungeonId = 10101

function V2a7_SelfSelectSix_PickChoiceItem:onInitView()
	self._gotitle = gohelper.findChild(self.viewGO, "#go_title")
	self._gooriginal = gohelper.findChild(self.viewGO, "#go_title/#go_original")
	self._golocked = gohelper.findChild(self.viewGO, "#go_title/#go_locked")
	self._txtlocked = gohelper.findChildText(self.viewGO, "#go_title/#go_locked/#txt_locked")
	self._gounlock = gohelper.findChild(self.viewGO, "#go_title/#go_unlock")
	self._txtunlock = gohelper.findChildText(self.viewGO, "#go_title/#go_unlock/#txt_unlock")
	self._gohero = gohelper.findChild(self.viewGO, "#go_hero")
	self._herocanvas = gohelper.onceAddComponent(self._gohero, typeof(UnityEngine.CanvasGroup))
	self._goheroitem = gohelper.findChild(self.viewGO, "#go_hero/heroitem")
	self._goexskill = gohelper.findChild(self.viewGO, "#go_hero/heroitem/role/#go_exskill")
	self._imageexskill = gohelper.findChildImage(self.viewGO, "#go_hero/heroitem/role/#go_exskill/#image_exskill")
	self._goclick = gohelper.findChild(self.viewGO, "#go_hero/heroitem/select/#go_click")
	self._itemList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a7_SelfSelectSix_PickChoiceItem:addEvents()
	self.addEventCb(self, V2a7_SelfSelectSix_PickChoiceController.instance, V2a7_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged, self.refreshUI, self)
end

function V2a7_SelfSelectSix_PickChoiceItem:removeEvents()
	self.removeEventCb(self, V2a7_SelfSelectSix_PickChoiceController.instance, V2a7_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged, self.refreshUI, self)
end

function V2a7_SelfSelectSix_PickChoiceItem:_editableInitView()
	self._transcontent = self._gohero.transform

	gohelper.setActive(self._goheroitem, false)
end

function V2a7_SelfSelectSix_PickChoiceItem:_editableAddEvents()
	return
end

function V2a7_SelfSelectSix_PickChoiceItem:_editableRemoveEvents()
	return
end

function V2a7_SelfSelectSix_PickChoiceItem:refreshUI()
	if self._isTitle then
		self:_refreshTitle()
	else
		self:_refreshHeroList()
	end

	self._herocanvas.alpha = self._mo.isUnlock and 1 or 0.5
end

function V2a7_SelfSelectSix_PickChoiceItem:onUpdateMO(mo)
	self._mo = mo
	self._isTitle = mo.isTitle

	gohelper.setActive(self._gotitle, self._isTitle)
	gohelper.setActive(self._gohero, not self._isTitle)
	self:refreshUI()
end

function V2a7_SelfSelectSix_PickChoiceItem:_refreshTitle()
	if self._mo.episodeId == V2a7_SelfSelectSix_PickChoiceItem.FirstDungeonId then
		gohelper.setActive(self._gooriginal, true)
		gohelper.setActive(self._golocked, false)
		gohelper.setActive(self._gounlock, false)
	else
		gohelper.setActive(self._gooriginal, false)
		gohelper.setActive(self._golocked, not self._mo.isUnlock)
		gohelper.setActive(self._gounlock, self._mo.isUnlock)

		local episodeName = DungeonHelper.getEpisodeName(self._mo.episodeId)

		self._txtlocked.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v2a7_newbie_storyprocess_locate_item"), episodeName)
		self._txtunlock.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v2a7_newbie_storyprocess_locate_item_finish"), episodeName)
	end
end

function V2a7_SelfSelectSix_PickChoiceItem:_refreshHeroList()
	for index, heroId in ipairs(self._mo.heroIdList) do
		local item = self:getOrCreateItem(index)
		local mo = SummonCustomPickChoiceMO.New()

		mo:init(tonumber(heroId))
		item.component:onUpdateMO(mo)

		if not self._mo.isUnlock then
			item.component:setLock()
		end
	end

	ZProj.UGUIHelper.RebuildLayout(self._transcontent)
end

function V2a7_SelfSelectSix_PickChoiceItem:getOrCreateItem(index)
	local item = self._itemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.clone(self._goheroitem, self._gohero, "item" .. tostring(index))

		gohelper.setActive(item.go, true)

		item.component = MonoHelper.addNoUpdateLuaComOnceToGo(item.go, V2a7_SelfSelectSix_PickChoiceHeroItem)

		item.component:init(item.go)
		item.component:addEvents()

		self._itemList[index] = item
	end

	return item
end

function V2a7_SelfSelectSix_PickChoiceItem:onDestroyView()
	return
end

return V2a7_SelfSelectSix_PickChoiceItem
