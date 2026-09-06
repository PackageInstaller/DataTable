-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergarteRankView.lua

module("logic.extensions.festiveflower.view.KindergarteRankView", package.seeall)

local KindergarteRankView = class("KindergarteRankView", ViewComponent)

KindergarteRankView.GLORY = 0
KindergarteRankView.STUDENT = 1

function KindergarteRankView:ctor()
	KindergarteRankView.super.ctor(self)
end

function KindergarteRankView:unbindEvents()
	KindergarteRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnHonor)
	GameUtil.rmClickHandler(self._btnStudent)
end

function KindergarteRankView:bindEvents()
	KindergarteRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnHonor, self._rankToHonor, self)
	GameUtil.addClickHandler(self._btnStudent, self._rankToStudent, self)
end

function KindergarteRankView:buildUI()
	KindergarteRankView.super.buildUI(self)

	self._btnClose = self:getGo("static/btnClose")
	self._btnHonor = self:getGo("btnCrol/btnHonor")
	self._btnStudent = self:getGo("btnCrol/btnStudent")
	self._titleHonor = self:getGo("title/titleHonor")
	self._titleStudent = self:getGo("title/titleStudent")
	self._imgHonor = self._btnHonor:GetComponent(ComponentType.UIImageSpriteChange)
	self._imgStudent = self._btnStudent:GetComponent(ComponentType.UIImageSpriteChange)
	self._empty = self:getGo("empty")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
	self._txtTip = self:getTxt("myRank/txtTip")

	local tableView = self:getGo("tableView")
	local cell = self:getGo("cell")

	self._rankList = ScrollerList.create(tableView, cell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._cellPrizeList = {}
end

function KindergarteRankView:onExit()
	KindergarteRankView.super.onExit(self)
	self._rankList:dispose()
end

function KindergarteRankView:onEnter()
	KindergarteRankView.super.onEnter(self)

	self._rankType = KindergarteRankView.GLORY
	self._activityId = KindergartenModel.instance:getActivityId()

	self:_rankToHonor()
	self.addGEvent(self, GlobalNotify.KindergartenRankViewRes, self._updatePersonInfo, self)
end

function KindergarteRankView:_updateRankCell(view, cell, info, tag)
	local mainGO = cell.gameObject
	local head = goutil.findChild(mainGO, "head")
	local imgRank = goutil.findChildComponent(mainGO, "imgRank", ComponentType.UIImageSpriteChange)
	local honorCell = goutil.findChild(mainGO, "honorCell")
	local studentCell = goutil.findChild(mainGO, "studentCell")
	local txtName = goutil.findChildTextComponent(mainGO, "txtName")
	local txtRank = goutil.findChildTextComponent(mainGO, "txtRank")
	local txtArea, txtCount
	local prizeItemGo = goutil.findChild(mainGO, "honorCell/item")
	local prizeItemListGo = goutil.findChild(mainGO, "honorCell/itemview")
	local name = info.headInfo.userName
	local rank = info.rank
	local area = info.areaName
	local score = info.score
	local headInfo = info.headInfo
	local prizeCfg

	for i, v in ipairs(KindergartenConfig.instance:getRankPrizeCfgs(self._activityId)) do
		if rank >= v.rankRange[1] and rank <= v.rankRange[2] then
			prizeCfg = v
		end
	end

	if self._rankType == KindergarteRankView.GLORY then
		local prizeArray = string.split(prizeCfg.prize, "#") or {}

		GameUtil.SetActive(studentCell, false)
		GameUtil.SetActive(honorCell, true)
		self:_clearPrizeCells(cell)

		txtArea = goutil.findChildTextComponent(mainGO, "honorCell/txtArea")
		txtCount = goutil.findChildTextComponent(mainGO, "honorCell/txtHonorCount")

		local list = ScrollerList.create(prizeItemListGo, prizeItemGo, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

		self._cellPrizeList[cell] = list

		list:reloadData(prizeArray)
	else
		GameUtil.SetActive(studentCell, true)
		GameUtil.SetActive(honorCell, false)

		txtArea = goutil.findChildTextComponent(mainGO, "studentCell/txtArea")
		txtCount = goutil.findChildTextComponent(mainGO, "studentCell/txtStudentCount")
	end

	HeadItemController.instance:setHeadCellByInfo(head, headInfo, true)

	local isTop3 = checknumber(rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	txtName.text = name
	txtRank.text = rank
	txtArea.text = area
	txtCount.text = score
end

function KindergarteRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local head = goutil.findChild(mainGo, "head")

	HeadItemController.instance:resetHeadCell(head)
end

function KindergarteRankView:_updatePersonInfo()
	local myRank = KindergartenModel.instance:getMyRank()

	self._txtMyRank.text = myRank < 0 and "未上榜" or myRank
	self._txtTip.text = self._rankType == KindergarteRankView.GLORY and lang("提示:前5000名可上榜，1-1000名可获得头像框+称号奖励，\n1001-5000名可获得称号奖励，在活动结束后通过邮件发放") or lang("提示:前1000名可以上榜")

	self:_updateAllRank()
end

function KindergarteRankView:_updateAllRank()
	local rankList = KindergartenModel.instance:getRankInfos()

	self._rankList:reloadData(rankList)

	if #rankList <= 0 then
		GameUtil.SetActive(self._empty, true)
	else
		GameUtil.SetActive(self._empty, false)
	end
end

function KindergarteRankView:_clearPrizeCells(cell)
	local list = self._cellPrizeList[cell]

	if list then
		list:dispose()
	end

	self._cellPrizeList[cell] = nil
end

function KindergarteRankView:_updatePrizeCell(index, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function KindergarteRankView:_clearPrizeCell(cell)
	MaterialMgr.resetAll(cell)
end

function KindergarteRankView:_rankToHonor()
	self._rankType = KindergarteRankView.GLORY

	KindergartenAgent.instance:sendPM_KindergartenRankViewReq(self._activityId, self._rankType)
	self._imgHonor:SetState(0)
	self._imgStudent:SetState(1)
	GameUtil.SetActive(self._titleHonor, true)
	GameUtil.SetActive(self._titleStudent, false)
end

function KindergarteRankView:_rankToStudent()
	self._rankType = KindergarteRankView.STUDENT

	KindergartenAgent.instance:sendPM_KindergartenRankViewReq(self._activityId, self._rankType)
	self._imgHonor:SetState(1)
	self._imgStudent:SetState(0)
	GameUtil.SetActive(self._titleHonor, false)
	GameUtil.SetActive(self._titleStudent, true)
end

function KindergarteRankView:_getPrizeCfg(index)
	return (KindergartenConfig.instance:getRankPrizeCfg(self._activityId, index))
end

return KindergarteRankView
