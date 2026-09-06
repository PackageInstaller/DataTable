-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/view/FormTeamCurTeamView.lua

module("logic.extensions.formteam.view.FormTeamCurTeamView", package.seeall)

local FormTeamCurTeamView = class("FormTeamCurTeamView", ViewComponent)

function FormTeamCurTeamView:buildUI()
	FormTeamCurTeamView.super.buildUI(self)

	self._modelCam = self:getGo("modelCam")
	self._btnClose = self:getGo("lefttop/btnClose")
	self._btnExit = self:getGo("btnExit")
	self._btnChat = self:getGo("btnChat")
	self._btnAddition = self:getGo("btnAddition")
	self._goldBarCon = self:getGo("goldBarCon")
	self._btnReady = self:getGo("btnReady")
	self._txtReady = goutil.findChildTextComponent(self._btnReady, "Text")
	self._teammateList = {}

	for i = 1, 5 do
		local cell = {}

		cell.go = self:getGo("teammateList/player_" .. i)
		cell.pos = goutil.findChild(self._modelCam, "posList/p" .. i)
		cell.playerPos = goutil.findChild(cell.pos, "pos")
		cell.btnCheckInfo = goutil.findChild(cell.go, "btnCheckInfo")
		cell.power = goutil.findChild(cell.go, "power")
		cell.txtPower = goutil.findChildTextComponent(cell.power, "txtPower")
		cell.bubble = goutil.findChild(cell.go, "bubble")
		cell.txtDesc = goutil.findChildTextComponent(cell.bubble, "txtDesc")
		cell.goReady = goutil.findChild(cell.go, "ready")
		cell.btnAdd = goutil.findChild(cell.go, "btnAdd")
		cell.info = goutil.findChild(cell.go, "info")
		cell.txtName = goutil.findChildTextComponent(cell.info, "txtName")
		cell.txtArea = goutil.findChildTextComponent(cell.info, "area/txt")
		cell.txtLevel = goutil.findChildTextComponent(cell.info, "txtLevel")
		cell.head = goutil.findChild(cell.info, "head")
		cell.avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)
		cell.avatar.useType = AvatarUseType.Scene

		cell.avatar:setParent(cell.playerPos.transform)
		cell.avatar:setLayer(SceneLayer.UI3D_Value)

		cell.data = nil
		self._teammateList[i] = cell
	end

	self._tagHelp = self:getGo("tag")
	self._iconCost = self:getGo("cost/txtCost/icon")
	self._txtCost = self:getTxt("cost/txtCost")
	self._txtLevel = self:getTxt("setting/txtLevel")
	self._txtPower = self:getTxt("setting/txtPower")
	self._txtPermission = self:getTxt("setting/txtPermission")
	self._txtCountDown = self:getTxt("cutdown/txt")
	self._btnTip = self:getGo("btnTip")
	self._txtMinAmount = self:getTxt("minAmount/txt")
	self._goChat = self:getGo("chat")
	self._goChatCell = goutil.findChild(self._goChat, "cell")
	self._goChatTable = goutil.findChild(self._goChat, "tableview")
	self._chatTableview = ScrollerList.create(self._goChatTable, self._goChatCell, GameUtil.handler(self._updateChatCell, self), GameUtil.handler(self._clearChatCell, self))
	self._btnAutoReady = self:getGo("btnAutoReady")
	self._txtMarkReady = goutil.findChildTextComponent(self._btnAutoReady, "mark/txt")
	self._txtAutoReady = self:getTxt("txtAutoReady")
end

function FormTeamCurTeamView:destroyUI()
	FormTeamCurTeamView.super.destroyUI(self)

	for i = 1, 5 do
		if self._teammateList[i].avatar then
			AvatarsMgrNew.instance:removeAvatar(self._teammateList[i].avatar)

			self._teammateList[i].avatar = nil
		end
	end
end

function FormTeamCurTeamView:bindEvents()
	FormTeamCurTeamView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickExitTeam, self)
	GameUtil.addClickHandler(self._btnExit, self._onClickExitTeam, self)
	GameUtil.addClickHandler(self._btnChat, self._onClickChat, self)
	GameUtil.addClickHandler(self._btnReady, self._onClickReady, self)
	GameUtil.addClickHandler(self._btnAddition, self._onClickAddition, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnAutoReady, self._onClickAutoReady, self)

	for i = 1, 5 do
		GameUtil.addClickHandler(self._teammateList[i].btnCheckInfo, GameUtil.handler(self._onClickInfo, self, i))
		GameUtil.addClickHandler(self._teammateList[i].btnAdd, GameUtil.handler(self._onClickInvite, self, i))
	end
