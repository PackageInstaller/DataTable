-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/DrawandguessteamView.lua

module("logic.extensions.drawandguess.view.DrawandguessteamView", package.seeall)

local DrawandguessteamView = class("DrawandguessteamView", ViewComponent)

function DrawandguessteamView:buildUI()
	DrawandguessteamView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._goldBarCon = self:getGo("goldBarCon")
	self._btnRefresh = self:getGo("btnRefresh")
	self._btnChat = self:getGo("btnChat")
	self._btnCreate = self:getGo("btnCreate")
	self._btnJoin = self:getGo("btnJoin")
	self._txtJoin = goutil.findChildTextComponent(self._btnJoin, "Text")
	self._matching = self:getGo("matching")
	self._txtMatch = goutil.findChildTextComponent(self._matching, "txtDesc")
	self._btnTip = self:getGo("btnTip")
	self._txtRefresh = goutil.findChildTextComponent(self._btnRefresh, "Text")
	self._iconCurcoins = self:getGo("curcoins/icon")
	self._txtCurcoins = self:getTxt("curcoins/txt")
	self._goTeamCell = self:getGo("right/cell")
	self._goTeamTableView = self:getGo("right/tableview")
	self._teamTableView = ScrollerList.create(self._goTeamTableView, self._goTeamCell, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))
	self._goEmpty = self:getGo("right/empty")
	self._txtTeamTitle = self:getTxt("right/txtTitle")
end

function DrawandguessteamView:bindEvents()
	DrawandguessteamView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnRefresh, self._onClickRefresh, self)
	GameUtil.addClickHandler(self._btnCreate, self._onClickCreate, self)
	GameUtil.addClickHandler(self._btnJoin, self._onQuickClickJoin, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnChat, self._onClickChat, self)
end

function DrawandguessteamView:unbindEvents()
	DrawandguessteamView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRefresh)
	GameUtil.rmClickHandler(self._btnCreate)
	GameUtil.rmClickHandler(self._btnJoin)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChat)
end

function DrawandguessteamView:onEnter()
	DrawandguessteamView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._groupId = params[2]
	self._markFirstDealUnlockInfo = true

	local curCoinsParams = string.splitToNumber(GameEnum.GoldType.ThanksCoin, ":")
	local itemCfg = ItemConfig.instance:getActItemCfgById(curCoinsParams[2])

	self._curcoinsLimit = itemCfg and itemCfg.dailyLimit

	MaterialMgr.setIcon(self._iconCurcoins, curCoinsParams[1], curCoinsParams[2])
	self:getInfo()
	self:_endAutoMath()

	self._txtRefresh.text = lang("刷新")

	FormTeamController.instance:handleOnLeaveTeamShowCI()
	self.addGEvent(self, GlobalNotify.FormTeamError, self._onError, self)
	self.addGEvent(self, GlobalNotify.FormTeamUnlockTabListUpdate, self._refreshTabList, self)
	self.addGEvent(self, GlobalNotify.FormTeamQueryListUpdate, self._refreshTeamList, self)
	self.addGEvent(self, GlobalNotify.FormTeamJoinTeam, self._onJoinTeam, self)
end

function DrawandguessteamView:_jumpToTab()
	local groupId = self._groupId

	self._teamTierCfg = FormTeamConfig.instance:getTeamCfgByGroupId(groupId)

	self:_onUpdateRight()
end

function DrawandguessteamView:onExit()
	DrawandguessteamView.super.onExit(self)
	self._teamTableView:dispose()

	self._inRefreshCD = false

	MaterialMgr.resetAll(self._iconCurcoins)
	self:_endAutoMath()
	removetimer(self._endRefreshCD, self)
end

function DrawandguessteamView:_onUpdateRight()
	self:_endAutoMath()
	FormTeamController.instance:getTeamList(nil, self._teamTierCfg.typeId)

	local tabCfg = FormTeamConfig.instance:getTabCfgByTabId(self._teamTierCfg.typeId) or {}
	local rootDes = tabCfg.name
	local leaveDes = self._teamTierCfg.name

	self._txtTeamTitle.text = langPara("%s-%s", rootDes, leaveDes)
end

function DrawandguessteamView:_getChildCellCount()
	return self._leafNum
end

function DrawandguessteamView:_onClickRefresh(isForce)
	if isForce then
		self._refreshCdTimer = 0
	else
		if self._inRefreshCD then
			FloatWordMgr.instance:show(lang("正处于冷却时间，请稍后再试。"))

			return
		end

		self._inRefreshCD = true
		self._refreshCdTimer = checkint(FormTeamConfig.instance:getCommonValue("REFRESH_CD")) + 1

		settimer(1, self._endRefreshCD, self)
	end

	self:_endRefreshCD()
	FormTeamController.instance:getTeamList(nil, self._teamTierCfg.typeId)
end

function DrawandguessteamView:_endRefreshCD()
	self._refreshCdTimer = self._refreshCdTimer - 1

	if self._refreshCdTimer <= 0 then
		self._inRefreshCD = false

		removetimer(self._endRefreshCD, self)

		self._txtRefresh.text = lang("刷新")
	else
		self._txtRefresh.text = langPara("刷新(%ss)", self._refreshCdTimer)
	end
end

function DrawandguessteamView:_onQuickClickJoin()
	if self._isAutoMatch then
		-- block empty
	else
		self:quickJoin()
	end
end

function DrawandguessteamView:_onClickCreate()
	FormTeamController.instance:createTeam(self._groupId, 0, false)
