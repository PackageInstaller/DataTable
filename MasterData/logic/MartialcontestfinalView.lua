-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalView.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalView", package.seeall)

local MartialcontestfinalView = class("MartialcontestfinalView", ViewComponent)

MartialcontestfinalView.TimeType = {
	WaitMatch = 2,
	CountDown = 1
}

function MartialcontestfinalView:ctor()
	MartialcontestfinalView.super.ctor(self)

	self._pkEffectHandlers = {}
end

function MartialcontestfinalView:unbindEvents()
	MartialcontestfinalView.super.unbindEvents(self)
	self._btnChallenge:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnBuffActive:RemoveClickListener()
	self._btnAllPlayer:RemoveClickListener()
	self._btnFmt:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnReward:RemoveClickListener()
end

function MartialcontestfinalView:bindEvents()
	MartialcontestfinalView.super.bindEvents(self)
	self._btnChallenge:AddClickListener(self._onClickbtnChallenge, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnBuffActive:AddClickListener(self._onClickbtnBuffActive, self)
	self._btnAllPlayer:AddClickListener(self._onClickbtnAllPlayer, self)
	self._btnFmt:AddClickListener(self._onClickbtnFmt, self)
	self._btnRank:AddClickListener(self._onClickbtnRank, self)
	self._btnReward:AddClickListener(self._onClickbtnReward, self)
end

function MartialcontestfinalView:buildUI()
	MartialcontestfinalView.super.buildUI(self)

	self._pettablecellGo = self:getGo("leftcon/pettablecell")
	self._pettableviewGo = self:getGo("leftcon/pettableview")
	self._tableviewGo = self:getGo("bottomleftcon/tableview")
	self._tablecellGo = self:getGo("bottomleftcon/tablecell")
	self._bufftableviewGo = self:getGo("leftcon/buff/bufftableview")
	self._bufftablecellGo = self:getGo("leftcon/buff/bufftablecell")
	self._buffscrollerList = ScrollerList.create(self._bufftableviewGo, self._bufftablecellGo, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._rankscrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._btnChallenge = self:getBtn("btnChallenge")
	self._txtTime = self:getTxt("top/txtTime")
	self._txtDetail = self:getTxt("top/txtDetail")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._txtDetail_1 = self:getTxt("top/txtDetail_1")
	self._txtDetail_2 = self:getTxt("top/txtDetail_2")
	self._effectGo = self:getGo("effect")
	self._pkNodeGo = self:getGo("rolecon/pk")
	self._pkOneNodeGo = self:getGo("rolecon/pkone")
	self._moveNodeGo = self:getGo("rolecon/move")

	for i = 1, 10 do
		local go = self:getGo("rolecon/move/player" .. i)

		self:_buildMovePlay(i, go)
	end

	for i = 1, 5 do
		local go = self:getGo("rolecon/pk/pk" .. i)

		self:_buildPkPlayer(i, go)
	end

	self:_buildMovePlayOnlyOne()

	self._pk1Canvas = self:getGo("rolecon/pk/pk1/pk"):GetComponent(ComponentType.CanvasGroup)
	self._pk2Canvas = self:getGo("rolecon/pk/pk2/pk"):GetComponent(ComponentType.CanvasGroup)
	self._pk2_effecrGo = self:getGo("rolecon/pk/pk2/effect")
	self._pk1_effectGo = self:getGo("rolecon/pk/pk1/effect")
	self._scoreconGo = self:getGo("leftcon/scorecon")
	self._txtScore = self:getTxt("leftcon/scorecon/txtScore")
	self._btnBuffActive = self:getBtn("leftcon/buff/btnBuffActive")
	self._buffRootGo = self:getGo("leftcon/buff")
	self._txtRound = self:getTxt("top/txtRound")
	self._btnAllPlayer = self:getBtn("bottomleftcon/btnAllPlayer")
	self._btnFmt = self:getBtn("btnFmt")
	self._txtBuffPointLeft = self:getTxt("leftcon/buff/txtBuffPointLeft")
	self._btnRank = self:getBtn("btnRank")
	self._txtBuffEmptyGo = self:getGo("leftcon/buff/txtBuffEmpty")
	self._txtGain = self:getTxt("leftcon/scorecon/txtGain")
	self._btnReward = self:getBtn("btnReward")
end

function MartialcontestfinalView:_buildPkPlayer(index, go)
	self._pkPlayers = self._pkPlayers or {}
	self._pkPlayers[index] = {
		mainGo = go,
		goHead1 = goutil.findChild(go, "player_pk1/head"),
		goHead2 = goutil.findChild(go, "player_pk2/head"),
		txtName1 = goutil.findChildTextComponent(go, "player_pk1/name/txtName"),
		txtName2 = goutil.findChildTextComponent(go, "player_pk2/name/txtName"),
		goPk = goutil.findChild(go, "pk"),
		myTag1 = goutil.findChild(go, "player_pk1/myTag"),
		myTag2 = goutil.findChild(go, "player_pk2/myTag")
	}
end

function MartialcontestfinalView:_buildMovePlay(index, go)
	self._movePlayers = self._movePlayers or {}
	self._movePlayers[index] = {
		mainGo = go,
		goHead = goutil.findChild(go, "head"),
		txtName = goutil.findChildTextComponent(go, "name/txtName"),
		myTag = goutil.findChild(go, "myTag")
	}
end

function MartialcontestfinalView:_buildMovePlayOnlyOne()
	local go = goutil.findChild(self._pkOneNodeGo, "player1")

	self._pkOnlyOnePlayer = {
		mainGo = go,
		goHead = goutil.findChild(go, "head"),
		txtName = goutil.findChildTextComponent(go, "name/txtName"),
		myTag = goutil.findChild(go, "myTag")
	}
end

function MartialcontestfinalView:onExit()
	MartialcontestfinalView.super.onExit(self)
	self._buffscrollerList:dispose()
	self._rankscrollerList:dispose()
	CommonTipsMgr.instance:closeOneView(ViewName.BufftipsView)
	CommonTipsMgr.instance:closeOneView(ViewName.PetTips)
	removetimer(self._tick, self)
	removetimer(self._tickPlayPkEffect, self)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end

	for k, v in pairs(self._pkPlayers) do
		HeadItemController.instance:resetHeadCell(v.goHead1)
		HeadItemController.instance:resetHeadCell(v.goHead2)
	end

	for k, v in pairs(self._movePlayers) do
		HeadItemController.instance:resetHeadCell(v.goHead)
	end

	for k, v in pairs(self._pkEffectHandlers) do
		UIEffectManager.instance:stopEffect(v.handler)
	end

	self._pkEffectHandlers = {}
end

function MartialcontestfinalView:onEnter()
	MartialcontestfinalView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.MCFinalsInfoRes, self._onMCFinalsInfoRes, self)
	self.addGEvent(self, GlobalNotify.MCFinalsGetFormationRes, self._onMCFinalsGetFormationRes, self)
	self.addGEvent(self, GlobalNotify.PM_MCGetInfoRes, self._onPM_MCGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.MCFinalsSetFormationRes, self._onMCFinalsSetFormationRes, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.MartialContest)
	end

	if self._activityId <= 0 then
		self:close()
	end

	self._maxPlayerShowNum = 10
	self._popResultViewTime = 300
	self._battleStepTickTime = 0
	self._isMeActive = false
	self._cacheStepId = MartialContestController.instance:getCacheFinalsStepId()
	self._pk1Alpha = -1
	self._pk2Alpha = -1

	MartialContestAgent.instance:sendPM_MCGetInfoReq(self._activityId)
end

function MartialcontestfinalView:_onPM_MCGetInfoRes()
	self._info = MartialContestModel.instance:getInfo(self._activityId)
	self._curStepId = self._info.curStepId

	local stepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, self._curStepId)

	if not stepCfg or stepCfg.processorTarget == MartialContestEnum.DISPLAY then
		TipsFacade.instance:openTipWindowNoX("提示", "决赛已结束", function()
			self:close()
		end, "确定")

		return
	end

	self._playerRoundId = self._info.playerRoundId

	self:_calTargetTickTime()
	settimer(1, self._tick, self, true)
	settimer(0.03, self._tickPlayPkEffect, self, true)
	self:_tick()
	self:_updateUI()
	MartialContestAgent.instance:sendPM_MCFinalsInfoReq(self._activityId)
