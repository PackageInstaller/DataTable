-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightcard/view/SaintKnightCardRankView.lua

module("logic.extensions.saintknightcard.view.SaintKnightCardRankView", package.seeall)

local SaintKnightCardRankView = class("SaintKnightCardRankView", ViewComponent)

function SaintKnightCardRankView:buildUI()
	SaintKnightCardRankView.super.buildUI(self)

	self._tabCol = goutil.findChild(self.mainGO, "tabCol")
	self._tabScrollerview = goutil.findChild(self.mainGO, "tabCol/tabScrollerview")
	self._tabScrollerContent = goutil.findChild(self.mainGO, "tabCol/tabScrollerview/Viewport/Content")
	self._tabScrollercell = goutil.findChild(self.mainGO, "tabCol/tabScrollercell")
	self._tabScrollercell_2 = goutil.findChild(self.mainGO, "tabCol/tabScrollercell/tabScrollercell_2")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "tipsCol/txtMyRank")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))

	GameUtil.SetActive(self._tabScrollercell, false)
	GameUtil.SetActive(self._tabScrollercell_2, false)
end

function SaintKnightCardRankView:bindEvents()
	SaintKnightCardRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SaintKnightCardRankView:unbindEvents()
	SaintKnightCardRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SaintKnightCardRankView:onEnter()
	SaintKnightCardRankView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.SaintKnightCard)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._actData = SaintKnightCardConfig.instance:getSkcActData(self._activityId)
	self._drawPlanIds = self._actData.drawPlanIds
	self._curDrawPlanId = self._drawPlanIds[1]
	self._curGroupId = 1
	self._myRank = -1
	self._rankInfoList = {}

	self:_onSetUI()
	self:_onUpdate()
	GlobalDispatcher:addListener(GlobalNotify.SaintKnightCardGetRankInfoRes, self._handleRankInfoRes, self)
	self:_sendInfoReq()
end

function SaintKnightCardRankView:onExit()
	SaintKnightCardRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SaintKnightCardGetRankInfoRes, self._handleRankInfoRes, self)
	self:_onClearTabCol()
	self:_onClearRankCol()
end

function SaintKnightCardRankView:_sendInfoReq()
	if self._activityId <= 0 or self._curDrawPlanId <= 0 or self._curGroupId <= 0 then
		return
	end

	SaintKnightCardController.instance:sendSaintKnightCardGetRankInfoReq(self._activityId, self._curDrawPlanId, self._curGroupId)
end

function SaintKnightCardRankView:_handleRankInfoRes(msg)
	self._myRank = msg.myRank
	self._rankInfoList = msg.rankInfos

	self:_onUpdate()
end

function SaintKnightCardRankView:_onSetUI()
	return
end

function SaintKnightCardRankView:_onUpdate()
	self:_onUpdatePlaneUI()
	self:_onUpdateTabColUI()
	self:_onUpdateRankColUI()
end

function SaintKnightCardRankView:_onUpdatePlaneUI()
	self._txtMyRank.text = self._myRank > 0 and self._myRank or "未上榜"

	GameUtil.SetActive(self._emptyGo, #self._rankInfoList <= 0)
end

function SaintKnightCardRankView:_onUpdateTabColUI()
	local parentTran = self._tabScrollerContent.transform
	local children = GameUtil.getChildren(parentTran)
	local dataCount = #self._drawPlanIds

	for idx, drawPlanId in ipairs(self._drawPlanIds) do
		if not children[idx] then
			local mainGo = goutil.cloneAndSetParent(self._tabScrollercell, parentTran)
			local drawData = SaintKnightCardConfig.instance:getSkcDrawData(drawPlanId)

			self:_updatePrimaryTabCell(children[idx], drawData)
		end
	end

	for idx = 1, parentTran.childCount do
		GameUtil.SetActive(parentTran:GetChild(idx - 1), idx <= dataCount)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._tabScrollerContent:GetComponent(goutil.Type_RectTransform))
end

function SaintKnightCardRankView:_onClearTabCol()
	local children = GameUtil.getChildren(parentTran)

	for idx, go in ipairs(children) do
		self:_clearPrimaryTabCell(go)
	end
end

