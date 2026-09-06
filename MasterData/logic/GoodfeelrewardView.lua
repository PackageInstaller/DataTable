-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelrewardView.lua

module("logic.extensions.goodfeel.view.GoodfeelrewardView", package.seeall)

local GoodfeelrewardView = class("GoodfeelrewardView", TableViewComponent)

function GoodfeelrewardView:ctor()
	GoodfeelrewardView.super.ctor(self)
end

function GoodfeelrewardView:buildUI()
	GoodfeelrewardView.super.buildUI(self)

	self._clostBtn = self:getBtn("closeBtn")
end

function GoodfeelrewardView:bindEvents()
	GoodfeelrewardView.super.bindEvents(self)
	self._clostBtn:AddClickListener(self.close, self)
end

function GoodfeelrewardView:unbindEvents()
	GoodfeelrewardView.super.unbindEvents(self)
	self._clostBtn:RemoveClickListener()
end

function GoodfeelrewardView:destroyUI()
	GoodfeelrewardView.super.destroyUI(self)
end

function GoodfeelrewardView:onEnter()
	GoodfeelrewardView.super.onEnter(self)
	GlobalDispatcher:addListener(GoodFeelController.PM_GFGainPrizeRes, self._gainPrizeRes, self)

	self._raceId = GoodFeelModel.instance:getPetShowViewCurrRaceId()

	local cfg = HandbookConfig.instance:getPetDetailsCfgById(self._raceId)

	self._curViewDatas = GoodFeelConfig.instance:getPrizePlan(cfg.prizePlan)

	self:_updateGetRewardState()
end

function GoodfeelrewardView:onEnterFinished()
	GoodfeelrewardView.super.onEnterFinished(self)
end

function GoodfeelrewardView:onExit()
	GoodfeelrewardView.super.onExit(self)
	GlobalDispatcher:removeListener(GoodFeelController.PM_GFGainPrizeRes, self._gainPrizeRes, self)
end

function GoodfeelrewardView:onExitFinished()
	GoodfeelrewardView.super.onExitFinished(self)
end

function GoodfeelrewardView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function GoodfeelrewardView:_cellSize(view, index)
	return 120, 120
end

function GoodfeelrewardView:_updateCell(view, cell, data)
	local item = GameUtil.AddLuaOnce(cell.gameObject, GoodfeedrewardItem)

	item:onEnter(self._raceId, data, self._prizeGainBit, cell.data)
end

function GoodfeelrewardView:_clearTableview(cell)
	local item = GameUtil.AddLuaOnce(cell.gameObject, GoodfeedrewardItem)

	item:onExit()
end

function GoodfeelrewardView:_updateGetRewardState()
	self._prizeGainBit = GoodFeelModel.instance:getPrizeGainBit(self._raceId)

	local newList = {}
	local newLastList = {}

	for i, v in ipairs(self._curViewDatas or {}) do
		local isGain = GameUtil.isBitOpenByDigit(self._prizeGainBit, v.lv - 1)

		if isGain then
			table.insert(newLastList, v)
		else
			table.insert(newList, v)
		end
	end

	for i, v in ipairs(newLastList) do
		table.insert(newList, v)
	end

	self._curViewDatas = newList

	self:reloadData()
end

function GoodfeelrewardView:_gainPrizeRes()
	self:_updateGetRewardState()
end

return GoodfeelrewardView