end

function MartialcontestfinalView:_onClickbtnChallenge()
	UIStateManager.instance:push(ViewName.MartialcontestfinalreportView, self._activityId)
end

function MartialcontestfinalView:_onClickbtnClose()
	MartialContestController.instance:blockGetFinalsInfo(false)
	self:close()
end

function MartialcontestfinalView:_refreshBattleField()
	local stepCfg = MartialContestController.instance:getStepCfgByNowTime(self._activityId)

	if not stepCfg then
		FloatWordMgr.instance:show("决赛已结束")
		self:close()

		return
	end

	local finalInfo = MartialContestModel.instance:getFinalsInfo()

	if not finalInfo then
		return
	end

	self:_checkIsMeActive(finalInfo.allPlayers)
	self:_refreshKillRank(finalInfo.allPlayers)
	self:_refreshKillNum(finalInfo.allPlayers)
	self:_refreshMovePlayers(finalInfo, stepCfg)
	self:_refreshBuffAndScore(finalInfo)

	self._txtRound.text = not stepCfg and "未知" or MartialContestController.instance:getFinalsRoundDesc(self._activityId, stepCfg.stepId, stepCfg.roundId)
end

function MartialcontestfinalView:_checkIsMeActive(allPlayers)
	local myUserId = checknumber(RoleModel.instance:getUserId())

	self._isMeActive = false

	for i, v in ipairs(allPlayers) do
		if v.isActive and checknumber(v.headInfo.headInfo.userId) == myUserId then
			self._isMeActive = true

			break
		end
	end
