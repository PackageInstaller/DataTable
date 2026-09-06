-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/TripleMacthesPrizeView.lua

module("logic.extensions.triplemacthesgame.view.TripleMacthesPrizeView", package.seeall)

local TripleMacthesPrizeView = class("TripleMacthesPrizeView", ViewComponent)

function TripleMacthesPrizeView:ctor()
	TripleMacthesPrizeView.super.ctor(self)
end

function TripleMacthesPrizeView:unbindEvents()
	TripleMacthesPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._viewCloseBtn)
end

function TripleMacthesPrizeView:bindEvents()
	TripleMacthesPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._viewCloseBtn, self.close, self)
end

function TripleMacthesPrizeView:buildUI()
	TripleMacthesPrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._viewCloseBtn = self:getGo("viewCloseBtn")
	self._rewardListSR = self:getGo("rewardListBgGo/rewardListSR")
	self._rewardItemGo = self:getGo("rewardListBgGo/rewardItemGo")
	self._itemScrollercell = self:getGo("rewardListBgGo/itemScrollercell")
	self._rewardTableList = ScrollerList.create(self._rewardListSR, self._rewardItemGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function TripleMacthesPrizeView:onExit()
	TripleMacthesPrizeView.super.onExit(self)
	self._rewardTableList:dispose()
end

function TripleMacthesPrizeView:onEnter()
	TripleMacthesPrizeView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._prizeCfg = TripleMachesGameConfig.instance:getPrizeCfgs(self._activityId)
	self._itemScrollListDic = {}

	local list = {}
	local lowLimit = 0

	for i, v in ipairs(self._prizeCfg) do
		table.insert(list, {
			lowLimit = lowLimit,
			cfg = v
		})

		lowLimit = v.scoreLimit + 1
	end

	list[#list].isFinish = true

	self._rewardTableList:reloadData(list)
end

function TripleMacthesPrizeView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local itemScrollerview = goutil.findChild(go, "itemScrollerview")

	txtScore.text = data.isFinish and langPara("%d及以上", data.lowLimit) or langPara("%d-%d", data.lowLimit, data.cfg.scoreLimit)

	local prizeStr = data.cfg.prize

	if itemScrollerview and self._itemScrollercell then
		local prizeStrArr = not string.nilorempty(prizeStr) and string.split(prizeStr, "#") or {}

		if not self._itemScrollListDic[go] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[go] = itemScrollList

			itemScrollList:reloadData(prizeStrArr)
			itemScrollList:dragNotifyParent()
		end
	end
end

function TripleMacthesPrizeView:_clearCell(cell)
	local go = cell.gameObject
	local itemScrollList = self._itemScrollListDic[go]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function TripleMacthesPrizeView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function TripleMacthesPrizeView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

return TripleMacthesPrizeView
