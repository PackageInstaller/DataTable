-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/view/FormTeamView.lua

module("logic.extensions.formteam.view.FormTeamView", package.seeall)

local FormTeamView = class("FormTeamView", ViewComponent)

function FormTeamView:buildUI()
	FormTeamView.super.buildUI(self)

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
	self._tablist = self:getGo("tablist")
	self._commonTab = TabFrameCommonTab.create(self._tablist, GameUtil.handler(self._onUpdateExtCell, self), GameUtil.handler(self._onUpdateRight, self))

	self._commonTab:setTabDataFilterCallBack(GameUtil.handler(self._onTabFilter, self))
	self._commonTab:setPreClickCallBack(GameUtil.handler(self._onPreClick, self))
	self._commonTab:setIsUnlockCallBack(GameUtil.handler(self._onTabUnlock, self))
	self._commonTab:clearAllData()

	local tabCfgs = FormTeamConfig.instance:getTabCfgs()

	for k, tabCfg in ipairs(tabCfgs) do
		if tabCfg.typeId ~= 14 then
			local obj = self._commonTab:addTabData(tabCfg.name, tabCfg)
			local temData = {}

			temData.typeId = tabCfg.typeId
			temData.isFake = true
			temData.name = langPara("全部")

			local tem = self._commonTab:addTabData(temData.name, temData, obj.root)
			local teamCfgs = FormTeamConfig.instance:getTeamCfgsByTabId(tabCfg.typeId)

			for k1, teamCfg in ipairs(teamCfgs) do
				local tem = self._commonTab:addTabData(teamCfg.name, teamCfg, obj.root)
			end
		end
	end
end

function FormTeamView:bindEvents()
	FormTeamView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnRefresh, self._onClickRefresh, self)
	GameUtil.addClickHandler(self._btnCreate, self._onClickCreate, self)
	GameUtil.addClickHandler(self._btnJoin, self._onQuickClickJoin, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnChat, self._onClickChat, self)
end

function FormTeamView:unbindEvents()
	FormTeamView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRefresh)
	GameUtil.rmClickHandler(self._btnCreate)
	GameUtil.rmClickHandler(self._btnJoin)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChat)
end