end

function MartialcontestfinalView:_refreshBuffAndScore(finalInfo)
	local stepCfg = MartialContestController.instance:getStepCfgByNowTime(self._activityId)
	local roundCfg = MartialContestConfig.instance:getRoundCfg(self._activityId, stepCfg.roundId)
	local isDay3 = roundCfg and roundCfg.roundType == "FINALS_BUFF"

	goutil.setActive(self._buffRootGo, isDay3 and self._isMeActive)

	local myFinalInfo
	local myUid = tostring(RoleModel.instance:getUserId())

	for i, v in ipairs(finalInfo.allPlayers) do
		if v.headInfo.headInfo.userId == myUid then
			myFinalInfo = v

			break
		end
	end

	if myFinalInfo then
		self._txtScore.text = myFinalInfo.totalScore or 0
	end

	if isDay3 then
		local point = MartialContestController.instance:getFinalsBuffPointLeft(self._activityId, self._curStepId)

		self._txtBuffPointLeft.text = string.format("剩余技能点：%s", point)
	end
end

function MartialcontestfinalView:_refreshMovePlayers(finalInfo, stepCfg)
	local isFight = stepCfg.processorTarget == MartialContestEnum.FINALS_BATTLE
	local myUserId = tostring(RoleModel.instance:getUserId())
	local activePlayerUsers = {}
	local isGetMyInfo = false

	for i, v in ipairs(finalInfo.allPlayers) do
		if self._isMeActive then
			if v.isActive then
				if v.headInfo.headInfo.userId ~= myUserId then
					if #activePlayerUsers < self._maxPlayerShowNum - 1 then
						table.insert(activePlayerUsers, v)
					end
				else
					isGetMyInfo = true

					table.insert(activePlayerUsers, v)
				end

				if isGetMyInfo and #activePlayerUsers >= self._maxPlayerShowNum then
					break
				end
			end

			if #activePlayerUsers >= self._maxPlayerShowNum then
				break
			end
		elseif v.isActive then
			table.insert(activePlayerUsers, v)

			if #activePlayerUsers >= self._maxPlayerShowNum then
				break
			end
		end
	end

	local activePlayerNum = #activePlayerUsers

	if isFight and activePlayerNum == 1 then
		for i, v in ipairs(finalInfo.allPlayers) do
			if not v.isActive then
				table.insert(activePlayerUsers, v)

				activePlayerNum = activePlayerNum + 1

				break
			end
		end
	end

	local nodeList = self:_getPlayersNodeListByActiveNum(activePlayerNum, isFight)

	for i, v in ipairs(nodeList) do
		if activePlayerUsers[i] then
			local headInfo = activePlayerUsers[i].headInfo.headInfo

			if headInfo then
				HeadItemController.instance:setHeadCellByInfo(v.goHead, headInfo, true)

				v.txtName.text = headInfo.userName

				goutil.setActive(v.myTag, myUserId == headInfo.userId)
			end
		end
	end
