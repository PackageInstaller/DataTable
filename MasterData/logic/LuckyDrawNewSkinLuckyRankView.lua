-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckyskinlottery/view/LuckyDrawNewSkinLuckyRankView.lua

module("logic.extensions.luckyskinlottery.view.LuckyDrawNewSkinLuckyRankView", package.seeall)

local LuckyDrawNewSkinLuckyRankView = class("LuckyDrawNewSkinLuckyRankView", ViewComponent)

function LuckyDrawNewSkinLuckyRankView:ctor()
	LuckyDrawNewSkinLuckyRankView.super.ctor(self)
end

function LuckyDrawNewSkinLuckyRankView:unbindEvents()
	LuckyDrawNewSkinLuckyRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function LuckyDrawNewSkinLuckyRankView:bindEvents()
	LuckyDrawNewSkinLuckyRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function LuckyDrawNewSkinLuckyRankView:buildUI()
	LuckyDrawNewSkinLuckyRankView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._content = self:getGo("tableview/viewport/content")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function LuckyDrawNewSkinLuckyRankView:onExit()
	LuckyDrawNewSkinLuckyRankView.super.onExit(self)
	self._scrollList:dispose()

	if self._tween then
		self._tween:Kill(false)
	end

	self._tween = nil
end

function LuckyDrawNewSkinLuckyRankView:onEnter()
	LuckyDrawNewSkinLuckyRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_SkinLotteryFreeChargeRankRes, self._onFreeChargeRankRes, self)

	self._activityId = tonumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = LuckyDrawNewSkinModel.instance:getActId()
	end

	self._cellHeight = 121.07
	self._tableviewHeight = 470.42
	self._duration = 75
	self._scrollData = {}

	for i = 0, 299 do
		table.insert(self._scrollData, i)
	end

	SkinLotteryAgent.instance:sendPM_SkinLotteryFreeChargeRankReq(self._activityId)
end

function LuckyDrawNewSkinLuckyRankView:_onFreeChargeRankRes()
	local rankInfo = LuckyDrawNewSkinModel.instance:getFreeRankInfo(self._activityId)

	self._rankList = rankInfo.infoList
	self._rankNum = #self._rankList

	local row = math.ceil(self._rankNum / 3)
	local totalMoveHeight = self._cellHeight * (row - 2) * 3

	if totalMoveHeight > self._tableviewHeight then
		local function updateFunc(val)
			GameUtil.setLocalPos(self._content, 0, val, 0)
		end

		local function endFunc(val)
			GameUtil.setLocalPos(self._content, 0, 0, 0)
		end

		self._tween = TweenUtil.ValueTo(0, totalMoveHeight, self._duration, updateFunc, endFunc, self)

		self._tween:SetLoops(-1, DG.Tweening.LoopType.Restart)
	end

	self._scrollList:reloadData(self._scrollData)
end

function LuckyDrawNewSkinLuckyRankView:_updateCell(view, cell, data)
	local index = data
	local rankData = self._rankList[index % self._rankNum + 1]
	local head = goutil.findChild(cell, "head")
	local txtArea = goutil.findChildTextComponent(cell, "area/txtArea")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")

	HeadItemController.instance:setHeadCellByInfo(head, rankData.opHeadInfo, true)

	txtArea.text = rankData.opHeadInfo.areaName and string.format("%d-%s", rankData.areaId, rankData.opHeadInfo.areaName) or string.format("%d区", rankData.areaId)
	txtName.text = string.format("%s", rankData.opHeadInfo.userName)
	txtDesc.text = string.format("第%d抽免单%d神钻", rankData.lotteryTimes, rankData.godGemCount)
end

function LuckyDrawNewSkinLuckyRankView:_clearCell(cell)
	local head = goutil.findChild(cell, "head")

	HeadItemController.instance:resetHeadCell(head)
end

return LuckyDrawNewSkinLuckyRankView
