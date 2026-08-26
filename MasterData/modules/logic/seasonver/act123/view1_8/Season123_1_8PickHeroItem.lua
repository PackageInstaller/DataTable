-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8PickHeroItem.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8PickHeroItem", package.seeall)

local Season123_1_8PickHeroItem = class("Season123_1_8PickHeroItem", ListScrollCell)

function Season123_1_8PickHeroItem:init(go)
	self._heroGOParent = gohelper.findChild(go, "hero")
	self._goOrder = gohelper.findChild(go, "#go_orderbg")
	self._txtorder = gohelper.findChildText(go, "#go_orderbg/#txt_level")
	self._heroItem = IconMgr.instance:getCommonHeroItem(self._heroGOParent)

	self._heroItem:addClickListener(self.onItemClick, self)
	self:initHeroItem(go)
end

function Season123_1_8PickHeroItem:initHeroItem(go)
	self._animator = self._heroItem.go:GetComponent(typeof(UnityEngine.Animator))

	transformhelper.setLocalScale(go.transform, 0.8, 0.8, 1)
end

function Season123_1_8PickHeroItem:addEventListeners()
	return
end

function Season123_1_8PickHeroItem:removeEventListeners()
	return
end

function Season123_1_8PickHeroItem:onUpdateMO(mo)
	self._mo = mo

	local heroMO = HeroModel.instance:getById(self._mo.id)

	self._heroItem:onUpdateMO(heroMO)
	self._heroItem:setNewShow(false)

	local isSelect = Season123PickHeroModel.instance:isHeroSelected(self._mo.id)

	self._heroItem:setSelect(isSelect)
	gohelper.setActive(self._goOrder, isSelect)

	if isSelect then
		local order = Season123PickHeroModel.instance:getSelectedIndex(self._mo.id)

		self._txtorder.text = tostring(order)
	end
end

function Season123_1_8PickHeroItem:onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local isSelect = Season123PickHeroModel.instance:isHeroSelected(self._mo.id)

	Season123PickHeroController.instance:setHeroSelect(self._mo.id, not isSelect)
end

function Season123_1_8PickHeroItem:onDestroy()
	if self._heroItem then
		self._heroItem:onDestroy()

		self._heroItem = nil
	end
end

function Season123_1_8PickHeroItem:getAnimator()
	return self._animator
end

return Season123_1_8PickHeroItem
