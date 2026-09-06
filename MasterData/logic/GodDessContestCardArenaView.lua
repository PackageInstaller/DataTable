-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/card/GodDessContestCardArenaView.lua

module("logic.extensions.goddesscontest.view.card.GodDessContestCardArenaView", package.seeall)

local GodDessContestCardArenaView = class("GodDessContestCardArenaView", ViewComponent)

function GodDessContestCardArenaView:ctor()
	GodDessContestCardArenaView.super.ctor(self)
end

function GodDessContestCardArenaView:buildUI()
	GodDessContestCardArenaView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._btnBag = goutil.findChild(self.mainGO, "btnBag")
	self._btnAdjust = goutil.findChild(self.mainGO, "btnAdjust")
	self._flowerView = goutil.findChild(self.mainGO, "flowerView")
	self._detailView = goutil.findChild(self.mainGO, "detailView")
	self._detailView_scoreCell = goutil.findChild(self.mainGO, "detailView/scoreCell")

	if self._detailView_scoreCell then
		self._detailView_scoreCell_txtPublicTime = goutil.findChildTextComponent(self.mainGO, "detailView/scoreCell/txtPublicTime")
		self._detailView_scoreCell_cardView = goutil.findChild(self.mainGO, "detailView/scoreCell/cardView")
		self._detailView_scoreCell_cardCellList = {}

		local cardCellList = GameUtil.getChildren(self._detailView_scoreCell_cardView)

		for idx, go in ipairs(cardCellList) do
			local cell = {}

			cell._mainGo = go
			cell._txtValue = goutil.findChildTextComponent(cell._mainGo, "txtValue")
			self._detailView_scoreCell_cardCellList[idx] = cell
		end
	end

	self._detailView_rankCell = goutil.findChild(self.mainGO, "detailView/rankCell")

	if self._detailView_rankCell then
		self._detailView_rankCell_txtPublicTime = goutil.findChildTextComponent(self.mainGO, "detailView/rankCell/txtPublicTime")
		self._detailView_rankCell_cardView = goutil.findChild(self.mainGO, "detailView/rankCell/cardView")
		self._detailView_rankCell_cardCellList = {}

		local cardCellList = GameUtil.getChildren(self._detailView_rankCell_cardView)

		for idx, go in ipairs(cardCellList) do
			local cell = {}

			cell._mainGo = go
			cell._txtValue = goutil.findChildTextComponent(cell._mainGo, "txtValue")
			self._detailView_rankCell_cardCellList[idx] = cell
		end
	end
end

function GodDessContestCardArenaView:bindEvents()
	GodDessContestCardArenaView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnBag, self._onClickBtnBag, self)
	GameUtil.addClickHandler(self._btnAdjust, self._onClickBtnAdjust, self)
end

function GodDessContestCardArenaView:unbindEvents()
	GodDessContestCardArenaView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBag)
	GameUtil.rmClickHandler(self._btnAdjust)
end

function GodDessContestCardArenaView:destroyUI()
	GodDessContestCardArenaView.super.destroyUI(self)
end

function GodDessContestCardArenaView:onEnter()
	GodDessContestCardArenaView.super.onEnter(self)
	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_GoddessContestCardDayOnceRed)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = GoddessContestController.instance:getActivityId()
	end

	self._activityType = GoddessContestController.instance:getActivityType()

	local isInTime = GoddessContestController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._cardStepMgr = GoddessContestController.instance:gdcCardStepMgrOnEnter(self._activityId)
	self._curStepId = GoddessContestController.instance:getCurStep(self._activityId)
	self._curInterval = GoddessContestController.instance:getStepInterval(self._activityId, self._curStepId)

	self.addGEvent(self, GlobalNotify.GoddessContestGetInfo, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.GoddessContestCardConIntervalChange, self._sendInfoReq, self)
	self.addGEvent(self, GlobalNotify.handlePM_GoddessContestGetCardInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_GoddessContestSetCardRes, self._sendInfoReq, self)
	self.addGEvent(self, GlobalNotify.handlePM_GoddessContestFlopRes, self._onUpdate, self)
	self:_sendInfoReq()
end