end

function FormTeamCurTeamView:unbindEvents()
	FormTeamCurTeamView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnExit)
	GameUtil.rmClickHandler(self._btnChat)
	GameUtil.rmClickHandler(self._btnReady)
	GameUtil.rmClickHandler(self._btnAddition)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnAutoReady)

	for i = 1, 5 do
		GameUtil.rmClickHandler(self._teammateList[i].btnCheckInfo)
		GameUtil.rmClickHandler(self._teammateList[i].btnAdd)
	end
end

function FormTeamCurTeamView:onEnter()
	FormTeamCurTeamView.super.onEnter(self)

	self._isCurChatCD = false
	self._isCurShowChat = false
	self._timerAutoReady = 0

	goutil.addChildToParent(self._modelCam)
	GlobalModel.instance:visibleSceneHUDs(false)
	self:_refreshViewByInfo()

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
	GlobalDispatcher:addListener(GlobalNotify.FormTeamLeaveCurTeam, self._onExitCurTeam, self)
	GlobalDispatcher:addListener(GlobalNotify.FormTeamError, self._onError, self)
	GlobalDispatcher:addListener(GlobalNotify.FormTeamLeaveCurTeamChangeInfo, self._onInfoChange, self)
	GlobalDispatcher:addListener(GlobalNotify.FormTeamLeaveCurTeamReady, self._onTeammateReady, self)
	GlobalDispatcher:addListener(GlobalNotify.FormTeamGetReformTime, self._onGetRefeformTime, self)
	GlobalDispatcher:addListener(GlobalNotify.FormTeamChat, self._onSomeoneChat, self)
	self.addGEvent(self, GlobalNotify.FormTeamJoinTeam, self._formTeamJoinTeam, self)
	FormTeamController.instance:handleDealBeforeEnterGame()
	goutil.setActive(self._goChat, self._isCurShowChat)
	self._chatTableview:reloadData(FormTeamConfig.instance:getChatCfgs())
end

function FormTeamCurTeamView:onEnterFinished()
	FormTeamCurTeamView.super.onEnterFinished(self)

	if self._curInfo then
		self:_refreshTeammateList()
	end

	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
end

function FormTeamCurTeamView:onExit()
	FormTeamCurTeamView.super.onExit(self)
	goutil.addChildToParent(self._modelCam, self.mainGO)
	GlobalModel.instance:visibleSceneHUDs(true)
	self:_removeAllTimers()
	MaterialMgr.resetAll(self._iconCost)

	for k, cell in ipairs(self._teammateList) do
		self:resetTeamCell(cell)
		goutil.setActive(cell.go, false)
		cell.avatar:reset(true)
	end

	LightMgr.instance:setLightForNormalScene()
	GlobalDispatcher:removeListener(GlobalNotify.FormTeamError, self._onError, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormTeamLeaveCurTeam, self._onExitCurTeam, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormTeamLeaveCurTeamChangeInfo, self._onInfoChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormTeamLeaveCurTeamReady, self._onTeammateReady, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormTeamGetReformTime, self._onGetRefeformTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormTeamChat, self._onSomeoneChat, self)
	UIStateManager.instance:popByName(ViewName.TeammateInfoView)
end

function FormTeamCurTeamView:_removeAllTimers()
	removetimer(self._onCountDown, self)
	removetimer(self._endChatCD, self)
	removetimer(self._onChatCountDown, self)
	removetimer(self._onAutoReadyCountDown, self)
end

function FormTeamCurTeamView:_refreshViewByInfo()
	for k, cell in ipairs(self._teammateList) do
		self:resetTeamCell(cell)
		goutil.setActive(cell.go, false)
		goutil.setActive(cell.pos, false)
	end

	self._curInfo = FormTeamModel.instance:getCurTeamInfo()

	if self._curInfo then
		self:_refreshSettingPart()
		self:_setAutoReadyPart()
	else
		local text = "当前队伍不存在"

		TipsFacade.instance:openTipWindowNoX("提示", text, GameUtil.handler(self.close, self))
	end
