-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/TLChallengerankView.lua

module("logic.extensions.rank.view.TLChallengerankView", package.seeall)

local TLChallengerankView = class("TLChallengerankView", ViewComponent)

function TLChallengerankView:ctor()
	TLChallengerankView.super.ctor(self)
end

function TLChallengerankView:buildUI()
	TLChallengerankView.super.buildUI(self)

	self.btnClose = self:getGo("Close")
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

function TLChallengerankView:bindEvents()
	TLChallengerankView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function TLChallengerankView:unbindEvents()
	TLChallengerankView.super.unbindEvents(self)
end

function TLChallengerankView:destroyUI()
	TLChallengerankView.super.destroyUI(self)
end

function TLChallengerankView:initTabList()
	local list = TimeLimitedConfig.instance:getChallengeRanks()

	self._tabList = {}

	for _, v in ipairs(list) do
		if v[1] then
			local challengeId = TimeLimitedConfig.instance:getChallengeIdByRankType(v[1].idx)

			if TLChallengeController.instance:isInOpenTime(challengeId) then
				table.insert(self._tabList, v)
			end
		end
	end
end

function TLChallengerankView:onEnter()
	TLChallengerankView.super.onEnter(self)

	local params = self:getOpenParam()

	self:initTabList()

	if params then
		self.rootIdx = params[1]
		self.leafIdx = params[2] or 1
	else
		self.rootIdx = self._tabList[1].idx
		self.leafIdx = 1
	end

	self:updateTabList()
	GlobalDispatcher:addListener(GlobalNotify.RankDataGet, self._updateRankList, self)
end

function TLChallengerankView:onEnterFinished()
	TLChallengerankView.super.onEnterFinished(self)
end

function TLChallengerankView:onExit()
	TLChallengerankView.super.onExit(self)
	RankModel.instance:onReset()
	GlobalDispatcher:removeListener(GlobalNotify.RankDataGet, self._updateRankList, self)
	self.scrollList:dispose()
	self.rankScrollList:dispose()
end

function TLChallengerankView:onExitFinished()
	TLChallengerankView.super.onExitFinished(self)
end

function TLChallengerankView:getTagByData(data, idx)
	return data.tag
end

function TLChallengerankView:getCellSize(view, idx)
	local list = self.scrollList:getData()
	local data = list[idx + 1]

	if data.tag == 1 then
		return 192, 70
	else
		return 192, 50
	end
end

function TLChallengerankView:getRankCellSize(view, idx)
	return 1092, 115
end

function TLChallengerankView:_upateCell(view, cell, data, tag)
	if data.tag == 1 then
		self:updateRootCell(view, cell, data, tag)
	else
		self:updateLeafCell(view, cell, data, tag)
	end
end

function TLChallengerankView:updateRootCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	GameUtil.setUIImageSpriteIdx(cell, (data.idx == self.rootIdx or nil) and 1)

	txtName.text = data.name

	GameUtil.addClickHandler(cell, GameUtil.handler(self.onRootClick, self, data))
end

function TLChallengerankView:updateLeafCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local imgSelected = goutil.findChild(cell, "imgSelected")

	txtName.text = data.name

	local isSelect = data.leaf == self.leafIdx

	GameUtil.SetActive(imgSelected, isSelect)
	GameUtil.addClickHandler(cell, GameUtil.handler(self.onLeafClick, self, data))
end

function TLChallengerankView:onRootClick(data)
	if data.idx == self.rootIdx and self.leafIdx > 0 then
		self.leafIdx = 0
	else
		self.rootIdx = data.idx
		self.leafIdx = 1

		self:updateTabList()
	end
end

function TLChallengerankView:onLeafClick(data)
	self.leafIdx = data.leaf

	self.scrollList:refresh()
	self:sendGetList()
end

function TLChallengerankView:updateTabList()
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

function TLChallengerankView:sendGetList()
	local root = self.rootIdx
	local leaf = self.leafIdx

	self:_updateRankList()

	if not RankModel.instance:getIsDataInit(root, leaf) then
		RankModel.instance:sendReqRankData(root, leaf)
	end
end

function TLChallengerankView:_updateRankList()
	local root = self.rootIdx
	local leaf = self.leafIdx
	local rankMo = RankModel.instance:getRankMo(self.rootIdx, self.leafIdx) or {}

	self.rankScrollList:reloadData(rankMo.rankList or {})
	GameUtil.SetActive(self.goEmpty, rankMo.rankList == nil or #rankMo.rankList == 0)

	self.txtMyRank.text = rankMo and checknumber(rankMo.myRank) > 0 and rankMo.myRank or lang("未上榜")

	local cfg = TimeLimitedConfig.instance:getChallengeRankCfgByRootAndLeat(root, leaf) or {}

	self._txtFamily.text = lang("家族")

	if checknumber(cfg.classType) == GameEnum.RankClassType.GainTime then
		self._txtAttribute.text = lang("兑换时间")

		if cfg.idx == 17 then
			self._txtAttribute.text = lang("获得时间")
		end
	elseif checknumber(cfg.classType) == GameEnum.RankClassType.Damage then
		self._txtAttribute.text = lang("造成伤害")
	elseif checknumber(cfg.classType) == GameEnum.RankClassType.TotalScore then
		self._txtAttribute.text = lang("累积总分")
		self._txtFamily.text = lang("区服")
	elseif checknumber(cfg.classType) == GameEnum.RankClassType.DailyScore then
		self._txtAttribute.text = lang("单次最高")
		self._txtFamily.text = lang("区服")
	end

	self._txtTip.text = cfg.desc
end

function TLChallengerankView:getCfgByRootAndLeaf(root, leaf)
	return
end

function TLChallengerankView:_upateRankCell(view, cell, data, tag)
	local imgIcon = goutil.findChild(cell, "imgIcon")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtFamily = goutil.findChildTextComponent(cell, "txtFamily")
	local txtDesc = goutil.findChildTextComponent(cell, "txtPassTime")
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

	GameUtil.rmClickHandler(imgIcon)

	local root = self.rootIdx
	local leaf = self.leafIdx
	local cfg = TimeLimitedConfig.instance:getChallengeRankCfgByRootAndLeat(root, leaf)

	if checknumber(cfg.classType) == GameEnum.RankClassType.GainTime then
		txtFamily.text = not string.nilorempty(data.familyName) and data.familyName or lang("无")

		local time = GameUtil.time2date(checknumber(data.gainTime) / 1000)

		txtDesc.text = langPara("%d月%d日 %02d:%02d:%02d", time.month, time.day, time.hour, time.min, time.sec)
	elseif checknumber(cfg.classType) == GameEnum.RankClassType.Damage then
		txtFamily.text = not string.nilorempty(data.familyName) and data.familyName or lang("无")
		txtDesc.text = data.damage

		if data.btlResult then
			-- block empty
		end
	elseif checknumber(cfg.classType) == GameEnum.RankClassType.TotalScore then
		txtFamily.text = data.areaName
		txtDesc.text = data.score
	elseif checknumber(cfg.classType) == GameEnum.RankClassType.DailyScore then
		txtFamily.text = data.areaName
		txtDesc.text = data.score
	end
end

function TLChallengerankView:onPlayResult(btlResult)
	if btlResult == nil then
		FloatWordMgr.instance:show("录像不存在")
	else
		BattleFacade.instance:onViewUserFightMonsterBtlResult(btlResult)
	end
end

function TLChallengerankView:onHeadClick(userId, imgIcon)
	print("onHeadClick")
	FriendController.instance:showInfoView(userId, imgIcon)
end

return TLChallengerankView
