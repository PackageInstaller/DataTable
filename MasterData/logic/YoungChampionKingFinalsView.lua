-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingFinalsView.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingFinalsView", package.seeall)

local YoungChampionKingFinalsView = class("YoungChampionKingFinalsView", ViewComponent)

function YoungChampionKingFinalsView:ctor()
	YoungChampionKingFinalsView.super.ctor(self)
end

function YoungChampionKingFinalsView:unbindEvents()
	YoungChampionKingFinalsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnVote)
	GameUtil.rmClickHandler(self._btnGainCoin)
	GameUtil.rmClickHandler(self._btnVoteRecord)
	GameUtil.rmClickHandler(self._btnRecord)
end

function YoungChampionKingFinalsView:bindEvents()
	YoungChampionKingFinalsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnVote, self._onClickVote, self)
	GameUtil.addClickHandler(self._btnGainCoin, self._onClickGainCoin, self)
	GameUtil.addClickHandler(self._btnVoteRecord, self._onClickVoteRecord, self)
	GameUtil.addClickHandler(self._btnRecord, self._onClickRecord, self)
end

function YoungChampionKingFinalsView:buildUI()
	YoungChampionKingFinalsView.super.buildUI(self)

	self._btnVote = self:getGo("colBtns/btnVote")
	self._btnGainCoin = self:getGo("colBtns/btnGainCoin")
	self._redPointBtnGainCoin = self:getGo("colBtns/btnGainCoin/redPoint")
	self._btnVoteRecord = self:getGo("colBtns/btnVoteRecord")
	self._btnRecord = self:getGo("colBtns/btnRecord")
	self._cellLeftRole = self:buildRoleCell(self:getGo("leftRole"))
	self._cellRightRole = self:buildRoleCell(self:getGo("rightRole"))
	self._txtTime = self:getTxt("txtTime")
	self._imgTitleChange = self:getGo("imgTitle"):GetComponent("UIImageSpriteChange")
end

function YoungChampionKingFinalsView:buildRoleCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.infoCom = goutil.findChild(cell.go, "infoCom")
	cell.txtPower = goutil.findChildTextComponent(cell.go, "infoCom/txtPower")
	cell.txtNameShow = goutil.findChildTextComponent(cell.go, "infoCom/txtNameShow")
	cell.head = goutil.findChild(cell.go, "head")
	cell.result = goutil.findChild(cell.go, "result")
	cell.resultChange = cell.result:GetComponent("UIImageSpriteChange")
	cell.medal = goutil.findChild(cell.go, "medal")
	cell.medalChange = cell.medal:GetComponent("UIImageSpriteChange")
	cell.role = goutil.findChild(cell.go, "role")
	cell.photoEff = AvatarPhotoShow.Get(cell.role)

	cell.photoEff:setRawWidthAndHeight(1280, 720)
	cell.photoEff:setCameraPosition(0, 1, -2)
	cell.photoEff:setCamSize(2.2)

	cell.avatar = nil
	cell.markList = {}

	for i = 1, 3 do
		local cellMark = {}

		cellMark.go = goutil.findChild(cell.go, "colMark/mark_" .. i)
		cellMark.mark = goutil.findChild(cellMark.go, "mark")
		cellMark.change = goutil.findChildComponent(cellMark.go, "mark", "UIImageSpriteChange")
		cell.markList[i] = cellMark
	end

	return cell
end

function YoungChampionKingFinalsView:onExit()
	YoungChampionKingFinalsView.super.onExit(self)
	HeadItemController.instance:resetHeadCell(self._cellLeftRole.head)
	HeadItemController.instance:resetHeadCell(self._cellRightRole.head)
	self._cellLeftRole.photoEff:clear()
	self._cellRightRole.photoEff:clear()

	self._cellLeftRole.avatar = nil
	self._cellRightRole.avatar = nil

	removetimer(self._updateTimer, self)
	RedPointController.instance:regRedPoint(self._redPointBtnGainCoin, RedPointModel.ID_YOUNG_CHAMPION_KING_GAIN_COIN)
end

function YoungChampionKingFinalsView:onEnter()
	YoungChampionKingFinalsView.super.onEnter(self)

	self._activityId = YoungChampionKingModel.instance:getCurActId()

	local params = self:getOpenParam()

	self._enterRoundId = checknumber(params[1])
	self._groupId = 1

	self:_updateUIByInfo()
	self.addGEvent(self, GlobalNotify.PM_YCKStepChange, self._onStepChange, self)
	self.addGEvent(self, GlobalNotify.PM_YCKGetKnockoutScheduleRes, self._updateUIByInfo, self)
	self:_onStepChange()
	self:_updateTimeTxt()
	RedPointController.instance:regRedPoint(self._redPointBtnGainCoin, RedPointModel.ID_YOUNG_CHAMPION_KING_GAIN_COIN)
