-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/upholdjustice/view/UpholdjusticeranktabView.lua

module("logic.extensions.upholdjustice.view.UpholdjusticeranktabView", package.seeall)

local UpholdjusticeranktabView = class("UpholdjusticeranktabView", ViewComponent)
local empty_list = {}

function UpholdjusticeranktabView:unbindEvents()
	UpholdjusticeranktabView.super.unbindEvents(self)
end

function UpholdjusticeranktabView:bindEvents()
	UpholdjusticeranktabView.super.bindEvents(self)
end

function UpholdjusticeranktabView:buildUI()
	UpholdjusticeranktabView.super.buildUI(self)

	self._emptyGo = self:getGo("emptyGo")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
	self._txtMyValue = self:getTxt("myRank/txtMyValue")
	self._txtTip = self:getTxt("myRank/tip/txtTip")
	self._itemcell = self:getGo("tableview/itemcell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._itemScrollListDic = {}
end

function UpholdjusticeranktabView:onExit()
	UpholdjusticeranktabView.super.onExit(self)
	self._scrollList:dispose()

	for go, itemScrollList in pairs(self._itemScrollListDic) do
		itemScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function UpholdjusticeranktabView:onEnter()
	UpholdjusticeranktabView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 581001
	end

	self.addGEvent(self, GlobalNotify.ON_UPHOLD_JUSTICE_RANK_INFO, self._refreshUI, self)
	UpholdJusticeController.instance:sendGetRankInfo(self._activityId)
	self:_refreshUI()
end

function UpholdjusticeranktabView:_refreshUI()
	self._info = UpholdJusticeModel.instance:getRankInfo(self._activityId) or {}

	if not self._info.rankInfoList then
		local rankInfoList = {}
		local myRank = checknumber(self._info.myRank)
		local myScore = checknumber(self._info.myScore)

		self._scrollList:reloadData(rankInfoList)
		GameUtil.SetActive(self._emptyGo, #rankInfoList == 0)

		self._txtMyRank.text = myRank > 0 and myRank or "未上榜"
		self._txtMyValue.text = checknumber(self._info.myScore)
	end
end

function UpholdjusticeranktabView:_updateCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtZdl = goutil.findChildTextComponent(cell, "txtZdl")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")
	local txtFamily = goutil.findChildTextComponent(cell, "txtFamily")
	local btnHead = goutil.findChild(cell, "btnHead")
	local imgRank = goutil.findChild(cell, "imgRank")
	local imgHeadIcon = goutil.findChild(cell, "imgHeadIcon")
	local itemScrollerview = goutil.findChild(cell, "tableview")
	local rank = checknumber(data.rank)

	txtRank.text = rank
	txtRank.text = ""

	if rank <= 3 then
		GameUtil.SetActive(imgRank, true)
		GameUtil.setUIImageSpriteIdx(imgRank, rank - 1)
	else
		GameUtil.SetActive(imgRank, false)

		txtRank.text = rank
	end

	txtName.text = data.headInfo.userName
	txtFamily.text = data.headInfo.areaName
	txtZdl.text = checknumber(data.value)

	local date = GameUtil.time2date(checknumber(data.time) / 1000)

	txtTime.text = string.format("%02d月%02d日\n%02d:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)

	HeadItemController.instance:setHeadCellByInfo(imgHeadIcon, data.headInfo, true)

	if itemScrollerview and self._itemcell then
		local prizeStrArr = UpholdJusticConfig.instance:getPrizeList(self._activityId, rank) or empty_list

		if not self._itemScrollListDic[cell] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemcell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			itemScrollList:setCenterMode(true)

			self._itemScrollListDic[cell] = itemScrollList

			itemScrollList:reloadData(prizeStrArr)
			itemScrollList:dragNotifyParent()
		end
	end
end

function UpholdjusticeranktabView:_clearCell(cell)
	local headGo = goutil.findChild(cell, "btnHead")

	HeadItemController.instance:resetHeadCell(headGo)

	if self._itemScrollListDic[cell] then
		self._itemScrollListDic[cell]:dispose()

		self._itemScrollListDic[cell] = nil
	end
end

function UpholdjusticeranktabView:_updateItemCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell)
end

function UpholdjusticeranktabView:_clearItemCell(cell)
	MaterialMgr.resetAll(cell)
end

return UpholdjusticeranktabView
