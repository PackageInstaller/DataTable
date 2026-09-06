-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschoolpvp/view/MagicSchoolPvpRankView.lua

module("logic.extensions.magicschoolpvp.view.MagicSchoolPvpRankView", package.seeall)

local MagicSchoolPvpRankView = class("MagicSchoolPvpRankView", ViewComponent)

function MagicSchoolPvpRankView:ctor()
	MagicSchoolPvpRankView.super.ctor(self)
end

function MagicSchoolPvpRankView:buildUI()
	MagicSchoolPvpRankView.super.buildUI(self)

	self._closeBtn = goutil.findChild(self.mainGO, "closeBtn")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._itemScrollercell = goutil.findChild(self.mainGO, "rankCol/itemScrollercell")
	self._itemScrollerListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._rankScrollerList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._myPrizeCol = self:getGo("tipsCol/myPrizeCol")
	self._myPrizeCol_itemScrollerview = self:getGo("tipsCol/myPrizeCol/itemScrollerview")
	self._myPrizeCol_itemScrollercell = self:getGo("tipsCol/myPrizeCol/itemScrollercell")
	self._myPrizeScrollList = ScrollerList.create(self._myPrizeCol_itemScrollerview, self._myPrizeCol_itemScrollercell, GameUtil.handler(self._updateMyPrizeItemCell, self), GameUtil.handler(self._clearMyPrizeItemCell, self))
end

function MagicSchoolPvpRankView:bindEvents()
	MagicSchoolPvpRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self.close, self)
end

function MagicSchoolPvpRankView:unbindEvents()
	MagicSchoolPvpRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._closeBtn)
end

function MagicSchoolPvpRankView:destroyUI()
	MagicSchoolPvpRankView.super.destroyUI(self)
end

function MagicSchoolPvpRankView:onEnter()
	MagicSchoolPvpRankView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = MagicSchoolPvPController.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self.addGEvent(self, GlobalNotify.HandlePM_MSPvPRankInfoRes, self._handlePM_MSPvPRankInfoRes, self)
	MagicSchoolPvPController.instance:sendPM_MSPvPRankInfoReq(self._activityId)
end

function MagicSchoolPvpRankView:onExit()
	MagicSchoolPvpRankView.super.onExit(self)
	self:_onClear()
	self._myPrizeScrollList:dispose()
end

function MagicSchoolPvpRankView:_handlePM_MSPvPRankInfoRes(msg)
	self._rankInfoList = msg.items
	self._myRank = msg.myRank
	self._myScore = 0

	self:_onUpdate()
end

function MagicSchoolPvpRankView:_onUpdate()
	local myRank = self:_getMyRank()

	self._txtMyRank.text = myRank > 0 and myRank or "未上榜"

	local infoList = self:_getRankInfoList()

	self._rankScrollerList:reloadData(infoList)
	self._rankScrollerList:MoveCellInView(0, true)
	GameUtil.SetActive(self._emptyGo, #infoList <= 0)

	local prizes = self:_getPrizesByRank(myRank)

	if not string.nilorempty(prizes) then
		local prizeStrArr = string.split(prizes, "#")

		self._myPrizeScrollList:reloadData(prizeStrArr)
		GameUtil.SetActive(self._myPrizeCol, true)
	else
		GameUtil.SetActive(self._myPrizeCol, false)
		self._myPrizeScrollList:dispose()
	end
end

function MagicSchoolPvpRankView:_onClear()
	self._rankScrollerList:dispose()
end

function MagicSchoolPvpRankView:_getMyRank()
	return self._myRank
end

function MagicSchoolPvpRankView:_getRankInfoList()
	return self._rankInfoList
end

function MagicSchoolPvpRankView:_getPrizesByRank(rank)
	local data = MagicSchoolPvpConfig.instance:getRankPrizeData(self._activityId, rank)

	if data then
		return data.prize
	end
end

function MagicSchoolPvpRankView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local txtArea = goutil.findChildTextComponent(mainGo, "txtArea")
	local txtTeam = goutil.findChildTextComponent(mainGo, "txtTeam")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")

	txtRank.text = info.rank

	local isTop3 = checknumber(info.rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(info.rank - 1)
	end

	txtName.text = info.headInfo.userName
	txtScore.text = info.totalDamage
	txtTeam.text = info.campId == MagicSchoolPvPEnum.CampId_Black and "黑" or "白"

	local date = GameUtil.time2date(info.time / 1000)

	txtTime.text = string.format("%02d.%02d %02d:%02d", date.month, date.day, date.hour, date.min)

	HeadItemController.instance:setHeadCellByInfo(head, info.headInfo, true)

	local prizes = self:_getPrizesByRank(info.rank)
	local prizeStrArr = {}

	if not string.nilorempty(prizes) then
		prizeStrArr = string.split(prizes, "#")
	end

	self._itemScrollerListDic[mainGo] = self._itemScrollerListDic[mainGo] or ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	local itemScrollList = self._itemScrollerListDic[mainGo]

	itemScrollList:dragNotifyParent()
	itemScrollList:reloadData(prizeStrArr)
end

function MagicSchoolPvpRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")

	HeadItemController.instance:resetHeadCell(head)

	local itemScrollList = self._itemScrollerListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollerListDic[mainGo] = nil
	end
end

function MagicSchoolPvpRankView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function MagicSchoolPvpRankView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function MagicSchoolPvpRankView:_updateMyPrizeItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function MagicSchoolPvpRankView:_clearMyPrizeItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return MagicSchoolPvpRankView