end

function DrawandguessteamView:_onClickChat()
	UIStateManager.instance:open(ViewName.chat, GameEnum.ChatChannel.World)
end

function DrawandguessteamView:_updateTeamCell(view, goCell, data)
	local cell = self:_clearTeamCell(goCell)
	local teamCfg, typeCfg = data:getTeamCfgAndTypeCfg()

	if teamCfg and typeCfg then
		cell.txtLevel.text = teamCfg.name

		for i = 1, teamCfg.maxCount do
			goutil.setActive(cell.headList[i].go, true)
		end

		for k, v in ipairs(data:getCurTeamMateList()) do
			HeadItemController.instance:setHeadCellByInfo(cell.headList[k].item, v.headInfo)

			cell.headList[k].txtPower.text = v.zdl > 10000 and langPara("%s万", math.floor(v.zdl / 10000)) or v.zdl
		end
	end

	cell.txtPower.text = data.zdlLimit <= 0 and lang("战力无要求") or langPara("战力<color=#20b376>%s</color>以上", data.zdlLimit)

	GameUtil.addClickHandler(cell.btnJoin, GameUtil.handler(self._onClickJoin, self, data))
end

function DrawandguessteamView:_clearTeamCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.headList = {}

	for i = 1, 5 do
		local headCell = {}

		headCell.go = goutil.findChild(cell.go, "headGroup/head_" .. i)
		headCell.item = goutil.findChild(headCell.go, "empty")
		headCell.txtPower = goutil.findChildTextComponent(headCell.go, "txtPower")

		HeadItemController.instance:resetHeadCell(headCell.item)
		goutil.setActive(headCell.go, false)

		headCell.txtPower.text = ""
		cell.headList[i] = headCell
	end

	cell.txtLevel = goutil.findChildTextComponent(cell.go, "txtLevel")
	cell.txtPower = goutil.findChildTextComponent(cell.go, "txtPower")
	cell.btnJoin = goutil.findChild(cell.go, "btnJoin")

	GameUtil.rmClickHandler(cell.btnJoin)

	return cell
end

function DrawandguessteamView:_onClickJoin(data)
	FormTeamController.instance:getJoinTeam(data.id, data.groupId)
end

function DrawandguessteamView:getInfo()
	FormTeamController.instance:getUnloadTabList()
end

function DrawandguessteamView:_refreshTabList()
	self._txtCurcoins.text = langPara("%s/%s", math.min(FormTeamModel.instance:getCurGainCoins(), self._curcoinsLimit), self._curcoinsLimit)

	self:_jumpToTab()
end

function DrawandguessteamView:_refreshTeamList()
	self._teamTableView:reloadData(FormTeamModel.instance:getMatchTeamList())
	goutil.setActive(self._goEmpty, FormTeamModel.instance:getMatchTeamListNum() == 0)
end

function DrawandguessteamView:_onError(status)
	if status == -750 then
		self:_onClickRefresh(true)
	elseif status == -740 then
		self:_startAutoMatch()
	end
end

function DrawandguessteamView:_onJoinTeam()
	return
end

function DrawandguessteamView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "team_rule")
end

function DrawandguessteamView:_onClickClose()
	if self._isAutoMatch then
		TipsFacade.instance:openPopupWindowWithX(lang("tip"), lang("离开组队界面将取消匹配等待状态，是否确定离开？"), GameUtil.handler(self.close, self))
	else
		self:close()
	end
end

function DrawandguessteamView:_startAutoMatch()
	if self._isAutoMatch then
		return
	end

	settimer(1, self._onAutoMathCountDown, self)

	self._autoMatchTotalTimer = checkint(FormTeamConfig.instance:getCommonValue("AUTO_MATCH_TIME"))
	self._autoMatchTimer = 0
	self._autoMatchInterval = checkint(FormTeamConfig.instance:getCommonValue("AUTO_MATCH_TIME_INTERVAL"))
	self._isAutoMatch = true
	self._txtJoin.text = langPara("匹配中")
	self._txtMatch.text = langPara("匹配中(%ss)", self._autoMatchTotalTimer)

	goutil.setActive(self._matching, true)
end

function DrawandguessteamView:_endAutoMath()
	removetimer(self._onAutoMathCountDown, self)

	self._isAutoMatch = false
	self._txtJoin.text = lang("快速加入")

	goutil.setActive(self._matching, false)
end

function DrawandguessteamView:_onAutoMathCountDown()
	self._autoMatchTotalTimer = self._autoMatchTotalTimer - 1

	if self._autoMatchTotalTimer < 0 then
		self:_endAutoMath()
		FloatWordMgr.instance:show(lang("当前没有符合条件的队伍，请尝试创建队伍。"))
	else
		self._txtMatch.text = langPara("匹配中(%ss)", self._autoMatchTotalTimer)
	end

	self._autoMatchTimer = self._autoMatchTimer + 1

	if self._autoMatchTimer >= self._autoMatchInterval then
		self:quickJoin()

		self._autoMatchTimer = 0
	end
end

function DrawandguessteamView:quickJoin()
	local isCurOpen = FormTeamModel.instance:checkFormTeamTabOpen(self._teamTierCfg.typeId)

	if isCurOpen then
		FormTeamController.instance:getQuickJoinTeam(nil, self._teamTierCfg.typeId)

		return
	end

	FloatWordMgr.instance:show(lang("当前未存在开放的组队副本"))
end

return DrawandguessteamView
