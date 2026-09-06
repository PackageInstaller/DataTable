-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/view/DoushouqirankView.lua

module("logic.extensions.doushouqi.view.DoushouqirankView", package.seeall)

local DoushouqirankView = class("DoushouqirankView", ViewComponent)

DoushouqirankView.TabType = {
	WeiHuqi = 2,
	Doushouqi = 1
}
DoushouqirankView.TabConfig = {
	{
		leafId = 0,
		name = "斗兽棋",
		tabId = DoushouqirankView.TabType.Doushouqi,
		rootId = DoushouqiController.ChessType.Doushouqi
	},
	{
		leafId = 0,
		name = "围虎棋",
		tabId = DoushouqirankView.TabType.WeiHuqi,
		rootId = DoushouqiController.ChessType.Weihuqi
	}
}

function DoushouqirankView:bindEvents()
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function DoushouqirankView:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function DoushouqirankView:buildUI()
	DoushouqirankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("title/txtTitle")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtMyTip = self:getTxt("right/myRank/txtTip")
	self._goEmpty = self:getGo("right/goEmpty")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._rankListViewGo = self:getGo("right/rankListView")
	self._rankCellGo = self:getGo("right/rankCell")
	self._tabScrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._rankScrollerList = ScrollerList.create(self._rankListViewGo, self._rankCellGo, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._myRankGo = self:getGo("right/myRank")
	self._txtTip = self:getTxt("right/myRank/txtTip")
	self._myRewardGoEmptyGo = self:getGo("right/myRank/goEmpty")
	self._rewardtableviewGo = self:getGo("right/myRank/tableview")
	self._rewardtablecellGo = self:getGo("right/myRank/tablecell")
	self._scrollerList = ScrollerList.create(self._rewardtableviewGo, self._rewardtablecellGo, GameUtil.handler(self._updateMyRewardCell, self), GameUtil.handler(self._clearMyRewardCell, self))
	self._txtScore = self:getTxt("right/myRank/txtScore")
end

function DoushouqirankView:onExit()
	self._tabScrollerList:dispose()
	self._rankScrollerList:dispose()
	self._scrollerList:dispose()
end

function DoushouqirankView:onEnter()
	DoushouqirankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BeastFightingChessRankRes, self._onBeastFightingChessRankRes, self)

	self._activityId = self:getFirstParam()
	self._curRootId = nil
	self._curLeafId = nil
	self._unFold = true

	self:_updateUI()
end

function DoushouqirankView:_onClickbtnClose()
	self:close()
end

function DoushouqirankView:_updateUI()
	self:_updateTab()
end

function DoushouqirankView:_updateTab()
	self:_onClickTabCell(1, 1)
end

function DoushouqirankView:_updateTabCell(view, cell, data, tag)
	local root = goutil.findChild(cell, "root")
	local txtRoot = goutil.findChildTextComponent(root, "txt")
	local changeRoot = root:GetComponent(ComponentType.UIChangeGroup)
	local leaf = goutil.findChild(cell, "leaf")
	local txtLeaf = goutil.findChildTextComponent(leaf, "txt")
	local changeLeaf = leaf:GetComponent(ComponentType.UIChangeGroup)

	txtRoot.text = data.name
	txtLeaf.text = data.name

	if data.leafId == 0 then
		changeRoot:SetState(data.rootId == self._curRootId and 0 or 1)
		goutil.setActive(root, true)
		goutil.setActive(leaf, false)
	else
		changeLeaf:SetState(data.leafId == self._curLeafId and 0 or 1)
		goutil.setActive(root, false)
		goutil.setActive(leaf, true)
	end

	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	btn:AddClickListener(function()
		self:_onClickTabCell(data.rootId, data.leafId)
	end)
end

function DoushouqirankView:_clearTabCell(cell)
	return
end