end

function YoungChampionKingFinalsView:_onStepChange(nextStep)
	YoungChampionKingController.instance:sendPM_YCKGetKnockoutScheduleReq(self._activityId, self._groupId, self._enterRoundId)
end

function YoungChampionKingFinalsView:_updateUIByInfo()
	self._curInfo = YoungChampionKingController.instance:getKnockoutScheduleMatchInfo(self._enterRoundId, 1, 1)

	if self._enterRoundId == YoungChampionKingEnum.Third_Place_Match_Round_Id then
		self._imgTitleChange:SetState(0)
	elseif self._enterRoundId == YoungChampionKingEnum.Final_Match_Round_Id then
		self._imgTitleChange:SetState(1)
	end

	if self._curInfo then
		local playerA = self._curInfo.playerA
		local playerB = self._curInfo.playerB

		self:_setCellRoleInfo(self._cellLeftRole, playerA)
		self:_setCellRoleInfo(self._cellRightRole, playerB)

		if self._curInfo then
			if not self._curInfo.reports then
				local records = {}
				local leftWinCount = 0
				local rightWinCount = 0

				for i, record in ipairs(records) do
					goutil.setActive(self._cellLeftRole.markList[i].mark, true)
					goutil.setActive(self._cellRightRole.markList[i].mark, true)

					local isLeftWin = checknumber(record.winPlayerId) == checknumber(playerA.headInfo.headInfo.userId)

					self._cellLeftRole.markList[i].change:SetState(isLeftWin and 0 or 1)
					self._cellRightRole.markList[i].change:SetState(isLeftWin and 1 or 0)

					if isLeftWin then
						leftWinCount = leftWinCount + 1
					else
						rightWinCount = rightWinCount + 1
					end
				end

				local getFinalResult = leftWinCount + rightWinCount > 1.5 and leftWinCount ~= rightWinCount

				if getFinalResult then
					goutil.setActive(self._cellRightRole.result, true)
					goutil.setActive(self._cellLeftRole.result, true)
					self._cellRightRole.resultChange:SetState(rightWinCount < leftWinCount and 1 or 0)
					self._cellLeftRole.resultChange:SetState(rightWinCount < leftWinCount and 0 or 1)
					goutil.setActive(self._cellRightRole.medal, true)
					goutil.setActive(self._cellLeftRole.medal, true)

					if self._enterRoundId == YoungChampionKingEnum.Third_Place_Match_Round_Id then
						self._cellRightRole.medalChange:SetState(rightWinCount < leftWinCount and 3 or 2)
						self._cellLeftRole.medalChange:SetState(rightWinCount < leftWinCount and 2 or 3)
					elseif self._enterRoundId == YoungChampionKingEnum.Final_Match_Round_Id then
						self._cellRightRole.medalChange:SetState(rightWinCount < leftWinCount and 1 or 0)
						self._cellLeftRole.medalChange:SetState(rightWinCount < leftWinCount and 0 or 1)
					end
				else
					goutil.setActive(self._cellRightRole.result, false)
					goutil.setActive(self._cellLeftRole.result, false)
					goutil.setActive(self._cellRightRole.medal, false)
					goutil.setActive(self._cellLeftRole.medal, false)
				end
			end
		end
	else
		self:_setCellRoleInfo(self._cellLeftRole)
		self:_setCellRoleInfo(self._cellRightRole)
	end
end

function YoungChampionKingFinalsView:_updateTimeTxt()
	self._startRoundId = self._enterRoundId
	self._endRoundId = self._enterRoundId

	local curStepId = YoungChampionKingModel.instance:getCurStepId()

	self._curStepCfg = YoungChampionKingConfig.instance:getStepCfg(self._activityId, curStepId)

	local nextStepCfg = YoungChampionKingConfig.instance:getStepCfg(self._activityId, curStepId + 1)
	local curRoundId = YoungChampionKingController.instance:getRoundIdByStepId(curStepId)

	self._txtTime.text = ""

	if curRoundId < self._startRoundId then
		self._txtTime.text = ""
	elseif curRoundId > self._endRoundId then
		self._txtTime.text = "本轮比赛已结束"
	else
		self._nextStageTime = GameUtil.string2time(nextStepCfg.startTime)
		self._txtTime.text = ""

		settimer(1, self._updateTimer, self, true)
	end
