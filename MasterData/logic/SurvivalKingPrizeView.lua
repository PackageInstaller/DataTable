-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingPrizeView.lua

module("logic.extensions.survivalking.view.SurvivalKingPrizeView", package.seeall)

local SurvivalKingPrizeView = class("SurvivalKingPrizeView", ViewComponent)

function SurvivalKingPrizeView:ctor()
	SurvivalKingPrizeView.super.ctor(self)
end

function SurvivalKingPrizeView:unbindEvents()
	SurvivalKingPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function SurvivalKingPrizeView:bindEvents()
	SurvivalKingPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function SurvivalKingPrizeView:buildUI()
	SurvivalKingPrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._container = self:getGo("container")
	self._goEmpty = self:getGo("goEmpty")
	self._btnSure = self:getGo("container/btnSure")
	self._goCellItem = self:getGo("container/cellItem")

	local goCellInfo = self:getGo("container/cellInfo")
	local goTableViewInfo = self:getGo("container/tableviewInfo")

	self._tableViewInfo = ScrollerList.create(goTableViewInfo, goCellInfo, GameUtil.handler(self._updateCellInfo, self), GameUtil.handler(self._clearCellInfo, self))
end

function SurvivalKingPrizeView:onExit()
	SurvivalKingPrizeView.super.onExit(self)
	self._tableViewInfo:dispose()
end

function SurvivalKingPrizeView:onEnter()
	SurvivalKingPrizeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SurvivalKingGainPrize, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.SurvivalKingGetPrizeInfo, self._handleGetInfo, self)

	self._itemScrollListDic = {}
	self._activityId = 529001

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])
	end

	SurvivalKingController.instance:getPrizeInfo(self._activityId)
	self:_handleGetInfo()
end

function SurvivalKingPrizeView:_handleGetInfo()
	local prizeInfos = {}
	local info = SurvivalKingModel.instance:getPrizeInfo(self._activityId)

	if info then
		prizeInfos = info.prizes or {}
	end

	if #prizeInfos == 0 then
		self._goEmpty:SetActive(true)
		self._container:SetActive(false)
	else
		self._goEmpty:SetActive(false)
		self._container:SetActive(true)
	end

	self._tableViewInfo:reloadData(prizeInfos)
end

function SurvivalKingPrizeView:_onClickSure()
	SurvivalKingController.instance:sendGainPrizeReq(self._activityId)
end

function SurvivalKingPrizeView:_updateCellInfo(view, cell, data, tag)
	local go = cell.gameObject
	local txtRank = goutil.findChildTextComponent(go, "txtrank")
	local txtDate = goutil.findChildTextComponent(go, "txtDate")
	local txtTitle = goutil.findChildTextComponent(go, "txtTitle")
	local itemListGo = goutil.findChild(go, "itemScrollerview")

	txtRank.text = ""

	local prizeCfg = SurvivalKingConfig.instance:getSessionRankPrizeCfg(self._activityId, data.lastRoundId)

	if itemListGo and self._goCellItem then
		if prizeCfg then
			if not prizeCfg.prize then
				do
					local prizes = ""

					if not self._itemScrollListDic[go] then
						local prizeScrollList = ScrollerList.create(itemListGo, self._goCellItem, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

						self._itemScrollListDic[go] = prizeScrollList

						local prizeStrArr = string.split(prizes, "#")

						prizeScrollList:reloadData(prizeStrArr)
						prizeScrollList:dragNotifyParent()
					end
				end

				if prizeCfg then
					txtRank.text = string.format("第%s名", prizeCfg.showRank)

					goto label_9_0
				end
			end
		end
	end

	txtRank.text = ""

	::label_9_0::

	local sessionCfg = SurvivalKingConfig.instance:getSessionCfg(self._activityId, data.sessionId)

	txtTitle.text = ""

	if sessionCfg then
		txtTitle.text = string.format("%s场次", sessionCfg.sessionName or "")
	end

	txtDate.text = ""

	local date = data.date

	if date and date > 0 then
		local dateStr = tostring(date)

		if #dateStr == 8 then
			local year = string.sub(dateStr, 1, 4)
			local month = string.sub(dateStr, 5, 6)
			local day = string.sub(dateStr, 7, 8)

			txtDate.text = string.format("%s.%s.%s", year, month, day)
		end
	end
end

function SurvivalKingPrizeView:_clearCellInfo(cell)
	local go = cell.gameObject
	local prizeScrollList = self._itemScrollListDic[go]

	if prizeScrollList then
		prizeScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function SurvivalKingPrizeView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function SurvivalKingPrizeView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

return SurvivalKingPrizeView