function GodDessContestCardArenaView:onExit()
	GodDessContestCardArenaView.super.onExit(self)

	if self._cardStepMgr then
		GoddessContestController.instance:gdcCardStepMgrOnExit(self._activityId)

		self._cardStepMgr = nil
	end

	self:_onClear()
end

function GodDessContestCardArenaView:_sendInfoReq()
	GoddessContestController.instance:sendPM_GoddessContestGetCardInfoReq(self._activityId)
end

function GodDessContestCardArenaView:_onUpdate()
	self._curStepId = GoddessContestController.instance:getCurStep(self._activityId)
	self._curInterval = GoddessContestController.instance:getStepInterval(self._activityId, self._curStepId)

	self:_onUpdatePlaneUI()
	self:_onUpdateFlowerColUI()
	self:_onUpdateDetailColUI()
end

function GodDessContestCardArenaView:_onClear()
	self:_onClearFlowerCol()
	self:_onClearDetailCol()
end

function GodDessContestCardArenaView:_onUpdatePlaneUI()
	local fields = GdcCardEnum.ActStepTimeFields[GdcCardEnum.ActStepType_Contest]
	local stepData = GoddessContestConfig.instance:getCardStepData(self._activityId, self._curStepId)

	if fields and stepData then
		local startStamp, endStamp = GameUtil.string2time(stepData[fields[1]]), GameUtil.string2time(stepData[fields[2]])

		self._txtOpenTime.text = string.format("第%s轮塔罗牌比拼时间：%s", self._curStepId, GameUtil.getFormatTimeByStamp(startStamp, endStamp))
	else
		self._txtOpenTime.text = string.format("第%s轮塔罗牌比拼时间", self._curStepId)
	end
end

function GodDessContestCardArenaView:_onUpdateFlowerColUI()
	local cfg = GoddessContestConfig.instance:getFanGroupCfgsByActId(self._activityId)
	local childCount = self._flowerView.transform.childCount

	if childCount ~= #cfg then
		printError(string.format("女神数量与预制数量不同，请检查配置或预制( n女神大赛.xlsx | 粉丝团配置 | activityId = %s )", self._activityId))
	end

	for idx, data in ipairs(cfg) do
		if idx <= childCount then
			local mainGo = self._flowerView.transform:GetChild(idx - 1).gameObject

			self:_updateFlowerCell(mainGo, data, idx)
		end
	end
end

function GodDessContestCardArenaView:_onClearFlowerCol()
	for idx = 1, self._flowerView.transform.childCount do
		local mainGo = self._flowerView.transform:GetChild(idx - 1).gameObject

		self:_clearFlowerCell(mainGo)
	end
end

function GodDessContestCardArenaView:_updateFlowerCell(mainGo, data, index)
	local fansGroupId = index
	local totalVoteNum = GoddessContestModel.instance:getTotalVoteNumInFgc(fansGroupId)
	local imgHead = goutil.findChild(mainGo, "imgHead")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtValue = goutil.findChildTextComponent(mainGo, "txtValue")
	local iconName = goutil.findChildTextComponent(mainGo, "iconName/txt")

	GameUtil.setUIImageSpriteIdx(imgHead, fansGroupId - 1)

	iconName.text = data.fansGroupName
	txtValue.text = string.format("共%s人气", totalVoteNum)
	txtName.text = string.format("女神组%s", index)
end

function GodDessContestCardArenaView:_clearFlowerCell(mainGo)
	return
end

