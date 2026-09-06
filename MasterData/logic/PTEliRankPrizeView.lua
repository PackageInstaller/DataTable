-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/PTEliRankPrizeView.lua

module("logic.extensions.peaktournament.view.eliminator.PTEliRankPrizeView", package.seeall)

local PTEliRankPrizeView = class("PTEliRankPrizeView", ViewComponent)

PTEliRankPrizeView.TabZone = 1
PTEliRankPrizeView.TabSpace = 2

function PTEliRankPrizeView:buildUI()
	PTEliRankPrizeView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._itemScrollercell = goutil.findChild(self.mainGO, "rankCol/itemScrollercell")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._btnTabZone = self:getGo("btnTabZone")
	self._changeGroupZone = self._btnTabZone:GetComponent(ComponentType.UIChangeGroup)
	self._btnTabSpace = self:getGo("btnTabSpace")
	self._changeGroupSpace = self._btnTabSpace:GetComponent(ComponentType.UIChangeGroup)
	self._txtTips = self:getTxt("tips/txt")
end

function PTEliRankPrizeView:bindEvents()
	PTEliRankPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTabZone, self._onClickTabZone, self)
	GameUtil.addClickHandler(self._btnTabSpace, self._onClickTabSpace, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PTEliRankPrizeView:unbindEvents()
	PTEliRankPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTabZone)
	GameUtil.rmClickHandler(self._btnTabSpace)
	GameUtil.rmClickHandler(self._btnClose)
end

function PTEliRankPrizeView:onEnter()
	PTEliRankPrizeView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		FloatWordMgr.instance:show("缺失活动id")

		return
	end

	self._actCfg = PeakTournamentConfig.instance:getPtBaseData(self._activityId)
	self._tab = PTEliRankPrizeView.TabZone

	self:_onUpdateRankScrollerList()
	self:_updateTabInfo()
end

function PTEliRankPrizeView:onExit()
	PTEliRankPrizeView.super.onExit(self)
	self._rankScrollList:dispose()
end

function PTEliRankPrizeView:_onUpdateRankScrollerList()
	local cfg = PeakTournamentConfig.instance:getPtEliRankPrizeCfg(self._actCfg.eliRankPrizePlanId)

	self._rankScrollList:reloadData((self._tab == PTEliRankPrizeView.TabSpace and self._actCfg.spaceRankPrizePlanId > 0 or nil) and PeakTournamentConfig.instance:getPtEliRankPrizeCfg(self._actCfg.spaceRankPrizePlanId))
end

function PTEliRankPrizeView:_updateRankCell(view, cell, data, tag)
	local index = cell.index
	local mainGo = cell.gameObject
	local imgRank = goutil.findChild(mainGo, "imgRank")
	local imgRankSpriteChange = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local txtRankRange = goutil.findChildTextComponent(mainGo, "txtRankRange")
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")
	local isNeedImgRank = data.eliRank <= 3 and data.eliRank > 0

	GameUtil.SetActive(imgRank, isNeedImgRank)

	if isNeedImgRank then
		imgRankSpriteChange:SetState(index)
	end

	txtRankRange.text = data.txtTitle

	GameUtil.SetActive(txtRankRange.gameObject, not isNeedImgRank)

	if itemScrollerview and self._itemScrollercell then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

			self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
			self._itemScrollListDic[mainGo]:dragNotifyParent()
		end
	end
end

function PTEliRankPrizeView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function PTEliRankPrizeView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo, urlOrGo, luaCls, isOne)
end

function PTEliRankPrizeView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function PTEliRankPrizeView:_updateTabInfo()
	self._changeGroupZone:SetState(self._tab == PTEliRankPrizeView.TabZone and 1 or 0)
	self._changeGroupSpace:SetState(self._tab == PTEliRankPrizeView.TabSpace and 1 or 0)

	self._txtTips.text = self._tab == PTEliRankPrizeView.TabZone and lang("排名奖励在巅峰战区赛结束时发放") or self._tab == PTEliRankPrizeView.TabSpace and lang("排名奖励在巅峰王者赛结束时发放") or lang("排名奖励在淘汰赛结束时发放")
end

function PTEliRankPrizeView:_onClickTabZone()
	self._tab = PTEliRankPrizeView.TabZone

	self:_updateTabInfo()
	self:_onUpdateRankScrollerList()
end

function PTEliRankPrizeView:_onClickTabSpace()
	self._tab = PTEliRankPrizeView.TabSpace

	self:_updateTabInfo()
	self:_onUpdateRankScrollerList()
end

return PTEliRankPrizeView
