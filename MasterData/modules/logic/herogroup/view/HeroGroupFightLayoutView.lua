-- chunkname: @modules/logic/herogroup/view/HeroGroupFightLayoutView.lua

module("modules.logic.herogroup.view.HeroGroupFightLayoutView", package.seeall)

local HeroGroupFightLayoutView = class("HeroGroupFightLayoutView", BaseView)

function HeroGroupFightLayoutView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupFightLayoutView:addEvents()
	return
end

function HeroGroupFightLayoutView:removeEvents()
	return
end

HeroGroupFightLayoutView.DefaultOffsetX = -130

function HeroGroupFightLayoutView:checkNeedSetOffset()
	return false
end

function HeroGroupFightLayoutView:_editableInitView()
	self.goHeroGroupContain = gohelper.findChild(self.viewGO, "herogroupcontain")
	self.heroGroupContainRectTr = self.goHeroGroupContain:GetComponent(gohelper.Type_RectTransform)
	self.containerAnimator = self.goHeroGroupContain:GetComponent(typeof(UnityEngine.Animator))
	self.heroItemList = {}

	for i = 1, 4 do
		local heroItem = self:getUserDataTb_()

		heroItem.bgRectTr = gohelper.findChildComponent(self.viewGO, "herogroupcontain/hero/bg" .. i, gohelper.Type_RectTransform)
		heroItem.posGoTr = gohelper.findChildComponent(self.viewGO, "herogroupcontain/area/pos" .. i, gohelper.Type_RectTransform)
		heroItem.bgX = recthelper.getAnchorX(heroItem.bgRectTr)
		heroItem.posX = recthelper.getAnchorX(heroItem.posGoTr)

		table.insert(self.heroItemList, heroItem)
	end

	self.replayFrameRectTr = gohelper.findChildComponent(self.viewGO, "#go_container/#go_replayready/#simage_replayframe", gohelper.Type_RectTransform)
	self.replayFrameWidth = recthelper.getWidth(self.replayFrameRectTr)
	self.replayFrameX = recthelper.getAnchorX(self.replayFrameRectTr)
	self.tipRectTr = gohelper.findChildComponent(self.viewGO, "#go_container/#go_replayready/tip", gohelper.Type_RectTransform)
	self.tipX = recthelper.getAnchorX(self.tipRectTr)

	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnCreateHeroItemDone, self.onCreateHeroItemDone, self)
end

function HeroGroupFightLayoutView:onCreateHeroItemDone()
	for i = 1, 4 do
		local heroItem = self.heroItemList[i]

		heroItem.heroItemRectTr = gohelper.findChildComponent(self.goHeroGroupContain, "hero/item" .. i, gohelper.Type_RectTransform)
	end

	self:setUIPos()
end

function HeroGroupFightLayoutView:setUIPos()
	if not self:checkNeedSetOffset() then
		return
	end

	self.containerAnimator.enabled = false

	for i = 1, 4 do
		local heroItem = self.heroItemList[i]

		recthelper.setAnchorX(heroItem.bgRectTr, heroItem.bgX + HeroGroupFightLayoutView.DefaultOffsetX)
		recthelper.setAnchorX(heroItem.posGoTr, heroItem.posX + HeroGroupFightLayoutView.DefaultOffsetX)

		local heroItemTr = heroItem.heroItemRectTr

		if not gohelper.isNil(heroItemTr) then
			local anchorPos = recthelper.rectToRelativeAnchorPos(heroItem.posGoTr.position, self.heroGroupContainRectTr)

			recthelper.setAnchor(heroItemTr, anchorPos.x, anchorPos.y)
		end
	end

	recthelper.setWidth(self.replayFrameRectTr, 1340)
	recthelper.setAnchorX(self.replayFrameRectTr, -60)
	recthelper.setAnchorX(self.tipRectTr, -156)
end

function HeroGroupFightLayoutView:resetUIPos()
	for i = 1, 4 do
		local heroItem = self.heroItemList[i]

		recthelper.setAnchorX(heroItem.bgRectTr, heroItem.bgX)
		recthelper.setAnchorX(heroItem.posGoTr, heroItem.posX)

		local heroItemTr = heroItem.heroItemRectTr

		if not gohelper.isNil(heroItemTr) then
			local anchorPos = recthelper.rectToRelativeAnchorPos(heroItem.posGoTr.position, self.heroGroupContainRectTr)

			recthelper.setAnchor(heroItemTr, anchorPos.x, anchorPos.y)
		end
	end

	recthelper.setWidth(self.replayFrameRectTr, self.replayFrameWidth)
	recthelper.setAnchorX(self.replayFrameRectTr, self.replayFrameX)
	recthelper.setAnchorX(self.tipRectTr, self.tipX)
end

function HeroGroupFightLayoutView:onClose()
	return
end

function HeroGroupFightLayoutView:onDestroyView()
	return
end

return HeroGroupFightLayoutView