end

function MartialcontestfinalView:_getPlayersNodeListByActiveNum(activePlayerNum, isFight)
	if isFight then
		activePlayerNum = math.floor(activePlayerNum / 2) * 2
	end

	local isOnlyOne = activePlayerNum == 1

	goutil.setActive(self._pkNodeGo, isFight and not isOnlyOne)
	goutil.setActive(self._moveNodeGo, not isFight and not isOnlyOne)
	goutil.setActive(self._pkOneNodeGo, isOnlyOne)

	activePlayerNum = math.min(activePlayerNum, self._maxPlayerShowNum)

	local nodeList = {}

	if isOnlyOne then
		local player = self._pkOnlyOnePlayer

		table.insert(nodeList, {
			goHead = player.goHead,
			txtName = player.txtName,
			myTag = player.myTag
		})
	elseif isFight then
		local needNum = activePlayerNum
		local halfNum = math.floor(activePlayerNum / 2)

		for i = halfNum + 1, #self._pkPlayers do
			goutil.setActive(self._pkPlayers[i].mainGo, false)
		end

		for i, v in ipairs(self._pkPlayers) do
			if needNum <= 0 then
				break
			end

			goutil.setActive(v.mainGo, true)
			table.insert(nodeList, {
				goHead = v.goHead1,
				txtName = v.txtName1,
				myTag = v.myTag1
			})
			table.insert(nodeList, {
				goHead = v.goHead2,
				txtName = v.txtName2,
				myTag = v.myTag2
			})

			needNum = needNum - 2
		end
	else
		for i = activePlayerNum + 1, #self._movePlayers do
			goutil.setActive(self._movePlayers[i].mainGo, false)
		end

		for i = 1, activePlayerNum do
			goutil.setActive(self._movePlayers[i].mainGo, true)

			local player = self._movePlayers[i]

			table.insert(nodeList, {
				goHead = player.goHead,
				txtName = player.txtName,
				myTag = player.myTag
			})
		end
	end

	return nodeList
end

function MartialcontestfinalView:_refreshKillNum(allPlayers)
	allPlayers = allPlayers or {}

	local aliveNum = 0
	local deathNum = 0

	for i, v in ipairs(allPlayers) do
		if v.isActive then
			aliveNum = aliveNum + 1
		else
			deathNum = deathNum + 1
		end
	end

	self._txtDetail_1.text = string.format("存活：%s", aliveNum)
	self._txtDetail_2.text = string.format("淘汰：%s", deathNum)
end

function MartialcontestfinalView:_refreshKillRank(allPlayers)
	allPlayers = allPlayers or {}

	local userId = tostring(RoleModel.instance:getUserId())

	table.sort(allPlayers, function(a, b)
		if a.isActive ~= b.isActive then
			return a.isActive
		elseif a.totalScore ~= b.totalScore then
			return a.totalScore > b.totalScore
		else
			return a.headInfo.headInfo.userId < b.headInfo.headInfo.userId
		end
	end)
	self._rankscrollerList:reloadData(allPlayers)
end

function MartialcontestfinalView:_updateUI()
	local finalInfo = MartialContestModel.instance:getFinalsInfo()

	if not finalInfo then
		return
	end

	self:_refreshBattleField()
	self:_setBuff()
end