end

function YoungChampionKingFinalsView:_updateTimer()
	local timer = self._nextStageTime - ServerTime.now()

	if timer <= 0 then
		removetimer(self._updateTimer, self)
		self:_updateTimeTxt()
	end

	local timeStr = GameUtil.FormatTimeSymbol(timer)

	self._txtTime.text = (self._curStepCfg.canGuss and "距离战斗开始剩余：" or "距离战斗结束剩余：") .. timeStr
end

function YoungChampionKingFinalsView:_setCellRoleInfo(cellRole, playerInfo)
	local cell = cellRole

	if cell then
		for i, cellMark in ipairs(cell.markList) do
			goutil.setActive(cellMark.mark, false)
		end

		if not playerInfo then
			goutil.setActive(cell.infoCom, false)
			goutil.setActive(cell.role, false)
		else
			goutil.setActive(cell.role, true)
			goutil.setActive(cell.infoCom, true)

			local headInfo = playerInfo.headInfo.headInfo

			cell.txtNameShow.text = string.format("s%03d-%s", playerInfo.areaId, headInfo.userName)
			cell.txtPower.text = playerInfo.zdl

			HeadItemController.instance:setHeadCellByInfo(cell.head, headInfo, true)

			local skId = DressModel.instance:getSkeIdByGender(playerInfo.gender)
			local mo = DressModel.instance:getAvatarPlayerMo(skId, (not playerInfo.clothes or nil) and {}, 0)
			local avatar = cell.avatar

			if avatar then
				avatar:updateByMo(mo)
			else
				avatar = AvatarsMgrNew.instance:getAvatarByMo(mo)
				avatar.useType = AvatarUseType.Scene
				cell.avatar = avatar

				cell.photoEff:addShowAvatarEffect(avatar)
			end
		end
	end
end

function YoungChampionKingFinalsView:_onClickVote()
	local curStepId = YoungChampionKingModel.instance:getCurStepId()
	local curRoundId = YoungChampionKingController.instance:getRoundIdByStepId(curStepId)
	local curStepCfg = YoungChampionKingConfig.instance:getStepCfg(self._activityId, curStepId)
	local isCanVote = curRoundId == self._enterRoundId and curStepCfg and curStepCfg.canGuss

	if isCanVote then
		if not self._curInfo or not self._curInfo.playerA or not self._curInfo.playerB then
			TipsFacade.instance:openCommonTips("当前不可应援")

			return
		end

		UIStateManager.instance:push(ViewName.YoungchampionkingsupportView, self._activityId, self._curInfo, self._enterRoundId, self._groupId)
	else
		TipsFacade.instance:openCommonTips("当前不可应援")
	end
end

function YoungChampionKingFinalsView:_onClickGainCoin()
	self._curStepId = YoungChampionKingModel.instance:getCurStepId()
	self._curRoundId = YoungChampionKingController.instance:getRoundIdByStepId(self._curStepId)

	UIStateManager.instance:push(ViewName.YoungChampionKingGainCoinView)
end

function YoungChampionKingFinalsView:_onClickVoteRecord()
	UIStateManager.instance:push(ViewName.YoungchampionkingsupportrecordView, self._activityId)
end

function YoungChampionKingFinalsView:_onClickRecord()
	if self._curInfo then
		if not self._curInfo.reports then
			local records = {}
			local dataList = {}

			for i, record in ipairs(records) do
				local data = {}

				data.leftHeadInfo = self._curInfo.playerA.headInfo.headInfo
				data.leftZdl = record.playerAZdl
				data.rightHeadInfo = self._curInfo.playerB.headInfo.headInfo
				data.rightZdl = record.playerBZdl
				data.stepId = YoungChampionKingEnum.Champion_Start_Step_Id

				local roundName = YoungChampionKingController.instance:getCurRoundNameByStepId(record.stepId)

				data.showTxt = string.format("第%s场", i)
				data.isLeftWin = checknumber(record.winPlayerId) == checknumber(data.leftHeadInfo.userId)
				data.battleId = record.battleId

				table.insert(dataList, data)
			end

			UIStateManager.instance:push(ViewName.YoungChampionKingBattleResultView, dataList)
		end
	end
end

return YoungChampionKingFinalsView
