-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelattrView.lua

module("logic.extensions.goodfeel.view.GoodfeelattrView", package.seeall)

local GoodfeelattrView = class("GoodfeelattrView", ViewComponent)

function GoodfeelattrView:ctor()
	GoodfeelattrView.super.ctor(self)
end

function GoodfeelattrView:unbindEvents()
	GoodfeelattrView.super.unbindEvents(self)
end

function GoodfeelattrView:bindEvents()
	GoodfeelattrView.super.bindEvents(self)
end

function GoodfeelattrView:buildUI()
	GoodfeelattrView.super.buildUI(self)

	self._itemGo = self:getGo("root/item")
	self._itemrootGo = self:getGo("root/itemroot")
	self._itemGroup = ItemGroup.New(self._itemrootGo, self._itemGo, nil, nil, true)

	goutil.setActive(self._itemGo, false)

	self._emptyTipGo = self:getGo("root/emptyTip")
end

function GoodfeelattrView:onExit()
	GoodfeelattrView.super.onExit(self)
	GlobalDispatcher:removeListener(GoodFeelModel.ChangePetShow, self._updateView, self)
	GlobalDispatcher:removeListener(GoodFeelController.RealUseGift, self._updateView, self)
end

function GoodfeelattrView:onEnter()
	GoodfeelattrView.super.onEnter(self)
	GlobalDispatcher:addListener(GoodFeelModel.ChangePetShow, self._updateView, self)
	GlobalDispatcher:addListener(GoodFeelController.RealUseGift, self._updateView, self)
	self:_updateView()
end

function GoodfeelattrView:_prepareData()
	self._raceId, self._skinId = GoodFeelModel.instance:getPetShowViewCurrRaceId()
	self._goodFeelLv = GoodFeelModel.instance:getPetGoodFeelLv(self._raceId)
	self._maxUnlockLv = GoodFeelModel.instance:getMaxUnlockPropLv(self._raceId)

	local detailCfg = HandbookConfig.instance:getPetDetailsCfgById(self._raceId)
	local temp = GoodFeelConfig.instance:getLvPropCfgs(detailCfg.propertyPlan)

	self._cfgs = temp and table.values(temp) or {}

	table.sort(self._cfgs, function(a, b)
		return a.unlockLv < b.unlockLv
	end)
end

function GoodfeelattrView:_updateView()
	self:_prepareData()
	goutil.setActive(self._emptyTipGo, not self._cfgs or #self._cfgs <= 0)
	self._itemGroup:updateWithMoArray(self._cfgs, function(item, cfg)
		local txtAttr = goutil.findChildTextComponent(item.mainGO, "txtAttr")
		local txtName = goutil.findChildTextComponent(item.mainGO, "txtName")
		local goLock = goutil.findChild(item.mainGO, "lock")
		local txtLock = goutil.findChildTextComponent(goLock, "txtLock")
		local isLock = self._maxUnlockLv < cfg.unlockLv

		goutil.setActive(goLock, isLock)

		if isLock then
			txtLock.text = string.format("%s级解锁", cfg.unlockLv)
		end

		txtName.text = "全体精灵："
		txtAttr.text = cfg.propertyApp
	end)
end

return GoodfeelattrView
