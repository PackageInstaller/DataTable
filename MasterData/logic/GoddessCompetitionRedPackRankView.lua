-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionRedPackRankView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionRedPackRankView", package.seeall)

local GoddessCompetitionRedPackRankView = class("GoddessCompetitionRedPackRankView", ViewComponent)

function GoddessCompetitionRedPackRankView:ctor()
	GoddessCompetitionRedPackRankView.super.ctor(self)
end

function GoddessCompetitionRedPackRankView:buildUI()
	GoddessCompetitionRedPackRankView.super.buildUI(self)

	self._ranktableGo = goutil.findChild(self.mainGO, "rankScrollRect")
	self._ranktableCell = goutil.findChild(self.mainGO, "cell")
	self._rankTableList = ScrollerList.create(self._ranktableGo, self._ranktableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyGo = goutil.findChild(self.mainGO, "goEmpty")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "myRank/txtMyRank")
	self._txtMyScore = self:getTxt("myRank/txtMyScore")
	self._itemTableCell = self:getGo("itemTableCell")
	self._prize = self:getGo("myRank/prize")
	self._prizeTableView = self:getGo("myRank/prize/prizeTableView")
	self._prizeTableCell = self:getGo("myRank/prize/prizeTableView/prizeTableCell")
	self._prizeTableList = ScrollerList.create(self._prizeTableView, self._prizeTableCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
end

function GoddessCompetitionRedPackRankView:bindEvents()
	GoddessCompetitionRedPackRankView.super.bindEvents(self)
end

function GoddessCompetitionRedPackRankView:unbindEvents()
	GoddessCompetitionRedPackRankView.super.unbindEvents(self)
end

function GoddessCompetitionRedPackRankView:destroyUI()
	GoddessCompetitionRedPackRankView.super.destroyUI(self)
end

function GoddessCompetitionRedPackRankView:onEnter()
	GoddessCompetitionRedPackRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.GoddessCompetitionRankViewRes, self._refreshView, self)

	self._activityId = self:getFirstParam()
	self._itemScrollListDic = {}

	GoddessCompetitionAgent.instance:sendPM_GoddessCompetitionRedPackRankViewReq(self._activityId)
end

function GoddessCompetitionRedPackRankView:onExit()
	GoddessCompetitionRedPackRankView.super.onExit(self)
	self._rankTableList:dispose()

	for i, v in pairs(self._itemScrollListDic) do
		v:dispose()
	end

	self._itemScrollListDic = nil
end

function GoddessCompetitionRedPackRankView:_refreshView()
	local rankInfo, myRank, myScore = GoddessCompetitionModel.instance:getRankInfo()

	rankInfo = rankInfo or {}

	self._rankTableList:reloadData(rankInfo)

	if #rankInfo > 0 then
		GameUtil.SetActive(self._emptyGo, false)
	else
		GameUtil.SetActive(self._emptyGo, true)
	end

	local prizCfgs = GoddessCompetitionConfig.instance:getRedPackRankCfgs(self._activityId)
	local prizeStrArr = {}

	for i, v in pairs(prizCfgs) do
		if myRank >= v.rankRange[1] and myRank <= v.rankRange[2] then
			prizeStrArr = string.split(v.prize, "#")
		end
	end

	self._txtMyRank.text = checknumber(myRank) > 0 and myRank or lang("未上榜")
	self._txtMyScore.text = myScore

	if #prizeStrArr <= 0 then
		GameUtil.SetActive(self._prize, false)
	else
		self._prizeTableList:reloadData(prizeStrArr)
		GameUtil.SetActive(self._prize, true)
	end
end

function GoddessCompetitionRedPackRankView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtArea = goutil.findChildTextComponent(go, "txtArea")
	local itemListGo = goutil.findChild(go, "itemTableView")
	local rankInfo = data

	txtRank.text = rankInfo.rank

	GameUtil.SetActive(imgChangeRank, rankInfo.rank <= 3 and rankInfo.rank > 0)

	if rankInfo.rank <= 3 and rankInfo.rank > 0 then
		imgChangeRank:SetState(rankInfo.rank - 1)
		GameUtil.SetActive(imgChangeRank, true)
		GameUtil.SetActive(txtRank, false)
	else
		GameUtil.SetActive(imgChangeRank, false)
		GameUtil.SetActive(txtRank, true)
	end

	HeadItemController.instance:setHeadCellByInfo(imgIcon, rankInfo.headInfo, true)

	txtName.text = rankInfo.headInfo.userName
	txtScore.text = rankInfo.value
	txtArea.text = rankInfo.headInfo.areaName

	local prizCfgs = GoddessCompetitionConfig.instance:getRedPackRankCfgs(self._activityId)
	local prizeStrArr = {}

	for i, v in pairs(prizCfgs) do
		if v.rankRange[1] <= rankInfo.rank and v.rankRange[2] >= rankInfo.rank then
			prizeStrArr = string.split(v.prize, "#")
		end
	end

	if itemListGo and self._itemTableCell then
		if not self._itemScrollListDic[go] then
			local prizeScrollList = ScrollerList.create(itemListGo, self._itemTableCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[go] = self._itemScrollListDic[go]

			self._itemScrollListDic[go]:reloadData(prizeStrArr)
			self._itemScrollListDic[go]:dragNotifyParent()
		end
	end
end

function GoddessCompetitionRedPackRankView:_clearCell(cell)
	local go = cell.gameObject

	HeadItemController.instance:resetHeadCell(go)

	local prizeScrollList = self._itemScrollListDic[go]

	if prizeScrollList then
		prizeScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function GoddessCompetitionRedPackRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

function GoddessCompetitionRedPackRankView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function GoddessCompetitionRedPackRankView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

return GoddessCompetitionRedPackRankView
