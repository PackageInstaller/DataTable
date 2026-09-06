-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKFinalsView.lua

module("logic.extensions.teenchampionking.view.TCKFinalsView", package.seeall)

local TCKFinalsView = class("TCKFinalsView", ViewComponent)

function TCKFinalsView:ctor()
	TCKFinalsView.super.ctor(self)
end

TCKFinalsView.Type = {
	Left = 1,
	Right = 2
}

function TCKFinalsView:unbindEvents()
	TCKFinalsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSwtich)
	GameUtil.rmClickHandler(self._btnVote)
	GameUtil.rmClickHandler(self._btnGainCoin)
	GameUtil.rmClickHandler(self._btnVoteRecord)
	GameUtil.rmClickHandler(self._btnRecord)
end

function TCKFinalsView:bindEvents()
	TCKFinalsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSwtich, self._onClickBtnSwtich, self)
	GameUtil.addClickHandler(self._btnVote, self._onClickVote, self)
	GameUtil.addClickHandler(self._btnGainCoin, self._onClickGainCoin, self)
	GameUtil.addClickHandler(self._btnVoteRecord, self._onClickVoteRecord, self)
	GameUtil.addClickHandler(self._btnRecord, self._onClickRecord, self)
end

function TCKFinalsView:buildUI()
	TCKFinalsView.super.buildUI(self)

	self._modelCam = self:getGo("modelCam")

	local rolePoint1 = self:getGo("modelCam/rolePoint_1")

	self._avatarLeft = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	self._avatarLeft:setParent(rolePoint1.transform)
	self._avatarLeft:setLayer(SceneLayer.UI3D_Value)

	local rolePoint2 = self:getGo("modelCam/rolePoint_2")

	self._avatarRight = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	self._avatarRight:setParent(rolePoint2.transform)
	self._avatarRight:setLayer(SceneLayer.UI3D_Value)

	self._txtOpenTime = self:getTxt("mask/txtOpenTime")
	self._btnSwtich = self:getGo("colGroup/btnSwtich")
	self._txtBtnSwtich = self:getTxt("colGroup/btnSwtich/txt")
	self._cellGoGroup = self:getGo("colGroup/cell")
	self._tableviewGoGroup = self:getGo("colGroup/tableview")
	self._tableviewGroup = ScrollerList.create(self._tableviewGoGroup, self._cellGoGroup, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self:_buildParts()

	self._btnVoteRecord = self:getGo("colBtns/btnVoteRecord")
	self._btnRecord = self:getGo("colBtns/btnRecord")
	self._btnVote = self:getGo("colBtns/btnVote")
	self._btnGainCoin = self:getGo("colBtns/btnGainCoin")
	self._redPoint = self:getGo("colBtns/btnGainCoin/redPoint")
	self._tableviewRank = self:getGo("rank/tableview")
	self._tablecellRank = self:getGo("rank/tableview/tablecell")
	self._rank = self:getGo("rank")
	self._tableview = ScrollerList.create(self._tableviewRank, self._tablecellRank, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function TCKFinalsView:_buildParts()
	local left = self:getGo("leftRole")
	local right = self:getGo("rightRole")

	self._leftRole = self:getGo("leftRole")
	self._rightRole = self:getGo("rightRole")
	self._parts = {}

	self:_buildPart(left, TCKFinalsView.Type.Left)
	self:_buildPart(right, TCKFinalsView.Type.Right)
end

function TCKFinalsView:_buildPart(root, posType)
	local var_6_0 = {
		goHead = goutil.findChild(root, "head"),
		txtNameShow = goutil.findChildTextComponent(root, "infoCom/txtNameShow"),
		txtPower = goutil.findChildTextComponent(root, "infoCom/txtPower"),
		result = goutil.findChild(root, "result")
	}

	var_6_0.resultChange = goutil.findChild(root, "result"):GetComponent("UIImageSpriteChange")
	var_6_0.scorePart = goutil.findChild(root, "score")
	var_6_0.txtScore = goutil.findChildTextComponent(root, "score/txt")
	var_6_0.rank = goutil.findChild(root, "rank")
	var_6_0.rankChange = goutil.findChild(root, "rank"):GetComponent("UIImageSpriteChange")
	var_6_0.txtRank = goutil.findChildTextComponent(root, "rank/txt")
	var_6_0.posType = posType
	self._parts[posType] = var_6_0
end

function TCKFinalsView:onExit()
	TCKFinalsView.super.onExit(self)
	LightMgr.instance:setLightForNormalScene()
	goutil.addChildToParent(self._modelCam, self.mainGO)
	GlobalModel.instance:visibleSceneHUDs(true)

	for k, posType in pairs(TCKFinalsView.Type) do
		local item = self._parts[posType]

		HeadItemController.instance:resetHeadCell(item.goHead)
	end

	removetimer(self._updateTimer, self)
	self._tableviewGroup:dispose()
	self._tableview:dispose()
	RedPointController.instance:unregRedPoint(self._redPoint)
end

function TCKFinalsView:destroyUI()
	TCKFinalsView.super.destroyUI(self)

	if self._avatarLeft then
		AvatarsMgrNew.instance:removeAvatar(self._avatarLeft)

		self._avatarLeft = nil
	end

	if self._avatarRight then
		AvatarsMgrNew.instance:removeAvatar(self._avatarRight)

		self._avatarRight = nil
	end
end

function TCKFinalsView:onEnter()
	TCKFinalsView.super.onEnter(self)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	goutil.addChildToParent(self._modelCam)
	GlobalModel.instance:visibleSceneHUDs(false)
	self.addGEvent(self, GlobalNotify.PM_TCKStepChange, self._onStepChange, self)
	self.addGEvent(self, GlobalNotify.PM_TCKStepChange, self._onStepChange, self)
	self.addGEvent(self, GlobalNotify.PM_TCKKnockoutSchedule, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.PM_TCKGuessChampionship, self._handleGuess, self)
	self.addGEvent(self, GlobalNotify.PM_TCKGetMyKnockoutInfo, self._handleGetRoomInfo, self)

	local params = self:getOpenParam()

	self._activityId = params and checknumber(params[1]) or 501001
	self._enterRoundId = params and checknumber(params[2]) or TeenChampionKingController.ROUND_CHAMPIONSHIP_MIN

	self:_updateUIByCfg()
	self:_updateTimeTxt()

	self._txtOpenTime.text = ""

	goutil.setActive(self._leftRole, false)
	goutil.setActive(self._rightRole, false)
	RedPointController.instance:regRedPoint(self._redPoint, RedPointModel.ID_TEEN_CHAMPION_KING_GUESS_ITEM)

	local info = TeenChampionKingModel.instance:getGlobalInfo(self._activityId)
	local curRoundId = TeenChampionKingConfig.instance:getRoundIdByStepId(self._activityId, (info or nil) and info.curStepId)

	if curRoundId > TeenChampionKingController.ROUND_CHAMPIONSHIP_MAX then
		self:_onSwitchGroup(1)
		goutil.setActive(self._leftRole, true)
		goutil.setActive(self._rightRole, true)
	else
		TeenChampionKingController.instance:getMyKnockoutInfo(self._activityId)
	end
end

function TCKFinalsView:_updateUIByCfg()
	self._totalGroupNum = 4
	self._curGroupIdList = {}

	for i = 1, self._totalGroupNum do
		table.insert(self._curGroupIdList, i)
	end
end

function TCKFinalsView:_updateTimeTxt()
	self._startRoundId = self._enterRoundId
	self._endRoundId = self._enterRoundId

	local curStepId = 0
	local info = TeenChampionKingModel.instance:getGlobalInfo(self._activityId)

	if info then
		curStepId = info.curStepId
	end

	self._curStepCfg = TeenChampionKingConfig.instance:getStepCfgByStepId(self._activityId, curStepId)

	local nextStepCfg = TeenChampionKingConfig.instance:getStepCfgByStepId(self._activityId, curStepId + 1)
	local curRoundId = TeenChampionKingConfig.instance:getRoundIdByStepId(self._activityId, curStepId)

	self._txtOpenTime.text = ""

	if curRoundId < self._startRoundId then
		self._txtOpenTime.text = ""
	elseif curRoundId > self._endRoundId then
		self._txtOpenTime.text = "本轮比赛已结束"
	else
		self._nextStageTime = GameUtil.string2time(nextStepCfg.startTime)
		self._txtOpenTime.text = ""

		settimer(1, self._updateTimer, self, true)
	end
end

function TCKFinalsView:_updateTimer()
	local timer = self._nextStageTime - ServerTime.now()

	if timer <= 0 then
		removetimer(self._updateTimer, self)
		self:_updateTimeTxt()
	end

	local timeStr = GameUtil.FormatTimeSymbol(timer)

	self._txtOpenTime.text = (not self._curStepCfg.needKnockoutRoom and "距离战斗开始剩余：" or "距离战斗结束剩余：") .. timeStr
end

function TCKFinalsView:onEnterFinished()
	TCKFinalsView.super.onEnterFinished(self)
	TeenChampionKingController.instance:getMyKnockoutInfo(self._activityId)
end

function TCKFinalsView:_handleGetRoomInfo()
	goutil.setActive(self._leftRole, true)
	goutil.setActive(self._rightRole, true)

	self._groupId = 1
	self._myGroupId = -1

	local info = TeenChampionKingModel.instance:getMyKnockoutInfo(self._activityId)
	local myKnockoutInfo = info.knockoutInfo

	if myKnockoutInfo then
		local matchId = myKnockoutInfo.groupId
		local matchRoundId = myKnockoutInfo.roundId

		if matchRoundId == self._enterRoundId then
			self._groupId = matchId
			self._myGroupId = self._groupId
		end
	end

	self:_onSwitchGroup(self._groupId)
end

function TCKFinalsView:_onStepChange(newStepId)
	self:_onSwitchGroup(self._curGroupId)
end

function TCKFinalsView:_handleGetInfo(viewGroupId)
	self._curGroupId = viewGroupId

	goutil.setActive(self._tableviewGoGroup, false)

	self._txtBtnSwtich.text = string.format("第%s组", GameUtil.getChineseNumber(self._curGroupId))

	self:_updateGroupMatch()
end

function TCKFinalsView:_updateCell(view, cell, data)
	GameUtil.addClickHandler(cell.gameObject, GameUtil.handler(self._onSwitchGroup, self, data))

	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")

	txtName.text = string.format("第%s组", GameUtil.getChineseNumber(data))

	local changeGroup = cell.gameObject:GetComponent(ComponentType.UIChangeGroup)

	changeGroup:SetState(self._curGroupId == data and 1 or 0)

	local mark = goutil.findChild(cell.gameObject, "mark")

	goutil.setActive(mark, self._myGroupId == data)
end

function TCKFinalsView:_clearCell(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

function TCKFinalsView:_onSwitchGroup(groupId)
	TeenChampionKingController.instance:getKnockoutSchedule(self._activityId, groupId, self._enterRoundId)
end

function TCKFinalsView:_handleGuess()
	self:_updateGroupMatch()
end

function TCKFinalsView:_updateGroupMatch()
	self._isShowScore = true
	self._curStepId = 0
	self._curRoundId = 0

	local info = TeenChampionKingModel.instance:getGlobalInfo(self._activityId)

	if info then
		self._curStepId = info.curStepId
	end

	self._curRoundId = TeenChampionKingConfig.instance:getRoundIdByStepId(self._activityId, self._curStepId)
	self._curStepCfg = TeenChampionKingConfig.instance:getStepCfgByStepId(self._activityId, self._curStepId)

	local scheduleInfo = TeenChampionKingModel.instance:getKnockoutScheduleInfo(self._activityId, self._curGroupId, self._enterRoundId)

	self._curMatchInfo = nil
	self._playerInfos = {}
	self._playerInfoMap = {}
	self._winner = nil
	self._loser = nil
	self._rankInfos = {}
	self._rankMap = {}

	if scheduleInfo then
		if not scheduleInfo.groupList then
			for _, matchInfo in ipairs(scheduleInfo.groupList) do
				table.insert(self._playerInfos, matchInfo.playerA)
				table.insert(self._playerInfos, matchInfo.playerB)

				self._playerInfoMap[checknumber(matchInfo.playerA.headInfo.headInfo.userId)] = matchInfo.playerA
				self._playerInfoMap[checknumber(matchInfo.playerB.headInfo.headInfo.userId)] = matchInfo.playerB

				if matchInfo.index == self._curGroupId then
					self._curMatchInfo = matchInfo
				end
			end

			self._rankInfos = scheduleInfo.rankPlayerIds or {}

			for k, v in ipairs(self._rankInfos) do
				self._rankMap[checknumber(v)] = k
			end

			if self._curMatchInfo then
				local records = self._curMatchInfo.reports
				local playerA = self._curMatchInfo.playerA
				local playerB = self._curMatchInfo.playerB

				if records then
					if checknumber(records.winPlayerId) == checknumber(playerA.headInfo.headInfo.userId) then
						self._winner = playerA
						self._loser = playerB
					else
						self._winner = playerB
						self._loser = playerA
					end
				elseif self._enterRoundId == TeenChampionKingController.ROUND_CHAMPIONSHIP_MIN then
					self._isShowScore = false
				end

				self:_updatePartInfo(self._parts[TCKFinalsView.Type.Left], playerA)
				self:_updatePartInfo(self._parts[TCKFinalsView.Type.Right], playerB)
				self:_updateAvatar(self._avatarLeft, playerA)
				self:_updateAvatar(self._avatarRight, playerB)
			end
		end
	end

	self._tableview:reloadData(self._rankInfos)
	goutil.setActive(self._rank, true)
end

function TCKFinalsView:_updateAvatar(avatar, player)
	if avatar and player then
		local skId = DressModel.instance:getSkeIdByGender(player.gender)
		local mo = DressModel.instance:getAvatarPlayerMo(skId, (not player.clothes or nil) and {}, 0)

		avatar:updateByMo(mo)
		avatar:setVisible(true)
	else
		avatar:setVisible(false)
	end
end

function TCKFinalsView:_updatePartInfo(part, info)
	if part then
		HeadItemController.instance:setHeadCellByInfo(part.goHead, info.headInfo.headInfo, true)

		part.txtNameShow.text = string.format("s%03d-%s", info.areaId, info.headInfo.headInfo.userName)
		part.txtPower.text = info.zdl

		if self._winner or self._loser then
			goutil.setActive(part.result, true)

			if self._winner == info then
				part.resultChange:SetState(0)
			elseif self._loser == info then
				part.resultChange:SetState(1)
			end
		else
			goutil.setActive(part.result, false)
		end

		goutil.setActive(part.rank, self._isShowScore)

		local userId = checknumber(info.headInfo.headInfo.userId)
		local rank = self._rankMap[userId]

		if rank > 0 then
			if rank <= 3 then
				part.rankChange:SetState(rank - 1)

				part.txtRank.text = ""
			else
				part.rankChange:SetState(3)

				part.txtRank.text = rank
			end
		end

		part.txtScore.text = string.format("积分：%s", info.headInfo.score)
	end
end

function TCKFinalsView:_onClickBtnSwtich()
	local isShow = GameUtil.GetActive(self._tableviewGoGroup)

	goutil.setActive(self._tableviewGoGroup, not isShow)

	if not isShow then
		self._tableviewGroup:reloadData(self._curGroupIdList)
	end
end

function TCKFinalsView:_onClickVote()
	UIStateManager.instance:push(ViewName.TCKFinalsGuessView, self._activityId, self._playerInfos)
end

function TCKFinalsView:_onClickGainCoin()
	UIStateManager.instance:push(ViewName.TeenChampionKingGainCoinView, self._activityId)
end

function TCKFinalsView:_onClickVoteRecord()
	UIStateManager.instance:push(ViewName.TCKGuessRecordView, self._activityId)
end

function TCKFinalsView:_onClickRecord()
	local info = self._curMatchInfo
	local reports = info and info.reports

	if not reports then
		TipsFacade.instance:openCommonTips("未出结果")

		return
	end

	local dataList = {}
	local data = {}

	data.leftHeadInfo = info.playerA.headInfo.headInfo
	data.leftZdl = reports.playerAZdl
	data.rightHeadInfo = info.playerB.headInfo.headInfo
	data.rightZdl = reports.playerBZdl
	data.showTxt = TeenChampionKingController.instance:getRoundNameByStepId(self._activityId, reports.stepId)
	data.isLeftWin = checknumber(reports.winPlayerId) == checknumber(data.leftHeadInfo.userId)
	data.battleId = reports.battleId

	table.insert(dataList, data)
	UIStateManager.instance:push(ViewName.TCKBattleResultView, dataList)
end

function TCKFinalsView:_updateRankCell(view, cell, data, tag)
	local goHeadIcon = goutil.findChild(cell.gameObject, "headicon")

	HeadItemController.instance:resetHeadCell(goHeadIcon)

	local txtRank = goutil.findChildTextComponent(cell.gameObject, "rank/txt")
	local rankGo = goutil.findChild(cell.gameObject, "rank")
	local rankChange = goutil.findChild(cell.gameObject, "rank"):GetComponent("UIImageSpriteChange")
	local txtScore = goutil.findChildTextComponent(cell.gameObject, "txtScore")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "name/txt")
	local userId = checknumber(data)
	local info = self._playerInfoMap[userId]

	if not self._rankMap[userId] then
		if info then
			if self._rankMap[userId] > 0 then
				if self._rankMap[userId] <= 3 then
					rankChange:SetState(self._rankMap[userId] - 1)

					txtRank.text = ""
				else
					rankChange:SetState(3)

					txtRank.text = self._rankMap[userId]
				end
			end

			HeadItemController.instance:setHeadCellByInfo(goHeadIcon, info.headInfo.headInfo, true)

			txtScore.text = string.format("<color=#B1DBFCFF>积分:</color>%s", info.headInfo.score)
			txtName.text = info.headInfo.headInfo.userName
		end

		goutil.setActive(rankGo, self._isShowScore)
	end
end

function TCKFinalsView:_clearRankCell(cell)
	local goHeadIcon = goutil.findChild(cell.gameObject, "headicon")

	HeadItemController.instance:resetHeadCell(goHeadIcon)
end

return TCKFinalsView
