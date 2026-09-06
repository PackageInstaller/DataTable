-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyngarde/view/LuyngardeRankView.lua

module("logic.extensions.luyngarde.view.LuyngardeRankView", package.seeall)

local LuyngardeRankView = class("LuyngardeRankView", ViewComponent)

function LuyngardeRankView:ctor()
	LuyngardeRankView.super.ctor(self)
end

function LuyngardeRankView:unbindEvents()
	LuyngardeRankView.super.unbindEvents(self)
end

function LuyngardeRankView:bindEvents()
	LuyngardeRankView.super.bindEvents(self)
end

function LuyngardeRankView:buildUI()
	LuyngardeRankView.super.buildUI(self)

	self._ranktableGo = goutil.findChild(self.mainGO, "rankScrollRect")
	self._ranktableCell = goutil.findChild(self.mainGO, "cell")
	self._rankTableList = ScrollerList.create(self._ranktableGo, self._ranktableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyGo = goutil.findChild(self.mainGO, "goEmpty")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "myRank/txtMyRank")
	self._txtMyScore = self:getTxt("myRank/txtMyScore")
	self._itemTableCell = self:getGo("itemTableCell")
	self._txtScore1 = self:getGo("subTitle/txtScore1")
	self._txtScore2 = self:getGo("subTitle/txtScore2")
	self._txtScore5 = self:getGo("subTitle/txtScore5")
	self._txtScore4 = self:getGo("subTitle/txtScore4")
	self._myTitle1 = self:getGo("myRank/myTitle1")
	self._myTitle2 = self:getGo("myRank/myTitle2")
	self._myTitle4 = self:getGo("myRank/myTitle4")
	self._myTitle5 = self:getGo("myRank/myTitle5")
end

function LuyngardeRankView:onExit()
	LuyngardeRankView.super.onExit(self)
	self._rankTableList:dispose()

	for i, v in pairs(self._itemScrollListDic) do
		v:dispose()
	end

	self._itemScrollListDic = nil
end

function LuyngardeRankView:onEnter()
	LuyngardeRankView.super.onEnter(self)

	self._activityId = 466001
	self._typeId = checknumber(self:getFirstParam())

	self.addGEvent(self, GlobalNotify.LuyngardeUpdateRankInfoList, self._refreshView, self)

	self._itemScrollListDic = {}
	self._cfgs1 = LuyngardeConfig.instance:getChapter2RankPrizeCfgs(self._activityId, 1)
	self._cfgs2 = LuyngardeConfig.instance:getChapter2RankPrizeCfgs(self._activityId, 2)
	self._cfgs4 = LuyngardeConfig.instance:getChapter3RankPrizeCfgs(self._activityId)
	self._cfgs5 = LuyngardeConfig.instance:getChapter4RankPrizeCfgs(self._activityId)

	goutil.setActive(self._txtScore1, false)
	goutil.setActive(self._myTitle1, false)
	goutil.setActive(self._txtScore2, false)
	goutil.setActive(self._myTitle2, false)
	goutil.setActive(self._txtScore4, false)
	goutil.setActive(self._myTitle4, false)
	goutil.setActive(self._txtScore5, false)
	goutil.setActive(self._myTitle5, false)

	if self._typeId == 1 then
		LuyngardeController.instance:getChapter2BossRankInfo(self._activityId, 1)
		goutil.setActive(self._txtScore1, true)
		goutil.setActive(self._myTitle1, true)
	elseif self._typeId == 2 then
		LuyngardeController.instance:getChapter2BossRankInfo(self._activityId, 2)
		goutil.setActive(self._txtScore2, true)
		goutil.setActive(self._myTitle2, true)
	elseif self._typeId == 4 then
		LuyngardeController.instance:getChapter3ExploreRankInfo(self._activityId)
		goutil.setActive(self._txtScore4, true)
		goutil.setActive(self._myTitle4, true)
	elseif self._typeId == 5 then
		LuyngardeController.instance:getChapter4FinalRankInfo(self._activityId)
		goutil.setActive(self._txtScore5, true)
		goutil.setActive(self._myTitle5, true)
	end
end

function LuyngardeRankView:_refreshView()
	local info = {}

	self._txtMyScore.text = ""

	if self._typeId == 1 then
		info = LuyngardeModel.instance:getChapter2RankInfo(self._activityId, 1)
		self._txtMyScore.text = checknumber(info.personalDamage)
	elseif self._typeId == 2 then
		info = LuyngardeModel.instance:getChapter2RankInfo(self._activityId, 2)
		self._txtMyScore.text = checknumber(info.maxDamage)
	elseif self._typeId == 4 then
		info = LuyngardeModel.instance:getChapter3RankInfo(self._activityId)
		self._txtMyScore.text = checknumber(info.score)
	elseif self._typeId == 5 then
		info = LuyngardeModel.instance:getChapter4RankInfo(self._activityId)
		self._txtMyScore.text = checknumber(info.minLeftHp)

		if info.minLeftHp <= 0 then
			self._txtMyScore.text = "未有记录"
		end
	end

	local myRank = info.myRank

	if not info.rankInfos then
		self._rankTableList:reloadData(info.rankInfos)

		if #info.rankInfos > 0 then
			GameUtil.SetActive(self._emptyGo, false)
		else
			GameUtil.SetActive(self._emptyGo, true)
		end

		self._txtMyRank.text = checknumber(myRank) > 0 and myRank or lang("未上榜")
	end
end

function LuyngardeRankView:_updateCell(view, cell, data, tag)
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

	local prizCfgs = {}

	if self._typeId == 1 then
		prizCfgs = self._cfgs1
	elseif self._typeId == 2 then
		prizCfgs = self._cfgs2
	elseif self._typeId == 4 then
		prizCfgs = self._cfgs4
	elseif self._typeId == 5 then
		prizCfgs = self._cfgs5
	end

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

function LuyngardeRankView:_clearCell(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "imgHeadIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)

	local prizeScrollList = self._itemScrollListDic[go]

	if prizeScrollList then
		prizeScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function LuyngardeRankView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function LuyngardeRankView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

return LuyngardeRankView