function MartialcontestfinalView:_setBuff()
	local buffIds = MartialContestModel.instance:getFinalsBuffIds(self._activityId) or {}
	local buffCfgs = {}

	for k, buffId in pairs(buffIds) do
		local buffCfg = MartialContestConfig.instance:getFinalsBuffCfg(self._activityId, buffId)

		table.insert(buffCfgs, buffCfg)
	end

	self._buffscrollerList:reloadData(buffCfgs)
	goutil.setActive(self._txtBuffEmptyGo, #buffCfgs == 0)
end

function MartialcontestfinalView:_updateBuffCell(view, cell, buffCfg, tag)
	local btnIcon = Framework.ButtonAdapter.GetFrom(cell.gameObject, "icon")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")

	uGuiUtil.clearImage(btnIcon.gameObject)

	local spriteName = GameUrl.getExpEventUrl(buffCfg.icon)

	uGuiUtil.setSpriteToImage(btnIcon.gameObject, nil, spriteName)

	txtName.text = buffCfg.name

	btnIcon:AddClickListener(function()
		local data = MartialContestConfig.instance:getBuffTipSimpleData(self._activityId, buffCfg.buffId)

		CommonTipsMgr.instance:openBuffTipView(data, cell.gameObject)
	end)
end

function MartialcontestfinalView:_clearBuffCell(cell)
	local btnIcon = goutil.findChild(cell.gameObject, "icon")

	uGuiUtil.clearImage(btnIcon)
end

function MartialcontestfinalView:_updateRankCell(view, cell, data, tag)
	local goHead = goutil.findChild(cell.gameObject, "head")
	local goMyTag = goutil.findChild(cell.gameObject, "myTag")
	local goOutTag = goutil.findChild(cell.gameObject, "out")
	local goGray = goutil.findChild(cell.gameObject, "gray")
	local txtKill = goutil.findChildTextComponent(cell.gameObject, "txtKill")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local headInfo = data.headInfo.headInfo

	HeadItemController.instance:resetHeadCell(goHead)
	HeadItemController.instance:setHeadCellByInfo(goHead, headInfo, true)

	txtName.text = headInfo.userName

	local myUid = tostring(RoleModel.instance:getUserId())

	goutil.setActive(goMyTag, headInfo.userId == myUid)
	goutil.setActive(goOutTag, not data.isActive)
	goutil.setActive(goGray, not data.isActive)

	txtKill.text = string.format("积分:<color=#ffa251>%s</color>", data.totalScore)
end

function MartialcontestfinalView:_clearRankCell(cell)
	local goHead = goutil.findChild(cell.gameObject, "head")

	HeadItemController.instance:resetHeadCell(goHead)
end

function MartialcontestfinalView:_tick()
	local leftTime = self._targetTickTime - ServerTime.now()

	self:_setTime(leftTime)

	if self._needPopResultView and leftTime <= self._popResultViewTime then
		self._needPopResultView = false

		self:_popResultView()
	end

	if leftTime <= 0 then
		self:_calTargetTickTime()

		self._needGetInfoDelay = true
		self._needGetInfoDelayTime = 5
	end

	if self._needGetInfoDelay then
		self._needGetInfoDelayTime = self._needGetInfoDelayTime - 1

		if self._needGetInfoDelayTime <= 0 then
			self._needGetInfoDelay = false

			local stepId = MartialContestController.instance:getStepIdByNowTime(self._activityId)
			local stepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, stepId)

			if stepCfg and stepCfg.processorTarget ~= MartialContestEnum.DISPLAY then
				MartialContestAgent.instance:sendPM_MCGetInfoReq(self._activityId)
			end
		end
	end
end

function MartialcontestfinalView:_setTime(leftTime)
	local leftTime = math.max(0, leftTime)

	if leftTime >= 3600 then
		local hour = math.floor(leftTime / 3600)
		local min = math.floor(leftTime % 3600 / 60)
		local sec = leftTime % 60

		self._txtTime.text = string.format("%s-倒计时：%s小时%s分%s秒", self._timePreStr, hour, min, sec)
	elseif leftTime >= 60 then
		local min = math.floor(leftTime / 60)
		local sec = leftTime % 60

		self._txtTime.text = string.format("%s-倒计时：%s分%s秒", self._timePreStr, min, sec)
	else
		self._txtTime.text = string.format("%s-倒计时：%s秒", self._timePreStr, leftTime)
	end
