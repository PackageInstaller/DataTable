-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontrialrankView.lua

module("logic.extensions.dragontrial.view.DragontrialrankView", package.seeall)

local DragontrialrankView = class("DragontrialrankView", ViewComponent)

function DragontrialrankView:ctor()
	DragontrialrankView.super.ctor(self)
end

function DragontrialrankView:buildUI()
	DragontrialrankView.super.buildUI(self)

	self.btnClose = self:getBtn("Close")
	self._txtName = self:getTxt("right/description/txtName")
	self._txtFamily = self:getTxt("right/description/txtFamily")
	self._txtAttribute = self:getTxt("right/description/txtAttribute")
	self._txtWin = self:getTxt("right/description/txtWin")
	self._txtWinRate = self:getTxt("right/description/txtWinRate")
	self.tableview = self:getGo("tableview")
	self.rootCell = self:getGo("rootCell")
	self.leafCell = self:getGo("leafCell")
	self.scrollList = ScrollerList.create(self.tableview, {
		self.rootCell,
		self.leafCell
	}, GameUtil.handler(self._upateCell, self))

	self.scrollList:regGetTagByIdx(GameUtil.handler(self.getTagByData, self))
	self.scrollList:regGetCellSize(GameUtil.handler(self.getCellSize, self))

	self.goEmpty = self:getGo("right/goEmpty")
	self.myRank = self:getGo("right/myRank")
	self.txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self.rankListView = self:getGo("right/rankListView")
	self.rankCell = self:getGo("right/rankCell")
	self.rankScrollList = ScrollerList.create(self.rankListView, self.rankCell, GameUtil.handler(self._upateRankCell, self))

	self.rankScrollList:regGetCellSize(GameUtil.handler(self.getRankCellSize, self))
	self:initTabList()

	self._txtTip = goutil.findChildTextComponent(self.mainGO, "right/myRank/txtTip")
end

function DragontrialrankView:bindEvents()
	DragontrialrankView.super.bindEvents(self)
	self.btnClose:AddClickListener(self.close, self)
end

function DragontrialrankView:unbindEvents()
	DragontrialrankView.super.unbindEvents(self)
	self.btnClose:RemoveClickListener()
end

function DragontrialrankView:initTabList()
	self._tabList = DragontrialConfig.instance:getRankCfgs()
end

function DragontrialrankView:onEnter()
	DragontrialrankView.super.onEnter(self)
	GlobalDispatcher:addListener(DragontrialController.PM_DragonTrialViewRankRes, self._updateRankList, self)

	local params = self:getOpenParam()

	self:initTabList()

	if params then
		self.rootIdx = params[1]
		self.leafIdx = params[2] or 1
	else
		for _, list in ipairs(self._tabList) do
			for _, v in ipairs(list) do
				if v.leaf == 0 and not self.rootIdx then
					self.rootIdx = v.idx

					break
				end
			end
		end

		self.leafIdx = 1
	end

	self:updateTabList()
end

function DragontrialrankView:onExit()
	DragontrialrankView.super.onExit(self)
	GlobalDispatcher:removeListener(DragontrialController.PM_DragonTrialViewRankRes, self._updateRankList, self)
	self.scrollList:dispose()
	self.rankScrollList:dispose()
end

function DragontrialrankView:getTagByData(data, idx)
	return data.tag
end

function DragontrialrankView:getCellSize(view, idx)
	local list = self.scrollList:getData()
	local data = list[idx + 1]

	if data.tag == 1 then
		return 192, 70
	else
		return 192, 50
	end
end

function DragontrialrankView:getRankCellSize(view, idx)
	return 1092, 115
end

function DragontrialrankView:_upateCell(view, cell, data, tag)
	if data.tag == 1 then
		self:updateRootCell(view, cell, data, tag)
	else
		self:updateLeafCell(view, cell, data, tag)
	end
end

function DragontrialrankView:updateRootCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	GameUtil.setUIImageSpriteIdx(cell, (data.idx == self.rootIdx or nil) and 1)

	txtName.text = data.name

	GameUtil.addClickHandler(cell, GameUtil.handler(self.onRootClick, self, data))
end

function DragontrialrankView:updateLeafCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local imgSelected = goutil.findChild(cell, "imgSelected")

	txtName.text = data.name

	local isSelect = data.leaf == self.leafIdx

	GameUtil.SetActive(imgSelected, isSelect)
	GameUtil.addClickHandler(cell, GameUtil.handler(self.onLeafClick, self, data))
end

function DragontrialrankView:onRootClick(data)
	if data.idx == self.rootIdx and self.leafIdx > 0 then
		self.leafIdx = 0
	else
		self.rootIdx = data.idx
		self.leafIdx = 1

		self:updateTabList()
	end
end

function DragontrialrankView:onLeafClick(data)
	self.leafIdx = data.leaf

	self.scrollList:refresh()
	self:sendGetList()
end

function DragontrialrankView:updateTabList()
	local rootIdx = self.rootIdx
	local leafIdx = self.leafIdx
	local list = {}

	for i, v in ipairs(self._tabList) do
		local rootNode = v[1]

		rootNode.tag = 1

		table.insert(list, rootNode)

		if rootIdx == rootNode.idx and leafIdx > 0 then
			for j = 2, #v do
				local leafNode = v[j]

				leafNode.tag = 2

				table.insert(list, leafNode)
			end
		end
	end

	self.scrollList:reloadData(list)
	self:sendGetList()
end

function DragontrialrankView:sendGetList()
	local root = self.rootIdx
	local leaf = self.leafIdx

	self:_updateRankList()

	if not DragontrialModel.instance:getIsDataInit(root, leaf) then
		DragontrialController.instance:sendPM_DragonTrialViewRankReq(root, leaf)
	end
end

function DragontrialrankView:_updateRankList()
	local root = self.rootIdx
	local leaf = self.leafIdx
	local rankMo = DragontrialModel.instance:getRankMo(self.rootIdx, self.leafIdx) or {}

	self.rankScrollList:reloadData((rankMo or nil) and (rankMo.rankList or {}))
	GameUtil.SetActive(self.goEmpty, not rankMo or rankMo.rankList == nil or #rankMo.rankList == 0)

	self.txtMyRank.text = rankMo and checknumber(rankMo.myRank) > 0 and (checknumber(rankMo.myRank) > 1000 and "1000+" or rankMo.myRank) or lang("未上榜")

	local cfg = DragontrialConfig.instance:getRankCfg(root, leaf) or {}

	self._txtTip.text = cfg.desc
end

function DragontrialrankView:getCfgByRootAndLeaf(root, leaf)
	return
end

function DragontrialrankView:_upateRankCell(view, cell, data, tag)
	local imgIcon = goutil.findChild(cell, "imgIcon")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtFamily = goutil.findChildTextComponent(cell, "txtFamily")
	local txtPassTime = goutil.findChildTextComponent(cell, "txtPassTime")
	local proxy = HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if data.headInfo.userId then
				self:onHeadClick(data.headInfo.userId, imgIcon)
			end
		end)
	end

	txtRank.text = data.rank
	txtName.text = data.headInfo.userName
	txtPassTime.text = data.damage
end

function DragontrialrankView:onPlayResult(btlResult)
	if btlResult == nil then
		FloatWordMgr.instance:show("录像不存在")
	else
		BattleFacade.instance:onViewUserFightMonsterBtlResult(btlResult)
	end
end

function DragontrialrankView:onHeadClick(userId, imgIcon)
	print("onHeadClick")
	FriendController.instance:showInfoView(userId, imgIcon)
end

return DragontrialrankView