end

function FormTeamCurTeamView:resetTeamCell(cell)
	goutil.setActive(cell.power, false)
	goutil.setActive(cell.bubble, false)
	goutil.setActive(cell.goReady, false)
	goutil.setActive(cell.btnAdd, true)
	goutil.setActive(cell.info, false)
	goutil.setActive(cell.playerPos, false)

	cell.data = nil

	HeadItemController.instance:resetHeadCell(cell.head)
end

function FormTeamCurTeamView:_refreshSettingPart()
	self._teamCfg, self._typeCfg = self._curInfo:getTeamCfgAndTypeCfg()

	GameUtil.SetActive(self._btnAutoReady, not self._typeCfg.isNotAutoReady)

	self._txtLevel.text = langPara("%s-%s", self._typeCfg.name, self._teamCfg.name)
	self._txtPower.text = langPara("%s以上", self._curInfo.zdlLimit)
	self._txtPermission.text = self._curInfo.isOnlyInvite and lang("仅队长邀请") or lang("所有人")

	local isHelp = self._curInfo:checkUserIsHelp()

	if isHelp then
		if not self._teamCfg.helpCost then
			local cost = self._teamCfg.cost

			self._curCost = cost

			MaterialMgr.resetAll(self._iconCost)

			if not string.nilorempty(cost) then
				local costtype, costId, costNum = MaterialMgr.getMatParams(cost)

				MaterialMgr.setIcon(self._iconCost, costtype, costId)

				self._txtCost.text = costNum
				self._curCostName = MaterialMgr.getMaterialsName(costtype, costId)
			else
				self._txtCost.text = lang("无消耗")
			end

			goutil.setActive(self._tagHelp, isHelp)

			for i = 1, self._teamCfg.maxCount do
				self:resetTeamCell(self._teammateList[i])
				goutil.setActive(self._teammateList[i].go, true)
				goutil.setActive(self._teammateList[i].pos, true)
			end

			self._txtReady.text = self._curInfo:checkUserIsReady() and lang("已准备") or lang("准备")
			self._txtMinAmount.text = langPara("最小可挑战人数：%s人", self._teamCfg.minCount)

			if self._curInfo.timeAutoStart > 0 then
				settimer(1, self._onCountDown, self)
				self:_onCountDown()
			else
				FormTeamController.instance:getReformTime()
			end

			local buffCfg = FormTeamConfig.instance:getFetterBuffById(self._typeCfg.buffPlanId)

			goutil.setActive(self._btnAddition, buffCfg)
		end
	end
end

function FormTeamCurTeamView:_refreshTeammateList()
	for i = 1, self._teamCfg.maxCount do
		local data = self._curInfo:getTeammateInfoById(i)
		local cell = self._teammateList[i]

		if data then
			cell.data = data

			goutil.setActive(cell.goReady, data.isReady)

			cell.txtPower.text = data.zdl

			goutil.setActive(cell.power, data.isReady)

			cell.txtName.text = data.headInfo.userName
			cell.txtArea.text = langPara("%s服", data.headInfo.areaName)
			cell.txtLevel.text = langPara("等级：%s", data.headInfo.playerLv)

			HeadItemController.instance:setHeadCellByInfo(cell.head, data.headInfo)
			goutil.setActive(cell.power, true)
			goutil.setActive(cell.btnAdd, false)
			goutil.setActive(cell.info, true)
			goutil.setActive(cell.playerPos, true)
			cell.avatar:updateByMo(data.dressMo)
		end
	end
end

function FormTeamCurTeamView:_onCountDown()
	local leftTime = math.ceil(self._curInfo.timeAutoStart / 1000) - ServerTime.now()

	if leftTime >= 0 then
		self._txtCountDown.text = langPara("<size=44>%s</size>自动开始", GameUtil.FormatTimeWords(leftTime, true))
	else
		removetimer(self._onCountDown, self)
	end
end

function FormTeamCurTeamView:_onClickExitTeam()
	local tip = lang("确定要离开当前队伍吗？")

	TipsFacade.instance:openPopupWindow(lang("提示"), tip, function()
		FormTeamController.instance:leaveCurTeam()
	end)
end

