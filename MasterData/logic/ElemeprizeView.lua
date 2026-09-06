-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eleme/view/ElemeprizeView.lua

module("logic.extensions.eleme.view.ElemeprizeView", package.seeall)

local ElemeprizeView = class("ElemeprizeView", ViewComponent)

function ElemeprizeView:ctor()
	ElemeprizeView.super.ctor(self)
end

function ElemeprizeView:unbindEvents()
	ElemeprizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ElemeprizeView:bindEvents()
	ElemeprizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ElemeprizeView:buildUI()
	ElemeprizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtNum = self:getTxt("txtNum")
	self._itemcell = self:getGo("itemcell")
	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function ElemeprizeView:onExit()
	ElemeprizeView.super.onExit(self)
	self._scrollList:dispose()
end

function ElemeprizeView:onEnter()
	ElemeprizeView.super.onEnter(self)

	self._rewardScroller = {}
	self._activityId = checknumber(self:getFirstParam())

	self:_refreshUI()
	self.addGEvent(self, GlobalNotify.ElemeInfoUpdate, self._refreshUI, self)
end

function ElemeprizeView:_refreshUI()
	local info = ElemeModel.instance:getMsgInfo(self._activityId) or {}

	self._likeNum = checknumber(info.likeNum)
	self._txtNum.text = self._likeNum

	if not info.gainedPrizeId then
		self._gainedPrizeIdMap = {}

		for i, v in ipairs(info.gainedPrizeId) do
			self._gainedPrizeIdMap[v] = true
		end

		local temp = ElemeConfig.instance:getPrizeList(self._activityId) or {}
		local list = {}

		for i, v in ipairs(temp) do
			table.insert(list, v)
		end

		ArraySort.sortOn(list, {
			function(cfg)
				if self._gainedPrizeIdMap[cfg.prizeId] then
					return 0
				else
					return 1
				end
			end,
			"prizeId"
		}, {
			ArraySort.NUMERIC,
			ArraySort.NUMERIC
		})
		self._scrollList:reloadData(list)
	end
end

function ElemeprizeView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local btnSure = goutil.findChild(cell, "btnSure")
	local receive = goutil.findChild(cell, "receive")
	local noPass = goutil.findChild(cell, "noPass")
	local rewardViewGo = goutil.findChild(cell, "rewardView")
	local rewardView = self._rewardScroller[cell]

	if rewardView == nil then
		rewardView = ScrollerList.create(rewardViewGo, self._itemcell, GameUtil.handler(self._updateRewarCell, self), GameUtil.handler(self._clearRewardCell, self))

		rewardView:dragNotifyParent()
	end

	self._rewardScroller[cell] = rewardView
	txtDesc.text = langPara("累计获得好评%s星", data.likeNum)

	GameUtil.SetActive(btnSure, not self._gainedPrizeIdMap[data.prizeId] and self._likeNum >= data.likeNum)
	GameUtil.SetActive(receive, self._gainedPrizeIdMap[data.prizeId])
	GameUtil.addClickHandler(btnSure, function()
		if self._likeNum >= data.likeNum then
			ElemeController.instance:sendGetPrize(self._activityId, data.prizeId)
		else
			TipsFacade.instance:openCommonTips("未到达领取条件")
		end
	end)

	local prizeData = string.split(data.prize, "#") or {}

	rewardView:reloadData(prizeData)
end

function ElemeprizeView:clearCell(cell)
	local rewardView = self._rewardScroller[cell]

	if rewardView then
		rewardView:dispose()
	end
end

function ElemeprizeView:_updateRewarCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function ElemeprizeView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell)
end

return ElemeprizeView