function GodDessContestCardArenaView:_onUpdateDetailColUI()
	local cardGridNum = GoddessContestController.instance:getCardGridNum(self._activityId)

	self._groupCellGoList = {}

	for idx = 1, cardGridNum do
		local mainGo = goutil.findChild(self._detailView, "groupCell" .. idx)

		if goutil.isNil(mainGo) then
			printError(string.format("预制为空( idx = %s )", idx))
		else
			table.insert(self._groupCellGoList, mainGo)
		end
	end

	for idx, mainGo in ipairs(self._groupCellGoList) do
		self:_updateGroupCell(mainGo, idx)
	end

	if self._curInterval >= GdcCardEnum.ConInterval_Public then
		for fansGroupId, cell in ipairs(self._detailView_scoreCell_cardCellList) do
			cell._txtValue.text = GoddessContestModel.instance:getContestScoreInFgc(fansGroupId)
		end

		for fansGroupId, cell in ipairs(self._detailView_rankCell_cardCellList) do
			cell._txtValue.text = GoddessContestModel.instance:getGroupRankInFgc(fansGroupId)
		end

		GameUtil.SetActive(self._detailView_scoreCell_cardView.gameObject, true)
		GameUtil.SetActive(self._detailView_rankCell_cardView.gameObject, true)
		GameUtil.SetActive(self._detailView_scoreCell_txtPublicTime.gameObject, false)
		GameUtil.SetActive(self._detailView_rankCell_txtPublicTime.gameObject, false)
	else
		GameUtil.SetActive(self._detailView_scoreCell_cardView.gameObject, false)
		GameUtil.SetActive(self._detailView_rankCell_cardView.gameObject, false)

		local stepData = GoddessContestConfig.instance:getCardStepData(self._activityId, self._curStepId)

		if stepData then
			local startStamp = GameUtil.string2time(stepData.publicationTime)

			self._detailView_scoreCell_txtPublicTime.text = string.format("%s 公布", GameUtil.getFormatTimeByStamp(startStamp, nil))
		else
			self._detailView_scoreCell_txtPublicTime.text = "未知时间 公布"
		end

		GameUtil.SetActive(self._detailView_scoreCell_txtPublicTime.gameObject, true)

		if stepData then
			local startStamp = GameUtil.string2time(stepData.publicationTime)

			self._detailView_rankCell_txtPublicTime.text = string.format("%s 公布", GameUtil.getFormatTimeByStamp(startStamp, nil))
		else
			self._detailView_rankCell_txtPublicTime.text = "未知时间 公布"
		end

		GameUtil.SetActive(self._detailView_rankCell_txtPublicTime.gameObject, true)
	end
end

function GodDessContestCardArenaView:_onClearDetailCol()
	if self._groupCellGoList then
		for _, mainGo in ipairs(self._groupCellGoList) do
			self:_clearGroupCell(mainGo)
		end
	end
end

function GodDessContestCardArenaView:_updateGroupCell(mainGo, idx)
	local txtGroupName = goutil.findChildTextComponent(mainGo, "txtGroupName")
	local cardView = goutil.findChild(mainGo, "cardView")

	txtGroupName.text = string.format("%s组", GdcCardEnum.CardGroupNames[idx])

	for fansGroupId = 1, cardView.transform.childCount do
		local cardCell = cardView.transform:GetChild(fansGroupId - 1).gameObject
		local txtValue = goutil.findChildTextComponent(cardCell, "txtValue")
		local cardNumList = GoddessContestModel.instance:getCardNumListInFgc(fansGroupId)

		if not cardNumList[idx] then
			if self._curInterval >= GdcCardEnum.ConInterval_Public then
				txtValue.text = cardNumList[idx]
			else
				local myGroupId = GoddessContestModel.instance:getCurGroupId()

				if myGroupId == fansGroupId then
					local grade = GoddessContestModel.instance:getCurGrade()

					txtValue.text = grade <= 3 and (cardNumList[idx] == 0 and "未布置" or cardNumList[idx]) or "布置中"
				else
					txtValue.text = "?"
				end
			end
		end
	end
end

function GodDessContestCardArenaView:_clearGroupCell(mainGo)
	return
end

function GodDessContestCardArenaView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("goddesscontestcardmainview_rule")
end

function GodDessContestCardArenaView:_onClickBtnBag()
	UIStateManager.instance:push(ViewName.GodDessContestCardBagView, self._activityId)
end

function GodDessContestCardArenaView:_onClickBtnAdjust()
	if not GoddessContestController.instance:isEnoughAdjustCardGrade() then
		FloatWordMgr.instance:show("只有团长可以布置塔罗牌")

		return
	end

	if self._curInterval >= GdcCardEnum.ConInterval_Public or self._curInterval < GdcCardEnum.ConInterval_Set then
		FloatWordMgr.instance:show("不在调整阶段内")

		return
	end

	UIStateManager.instance:push(ViewName.GodDessContestCardAdjustView, self._activityId)
end

return GodDessContestCardArenaView
