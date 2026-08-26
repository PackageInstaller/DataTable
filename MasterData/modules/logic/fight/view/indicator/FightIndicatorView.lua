-- chunkname: @modules/logic/fight/view/indicator/FightIndicatorView.lua

module("modules.logic.fight.view.indicator.FightIndicatorView", package.seeall)

local FightIndicatorView = class("FightIndicatorView", FightIndicatorBaseView)

FightIndicatorView.PrefabPath = "ui/sceneui/fight/seasoncelebritycardi.prefab"
FightIndicatorView.EffectDuration = 1.667
FightIndicatorView.EffectDurationForDot = 0.8
FightIndicatorView.MaxIndicatorCount = 5

function FightIndicatorView:initView(indicatorMgrView, indicatorId, totalIndicatorNum)
	FightIndicatorView.super.initView(self, indicatorMgrView, indicatorId, totalIndicatorNum)

	self.totalIndicatorNum = FightIndicatorView.MaxIndicatorCount
	self.goIndicatorContainer = gohelper.findChild(self.goIndicatorRoot, "fight_indicator")
end

function FightIndicatorView:startLoadPrefab()
	gohelper.setActive(self.goIndicatorContainer, true)

	self.loader = PrefabInstantiate.Create(self.goIndicatorContainer)

	self.loader:startLoad(FightIndicatorView.PrefabPath, self.loadCallback, self)
end

function FightIndicatorView:loadCallback()
	self.loadDone = true
	self.instanceGo = self.loader:getInstGO()

	self:initNode()
	self:onIndicatorChange()
end

function FightIndicatorView:initNode()
	self.init = true
	self.goDownOne = gohelper.findChild(self.instanceGo, "down_one")
	self.goDownAll = gohelper.findChild(self.instanceGo, "down_all")
	self.goUpOne = gohelper.findChild(self.instanceGo, "up_one")
	self.goUpAll = gohelper.findChild(self.instanceGo, "up_all")
	self.pointContainer = gohelper.findChild(self.instanceGo, "pointContainer")

	local goDot = gohelper.findChild(self.instanceGo, "pointContainer/dot_item")

	self.goDotItemList = {}

	table.insert(self.goDotItemList, self:createDotItem(goDot))

	for i = 2, self.totalIndicatorNum do
		goDot = gohelper.cloneInPlace(goDot)

		table.insert(self.goDotItemList, self:createDotItem(goDot))
	end

	self.simageIcon = gohelper.findChildSingleImage(self.instanceGo, "card/#go_rare5/image_icon")
	self.simageSignature = gohelper.findChildSingleImage(self.instanceGo, "card/#go_rare5/simage_signature")

	local goCareer = gohelper.findChild(self.instanceGo, "card/#go_rare5/image_career")

	gohelper.setActive(goCareer, false)
	self:loadImage()
end

function FightIndicatorView:createDotItem(goDot)
	local dotItem = self:getUserDataTb_()

	dotItem.goDot = goDot
	dotItem.goDarkIcon = gohelper.findChild(goDot, "dark_icon")
	dotItem.goBrightIcon = gohelper.findChild(goDot, "bright_icon")
	dotItem.goEffect = gohelper.findChild(goDot, "effect")
	dotItem.goEffectOne = gohelper.findChild(goDot, "effect/one")
	dotItem.goEffectAll = gohelper.findChild(goDot, "effect/all")

	return dotItem
end

function FightIndicatorView:loadImage()
	local config = self:getCardConfig()

	self.simageIcon:LoadImage(ResUrl.getSeasonCelebrityCard(config.icon))

	if not string.nilorempty(config.signIcon) then
		self.simageSignature:LoadImage(ResUrl.getSignature(config.signIcon, "characterget"))
	end
end

function FightIndicatorView:getCardConfig()
	return SeasonConfig.instance:getSeasonEquipCo(self:getCardId())
end

function FightIndicatorView:getCardId()
	return 11549
end

function FightIndicatorView:onIndicatorChange()
	if not self.loadDone then
		return
	end

	local num = FightDataHelper.fieldMgr:getIndicatorNum(self.indicatorId)

	if num <= 0 or num > self.totalIndicatorNum then
		return
	end

	self.indicatorNum = num

	self:playEffect()
end

function FightIndicatorView:playEffect()
	gohelper.setActive(self.goIndicatorContainer, true)
	self:resetEffect()
	self:refreshDotItemNode()

	if self.indicatorNum == self.totalIndicatorNum then
		AudioMgr.instance:trigger(AudioEnum.UI.play_buff_accrued_number_2)
		gohelper.setActive(self.goDownAll, true)
		gohelper.setActive(self.goUpAll, true)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_buff_accrued_number_1)
		gohelper.setActive(self.goDownOne, true)
		gohelper.setActive(self.goUpOne, true)
	end

	TaskDispatcher.runDelay(self.playEffectDone, self, FightIndicatorView.EffectDuration)

	local dotItem = self.goDotItemList[self.indicatorNum]

	if dotItem then
		gohelper.setActive(dotItem.goEffect, true)

		local isLastDot = self.indicatorNum == self.totalIndicatorNum

		gohelper.setActive(dotItem.goEffectOne, not isLastDot)
		gohelper.setActive(dotItem.goEffectAll, isLastDot)
	end
end

function FightIndicatorView:refreshDotItemNode()
	local dotItem

	for i = 1, self.totalIndicatorNum do
		dotItem = self.goDotItemList[i]

		gohelper.setActive(self.goDotItemList[i].goEffectOne, false)
		gohelper.setActive(dotItem.goEffectAll, false)
		gohelper.setActive(dotItem.goBrightIcon, i <= self.indicatorNum)
		gohelper.setActive(dotItem.goDarkIcon, i > self.indicatorNum)
	end
end

function FightIndicatorView:playEffectDone()
	gohelper.setActive(self.goIndicatorContainer, false)
	self:resetEffect()
end

function FightIndicatorView:resetEffect()
	gohelper.setActive(self.goDownOne, false)
	gohelper.setActive(self.goDownAll, false)
	gohelper.setActive(self.goUpOne, false)
	gohelper.setActive(self.goUpAll, false)
end

function FightIndicatorView:onDestroy()
	TaskDispatcher.cancelTask(self.playEffectDone, self)

	self.goDotItemList = nil

	if self.loader then
		self.loader:onDestroy()

		self.loader = nil
	end

	if gohelper.isNil(self.simageIcon) then
		self.simageIcon:UnLoadImage()
	end

	if gohelper.isNil(self.simageSignature) then
		self.simageSignature:UnLoadImage()
	end

	FightIndicatorView.super.onDestroy(self)
end

return FightIndicatorView
