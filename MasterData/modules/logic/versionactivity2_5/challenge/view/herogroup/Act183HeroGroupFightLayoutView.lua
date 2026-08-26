-- chunkname: @modules/logic/versionactivity2_5/challenge/view/herogroup/Act183HeroGroupFightLayoutView.lua

module("modules.logic.versionactivity2_5.challenge.view.herogroup.Act183HeroGroupFightLayoutView", package.seeall)

local Act183HeroGroupFightLayoutView = class("Act183HeroGroupFightLayoutView", BaseView)

function Act183HeroGroupFightLayoutView:onInitView()
	self.heroContainer = gohelper.findChild(self.viewGO, "herogroupcontain/area")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act183HeroGroupFightLayoutView:addEvents()
	return
end

function Act183HeroGroupFightLayoutView:removeEvents()
	return
end

Act183HeroGroupFightLayoutView.MoveOffsetX = 125

function Act183HeroGroupFightLayoutView:_editableInitView()
	self.isSeason166Episode = Season166HeroGroupModel.instance:isSeason166Episode()

	if not self.isSeason166Episode then
		return
	end

	self.goHeroGroupContain = gohelper.findChild(self.viewGO, "herogroupcontain")
	self.heroGroupContainRectTr = self.goHeroGroupContain:GetComponent(gohelper.Type_RectTransform)
	self.maxHeroCount = Season166HeroGroupModel.instance:getMaxHeroCountInGroup()

	self:initItemName()

	self.heroItemList = {}

	for i = 1, self.maxHeroCount do
		local heroItem = self:getUserDataTb_()

		heroItem.bgRectTr = gohelper.findChildComponent(self.viewGO, "herogroupcontain/hero/bg" .. i, gohelper.Type_RectTransform)
		heroItem.posGoTr = gohelper.findChildComponent(self.viewGO, "herogroupcontain/area/pos" .. i, gohelper.Type_RectTransform)
		heroItem.bgX = recthelper.getAnchorX(heroItem.bgRectTr)
		heroItem.posX = recthelper.getAnchorX(heroItem.posGoTr)

		table.insert(self.heroItemList, heroItem)
	end

	self.mainFrameBgTr = gohelper.findChildComponent(self.viewGO, "frame/#go_mainFrameBg", gohelper.Type_RectTransform)
	self.mainFrameBgWidth = recthelper.getWidth(self.mainFrameBgTr)
	self.mainFrameBgX = recthelper.getAnchorX(self.mainFrameBgTr)
	self.helpFrameBgTr = gohelper.findChildComponent(self.viewGO, "frame/#go_helpFrameBg", gohelper.Type_RectTransform)
	self.helpFrameBgWidth = recthelper.getWidth(self.helpFrameBgTr)
	self.helpFrameBgX = recthelper.getAnchorX(self.helpFrameBgTr)

	self.addEventCb(self, Season166HeroGroupController.instance, Season166Event.OnCreateHeroItemDone, self.onCreateHeroItemDone, self)
end

function Act183HeroGroupFightLayoutView:initItemName()
	if self.maxHeroCount == Season166Enum.MaxHeroCount then
		return
	end

	local middleHeroNum = self.maxHeroCount / 2 + 1

	for i = 1, Season166Enum.MaxHeroCount do
		local pos = gohelper.findChild(self.heroContainer, "pos" .. i)
		local bg = gohelper.findChild(self.viewGO, "herogroupcontain/hero/bg" .. i)

		gohelper.setActive(pos, i % middleHeroNum ~= 0)
		gohelper.setActive(bg, i % middleHeroNum ~= 0)

		if i % middleHeroNum == 0 then
			pos.name = string.format("pos_%d_1", i)
			bg.name = string.format("bg_%d_1", i)
		end

		if middleHeroNum <= i and i % middleHeroNum ~= 0 then
			local nameIndex = i - math.floor(i / middleHeroNum)

			pos.name = "pos" .. nameIndex
			bg.name = "bg" .. nameIndex
		end
	end
end

function Act183HeroGroupFightLayoutView:onCreateHeroItemDone()
	for i = 1, self.maxHeroCount do
		local heroItem = self.heroItemList[i]

		heroItem.heroItemRectTr = gohelper.findChildComponent(self.goHeroGroupContain, "hero/item" .. i, gohelper.Type_RectTransform)
	end

	self:setUIPos()
end

function Act183HeroGroupFightLayoutView:setUIPos()
	local moveOffsetX = self.maxHeroCount == Season166Enum.MaxHeroCount and 0 or Act183HeroGroupFightLayoutView.MoveOffsetX

	for i = 1, self.maxHeroCount do
		local heroItem = self.heroItemList[i]

		recthelper.setAnchorX(heroItem.bgRectTr, heroItem.bgX + moveOffsetX)
		recthelper.setAnchorX(heroItem.posGoTr, heroItem.posX + moveOffsetX)

		local heroItemTr = heroItem.heroItemRectTr

		if not gohelper.isNil(heroItemTr) then
			local anchorPos = recthelper.rectToRelativeAnchorPos(heroItem.posGoTr.position, self.heroGroupContainRectTr)

			recthelper.setAnchor(heroItemTr, anchorPos.x, anchorPos.y)
		end
	end
end

function Act183HeroGroupFightLayoutView:onClose()
	return
end

function Act183HeroGroupFightLayoutView:onDestroyView()
	return
end

return Act183HeroGroupFightLayoutView