function SaintKnightCardRankView:_updatePrimaryTabCell(mainGo, drawData)
	local parentTran = mainGo.transform
	local children = GameUtil.getChildren(parentTran)
	local secondaryChildren = {}

	for idx = 2, #children do
		table.insert(secondaryChildren, children[idx])
	end

	local cell_1 = children[1]

	if cell_1 then
		local txtName = goutil.findChildTextComponent(cell_1, "txtName")
		local changeGroup = cell_1:GetComponent(ComponentType.UIChangeGroup)

		txtName.text = drawData.txtTitle

		local isSelected = self._curDrawPlanId == drawData.drawPlanId

		changeGroup:SetState(isSelected and 1 or 0)
		GameUtil.addClickHandler(cell_1, GameUtil.handler(self._onClickPrimaryTabCell, self, drawData.drawPlanId))
	end

	local prizeCfg = SaintKnightCardConfig.instance:getSkcPrizeCfgById(drawData.drawPlanId)
	local dataCount = 0

	if self._curDrawPlanId == drawData.drawPlanId then
		dataCount = #prizeCfg
	end

	for idx, go in ipairs(secondaryChildren) do
		GameUtil.SetActive(go, idx <= dataCount)
	end

	for groupId = 1, dataCount do
		if not secondaryChildren[groupId] then
			local cell_2 = goutil.cloneAndSetParent(self._tabScrollercell_2, parentTran)

			self:_updateSecondaryTabCell(cell_2, prizeCfg[groupId])
			GameUtil.SetActive(cell_2, true)
		end
	end
end

function SaintKnightCardRankView:_clearPrimaryTabCell(mainGo)
	local parentTran = mainGo.transform
	local children = GameUtil.getChildren(parentTran)
	local secondaryChildren = {}

	for idx = 2, children do
		table.insert(secondaryChildren, children[idx])
	end

	local cell_1 = children[1]

	GameUtil.rmClickHandler(cell_1)

	for idx, go in ipairs(secondaryChildren) do
		self:_clearSecondaryTabCell(go)
	end
end

function SaintKnightCardRankView:_updateSecondaryTabCell(mainGo, data)
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local changeGroup = mainGo:GetComponent(ComponentType.UIChangeGroup)

	txtName.text = data.txtName

	local isSelected = self._curGroupId == data.groupId

	changeGroup:SetState(isSelected and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickSecondaryTabCell, self, data.groupId))
end

function SaintKnightCardRankView:_clearSecondaryTabCell(mainGo)
	GameUtil.rmClickHandler(mainGo)
end

function SaintKnightCardRankView:_onClickPrimaryTabCell(drawPlanId)
	self._curDrawPlanId = drawPlanId
	self._curGroupId = 1

	self:_sendInfoReq()
end

function SaintKnightCardRankView:_onClickSecondaryTabCell(groupId)
	self._curGroupId = groupId

	self:_sendInfoReq()
end

function SaintKnightCardRankView:_onUpdateRankColUI()
	self._rankScrollList:reloadData(self._rankInfoList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
end

function SaintKnightCardRankView:_onClearRankCol()
	self._rankScrollList:dispose()
end

function SaintKnightCardRankView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")
	local btnIcon = goutil.findChild(mainGo, "btnIcon")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local txtArea = goutil.findChildTextComponent(mainGo, "txtArea")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)

	txtRank.text = info.rank

	local isTop3 = checknumber(info.rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(info.rank - 1)
	end

	txtName.text = info.headInfo.userName
	txtArea.text = info.areaName

	local timeStr = ""
	local timeSec = checknumber(info.sumbitTimeSec)

	if timeSec > 0 then
		local timeDate = os.date("*t", timeSec / 1000)

		timeStr = string.format("%d %02d.%02d\n%02d:%02d:%02d", timeDate.year, timeDate.month, timeDate.day, timeDate.hour, timeDate.min, timeDate.sec)
	end

	txtTime.text = timeStr

	HeadItemController.instance:setHeadCellByInfo(imgIcon, info.headInfo)

	local function callBack()
		FriendController.instance:showInfoView(info.headInfo.userId, imgIcon)
	end

	GameUtil.addClickHandler(btnIcon, callBack)
end

function SaintKnightCardRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local imgIcon = goutil.findChild(mainGo, "imgIcon")
	local btnIcon = goutil.findChild(mainGo, "btnIcon")

	uGuiUtil.clearImage(imgIcon)
	GameUtil.rmClickHandler(btnIcon)
end

return SaintKnightCardRankView
