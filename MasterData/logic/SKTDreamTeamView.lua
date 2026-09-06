-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknighttask/view/dream/SKTDreamTeamView.lua

module("logic.extensions.saintknighttask.view.dream.SKTDreamTeamView", package.seeall)

local SKTDreamTeamView = class("SKTDreamTeamView", ViewComponent)

function SKTDreamTeamView:ctor()
	SKTDreamTeamView.super.ctor(self)
end

function SKTDreamTeamView:buildUI()
	SKTDreamTeamView.super.buildUI(self)

	self._bg = goutil.findChild(self.mainGO, "bg")
	self._btnRank = goutil.findChild(self.mainGO, "btnRank")
	self._btnVerify = goutil.findChild(self.mainGO, "btnVerify")

	local tabScrollerview = goutil.findChild(self.mainGO, "tabCol/tabScrollerview")
	local tabScrollercell = goutil.findChild(self.mainGO, "tabCol/tabScrollercell")

	self._tabScrollList = ScrollerList.create(tabScrollerview, tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._filedView = goutil.findChild(self.mainGO, "rankCol/subTitle/filedView")
	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._colRewardCol = {}

	local mainGo = goutil.findChild(self.mainGO, "colRewardCol")

	self._colRewardCol._mainGo = mainGo
	self._colRewardCol._btnGet = goutil.findChild(mainGo, "btnGet")
	self._colRewardCol._btnGetRed = goutil.findChild(mainGo, "btnGet/redPoint")
	self._colRewardCol._receiveGo = goutil.findChild(mainGo, "receiveGo")
	self._colRewardCol._prize = goutil.findChild(mainGo, "prize")
	self._verRewardCol = {}

	local mainGo = goutil.findChild(self.mainGO, "verRewardCol")

	self._verRewardCol._mainGo = mainGo
	self._verRewardCol._btnGet = goutil.findChild(mainGo, "btnGet")
	self._verRewardCol._btnGetRed = goutil.findChild(mainGo, "btnGet/redPoint")
	self._verRewardCol._receiveGo = goutil.findChild(mainGo, "receiveGo")
	self._verRewardCol._prize = goutil.findChild(mainGo, "prize")
	self._verRewardCol._txtTip = goutil.findChildTextComponent(mainGo, "tip/txt")
	self._verRewardCol._tipStr = self._verRewardCol._txtTip.text
end

function SKTDreamTeamView:bindEvents()
	SKTDreamTeamView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnVerify, self._onClickBtnVerify, self)
	GameUtil.addClickHandler(self._colRewardCol._btnGet, self._onClickBtnGetOfColReward, self)
	GameUtil.addClickHandler(self._verRewardCol._btnGet, self._onClickBtnGetOfVerReward, self)
end

function SKTDreamTeamView:unbindEvents()
	SKTDreamTeamView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnVerify)
	GameUtil.rmClickHandler(self._colRewardCol._btnGet)
	GameUtil.rmClickHandler(self._verRewardCol._btnGet)
end

function SKTDreamTeamView:destroyUI()
	SKTDreamTeamView.super.destroyUI(self)
end