function FormTeamCurTeamView:_onClickReady()
	if not self._curInfo:checkUserIsReady() then
		if self._curCost then
			local isEnough = MaterialMgr.getMatEnough(self._curCost)

			if isEnough then
				FormTeamController.instance:readyForGame()
			else
				FloatWordMgr.instance:show(langPara("当前%s数量不足，无法进入组队准备状态", self._curCostName))
			end
		else
			FormTeamController.instance:readyForGame()
		end
	else
		FloatWordMgr.instance:show(lang("已准备就绪，请等待其他队友准备。"))
	end
end

function FormTeamCurTeamView:_onClickChat()
	if self._isCurChatCD then
		FloatWordMgr.instance:show(lang("CD中，等会再来"))
	else
		self._isCurShowChat = not self._isCurShowChat

		goutil.setActive(self._goChat, self._isCurShowChat)
	end
end

function FormTeamCurTeamView:_onClickAddition()
	FormTeamController.instance:getCurFetterInfo()
end

function FormTeamCurTeamView:_onClickInvite(id)
	if self._curInfo.isOnlyInvite then
		if self._curInfo:checkUserIsTeamLeader() then
			UIStateManager.instance:push(ViewName.FormTeamInviteTypeView, self._teamCfg)
		else
			FloatWordMgr.instance:show(lang("仅队长可邀请"))
		end
	else
		UIStateManager.instance:push(ViewName.FormTeamInviteTypeView, self._teamCfg)
	end
end

function FormTeamCurTeamView:_onClickInfo(id)
	local data = self._curInfo:getTeammateInfoById(id)

	if data and not self._curInfo:checkUserIsPosId(id) then
		UIStateManager.instance:open(ViewName.TeammateInfoView, data, self._teammateList[id].btnCheckInfo, id == 1, self._curInfo:checkUserIsTeamLeader())
	end
end

function FormTeamCurTeamView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "team_rule")
end

function FormTeamCurTeamView:_onError(status)
	return
end

function FormTeamCurTeamView:_onExitCurTeam()
	self:close()
	UIStateManager.instance:push(ViewName.FormTeamView, self._teamCfg.groupId)
end

function FormTeamCurTeamView:_formTeamJoinTeam(res)
	self:_removeAllTimers()
	self:_refreshViewByInfo()

	if self._curInfo then
		self:_refreshTeammateList()

		self._txtReady.text = self._curInfo:checkUserIsReady() and lang("已准备") or lang("准备")

		self:_setAutoReadyPart()
	end
end

function FormTeamCurTeamView:_onChat()
	return
end

function FormTeamCurTeamView:_onInfoChange()
	self._curInfo = FormTeamModel.instance:getCurTeamInfo()

	for i = 1, self._teamCfg.maxCount do
		self:resetTeamCell(self._teammateList[i])
	end

	self:_refreshTeammateList()
end

function FormTeamCurTeamView:_onTeammateReady()
	self._curInfo = FormTeamModel.instance:getCurTeamInfo()

	for i = 1, self._teamCfg.maxCount do
		local data = self._curInfo:getTeammateInfoById(i)

		goutil.setActive(self._teammateList[i].goReady, data and data.isReady)
	end

	self._txtReady.text = self._curInfo:checkUserIsReady() and lang("已准备") or lang("准备")

	self:_setAutoReadyPart()
end

function FormTeamCurTeamView:_onGetRefeformTime()
	settimer(1, self._onCountDown, self)
	self:_onCountDown()
end

function FormTeamCurTeamView:_updateChatCell(view, goCell, data)
	local cell = self:_clearChatCell(goCell)

	cell.txt.text = data.quickChat

	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onSelectChat, self, data))
end

function FormTeamCurTeamView:_clearChatCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txt = goutil.findChildTextComponent(cell.go, "txt")
	cell.txt.text = ""

	GameUtil.rmClickHandler(cell.go)

	return cell
end

function FormTeamCurTeamView:_onSelectChat(data)
	self._isCurChatCD = true
	self._isCurShowChat = false

	goutil.setActive(self._goChat, self._isCurShowChat)

	local chatCDTimer = checkint(FormTeamConfig.instance:getCommonValue("CHAT_CD"))

	settimer(chatCDTimer, self._endChatCD, self, false)
	FormTeamController.instance:chatWithSimpleId(data.id)
end

