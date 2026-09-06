-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbreakformation/view/NewBreakFormationRankView.lua

module("logic.extensions.newbreakformation.view.NewBreakFormationRankView", package.seeall)

local NewBreakFormationRankView = class("NewBreakFormationRankView", ViewComponent)

function NewBreakFormationRankView:ctor()
	NewBreakFormationRankView.super.ctor(self)
end

function NewBreakFormationRankView:unbindEvents()
	NewBreakFormationRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function NewBreakFormationRankView:bindEvents()
	NewBreakFormationRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function NewBreakFormationRankView:buildUI()
	NewBreakFormationRankView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._rankTableView = self:getGo("right/rankScrollRect")
	self._rankTableCell = self:getGo("right/cell")
	self._rankTableList = ScrollerList.create(self._rankTableView, self._rankTableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._itemScrollercell = self:getGo("right/itemScrollercell")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._emptyGo = self:getGo("right/goEmpty")
	self._txtRankDesc = self:getTxt("right/myRank/txtTip")
end

function NewBreakFormationRankView:destroyUI()
	NewBreakFormationRankView.super.destroyUI(self)
	self._rankTableList:dispose()
end

function NewBreakFormationRankView:onExit()
	NewBreakFormationRankView.super.onExit(self)
	self._rankTableList:dispose()
end

function NewBreakFormationRankView:onEnter()
	NewBreakFormationRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_NewBreachFormationRankViewRes, self._refreshView, self)

	self._itemScrollListDic = {}
	self._seasonId = self:getFirstParam()

	NewBreachFormationAgent.instance:sendPM_NewBreachFormationRankViewReq(self._seasonId)

	local seasonCfg = NewBreakFormationConfig.instance:getSeasonCfg(self._seasonId)

	self._txtRankDesc.text = seasonCfg.rankDesc
end

function NewBreakFormationRankView:_refreshView()
	local list = NewBreakFormationModel.instance:getRankList(self._seasonId)

	self._rankTableList:reloadData(list)
	GameUtil.SetActive(self._emptyGo, #list <= 0)

	local myRank = NewBreakFormationModel.instance:getMyRank()

	self._txtMyRank.text = myRank > 0 and myRank or lang("未上榜")
end

function NewBreakFormationRankView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgHeadIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtTime = goutil.findChildTextComponent(go, "txtTime")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local itemScrollerview = goutil.findChild(go, "itemScrollerview")

	txtRank.text = data.rank

	GameUtil.SetActive(imgChangeRank, data.rank <= 3 and data.rank > 0)

	if data.rank <= 3 and data.rank > 0 then
		imgChangeRank:SetState(data.rank - 1)
		GameUtil.SetActive(imgChangeRank, true)
		GameUtil.SetActive(txtRank, false)
	else
		GameUtil.SetActive(imgChangeRank, false)
		GameUtil.SetActive(txtRank, true)
	end

	local proxy = HeadItemController.instance:setHeadCellByInfo(imgHeadIcon, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if data.headInfo.userId then
				self:onHeadClick(data.headInfo.userId, imgHeadIcon)
			end
		end)
	end

	txtName.text = data.headInfo.userName
	txtScore.text = data.score

	local date = GameUtil.time2date(checknumber(data.time) / 1000)

	txtTime.text = langPara("%d月%d日 %02d:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)

	local rankCfg = NewBreakFormationConfig.instance:getRankCfg(self._seasonId, data.rank)
	local prizeStr = ""

	if rankCfg then
		prizeStr = rankCfg.prize
	end

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

function NewBreakFormationRankView:_clearCell(cell)
	local go = cell.gameObject
	local imgHeadIcon = goutil.findChild(go, "imgHeadIcon")

	HeadItemController.instance:resetHeadCell(imgHeadIcon)

	local itemScrollList = self._itemScrollListDic[go]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function NewBreakFormationRankView:_updateItemCell(view, cell, prizeStr, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, go)
end

function NewBreakFormationRankView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function NewBreakFormationRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return NewBreakFormationRankView