end

function MartialcontestfinalView:_calTargetTickTime()
	local stepId = MartialContestController.instance:getStepIdByNowTime(self._activityId)
	local nextStepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, stepId + 1)

	if not nextStepCfg then
		removetimer(self._tick, self)
		MartialContestAgent.instance:sendPM_MCGetInfoReq(self._activityId)

		self._txtTime.text = "比赛结束"

		return
	end

	local stepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, stepId)

	self._timePreStr = ""

	local nextStartTime = GameUtil.string2time(nextStepCfg.startTime)

	self._needPopResultView = false
	self._battleStepTickTime = 0

	if stepCfg.processorTarget == "FINALS_BATTLE" then
		self._timePreStr = "战斗阶段"

		local currStartTime = GameUtil.string2time(stepCfg.startTime)
		local tickTime = ServerTime.now() - currStartTime

		self._battleStepTickTime = tickTime

		if tickTime < self._popResultViewTime then
			if self._cacheStepId <= 0 then
				MartialContestController.instance:cacheFinalsStepId(stepId)
			elseif self._cacheStepId ~= stepId then
				self._needPopResultView = true
			end
		end
	else
		self._timePreStr = "准备阶段"

		MartialContestController.instance:cacheFinalsStepId(stepId)
	end

	self._targetTickTime = nextStartTime
end

function MartialcontestfinalView:_setEffect()
	local effName = "20230428/honglianzhanchang/fx_ui_honglianzhanchang_qiecuojiemian_fengwei.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

function MartialcontestfinalView:_tickPlayPkEffect()
	self:_checkCanvasGroup(self._pk1Canvas, "_pk1Alpha", self._pk1_effectGo)
	self:_checkCanvasGroup(self._pk2Canvas, "_pk2Alpha", self._pk2_effecrGo)
end

function MartialcontestfinalView:_checkCanvasGroup(canvasGroup, alphaAttrName, effectRoot)
	if canvasGroup.alpha > self[alphaAttrName] and canvasGroup.alpha >= 0.8 then
		self:_playPkEffect(effectRoot)
	end

	self[alphaAttrName] = canvasGroup.alpha
end

function MartialcontestfinalView:_playPkEffect(effectRoot)
	local data = self._pkEffectHandlers[effectRoot]

	if data and data.isPlaying then
		return
	end

	local handler = data and data.handler

	if handler then
		UIEffectManager.instance:stopEffect(handler)
	end

	local effName = "20230428/honglianzhanchang/fx_ui_honglianzhanchang_qiecuojiemian_zhuanji.prefab"

	handler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false, nil, function()
		self._pkEffectHandlers[effectRoot].isPlaying = false
	end)

	handler:setParent(effectRoot.transform)
	handler:setLocalPos(18, 49, 0)
	handler:setScale(1)

	self._pkEffectHandlers[effectRoot] = {
		isPlaying = true,
		handler = handler
	}
end

function MartialcontestfinalView:_onClickbtnBuffActive()
	if not self._isMeActive then
		FloatWordMgr.instance:show("您已被淘汰，无法调整祝福")

		return
	end

	if not self:_isCanActiveBuff() then
		FloatWordMgr.instance:show("战斗阶段不能调整祝福")

		return
	end

	UIStateManager.instance:push(ViewName.MartialcontestfinalbuffView, self._activityId, self._curStepId)
end

function MartialcontestfinalView:_onClickbtnAllPlayer()
	UIStateManager.instance:push(ViewName.MartialcontestfinalallplayerView, self._activityId)
end

function MartialcontestfinalView:_onClickbtnFmt()
	if not self._isMeActive then
		FloatWordMgr.instance:show("您已被淘汰，无法设置阵型")

		return
	end

	local stepId = MartialContestController.instance:getStepIdByNowTime(self._activityId)
	local stepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, stepId)

	if stepCfg and stepCfg.processorTarget == "FINALS_BATTLE" then
		FloatWordMgr.instance:show("比赛阶段不可调整")

		return
	end

	local roundCfg = MartialContestConfig.instance:getRoundCfg(self._activityId, stepCfg.roundId)
	local isDay2 = roundCfg and roundCfg.roundType == "FINALS_3V3"
	local isDay3 = roundCfg and roundCfg.roundType == "FINALS_BUFF"
	local fmtMo = MartialContestModel.instance:getFinalDefenseFmtMo()

	fmtMo:initParams(self._activityId, isDay2 or isDay3)
	CustomFmtController.instance:showMissionFormationView(fmtMo)
