-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalrankjuesaiView.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalrankjuesaiView", package.seeall)

local MartialcontestfinalrankjuesaiView = class("MartialcontestfinalrankjuesaiView", ViewComponent)

function MartialcontestfinalrankjuesaiView:ctor()
	MartialcontestfinalrankjuesaiView.super.ctor(self)
end

function MartialcontestfinalrankjuesaiView:unbindEvents()
	MartialcontestfinalrankjuesaiView.super.unbindEvents(self)
end

function MartialcontestfinalrankjuesaiView:bindEvents()
	MartialcontestfinalrankjuesaiView.super.bindEvents(self)
end

function MartialcontestfinalrankjuesaiView:buildUI()
	MartialcontestfinalrankjuesaiView.super.buildUI(self)

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

function MartialcontestfinalrankjuesaiView:onExit()
	MartialcontestfinalrankjuesaiView.super.onExit(self)
	self._rankScrollList:dispose()
	self._myPrizeScrollList:dispose()
end

function MartialcontestfinalrankjuesaiView:onEnter()
	MartialcontestfinalrankjuesaiView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.MCFinalsInfoRes, self._onMCFinalsInfoRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._tabId = checknumber(params[2])
	self._tabCfg = MartialContestConfig.instance:getFinalsRankViewCfg(self._tabId)
	self._txtTip1.text = self._tabCfg.txtTips
	self._zoneId = 0
	self._rankList = {}
	self._myRank = 0
	self._myValue = 0

	local stepId = MartialContestController.instance:getStepIdByNowTime(self._activityId)
	local canGetInfo = stepId >= MartialContestEnum.Finals_Show_Rank_Step_Id

	if not canGetInfo then
		local stepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, MartialContestEnum.Finals_Show_Rank_Step_Id)
		local time = GameUtil.string2time(stepCfg.startTime)

		if time <= ServerTime.now() then
			canGetInfo = true
		end
	end

	if canGetInfo then
		MartialContestAgent.instance:sendPM_MCFinalsInfoReq(self._activityId)
	else
		self:_onMCFinalsInfoRes()
	end
end

function MartialcontestfinalrankjuesaiView:_onMCFinalsInfoRes()
	local info = MartialContestModel.instance:getInfo(self._activityId)
	local newPlayers = {}

	if info and info.curStepId >= MartialContestEnum.Finals_Show_Rank_Step_Id then
		local info = MartialContestModel.instance:getFinalsInfo() or {}

		table.insertto(newPlayers, info.allPlayers or {})
		table.sort(newPlayers, function(a, b)
			if a.totalScore == b.totalScore then
				if a.winTimes == b.winTimes then
					if a.headInfo.zdl == b.headInfo.zdl then
						return checknumber(a.headInfo.headInfo.userId) < checknumber(b.headInfo.headInfo.userId)
					else
						return a.headInfo.zdl > b.headInfo.zdl
					end
				end

				return a.winTimes > b.winTimes
			end

			return a.totalScore > b.totalScore
		end)

		local userId = tostring(RoleModel.instance:getUserId())

		for i, v in ipairs(newPlayers) do
			if v.headInfo.headInfo.userId == userId then
				self._myRank = i
				self._myValue = v.totalScore

				break
			end
		end
	end

	self._rankList = newPlayers

	self:_onUpdate()
end

function MartialcontestfinalrankjuesaiView:_getPrizesByRank(rank)
	local cfg = MartialContestConfig.instance:getFinalsRankPrizeCfgByRank(self._activityId, rank)

	return cfg and cfg.prize
end

function MartialcontestfinalrankjuesaiView:_onUpdate()
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

function MartialcontestfinalrankjuesaiView:_updateRankCell(view, cell, info, tag)
	local rank = cell.data
	local headInfo = info.headInfo.headInfo
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local txtArea = goutil.findChildTextComponent(mainGo, "txtArea")
	local txtWinTimes = goutil.findChildTextComponent(mainGo, "txtWin")
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
	txtScore.text = info.totalScore
	txtWinTimes.text = info.winTimes

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

function MartialcontestfinalrankjuesaiView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")

	HeadItemController.instance:resetHeadCell(headRoot)

	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function MartialcontestfinalrankjuesaiView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function MartialcontestfinalrankjuesaiView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function MartialcontestfinalrankjuesaiView:_updateMyPrizeItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function MartialcontestfinalrankjuesaiView:_clearMyPrizeItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return MartialcontestfinalrankjuesaiView
