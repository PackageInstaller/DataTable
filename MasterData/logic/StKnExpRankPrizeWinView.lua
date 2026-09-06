-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpRankPrizeWinView.lua

module("logic.extensions.stknexp.view.StKnExpRankPrizeWinView", package.seeall)

local StKnExpRankPrizeWinView = class("StKnExpRankPrizeWinView", ViewComponent)

function StKnExpRankPrizeWinView:buildUI()
	StKnExpRankPrizeWinView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local tabScrView = self:getGo("tabCol/scrView")
	local tabScrCell = self:getGo("tabCol/scrCell")

	self._tabScrollList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	local rankScrView = goutil.findChild(self.mainGO, "rankCol/scrView")
	local rankScrCell = goutil.findChild(self.mainGO, "rankCol/scrCell")

	self._rankScrollList = ScrollerList.create(rankScrView, rankScrCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemScrCell = goutil.findChild(self.mainGO, "rankCol/itemScrCell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrCell, false)
end

function StKnExpRankPrizeWinView:bindEvents()
	StKnExpRankPrizeWinView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function StKnExpRankPrizeWinView:unbindEvents()
	StKnExpRankPrizeWinView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function StKnExpRankPrizeWinView:onEnter()
	StKnExpRankPrizeWinView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._clgType = self._clgType or StKnExpEnum.ClgType_Stage
	self._subMo = StKnExpController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_SaintKnightExpeditionInfoRes, self._onUpdate, self)
	self:_onUpdate()
end

function StKnExpRankPrizeWinView:onExit()
	StKnExpRankPrizeWinView.super.onExit(self)
	self:_onClear()
end

function StKnExpRankPrizeWinView:_onUpdate()
	self:_onUpdateTabColUI()
	self:_onUpdateRankColUI()
end

function StKnExpRankPrizeWinView:_onClear()
	self:_onClearTabCol()
	self:_onClearRankCol()
end

function StKnExpRankPrizeWinView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(StKnExpEnum.ClgTypeList)
end

function StKnExpRankPrizeWinView:_onClearTabCol()
	self._tabScrollList:dispose()
end

function StKnExpRankPrizeWinView:_updateTabCell(view, cell, clgType, tag)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local redPoint = goutil.findChild(mainGo, "redPoint")

	txtName.text = StKnExpEnum.ClgTypeNames[clgType]

	GameUtil.setUIGroupIdx(mainGo, self._clgType == clgType and 1 or 0)
	GameUtil.addClickHandler(mainGo, function()
		if self._clgType == clgType then
			return
		end

		self._clgType = clgType

		self:_onUpdate()
	end)
end

function StKnExpRankPrizeWinView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function StKnExpRankPrizeWinView:_onUpdateRankColUI()
	local cfg

	cfg = self._clgType == StKnExpEnum.ClgType_Stage and StKnExpConfig.instance:getStageRankPrizeCfg(self._activityId) or self._clgType == StKnExpEnum.ClgType_Boss and StKnExpConfig.instance:getBossRankPrizeCfg(self._activityId) or cfg

	self._rankScrollList:reloadData(cfg)
	self._rankScrollList:MoveCellToBegin(0, false)
end

function StKnExpRankPrizeWinView:_onClearRankCol()
	self._rankScrollList:dispose()
end

function StKnExpRankPrizeWinView:_updateRankCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtValue = goutil.findChildTextComponent(mainGo, "txtValue")
	local txtArea = goutil.findChildTextComponent(mainGo, "txtArea")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local itemScrView = goutil.findChild(mainGo, "itemScrView")

	GameUtil.SetActive(txtRank.gameObject, false)
	GameUtil.SetActive(imgRank.gameObject, false)

	if not data.rankRange then
		local rankRange = {}
		local left, right = checknumber(rankRange[1]), checknumber(rankRange[2])

		if left == right then
			if left <= 3 then
				imgRank:SetState(left - 1)
				GameUtil.SetActive(imgRank.gameObject, true)
			end
		else
			txtRank.text = string.format("%s~%s名", left, right)

			GameUtil.SetActive(txtRank.gameObject, true)
		end

		if itemScrView and self._itemScrCell and not string.nilorempty(data.prize) then
			local prizeStrArr = string.split(data.prize, "#")

			if not self._itemScrollListDic[mainGo] then
				local itemScrollList = ScrollerList.create(itemScrView, self._itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

				self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

				self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
				self._itemScrollListDic[mainGo]:dragNotifyParent()
			end
		end
	end
end

function StKnExpRankPrizeWinView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")

	HeadItemController.instance:resetHeadCell(headRoot)

	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function StKnExpRankPrizeWinView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function StKnExpRankPrizeWinView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return StKnExpRankPrizeWinView
