-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingRoomView.lua

module("logic.extensions.survivalking.view.SurvivalKingRoomView", package.seeall)

local SurvivalKingRoomView = class("SurvivalKingRoomView", ViewComponent)

function SurvivalKingRoomView:ctor()
	SurvivalKingRoomView.super.ctor(self)
end

function SurvivalKingRoomView:unbindEvents()
	SurvivalKingRoomView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SurvivalKingRoomView:bindEvents()
	SurvivalKingRoomView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SurvivalKingRoomView:buildUI()
	SurvivalKingRoomView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")

	local goTabPlayer = self:getGo("player/tableview")
	local goCellPlayer = self:getGo("player/tableview/tablecell")

	self._tableViewPlayer = ScrollerList.create(goTabPlayer, goCellPlayer, GameUtil.handler(self._updateCellPlayer, self), GameUtil.handler(self._clearCellPlayer, self))

	local goTabLog = self:getGo("battlelog/tableview")
	local goCellLog = self:getGo("battlelog/tableview/tablecell")

	self._tableViewLog = ScrollerList.create(goTabLog, goCellLog, GameUtil.handler(self._updateCellLog, self), GameUtil.handler(self._clearCellLog, self))
	self._result = self:getGo("result")
	self._battlelog = self:getGo("battlelog")

	local goTabResult = self:getGo("result/tableview")
	local goCellResult = self:getGo("result/tableview/tablecell")

	self._tableViewResult = ScrollerList.create(goTabResult, goCellResult, GameUtil.handler(self._updateCellResult, self), GameUtil.handler(self._clearCellResult, self))
	self._goEmptyResult = self:getGo("result/goEmpty")
	self._playerCellResult = self:getGo("result/playerCell")

	goutil.setActive(self._playerCellResult, false)

	local goTabSession = self:getGo("session/tableview")
	local goCellSession = self:getGo("session/tableview/tablecell")

	self._tableViewSession = ScrollerList.create(goTabSession, goCellSession, GameUtil.handler(self._updateCellSession, self), GameUtil.handler(self._clearCellSession, self))
	self._goEmpty = self:getGo("player/goEmpty")
	self._textEmptyPlayer = self:getTxt("player/goEmpty/text")
	self._goEmpty2 = self:getGo("battlelog/goEmpty")
	self._textEmptyBattleLog = self:getTxt("battlelog/goEmpty/text")
	self._textEmptyResult = self:getTxt("result/goEmpty/text")
	self._progressBar = self:getSlider("session/tableview/viewport/content/progressBar")
end

function SurvivalKingRoomView:onExit()
	SurvivalKingRoomView.super.onExit(self)
	self._tableViewPlayer:dispose()
	self._tableViewLog:dispose()
	self._tableViewSession:dispose()
	self._tableViewResult:dispose()
end

function SurvivalKingRoomView:onEnter()
	SurvivalKingRoomView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SurvivalKingGetRoomInfo, self._updateUIByInfo, self)

	self._subTableviewDic = {}
	self._activityId = 529001
	self._curSessionId = 1
	self._selectSeeionId = 1

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])
		self._curSessionId = checknumber(params[2])
	end

	self._selectSeeionId = self._curSessionId
	self._myUserId = checknumber(RoleModel.instance:getUserId())

	self:_updateUIByCfg()
	SurvivalKingController.instance:getRoomInfo(self._activityId, self._curSessionId)
end