function FormTeamView:onEnter()
	FormTeamView.super.onEnter(self)

	self._markFirstDealUnlockInfo = true

	local btn_list = {
		{
			showAdd = true,
			id = GameEnum.GoldType.ThanksCoin
		},
		{
			showAdd = true,
			id = GameEnum.GoldType.Tili
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)

	local curCoinsParams = string.splitToNumber(GameEnum.GoldType.ThanksCoin, ":")
	local itemCfg = ItemConfig.instance:getActItemCfgById(curCoinsParams[2])

	self._curcoinsLimit = itemCfg and itemCfg.dailyLimit

	MaterialMgr.setIcon(self._iconCurcoins, curCoinsParams[1], curCoinsParams[2])
	self:getInfo()
	self:_endAutoMath()

	self._txtRefresh.text = lang("刷新")

	FormTeamController.instance:handleOnLeaveTeamShowCI()
	GlobalDispatcher:addListener(GlobalNotify.FormTeamError, self._onError, self)
	GlobalDispatcher:addListener(GlobalNotify.FormTeamUnlockTabListUpdate, self._refreshTabList, self)
	GlobalDispatcher:addListener(GlobalNotify.FormTeamQueryListUpdate, self._refreshTeamList, self)
	GlobalDispatcher:addListener(GlobalNotify.FormTeamJoinTeam, self._onJoinTeam, self)
end

function FormTeamView:_jumpToTab()
	local groupId = checkint(self:getFirstParam())
	local teamCfg = FormTeamConfig.instance:getTeamCfgByGroupId(groupId)

	self._commonTab:jumpTabByData(teamCfg)
end

function FormTeamView:onExit()
	FormTeamView.super.onExit(self)
	self._teamTableView:dispose()

	self._inRefreshCD = false

	MaterialMgr.resetAll(self._iconCurcoins)
	self:_endAutoMath()
	removetimer(self._endRefreshCD, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormTeamError, self._onError, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormTeamUnlockTabListUpdate, self._refreshTabList, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormTeamQueryListUpdate, self._refreshTeamList, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormTeamJoinTeam, self._onJoinTeam, self)
end

function FormTeamView:_onUpdateExtCell(view, cell, tabData, tag)
	local redpoint = goutil.findChild(cell, "redpoint")
	local lock = goutil.findChild(cell, "lock")
	local isUnlock = self:_onTabUnlock(tabData)

	GameUtil.SetActive(lock, not isUnlock)
end

function FormTeamView:_onUpdateRight(tabData)
	if tabData then
		local data = tabData.data

		if tabData.root == 1 or tabData.root ~= 1 and tabData.leaf == 0 then
			self:_endAutoMath()
			FormTeamController.instance:getTeamList(nil, data.typeId)
		elseif checkbool(data.isFake) then
			self:_endAutoMath()
			FormTeamController.instance:getTeamList(nil, data.typeId)
		else
			FormTeamController.instance:getTeamList(data.groupId)
			self:_endAutoMath()
		end
	end

	local rootDes, leaveDes
	local tabData = self._commonTab:getCurrTabData()

	if tabData and tabData.data then
		local data = tabData.data

		if tabData.root ~= 1 and tabData.leaf == 0 then
			rootDes = data.name
			leaveDes = langPara("全部")
		else
			local tabCfg = FormTeamConfig.instance:getTabCfgByTabId(data.typeId) or {}

			rootDes = tabCfg.name
			leaveDes = data.name
		end

		self._txtTeamTitle.text = langPara("%s-%s", rootDes, leaveDes)
	else
		self._txtTeamTitle.text = ""
	end
end

function FormTeamView:_onPreClick(tabData)
	local isCurOpen = self:_onTabUnlock(tabData)

	if not isCurOpen then
		if tabData.root == 1 or tabData.root ~= 1 and tabData.leaf == 0 then
			FloatWordMgr.instance:show(lang("当前副本未开放"))
		else
			FloatWordMgr.instance:show(lang("当前章节未开放"))
		end

		return true
	end
end

function FormTeamView:_onTabFilter(tabData)
	if tabData == nil then
		return true
	end

	if tabData.root == 1 or tabData.root ~= 1 and tabData.leaf == 0 then
		local data = tabData.data
		local typeId = data and data.typeId

		return FormTeamController.instance:isNeedFilterTypeWithType(typeId)
	end

	return false
end

function FormTeamView:_onTabUnlock(tabData)
	local data = tabData.data

	return (tabData.root == 1 or tabData.root ~= 1 and tabData.leaf == 0) and FormTeamModel.instance:checkFormTeamTabOpen(data.typeId) or checkbool(data.isFake) and FormTeamModel.instance:checkFormTeamTabOpen(data.typeId) or FormTeamModel.instance:checkIsUnlockBygroupId(data.groupId) ~= nil
end

function FormTeamView:_getChildCellCount()
	return self._leafNum
end

function FormTeamView:_onClickRefresh(isForce)
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

	local tabData = self._commonTab:getCurrTabData()

	if tabData and tabData.data then
		local data = tabData.data

		if tabData.root == 1 or tabData.root ~= 1 and tabData.leaf == 0 then
			FormTeamController.instance:getTeamList(nil, data.typeId)
		elseif checkbool(data.isFake) then
			FormTeamController.instance:getTeamList(nil, data.typeId)
		else
			FormTeamController.instance:getTeamList(data.groupId)
		end
	else
		FloatWordMgr.instance:show(lang("当前未存在开放的组队副本"))
	end
end

function FormTeamView:_endRefreshCD()
	self._refreshCdTimer = self._refreshCdTimer - 1

	if self._refreshCdTimer <= 0 then
		self._inRefreshCD = false

		removetimer(self._endRefreshCD, self)

		self._txtRefresh.text = lang("刷新")
	else
		self._txtRefresh.text = langPara("刷新(%ss)", self._refreshCdTimer)
	end
end

function FormTeamView:_onQuickClickJoin()
	if self._isAutoMatch then
		-- block empty
	else
		self:quickJoin()
	end
end

function FormTeamView:_onClickCreate()
	local tabData = self._commonTab:getCurrTabData()

	if tabData and tabData.data then
		UIStateManager.instance:push(ViewName.FormTeamCreateView, tabData.data.typeId)
	else
		FloatWordMgr.instance:show(lang("当前未存在开放的组队副本"))
	end
end

function FormTeamView:_onClickChat()
	UIStateManager.instance:open(ViewName.chat, GameEnum.ChatChannel.World)
end

function FormTeamView:_updateTeamCell(view, goCell, data)
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

function FormTeamView:_clearTeamCell(goCell)
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

function FormTeamView:_onClickJoin(data)
	FormTeamController.instance:getJoinTeam(data.id, data.groupId)
end

function FormTeamView:getInfo()
	FormTeamController.instance:getUnloadTabList()
end

function FormTeamView:_refreshTabList()
	self._txtCurcoins.text = langPara("%s/%s", math.min(FormTeamModel.instance:getCurGainCoins(), self._curcoinsLimit), self._curcoinsLimit)

	self:_jumpToTab()
end

function FormTeamView:_refreshTeamList()
	self._teamTableView:reloadData(FormTeamModel.instance:getMatchTeamList())
	goutil.setActive(self._goEmpty, FormTeamModel.instance:getMatchTeamListNum() == 0)
end

function FormTeamView:_onError(status)
	if status == -750 then
		self:_onClickRefresh(true)
	elseif status == -740 then
		self:_startAutoMatch()
	end
end

function FormTeamView:_onJoinTeam()
	UIStateManager.instance:push(ViewName.FormTeamCurTeamView)
end

function FormTeamView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "team_rule")
end

