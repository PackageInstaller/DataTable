-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckydraw/view/LuckydrawtimestaterankView.lua

module("logic.extensions.luckydraw.view.LuckydrawtimestaterankView", package.seeall)

local LuckydrawtimestaterankView = class("LuckydrawtimestaterankView", ViewComponent)

LuckydrawtimestaterankView.TabType = {
	Dajiang = 1
}
LuckydrawtimestaterankView.TabConfig = {
	{
		leafId = 0,
		name = "大奖名单",
		rootId = 1,
		tabId = LuckydrawtimestaterankView.TabType.Dajiang
	}
}

function LuckydrawtimestaterankView:bindEvents()
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function LuckydrawtimestaterankView:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function LuckydrawtimestaterankView:buildUI()
	LuckydrawtimestaterankView.super.buildUI(self)

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
	self._txtScore = self:getTxt("right/myRank/txtScore")
end

function LuckydrawtimestaterankView:onExit()
	self._tabScrollerList:dispose()
	self._rankScrollerList:dispose()
end

function LuckydrawtimestaterankView:onEnter()
	LuckydrawtimestaterankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.LuckyDrawRankViewRes, self._onGetInfo, self)

	self._activityId = self:getFirstParam()
	self._curRootId = nil
	self._curLeafId = nil
	self._unFold = true

	self:_updateUI()
end

function LuckydrawtimestaterankView:_onClickbtnClose()
	self:close()
end

function LuckydrawtimestaterankView:_updateUI()
	self:_updateTab()
end

function LuckydrawtimestaterankView:_updateTab()
	self:_onClickTabCell(1, 1)
end

function LuckydrawtimestaterankView:_updateTabCell(view, cell, data, tag)
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

function LuckydrawtimestaterankView:_clearTabCell(cell)
	return
end

function LuckydrawtimestaterankView:_updateRankCell(view, cell, data, tag)
	local goHeadIcon = goutil.findChild(cell.gameObject, "headIcon")
	local imgChangeImgRank = goutil.findChild(cell.gameObject, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtRankGo = goutil.findChild(cell.gameObject, "txtRank")
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")
	local txtScore = goutil.findChildTextComponent(cell.gameObject, "txtScore")
	local txtTime = goutil.findChildTextComponent(cell.gameObject, "txtTime")
	local tableview = goutil.findChild(cell.gameObject, "tableview")
	local tablecell = goutil.findChild(cell.gameObject, "tablecell")

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
	txtScore.text = data.headInfo.areaName
	txtTime.text = GameUtil.formatTimeStamp("%Y.%m.%d %H:%M:%S", checknumber(data.time) / 1000)
end

function LuckydrawtimestaterankView:_clearRankCell(cell)
	local goHeadIcon = goutil.findChild(cell.gameObject, "headIcon")

	MaterialMgr.resetAll(goHeadIcon)
	HeadItemController.instance:resetHeadCell(goHeadIcon)
end

function LuckydrawtimestaterankView:_onClickTabCell(rootId, leafId)
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

	if rootId == LuckydrawtimestaterankView.TabType.Dajiang then
		LuckyDrawAgent.instance:sendPM_LuckyDrawRankViewReq(self._activityId)
	end
end

function LuckydrawtimestaterankView:_updateTabList()
	local tabList = {}

	for i, tabData in ipairs(LuckydrawtimestaterankView.TabConfig) do
		if tabData.leafId == 0 then
			table.insert(tabList, tabData)
		elseif self._unFold and self._curRootId == tabData.rootId then
			table.insert(tabList, tabData)
		end
	end

	self._tabScrollerList:reloadData(tabList)
end

function LuckydrawtimestaterankView:_onGetInfo(msg)
	self._rankInfo = msg

	self:_updateRankView()
end

function LuckydrawtimestaterankView:_updateRankView()
	local info = self._rankInfo

	if not info then
		return
	end

	local myRank = info.myRank

	self._txtMyRank.text = myRank <= 0 and "未上榜" or string.format("第%s名", myRank)

	if info then
		if not info.recordList then
			local rankList = {}

			self._rankScrollerList:reloadData(rankList)
			goutil.setActive(self._goEmpty, #rankList <= 0)
		end
	end
end

return LuckydrawtimestaterankView