function SKTDreamTeamView:onEnter()
	SKTDreamTeamView.super.onEnter(self)

	self._activityId = SaintKnightTaskController.instance:getActivityId()

	local isInTime = SaintKnightTaskController.instance:isInActivityTimeAsSkt(self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._rankCfg = SaintKnightTaskConfig.instance:getSktRankCfg(self._activityId) or {}

	self:_setCurTabIdx(#self._rankCfg > 0 and 1 or 0)
	self.addGEvent(self, GlobalNotify.SKTaskCollectionTasksGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.SKTaskCollectionTasksGetRankInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.SKTaskWorldTasksVerifyFormZdlRes, self._sendInfoReq, self)
	self.addGEvent(self, GlobalNotify.SKTaskCollectionTasksGainPrizeRes, self._sendInfoReq, self)
	self.addGEvent(self, GlobalNotify.SKTaskWorldTasksGainVerifyPrizeRes, self._sendInfoReq, self)
	self:_onSetUI()
	self:_onUpdate()
	self:_sendInfoReq()

	if self:_getCurTabIdx() > 0 then
		SaintKnightTaskController.instance:sendCollectionTasksGetRankInfoReq(self._activityId, self:_getCurRankId())
	end
end

function SKTDreamTeamView:onExit()
	SKTDreamTeamView.super.onExit(self)
	self:_onClearTabColUI()
	self:_onClearRankCol()
	RedPointController.instance:unregRedPoint(self._colRewardCol._btnGetRed)
	RedPointController.instance:unregRedPoint(self._verRewardCol._btnGetRed)
	MaterialMgr.resetAll(self._colRewardCol._prize)
	MaterialMgr.resetAll(self._verRewardCol._prize)
end

function SKTDreamTeamView:_sendInfoReq()
	SaintKnightTaskController.instance:sendCollectionTasksGetInfoReq(self._activityId)
end

function SKTDreamTeamView:_onSetUI()
	local redId = SaintKnightTaskConfig.instance:getSktCollectionPrizeRed()

	RedPointController.instance:regRedPoint(self._colRewardCol._btnGetRed, redId)

	local redId = SaintKnightTaskConfig.instance:getSktVerifyPrizeRed()

	RedPointController.instance:regRedPoint(self._verRewardCol._btnGetRed, redId)

	local collData = SaintKnightTaskConfig.instance:getSktCollDataById(self._activityId)

	if collData and not string.nilorempty(collData.prize) then
		MaterialMgr.setCellByCfg(collData.prize, self._colRewardCol._prize)
	else
		MaterialMgr.resetAll(self._colRewardCol._prize)
	end

	local verifyData = SaintKnightTaskConfig.instance:getSktVerifyData(self._activityId)

	if verifyData and not string.nilorempty(verifyData.prize) then
		MaterialMgr.setCellByCfg(verifyData.prize, self._verRewardCol._prize)
	else
		MaterialMgr.resetAll(self._verRewardCol._prize)
	end

	self._verRewardCol._txtTip.text = string.format(self._verRewardCol._tipStr, verifyData.zdl)
end

function SKTDreamTeamView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function SKTDreamTeamView:_onUpdateData()
	self._tabInfoList = {}

	for idx, data in ipairs(self._rankCfg) do
		local info = {}

		info.tabIdx = data.index
		info.rankId = data.rankId
		info.data = data
		self._tabInfoList[idx] = info
	end

	if self._curTabIdx == nil or self:_getTabInfo(self._curTabIdx) == nil then
		self:_setCurTabIdx(#self._tabInfoList > 0 and 1 or 0)
	end
end

function SKTDreamTeamView:_onUpdateUI()
	self:_onUpdateTabColUI()
	self:_onUpdateRankColUI()
	self:_onUpdateColRewardColUI()
	self:_onUpdatVerRewardColUI()
end

function SKTDreamTeamView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(self._tabInfoList)
end

function SKTDreamTeamView:_onClearTabColUI()
	self._tabScrollList:dispose()
end

function SKTDreamTeamView:_updateTabCell(view, cell, info, tag)
	local tabIdx = info.tabIdx
	local data = info.data
	local mainGo = cell.gameObject
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = data.name

	GameUtil.SetActive(redPoint, false)
	GameUtil.setUIGroupIdx(mainGo, self:_getCurTabIdx() == tabIdx and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, info))
end

function SKTDreamTeamView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local redPoint = goutil.findChild(mainGo, "redPoint")

	GameUtil.rmClickHandler(mainGo)
end

function SKTDreamTeamView:_onClickTab(info)
	self:_setCurTabIdx(info.tabIdx)
	self:_onUpdate()
	SaintKnightTaskController.instance:sendCollectionTasksGetRankInfoReq(self._activityId, info.rankId)
end

function SKTDreamTeamView:_setCurTabIdx(tabIdx)
	self._curTabIdx = tabIdx
end

function SKTDreamTeamView:_getCurTabIdx()
	return self._curTabIdx
end

function SKTDreamTeamView:_getCurRankId()
	local info = self:_getTabInfo(self:_getCurTabIdx())

	return (info or nil) and (info.rankId or 0)
end

function SKTDreamTeamView:_getTabInfo(tabIdx)
	return self._tabInfoList[tabIdx]
end

function SKTDreamTeamView:_onUpdateRankColUI()
	local list = SaintKnightTaskModel.instance:getCollectionTasksRankInfoList(self:_getCurRankId())
	local infoList = {}

	for i = 1, 20 do
		if list[i] then
			table.insert(infoList, list[i])
		else
			break
		end
	end

	self._rankScrollList:reloadData(infoList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
	GameUtil.SetActive(self._emptyGo, #infoList <= 0)

	local data = SaintKnightTaskConfig.instance:getSktRankData(self._activityId, self:_getCurTabIdx())

	if data then
		local str
		local children = GameUtil.getChildren(self._filedView)

		for idx, go in ipairs(children) do
			go:GetComponent(goutil.Type_UIText).text = data.fields[idx] or ""
		end
	end
end

function SKTDreamTeamView:_onClearRankCol()
	self._rankScrollList:dispose()
end

function SKTDreamTeamView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
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

	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickCell, self, info, cell))
end

function SKTDreamTeamView:_onClickCell(info, go)
	FriendController.instance:showInfoView(info.headInfo.userId, go)
end

function SKTDreamTeamView:_clearRankCell(cell)
	GameUtil.rmClickHandler(cell)
end

function SKTDreamTeamView:_onUpdateColRewardColUI()
	local isHasGain = SaintKnightTaskModel.instance:isHasGainAsCollePrize()
	local isCanGain = SaintKnightTaskModel.instance:isCanGainAsCollePrize()

	GameUtil.SetActive(self._colRewardCol._receiveGo, isHasGain)
	GameUtil.SetActive(self._colRewardCol._btnGet, not isHasGain)
	GameUtil.SetGray(self._colRewardCol._btnGet, isHasGain or not isCanGain)
end

function SKTDreamTeamView:_onClickBtnGetOfColReward()
	if not SaintKnightTaskModel.instance:isCanGainAsCollePrize() then
		FloatWordMgr.instance:show("集齐阵容中所有精灵后，即可领取噢")

		return
	end

	if SaintKnightTaskModel.instance:isHasGainAsCollePrize() then
		return
	end

	SaintKnightTaskController.instance:sendCollectionTasksGainPrizeReq(self._activityId)
end

function SKTDreamTeamView:_onUpdatVerRewardColUI()
	local isPassVerify = SaintKnightTaskModel.instance:isPassVerify()
	local isGainVerify = SaintKnightTaskModel.instance:isGainVerifyPrize()

	GameUtil.SetActive(self._verRewardCol._receiveGo, isGainVerify)
	GameUtil.SetActive(self._verRewardCol._btnGet, not isGainVerify)
	GameUtil.SetGray(self._verRewardCol._btnGet, not isPassVerify)
end

function SKTDreamTeamView:_onClickBtnGetOfVerReward()
	if not SaintKnightTaskModel.instance:isPassVerify() then
		FloatWordMgr.instance:show("通过战力验证后，即可领取哦")

		return
	end

	if SaintKnightTaskModel.instance:isGainVerifyPrize() then
		return
	end

	SaintKnightTaskController.instance:sendSKGainVerifyPrizeReq(self._activityId)
end

function SKTDreamTeamView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.SKTDreamTeamRankView)
end

function SKTDreamTeamView:_onClickBtnVerify()
	SaintKnightTaskController.instance:enterFormationAsSkt(self._activityId)
end

return SKTDreamTeamView