function SurvivalKingRoomView:_updateUIByCfg()
	self._roundCfgs = SurvivalKingConfig.instance:getRoundPrizeCfgs(self._activityId)

	local cfgs = SurvivalKingConfig.instance:getAllSessionCfg(self._activityId) or {}

	self._curDataList = {}

	for sessionId, cfg in ipairs(cfgs) do
		table.insert(self._curDataList, cfg)
	end

	self._tableViewSession:reloadData(self._curDataList)
	self._progressBar:SetValue((#cfgs - self._curSessionId) / (#cfgs - 1))
end

function SurvivalKingRoomView:_updateUIByInfo(sessionId)
	local baseInfo = SurvivalKingModel.instance:getBaseInfo(self._activityId)
	local signInMap = {}

	if baseInfo then
		if not baseInfo.signUps then
			local signUps = {}

			for _, signUp in ipairs(signUps) do
				signInMap[signUp.sessionId] = signUp.signUp
			end
		end
	end

	self._playerInfos = {}
	self._selectSessionId = sessionId or self._selectSessionId

	local roomInfo = SurvivalKingModel.instance:getRoomInfo(self._activityId, self._selectSessionId)

	if roomInfo then
		self._playerInfos = roomInfo.players or {}

		for i, v in ipairs(self._playerInfos) do
			if checknumber(v.headInfo.userId) == self._myUserId then
				table.remove(self._playerInfos, i)
				table.insert(self._playerInfos, 1, v)

				break
			end
		end
	end

	self._tableViewPlayer:reloadData(self._playerInfos)
	goutil.setActive(self._goEmpty, #self._playerInfos <= 0)
	goutil.setActive(self._goEmptyResult, #self._playerInfos <= 0)

	self._resultMap = {}

	for i, v in ipairs(self._playerInfos) do
		local lastRoundId = v.lastRoundId
		local cfg = SurvivalKingConfig.instance:getSessionRankPrizeCfg(self._activityId, lastRoundId)

		if cfg then
			if not self._resultMap[cfg.id] then
				table.insert(self._resultMap[cfg.id], v)

				self._resultMap[cfg.id] = self._resultMap[cfg.id]
			end
		end
	end

	if #self._playerInfos <= 0 then
		self._tableViewResult:reloadData({})
	else
		self._tableViewResult:reloadData(self._roundCfgs)
	end

	local battleLogs = {}

	if roomInfo then
		battleLogs = roomInfo.rounds or {}
	end

	self._tableViewLog:reloadData(battleLogs)
	goutil.setActive(self._goEmpty2, #battleLogs <= 0)
	self._tableViewSession:reloadData(self._curDataList)

	if self._selectSessionId == self._curSessionId then
		if signInMap[self._selectSessionId] then
			self._textEmptyPlayer.text = "当前场次已报名，等待战斗结果"
			self._textEmptyBattleLog.text = "等待战斗结果"
		else
			self._textEmptyPlayer.text = "当前场次未报名"
			self._textEmptyBattleLog.text = "无战斗记录"
		end
	elseif signInMap[self._selectSessionId] then
		self._textEmptyPlayer.text = "当前场次参赛人数过少未能成局"
		self._textEmptyBattleLog.text = "无战斗记录"
		self._textEmptyResult.text = "当前未有战斗记录"
	else
		self._textEmptyPlayer.text = "当前场次未报名"
		self._textEmptyBattleLog.text = "无战斗记录"
		self._textEmptyResult.text = "当前场次未报名"
	end

	goutil.setActive(self._result, self._curSessionId > self._selectSessionId)
	goutil.setActive(self._battlelog, self._curSessionId == self._selectSessionId)
end

function SurvivalKingRoomView:_updateCellPlayer(view, cell, data, tag)
	local go = cell.gameObject
	local head = goutil.findChild(go, "head")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local tagMy = goutil.findChild(go, "tagMy")

	goutil.setActive(tagMy, checknumber(data.headInfo.userId) == self._myUserId)
	HeadItemController.instance:setHeadCellByInfo(head, data.headInfo, true)

	txtName.text = data.headInfo.userName
end

function SurvivalKingRoomView:_clearCellPlayer(cell)
	local go = cell.gameObject
	local head = goutil.findChild(go, "head")

	HeadItemController.instance:resetHeadCell(head)
end

function SurvivalKingRoomView:_getPlayerPart(partGo)
	local partCell = {}

	partCell.go = partGo
	partCell.head = goutil.findChild(partCell.go, "head")
	partCell.txtName = goutil.findChildTextComponent(partCell.go, "txtName")
	partCell.empty = goutil.findChild(partCell.go, "empty")

	return partCell
end

function SurvivalKingRoomView:_updateCellLog(view, cell, data)
	local btnVideo = goutil.findChild(cell.gameObject, "btnVideo")

	GameUtil.addClickHandler(btnVideo, GameUtil.handler(self._onClickPlayVideo, self, data.recordId))

	local imgResult = goutil.findChildComponent(cell.gameObject, "imgResult", "UIImageSpriteChange")

	imgResult:SetState(data.isWin and 0 or 1)

	local leftPart = self:_getPlayerPart(goutil.findChild(cell.gameObject, "left"))

	HeadItemController.instance:setMyHeadCell(leftPart.head)

	leftPart.txtName.text = RoleModel.instance:getUserName()

	local rightPart = self:_getPlayerPart(goutil.findChild(cell.gameObject, "right"))
	local opUserId = checknumber(data.opUserId)

	if opUserId <= 0 then
		rightPart.empty:SetActive(true)
		rightPart.head:SetActive(false)

		rightPart.txtName.text = "此战斗轮空"
	else
		rightPart.empty:SetActive(false)
		rightPart.head:SetActive(true)

		local opHeadInfo

		for _, v in ipairs(self._playerInfos) do
			if checknumber(v.headInfo.userId) == opUserId then
				opHeadInfo = v.headInfo

				HeadItemController.instance:setHeadCellByInfo(rightPart.head, v.headInfo)

				rightPart.txtName.text = opHeadInfo.userName

				break
			end
		end
	end

	goutil.setActive(btnVideo, opUserId > 0)

	local txtTitle = goutil.findChildTextComponent(cell.gameObject, "txtTitle")

	txtTitle.text = string.format("第\n%s\n轮", GameUtil.getChineseNumber(data.roundId))
end

function SurvivalKingRoomView:_clearCellLog(cell)
	local btnVideo = goutil.findChild(cell.gameObject, "btnVideo")

	GameUtil.rmClickHandler(btnVideo)

	local leftPart = self:_getPlayerPart(goutil.findChild(cell.gameObject, "left"))
	local rightPart = self:_getPlayerPart(goutil.findChild(cell.gameObject, "right"))

	HeadItemController.instance:resetHeadCell(leftPart.head)
	HeadItemController.instance:resetHeadCell(rightPart.head)
end

function SurvivalKingRoomView:_onClickPlayVideo(recordId)
	if checknumber(recordId) <= 0 then
		TipsFacade.instance:openCommonTips("战斗记录已过期")

		return
	end

	SurvivalKingController.instance:getBattleDetail(self._activityId, recordId)
end

function SurvivalKingRoomView:_updateCellSession(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtStatus = goutil.findChildTextComponent(go, "txtStatus")
	local change = goutil.findChildComponent(go, "bg", "UIImageSpriteChange")

	txtName.text = data.sessionName or ""

	if not data.sessionName then
		local sessionName = ""
		local strs = string.split(sessionName, "-")

		if #strs == 2 then
			txtName.text = string.format("%s场次", strs[1])
		end

		if data.sessionId == self._curSessionId then
			txtStatus.text = "<color=#49f069>进行中</color>"
		elseif data.sessionId < self._curSessionId then
			txtStatus.text = "已结束"
		elseif data.sessionId > self._curSessionId then
			txtStatus.text = "未开始"
		end

		change:SetState(data.sessionId == self._selectSessionId and 0 or 1)

		local btnSelect = goutil.findChild(go, "bg")

		GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onClickSelectSession, self, data.sessionId))
	end
end

function SurvivalKingRoomView:_onClickSelectSession(sessionId)
	if self._selectSessionId == sessionId then
		return
	end

	if sessionId > self._curSessionId then
		TipsFacade.instance:openCommonTips("该场次尚未开始")

		return
	end

	SurvivalKingController.instance:getRoomInfo(self._activityId, sessionId)
end

function SurvivalKingRoomView:_clearCellSession(cell)
	local go = cell.gameObject
	local btnSelect = goutil.findChild(go, "bg")

	GameUtil.rmClickHandler(btnSelect)
end

function SurvivalKingRoomView:_updateCellResult(view, cell, data, tag)
	local go = cell.gameObject
	local tagFirst = goutil.findChild(go, "tagFirst")
	local txtRound = goutil.findChildTextComponent(go, "txtRound")

	if data.id == 1 then
		txtRound.text = ""

		goutil.setActive(tagFirst, true)
	else
		txtRound.text = string.format("第%s名", data.showRank)

		goutil.setActive(tagFirst, false)
	end

	local goTab = goutil.findChild(go, "subtab")
	local empty = goutil.findChild(go, "empty")

	if goTab and self._playerCellResult then
		local subTabView = self._subTableviewDic[go]

		if not subTabView then
			self._subTableviewDic[go] = ScrollerList.create(goTab, self._playerCellResult, GameUtil.handler(self._updatePlayerCellResult, self), GameUtil.handler(self._clearPlayerCellResult, self))
			subTabView = self._subTableviewDic[go]
		end

		if not self._resultMap[data.id] then
			local results = {}

			subTabView:reloadData(results)
			subTabView:dragNotifyParent()
			goutil.setActive(empty, #results == 0)
		end
	end
end

function SurvivalKingRoomView:_clearCellResult(cell)
	local go = cell.gameObject
	local tableview = self._subTableviewDic[go]

	if tableview then
		tableview:dispose()

		self._subTableviewDic[go] = nil
	end
end

function SurvivalKingRoomView:_updatePlayerCellResult(view, cell, data, tag)
	local go = cell.gameObject
	local head = goutil.findChild(go, "head")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local tagMy = goutil.findChild(go, "tagMy")

	goutil.setActive(tagMy, checknumber(data.headInfo.userId) == self._myUserId)
	HeadItemController.instance:setHeadCellByInfo(head, data.headInfo, true)

	txtName.text = data.headInfo.userName
end

function SurvivalKingRoomView:_clearPlayerCellResult(cell)
	local go = cell.gameObject
	local head = goutil.findChild(go, "head")

	HeadItemController.instance:resetHeadCell(head)
end

return SurvivalKingRoomView