function DoushouqirankView:_updateRankCell(view, cell, data, tag)
	local goHeadIcon = goutil.findChild(cell.gameObject, "headIcon")
	local imgChangeImgRank = goutil.findChild(cell.gameObject, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtRankGo = goutil.findChild(cell.gameObject, "txtRank")
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")
	local txtScore = goutil.findChildTextComponent(cell.gameObject, "txtScore")
	local tableview = goutil.findChild(cell.gameObject, "tableview")
	local tablecell = goutil.findChild(cell.gameObject, "tablecell")
	local rewardScroll = self:_getRewardScrollList(tableview, tablecell)

	HeadItemController.instance:resetHeadCell(goHeadIcon)
	HeadItemController.instance:setHeadCellByInfo(goHeadIcon, data.headInfo, true)

	local isTop3 = data.rank <= 3

	if isTop3 then
		imgChangeImgRank:SetState(data.rank - 1)
		goutil.setActive(imgChangeImgRank.gameObject, true)
		goutil.setActive(txtRankGo, false)
	else
		goutil.setActive(txtRankGo, true)
		goutil.setActive(imgChangeImgRank.gameObject, false)

		txtRank.text = data.rank
	end

	txtName.text = data.headInfo.userName
	txtScore.text = data.value

	local cfg = DoushouqiConfig.instance:getRankPrizeCfg(self._activityId, self._curRootId, data.rank)

	rewardScroll:reloadData((cfg or nil) and string.split(cfg.prize, "#"))
end

function DoushouqirankView:_clearRankCell(cell)
	local goHeadIcon = goutil.findChild(cell.gameObject, "headIcon")

	MaterialMgr.resetAll(goHeadIcon)
	HeadItemController.instance:resetHeadCell(goHeadIcon)

	local tableview = goutil.findChild(cell.gameObject, "tableview")

	self:_disposeRewardScrollList(tableview)
end

function DoushouqirankView:_onClickTabCell(rootId, leafId)
	if rootId == self._curRootId then
		if leafId == 0 then
			self._unFold = not self._unFold
		elseif leafId == self._curLeafId then
			return
		else
			self._curLeafId = leafId
		end
	else
		self._curRootId = rootId
		self._curLeafId = 0
		self._unFold = true
	end

	self:_updateTabList()
	BeastFightingChessAgent.instance:sendBeastFightingChessRankReq(self._activityId, rootId)
end

function DoushouqirankView:_updateTabList()
	local tabList = {}

	for i, tabData in ipairs(DoushouqirankView.TabConfig) do
		if tabData.leafId == 0 then
			table.insert(tabList, tabData)
		elseif self._unFold and self._curRootId == tabData.rootId then
			table.insert(tabList, tabData)
		end
	end

	self._tabScrollerList:reloadData(tabList)
end

function DoushouqirankView:_onBeastFightingChessRankRes(msg)
	self._rankInfo = msg

	self:_updateRankView()
end

function DoushouqirankView:_updateRankView()
	local info = self._rankInfo

	if not info then
		return
	end

	local myRank = info.myRank

	self._txtMyRank.text = myRank <= 0 and "未上榜" or string.format("第%s名", myRank)

	if info then
		if not info.rankList then
			local rankList = {}

			self._rankScrollerList:reloadData(rankList)

			local myScore = 0
			local userId = checknumber(RoleModel.instance:getUserId())

			for i, v in ipairs(rankList) do
				if checknumber(v.headInfo.userId) == userId then
					myScore = v.value

					break
				end
			end

			if myScore == 0 then
				local baseInfo = DoushouqiModel.instance:getTypeInfo(info.typeId)

				myScore = baseInfo.score
			end

			self._txtScore.text = myScore

			goutil.setActive(self._goEmpty, #rankList <= 0)
			self:_updateMyRewardPreview(info.myRank)
		end
	end
end

function DoushouqirankView:_updateMyRewardPreview(myRank)
	local cfg = DoushouqiConfig.instance:getRankPrizeCfg(self._activityId, self._curRootId, myRank)

	goutil.setActive(self._myRewardGoEmptyGo, not cfg)

	if cfg then
		local list = string.split(cfg.prize, "#")

		self._scrollerList:reloadData(list)
	else
		self._scrollerList:reloadData(nil)
	end
end

function DoushouqirankView:_updateMyRewardCell(view, cell, data, tag)
	MaterialMgr.resetAll(cell.gameObject)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function DoushouqirankView:_clearMyRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function DoushouqirankView:_getRewardScrollList(tableview, tablecell)
	self._rewardSrolls = self._rewardSrolls or {}

	if not self._rewardSrolls[tableview] then
		local scroller

		self._rewardSrolls[tableview] = ScrollerList.create(tableview, tablecell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	end

	return self._rewardSrolls[tableview]
end

function DoushouqirankView:_disposeRewardScrollList(tableview)
	if self._rewardSrolls[tableview] then
		self._rewardSrolls[tableview]:dispose()

		self._rewardSrolls[tableview] = nil
	end
end

function DoushouqirankView:_updateRewardCell(view, cell, data, tag)
	MaterialMgr.resetAll(cell.gameObject)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function DoushouqirankView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return DoushouqirankView
