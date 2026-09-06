-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalBattleReportView.lua

module("logic.extensions.landlords.view.FalBattleReportView", package.seeall)

local FalBattleReportView = class("FalBattleReportView", ViewComponent)

function FalBattleReportView:buildUI()
	FalBattleReportView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._recordCol = goutil.findChild(self.mainGO, "recordCol")
	self._recordScrollerview = goutil.findChild(self._recordCol, "recordScrollerview")
	self._recordScrollercell = goutil.findChild(self._recordCol, "recordScrollercell")
	self._recordScrollList = ScrollerList.create(self._recordScrollerview, self._recordScrollercell, GameUtil.handler(self._updateRecordCell, self), GameUtil.handler(self._clearRecordCell, self))
	self._nodata = goutil.findChild(self.mainGO, "nodata")
	self._backMask = goutil.findChild(self.mainGO, "backMask")
end

function FalBattleReportView:bindEvents()
	FalBattleReportView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnMask, self)
	GameUtil.addClickHandler(self._backMask, self._onClickBtnMask, self)
end

function FalBattleReportView:unbindEvents()
	FalBattleReportView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._backMask)
end

function FalBattleReportView:onEnter()
	FalBattleReportView.super.onEnter(self)

	self._activityId = FightAgainstLandlordsController.instance:getActivityId()
	self._myUserId = FightAgainstLandlordsController.instance:getMyUserId()

	GlobalDispatcher:addListener(GlobalNotify.handlePM_LandlordsPKGetBattleRecordRes, self._onUpdateRecordColUI, self)
	FightAgainstLandlordsController.instance:sendPM_LandlordsPKGetBattleRecordReq(self._activityId)
end

function FalBattleReportView:onExit()
	FalBattleReportView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.handlePM_LandlordsPKGetBattleRecordRes, self._onUpdateRecordColUI, self)
	self:_onClearRecordColUI()
end

function FalBattleReportView:_onUpdateRecordColUI()
	local recordInfoList = FightAgainstLandlordsModel.instance:getRecordInfoListInBR()
	local infoIdxList = {}

	for i = #recordInfoList, 1, -1 do
		table.insert(infoIdxList, recordInfoList[i].idx)
	end

	self._recordScrollList:reloadData(infoIdxList)
	GameUtil.SetActive(self._nodata, #infoIdxList == 0)
end

function FalBattleReportView:_onClearRecordColUI()
	self._recordScrollList:dispose()
end

function FalBattleReportView:_updateRecordCell(view, cell, infoIdx, tag)
	local mainGo = cell.gameObject
	local imgResult = goutil.findChild(mainGo, "imgResult")
	local resultChange = imgResult:GetComponent("UIImageSpriteChange")
	local btnVideo = goutil.findChild(mainGo, "btnVideo")
	local txtTime = goutil.findChildTextComponent(mainGo, "time/txt")
	local reward = goutil.findChild(mainGo, "reward")
	local rewardItem = goutil.findChild(mainGo, "reward/rewardItem")
	local txtLevel = goutil.findChildTextComponent(mainGo, "txtLevel")
	local recordMo = FightAgainstLandlordsModel.instance:getRecordMoInBR(infoIdx)

	resultChange:SetState(recordMo:isWin(self._myUserId) and 0 or 1)

	local timeMills = FightAgainstLandlordsModel.instance:getTimeMillsInBR(infoIdx)
	local date = GameUtil.time2date(checknumber(timeMills) / 1000)

	txtTime.text = string.format("%02d月%02d日", date.month, date.day)

	local thresholdId = recordMo:getThresholdId()

	txtLevel.text = string.format("%s级场对战", thresholdId == 1 and "初" or thresholdId == 2 and "中" or "高")

	local userIdList = recordMo:getUesrIdList()

	table.sort(userIdList, function(userIdA, userIdB)
		return recordMo:getIdentity(userIdA) == GameEnum.FalIdentity.Landlord
	end)

	local leftHead = goutil.findChild(mainGo, "headView/leftHead")
	local rightHead_1 = goutil.findChild(mainGo, "headView/rightHead_1")
	local rightHead_2 = goutil.findChild(mainGo, "headView/rightHead_2")

	for headIdx, headGo in ipairs({
		leftHead,
		rightHead_1,
		rightHead_2
	}) do
		local headIcon = goutil.findChild(headGo, "headIcon")
		local txtName = goutil.findChildTextComponent(headGo, "txtName")
		local userId = userIdList[headIdx]
		local userName = recordMo:getUserName(userId)

		txtName.text = userId == self._myUserId and string.format("<color=#8BF876FF>%s</color>", userName) or userName

		HeadItemController.instance:setHeadCellByInfo(headIcon, recordMo:getHeadInfo(userId))
	end

	local baseData = FightAgainstLandlordsConfig.instance:getFalBaseData(self._activityId)
	local itemStr = baseData.scoreItem
	local rewardNum = recordMo:getGoldValueA(self._myUserId)

	if not string.nilorempty(itemStr) then
		local matType, matId, matNum = MaterialMgr.getMatParams(baseData.scoreItem)
		local str = string.format("%s:%s:%s", matType, matId, rewardNum)

		MaterialMgr.setCellByCfg(str, rewardItem)
	end

	GameUtil.SetActive(reward, rewardNum > 0)

	local battleIds = FightAgainstLandlordsModel.instance:getBattleIdInBR(infoIdx)

	GameUtil.addClickHandler(btnVideo, GameUtil.handler(self._onClickVideo, self, battleIds), self)
end

function FalBattleReportView:_clearRecordCell(cell)
	local mainGo = cell.gameObject
	local leftHead = goutil.findChild(mainGo, "headView/leftHead")
	local rightHead_1 = goutil.findChild(mainGo, "headView/rightHead_1")
	local rightHead_2 = goutil.findChild(mainGo, "headView/rightHead_2")

	for _, go in ipairs({
		leftHead,
		rightHead_1,
		rightHead_2
	}) do
		local headIcon = goutil.findChild(go, "headIcon")

		HeadItemController.instance:resetHeadCell(headIcon)
	end

	local rewardItem = goutil.findChild(mainGo, "reward/rewardItem")

	MaterialMgr.resetAll(rewardItem)

	local btnVideo = goutil.findChild(mainGo, "btnVideo")

	GameUtil.rmClickHandler(btnVideo)
end

function FalBattleReportView:_onClickVideo(battleIds)
	self:close()
	UIJumper.instance:pushOneStack(ViewName.FightAgainstLandlordsMainView, nil)
	UIJumper.instance:pushOneStack(ViewName.FalBattleReportView, nil)
	FightAgainstLandlordsController.instance:sendPM_LandlordsPKGetBattleVideoReq(battleIds)
end

function FalBattleReportView:_onClickBtnMask()
	self:close()
end

return FalBattleReportView
