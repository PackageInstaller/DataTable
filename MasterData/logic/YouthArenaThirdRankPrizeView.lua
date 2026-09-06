-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdRankPrizeView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdRankPrizeView", package.seeall)

local YouthArenaThirdRankPrizeView = class("YouthArenaThirdRankPrizeView", ViewComponent)

YouthArenaThirdRankPrizeView.TabScoreMatch = 1
YouthArenaThirdRankPrizeView.TabKnockout = 2
YouthArenaThirdRankPrizeView.TabCfg = {
	[YouthArenaThirdRankPrizeView.TabScoreMatch] = {
		tip = "排名奖励在<color=#29B67BFF>战区积分赛</color>结束时发放"
	},
	[YouthArenaThirdRankPrizeView.TabKnockout] = {
		tip = "排名奖励在<color=#29B67BFF>全服冠军赛</color>结束时发放"
	}
}

function YouthArenaThirdRankPrizeView:ctor()
	YouthArenaThirdRankPrizeView.super.ctor(self)
end

function YouthArenaThirdRankPrizeView:buildUI()
	YouthArenaThirdRankPrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtTip = self:getTxt("txt")
	self._tableview = ScrollerList.create(self:getGo("tableview"), self:getGo("cell"), GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._switchBtns = {}

	for i = 1, 2 do
		local cell = {}

		cell.go = self:getGo("switchBtns/btn_" .. i)
		cell.change = cell.go:GetComponent(ComponentType.UIChangeGroup)
		self._switchBtns[i] = cell
	end

	self._itemScrollListDic = {}
end

function YouthArenaThirdRankPrizeView:bindEvents()
	YouthArenaThirdRankPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i = 1, #self._switchBtns do
		GameUtil.addClickHandler(self._switchBtns[i].go, GameUtil.handler(self._onClickSwitch, self, i))
	end
end

function YouthArenaThirdRankPrizeView:unbindEvents()
	YouthArenaThirdRankPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i = 1, #self._switchBtns do
		GameUtil.rmClickHandler(self._switchBtns[i].go)
	end
end

function YouthArenaThirdRankPrizeView:onEnter()
	YouthArenaThirdRankPrizeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = YouthArenaThirdController.instance:getActivityId()
	end

	self._curSwitchId = nil

	self:_onClickSwitch(YouthArenaThirdRankPrizeView.TabScoreMatch)
end

function YouthArenaThirdRankPrizeView:onExit()
	YouthArenaThirdRankPrizeView.super.onExit(self)

	if self._tableview then
		self._tableview:dispose()
	end

	for _, itemScrollList in pairs(self._itemScrollListDic or {}) do
		itemScrollList:dispose()
	end

	self._itemScrollListDic = {}
end

function YouthArenaThirdRankPrizeView:_onClickSwitch(switchId)
	if self._curSwitchId == switchId then
		return
	end

	self._curSwitchId = switchId

	self:_refreshSwitchState()
	self:_refreshPrizeList()
end

function YouthArenaThirdRankPrizeView:_refreshSwitchState()
	for i = 1, #self._switchBtns do
		local cell = self._switchBtns[i]

		cell.change:SetState(self._curSwitchId == i and 1 or 0)
	end

	local tabCfg = YouthArenaThirdRankPrizeView.TabCfg[self._curSwitchId]

	if tabCfg then
		self._txtTip.text = tabCfg.tip or ""
	end
end

function YouthArenaThirdRankPrizeView:_refreshPrizeList()
	local dataList = {}

	if self._curSwitchId == YouthArenaThirdRankPrizeView.TabScoreMatch then
		dataList = self:_buildScoreMatchPrizeList()
	elseif self._curSwitchId == YouthArenaThirdRankPrizeView.TabKnockout then
		dataList = self:_buildKnockoutPrizeList()
	end

	self._tableview:reloadData(dataList)
	self._tableview:MoveCellToBegin(0)
end

function YouthArenaThirdRankPrizeView:_buildScoreMatchPrizeList()
	local cfgList = YouthArenaThirdConfig.instance:getScoreMatchRankPrizeDatas(self._activityId) or {}
	local dataList = {}

	for _, cfg in ipairs(cfgList) do
		if not cfg.rankRange then
			table.insert(dataList, {
				rank = checknumber(cfg.rankRange[1]),
				title = cfg.title,
				prize = cfg.prize
			})
		end
	end

	table.sort(dataList, function(a, b)
		return checknumber(a.rank) < checknumber(b.rank)
	end)

	return dataList
end

function YouthArenaThirdRankPrizeView:_buildKnockoutPrizeList()
	local cfgMap = YouthArenaThirdConfig.instance:getKnockoutRankPrizeDatas(self._activityId) or {}
	local dataList = {}

	for _, cfg in pairs(cfgMap) do
		local var_12_1 = {
			rankPrizeId = checknumber(cfg.rankPrizeId),
			rank = checknumber(cfg.rank),
			title = cfg.title
		}

		var_12_1.prize = cfg.showPrize or cfg.prize

		table.insert(dataList, var_12_1)
	end

	table.sort(dataList, function(a, b)
		if a.rank == b.rank then
			return a.rankPrizeId < b.rankPrizeId
		end

		return a.rank < b.rank
	end)

	return dataList
end

function YouthArenaThirdRankPrizeView:_updateRankCell(view, cell, data, tag)
	if not cell.gameObject then
		local go = cell
		local txtRank = goutil.findChildTextComponent(go, "txtRank")
		local imgRank = goutil.findChild(go, "imgRank")
		local imgRankChange = imgRank:GetComponent(ComponentType.UIImageSpriteChange)
		local rank = checknumber(data.rank)
		local isTopRank = rank >= 1 and rank <= 3

		goutil.setActive(imgRank, isTopRank)
		txtRank.gameObject:SetActive(not isTopRank)

		if isTopRank then
			imgRankChange:SetState(rank - 1)

			txtRank.text = ""
		else
			txtRank.text = data.title or ""
		end

		self:_updatePrizeItems(go, data.prize)
	end
end

function YouthArenaThirdRankPrizeView:_clearRankCell(cell)
	if not cell.gameObject then
		local go = cell
		local itemScrollList = self._itemScrollListDic[go]

		if itemScrollList then
			itemScrollList:removeDragNotifyParent()
			itemScrollList:dispose()

			self._itemScrollListDic[go] = nil
		end
	end
end

function YouthArenaThirdRankPrizeView:_updatePrizeItems(go, prize)
	local prizeCom = goutil.findChild(go, "prizeCom")
	local itempos = goutil.findChild(go, "itempos")
	local itemScrollList = self._itemScrollListDic[go]

	if not itemScrollList then
		itemScrollList = ScrollerList.create(prizeCom, itempos, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
		self._itemScrollListDic[go] = itemScrollList

		itemScrollList:dragNotifyParent()
	end

	itemScrollList:reloadData((not string.nilorempty(prize) or nil) and string.split(prize, "#"))
	itemScrollList:MoveCellToBegin(0)
end

function YouthArenaThirdRankPrizeView:_updateItemCell(view, cell, prizeStr, tag)
	if not cell.gameObject then
		MaterialMgr.setCellByCfg(prizeStr, cell.gameObject)
	end
end

function YouthArenaThirdRankPrizeView:_clearItemCell(cell)
	if not cell.gameObject then
		MaterialMgr.resetAll(cell.gameObject)
	end
end

return YouthArenaThirdRankPrizeView