function FormTeamCurTeamView:_onSomeoneChat(userId, chatId)
	removetimer(self._onChatCountDown, self)

	self._chatHashTab = self._chatHashTab or {}

	local chatCfg = FormTeamConfig.instance:getChatCfgById(chatId)
	local content = chatCfg and chatCfg.quickChat
	local chatPosId = table.keyof(self._curInfo.teammateUserIdList, userId)

	if chatPosId and not string.nilorempty(content) then
		self._chatHashTab[chatPosId] = ServerTime.now() + checkint(FormTeamConfig.instance:getCommonValue("CHAT_SHOW_TIME"))
		self._teammateList[chatPosId].txtDesc.text = content

		goutil.setActive(self._teammateList[chatPosId].bubble, true)
	end

	if table.nums(self._chatHashTab) > 0 then
		settimer(0.5, self._onChatCountDown, self)
	end
end

function FormTeamCurTeamView:_onChatCountDown()
	local timeNow = ServerTime.now()

	for k, v in pairs(self._chatHashTab) do
		if v < timeNow then
			goutil.setActive(self._teammateList[k].bubble, false)

			self._chatHashTab[k] = nil
		end
	end

	if table.nums(self._chatHashTab) <= 0 then
		removetimer(self._onChatCountDown, self)
	end
end

function FormTeamCurTeamView:_endChatCD()
	self._isCurChatCD = false
end

function FormTeamCurTeamView:_onClickAutoReady()
	local autoState = FormTeamModel.instance:getTeamAutoReadyState(self._teamCfg.groupId)

	if autoState == GameEnum.FormTeamAutoReadyState.Not_Play_Before then
		FloatWordMgr.instance:show(langPara("需要挑战过1次组队模式才可以开启自动准备"))
	elseif autoState == GameEnum.FormTeamAutoReadyState.Auto then
		FormTeamModel.instance:setTeamAutoReadyState(self._teamCfg.groupId, GameEnum.FormTeamAutoReadyState.Not_Ready)
		FloatWordMgr.instance:show(langPara("自动准备已关闭"))
	elseif autoState == GameEnum.FormTeamAutoReadyState.Not_Ready then
		FormTeamModel.instance:setTeamAutoReadyState(self._teamCfg.groupId, GameEnum.FormTeamAutoReadyState.Auto)
		FloatWordMgr.instance:show(langPara("自动准备已开启"))
	end

	self:_setAutoReadyPart()
end

function FormTeamCurTeamView:_setAutoReadyPart()
	local autoState = FormTeamModel.instance:getTeamAutoReadyState(self._teamCfg.groupId)

	if autoState == GameEnum.FormTeamAutoReadyState.Auto then
		self:_setAutoReadyState(true)
	else
		self:_setAutoReadyState(false)
	end
end

function FormTeamCurTeamView:_setAutoReadyState(isOn)
	removetimer(self._onAutoReadyCountDown, self)

	self._txtAutoReady.text = ""

	if isOn then
		if self._curInfo:checkUserIsReady() then
			-- block empty
		else
			if self._timerAutoReady <= 0 then
				self._timerAutoReady = checkint(FormTeamConfig.instance:getCommonValue("AUTO_READY_TIME"))
			end

			self._timerAutoReady = self._timerAutoReady + 1

			self:_onAutoReadyCountDown()
			settimer(1, self._onAutoReadyCountDown, self)
		end

		self._txtMarkReady.text = lang("开")
	else
		self._txtMarkReady.text = lang("关")
		self._timerAutoReady = 0
	end
end

function FormTeamCurTeamView:_onAutoReadyCountDown()
	self._timerAutoReady = self._timerAutoReady - 1

	if self._timerAutoReady > 0 then
		self._txtAutoReady.text = langPara("%s秒后自动准备", self._timerAutoReady)
	else
		self._txtAutoReady.text = ""

		removetimer(self._onAutoReadyCountDown, self)

		if self._curCost then
			local isEnough = MaterialMgr.getMatEnough(self._curCost)

			if isEnough then
				FormTeamController.instance:readyForGame()
			else
				FloatWordMgr.instance:show(langPara("当前%s数量不足，自动准备关闭", self._curCostName))
			end
		else
			FormTeamController.instance:readyForGame()
		end
	end
end

return FormTeamCurTeamView