end

function MartialcontestfinalView:_onClickbtnRank()
	UIStateManager.instance:push(ViewName.MartialcontestfinalrankView, self._activityId, 9)
end

function MartialcontestfinalView:_onClickbtnReward()
	UIStateManager.instance:push(ViewName.MartialContestRewardView, self._activityId, 3)
end

function MartialcontestfinalView:_isCanActiveBuff()
	local stepCfg = MartialContestController.instance:getStepCfgByNowTime(self._activityId)

	if not stepCfg then
		return false
	end

	if stepCfg.processorTarget == "FINALS_BATTLE" then
		return false
	end

	local roundCfg = MartialContestConfig.instance:getRoundCfg(self._activityId, stepCfg.roundId)

	if not roundCfg then
		return false
	end

	if roundCfg.roundType ~= "FINALS_BUFF" then
		return false
	end

	return true
end

function MartialcontestfinalView:_onMCFinalsInfoRes()
	self._info = MartialContestModel.instance:getInfo(self._activityId)
	self._curStepId = self._info.curStepId
	self._playerRoundId = self._info.playerRoundId
	self._cacheStepId = MartialContestController.instance:getCacheFinalsStepId()

	self:_refreshBattleField()
	GameUtil.SetActive(self._scoreconGo, self._isMeActive)

	if self._isMeActive then
		local stepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, self._curStepId)
		local score = 0

		if stepCfg.processorTarget == "FINALS_BATTLE" then
			score = stepCfg.finalsScore
		else
			local nextStepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, self._curStepId + 1)

			score = nextStepCfg and nextStepCfg.finalsScore
		end

		self._txtGain.text = string.format("本轮胜利获得%s积分", score)
	end

	if self._isMeActive then
		local stepId = MartialContestController.instance:getStepIdByNowTime(self._activityId)
		local stepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, stepId)
		local roundCfg = MartialContestConfig.instance:getRoundCfg(self._activityId, stepCfg.roundId)
		local isDay1 = roundCfg and roundCfg.roundType == "FINALS_COMMON"
		local isDay2 = roundCfg and roundCfg.roundType == "FINALS_3V3"
		local isDay3 = roundCfg and roundCfg.roundType == "FINALS_BUFF"

		if isDay1 then
			MartialContestAgent.instance:sendPM_MCGetDefenseForamtionReq(self._activityId)
		elseif isDay2 or isDay3 then
			MartialContestAgent.instance:sendPM_MCFinalsGetFormationReq(self._activityId)
		end
	end
end

function MartialcontestfinalView:_onMCFinalsSetFormationRes()
	MartialContestAgent.instance:sendPM_MCFinalsGetFormationReq(self._activityId)
end

function MartialcontestfinalView:_onMCFinalsGetFormationRes()
	self:_setBuff()

	local finalInfo = MartialContestModel.instance:getFinalsInfo()

	if not finalInfo then
		return
	end

	self:_refreshBuffAndScore(finalInfo)
end

function MartialcontestfinalView:_cacheAllPlayersData()
	self._allPlayersMap = {}

	local finalInfo = MartialContestModel.instance:getFinalsInfo()
	local allPlayers = finalInfo.allPlayers

	for k, v in ipairs(allPlayers or {}) do
		local userId = checknumber(v.headInfo.headInfo.userId)

		self._allPlayersMap[userId] = v
	end
end

function MartialcontestfinalView:_popResultView()
	MartialContestController.instance:sendPM_MCFinalsInfoReq(self._activityId, true)
	MartialContestAgent.instance:sendPM_MCGetInfoReq(self._activityId)
end

return MartialcontestfinalView