function FormTeamView:_onClickClose()
	if self._isAutoMatch then
		TipsFacade.instance:openPopupWindowWithX(lang("tip"), lang("离开组队界面将取消匹配等待状态，是否确定离开？"), GameUtil.handler(self.close, self))
	else
		self:close()
	end
end

function FormTeamView:_startAutoMatch()
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

function FormTeamView:_endAutoMath()
	removetimer(self._onAutoMathCountDown, self)

	self._isAutoMatch = false
	self._txtJoin.text = lang("快速加入")

	goutil.setActive(self._matching, false)
end

function FormTeamView:_onAutoMathCountDown()
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

function FormTeamView:quickJoin()
	local tabData = self._commonTab:getCurrTabData()

	if tabData and tabData.data then
		local data = tabData.data

		if tabData.root == 1 or tabData.root ~= 1 and tabData.leaf == 0 then
			local isCurOpen = FormTeamModel.instance:checkFormTeamTabOpen(data.typeId)

			if isCurOpen then
				FormTeamController.instance:getQuickJoinTeam(nil, data.typeId)

				return
			end
		elseif checkbool(data.isFake) then
			local isCurOpen = FormTeamModel.instance:checkFormTeamTabOpen(data.typeId)

			if isCurOpen then
				FormTeamController.instance:getQuickJoinTeam(nil, data.typeId)

				return
			end
		else
			local isCurOpen = FormTeamModel.instance:checkIsUnlockBygroupId(data.groupId)

			if isCurOpen then
				FormTeamController.instance:getQuickJoinTeam(data.groupId)

				return
			end
		end
	end

	FloatWordMgr.instance:show(lang("当前未存在开放的组队副本"))
end

return FormTeamView
