-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalrankscoreView.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalrankscoreView", package.seeall)

local MartialcontestfinalrankscoreView = class("MartialcontestfinalrankscoreView", ViewComponent)

function MartialcontestfinalrankscoreView:ctor()
	MartialcontestfinalrankscoreView.super.ctor(self)
end

function MartialcontestfinalrankscoreView:unbindEvents()
	MartialcontestfinalrankscoreView.super.unbindEvents(self)
end

function MartialcontestfinalrankscoreView:bindEvents()
	MartialcontestfinalrankscoreView.super.bindEvents(self)
end

function MartialcontestfinalrankscoreView:buildUI()
	MartialcontestfinalrankscoreView.super.buildUI(self)

	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemScrollercell = goutil.findChild(self.mainGO, "rankCol/itemScrollercell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._txtMyValue = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyValue")
	self._myPrizeCol = goutil.findChild(self.mainGO, "tipsCol/myPrizeCol")
	self._myPrizeCol_itemScrollerview = goutil.findChild(self.mainGO, "tipsCol/myPrizeCol/itemScrollerview")
	self._myPrizeCol_itemScrollercell = goutil.findChild(self.mainGO, "tipsCol/myPrizeCol/itemScrollercell")
	self._myPrizeScrollList = ScrollerList.create(self._myPrizeCol_itemScrollerview, self._myPrizeCol_itemScrollercell, GameUtil.handler(self._updateMyPrizeItemCell, self), GameUtil.handler(self._clearMyPrizeItemCell, self))

	GameUtil.SetActive(self._myPrizeCol, false)

	self._txtTip1 = self:getTxt("tipsCol/txtTip1")
end

function MartialcontestfinalrankscoreView:onExit()
	MartialcontestfinalrankscoreView.super.onExit(self)
	self._rankScrollList:dispose()
	self._myPrizeScrollList:dispose()
end

function MartialcontestfinalrankscoreView:onEnter()
	MartialcontestfinalrankscoreView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._tabId = checknumber(params[2])
	self._tabCfg = MartialContestConfig.instance:getFinalsRankViewCfg(self._tabId)
	self._txtTip1.text = self._tabCfg.txtTips
	self._stepId = checknumber(self._tabCfg.param)
	self._zoneId = MartialContestController.instance:getCurZoneId(self._activityId)
	self._rankList = {}
	self._myRank = 0
	self._myValue = 0

	self.addGEvent(self, GlobalNotify.MCQualifierRankInfoRes, self._onMCQualifierRankInfoRes, self)
	MartialContestAgent.instance:sendPM_MCQualifierRankInfoReq(self._activityId, self._zoneId, self._stepId)
end

function MartialcontestfinalrankscoreView:_onMCQualifierRankInfoRes(msg)
	if msg.activityId ~= self._activityId then
		return
	end

	self._rankList = msg.rankList or {}
	self._myRank = msg.myRank
	self._myValue = "无"

	local userId = tostring(RoleModel.instance:getUserId())

	for i, v in ipairs(self._rankList) do
		if v.headInfo.userId == userId then
			self._myValue = v.value

			break
		end
	end

	self:_onUpdate()
end

function MartialcontestfinalrankscoreView:_getPrizesByRank(rank)
	if self._stepId == MartialContestEnum.Qualify_Step_Id then
		local cfg = MartialContestConfig.instance:getQualifierRankPrizeCfgByRank(self._activityId, rank)

		return cfg and cfg.prize
	else
		local cfg = MartialContestConfig.instance:getScoreRankPrizeCfgByRank(self._activityId, rank)

		return cfg and cfg.prize
	end
end

function MartialcontestfinalrankscoreView:_onUpdate()
	self._txtMyRank.text = self._myRank > 0 and self._myRank or "未上榜"
	self._txtMyValue.text = self._myValue

	local prizes = self:_getPrizesByRank(self._myRank)

	if not string.nilorempty(prizes) then
		local prizeStrArr = string.split(prizes, "#")

		self._myPrizeScrollList:reloadData(prizeStrArr)
		self._myPrizeScrollList:dragNotifyParent()
		GameUtil.SetActive(self._myPrizeCol, true)
	else
		GameUtil.SetActive(self._myPrizeCol, false)
		self._myPrizeScrollList:dispose()
	end

	GameUtil.SetActive(self._emptyGo, #self._rankList <= 0)
	self._rankScrollList:reloadData(self._rankList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
end

function MartialcontestfinalrankscoreView:_updateRankCell(view, cell, info, tag)
	local rank = info.rank
	local headInfo = info.headInfo
	local value = info.value
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local txtArea = goutil.findChildTextComponent(mainGo, "txtArea")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")

	txtRank.text = rank

	local isTop3 = checknumber(rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	txtName.text = headInfo.userName
	txtArea.text = headInfo.areaName
	txtScore.text = value

	HeadItemController.instance:setHeadCellByInfo(headRoot, headInfo, true)

	local prizes = self:_getPrizesByRank(rank)

	if itemScrollerview and self._itemScrollercell and not string.nilorempty(prizes) then
		local prizeStrArr = string.split(prizes, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

			self._itemScrollListDic[mainGo]:setCenterMode(true)
			self._itemScrollListDic[mainGo]:dragNotifyParent()
			self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
		end
	end
end

function MartialcontestfinalrankscoreView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")

	HeadItemController.instance:resetHeadCell(headRoot)

	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function MartialcontestfinalrankscoreView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function MartialcontestfinalrankscoreView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function MartialcontestfinalrankscoreView:_updateMyPrizeItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function MartialcontestfinalrankscoreView:_clearMyPrizeItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return MartialcontestfinalrankscoreView
