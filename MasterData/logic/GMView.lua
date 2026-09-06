-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/GMView.lua

module("logic.extensions.gm.view.GMView", package.seeall)

local GMView = class("GMView", ViewComponent)
local json = require("cjson")
local GameUrl_getSpineUrl = GameUrl.getSpineUrl
local GameUrl_getSpineUIUrl = GameUrl.getSpineUIUrl
local GameUrl_getLihuiSpineUrl = GameUrl.getLihuiSpineUrl
local GameUrl_getLihuiSpineUIUrl = GameUrl.getLihuiSpineUIUrl
local GameUrl_getSpineAssetRrl = GameUrl.getSpineAssetRrl
local GameUrl_getPetImgUrl = GameUrl.getPetImgUrl
local GameUrl_getPosterSpineUrl = GameUrl.getPosterSpineUrl
local CharacterConfig_GetCharacterResIdx = CharacterConfig.GetCharacterResIdx

function GMView:ctor()
	GMView.super.ctor(self)

	self._startTime = 0
	GMView.instance = self
	self._inputTxts = {}
	self._inputTxtIndex = 0
	self._searchDataArrays = {}

	if enableDebug == true then
		local getresFunc = getglobal("getres")

		function getres2(resPath, handler, handlerObj, resType, isPreload)
			if resPath ~= string.lower(resPath) then
				printError(">>>>>>>>Error!!!!!!!!!!!!!为什么路径有大写？？", resPath)
			end

			getresFunc(resPath, handler, handlerObj, resType, isPreload)
		end

		setglobal("getres", getres2)
	end
end

function GMView:test(arr)
	return
end

function GMView:sendError()
	printError(">>>>>>>>Error!!!!!!!!!!!!!!!自定义报错")
end

local ____creeps_rev = 1

function GMView:allCreepRev(arr)
	____creeps_rev = ____creeps_rev * -1

	local dic = ConfigMgr.instance._configDict

	for k, v in pairs(dic) do
		local a, b = string.find(k, "_creeps")

		if a ~= nil then
			local list = v.dataList

			for i, cfg in ipairs(list) do
				if cfg.posId then
					rawset(cfg, "posId", -cfg.posId)
				end
			end
		end
	end

	printError(">>>>>>>>>>>>>>>>>>>>>当前creeps 状态：", ____creeps_rev)
end

function GMView:_onKeycodeChange(keycode, isOn)
	print(">>>>>>>>>>>press ", keycode, isOn)

	local inst = KeycodeListener.instance

	if inst:isOn(UnityEngine.KeyCode.F1) then
		local root = ViewMgr.instance:getRoot(ViewRootType.TopMost)

		if self._viewPresentor.mainGO.transform.parent ~= root then
			goutil.addChildToParent(self._viewPresentor.mainGO, root)
		end

		self:_show(not self._isShow)
	elseif inst:isOn(UnityEngine.KeyCode.F2) then
		GameUtil.SetActive(self._tipsGo, not GameUtil.GetActive(self._tipsGo))
	elseif inst:isOn(UnityEngine.KeyCode.F4) then
		StoryController.instance:finishCurrStory()
		StoryModel.instance:endStory()
		GlobalModel.instance:showUI(true, GlobalModel.UIFadeTime)
		UIStateManager.instance:clear(true)
	elseif inst:isOn(UnityEngine.KeyCode.F6) then
		rescache:Dump()
	elseif inst:isOn(UnityEngine.KeyCode.F9) then
		GotoMgr.curItemMo = nil

		print(">>>&&&&&&&&&&&&&&&&&&&&&&&&&&& <color='#ff0000'>清除了物品记录</color>")
	elseif inst:isOn(UnityEngine.KeyCode.F12) then
		PlayerAgent.instance:sendGetMyDisplayCardInfoReq(function(msg)
			RoleModel.instance:setMyCardInfo(msg)

			local curMo = RoleModel.instance:getCardInfoMo(RoleModel.CardBelong.My)
			local serStr = "当前服务器：" .. "[" .. curMo.zoneId .. "]" .. curMo.zoneName

			FloatWordMgr.instance:show(serStr)
		end, nil, function()
			self._isReqingRoleInfo = false
		end)

		local taskes = TaskModel.instance:getCurrentTriggerTaskesByType(GameEnum.TaskType.Main)

		if taskes then
			for i = 1, #taskes do
				FloatWordMgr.instance:show("当前任务：" .. taskes[i]:getTaskId() .. "_" .. taskes[i]:getStepId())
			end
		end
	elseif inst:isOn(UnityEngine.KeyCode.Return) then
		self:_onClickChallengeId()
	elseif inst:isOn(UnityEngine.KeyCode.UpArrow) then
		local txt = self:_getLastInputTxt()

		if not string.nilorempty(txt) then
			self:_setClgText(txt)
		end
	elseif inst:isOn(UnityEngine.KeyCode.DownArrow) then
		local txt = self:_getNextInputTxt()

		if not string.nilorempty(txt) then
			self:_setClgText(txt)
		end
	end
end

function GMView:bindEvents()
	GMView.super.bindEvents(self)

	self._clgInputPointerClickHandler = PointerClickHandler.Get(self._clgInputGo):AddLuaHandler(function(_go, eventData)
		self:_onClgInputPointerClickHandler(_go, eventData)
	end)
	self._itemSearchInputPointerClickHandler = PointerClickHandler.Get(self._itemSearchInputGo):AddLuaHandler(function(_go, eventData)
		self:_onItemSearchInputPointerClickHandler(_go, eventData)
	end)

	self._itemScrCustomInput:AddListener(self._onItemScrCustomInputCallback, self)
end

function GMView:unbindEvents()
	GMView.super.unbindEvents(self)
	PointerClickHandler.Get(self._clgInputGo):RemoveLuaHandler(self._clgInputPointerClickHandler)
	PointerClickHandler.Get(self._itemSearchInputGo):RemoveLuaHandler(self._itemSearchInputPointerClickHandler)
	self._itemScrCustomInput:RemoveListener()
end

function GMView:buildUI()
	self._gmGo = self:getGo("Right/gm")
	self._bgGo = self:getGo("Right/gm/bg1")
	self._openButton = self:getBtn("Right/gm/Open")
	self._addButton = self:getBtn("Right/gm/bg1/BtnAdd")
	self._addOneButton = self:getBtn("Right/gm/bg1/Btn1")
	self._add100Button = self:getBtn("Right/gm/bg1/Btn100")
	self._searchButton = self:getBtn("Right/gm/bg1/BtnSearch")
	self.BtnChange = self:getBtn("Right/gm/BtnChange")
	self.BtnSpeed = self:getBtn("Right/gm/BtnSpeed")
	self._closeButton = self:getBtn("Right/gm/Close")
	self._closePanelButton = self:getBtn("Right/gm/bg1/BtnClosePanel")
	self._moreBotton = self:getBtn("Right/gm/bg1/BtnMore")
	self._fightBotton = self:getBtn("Right/gm/bg1/BtnFight")
	self._challengeBotton = self:getBtn("Right/gm/bg1/BtnChallenge")
	self._challengeIdBotton = self:getBtn("Right/gm/bg1/BtnChallengeId")
	self.txtTime = self:getTxt("Right/gm/bg1/txtTips/txtTime")
	self.txtArea = self:getTxt("Right/gm/bg1/txtTips/txtArea")
	self._exInfo = self:getGo("Right/gm/bg1/exInfo")
	self._exInfo_txt1 = self:getTxt("Right/gm/bg1/exInfo/txt1")
	self._exInfo_txt2 = self:getTxt("Right/gm/bg1/exInfo/txt2")
	self._branchesTag = self:getGo("Right/gm/branchesTag")
	self._imgBranchesTag = self:getGo("Right/gm/branchesTag/img")
	self._btnMsg = {}

	local mainGo = goutil.findChild(self.mainGO, "Right/gm/BtnMsg")

	self._btnMsg._mainGo = mainGo
	self._btnMsg._redPoint = goutil.findChild(mainGo, "redPoint")
	self._btnMsg._imgError = goutil.findChild(mainGo, "imgError")
	self._btnMsg._txtRedPoint = goutil.findChildTextComponent(mainGo, "redPoint/txt")
	self._itemScrGo = goutil.findChild(self.mainGO, "Right/gm/bg1/Scroll")

	local itemScrView = goutil.findChild(self.mainGO, "Right/gm/bg1/Scroll/ScrollView")
	local itemScrCell = goutil.findChild(self.mainGO, "Right/gm/bg1/Cell")

	self._itemScrollList = ScrollerList.create(itemScrView, itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
	self._itemScrCustomInput = UICustomInput.Get(self._itemScrGo)
	self._clgInputGo = self:getGo("Right/gm/bg1/ClgInput/Input")
	self.clgInput = self._clgInputGo:GetComponent(ComponentType.InputField)
	self._clgText = self:getInput("Right/gm/bg1/ClgInput/Input")
	self._itemSearchInputGo = self:getGo("Right/gm/bg1/Input/Search/Input")
	self._searchText = self:getInput("Right/gm/bg1/Input/Search/Input")
	self._typeText = self:getInput("Right/gm/bg1/Input/Type/Input")
	self._subTypeText = self:getInput("Right/gm/bg1/Input/SubType/Input")
	self._idText = self:getInput("Right/gm/bg1/Input/Id/Input")
	self._numText = self:getInput("Right/gm/bg1/Input/Num/Input")

	local tweens = self._gmGo:GetComponents(UnityTweensType.TweenPosition)

	for i = 0, tweens.Length - 1 do
		if tweens[i].tag == 1 then
			self._tweenIn = tweens[i]
		else
			self._tweenOut = tweens[i]
		end
	end

	self._tipsGo = self:getGo("tips")
	self._txtTips = self:getTxt("tips/txt")
end

function GMView:destroyUI()
	return
end

function GMView:onEnter()
	self._openButton:AddClickListener(self._onClickOpen, self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._addButton:AddClickListener(self._onClickAdd, self)
	self._addOneButton:AddClickListener(self._onClickAddOne, self)
	self._add100Button:AddClickListener(self._onClickAddHundred, self)
	self._searchButton:AddClickListener(self._onClickSearch, self)
	GameUtil.addClickHandler(self._btnMsg._mainGo, self._onClickMsg, self)
	GameUtil.addClickHandler(self._btnMsg._redPoint, self._onClickMsgRedPoint, self)
	self.BtnChange:AddClickListener(self._onClickBtnChange, self)
	self.BtnSpeed:AddClickListener(self._onClickBtnSpeed, self)
	self._closePanelButton:AddClickListener(self._onClickClosePanel, self)
	self._moreBotton:AddClickListener(self._onClickMoreButton, self)
	self._fightBotton:AddClickListener(self._onClickFight, self)
	self._challengeBotton:AddClickListener(self._onClickChallenge, self)
	self._challengeIdBotton:AddClickListener(self._onClickChallengeId, self)
	self._searchText:AddOnValueChanged(self._onClickSearch, self)

	if KeycodeListener.instance.enabled then
		KeycodeListener.instance:addListener(UnityEngine.KeyCode.F1, self._onKeycodeChange, self)
		KeycodeListener.instance:addListener(UnityEngine.KeyCode.F2, self._onKeycodeChange, self)
		KeycodeListener.instance:addListener(UnityEngine.KeyCode.F4, self._onKeycodeChange, self)
		KeycodeListener.instance:addListener(UnityEngine.KeyCode.F6, self._onKeycodeChange, self)
		KeycodeListener.instance:addListener(UnityEngine.KeyCode.F9, self._onKeycodeChange, self)
		KeycodeListener.instance:addListener(UnityEngine.KeyCode.F12, self._onKeycodeChange, self)
		KeycodeListener.instance:addListener(UnityEngine.KeyCode.Return, self._onKeycodeChange, self)
		KeycodeListener.instance:addListener(UnityEngine.KeyCode.UpArrow, self._onKeycodeChange, self)
		KeycodeListener.instance:addListener(UnityEngine.KeyCode.DownArrow, self._onKeycodeChange, self)
	end

	self:_show(false)
	self:_onUpdateItemScr(nil, nil)
	self:_onLoadLocalSearchData()
	self._openButton.gameObject:SetActive(not self._isShow)
	self._closeButton.gameObject:SetActive(self._isShow)
	self:startShowTime()

	local areaId = RoleModel.instance:getAreaId()
	local areaName = RoleModel.instance:getAreaName()
	local zoneId = RoleModel.instance:getZoneId()
	local zoneName = RoleModel.instance.myRoleMo.zoneName

	self.txtArea.text = string.format("%s-%s\n%s-%s", areaId or "?", areaName or "??", zoneId or "???", zoneName or "????")

	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.showClock, self)
	self:_updateExInfoUI()
	self:_updateMsgRedPoint()
	GlobalDispatcher:addListener(GMModel.Notify.GMCONTROLLER_DUMP_MSG, self._updateMsgRedPoint, self)
	GlobalDispatcher:addListener(GMModel.Notify.RECEIVED_SHUTDOWN_SERVER_REQUEST, self._onShowShutDownAlert, self)
	GlobalDispatcher:addListener(GlobalNotify.NetDisconnected, self._onNetDisconnected, self, NotifyPriority.High)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationQuit, self._onSaveSearchDataToLocal, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewOpen, self._onViewOpened, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClosed, self)
	self.addGEvent(self, GlobalNotify.OnBattleRoundStart, self._onBattleRoundStart, self)
end

function GMView:onExit()
	self._openButton:RemoveClickListener()
	self._closeButton:RemoveClickListener()
	self._addButton:RemoveClickListener()
	self._addOneButton:RemoveClickListener()
	self._add100Button:RemoveClickListener()
	self._searchButton:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnMsg._mainGo)
	GameUtil.rmClickHandler(self._btnMsg._redPoint)
	self.BtnChange:RemoveClickListener()
	self.BtnSpeed:RemoveClickListener()
	self._closePanelButton:RemoveClickListener()
	self._moreBotton:RemoveClickListener()
	self._fightBotton:RemoveClickListener()
	self._challengeBotton:RemoveClickListener()
	self._challengeIdBotton:RemoveClickListener()
	self._clgText:RemoveOnValueChanged()
	self._searchText:RemoveOnValueChanged()
	self:_onClearItemScr()
	self:_stopWwwLoadTicking()
	self:_onResetFunction()

	if KeycodeListener.instance.enabled then
		KeycodeListener.instance:removeListener(UnityEngine.KeyCode.F1, self._onKeycodeChange, self)
		KeycodeListener.instance:removeListener(UnityEngine.KeyCode.F2, self._onKeycodeChange, self)
		KeycodeListener.instance:removeListener(UnityEngine.KeyCode.F4, self._onKeycodeChange, self)
		KeycodeListener.instance:removeListener(UnityEngine.KeyCode.F6, self._onKeycodeChange, self)
		KeycodeListener.instance:removeListener(UnityEngine.KeyCode.F9, self._onKeycodeChange, self)
		KeycodeListener.instance:removeListener(UnityEngine.KeyCode.F12, self._onKeycodeChange, self)
		KeycodeListener.instance:removeListener(UnityEngine.KeyCode.Return, self._onKeycodeChange, self)
		KeycodeListener.instance:removeListener(UnityEngine.KeyCode.UpArrow, self._onKeycodeChange, self)
		KeycodeListener.instance:removeListener(UnityEngine.KeyCode.DownArrow, self._onKeycodeChange, self)
	end

	self:stopShowTime()
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self.showClock, self)
	GlobalDispatcher:removeListener(GMModel.Notify.GMCONTROLLER_DUMP_MSG, self._updateMsgRedPoint, self)
	GlobalDispatcher:removeListener(GMModel.Notify.RECEIVED_SHUTDOWN_SERVER_REQUEST, self._onShowShutDownAlert, self)
	GlobalDispatcher:removeListener(GlobalNotify.NetDisconnected, self._onNetDisconnected, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewOpen, self._onViewOpened, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewClose, self._onViewClosed, self)
	self:_onSaveSearchDataToLocal()
end

function GMView:showClock()
	print("<color='#FF3300'>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>5点刷新>>>>>>>>>>>>>>>>></color>")
end

function GMView:_onNetDisconnected()
	removetimer(self._onShoutdownTimer, self)

	if self._shutViewPresentor and self._gmRecordPopUpId and self._shutViewPresentor.ID == self._gmRecordPopUpId then
		ViewMgr.instance:close(self._shutViewPresentor.viewName)
	end

	self._gmRecordPopUpId = nil
	self._shutViewPresentor = nil
end

function GMView:_onShowShutDownAlert(sec)
	removetimer(self._onShoutdownTimer, self)

	sec = math.max(0, checknumber(sec) - 2)

	if sec == 0 then
		return
	end

	local str = " ~~~~~~有人要重启了！！！你可以停止它！！！\n\n" .. "<size=8>" .. "* _______________#########_______________________\n" .. "* ______________############_____________________\n" .. "* ______________#############____________________\n" .. "* _____________##__###########___________________\n" .. "* ____________###__######_#####__________________\n" .. "* ____________###_#######___####_________________\n" .. "* ___________###__##########_####________________\n" .. "* __________####__###########_####_______________\n" .. "* ________#####___###########__#####_____________\n" .. "* _______######___###_########___#####___________\n" .. "* _______#####___###___########___######_________\n" .. "* ______######___###__###########___######_______\n" .. "* _____######___####_##############__######______\n" .. "* ____#######__#####################_#######_____\n" .. "* ____#######__##############################____\n" .. "* ___#######__######_#################_#######___\n" .. "* ___#######__######_######_#########___######___\n" .. "* ___#######____##__######___######_____######___\n" .. "* ___#######________######____#####_____#####____\n" .. "* ____######________#####_____#####_____####_____\n" .. "* _____#####________####______#####_____###______\n" .. "* ______#####_______###________###______#________\n" .. "* ________##_______####________####______________\n" .. "</size>"

	self._curTime = 0
	self._shutTime = sec
	self._shutViewPresentor = TipsFacade.instance:openPopupWindow(langPara("离重启还有%ss", sec), str, function()
		removetimer(self._onShoutdownTimer, self)
	end, function()
		removetimer(self._onShoutdownTimer, self)
		GMAgent.instance:sendPM_RejectShutdownServerReq()
	end, "算了", "别重启")
	self._gmRecordPopUpId = self._shutViewPresentor.ID

	settimer(1, self._onShoutdownTimer, self)
end

function GMView:_onShoutdownTimer()
	self._curTime = self._curTime + 1

	if self._curTime > self._shutTime then
		self:_onNetDisconnected()
	elseif self._shutViewPresentor and self._gmRecordPopUpId and self._shutViewPresentor.ID == self._gmRecordPopUpId and self._shutViewPresentor._views and self._shutViewPresentor._views[1] and self._shutViewPresentor._views[1]._titleTxt then
		self._shutViewPresentor._views[1]._titleTxt.text = langPara("离重启还有%ss", self._shutTime - self._curTime)
	end
end

function GMView:startShowTime()
	settimer(1, self.updateSerTime, self)
end

function GMView:stopShowTime()
	removetimer(self.updateSerTime, self)
end

function GMView:updateSerTime()
	self.txtTime.text = GameUtil.formatTimeStamp("%Y-%m-%d %H:%M:%S", ServerTime.now())
end

function GMView:_show(bShow)
	if self._isShow == bShow then
		return
	end

	self._isShow = bShow

	self._bgGo:SetActive(bShow)
	self._openButton.gameObject:SetActive(not self._isShow)
	self._closeButton.gameObject:SetActive(self._isShow)

	if self._isShow then
		self.clgInput:ActivateInputField()
		self:_setClgText(GameUtil.getLocalString("GM_SearchChanged", ""))
	end

	if self._isShow then
		self._tweenIn:Begin()
	else
		self._tweenOut:Begin()
	end
end

function GMView:_onClickOpen()
	self:_show(true)
end

function GMView:_onClickClose()
	self:_show(false)
end

function GMView:_onClickClosePanel()
	ViewMgr.instance:closeAllViews()
	UIStateManager.instance:clear(true)
end

function GMView:_onClickAdd()
	local mat = ""
	local ids = TableUtil.split(self._idText:GetText(), "#")
	local value = checknumber(self._numText:GetText())
	local num = math.abs(value)
	local matType = checknumber(self._typeText:GetText())
	local lvl = checknumber(self._subTypeText:GetText())

	if lvl == 0 then
		for i, v in ipairs(ids) do
			mat = i == 1 and ((matType == MatType.Equipment or matType == MatType.PET_SKIN) and matType .. ":" .. v .. ":" .. lvl .. ":" .. num or matType == MatType.CutePet and matType .. ":" .. v .. ":" .. self._subTypeText:GetText() .. ":" .. num or matType .. ":" .. v .. ":" .. num) or (matType == MatType.Equipment or matType == MatType.PET_SKIN) and mat .. "#" .. matType .. ":" .. v .. ":" .. lvl .. ":" .. num or matType == MatType.CutePet and mat .. "#" .. matType .. ":" .. v .. ":" .. self._subTypeText:GetText() .. ":" .. num or mat .. "#" .. matType .. ":" .. v .. ":" .. num
		end
	else
		for i, v in ipairs(ids) do
			mat = i == 1 and matType .. ":" .. v .. ":" .. lvl .. ":" .. num or mat .. "#" .. matType .. ":" .. v .. ":" .. lvl .. ":" .. num
		end
	end

	if value > 0 then
		GMAgent.instance:sendPM_AddMaterialsReq(mat, 0, function()
			FloatWordMgr.instance:show("添加物品成功")
		end)
	elseif value < 0 then
		GMAgent.instance:sendPM_DecMaterialsReq(mat, function()
			FloatWordMgr.instance:show("删除物品成功")
		end, nil, function()
			FloatWordMgr.instance:show("删除物品 不成功 具体问后端")
		end)
	end
end

function GMView:_onClickAddOne()
	self._numText:SetText("1")
	self:_onClickAdd()
end

function GMView:_onClickAddHundred()
	self._numText:SetText("100")
	self:_onClickAdd()
end

function GMView:_onClickFight()
	UIStateManager.instance:push(ViewName.DebugView)
	self:_show(false)

	local view = self._viewPresentor._views[2]

	view:hide()
end

function GMView:_saveInputTxt(str)
	if type(str) == "string" and not string.nilorempty(str) then
		table.indexof(self._inputTxts, str)

		if not table.indexof(self._inputTxts, str) then
			table.insert(self._inputTxts, str)

			self._inputTxtIndex = #self._inputTxts
		end
	end
end

function GMView:_getLastInputTxt()
	if #self._inputTxts > 0 then
		if self._inputTxtIndex < 1 then
			return ""
		end

		local index = self._inputTxtIndex

		self._inputTxtIndex = self._inputTxtIndex - 1

		return self._inputTxts[index]
	end

	return ""
end

function GMView:_getNextInputTxt()
	if #self._inputTxts > 0 then
		if self._inputTxtIndex == #self._inputTxts then
			return ""
		end

		self._inputTxtIndex = self._inputTxtIndex + 1

		return self._inputTxts[self._inputTxtIndex]
	end

	return ""
end

function GMView:_onClickChallenge()
	local popupConfig = {}

	popupConfig.displayOpts = {
		"千鸟丸",
		"末炎",
		"寒冰",
		"卡雅公主",
		"怨灵毒宝",
		"圣光飞龙",
		"问问",
		"九九",
		"修尔",
		"熊猫",
		"水圣主",
		"千机",
		"火圣主",
		"冰灵王",
		"天蛮王",
		"龙君焰",
		"苍零式",
		"空无流",
		"芒"
	}
	popupConfig.onSelectIndex = self._onSelectChallenge
	popupConfig.handlerTarget = self
	popupConfig.showClose = true
	popupConfig.align = 1
	popupConfig.closeInSelect = true
	popupConfig.closeOnClickOutside = true

	TipsFacade.instance:openPopupMenu(popupConfig)
end

function GMView:_onClickChallengeId()
	if not self._isShow then
		return
	end

	local text = self._clgText:GetText()

	if not text or #text == 0 then
		return
	end

	self:_addSearchData(GmEnum.ItemScrType_Command, text)

	local cId = checknumber(text)

	if cId and cId > 0 then
		FuncOpenController.instance:openFunc(cId)
	else
		self:_onDealCommand(text)
	end

	self:_onClickClose()
end

function GMView:_onDealCommand(txt)
	txt = string.trim(txt)

	local num

	txt = string.gsub(txt, " ", " ")
	txt, num = string.gsub(txt, "  ", " ")

	while num > 0 do
		txt, num = string.gsub(txt, "  ", " ")
	end

	local arr = string.split(txt, " ")
	local str = arr[1]

	if str ~= nil then
		str = string.upper(str)
	end

	self:_saveInputTxt(txt)

	if str == "PROFILER" then
		UIStateManager.instance:push("profiler")
	elseif str == "PS" or str == "PLSPD" or str == "YDSU" or str == "移动速度" then
		self:_setPlayerSpeed(arr[2])
	elseif str == "TASK" or str == "TA" or str == "TS" then
		self:jumpTask(arr)
	elseif str == "ONLINE" or str == "OL" or str == "ON" then
		self:setOnlineTime(arr)
	elseif str == "CHALLENGE" or str == "CH" then
		self:setChallenge(arr)
	elseif str == "ITEM" then
		self:addItems(arr)
	elseif str == "OPEN" or str == "OP" then
		self:openView(arr, false)
	elseif str == "OPENNOCLOSE" or str == "OPN" then
		self:openView(arr, true)
	elseif str == "ZMD" then
		self:sendZouMaDeng(arr)
	elseif str == "GUIDE" or str == "GU" then
		self:guideTest(arr)
	elseif str == "MOVIE" or str == "MV" then
		self:playMv(arr)
	elseif str == "拼格子" then
		self:generateTilingScene(arr)
	elseif str == "赛季玩法" or str == "SJWF" then
		self:generateSeasonSystem(arr)
	elseif str == "领域冒险" then
		self:enterDomainAdventureScene(arr)
	elseif str == "ADV" then
		self:domainAdventureSceneGmTest(arr)
	elseif str == "虹桥半径" then
		self:generateSeasonRainbowCircle(arr)
	elseif str == "赛季地图跳转" then
		self:generateSeasonJump(arr)
	elseif str == "答题" then
		AnswerSceneController.instance:enterAnswerScene()
	elseif str == "测试答题题目" then
		AnswerSceneModel.instance.testQuestions = true
	elseif str == "跳过测试" then
		self:testSkippedBattle(arr)
	elseif str == "TEST" then
		self:test(arr)
	elseif str == "CREV" then
		self:allCreepRev(arr)
	elseif str == "SPEED" or str == "SPD" then
		self:changeTimeScale(arr)
	elseif str == "对比" or str == "PETCOM" then
		self:petCompare(arr)
	elseif str == "当前阵对比" or str == "PETCOMERR" then
		GMView.petCompareForm(arr)
	elseif str == "PETSHOW" then
		self:petShow()
	elseif str == "BATTLESHOWZDL" then
		BattleModel.instance.showPetZdl = true
	elseif str == "GOTO" then
		self:gmGoto(arr)
	elseif str == "DELPET" or str == "删宠" or str == "PETDEL" then
		self:deletePet(arr)
	elseif str == "新手" or str == "XINSHOU" then
		self:passNew(arr)
	elseif str == "ACTIVEBATTLEGM" then
		if arr[2] == "true" or arr[2] == "false" then
			local isOpen = string.upper(arr[2]) == "TRUE"

			FloatWordMgr.instance:show(isOpen and "开启战斗GM" or "关闭战斗GM")
			GMController.instance:setOpenBattleGMView(isOpen)
		end
	elseif str == "STORY" or str == "剧情" then
		self:playStory(arr)
	elseif str == "对话" then
		self:playNpcChatStory(arr)
	elseif str == "关闭LOG" then
		self:_enabledLog(true)
	elseif str == "打开LOG" then
		self:_enabledLog(false)
	elseif str == "场景切换" or str == "SCENE" then
		self:parseSceneTrans(arr)
	elseif str == "节日场景" then
		self:parseFestivalSceneTrans(arr)
	elseif str == "NPC" then
		self:parseGotoNpc(arr)
	elseif str == "JLJS" then
		self:parsePetIntrod(arr)
	elseif str == "NPCJS" then
		self:parseNpcIntrod(arr)
	elseif str == "ZB" or str == "坐标" then
		self:showMainPlayerPos(arr)
	elseif str == "挑战速度" then
		self:exportChallengeTeamSpeed(arr)
	elseif str == "夺宝奇兵" or str == "DBQB" then
		self:enterTreasureRaiderScene(arr)
	elseif str == "外链" then
		self:parseOuterLinkUrl(arr)
	elseif str == "SLYJ" then
		self:parseExpedMapPath(arr)
	elseif str == "风控" then
		self:fengkongTest(arr)
	elseif str == "勇者速度" then
		self:exportTowerTeamSpeed(arr)
	elseif str == "UNLOCKSCENE" or str == "解锁场景" or str == "ULS" then
		UnlockFacade.dontcheckTaskUnlockScene = true
	elseif str == "CHANGEMODEL" or str == "换模" or str == "CM" then
		self:changePlayerModel(arr)
	elseif str == "VIEW" then
		if enableDebug then
			ViewCheck.instance:printAllViewTime()
			UIStateManager.instance:push(ViewName.ViewCheckView)
		end
	elseif str == "TREASUREPOINT" then
		self:_handleTreasurePoint(arr)
	elseif str == "RRCH" then
		RankRaceController.instance:checkLastSeasonPrizeReq()
	elseif str == "SAIZ" then
		MonopolyController.instance:rotateSaizi()
	elseif str == "SAIC" then
		MonopolyController.instance:clearSaiziRes()
	elseif str == "SHOWA" then
		FloatWordMgr.instance:show("HardwareQuality.getQualityLevel():" .. HardwareQuality.getQualityLevel())
	elseif str == "WBCT" then
		WorldBossController.instance:onClickClearTired()
	elseif string.sub(str, 1, 4) == "RRMY" then
		self:_handleRRMY(str, arr)
	elseif str == "MEMORY" then
		self:_testMemory(arr)
	elseif str == "TABBG" then
		self:_handleTabBg(arr)
	elseif str == "TABBG1" then
		self:_handleTabBgTab(1)
	elseif str == "TABBG2" then
		self:_handleTabBgTab(2)
	elseif str == "TABBG3" then
		self:_handleTabBgTab(3)
	elseif str == "GCGC" then
		ResGcMgr.instance:gc()
	elseif str == "FUBEN" then
		self:completeFuben(arr)
	elseif str == "DELALLEQUIP" then
		PetEquipController.instance:CSDelectAllEquipInfo()
	elseif str == "REFRESHFAMILYPOOL" then
		GMAgent.instance:sendPM_RefreshFamilyListReq(function()
			FloatWordMgr.instance:show("刷新家族池成功")
		end)
	elseif str == "ADDFAMILYSCORE" then
		local addScore = checknumber(arr[2])

		GMAgent.instance:sendPM_AddFamilyScoreReq(addScore, function()
			FloatWordMgr.instance:show("添加活跃度成功")
		end)
	elseif str == "MODIFYDONATEVALUE" then
		local addValue = checknumber(arr[2])
		local isAdd = addValue > 0

		addValue = math.abs(addValue)

		GMAgent.instance:sendPM_ModifyDonateValueReq(addValue, isAdd, function()
			FloatWordMgr.instance:show("修改捐献值成功")
		end)
	elseif str == "POPITEM" then
		MaterialFacade.instance:popAndShowChangeSetItems(0)
	elseif str == "FBCZ" then
		GMAgent.instance:sendPM_ResetFamilyBossClgTimesReq(checknumber(arr[2]))
	elseif str == "MSG" then
		MsgDebugger.instance:show()
	elseif str == "GJSZ" then
		UIStateManager.instance:push(ViewName.GMSettingView)
	elseif str == "TGZD" then
		BattleController.instance:pass()
	elseif str == "WEB" then
		self:openWeb()
	elseif str == "URL" then
		self:openInnerWeb(arr)
	elseif str == "OFPS" then
		ProfilerToolMgr.instance:showFps(true)
	elseif str == "CFPS" or str == "请炫光赐予我关爱你的力量" then
		ProfilerToolMgr.instance:showFps(false)
	elseif str == "AFPS" then
		ProfilerToolMgr.instance:monitorAvgFps()
	elseif str == "MT" then
		SceneMainPlayer.instance:showOutline(true)
	elseif str == "MF" then
		SceneMainPlayer.instance:showOutline(false)
	elseif str == "ATTIME" then
		local hour = checknumber(arr[2]) or 0
		local minute = checknumber(arr[3]) or 1

		GlobalDispatcher:dispatch(GlobalNotify.SetPushOpen, {
			7
		}, hour, minute)
	elseif str == "AB" then
		self:_testAB(arr)
	elseif str == "QA" then
		self:_testQA(arr)
	elseif str == "MYCARD" then
		RoleController.instance:openMyInfoCard()
	elseif str == "测试动画" then
		self:_testAnimation(arr)
	elseif str == "SHOWALLFUNC" then
		self:_testShowAllIcon()
	elseif str == "CLOCK" then
		ClockMgr.instance:dispatch(ClockMgr.TickDailyRefresh)
	elseif str == "TESTTIME" then
		self:testTime()
	elseif str == "CONTRACT" or str == "契约" then
		self:testContract(arr)
	elseif str == "红点" or str == "REDPOINT" or str == "RD" or str == "RED" then
		self:openGMRedPointView(arr)
	elseif str == "伪造服务器时间" or str == "TIMECHEAT" or str == "SERVERTIME" then
		self:testTimecheat(arr)
	elseif str == "THEATER" then
		local id, status = checknumber(arr[2]), checknumber(arr[3])

		TheaterController.instance:play(id, status)
	elseif str == "宠物园" or str == "ZOO" then
		ZooSceneController.instance:enterMyZoo()
	elseif str == "CUTEPET" or str == "萌宠园" then
		CutePetController.instance:enterScene()
	elseif str == "REANIMAL" then
		ZooAgent.instance:sendPM_ZooRecycleAnimalReq(tonumber(arr[2]))
	elseif str == "ZOOFAST" then
		GMAgent.instance:sendPM_GmZooHatchSlotProcessReq(tonumber(arr[2]), tonumber(arr[3]), arr[4])
	elseif str == "接花" then
		CatchPropsController.instance:openActivityView()
	elseif str == "巅峰赛" then
		PeakTournamentController.instance:openPeakTournamentView(checknumber(arr[2]))
	elseif str == "剧情杀" then
		self:_playStroyBattle(arr)
	elseif str == "MB1" then
		self:_createBackground(1)
	elseif str == "MB2" then
		self:_createBackground(2)
	elseif str == "MB3" then
		self:_createBackground(3)
	elseif str == "MB4" then
		self:_createBackground(4)
	elseif str == "MB5" then
		self:_createBackground(5)
	elseif str == "MB6" then
		self:_createBackground(6)
	elseif str == "DMBG" then
		self:_clearRes()
	elseif str == "TRIM" then
		LogicLauncher.instance:_onTrimMemory(40, true)
		LogicLauncher.instance:_clearBattleSceneCache()
	elseif str == "ASTYPE" then
		self:_answerProblemSelectTypeReq(tonumber(arr[2]))
	elseif str == "RATE" then
		self:_testRate(arr)
	elseif str == "BATTLELOGSWITCH" or str == "BTLS" then
		self:_testBattleLogSwtch(arr)
	elseif str == "SKI" then
		if arr[2] then
			local cmd = string.upper(arr[2])

			if cmd == "TEST" then
				GlobalDispatcher:dispatch(GlobalNotify.SpineInterFaceBoundingBoxDrawUi)
			else
				UIStateManager.instance:push(ViewName.GMSkinInterfaceView)
			end
		end
	elseif str == "DDG" or str == "神曜哆啦小游戏" or str == "LIGHTGAMEVIEW" then
		local params = {}

		params.mapId = 1
		params.isTestMode = true

		UIStateManager.instance:push(ViewName.LightGameView, params)
	elseif str == "NPG" or str == "2048小游戏" or str == "NUMBERPUZZLEGAME" then
		GlobalDispatcher:dispatch(GlobalNotify.NumberPuzzleGameStartTestMode)
	elseif str == "MUSICGAME" then
		local stageId = checknumber(arr[2])

		if stageId <= 0 then
			stageId = 1
		end

		MusicGameController.instance:startMusicGameByGmTestMode(stageId)
	elseif str == "PLAYMUSIC" then
		local bgmId = checknumber(arr[2])

		AudioPlayerEx.instance:playMusic(bgmId)
	elseif str == "HIERARCHY" or str == "UILEVEL" then
		self:_openRemoteHierarchy()
	elseif str == "SSR" then
		GMAgent.instance:sendPM_GM_AddAllSsrAndSkinsReq()
	elseif str == "ELEM" then
		ElementSparkSceneController.instance:enterElementSpark()
	elseif str == "FAMILYSCENE" then
		FamilySceneController.instance:enterScene()
	elseif str == "CHANGESKIN" then
		self:_changeSkin(arr)
	elseif str == "DELALLMAT" then
		GMAgent.instance:sendPM_DecMaterialsReq("all", function()
			FloatWordMgr.instance:show("删除物品成功")
		end, nil, function()
			FloatWordMgr.instance:show("删除物品 不成功 具体问后端")
		end)
	elseif str == "CROSSWORD" then
		CrosswordGM.instance:enterWords(arr[2])
	elseif str == "PLATFORMID" then
		BootstrapUtil._platformId = checknumber(arr[2])
		LoginModel.instance.platformId = checknumber(arr[2])
	elseif str == "COCHANNELID" then
		LoginModel.instance._cochannelId = checknumber(arr[2])
	elseif str == "WENJUAN" then
		local q = checknumber(arr[2])

		SurveyController.instance._isUseOnline = q ~= 0
	elseif str == "POP" then
		UIStateManager.instance:popByName(arr[2])
	elseif str == "STK" then
		local cmds = {}

		for i = 2, #arr do
			if not string.nilorempty(arr[i]) then
				table.insert(cmds, arr[i])
			end
		end

		StKnExpController.instance:saveOpCultTypes(cmds)
	elseif str == "PAY" then
		if not string.nilorempty(arr[2]) then
			GMAgent.instance:sendPM_FakeFinishPayOrderReq(arr[2])
		else
			FloatWordMgr.instance:show("要带订单号！！")
		end
	elseif str == "ICEQIBU" then
		local mapId = checknumber(arr[2])

		IceQibuGameController.instance:startTestGame(mapId)
	elseif str == "OVERROUNDLIMIT" then
		BattleModel.instance.isOverRoundLimit = true
	elseif str == "FIVEYEARRECAP" then
		FiveYearRecapController.instance:printAllData()
	elseif str == "ERROR" then
		self:sendError()
	else
		print("不存在的命令 = " .. str)
	end
end

function GMView:_onItemScrCustomInputCallback(hover)
	if not hover then
		self:_setVisItemScr(false)
	end
end

function GMView:_onClgInputPointerClickHandler(go, eventData)
	self:_onSearchView()
end

function GMView:_onItemSearchInputPointerClickHandler(go, eventData)
	self:onSerachItem()
end

function GMView:_showLocalSearchToScr(itemScrType)
	local descList = {}
	local array = self:_getSearchDataArray(itemScrType)

	if array then
		for index = 0, array:GetSize() - 1 do
			table.insert(descList, array:Get(index))
		end
	end

	self:_onUpdateItemScr(descList, itemScrType)
end

function GMView:_onLoadLocalSearchData()
	self._searchDataArrays = GMController.instance:getLocalSearchDataArrays()
end

function GMView:_onSaveSearchDataToLocal()
	GMController.instance:saveLocalSearchDataArrays(self._searchDataArrays)
end

function GMView:_getSearchDataArray(itemScrType)
	return self._searchDataArrays[itemScrType]
end

function GMView:_addSearchData(itemScrType, data)
	local array = self._searchDataArrays[itemScrType]

	if array == nil then
		array = Array.New()
		self._searchDataArrays[itemScrType] = array
	end

	local index = false

	for idx = 0, array:GetSize() - 1 do
		local value = array:Get(idx)

		if self:_tablesAreEqual(value, data) then
			index = idx

			break
		end
	end

	if index then
		array:Erase(index)
		array:PushFront(data)
	else
		if array:GetSize() - 1 > GmEnum.MaxSearchDataLimit then
			array:PopBack()
		end

		array:PushFront(data)
	end
end

function GMView:_tablesAreEqual(t1, t2)
	local ty1 = type(t1)
	local ty2 = type(t2)

	if ty1 ~= ty2 then
		return false
	end

	if ty1 ~= "table" and ty2 ~= "table" then
		return t1 == t2
	end

	for k1, v1 in pairs(t1) do
		local v2 = t2[k1]

		if v2 == nil or not self:_tablesAreEqual(v1, v2) then
			return false
		end
	end

	for k2, v2 in pairs(t2) do
		local v1 = t1[k2]

		if v1 == nil or not self:_tablesAreEqual(v1, v2) then
			return false
		end
	end

	return true
end

function GMView:_onUpdateItemScr(descList, itemScrType)
	local infoList = {}

	if descList then
		for _, desc in ipairs(descList) do
			local info = {}

			info.desc = desc
			info.itemScrType = itemScrType

			table.insert(infoList, info)
		end
	end

	self:_setVisItemScr(#infoList > 0, itemScrType)
	self._itemScrollList:reloadData(infoList)
end

function GMView:_onClearItemScr()
	self._itemScrollList:dispose()
end

function GMView:_updateItemCell(view, cell, info, tag)
	local desc = info.desc
	local descGo = goutil.findChild(cell, "Desc")
	local txtDesc = goutil.findChildTextComponent(cell, "Desc")

	txtDesc.text = desc

	GameUtil.addClickHandler(descGo, GameUtil.handler(self._onClickItemCell, self, info))
end

function GMView:_clearItemCell(cell)
	local descGo = goutil.findChild(cell, "Desc")

	GameUtil.rmClickHandler(descGo)
end

function GMView:_onClickItemCell(info)
	removetimer(self._onSearchView, self)
	removetimer(self.onSerachItem, self)

	local desc = info.desc
	local itemScrType = info.itemScrType

	self:_addSearchData(itemScrType, desc)

	self.isClickItem = true

	if itemScrType == GmEnum.ItemScrType_Prop then
		local results = GMModel.instance:searchByStr(desc)
		local data = results[1]

		if data then
			self:_setItemSearchText(data.name)
			self._typeText:SetText(data.matType)

			if data.matType == MatType.Pet then
				self._subTypeText:SetText("100")
			else
				self._subTypeText:SetText(tostring(data.level))
			end

			self._idText:SetText(data.id)
			self._numText:SetText("1")
		end
	elseif itemScrType == GmEnum.ItemScrType_Command then
		self:_setClgText(desc)
	elseif itemScrType == GmEnum.ItemScrType_Search then
		self:_setClgText("op " .. desc)
	end

	self:_setVisItemScr(false)
end

function GMView:_setVisItemScr(isToShow, itemScrType)
	GameUtil.SetActive(self._itemScrGo, isToShow)

	if isToShow then
		if itemScrType == GmEnum.ItemScrType_Command or itemScrType == GmEnum.ItemScrType_Search then
			GameUtil.setLocalPos(self._itemScrGo, -491, 260, 0)
		elseif itemScrType == GmEnum.ItemScrType_Prop then
			GameUtil.setLocalPos(self._itemScrGo, -472, 155, 0)
		end
	end
end

function GMView:_isShowingOfItemScr()
	return GameUtil.GetActive(self._itemScrGo)
end

function GMView:_createBackground(index, _call_back)
	if self._res then
		return
	end

	self._resLoader = MultiResLoader.New()
	self._resourcesList = {
		{
			"ui/bigbg/accconsume/gift_chiyanlongwang.png",
			"ui/bigbg/accconsume/gift_kuxuanhuaban.png",
			"ui/bigbg/accconsume/gift_motuo.png",
			"ui/bigbg/activitypopup/board_01.png",
			"ui/bigbg/activitypopup/board_tc01.png",
			"ui/bigbg/activitypopup/board_tc02.png",
			"ui/bigbg/activitypopup/board_tc03.png",
			"ui/bigbg/activitypopup/board_tc04.png",
			"ui/bigbg/activitypopup/board_tc05.png",
			"ui/bigbg/activitypopup/board_tc06.png",
			"ui/bigbg/activitypopup/board_tc08.png",
			"ui/bigbg/activitypopup/board_tc09.png",
			"ui/bigbg/activitypopup/board_tc10.png",
			"ui/bigbg/activitypopup/board_tc11.png",
			"ui/bigbg/activitypopup/board_tc12.png",
			"ui/bigbg/activitypopup/board_tc13.png",
			"ui/bigbg/activitypopup/board_tc14.png",
			"ui/bigbg/activitypopup/board_tc15.png",
			"ui/bigbg/activitypopup/board_tc16.png",
			"ui/bigbg/activitypopup/board_tc17.png",
			"ui/bigbg/activitypopup/board_tc18.png",
			"ui/bigbg/activitypopup/board_tc19.png",
			"ui/bigbg/activitypopup/board_tc20.png",
			"ui/bigbg/activitypopup/board_tc21.png",
			"ui/bigbg/activitypopup/board_tc22.png",
			"ui/bigbg/activitypopup/board_tc23.png",
			"ui/bigbg/activitypopup/board_tc24.png",
			"ui/bigbg/activitypopup/board_tc25_01.png",
			"ui/bigbg/activitypopup/board_tc26.png",
			"ui/bigbg/activitypopup/board_tc27.png",
			"ui/bigbg/activitypopup/board_tc28.png",
			"ui/bigbg/activitypopup/board_tc29.png",
			"ui/bigbg/activitypopup/board_tc30.png",
			"ui/bigbg/activitypopup/board_tc32.png",
			"ui/bigbg/activitypopup/board_tc33.png",
			"ui/bigbg/activitypopup/board_tc34.png",
			"ui/bigbg/activitypopup/board_tc35.png",
			"ui/bigbg/activitypopup/board_tc36.png",
			"ui/bigbg/activitypopup/board_tc37.png",
			"ui/bigbg/activitypopup/board_tc39.png",
			"ui/bigbg/activitypopup/board_tc40.png",
			"ui/bigbg/activitypopup/board_tc40_1.png",
			"ui/bigbg/activitypopup/board_tc40_2.png",
			"ui/bigbg/activitypopup/board_tc40_3.png",
			"ui/bigbg/activitypopup/board_tc41.png",
			"ui/bigbg/activitypopup/board_tc42.png",
			"ui/bigbg/activitypopup/board_tc43.png",
			"ui/bigbg/activitypopup/board_tc45.png",
			"ui/bigbg/activitypopup/board_tc46.png",
			"ui/bigbg/activitypopup/board_tc48.png",
			"ui/bigbg/activitypopup/board_tc49.png",
			"ui/bigbg/activitypopup/board_tc50.png",
			"ui/bigbg/activitypopup/board_tc51.png",
			"ui/bigbg/activitypopup/board_tc52.png",
			"ui/bigbg/activitypopup/board_tc56.png",
			"ui/bigbg/activitypopup/board_tc57.png",
			"ui/bigbg/activitypopup/board_tc58.png",
			"ui/bigbg/bgskin/board_pfhd_05.png",
			"ui/bigbg/bgskin/board_pfhd_06.png",
			"ui/bigbg/bgskin/btn_pfhd_01.png",
			"ui/bigbg/bgskin/btn_pfhd_02.png",
			"ui/bigbg/bigorange/board_banner01.png",
			"ui/bigbg/bigorange/board_banner02.png",
			"ui/bigbg/bigorange/board_banner03.png",
			"ui/bigbg/bigorange/board_banner04.png",
			"ui/bigbg/bigorange/board_banner06.png",
			"ui/bigbg/bigorange/board_banner07.png",
			"ui/bigbg/bigorange/board_banner08.png",
			"ui/bigbg/bigorange/board_banner09.png",
			"ui/bigbg/bigorange/board_banner10.png",
			"ui/bigbg/bigorange/board_banner11.png",
			"ui/bigbg/bigorange/board_banner12.png",
			"ui/bigbg/bigorange/board_banner13.png",
			"ui/bigbg/bigorange/board_banner15.png",
			"ui/bigbg/catchprops/bg_myjgh_01.png",
			"ui/bigbg/catchprops/board_myjgh_03.png",
			"ui/bigbg/copychapter/board_jqfb_sm1.png",
			"ui/bigbg/copychapter/board_jqfb_sm2.png",
			"ui/bigbg/copychapter/board_jqfb_sm3.png",
			"ui/bigbg/copychapter/board_jqfb_sm4.png",
			"ui/bigbg/copychapter/fubeng_board_richang01.png",
			"ui/bigbg/copychapter/fubeng_board_richang02.png",
			"ui/bigbg/copychapter/fubeng_board_richang03.png",
			"ui/bigbg/copychapter/fubeng_board_richang04.png",
			"ui/bigbg/copychapter/fuben_bg01.png",
			"ui/bigbg/copychapter/fuben_bg02.png",
			"ui/bigbg/copychapter/fuben_bg03.png",
			"ui/bigbg/copychapter/fuben_board01.png",
			"ui/bigbg/copychapter/fuben_board02.png",
			"ui/bigbg/copychapter/fuben_board03.png",
			"ui/bigbg/copychapter/fuben_board04.png",
			"ui/bigbg/copychapter/chapterbg/jinbihuanjing1.png",
			"ui/bigbg/copychapter/chapterbg/jinbihuanjing2.png",
			"ui/bigbg/copychapter/chapterbg/jinbihuanjing3.png",
			"ui/bigbg/copychapter/chapterbg/jingjichang1.png",
			"ui/bigbg/copychapter/chapterbg/jingjichang2.png",
			"ui/bigbg/copychapter/chapterbg/jingjichang3.png"
		},
		{
			"ui/bigbg/copychapter/chapterbg/jingyanhuanjing1.png",
			"ui/bigbg/copychapter/chapterbg/jingyanhuanjing2.png",
			"ui/bigbg/copychapter/chapterbg/jingyanhuanjing3.png",
			"ui/bigbg/copychapter/chapterbg/lanlongwan1.png",
			"ui/bigbg/copychapter/chapterbg/lanlongwan2.png",
			"ui/bigbg/copychapter/chapterbg/lanlongwan3.png",
			"ui/bigbg/copychapter/chapterbg/pinminku1.png",
			"ui/bigbg/copychapter/chapterbg/pinminku2.png",
			"ui/bigbg/copychapter/chapterbg/pinminku3.png",
			"ui/bigbg/copychapter/chapterbg/shazhiguo1.png",
			"ui/bigbg/copychapter/chapterbg/shazhiguo2.png",
			"ui/bigbg/copychapter/chapterbg/shazhiguo3.png",
			"ui/bigbg/copychapter/chapterbg/shuguangsenlin1.png",
			"ui/bigbg/copychapter/chapterbg/shuguangsenlin2.png",
			"ui/bigbg/copychapter/chapterbg/shuguangsenlin3.png",
			"ui/bigbg/copychapter/chapterbg/shuzuizhexiagu1.png",
			"ui/bigbg/copychapter/chapterbg/shuzuizhexiagu2.png",
			"ui/bigbg/copychapter/chapterbg/shuzuizhexiagu3.png",
			"ui/bigbg/copychapter/chapterbg/xingshenhuanjing1.png",
			"ui/bigbg/copychapter/chapterbg/xingshenhuanjing2.png",
			"ui/bigbg/copychapter/chapterbg/xingshenhuanjing3.png",
			"ui/bigbg/copychapter/chapterbg/xingshenjie1.png",
			"ui/bigbg/copychapter/chapterbg/xingshenjie2.png",
			"ui/bigbg/copychapter/chapterbg/xingshenjie3.png",
			"ui/bigbg/copychapter/chapterbg/yingxiongdao1.png",
			"ui/bigbg/copychapter/chapterbg/yingxiongdao2.png",
			"ui/bigbg/copychapter/chapterbg/yingxiongdao3.png",
			"ui/bigbg/copychapter/chapterbg/yongzhezhita1.png",
			"ui/bigbg/copychapter/chapterbg/yongzhezhita2.png",
			"ui/bigbg/copychapter/chapterbg/yongzhezhita3.png",
			"ui/bigbg/copychapter/chapterbg/zhuangbeihuanjing1.png",
			"ui/bigbg/copychapter/chapterbg/zhuangbeihuanjing2.png",
			"ui/bigbg/copychapter/chapterbg/zhuangbeihuanjing3.png",
			"ui/bigbg/draweuips/board_lhlz_bg.png",
			"ui/bigbg/draweuips/zhaohuan_qj1.png",
			"ui/bigbg/familyteamplay/board_jztb_19.png",
			"ui/bigbg/familyteamplay/board_jztb_20.png",
			"ui/bigbg/familyteamplay/board_jztb_21.png",
			"ui/bigbg/familyteamplay/board_jztb_yongchuanglongcheng.png",
			"ui/bigbg/familyteamplay/board_jztb_zhuashuimu.png",
			"ui/bigbg/familyteamplay/board_jztb_zhuashuimu_bg.png",
			"ui/bigbg/firstcharge/board_sc_01.png",
			"ui/bigbg/firstcharge/board_sc_03.png",
			"ui/bigbg/firstcharge/board_sc_04.png",
			"ui/bigbg/firstcharge/board_sc_05.png",
			"ui/bigbg/firstcharge/board_sc_06.png",
			"ui/bigbg/firstcharge/board_sc_06_1.png",
			"ui/bigbg/gift/board_tclb_0.png",
			"ui/bigbg/gift/board_tclb_1.png",
			"ui/bigbg/gift/board_tclb_2.png",
			"ui/bigbg/gift/board_tclb_3.png",
			"ui/bigbg/gift/board_tclb_4.png",
			"ui/bigbg/gift/board_tclb_5.png",
			"ui/bigbg/gift/board_tclb_6.png",
			"ui/bigbg/gift/board_tclb_7.png",
			"ui/bigbg/gift/slogan/tclb_1zhe.png",
			"ui/bigbg/gift/slogan/tclb_2zhe.png",
			"ui/bigbg/gift/slogan/tclb_3zhe.png",
			"ui/bigbg/gift/slogan/tclb_4zhe.png",
			"ui/bigbg/gift/slogan/tclb_5zhe.png",
			"ui/bigbg/gift/slogan/tclb_6zhe.png",
			"ui/bigbg/gift/slogan/tclb_7zhe.png",
			"ui/bigbg/gift/slogan/tclb_8zhe.png",
			"ui/bigbg/gift/slogan/tclb_9zhe.png",
			"ui/bigbg/gift/slogan/tclb_slogan_01.png",
			"ui/bigbg/gift/slogan/tclb_slogan_02.png",
			"ui/bigbg/gift/slogan/tclb_slogan_03.png",
			"ui/bigbg/gift/slogan/tclb_slogan_04.png",
			"ui/bigbg/gift/slogan/tclb_slogan_05.png",
			"ui/bigbg/legend/cstz_bg02.png",
			"ui/bigbg/legend/cstz_bg03.png",
			"ui/bigbg/legend/cstz_bg04.png",
			"ui/bigbg/legend/cstz_bg05.png",
			"ui/bigbg/legend/cstz_bg06.png",
			"ui/bigbg/legend/huodong/btn_fubeng_huodong01.png",
			"ui/bigbg/legend/huodong/btn_fubeng_huodong02.png",
			"ui/bigbg/legend/huodong/btn_fubeng_huodong03.png",
			"ui/bigbg/legend/huodong/btn_fubeng_huodong04.png",
			"ui/bigbg/legend/huodong/btn_fubeng_huodong05.png",
			"ui/bigbg/legend/huodong/btn_fubeng_huodong06.png",
			"ui/bigbg/legend/huodong/btn_fubeng_huodong07.png",
			"ui/bigbg/legend/huodong/btn_fubeng_huodong08.png",
			"ui/bigbg/legend/huodong/btn_fubeng_huodong09.png",
			"ui/bigbg/legend/huodong/btn_fubeng_huodong10.png",
			"ui/bigbg/legend/huodong/btn_fubeng_huodong11.png",
			"ui/bigbg/legend/huodong/btn_fubeng_huodong12.png",
			"ui/bigbg/legend/huodong/btn_fubeng_huodong13.png",
			"ui/bigbg/legend/huodong/btn_fubeng_huodong14.png",
			"ui/bigbg/legend/huodong/btn_fubeng_huodong15.png",
			"ui/bigbg/legend/huodong/btn_fubeng_huodong16.png",
			"ui/bigbg/legend/raiders/board_jltz_22.png",
			"ui/bigbg/legend/raiders/board_jltz_23.png",
			"ui/bigbg/legend/raiders/board_jltz_24.png",
			"ui/bigbg/legend/raiders/board_jltz_25.png",
			"ui/bigbg/legend/raiders/board_jltz_26.png",
			"ui/bigbg/legend/raiders/board_jltz_27.png",
			"ui/bigbg/legend/raiders/board_jltz_28.png",
			"ui/bigbg/legend/raiders/board_jltz_29.png",
			"ui/bigbg/legend/raiders/board_jltz_30.png",
			"ui/bigbg/onepeoplecopy/board_zhsdl_bg05.png",
			"ui/bigbg/onepeoplecopy/board_zhsdl_bg06.png",
			"ui/bigbg/onepeoplecopy/board_zhsdl_bg07.png",
			"ui/bigbg/onepeoplecopy/board_zhsdl_bg08.png",
			"ui/bigbg/passport/lsq_01.png",
			"ui/bigbg/passport/lsq_02.png",
			"ui/bigbg/passport/txz_01.png",
			"ui/bigbg/passport/txz_02.png",
			"ui/bigbg/passport/yzl_01.png",
			"ui/bigbg/passport/yzl_02.png",
			"ui/bigbg/pet/066.png",
			"ui/bigbg/pet/img_10001_xiaolan.png",
			"ui/bigbg/pet/img_10002_lanlanlu.png",
			"ui/bigbg/pet/img_10002_xiaobao.png",
			"ui/bigbg/pet/img_10003_xiaoku.png",
			"ui/bigbg/pet/img_10004_lanlanlu.png",
			"ui/bigbg/pet/img_10004_newlanlanlu.png",
			"ui/bigbg/pet/img_10005_baobaolong.png",
			"ui/bigbg/pet/img_10005_newbaobaolong.png",
			"ui/bigbg/pet/img_10006_kulashou.png",
			"ui/bigbg/pet/img_10006_newkulashou.png",
			"ui/bigbg/pet/img_10010_xiaotuzhu.png",
			"ui/bigbg/pet/img_10012_shuangbing.png",
			"ui/bigbg/pet/img_10013_jisi.png",
			"ui/bigbg/pet/img_10014_liya.png",
			"ui/bigbg/pet/img_10016_sagute.png",
			"ui/bigbg/pet/img_10017_hanbingqishi.png",
			"ui/bigbg/pet/img_10018_baojiajisi.png",
			"ui/bigbg/pet/img_10019_kayagongzhu.png",
			"ui/bigbg/pet/img_10020_yuandulingbao.png",
			"ui/bigbg/pet/img_10026_xiaofeilong.png",
			"ui/bigbg/pet/img_10028_shengguangfeilong.png",
			"ui/bigbg/pet/img_10030_dandan.png",
			"ui/bigbg/pet/img_10031_wenwen.png",
			"ui/bigbg/pet/img_10032_dangdang.png",
			"ui/bigbg/pet/img_10033_juejue.png",
			"ui/bigbg/pet/img_10034_shuangshuang.png",
			"ui/bigbg/pet/img_10035_shanshan.png",
			"ui/bigbg/pet/img_10036_zhunzhun.png",
			"ui/bigbg/pet/img_10037_momo.png",
			"ui/bigbg/pet/img_10046_sanyeshou.png",
			"ui/bigbg/pet/img_10047_haibulan.png",
			"ui/bigbg/pet/img_10048_gulumaoniu.png",
			"ui/bigbg/pet/img_10049_nuhuozhizhu.png",
			"ui/bigbg/pet/img_10050_cizhuixie.png",
			"ui/bigbg/pet/img_10051_duoduo.png",
			"ui/bigbg/pet/img_10053_hao.png",
			"ui/bigbg/pet/img_10055_tuzhutailang.png",
			"ui/bigbg/pet/img_10057_xuanwu.png",
			"ui/bigbg/pet/img_10058_baihu.png",
			"ui/bigbg/pet/img_10059_zhuque.png",
			"ui/bigbg/pet/img_10060_qinglong.png",
			"ui/bigbg/pet/img_10061_qilin.png",
			"ui/bigbg/pet/img_10068_jiujiu.png",
			"ui/bigbg/pet/img_10072_anyingsuoluo.png",
			"ui/bigbg/pet/img_10075_haisaisi.png",
			"ui/bigbg/pet/img_10082_junyan.png",
			"ui/bigbg/pet/img_10083_lingshi.png",
			"ui/bigbg/pet/img_10084_mengkongliu.png",
			"ui/bigbg/pet/img_10085_chenguang.png",
			"ui/bigbg/pet/img_10086_wuyou.png",
			"ui/bigbg/pet/img_10092_xiaomo.png",
			"ui/bigbg/pet/img_10097_moyan.png",
			"ui/bigbg/pet/img_10098_binglingwang.png",
			"ui/bigbg/pet/img_10099_tianmanwang.png",
			"ui/bigbg/pet/img_10100_guangmingwang.png",
			"ui/bigbg/pet/img_10101_yueyingwang.png",
			"ui/bigbg/pet/img_10122_xiaolanlong.png",
			"ui/bigbg/pet/img_10127_xinglanlong.png",
			"ui/bigbg/pet/img_10128_fenghuang.png",
			"ui/bigbg/pet/img_10129_zhenlong.png",
			"ui/bigbg/pet/img_10130_xingge.png",
			"ui/bigbg/pet/img_10130_xingge01.png",
			"ui/bigbg/pet/img_10131_luosa.png",
			"ui/bigbg/pet/img_10138_xiaoyan.png",
			"ui/bigbg/pet/img_10140_xiaonuo.png",
			"ui/bigbg/pet/img_10141_axiu.png",
			"ui/bigbg/pet/img_10142_dishitian.png",
			"ui/bigbg/pet/img_10143_longyan.png",
			"ui/bigbg/pet/img_10143_longyan01.png",
			"ui/bigbg/pet/img_10143_newlongyan.png",
			"ui/bigbg/pet/img_10144_aruisi.png",
			"ui/bigbg/pet/img_10145_nuoya.png",
			"ui/bigbg/pet/img_10145_nuoya01.png",
			"ui/bigbg/pet/img_10145_nuoya02.png",
			"ui/bigbg/pet/img_10146_xiuer.png",
			"ui/bigbg/pet/img_10146_xiuer01.png",
			"ui/bigbg/pet/img_10147_miya.png",
			"ui/bigbg/pet/img_10147_miya01.png",
			"ui/bigbg/pet/img_10154_feiniao.png",
			"ui/bigbg/pet/img_10155_qianniaowan.png",
			"ui/bigbg/pet/img_10158_xiongmaoxiaobao.png",
			"ui/bigbg/pet/img_10159_gongfuxiongmao.png",
			"ui/bigbg/pet/img_10162_anyingzhizi.png",
			"ui/bigbg/pet/img_10165_mang.png",
			"ui/bigbg/pet/img_10167_panduola.png",
			"ui/bigbg/pet/img_10167_panduola01.png",
			"ui/bigbg/pet/img_10169_feiying.png",
			"ui/bigbg/pet/img_10172_qianji.png",
			"ui/bigbg/pet/img_10175_yin.png",
			"ui/bigbg/pet/img_10177_xu.png",
			"ui/bigbg/pet/img_10179_mingjing.png",
			"ui/bigbg/pet/img_10181_guangyidatianshi.png",
			"ui/bigbg/pet/img_10183_heiyutianshi.png",
			"ui/bigbg/pet/img_10183_heiyutianshi01.png",
			"ui/bigbg/pet/img_10185_yongyemoyan.png",
			"ui/bigbg/pet/img_10187_bingxuenvwang.png",
			"ui/bigbg/pet/img_10189_xiaoduo.png",
			"ui/bigbg/pet/img_10190_xiaohao.png",
			"ui/bigbg/pet/img_10192_shiruike.png",
			"ui/bigbg/pet/img_10193_shuiroudun.png",
			"ui/bigbg/pet/img_10194_huoroudun.png",
			"ui/bigbg/pet/img_10195_caoshuchu.png",
			"ui/bigbg/pet/img_10196_anshuchu.png",
			"ui/bigbg/pet/img_10197_guangpingheng.png",
			"ui/bigbg/pet/img_10201_nian.png",
			"ui/bigbg/pet/img_10202_zhenyuanxuanwu.png",
			"ui/bigbg/pet/img_10202_zhenyuanxuanwu01.png",
			"ui/bigbg/pet/img_10203_tianbingshenhu.png",
			"ui/bigbg/pet/img_10203_tianbingshenhu01.png",
			"ui/bigbg/pet/img_10204_tianyanzhuque.png",
			"ui/bigbg/pet/img_10204_tianyanzhuque01.png",
			"ui/bigbg/pet/img_10205_xuanmingtianlong.png",
			"ui/bigbg/pet/img_10206_guangmingshengqilin.png",
			"ui/bigbg/pet/img_10206_guangmingshengqilin01.png",
			"ui/bigbg/pet/img_10207_ruikesi.png",
			"ui/bigbg/pet/img_10208_liemoshou.png",
			"ui/bigbg/pet/img_10209_hongyantaizhu.png",
			"ui/bigbg/pet/img_10271_mininuo.png",
			"ui/bigbg/pet/img_10272_yuangunuo.png",
			"ui/bigbg/pet/img_10273_lifunuo.png",
			"ui/bigbg/pet/img_10274_yishengnuo.png",
			"ui/bigbg/pet/img_10275_niuzainuo.png",
			"ui/bigbg/pet/img_10276_qishinuo.png",
			"ui/bigbg/pet/img_10277_wushinuo.png",
			"ui/bigbg/pet/img_10279_jingangnuo.png",
			"ui/bigbg/pet/img_10280_konglongnuo.png",
			"ui/bigbg/pet/img_10281_shayunuo.png",
			"ui/bigbg/pet/img_10282_xianrenzhangnuo.png",
			"ui/bigbg/pet/img_10283_shizinuo.png",
			"ui/bigbg/pet/img_10284_renzhenuo.png",
			"ui/bigbg/pet/img_10285_jiangshinuo.png",
			"ui/bigbg/pet/img_10308_weiduoliya.png",
			"ui/bigbg/pet/img_10309_xixi.png",
			"ui/bigbg/pet/img_10309_xixi01.png"
		},
		{
			"ui/bigbg/pet/img_10313_ciyuanshenglong.png",
			"ui/bigbg/pet/img_10313_ciyuanshenglong01.png",
			"ui/bigbg/pet/img_10316_luoyi.png",
			"ui/bigbg/pet/img_10317_xuelang.png",
			"ui/bigbg/pet/img_10318_chengzhu.png",
			"ui/bigbg/pet/img_10319_jinqianbao.png",
			"ui/bigbg/pet/img_10320_yanmielongzun.png",
			"ui/bigbg/pet/img_10320_yanmielongzun01.png",
			"ui/bigbg/pet/img_10322_yilishabai.png",
			"ui/bigbg/pet/img_10322_yilishabai01.png",
			"ui/bigbg/pet/img_10323_luoshiqi.png",
			"ui/bigbg/pet/img_10323_luoshiqi01.png",
			"ui/bigbg/pet/img_10324_huangjinshenglong.png",
			"ui/bigbg/pet/img_10324_huangjinshenglong01.png",
			"ui/bigbg/pet/img_10325_jiyaoshenglong.png",
			"ui/bigbg/pet/img_10326_chiyanlonghuang.png",
			"ui/bigbg/pet/img_10327_mimengli.png",
			"ui/bigbg/pet/img_10328_xinxiya.png",
			"ui/bigbg/pet/img_10328_xinxiya01.png",
			"ui/bigbg/pet/img_10329_mi.png",
			"ui/bigbg/pet/img_10330_aixi.png",
			"ui/bigbg/pet/img_10331_kasuo.png",
			"ui/bigbg/pet/img_10332_youbo.png",
			"ui/bigbg/pet/img_10333_youlie.png",
			"ui/bigbg/pet/img_10334_tong.png",
			"ui/bigbg/pet/img_10335_miqilin.png",
			"ui/bigbg/pet/img_10337_busixing.png",
			"ui/bigbg/pet/img_10338_duola.png",
			"ui/bigbg/pet/img_10339_anhei.png",
			"ui/bigbg/pet/img_10341_lianjin.png",
			"ui/bigbg/pet/img_10342_rexue.png",
			"ui/bigbg/pet/img_10343_aixin.png",
			"ui/bigbg/pet/img_10344_xiaomeng.png",
			"ui/bigbg/pet/img_10345_longnv.png",
			"ui/bigbg/pet/img_10345_longnv01.png",
			"ui/bigbg/pet/img_10346_taige.png",
			"ui/bigbg/pet/img_10347_bohe.png",
			"ui/bigbg/pet/img_10348_yanmo.png",
			"ui/bigbg/pet/img_10349_pokongyingwei.png",
			"ui/bigbg/pet/img_10350_shuguangshujing.png",
			"ui/bigbg/pet/img_10351_xieweishashe.png",
			"ui/bigbg/pet/img_10352_disi.png",
			"ui/bigbg/pet/img_10353_baoshiniao.png",
			"ui/bigbg/pet/img_10354_qianduoduo.png",
			"ui/bigbg/pet/img_10355_qianmanman.png",
			"ui/bigbg/pet/img_10356_huolima.png",
			"ui/bigbg/pet/img_10357_lirentanglang.png",
			"ui/bigbg/pet/img_10360_chiyanhejinzhu.png",
			"ui/bigbg/pet/img_10361_huojianji.png",
			"ui/bigbg/pet/img_10362_daitouya.png",
			"ui/bigbg/pet/img_10363_jibingniao.png",
			"ui/bigbg/pet/img_10364_xilige.png",
			"ui/bigbg/pet/img_10365_panglulu.png",
			"ui/bigbg/pet/img_10367_zibaodou.png",
			"ui/bigbg/pet/img_10368_munaiyi.png",
			"ui/bigbg/pet/img_10369_yuanmo.png",
			"ui/bigbg/pet/img_10371_leidun.png",
			"ui/bigbg/pet/img_10373_juguai.png",
			"ui/bigbg/pet/img_10374_yuling.png",
			"ui/bigbg/pet/img_10375_ansha.png",
			"ui/bigbg/pet/img_10380_fengbaobao.png",
			"ui/bigbg/pet/img_10380_fengbaobao02.png",
			"ui/bigbg/pet/img_10381_wangye.png",
			"ui/bigbg/pet/img_20001_lang.png",
			"ui/bigbg/pet/img_20002_hu.png",
			"ui/bigbg/pet/img_20003_laohu.png",
			"ui/bigbg/pet/img_20004_xi.png",
			"ui/bigbg/pet/img_20005_sha.png",
			"ui/bigbg/pet/img_20006_xiang.png",
			"ui/bigbg/pet/img_20007_shu.png",
			"ui/bigbg/pet/img_20008_ying.png",
			"ui/bigbg/pet/img_20009_bianyilang.png",
			"ui/bigbg/pet/img_20010_bianyihu.png",
			"ui/bigbg/pet/img_20011_bianyilaohu.png",
			"ui/bigbg/pet/img_20012_bianyixi.png",
			"ui/bigbg/pet/img_20013_bianyisha.png",
			"ui/bigbg/pet/img_20014_bianyixiang.png",
			"ui/bigbg/pet/img_20015_bianyishu.png",
			"ui/bigbg/pet/img_20016_bianyiying.png",
			"ui/bigbg/petcollegetip/board_jlsy_01.png",
			"ui/bigbg/petcollegetip/board_jlsy_02.png",
			"ui/bigbg/petcollegetip/board_jlsy_03.png",
			"ui/bigbg/petcollegetip/board_jlsy_04.png",
			"ui/bigbg/petcollegetip/board_jlsy_05.png",
			"ui/bigbg/petcollegetip/board_jlsy_06.png",
			"ui/bigbg/petcollegetip/board_jlsy_07.png",
			"ui/bigbg/petcollegetip/board_jlsy_08.png",
			"ui/bigbg/petcollegetip/board_jlsy_09.png",
			"ui/bigbg/petcollegetip/board_jlsy_10.png",
			"ui/bigbg/petcollegetip/board_jlsy_11.png",
			"ui/bigbg/petcollegetip/board_jlsy_12.png",
			"ui/bigbg/petcollegetip/board_jlsy_14.png",
			"ui/bigbg/petcollegetip/board_jlsy_15.png",
			"ui/bigbg/petcollegetip/board_jlsy_16.png",
			"ui/bigbg/petcollegetip/board_jlsy_17.png",
			"ui/bigbg/petcollegetip/board_jlsy_18.png",
			"ui/bigbg/petcollegetip/board_jlsy_19.png",
			"ui/bigbg/petcollegetip/board_jlsy_20.png",
			"ui/bigbg/petdisplay/board_jlhd_010.png",
			"ui/bigbg/petdisplay/board_jlhd_012.png",
			"ui/bigbg/petdisplay/board_jlhd_013.png",
			"ui/bigbg/petposter/board_jltd01.png",
			"ui/bigbg/petposter/board_jltd02.png",
			"ui/bigbg/petposter/board_jltd03.png",
			"ui/bigbg/petposter/board_jltd04.png",
			"ui/bigbg/petposter/board_jltd05.png",
			"ui/bigbg/petposter/board_jltd06.png",
			"ui/bigbg/petposter/board_jltd07.png",
			"ui/bigbg/petposter/board_jltd08.png",
			"ui/bigbg/petposter/board_jltd09.png",
			"ui/bigbg/petposter/board_jltd10.png",
			"ui/bigbg/petposter/board_jltd11.png",
			"ui/bigbg/petposter/board_jltd12.png",
			"ui/bigbg/petposter/board_jltd13.png",
			"ui/bigbg/petposter/board_jltd14.png",
			"ui/bigbg/petposter/board_jltd15.png",
			"ui/bigbg/petposter/tj_azsl_10020.png",
			"ui/bigbg/petposter/tj_azsl_10035.png",
			"ui/bigbg/petposter/tj_azsl_10037.png",
			"ui/bigbg/petposter/tj_azsl_10072.png",
			"ui/bigbg/petposter/tj_azsl_10086.png",
			"ui/bigbg/petposter/tj_azsl_10131.png",
			"ui/bigbg/petposter/tj_azsl_10179.png",
			"ui/bigbg/petposter/tj_azsl_10205.png",
			"ui/bigbg/petposter/tj_azsl_10319.png",
			"ui/bigbg/petposter/tj_azsl_10348.png",
			"ui/bigbg/petposter/tj_azsl_bg.png",
			"ui/bigbg/petposter/tj_czsl_10006.png",
			"ui/bigbg/petposter/tj_czsl_10016.png",
			"ui/bigbg/petposter/tj_czsl_10030.png",
			"ui/bigbg/petposter/tj_czsl_10034.png",
			"ui/bigbg/petposter/tj_czsl_10083.png",
			"ui/bigbg/petposter/tj_czsl_10129.png",
			"ui/bigbg/petposter/tj_czsl_10159.png",
			"ui/bigbg/petposter/tj_czsl_10202.png",
			"ui/bigbg/petposter/tj_czsl_10318.png",
			"ui/bigbg/petposter/tj_czsl_10347.png",
			"ui/bigbg/petposter/tj_czsl_bg.png",
			"ui/bigbg/petposter/tj_czsl_tuanming.png",
			"ui/bigbg/petposter/tj_gzsl_10048.png",
			"ui/bigbg/petposter/tj_gzsl_10085.png",
			"ui/bigbg/petposter/tj_gzsl_10130.png",
			"ui/bigbg/petposter/tj_gzsl_10172.png",
			"ui/bigbg/petposter/tj_gzsl_10206.png",
			"ui/bigbg/petposter/tj_gzsl_10346.png",
			"ui/bigbg/petposter/tj_gzsl_10349.png",
			"ui/bigbg/petposter/tj_gzsl_bg.png",
			"ui/bigbg/petposter/tj_gzsl_tuanming.png",
			"ui/bigbg/petposter/tj_hy_10082.png",
			"ui/bigbg/petposter/tj_hy_10143.png",
			"ui/bigbg/petposter/tj_hy_10204.png",
			"ui/bigbg/petposter/tj_hy_10309.png",
			"ui/bigbg/petposter/tj_hy_10337.png",
			"ui/bigbg/petposter/tj_hy_bg.png",
			"ui/bigbg/petposter/tj_hzsl_10005.png",
			"ui/bigbg/petposter/tj_hzsl_10018.png",
			"ui/bigbg/petposter/tj_hzsl_10031.png",
			"ui/bigbg/petposter/tj_hzsl_10036.png",
			"ui/bigbg/petposter/tj_hzsl_10082.png",
			"ui/bigbg/petposter/tj_hzsl_10169.png",
			"ui/bigbg/petposter/tj_hzsl_10177.png",
			"ui/bigbg/petposter/tj_hzsl_10204.png",
			"ui/bigbg/petposter/tj_hzsl_10337.png",
			"ui/bigbg/petposter/tj_hzsl_10360.png",
			"ui/bigbg/petposter/tj_hzsl_bg.png",
			"ui/bigbg/petposter/tj_hzsl_tuanming.png",
			"ui/bigbg/petposter/tj_jgbz_10030.png",
			"ui/bigbg/petposter/tj_jgbz_10031.png",
			"ui/bigbg/petposter/tj_jgbz_10032.png",
			"ui/bigbg/petposter/tj_jgbz_10033.png",
			"ui/bigbg/petposter/tj_jgbz_10034.png"
		},
		{
			"ui/bigbg/petposter/tj_jgbz_10035.png",
			"ui/bigbg/petposter/tj_jgbz_10036.png",
			"ui/bigbg/petposter/tj_jgbz_10037.png",
			"ui/bigbg/petposter/tj_jgbz_bg.png",
			"ui/bigbg/petposter/tj_lh_10027.png",
			"ui/bigbg/petposter/tj_lh_10127.png",
			"ui/bigbg/petposter/tj_lh_10313.png",
			"ui/bigbg/petposter/tj_lh_10324.png",
			"ui/bigbg/petposter/tj_lh_10326.png",
			"ui/bigbg/petposter/tj_lh_bg.png",
			"ui/bigbg/petposter/tj_nslm_10316.png",
			"ui/bigbg/petposter/tj_nslm_10327.png",
			"ui/bigbg/petposter/tj_nslm_10328.png",
			"ui/bigbg/petposter/tj_nslm_10329.png",
			"ui/bigbg/petposter/tj_nslm_10345.png",
			"ui/bigbg/petposter/tj_nslm_10352.png",
			"ui/bigbg/petposter/tj_nslm_bg.png",
			"ui/bigbg/petposter/tj_szc_10004.png",
			"ui/bigbg/petposter/tj_szc_10005.png",
			"ui/bigbg/petposter/tj_szc_10006.png",
			"ui/bigbg/petposter/tj_szc_bg.png",
			"ui/bigbg/petposter/tj_szsl_10004.png",
			"ui/bigbg/petposter/tj_szsl_10017.png",
			"ui/bigbg/petposter/tj_szsl_10032.png",
			"ui/bigbg/petposter/tj_szsl_10033.png",
			"ui/bigbg/petposter/tj_szsl_10084.png",
			"ui/bigbg/petposter/tj_szsl_10127.png",
			"ui/bigbg/petposter/tj_szsl_10175.png",
			"ui/bigbg/petposter/tj_szsl_10203.png",
			"ui/bigbg/petposter/tj_szsl_10317.png",
			"ui/bigbg/petposter/tj_szsl_10333.png",
			"ui/bigbg/petposter/tj_szsl_10335.png",
			"ui/bigbg/petposter/tj_szsl_bg.png",
			"ui/bigbg/petposter/tj_szsl_tuanming.png",
			"ui/bigbg/petposter/tj_wssdcs_10202.png",
			"ui/bigbg/petposter/tj_wssdcs_10203.png",
			"ui/bigbg/petposter/tj_wssdcs_10204.png",
			"ui/bigbg/petposter/tj_wssdcs_10205.png",
			"ui/bigbg/petposter/tj_wssdcs_10206.png",
			"ui/bigbg/petposter/tj_wssdcs_bg.png",
			"ui/bigbg/petposter/tj_wwjb_10142.png",
			"ui/bigbg/petposter/tj_wwjb_10143.png",
			"ui/bigbg/petposter/tj_wwjb_10144.png",
			"ui/bigbg/petposter/tj_wwjb_10145.png",
			"ui/bigbg/petposter/tj_wwjb_10146.png",
			"ui/bigbg/petposter/tj_wwjb_bg.png",
			"ui/bigbg/petposter/tj_wzzl_10016.png",
			"ui/bigbg/petposter/tj_wzzl_10017.png",
			"ui/bigbg/petposter/tj_wzzl_10018.png",
			"ui/bigbg/petposter/tj_wzzl_10019.png",
			"ui/bigbg/petposter/tj_wzzl_10020.png",
			"ui/bigbg/petposter/tj_wzzl_10027.png",
			"ui/bigbg/petposter/tj_wzzl_10072.png",
			"ui/bigbg/petposter/tj_wzzl_bg.png",
			"ui/bigbg/petposter/tj_yxzl_10084.png",
			"ui/bigbg/petposter/tj_yxzl_10086.png",
			"ui/bigbg/petposter/tj_yxzl_10087.png",
			"ui/bigbg/petposter/tj_yxzl_10088.png",
			"ui/bigbg/petposter/tj_yxzl_10090.png",
			"ui/bigbg/petposter/tj_yxzl_10202.png",
			"ui/bigbg/petposter/tj_yxzl_10203.png",
			"ui/bigbg/petposter/tj_yxzl_10204.png",
			"ui/bigbg/petposter/tj_yxzl_10205.png",
			"ui/bigbg/petposter/tj_yxzl_10206.png",
			"ui/bigbg/petposter/tj_yxzl_bg.png",
			"ui/bigbg/petposter/tj_zsnp_10167.png",
			"ui/bigbg/petposter/tj_zsnp_10308.png",
			"ui/bigbg/petposter/tj_zsnp_10309.png",
			"ui/bigbg/petposter/tj_zsnp_10322.png",
			"ui/bigbg/petposter/tj_zsnp_10323.png",
			"ui/bigbg/petposter/tj_zsnp_bg.png",
			"ui/bigbg/petrelation/btn_anzhishilian.png",
			"ui/bigbg/petrelation/btn_caozhishilian.png",
			"ui/bigbg/petrelation/btn_guangzhishilian.png",
			"ui/bigbg/petrelation/btn_hongyan.png",
			"ui/bigbg/petrelation/btn_huozhishilian.png",
			"ui/bigbg/petrelation/btn_jiugongbazhen.png",
			"ui/bigbg/petrelation/btn_longhuen.png",
			"ui/bigbg/petrelation/btn_nvshenlianmeng.png",
			"ui/bigbg/petrelation/btn_sanzhuchong.png",
			"ui/bigbg/petrelation/btn_shuizhishilian.png",
			"ui/bigbg/petrelation/btn_wangzhezhilu.png",
			"ui/bigbg/petrelation/btn_wushenshoudechuangshuo.png",
			"ui/bigbg/petrelation/btn_wuwangjiban.png",
			"ui/bigbg/petrelation/btn_yingxiongzhilv.png",
			"ui/bigbg/petrelation/btn_zhuanshunvpu.png",
			"ui/bigbg/pettalent/tianfu_0.png",
			"ui/bigbg/pettalent/tianfu_1.png",
			"ui/bigbg/pettalent/tianfu_10.png",
			"ui/bigbg/pettalent/tianfu_2.png",
			"ui/bigbg/pettalent/tianfu_3.png",
			"ui/bigbg/pettalent/tianfu_4.png",
			"ui/bigbg/pettalent/tianfu_5.png",
			"ui/bigbg/pettalent/tianfu_6.png",
			"ui/bigbg/pettalent/tianfu_7.png",
			"ui/bigbg/pettalent/tianfu_8.png",
			"ui/bigbg/pettalent/tianfu_9.png",
			"ui/bigbg/pettrial/jlsl_bg01.png",
			"ui/bigbg/pettrial/jlsl_bg02.png",
			"ui/bigbg/pettrial/jlsl_bg03.png",
			"ui/bigbg/picturepuzzle/board_kcyr_bg03.png",
			"ui/bigbg/picturepuzzle/board_kcyr_bg04.png",
			"ui/bigbg/picturepuzzle/board_kcyr_bg07.png",
			"ui/bigbg/picturepuzzle/board_kcyr_bg08.png",
			"ui/bigbg/picturepuzzle/board_kcyr_bg09.png",
			"ui/bigbg/picturepuzzle/board_kcyr_bg10.png",
			"ui/bigbg/picturepuzzle/board_kcyr_fx01.png",
			"ui/bigbg/picturepuzzle/board_kcyr_pintu01.png",
			"ui/bigbg/picturepuzzle/board_kcyr_pintu02.png",
			"ui/bigbg/picturepuzzle/board_kcyr_pintu03.png",
			"ui/bigbg/picturepuzzle/board_kcyr_tmw01.png",
			"ui/bigbg/picturepuzzle/board_kcyr_tmw02.png",
			"ui/bigbg/plotmemories/board_bg_01.png",
			"ui/bigbg/plotmemories/board_bg_02.png",
			"ui/bigbg/plotmemories/board_bg_03.png",
			"ui/bigbg/plotmemories/board_bg_04.png",
			"ui/bigbg/plotmemories/board_bg_05.png",
			"ui/bigbg/plotmemories/board_bg_06.png",
			"ui/bigbg/plotmemories/board_bg_07.png",
			"ui/bigbg/plotmemories/board_bg_08.png",
			"ui/bigbg/plotmemories/board_bg_09.png",
			"ui/bigbg/plotmemories/board_bg_10.png",
			"ui/bigbg/plotmemories/board_bg_11.png",
			"ui/bigbg/plotmemories/board_bg_12.png",
			"ui/bigbg/plotmemories/board_bg_13.png",
			"ui/bigbg/plotmemories/board_bg_14.png",
			"ui/bigbg/plotmemories/icon_anlong.png",
			"ui/bigbg/plotmemories/icon_dishitian.png",
			"ui/bigbg/plotmemories/icon_guangmingwang.png",
			"ui/bigbg/plotmemories/icon_longyan.png",
			"ui/bigbg/plotmemories/icon_mengzhidui.png",
			"ui/bigbg/plotmemories/icon_nuoyajuqing.png",
			"ui/bigbg/plotmemories/icon_shengmingzhishu.png",
			"ui/bigbg/plotmemories/icon_tianyanjuqing.png",
			"ui/bigbg/plotmemories/icon_xinggeluosa.png",
			"ui/bigbg/plotmemories/icon_xinglanlong.png",
			"ui/bigbg/plotmemories/icon_xiuer.png",
			"ui/bigbg/plotmemories/icon_yirenzhixia.png",
			"ui/bigbg/rankrace/paiweisai_icon_lv01.png",
			"ui/bigbg/rankrace/paiweisai_icon_lv02.png",
			"ui/bigbg/rankrace/paiweisai_icon_lv03.png",
			"ui/bigbg/rankrace/paiweisai_icon_lv04.png",
			"ui/bigbg/rankrace/paiweisai_icon_lv05.png",
			"ui/bigbg/rankrace/paiweisai_icon_lv06.png",
			"ui/bigbg/rankrace/paiweisai_icon_lv07.png",
			"ui/bigbg/rankrace/paiweisai_icon_lv08.png",
			"ui/bigbg/story/story_assets/dh_xiangkuang.png",
			"ui/bigbg/story/story_assets/juqing_mask.png",
			"ui/bigbg/story/story_assets/xgnkq_cjjiesuo_di.png",
			"ui/bigbg/story/story_bg/aoqimofang.png",
			"ui/bigbg/story/story_bg/bg_aside1.png",
			"ui/bigbg/story/story_bg/caidan_cg_1.png",
			"ui/bigbg/story/story_bg/caidan_cg_2.png",
			"ui/bigbg/story/story_bg/cg_0_1.png",
			"ui/bigbg/story/story_bg/cg_0_2.png",
			"ui/bigbg/story/story_bg/cg_0_3.png",
			"ui/bigbg/story/story_bg/cg_1_1.png",
			"ui/bigbg/story/story_bg/cg_1_2.png",
			"ui/bigbg/story/story_bg/cg_1_3.png",
			"ui/bigbg/story/story_bg/cg_1_4.png",
			"ui/bigbg/story/story_bg/cg_1_5.png",
			"ui/bigbg/story/story_bg/cg_1_6.png",
			"ui/bigbg/story/story_bg/cg_1_7.png",
			"ui/bigbg/story/story_bg/cg_2_0.png",
			"ui/bigbg/story/story_bg/cg_2_1.png",
			"ui/bigbg/story/story_bg/cg_2_2.png",
			"ui/bigbg/story/story_bg/cg_2_3.png",
			"ui/bigbg/story/story_bg/cg_2_4.png",
			"ui/bigbg/story/story_bg/cg_2_5.png",
			"ui/bigbg/story/story_bg/cg_2_6.png",
			"ui/bigbg/story/story_bg/cg_3_1.png",
			"ui/bigbg/story/story_bg/cg_3_2.png",
			"ui/bigbg/story/story_bg/cg_3_3.png",
			"ui/bigbg/story/story_bg/cg_3_4.png",
			"ui/bigbg/story/story_bg/cg_3_5.png",
			"ui/bigbg/story/story_bg/cg_4_1.png",
			"ui/bigbg/story/story_bg/cg_4_2.png",
			"ui/bigbg/story/story_bg/cg_4_3.png",
			"ui/bigbg/story/story_bg/cg_s1_1.png",
			"ui/bigbg/story/story_bg/cg_s1_2.png",
			"ui/bigbg/story/story_bg/cg_s1_3.png",
			"ui/bigbg/story/story_bg/cg_s1_4.png",
			"ui/bigbg/story/story_bg/cg_s1_5.png",
			"ui/bigbg/story/story_bg/cg_s1_6.png",
			"ui/bigbg/story/story_bg/cg_y_1_1.png",
			"ui/bigbg/story/story_bg/cg_y_1_2.png",
			"ui/bigbg/story/story_bg/cg_y_1_3.png",
			"ui/bigbg/story/story_bg/cg_y_1_4.png",
			"ui/bigbg/story/story_bg/cg_y_1_5.png",
			"ui/bigbg/story/story_bg/cg_y_1_6.png",
			"ui/bigbg/story/story_bg/cg_y_2_1.png",
			"ui/bigbg/story/story_bg/cg_y_2_2.png",
			"ui/bigbg/story/story_bg/cg_y_2_3.png",
			"ui/bigbg/story/story_bg/cg_y_2_4.png",
			"ui/bigbg/story/story_bg/cg_y_2_5.png",
			"ui/bigbg/story/story_bg/cg_y_3_1.png",
			"ui/bigbg/story/story_bg/cg_y_3_2.png",
			"ui/bigbg/story/story_bg/cg_y_3_3.png",
			"ui/bigbg/story/story_bg/cg_y_3_4.png",
			"ui/bigbg/story/story_bg/cg_y_4_1.png",
			"ui/bigbg/story/story_bg/cg_y_4_2.png",
			"ui/bigbg/story/story_bg/cg_y_4_3.png",
			"ui/bigbg/story/story_bg/cg_y_4_4.png",
			"ui/bigbg/story/story_bg/cg_y_4_5.png",
			"ui/bigbg/story/story_bg/cg_y_4_6.png",
			"ui/bigbg/story/story_bg/cg_y_5_1.png",
			"ui/bigbg/story/story_bg/cg_y_5_2.png",
			"ui/bigbg/story/story_bg/cg_y_5_3.png",
			"ui/bigbg/story/story_bg/cg_y_5_4.png",
			"ui/bigbg/story/story_bg/cg_y_5_5.png",
			"ui/bigbg/story/story_bg/cg_y_5_6.png",
			"ui/bigbg/story/story_bg/cg_y_5_7.png",
			"ui/bigbg/story/story_bg/cg_y_7_1.png",
			"ui/bigbg/story/story_bg/cg_y_7_2.png",
			"ui/bigbg/story/story_bg/cg_z3_0.png"
		},
		{
			"ui/bigbg/story/story_bg/cg_z3_1.png",
			"ui/bigbg/story/story_bg/cg_z3_10.png",
			"ui/bigbg/story/story_bg/cg_z3_2.png",
			"ui/bigbg/story/story_bg/cg_z3_3.png",
			"ui/bigbg/story/story_bg/cg_z3_4.png",
			"ui/bigbg/story/story_bg/cg_z3_6.png",
			"ui/bigbg/story/story_bg/cg_z3_7.png",
			"ui/bigbg/story/story_bg/cg_z3_8.png",
			"ui/bigbg/story/story_bg/cg_z3_9.png",
			"ui/bigbg/story/story_bg/ef_08.png",
			"ui/bigbg/story/story_bg/gal_0_1.png",
			"ui/bigbg/story/story_bg/gal_1_1.png",
			"ui/bigbg/story/story_bg/gal_1_10.png",
			"ui/bigbg/story/story_bg/gal_1_11.png",
			"ui/bigbg/story/story_bg/gal_1_2.png",
			"ui/bigbg/story/story_bg/gal_1_4.png",
			"ui/bigbg/story/story_bg/gal_1_5.png",
			"ui/bigbg/story/story_bg/gal_1_6.png",
			"ui/bigbg/story/story_bg/gal_1_7.png",
			"ui/bigbg/story/story_bg/gal_1_8.png",
			"ui/bigbg/story/story_bg/gal_1_9.png",
			"ui/bigbg/story/story_bg/gal_2_1.png",
			"ui/bigbg/story/story_bg/gal_2_2.png",
			"ui/bigbg/story/story_bg/gal_2_3.png",
			"ui/bigbg/story/story_bg/gal_2_4.png",
			"ui/bigbg/story/story_bg/gal_2_5.png",
			"ui/bigbg/story/story_bg/gal_4_1.png",
			"ui/bigbg/story/story_bg/gal_4_2.png",
			"ui/bigbg/story/story_bg/gal_4_3.png",
			"ui/bigbg/story/story_bg/gal_s1_3.png",
			"ui/bigbg/story/story_bg/gal_s1_4.png",
			"ui/bigbg/story/story_bg/gal_s1_5.png",
			"ui/bigbg/story/story_bg/gal_s1_6.png",
			"ui/bigbg/story/story_bg/gal_y_1_1.png",
			"ui/bigbg/story/story_bg/gal_y_1_2.png",
			"ui/bigbg/story/story_bg/gal_y_1_3.png",
			"ui/bigbg/story/story_bg/gal_y_2_1.png",
			"ui/bigbg/story/story_bg/gal_y_2_2.png",
			"ui/bigbg/story/story_bg/gal_y_2_3.png",
			"ui/bigbg/story/story_bg/gal_y_3_1.png",
			"ui/bigbg/story/story_bg/gal_y_3_2.png",
			"ui/bigbg/story/story_bg/gal_y_3_3.png",
			"ui/bigbg/story/story_bg/gal_y_3_4.png",
			"ui/bigbg/story/story_bg/gal_y_3_5.png",
			"ui/bigbg/story/story_bg/gal_y_3_6.png",
			"ui/bigbg/story/story_bg/gal_y_3_7.png",
			"ui/bigbg/story/story_bg/gal_y_4_1.png",
			"ui/bigbg/story/story_bg/gal_y_4_2.png",
			"ui/bigbg/story/story_bg/gal_y_4_3.png",
			"ui/bigbg/story/story_bg/gal_y_5_1.png",
			"ui/bigbg/story/story_bg/gal_y_5_2.png",
			"ui/bigbg/story/story_bg/gal_y_5_3.png",
			"ui/bigbg/story/story_bg/gal_y_5_4.png",
			"ui/bigbg/story/story_bg/gal_y_5_5.png",
			"ui/bigbg/story/story_bg/gal_y_5_6.png",
			"ui/bigbg/story/story_bg/gal_y_6_1.png",
			"ui/bigbg/story/story_bg/gal_z3_1.png",
			"ui/bigbg/story/story_bg/gal_z3_2.png",
			"ui/bigbg/story/story_bg/gal_z3_3.png",
			"ui/bigbg/story/story_bg/gal_z3_4.png",
			"ui/bigbg/story/story_bg/gal_z3_6.png",
			"ui/bigbg/story/story_bg/gal_z4_1.png",
			"ui/bigbg/story/story_bg/gal_z4_2.png",
			"ui/bigbg/story/story_bg/gal_z4_3.png",
			"ui/bigbg/story/story_bg/gal_z4_4.png",
			"ui/bigbg/story/story_bg/hgd_gal_1.png",
			"ui/bigbg/story/story_bg/hgd_gal_2.png",
			"ui/bigbg/story/story_bg/hgd_gal_3.png",
			"ui/bigbg/story/story_bg/hgd_gal_4.png",
			"ui/bigbg/story/story_bg/hgd_gal_5.png",
			"ui/bigbg/story/story_bg/hgd_gal_6.png",
			"ui/bigbg/story/story_bg/hgd_gal_7.png",
			"ui/bigbg/story/story_bg/hgd_sgfl_1.png",
			"ui/bigbg/story/story_bg/hgd_sgfl_2.png",
			"ui/bigbg/story/story_bg/longhun.png",
			"ui/bigbg/story/story_bg/panduola.png",
			"ui/bigbg/story/story_bg/panduola1.png",
			"ui/bigbg/story/story_bg/sence_mofang.png",
			"ui/bigbg/story/story_bg/story_chapter_bg.png",
			"ui/bigbg/story/story_bg/tm_mcy_1.png",
			"ui/bigbg/story/story_bg/tm_mcy_2.png",
			"ui/bigbg/story/story_bg/tm_mcy_3.png",
			"ui/bigbg/story/story_bg/tm_mcy_4.png",
			"ui/bigbg/story/story_bg/tm_mcy_5.png",
			"ui/bigbg/story/story_bg/tm_mcy_6.png",
			"ui/bigbg/story/story_bg/tm_mcy_7.png",
			"ui/bigbg/story/story_bg/yewan.png",
			"ui/bigbg/story/story_icons/icon_expedition_bidingbaoji_2.png",
			"ui/bigbg/story/story_icons/icon_jiaoshui_01.png",
			"ui/bigbg/story/story_icons/icon_juqing_dishitian256.png",
			"ui/bigbg/story/story_icons/icon_juqing_fg.png",
			"ui/bigbg/story/story_icons/icon_juqing_hall.png",
			"ui/bigbg/story/story_icons/icon_juqing_hl.png",
			"ui/bigbg/story/story_icons/icon_juqing_hsdp.png",
			"ui/bigbg/story/story_icons/icon_juqing_jhj0.png",
			"ui/bigbg/story/story_icons/icon_juqing_jhj1.png",
			"ui/bigbg/story/story_icons/icon_juqing_jly.png",
			"ui/bigbg/story/story_icons/icon_juqing_jyg.png",
			"ui/bigbg/story/story_icons/icon_juqing_lyzl.png",
			"ui/bigbg/story/story_icons/icon_juqing_xj.png",
			"ui/bigbg/story/story_icons/icon_juqing_xp.png",
			"ui/bigbg/story/story_icons/icon_juqing_xtwt.png",
			"ui/bigbg/story/story_icons/icon_juqing_yhl.png",
			"ui/bigbg/story/story_icons/icon_juqing_yqxz.png",
			"ui/bigbg/story/story_icons/icon_juqing_ys.png",
			"ui/bigbg/story/story_icons/icon_juqing_yw.png",
			"ui/bigbg/story/story_icons/icon_juqing_zhy.png",
			"ui/bigbg/story/story_icons/icon_juqing_zmhx.png",
			"ui/bigbg/story/story_icons/icon_juqing_zmzd.png",
			"ui/bigbg/story/story_icons/icon_rubikcube.png",
			"ui/bigbg/story/story_icons_npc/story_icons_npc_kaya.png",
			"ui/bigbg/story/story_icons_npc/story_icons_npc_nan.png",
			"ui/bigbg/story/story_icons_npc/story_icons_npc_nv.png",
			"ui/bigbg/story/story_icons_npc/story_icons_npc_xuanwu.png",
			"ui/bigbg/story/story_icons_npc/story_icons_npc_yuandulingbao.png",
			"ui/bigbg/story/story_images/weiduoliyadoupeng.png",
			"ui/bigbg/story/story_images/xiaotiandoupeng.png",
			"ui/bigbg/sunranbattle/board_lysj_12.png",
			"ui/bigbg/sunranbattle/board_lysj_13.png",
			"ui/bigbg/sunranbattle/board_lysj_14.png",
			"ui/bigbg/sunranbattle/board_lysj_15.png",
			"ui/bigbg/views/bg_ah_01.png",
			"ui/bigbg/views/bg_sgj.png",
			"ui/bigbg/views/bg_shilian.png",
			"ui/bigbg/views/bg_sz_01.png",
			"ui/bigbg/views/bg_wanfa01.png",
			"ui/bigbg/views/bg_wjsl_01.png",
			"ui/bigbg/views/bg_ylc.png",
			"ui/bigbg/views/bg_yxsl_01.png",
			"ui/bigbg/views/bg_zq01.png",
			"ui/bigbg/views/board_ah_01.png",
			"ui/bigbg/views/board_gg_01.png",
			"ui/bigbg/views/board_hg_bg.png",
			"ui/bigbg/views/board_ljcz_01_1.png",
			"ui/bigbg/views/board_ljcz_06.png",
			"ui/bigbg/views/board_mzd.png",
			"ui/bigbg/views/board_yuchuangjiao_01.png",
			"ui/bigbg/views/board_zhuzhen_01.png",
			"ui/bigbg/views/ditu_bg-real.png",
			"ui/bigbg/views/ditu_bg.png",
			"ui/bigbg/views/hs_bg01.png",
			"ui/bigbg/views/juqing_board_bg1.png",
			"ui/bigbg/views/npc_fz01.png",
			"ui/bigbg/views/qirirenwu_bg.png",
			"ui/bigbg/views/quanjiafu.png",
			"ui/bigbg/views/shengxingbeijing.png",
			"ui/bigbg/views/baozangmicheng/bg_bzmc_01.png",
			"ui/bigbg/views/baozangmicheng/board_bzmc_01.png",
			"ui/bigbg/views/baozangmicheng/board_dj_01.png",
			"ui/bigbg/views/challenges/board_jxt_bg.png",
			"ui/bigbg/views/challenges/qnwxyx_bg.png",
			"ui/bigbg/views/challenges/finddifference/cf.png",
			"ui/bigbg/views/challenges/finddifference/gk.png",
			"ui/bigbg/views/challenges/finddifference/ksbp.png",
			"ui/bigbg/views/challenges/finddifference/kxj.png",
			"ui/bigbg/views/challenges/finddifference/pdl.png",
			"ui/bigbg/views/challenges/finddifference/sxxx.png",
			"ui/bigbg/views/challenges/finddifference/ty.png",
			"ui/bigbg/views/challenges/finddifference/xn.png",
			"ui/bigbg/views/challenges/finddifference/xxcfly.png",
			"ui/bigbg/views/challenges/finddifference/zx.png",
			"ui/bigbg/views/challenges/guangmingwang/bg_gmw_01.png",
			"ui/bigbg/views/challenges/guangmingwang/board_gmw_02.png",
			"ui/bigbg/views/challenges/guangmingwang/board_gmw_03.png",
			"ui/bigbg/views/challenges/guangmingwang/board_gmw_05.png",
			"ui/bigbg/views/challenges/lianyushenjing/board_lysj_16.png",
			"ui/bigbg/views/challenges/lianyushenjing/board_lysj_17.png",
			"ui/bigbg/views/challenges/lianyushenjing/board_lysj_bg_01.png",
			"ui/bigbg/views/challenges/luotiandajiao/board_bg02.png",
			"ui/bigbg/views/challenges/luotiandajiao/board_vsdi.png",
			"ui/bigbg/views/challenges/mang/bg_mangtz01.png",
			"ui/bigbg/views/challenges/mang/bg_mangtz02.png",
			"ui/bigbg/views/challenges/mang/board_mangtz01.png",
			"ui/bigbg/views/challenges/mang/board_mangtz09.png",
			"ui/bigbg/views/challenges/mengmeng/bg_ahmm_01.png",
			"ui/bigbg/views/challenges/mengmeng/bg_dlmm.png",
			"ui/bigbg/views/challenges/mengmeng/bg_dlmm_01.png",
			"ui/bigbg/views/challenges/mengmeng/bg_dlmm_02.png",
			"ui/bigbg/views/challenges/mengmeng/bg_dlmm_03.png",
			"ui/bigbg/views/challenges/mengmeng/bg_dlmm_04.png",
			"ui/bigbg/views/challenges/mengmeng/board_ahmm_01.png",
			"ui/bigbg/views/challenges/mengmeng/com_huode_text23.png",
			"ui/bigbg/views/challenges/shengguangfeilong/bg_sgfltz_01.png",
			"ui/bigbg/views/challenges/shengguangfeilong/board_sgfltz_10.png",
			"ui/bigbg/views/challenges/shengguangfeilong/board_sgfltz_24.png",
			"ui/bigbg/views/challenges/xianshi/bg_amier_01.png",
			"ui/bigbg/views/challenges/xianshi/bg_binglingwang_01.png",
			"ui/bigbg/views/challenges/xianshi/bg_binglingwang_02.png",
			"ui/bigbg/views/challenges/xianshi/bg_ln.png",
			"ui/bigbg/views/challenges/xianshi/bg_mingjing_01.png",
			"ui/bigbg/views/challenges/xianshi/bg_tzars_01.png",
			"ui/bigbg/views/challenges/xianshi/bg_tzfbb_01.png",
			"ui/bigbg/views/challenges/xianshi/bg_tzfbb_02.png",
			"ui/bigbg/views/challenges/xianshi/bg_tzlh_01.png",
			"ui/bigbg/views/challenges/xianshi/bg_tzpdl_01.png",
			"ui/bigbg/views/challenges/xianshi/bg_tzzhzs_01.png",
			"ui/bigbg/views/challenges/xianshi/bg_tzzhzs_02.png",
			"ui/bigbg/views/challenges/xianshi/bg_xxy_01.png",
			"ui/bigbg/views/challenges/xianshi/bg_youlie.png",
			"ui/bigbg/views/challenges/xianshi/board_amier_01.png",
			"ui/bigbg/views/challenges/xianshi/board_amier_04.png",
			"ui/bigbg/views/challenges/xianshi/board_ln_02.png",
			"ui/bigbg/views/challenges/xianshi/board_miji_01.png",
			"ui/bigbg/views/challenges/xianshi/board_tzars_03.png",
			"ui/bigbg/views/challenges/xianshi/board_tzlh_02.png",
			"ui/bigbg/views/challenges/xianshi/board_tzlh_12.png",
			"ui/bigbg/views/challenges/xianshi/board_tzpdl_03.png",
			"ui/bigbg/views/challenges/xianshi/board_tzpdl_04.png",
			"ui/bigbg/views/challenges/xianshi/board_tzpdl_05.png",
			"ui/bigbg/views/challenges/xianshi/board_tzzhzs_02.png",
			"ui/bigbg/views/challenges/xianshi/board_tzzhzs_25.png",
			"ui/bigbg/views/challenges/xianshi/board_yrzxtzjl_bg_xiaoyouxi.png",
			"ui/bigbg/views/challenges/xiongmao/xmtz_bg.png",
			"ui/bigbg/views/challenges/xiongmao/xmtz_bg1.png",
			"ui/bigbg/views/challenges/xiongmao/xmtz_caocong.png",
			"ui/bigbg/views/challenges/xiongmao/xmtz_img_shuichi.png",
			"ui/bigbg/views/challenges/yilishabai/bg_ylsb_01.png",
			"ui/bigbg/views/challenges/yilishabai/bg_ylsb_02.png",
			"ui/bigbg/views/challenges/yilishabai/bg_ylsb_03.png",
			"ui/bigbg/views/challenges/yilishabai/bg_ylsb_04.png",
			"ui/bigbg/views/challenges/yilishabai/bg_ylsb_05.png",
			"ui/bigbg/views/challenges/yilishabai/bg_ylsb_06.png",
			"ui/bigbg/views/challenges/yilishabai/bg_ylsb_07.png",
			"ui/bigbg/views/challenges/yilishabai/bg_ylsb_08.png",
			"ui/bigbg/views/challenges/yilishabai/bg_ylsb_09.png",
			"ui/bigbg/views/challenges/yilishabai/bg_ylsb_10.png",
			"ui/bigbg/views/challenges/yilishabai/bg_ylsb_11.png",
			"ui/bigbg/views/challenges/yilishabai/bg_ylsb_12.png",
			"ui/bigbg/views/challenges/yilishabai/bg_ylsb_13.png",
			"ui/bigbg/views/challenges/yilishabai/bg_ylsb_18.png",
			"ui/bigbg/views/chongwuyuan/bg_cwyeq_01.png",
			"ui/bigbg/views/chongwuyuan/bg_fangzhi_01.png",
			"ui/bigbg/views/chongwuyuan/bg_fangzhi_02.png",
			"ui/bigbg/views/chongwuyuan/bg_xnmx_01.png",
			"ui/bigbg/views/chongwuyuan/board_cwy_01.png",
			"ui/bigbg/views/chongwuyuan/board_jytj_01.png",
			"ui/bigbg/views/chongwuyuan/board_jytj_03.png",
			"ui/bigbg/views/chongwuyuan/board_yj_01.png",
			"ui/bigbg/views/chongwuyuan/btn_cwcy_01.png",
			"ui/bigbg/views/com_bg/bg_wanfa02.png",
			"ui/bigbg/views/com_bg/com_bg_fz04.png",
			"ui/bigbg/views/com_bg/com_bg_fz05.png",
			"ui/bigbg/views/com_bg/com_bg_jingjichang.png",
			"ui/bigbg/views/com_bg/com_board63.png",
			"ui/bigbg/views/com_bg/com_board_tc01.png",
			"ui/bigbg/views/com_bg/com_datiban_01.png",
			"ui/bigbg/views/com_bg/com_lv1_board01.png",
			"ui/bigbg/views/com_bg/com_lv1_board02.png",
			"ui/bigbg/views/com_bg/com_lv2_board02.png",
			"ui/bigbg/views/com_bg/com_lv3_board03.png",
			"ui/bigbg/views/com_bg/com_lv5_board02.png",
			"ui/bigbg/views/com_bg/com_lv5_board06.png",
			"ui/bigbg/views/com_bg/com_qp01_1.png",
			"ui/bigbg/views/com_bg/com_qp04.png",
			"ui/bigbg/views/com_bg/com_zrzl_01.png",
			"ui/bigbg/views/damaoxian/bg_dmx_01.png",
			"ui/bigbg/views/damaoxian/board_dmx_01.png",
			"ui/bigbg/views/fuben_zhandou/bg_bz01.png",
			"ui/bigbg/views/fuben_zhandou/board_bz20.png",
			"ui/bigbg/views/fuben_zhandou/board_dikuang.png",
			"ui/bigbg/views/fuben_zhandou/board_jjc_20.png",
			"ui/bigbg/views/fuben_zhandou/board_jjc_21.png",
			"ui/bigbg/views/fuben_zhandou/board_jjc_22.png",
			"ui/bigbg/views/fuben_zhandou/board_jjc_24.png",
			"ui/bigbg/views/fuben_zhandou/board_jjc_25.png",
			"ui/bigbg/views/fuben_zhandou/board_jjc_26.png",
			"ui/bigbg/views/fuben_zhandou/board_jltz_01.png",
			"ui/bigbg/views/fuben_zhandou/board_zd_09.png",
			"ui/bigbg/views/fuben_zhandou/board_zd_11.png",
			"ui/bigbg/views/fuben_zhandou/ditu_01.png",
			"ui/bigbg/views/fuben_zhandou/ditu_02.png",
			"ui/bigbg/views/fuben_zhandou/ditu_08.png",
			"ui/bigbg/views/fuben_zhandou/ditu_09.png",
			"ui/bigbg/views/fuben_zhandou/ditu_10.png",
			"ui/bigbg/views/fuben_zhandou/ditu_11.png",
			"ui/bigbg/views/fuben_zhandou/ditu_12.png",
			"ui/bigbg/views/fuben_zhandou/ditu_13.png",
			"ui/bigbg/views/fuben_zhandou/fubeng_bg.png",
			"ui/bigbg/views/fuben_zhandou/fubeng_board.png",
			"ui/bigbg/views/fuben_zhandou/fubeng_board2.png",
			"ui/bigbg/views/fuben_zhandou/fubeng_luxian.png",
			"ui/bigbg/views/fuben_zhandou/fuben_zsjs_di1.png",
			"ui/bigbg/views/fuben_zhandou/fuben_zsjs_di5.png",
			"ui/bigbg/views/fuben_zhandou/zqtb_board01.png",
			"ui/bigbg/views/fuli/bg_flzx01.png",
			"ui/bigbg/views/fuli/bg_flzx_qrqd01.png",
			"ui/bigbg/views/fuli/bg_flzx_sars01.png",
			"ui/bigbg/views/fuli/bg_flzx_sars02.png",
			"ui/bigbg/views/fuli/bg_flzx_tllq_01.png",
			"ui/bigbg/views/fuli/bg_flzx_tllq_03.png",
			"ui/bigbg/views/fuli/bg_flzx_zyzh_01.png",
			"ui/bigbg/views/fuli/bg_jpk01.png",
			"ui/bigbg/views/fuli/board_flzx_dhm_01.png",
			"ui/bigbg/views/fuli/board_flzx_shjsl_01.png",
			"ui/bigbg/views/fuli/board_flzx_shjsl_02.png",
			"ui/bigbg/views/fuli/board_flzx_zxsj_03.png",
			"ui/bigbg/views/fuli/board_flzx_zxsj_04.png",
			"ui/bigbg/views/fuli/board_gmw01.png",
			"ui/bigbg/views/fuli/board_mrqd_01.png",
			"ui/bigbg/views/fuli/board_mrqd_02.png",
			"ui/bigbg/views/fuli/board_sldb01.png",
			"ui/bigbg/views/fuli/board_sldb03.png",
			"ui/bigbg/views/fuli/board_xiaonuo.png",
			"ui/bigbg/views/game/bg_clmxj_01.png",
			"ui/bigbg/views/game/bg_clmxj_02.png",
			"ui/bigbg/views/game/board_alxyx_bg4.png",
			"ui/bigbg/views/game/jiehua/bg_myjgh_02.png",
			"ui/bigbg/views/game/jiehua/bg_myjgh_03.png",
			"ui/bigbg/views/gerenxinxi/bg_gr_01.png",
			"ui/bigbg/views/gerenxinxi/bg_gr_02.png",
			"ui/bigbg/views/gerenxinxi/bg_gr_03.png",
			"ui/bigbg/views/gerenxinxi/board_gr_01.png",
			"ui/bigbg/views/gerenxinxi/board_tc51_01.png",
			"ui/bigbg/views/guaiwulaixi/bg_gwlx01.png",
			"ui/bigbg/views/guaiwulaixi/board_gwlx07.png",
			"ui/bigbg/views/guaiwulaixi/board_gwlx08.png",
			"ui/bigbg/views/guaiwulaixi/board_gwlx09.png",
			"ui/bigbg/views/huizhang/board_hz_01.png",
			"ui/bigbg/views/huizhang/board_hz_10.png",
			"ui/bigbg/views/huodong/bg_9znqd_01.png",
			"ui/bigbg/views/huodong/bg_anlonghuizong.png",
			"ui/bigbg/views/huodong/bg_flzx_mxndj_01.png",
			"ui/bigbg/views/huodong/bg_flzx_mxndj_02.png",
			"ui/bigbg/views/huodong/bg_flzx_mxndj_12.png",
			"ui/bigbg/views/huodong/bg_ljcz_01.png",
			"ui/bigbg/views/huodong/bg_mzd_01.png",
			"ui/bigbg/views/huodong/bg_sjzlkb.png",
			"ui/bigbg/views/huodong/bg_yyfb_01.png",
			"ui/bigbg/views/huodong/bg_zlbs_01.png",
			"ui/bigbg/views/huodong/board_9znlc.png",
			"ui/bigbg/views/huodong/board_9znlczz_01.png",
			"ui/bigbg/views/huodong/board_9znlczz_02.png",
			"ui/bigbg/views/huodong/board_9znlc_choujiang.png",
			"ui/bigbg/views/huodong/board_9znlc_tianxie.png",
			"ui/bigbg/views/huodong/board_al_01.png",
			"ui/bigbg/views/huodong/board_antishi_11.png",
			"ui/bigbg/views/huodong/board_bg 1.png",
			"ui/bigbg/views/huodong/board_bg.png",
			"ui/bigbg/views/huodong/board_bg_yyhz.png",
			"ui/bigbg/views/huodong/board_dcz_01.png",
			"ui/bigbg/views/huodong/board_dcz_02.png",
			"ui/bigbg/views/huodong/board_flzx_sars01.png",
			"ui/bigbg/views/huodong/board_hd_1.png",
			"ui/bigbg/views/huodong/board_kcyr_bg.png",
			"ui/bigbg/views/huodong/board_lchl_bg_01.png",
			"ui/bigbg/views/huodong/board_lcspf_01.png",
			"ui/bigbg/views/huodong/board_ljcz_01.png",
			"ui/bigbg/views/huodong/board_lsqzhslbtj01.png",
			"ui/bigbg/views/huodong/board_mxch01.png",
			"ui/bigbg/views/huodong/board_mxhk_01.png",
			"ui/bigbg/views/huodong/board_nianfeidanchuang_01_1.png",
			"ui/bigbg/views/huodong/board_pt_bg.png",
			"ui/bigbg/views/huodong/board_qjf_01.png",
			"ui/bigbg/views/huodong/board_sclbtj_01.png",
			"ui/bigbg/views/huodong/board_sc_02.png",
			"ui/bigbg/views/huodong/board_sc_07.png",
			"ui/bigbg/views/huodong/board_sjdllb_01.png",
			"ui/bigbg/views/huodong/board_tc54.png",
			"ui/bigbg/views/huodong/board_tclb_02.png",
			"ui/bigbg/views/huodong/board_tclb_04.png",
			"ui/bigbg/views/huodong/board_tylb_02.png",
			"ui/bigbg/views/huodong/board_xxybg_01.png",
			"ui/bigbg/views/huodong/board_xxy_02.png",
			"ui/bigbg/views/huodong/board_xxy_03.png",
			"ui/bigbg/views/huodong/board_xy_01.png",
			"ui/bigbg/views/huodong/board_yyfb_08.png",
			"ui/bigbg/views/huodong/board_zdsz_01.png",
			"ui/bigbg/views/huodong/board_zdsz_08.png",
			"ui/bigbg/views/huodong/board_zdsz_bg.png",
			"ui/bigbg/views/huodong/board_zhsdl_bg.png",
			"ui/bigbg/views/huodong/board_zhsdl_bg02.png",
			"ui/bigbg/views/huodong/board_zklk_01.png",
			"ui/bigbg/views/huodong/mairen_bg01.png",
			"ui/bigbg/views/huodong/mairen_bg02.png",
			"ui/bigbg/views/huodong/mzd_bg1.png",
			"ui/bigbg/views/huodong/leichonghaoli/board_cbg_03.png",
			"ui/bigbg/views/huodong/leichonghaoli/board_cbg_04.png",
			"ui/bigbg/views/huodong/leichonghaoli/board_cbg_bg.png",
			"ui/bigbg/views/huodong/pifushoumai/board_pfhd_01.png",
			"ui/bigbg/views/huodong/pifushoumai/board_pfhd_07.png",
			"ui/bigbg/views/huodong/pifushoumai/board_pfhd_08.png",
			"ui/bigbg/views/huodong/pifushoumai/board_pfhd_09.png",
			"ui/bigbg/views/huodong/pifushoumai/title_pfhd_bsss_01.png",
			"ui/bigbg/views/huodong/pifushoumai/title_pfhd_bsss_04.png",
			"ui/bigbg/views/huodong/pifushoumai/title_pfhd_bsss_07.psb.png",
			"ui/bigbg/views/huodong/xinyuandan/board_bg_01.png",
			"ui/bigbg/views/huodong/xinyuandan/board_kx_01.png",
			"ui/bigbg/views/huodong/xinyuandan/board_kx_02.png",
			"ui/bigbg/views/huodong/xinyuandan/board_kx_06.png",
			"ui/bigbg/views/jiazu/board_jztb_08.png",
			"ui/bigbg/views/jiazu/board_jztb_16.png",
			"ui/bigbg/views/jiazu/board_jztb_17.png",
			"ui/bigbg/views/jiazu/board_jz_kejixitong.png",
			"ui/bigbg/views/jiazu/jiazu_mw_bg01.png"
		},
		{
			"ui/bigbg/views/jiazu/jiazu_mw_bg02.png",
			"ui/bigbg/views/jingling/bg_jltd01.png",
			"ui/bigbg/views/jingling/bg_jltd02.png",
			"ui/bigbg/views/jingling/board_jinglingjinhua.png",
			"ui/bigbg/views/jingling/board_jlgl_01.png",
			"ui/bigbg/views/jingling/board_jlpf_07.png",
			"ui/bigbg/views/jingling/board_jlpf_bg01.png",
			"ui/bigbg/views/jingling/board_jlpf_bg02.png",
			"ui/bigbg/views/jingling/board_jlpf_bg03.png",
			"ui/bigbg/views/jingling/board_jlpf_bg04.png",
			"ui/bigbg/views/jingling/board_jlpl.png",
			"ui/bigbg/views/jingling/board_spqh_01.png",
			"ui/bigbg/views/jingling/board_sx_20.png",
			"ui/bigbg/views/jingling/icon_bg_rw.png",
			"ui/bigbg/views/jingling/jingling_zb_01.png",
			"ui/bigbg/views/jingling/jlbb_bg.png",
			"ui/bigbg/views/jingling/zhuangbei/bg_lianjin_01.png",
			"ui/bigbg/views/jingling/zhuangbei/board_168_02.png",
			"ui/bigbg/views/jingling/zhuangbei/board_lianjin_01.png",
			"ui/bigbg/views/jinglingdaluandou/board_bg_01.png",
			"ui/bigbg/views/jinglingdaluandou/board_bg_02.png",
			"ui/bigbg/views/jinglingdaluandou/board_hongdi_02.png",
			"ui/bigbg/views/jinglingdaluandou/board_landi_02.png",
			"ui/bigbg/views/jinglingdaluandou/board_tishi_di.png",
			"ui/bigbg/views/jingyingxuanshang/bg_txz03.png",
			"ui/bigbg/views/jingyingxuanshang/bg_xg_tongxunzhen.png",
			"ui/bigbg/views/jingyingxuanshang/board_zhanling_01.png",
			"ui/bigbg/views/jingyingxuanshang/board_zhanling_02.png",
			"ui/bigbg/views/jinjichang/bg_gjjjc.png",
			"ui/bigbg/views/jinjichang/board_jjc_12.png",
			"ui/bigbg/views/jinjichang/board_jjc_13.png",
			"ui/bigbg/views/jinjichang/board_jjc_15.png",
			"ui/bigbg/views/jinjichang/board_jjc_16.png",
			"ui/bigbg/views/jinjichang/jingjichang_zjm_new_05.png",
			"ui/bigbg/views/jiugongbazhen/bg_jgbz_01.png",
			"ui/bigbg/views/jiugongbazhen/bg_zg_01.png",
			"ui/bigbg/views/jiugongbazhen/board_gd_01.png",
			"ui/bigbg/views/juqinghuigu/board_bg.png",
			"ui/bigbg/views/juqinghuigu/board_mianban01.png",
			"ui/bigbg/views/juqinghuigu/board_mianban02.png",
			"ui/bigbg/views/juqinghuigu/board_mianban03.png",
			"ui/bigbg/views/juqinghuigu/board_mianban05.png",
			"ui/bigbg/views/liaotian/fx_board01.png",
			"ui/bigbg/views/liaotian/fx_board03.png",
			"ui/bigbg/views/liushiwanjiahuigui/bg_lswjhg_01.png",
			"ui/bigbg/views/liushiwanjiahuigui/bg_lswjhg_02.png",
			"ui/bigbg/views/liushiwanjiahuigui/bg_lswjhg_03.png",
			"ui/bigbg/views/liushiwanjiahuigui/bg_lswjhg_04.png",
			"ui/bigbg/views/liushiwanjiahuigui/board_tc_01.png",
			"ui/bigbg/views/liushiwanjiahuigui/board_tc_02.png",
			"ui/bigbg/views/liushiwanjiahuigui/board_tc_03.png",
			"ui/bigbg/views/liushiwanjiahuigui/board_tc_06.png",
			"ui/bigbg/views/mibaoshangcheng/bg_newsc_01.png",
			"ui/bigbg/views/mibaoshangcheng/board_newsc_01.png",
			"ui/bigbg/views/mibaoshangcheng/board_newsc_02.png",
			"ui/bigbg/views/mibaoshangcheng/board_newsc_09.png",
			"ui/bigbg/views/mibaoshangcheng/board_newsc_10.png",
			"ui/bigbg/views/mibaoshangcheng/board_newsc_11.png",
			"ui/bigbg/views/mibaoshangcheng/board_newsc_12.png",
			"ui/bigbg/views/mibaoshangcheng/board_newsc_14.png",
			"ui/bigbg/views/mibaoshangcheng/board_newsc_15.png",
			"ui/bigbg/views/mibaoshangcheng/board_newsc_17.png",
			"ui/bigbg/views/mibaoshangcheng/board_vip_01.png",
			"ui/bigbg/views/mibaoshangcheng/board_vip_bg.png",
			"ui/bigbg/views/nianfei/board_cyl_01.png",
			"ui/bigbg/views/nianfei/board_cyl_02.png",
			"ui/bigbg/views/nianfei/board_cyl_03.png",
			"ui/bigbg/views/paiqian/pq_bg01.png",
			"ui/bigbg/views/paiqian/pq_bg02.png",
			"ui/bigbg/views/paiweisai/paiweisai_jiesuan01.png",
			"ui/bigbg/views/paiweisai/paiweisai_jiesuan02.png",
			"ui/bigbg/views/paiweisai/paiweisai_jiesuan_bg.png",
			"ui/bigbg/views/paiweisai/paiweisai_js_bar01.png",
			"ui/bigbg/views/paiweisai/paiweisai_rk_bar01.png",
			"ui/bigbg/views/paiweisai/paiweisai_zjm_bar01.png",
			"ui/bigbg/views/pozhentianxia/board_bg_diyu.png",
			"ui/bigbg/views/pozhentianxia/pozhentianxia_pztx_23.png",
			"ui/bigbg/views/pozhentianxia/pozhentianxia_pztx_25.png",
			"ui/bigbg/views/pozhentianxia/pozhentianxia_pztx_26.png",
			"ui/bigbg/views/renwu/bg_rw01.png",
			"ui/bigbg/views/renwu/board_jud08.png",
			"ui/bigbg/views/shijianjiaonang/board_huodong1.png",
			"ui/bigbg/views/shijianjiaonang/board_huodong2.png",
			"ui/bigbg/views/shijianzhilun/bg_sjzl01.png",
			"ui/bigbg/views/shijianzhilun/board_sjzl_07.png",
			"ui/bigbg/views/shijianzhilun/board_sjzl_11.png",
			"ui/bigbg/views/shijianzhilun/board_sjzl_13.png",
			"ui/bigbg/views/shijianzhilun/board_sjzl_14.png",
			"ui/bigbg/views/shijianzhilun/board_sjzl_15.png",
			"ui/bigbg/views/shijianzhuisu/beijingnew.png",
			"ui/bigbg/views/shijianzhuisu/bg_sjzs.png",
			"ui/bigbg/views/shiluoyiji/heishi_board01.png",
			"ui/bigbg/views/shiluoyiji/main_bg01.png",
			"ui/bigbg/views/shiluoyiji/main_bg03.png",
			"ui/bigbg/views/shiluoyiji/shijian_board03.png",
			"ui/bigbg/views/shiluoyiji/shijian_board_01.png",
			"ui/bigbg/views/shiluoyiji/xj_title_01.png",
			"ui/bigbg/views/shiluoyiji/xj_title_02.png",
			"ui/bigbg/views/shiluoyiji/yuanzheng_title2.png",
			"ui/bigbg/views/shiluoyiji/yuanzheng_title5.png",
			"ui/bigbg/views/shoucangguan/bg_shoucangguan_01.png",
			"ui/bigbg/views/shoucangguan/board_shoucangguan_11.png",
			"ui/bigbg/views/story/dh_img_duihuakuang1.png",
			"ui/bigbg/views/story/dh_img_juqingkuang.png",
			"ui/bigbg/views/sxgame/sx_background01.png",
			"ui/bigbg/views/sxgame/sx_img_gezi.png",
			"ui/bigbg/views/tongxunqi/board_bg.png",
			"ui/bigbg/views/tongxunqi/board_diban.png",
			"ui/bigbg/views/tujian/bg_bjb.png",
			"ui/bigbg/views/tujian/bg_jq01.png",
			"ui/bigbg/views/tujian/bg_tj_01.png",
			"ui/bigbg/views/tujian/bg_tj_02.png",
			"ui/bigbg/views/tujian/board_jq01.png",
			"ui/bigbg/views/tujian/jb_bg02.png",
			"ui/bigbg/views/tujian/jb_di01.png",
			"ui/bigbg/views/xiaonuobianbianbian/xnbbb_bg_caodi.png",
			"ui/bigbg/views/xinshou/board_guize_01.png",
			"ui/bigbg/views/xinshou/board_guize_02.png",
			"ui/bigbg/views/xinshou/board_guize_03.png",
			"ui/bigbg/views/xuyuanchi/bg_wwxyc01.png",
			"ui/bigbg/views/xuyuanchi/board_wwxyc11.png",
			"ui/bigbg/views/yongzhezhita/bg_dark.png",
			"ui/bigbg/views/yongzhezhita/bg_fire.png",
			"ui/bigbg/views/yongzhezhita/bg_grass.png",
			"ui/bigbg/views/yongzhezhita/bg_light_0.png",
			"ui/bigbg/views/yongzhezhita/bg_water.png",
			"ui/bigbg/views/yongzhezhita/bg_yzzl01.png",
			"ui/bigbg/views/yongzhezhita/bg_yzzt02.png",
			"ui/bigbg/views/yongzhezhita/board_dark.png",
			"ui/bigbg/views/yongzhezhita/board_fire.png",
			"ui/bigbg/views/yongzhezhita/board_grass.png",
			"ui/bigbg/views/yongzhezhita/board_water.png",
			"ui/bigbg/views/zhaohuanqiyue/board_taizi.png",
			"ui/bigbg/views/zhuzhu/pfxz_board01.png",
			"ui/bigbg/views/zhuzhu/zzczj_bg01.png",
			"ui/bigbg/views/zhuzhu/zzczj_bg02.png",
			"ui/bigbg/views/zhuzhu/zzly_board01.png",
			"ui/bigbg/views/zhuzhu/zzmx_board01.png",
			"ui/bigbg/views/zhuzhu/zzqs_board01.png",
			"ui/bigbg/wangzhezhilu/bg_tz_jy01.png",
			"ui/bigbg/wangzhezhilu/bg_tz_jy02.png",
			"ui/bigbg/wangzhezhilu/bg_tz_pt01.png",
			"ui/bigbg/wangzhezhilu/bg_tz_pt02.png",
			"ui/bigbg/wangzhezhilu/bg_tz_pt03.png",
			"ui/bigbg/wangzhezhilu/bg_tz_pt04.png",
			"ui/bigbg/waterdarktower/board_sat_bg1.png",
			"ui/bigbg/waterdarktower/board_sat_bg2.png",
			"ui/bigbg/worldboss/sjb_bg_01.png",
			"ui/bigbg/worldboss/sjb_bg_02.png",
			"ui/bigbg/worldboss/sjb_bg_03.png",
			"ui/bigbg/worldboss/sjb_ls_01.png",
			"ui/bigbg/worldboss/sjb_ls_03.png",
			"ui/bigbg/worldboss/sjb_lxl_01.png",
			"ui/bigbg/worldboss/sjb_lxl_03.png",
			"ui/bigbg/worldboss/sjb_mengban.png",
			"ui/bigbg/worldboss/sjb_wxl_01.png",
			"ui/bigbg/worldboss/sjb_wxl_03.png",
			"ui/bigbg/worldboss/sjb_xg_01.png",
			"ui/bigbg/worldboss/sjb_xg_03.png",
			"ui/bigbg/worldboss/sjb_zl_01.png",
			"ui/bigbg/worldboss/sjb_zl_03.png",
			"ui/bigbg/yyfb/board_sjcc_01.png",
			"ui/bigbg/yyfb/board_sjcc_02.png",
			"ui/bigbg/yyfb/board_sjcc_03.png",
			"ui/bigbg/yyfb/board_sjcc_04.png",
			"ui/bigbg/yyfb/board_yyfb_11.png",
			"ui/bigbg/yyfb/board_yyfb_11_1.png",
			"ui/bigbg/yyfb/board_yyfb_11_2.png",
			"ui/bigbg/yyfb/yyfb_wllc_blue.png",
			"ui/bigbg/yyfb/yyfb_wllc_origin.png",
			"ui/bigbg/zhaohuan/bg_antianshi.png",
			"ui/bigbg/zhaohuan/bg_dishitian_01.png",
			"ui/bigbg/zhaohuan/bg_megnzhidui.png",
			"ui/bigbg/zhaohuan/bg_mi.png",
			"ui/bigbg/zhaohuan/bg_shikongshenglong.png",
			"ui/bigbg/zhaohuan/bg_tianmanwang.png",
			"ui/bigbg/zhaohuan/bg_xiuer.png",
			"ui/bigbg/zhaohuan/bg_yirenzhixia.png",
			"ui/bigbg/zhaohuan/board_changdi.png",
			"ui/bigbg/zhaohuan/board_huodong_02.png",
			"ui/bigbg/zhaohuan/board_jinglingxinyuandan_01.png",
			"ui/bigbg/zhaohuan/zhaohuan_cy1.png",
			"ui/bigbg/zhaohuan/zhaohuan_jindu_10.png",
			"ui/bigbg/zhaohuan/zhaohuan_jindu_11.png",
			"ui/bigbg/zhaohuan/zhaohuan_jindu_12.png",
			"ui/bigbg/zhaohuan/zhaohuan_jindu_13.png",
			"ui/bigbg/zhaohuan/zhaohuan_jindu_14.png",
			"ui/bigbg/zhaohuan/zhaohuan_jindu_15.png",
			"ui/bigbg/zhaohuan/zhaohuan_jindu_16.png",
			"ui/bigbg/zhaohuan/zhaohuan_jindu_17.png",
			"ui/bigbg/zhaohuan/zhaohuan_jindu_18.png",
			"ui/bigbg/zhaohuan/zhaohuan_jindu_6.png",
			"ui/bigbg/zhaohuan/zhaohuan_jy1.png",
			"ui/bigbg/zhaohuan/zhaohuan_ll1.png",
			"ui/bigbg/zhaohuan/zhaohuan_qj1.png",
			"ui/bigbg/zhaohuan/zhaohuan_sj1.png",
			"ui/bigbg/zhaohuan/zhaohuan_sl1.png",
			"ui/bigbg/zhaohuan/zhaohuan_sy1.png",
			"ui/bigbg/zhaohuan/zhaohuan_yq1.png",
			"ui/bigbg/zhaohuan/zhaohuan_zh1.png",
			"ui/bigbg/zhounianqiandao/zhounian_qd_1.png",
			"ui/bigbg/zhounianqiandao/zhounian_qd_10.png",
			"ui/bigbg/zhounianqiandao/zhounian_qd_2.png",
			"ui/bigbg/zhounianqiandao/zhounian_qd_3.png",
			"ui/bigbg/zhounianqiandao/zhounian_qd_4.png",
			"ui/bigbg/zhounianqiandao/zhounian_qd_5_1.png",
			"ui/bigbg/zhounianqiandao/zhounian_qd_5_2.png",
			"ui/bigbg/zhounianqiandao/zhounian_qd_6_1.png",
			"ui/bigbg/zhounianqiandao/zhounian_qd_6_2.png",
			"ui/bigbg/zhounianqiandao/zhounian_qd_6_3.png",
			"ui/bigbg/zhounianqiandao/zhounian_qd_7_1.png",
			"ui/bigbg/zhounianqiandao/zhounian_qd_7_2.png",
			"ui/bigbg/zhounianqiandao/zhounian_qd_8_1.png",
			"ui/bigbg/zhounianqiandao/zhounian_qd_8_2.png",
			"ui/bigbg/zhounianqiandao/zhounian_qd_9_1.png",
			"ui/bigbg/zhounianqiandao/zhounian_qd_9_2.png"
		}
	}

	self._resLoader:setResPaths(self._resourcesList[index])
	self._resLoader:load(function()
		self._res = self._res or {}
		self._res[index] = self._res[index] or {}

		for i = 1, #self._resourcesList[index] do
			self._res[index][i] = self._resLoader:getResource(self._resourcesList[index][i])
		end

		if _call_back then
			_call_back()
		end
	end, nil, self)
end

function GMView:_clearRes()
	if self._resLoader then
		GameUtil.unloadMultiResLoaderResource(self._resLoader)

		self._resLoader = nil
	end

	if self._res then
		for k, v in pairs(self._res) do
			for i = 1, #self._res[k] do
				if self._res[k][i] ~= nil then
					self._res[k][i] = nil
				end
			end

			self._res[k] = nil
		end

		self._res = nil
	end
end

function GMView:testTime()
	local timeTable1 = GameUtil.parseToTimeTable("2018-08-07 10:43:33")
	local timeTable2 = GameUtil.parseToTimeTable("2099-08-07 10:43:33")
	local timeStr1 = os.date("%Y-%m-%d %X", os.time(timeTable1))
	local timeStr2 = os.date("%Y-%m-%d %X", os.time(timeTable2))

	TipsFacade.instance:openPopupWindow(lang("tip"), "测试时间按配置显示值：\n" .. timeStr1 .. "\n" .. timeStr2)
end

function GMView:testTimecheat(arr)
	local str

	if #arr == 2 then
		str = arr[2]
	elseif #arr == 3 then
		str = arr[2] .. " " .. arr[3]
	end

	if str then
		local timeTable1 = GameUtil.parseToTimeTable(str)
		local timeSecs = os.time(timeTable1)

		print(">>>>>>>>>>>>>>>>>>>>>>>> testTimecheat ", str, timeSecs)
		ServerTime.sync(timeSecs)
		GlobalDispatcher:dispatch(GlobalNotify.ServerTimeSync)
	end
end

function GMView:testRed(arr)
	local function color(clr, str)
		return "<color=" .. clr .. ">" .. str .. "</color>"
	end

	local pink = "#ff00ff"
	local green = "#008500"
	local red = "#ff0000"
	local yellow = "#B4AB3B"
	local yes = color(green, "√")
	local no = color(red, "×")
	local searchMode = 0
	local command = arr[2]

	searchMode = string.nilorempty(command) and 0 or (command == "c" or command == "client") and 1 or (command == "s" or command == "server") and 2 or 3

	local map = RedPointModel.instance._infoDic
	local redIds = {}

	if searchMode == 0 then
		for _, info in pairs(map) do
			table.insert(redIds, info.redPointId .. "")
		end
	elseif searchMode == 1 then
		for _, info in pairs(map) do
			if checknumber(info.redPointId) <= 0 then
				table.insert(redIds, info.redPointId .. "")
			end
		end
	elseif searchMode == 2 then
		for _, info in pairs(map) do
			if checknumber(info.redPointId) > 0 then
				table.insert(redIds, info.redPointId .. "")
			end
		end
	elseif searchMode == 3 then
		for i = 2, #arr do
			local input = string.gsub(arr[i] .. "", "[,.;:#]", " ")

			input = string.gsub(input, "%s+", "#")

			local ids = string.split(input, "#")

			for _, id in ipairs(ids) do
				if not string.nilorempty(id) then
					table.insert(redIds, id)
				end
			end
		end
	end

	if searchMode == 0 then
		-- block empty
	elseif searchMode == 1 then
		-- block empty
	elseif searchMode == 2 then
		-- block empty
	elseif searchMode == 3 then
		-- block empty
	end

	local redGos = {}
	local redTemp = {}

	for _, id in ipairs(redIds) do
		redTemp[id] = id
	end

	for go, arr in pairs(RedPointController.instance.redpointPool) do
		for _, id in ipairs(arr) do
			local redId = id .. ""

			redGos[redId] = redGos[redId] or {}

			local a, b = string.find(redId, RedPointController.REV_PRE_KEY)

			if a == 1 and b == self.REV_KEY_LEN then
				redId = string.sub(redId, a, b)
			end

			if redId == redTemp[redId] then
				table.insert(redGos[redId], go)
			end

			if redId ~= redTemp[redId] then
				if searchMode == 0 then
					table.insert(redIds, redId)
				elseif searchMode == 1 then
					if checknumber(redId) <= 0 then
						table.insert(redIds, redId)
					end
				elseif searchMode == 2 and checknumber(redId) > 0 then
					table.insert(redIds, redId)
				end
			end
		end
	end

	table.sort(redIds, function(a, b)
		if checknumber(a) == checknumber(b) then
			return false
		end

		return checknumber(a) < checknumber(b)
	end)

	local str = ""
	local cont1 = ""
	local cont2 = ""
	local cont3 = ""
	local now = ServerTime.now() * 1000
	local nowT = os.date("*t", ServerTime.now())
	local nowStr = string.format("%02d年 %02d月 %02d日 %02d时 %02d分 %02d秒", nowT.year, nowT.month, nowT.day, nowT.hour, nowT.min, nowT.sec)

	cont1 = cont1 .. color(pink, "现在时间是 : " .. nowStr .. "\n")

	if searchMode == 0 then
		cont1 = cont1 .. "<全局搜索> "
	elseif searchMode == 1 then
		cont1 = cont1 .. "<前端搜索> "
	elseif searchMode == 2 then
		cont1 = cont1 .. "<后端搜索> "
	elseif searchMode == 3 then
		cont1 = cont1 .. "<特定搜索> "
	end

	cont1 = cont1 .. string.format("一共搜索了[%s]个红点\n\n", color(pink, #redIds))

	for _, id in ipairs(redIds) do
		local info = map[id]
		local temp = ""
		local isActive = RedPointModel.instance:isActive(id)
		local nameStr = (checknumber(id) <= 0 and "前端" or "后端") .. "id[" .. color(yellow, id) .. "]"
		local isActiveStr = " 激活:[" .. (isActive and yes or no) .. "]"

		if info then
			if not (" 状态:[" .. (info.isActivated and yes or no) .. "]") then
				local stateStr = " (未注册)"

				temp = nameStr .. isActiveStr .. stateStr .. "\n"

				if searchMode == 3 then
					if info ~= nil then
						local showT, endT = os.date("*t", checknumber(info.showTime) / 1000), os.date("*t", checknumber(info.endTime) / 1000)
						local showTime = string.format("%02d-%02d-%02d", showT.year, showT.month, showT.day)
						local endTime = string.format("%02d-%02d-%02d", endT.year, endT.month, endT.day)
						local notPassTime = not info.endTime or info.endTime == 0 or now < tonumber(info.endTime)

						if info.showTime and info.showTime ~= 0 then
							if info.showTime then
								local afterShowTime = now > tonumber(info.showTime)
								local activateTime = notPassTime and afterShowTime and yes or no
								local isUseDefault = info.endTime == 0 and info.showTime == 0

								if isUseDefault == false then
									temp = temp .. "激活期:[" .. activateTime .. "] " .. showTime .. " 至 " .. endTime .. "\n"
								end
							end
						end
					end

					if checknumber(id) > 0 then
						local cfg = RedPointConfig.instance:getCfgById(checknumber(id))

						if cfg and not string.nilorempty(cfg.funcIds) then
							local opIds, clIds = "", ""

							for _, v in ipairs(string.split(cfg.funcIds, "#")) do
								local funcId = checknumber(v)
								local isOpen = FuncOpenModel.instance:getFuncIsOpen(funcId)

								if isOpen == true then
									opIds = opIds .. funcId
								else
									clIds = clIds .. funcId
								end
							end

							temp = temp .. "关联的功能ids:[" .. cfg.funcIds .. "] " .. "已开启:[" .. color(green, opIds) .. "] " .. "未开启:[" .. color(red, clIds) .. "]\n"
						end
					end

					if redGos[id] then
						for index, redGo in ipairs(redGos[id]) do
							local go = redGo
							local path = ""

							while true do
								path = go.name .. path

								if go.transform.parent then
									go = go.transform.parent.gameObject
									path = "/" .. path
								else
									break
								end
							end

							temp = temp .. string.format("注册路径%s:[%s]\n", index, path)
						end
					end
				end

				if string.len(cont2) >= 18000 then
					cont2 = cont2 .. "超过限制，无法打印后续" .. "\n"

					break
				else
					cont2 = cont2 .. temp .. (searchMode ~= 3 and "" or "\n")
				end
			end
		end
	end

	if searchMode == 3 then
		cont3 = cont3 .. "\n----------提示----------\n" .. "--[激活],若[" .. yes .. "]则红点亮，[" .. no .. "]则不亮\n" .. "--[状态],若状态是[" .. yes .. "],但[激活]是[" .. no .. "]，可能是前端另作了逻辑判断\n" .. "--[激活期],激活期内才能被激活，否则是前端另作了逻辑判断\n" .. "--[关联的功能ids],后端id才有，在h红点配置表配置，开启才能被激活，否则是前端另作了逻辑判断\n" .. "--[注册路径],红点对应的预制体路径，同一红点id可能对应多个预制体\n" .. "\n----------红点测试使用方法----------\n" .. "--[全局搜索],直接输入'redpoint'、'rd'、'红点',则全局搜索所有红点\n" .. "--[前端搜索],'redpoint'、'rd'、'红点' + 'c'或'client'\n" .. "--[后端搜索],'redpoint'、'rd'、'红点' + 's'或'server'\n" .. "--[特定搜索],'redpoint'、'rd'、'红点'加符号隔开的id,符号包括[空格,.;:#]\n" .. "--[示例1] rd\n" .. "--[示例2] rd -29 80 152\n" .. "--[示例3] rd -29#80#152\n"
	end

	str = str .. cont1 .. cont2 .. cont3

	TipsFacade.instance:openTipWindowNoX("红点测试", str)
end

function GMView:openGMRedPointView(arr)
	local param = ""

	for i = 2, #arr do
		if not string.nilorempty(arr[i]) then
			param = i < #arr and param .. arr[i] .. " " or param .. arr[#arr]
		end
	end

	UIStateManager.instance:push(ViewName.GMRedPointView, param)
end

function GMView:testContract(arr)
	return
end

function GMView:_playStroyBattle(arr)
	local str = arr[2]
	local fileNames = string.split(str, "#")

	if #fileNames == 3 then
		local paths = {}

		for i, v in ipairs(fileNames) do
			table.insert(paths, "scene/battle/local/" .. v .. ".txt")
		end

		BattleController.instance:startLocalBattle(paths[1], paths[2], paths[3])
	end
end

function GMView:_selectSummonPet(masterId)
	local petMo = MaterialMgr.getModel(MatType.Pet, masterId)
	local arr = ContractConfig.instance._contractCfg.dataList
	local summList = {}

	for i, cc in ipairs(arr) do
		if not cc.summonMasterRaceIds then
			if table.indexof(cc.summonMasterRaceIds, petMo.raceId) ~= false then
				local summonedRaceIds = cc.summonedRaceIds

				for j, v in ipairs(summonedRaceIds) do
					table.insert(summList, v)
				end
			end
		end
	end

	local function onSeletCallBack(data)
		if data then
			printError(">>>>>>>>已经没有这个功能了")
		end
	end

	local function filterFunc(petData)
		if petData.summonMasterId <= 0 then
			local raceId = petData.raceId

			return table.indexof(summList, raceId) ~= false
		end

		return false
	end

	PetSelectController.instance:OpenView(1, "选召唤兽！", filterFunc, onSeletCallBack, nil)
end

function GMView:_testShowAllIcon()
	if self.rcdFcFunc == nil then
		self.rcdFcFunc = FuncOpenController.instance.getFuncIsOpenByCfg
		self.rcdFcFunc2 = FuncOpenController.instance.getConditionReached
		self.rcdAdFunc = ActivityDefineController.instance.isInActivityTimeById

		function FuncOpenController.instance:getFuncIsOpenByCfg(a)
			return true
		end

		function FuncOpenController.instance:getConditionReached(a, b)
			return true
		end

		function ActivityDefineController.instance:isInActivityTimeById(a, b)
			return true
		end
	else
		FuncOpenController.instance.getFuncIsOpenByCfg = self.rcdFcFunc
		FuncOpenController.instance.getConditionReached = self.rcdFcFunc2
		ActivityDefineController.instance.isInActivityTimeById = self.rcdAdFunc
		self.rcdFcFunc = nil
		self.rcdFcFunc2 = nil
		self.rcdAdFunc = nil
	end
end

function GMView:openWeb()
	local url = "http://account.100bt.com/gameBind/index.html"

	UnityWebBridge.registerGetActionListener(function(result)
		UnityWebBridge.unregisterGetActionListener()

		local cb = result.callback
		local tar = result.target

		if tar == "userInfo" then
			local tb = {}

			tb.gameId = SDKManager.getGameId()
			tb.roleId = LoginModel.instance.userId

			UnityWebBridge.registerPostActionListener(function(res)
				UnityWebBridge.unregisterPostActionListener()
			end)
			UnityWebBridge.callbackWebView(cb, tb)
		end
	end)
	UnityWebBridge.openWebView(url, false)
end

function GMView:openInnerWeb(arr)
	local url = arr[2]

	if not string.nilorempty(url) then
		InnerWebController.instance:openWebView(url)
	else
		InnerWebController.instance:openWebView("https://noticemgr.100bt.com/staticpage/index.html")
	end
end

function GMView:_handleRRMY(str, arr)
	local strArray = string.split(str, "-")

	if #strArray > 2 then
		if strArray[2] == "FAST" then
			if strArray[3] then
				if strArray[3] == "STOP" then
					RankRaceController.instance:operView(ViewName.RankRaceMyInfoView, function(_view)
						_view:testPetStop()
					end)
				else
					RankRaceController.instance:operView(ViewName.RankRaceMyInfoView, function(_view)
						_view:testPetFastTimer(tonumber(strArray[3]))
					end)
				end
			else
				error("缺少id")
			end
		end
	else
		local raceId = tonumber(string.sub(str, 6))

		if raceId then
			RankRaceController.instance:operView(ViewName.RankRaceMyInfoView, function(_view)
				_view:testPet(raceId)
			end)
		else
			error("没有这个 id = " .. str .. raceId)
		end
	end
end

function GMView:_handleTabBg(arr)
	local viewConfig = {
		tabViewName = "测试面板",
		tabInfo = {
			{
				name = "测试1",
				view = ViewName.Testtab1View,
				hideCallBack = function()
					print("隐藏了测试1")
				end,
				showCallBack = function()
					print("展示了测试1")
				end,
				closeCallBack = function()
					print("关闭了测试1")
				end,
				redPointCheck = function()
					self.test_tabbg_count = self.test_tabbg_count or 0
					self.test_tabbg_count = self.test_tabbg_count + 1

					return self.test_tabbg_count % 2 == 0
				end
			},
			{
				name = "tab2",
				view = ViewName.Testtab2View,
				hideCallBack = function()
					print("隐藏了tab2")
				end,
				showCallBack = function()
					print("展示了tab2")
				end,
				closeCallBack = function()
					print("关闭了tab2")
				end,
				redPointCheck = function()
					self.test_tabbg_count = self.test_tabbg_count or 0

					return self.test_tabbg_count % 3 ~= 0
				end
			},
			{
				name = "TAB3",
				view = ViewName.Testtab3View,
				hideCallBack = function()
					print("隐藏了TAB3")
				end,
				redPointCheck = function()
					self.test_tabbg_count = self.test_tabbg_count or 0

					return self.test_tabbg_count % 5 ~= 0
				end
			}
		},
		tabCloseCallBack = function()
			print("整个面板关闭")
		end,
		tabOpenCallBack = function()
			print("整个面板打开")
		end
	}

	TabbgController.instance:onOpenTabView(viewConfig)
end

function GMView:_handleTabBgTab(_index)
	if not _index then
		return
	end

	if _index == 1 then
		local tabView, _ = TabbgController.instance:getTabView()

		tabView:setActiveComp(TabbgView.goldBarConComp, false)
		tabView:setActiveComp(TabbgView.tableViewComp, false)
		tabView:setActiveComp(TabbgView.topLeftComp, false)
	elseif _index == 2 then
		for view_index = 1, 3 do
			local tabView, presentor = TabbgController.instance:getTabView(view_index)

			if tabView and tabView.setImageActive then
				tabView:setImageActive(false)
			end

			if presentor and presentor.toString then
				presentor:toString()
			end
		end
	elseif _index == 3 then
		local tabView, _ = TabbgController.instance:getTabView()

		tabView:setUpdateRedPointAllTime(1)
	end
end

function GMView:_testMemory(arr)
	local isMemEnough = UnityEngine.SystemInfo.systemMemorySize > 3000

	if isMemEnough then
		FloatWordMgr.instance:show("test_memory_2 =", UnityEngine.SystemInfo.systemMemorySize)
	else
		FloatWordMgr.instance:show("test_memory_1 =", UnityEngine.SystemInfo.systemMemorySize)
	end
end

function GMView:_handleTreasurePoint(arr)
	local _scene = SceneMgr.instance:getCurScene()
	local birthPosx = math.floor(_scene:getBornX())
	local birthPosy = math.floor(_scene:getBornZ())

	if _scene then
		local _wholeScene = _scene.stage.wholeScene
		local point = {}
		local count = 0

		while count < 30 do
			local x, y = _wholeScene:GetRandomWalkablePosInZone(nil, 1, nil, nil)

			x = math.floor(x)
			y = math.floor(y)

			if x ~= birthPosx or y ~= birthPosy then
				local finded = false

				for i, v in ipairs(point) do
					if v.x == x and v.y == y then
						finded = true

						break
					end
				end

				if not finded then
					table.insert(point, {
						x = x,
						y = y
					})

					count = count + 1
				end
			end
		end

		local _posStrX = ""
		local _posStrY = ""
		local _posStr = ""

		for i, v in ipairs(point) do
			_posStrX = _posStrX .. v.x .. "\n"
			_posStrY = _posStrY .. v.y .. "\n"
			_posStr = _posStr .. "[" .. v.x .. "," .. v.y .. "]\n"
		end

		print("寻宝坐标 X:\n", _posStrX)
		print("寻宝坐标 Y:\n", _posStrY)
		print("寻宝坐标 :\n", _posStr)
	end
end

function GMView:changePlayerModel(arr)
	usingnow("logic.extensions.dress.agent.ClothesAgent", "ClothesAgent")

	if #arr > 1 then
		local idx = checknumber(arr[2])

		ClothesAgent.instance:sendSetMyAvatarReq({
			idx
		})
	else
		ClothesAgent.instance:sendSetMyAvatarReq({
			1
		})
	end
end

function GMView:passNew(arr)
	local lastBranch

	if #arr > 1 then
		lastBranch = string.splitToNumber(arr[2], "#")
	end

	local list = {}
	local allCfg = GuideConfig.instance:getGuideConfig()

	for branch, conf in pairs(allCfg) do
		if checknumber(branch) > 0 then
			if lastBranch and table.indexof(lastBranch, checknumber(branch)) ~= false then
				for k, v in pairs(conf) do
					print(">>>>>>>>>>>>>>>>>", v.taskLimit)

					v[6] = 0
					v[7] = nil
					v[8] = nil

					print(">>>>>>>>>>>>>>>>>", v.taskLimit)
				end

				table.insert(list, {
					cid = 1,
					bid = branch
				})
				GuideModel.instance:updateSvrGuideData(branch, 1, true)
			else
				table.insert(list, {
					cid = -1,
					bid = branch
				})
				GuideModel.instance:updateSvrGuideData(branch, -1)
			end
		end
	end

	GuideController.instance:sendToSave(list)

	if LoginModel.instance.userId then
		UnityEngine.PlayerPrefs.SetString("guideInfos_" .. LoginModel.instance.userId, "")
	end

	GuideModel.instance._currGuides = {}
	GuideModel.instance._branSequeces = {}

	GuideController.instance:loadGuideInit(GuideModel.instance.svrGuideList)
end

function GMView:gmGoto(arr)
	if #arr > 1 then
		GotoMgr.gotoByString(arr[2])
	end
end

function GMView:deletePet(arr)
	local function onSeletCallBack(data)
		if data then
			GMAgent.instance:sendPM_DeletePetsReq(data, function(msg)
				TipsFacade.instance:openTipWindow("提示", "删除成功")
			end)
		end
	end

	local function filterFunc(petData)
		return true
	end

	PetSelectController.instance:OpenView(10, "小心点！！！现在是删精灵", filterFunc, onSeletCallBack, nil)
end

function GMView.getMaxPetMo(raceId, faceId)
	local bagPet = BagPetMo.New()

	bagPet.isMyPackPet = false
	bagPet.raceId = raceId
	bagPet.curFaceId = checknumber(faceId)

	if checknumber(bagPet.curFaceId) == 0 then
		bagPet.curFaceId = checknumber(raceId)
	end

	bagPet:setAttrMo()

	local petCo = CharacterConfig.instance:getPetCo(raceId)

	bagPet.level = petCo.maxLv
	bagPet.awakeLevel = FightingPowerPetMo._getMaxAwakenLevel(raceId) or 1
	bagPet.awakenLv = bagPet.awakeLevel
	bagPet.talentLevel = FightingPowerPetMo._getMaxTalentLevel(raceId) or 1
	bagPet.equipments = FightingPowerFormula.instance:parsEequipmentsClient("&100", raceId, bagPet.curFaceId)
	bagPet.teamInfo = {
		isMax = true
	}
	bagPet.contractSkillId = 0

	local skillLevelStrategyId = petCo.skillLevelStrategyId

	bagPet.normalSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, 1)
	bagPet.ultimateSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, 2)
	bagPet.passiveSkillLv = CharacterConfig.instance:getMaxSkillLevelCfgById(skillLevelStrategyId, 3)
	bagPet.rare = CharacterConfig.instance:getRareByAwakenLv(0, bagPet.raceId)
	bagPet.assistTeamInfoList = {}
	bagPet.assistTeamInfoList.assistTeamInfo = {}

	local petCfgList = CharacterConfig.instance:getPetCfg()

	for type = 1, 7 do
		local info = {}

		info.type = type
		info.level = 100
		info.assistPetDetailList = {}

		local list = {}

		for _, petCfg in ipairs(petCfgList) do
			if petCfg.raceId < 20000 and checknumber(petCfg.bookIds) > 0 and PetSkinConfig.instance:checkHasEleAttr(petCfg.raceId, type) then
				table.insert(list, petCfg)
			end
		end

		ArraySort.sortOn(list, "evaluateLevel")
		print(">>>>>>>>>>>>TTTTTTTTTTTT", type)

		for j = 1, 6 do
			if list[j] then
				local petInfo = {}

				petInfo.raceId = list[j].raceId
				petInfo.awakenLv = CharacterConfig.instance:getMaxAwaken(list[j].raceId)
				petInfo.petLv = list[j].maxLv

				print(">>>>>>>>>>>>TTTTTTTTTTTT>>>>>>>>>>>>>", petInfo.raceId, list[j].name)
				table.insert(info.assistPetDetailList, petInfo)
			end
		end

		print(">>>>>>>>>>>>EEEEEEEEEEEEEEEEEE>>>>>>>>>>>>>")
		table.insert(bagPet.assistTeamInfoList.assistTeamInfo, info)
	end

	bagPet.mountInfo = {
		isMax = true
	}
	bagPet.collectRelationIds = CharacterConfig.instance:getBondCfgsCollectIds(raceId)
	bagPet.throneList = {}

	local throneList = ThroneConfig.instance:getThroneCfgs()

	for i, v in ipairs(throneList) do
		local th = {}

		th.throneId = v.id
		th.lv = 15

		table.insert(bagPet.throneList, th)
	end

	bagPet.goodFeelingInfos = {}

	for _, petCfg in ipairs(petCfgList) do
		if petCfg.raceId < 20000 and checknumber(petCfg.bookIds) > 0 then
			local hdCfg = HandbookConfig.instance:getPetDetailsCfgById(petCfg.raceId)

			if hdCfg then
				local lvPropCfgs = GoodFeelConfig.instance:getLvPropCfgs(hdCfg.propertyPlan)

				if lvPropCfgs then
					local maxUnlockLv = 0

					for i, ssCfg in pairs(lvPropCfgs) do
						maxUnlockLv = math.max(maxUnlockLv, ssCfg.unlockLv)
					end

					table.insert(bagPet.goodFeelingInfos, {
						raceId = petCfg.raceId,
						level = maxUnlockLv
					})
				end
			else
				printError(">>>>>>>>>>>>>>>>>>>>>此精灵在精灵基础信息配置了 bookIds 有值  但没有图鉴信息表却找不到它的配置：", petCfg.raceId)
			end
		end
	end

	bagPet.starGodPlusSlots = {}

	local petCo = MaterialMgr.getMatCfg(MatType.Pet, raceId) or {}
	local petskinCfg = PetSkinConfig.instance:getPetSkinCfg(bagPet.curFaceId)
	local starIds = petskinCfg.recommendClient

	for i, v in ipairs(starIds) do
		if StargodplusConfig.instance:getFillerCfg(v) then
			local star = {}

			star.slot = i

			local _, exp = StargodplusModel.instance:getMaxSlotLevel(i)

			star.exp = exp
			star.fillerDefineId = v

			table.insert(bagPet.starGodPlusSlots, star)
		else
			printError(">>>>>>>>>>>>>>>>>>>> 配置的推荐星神错误，faceId_starId:", bagPet.curFaceId, v)
		end
	end

	bagPet.benefitInfoList = {}
	bagPet.benefitInfoList.benefitInfo = {}

	local map = {}
	local map2 = {}

	print(">>>>>>>>>>>>>>> bbbbbbbbbbbbbbb ==========================")

	for _, cfg in ipairs(petCfgList) do
		local petDetail = HandbookConfig.instance:getPetDetailsCfgById(cfg.raceId)

		if (not petDetail or petDetail.unproved ~= 1) and not string.nilorempty(cfg.bookIds) then
			print(">>>>>>>>>>>>>>> bbbbbbbbbbbbbbb ", cfg.raceId, cfg.name)

			if BagPetsController.instance:getPetNumByRaceId(cfg.raceId) == 0 then
				print(">>>>>>>>>>>>>>> <color=#ff0000>bbbbbbbbbbbbbbb </color> ", cfg.raceId, cfg.name)
			end

			local manualBenefitId = cfg.manualBenefitId

			if cfg.awakenCostStrategyId < 0 then
				local info = map2[manualBenefitId]

				if info == nil then
					info = {}

					table.insert(bagPet.benefitInfoList.benefitInfo, info)
				end

				info.benefitId = manualBenefitId
				info.benefitLv = 0
				info.num = checknumber(info.num) + 1
				map2[manualBenefitId] = info
			else
				local info = map[manualBenefitId]

				if info == nil then
					info = {}

					table.insert(bagPet.benefitInfoList.benefitInfo, info)
				end

				info.benefitId = manualBenefitId
				info.benefitLv = 6
				info.num = checknumber(info.num) + 1
				map[manualBenefitId] = info
			end
		end
	end

	print(">>>>>>>>>>>>>>> bbbbbbbbbbbbbbb ==========================")

	bagPet.formStrength = {}
	bagPet.formStrength.formStrengths = {}

	for i = 1, 8 do
		local info = {}

		info.formStrengthId = i
		info.formStrengthLv = 20

		table.insert(bagPet.formStrength.formStrengths, info)
	end

	bagPet:calcAllAttr()

	return bagPet
end

function GMView.onSeletCallBack(petId, petIds, fullPublicStrengthens)
	local function comStr(name, v1, v2)
		local str

		return checknumber(v1) ~= checknumber(v2) and v1 .. "" ~= v2 .. "" and name .. v1 .. "(<color='#ff0000'>" .. v2 .. "</color>) " or name .. v1 .. "(" .. v2 .. ") "
	end

	local serverMap = {
		TALENT = "talentAttr",
		STAR_GOD_PLUS = "starGodPlusAttr",
		DECORATION = "decorationAttr",
		TEAM = "petTeamAttr",
		COLLECT_RELATION = "petRelationAttr",
		HOSHIGAMI = "petHoshigamiAttr",
		HOLY_STRIPE = "petHolyStripesAttr",
		EXT = "extAttr",
		SKIN = "petSkinAttr",
		RACE = "baseAttr",
		EQUIPMENT = "equipAttr",
		RUNE = "runeAttr",
		GOOD_FEELING = "petGoodfellingAttr",
		ASSIST_TEAM = "assistAttr",
		AWAKEN = "awakenAttr",
		PET_MANUAL_BENEFIT = "handbookAttr",
		FORMATION = "formStrengthAttr",
		SKILL = "",
		MOUNT = "mountAttr",
		THRONE = "petThroneAttr"
	}

	local function getClicntAttrs(attrMo, key)
		local attr = serverMap[key]

		if attr then
			return attrMo[attr]
		end
	end

	if petId then
		GMAgent.instance:sendPM_GetUserPetPropertyReq(petId, fullPublicStrengthens, function(msg)
			local tb = GameUtil.pbToTable(msg.basePropertyView)
			local tb2 = GameUtil.pbToTable(msg.extPropertyView)
			local tb3 = GameUtil.pbToTable(msg.partProperties)
			local tb4 = GameUtil.pbToTable(msg.partCurZdl)
			local tb5 = GameUtil.pbToTable(msg.partMaxZdl)
			local petMo = BagPetsController.instance:getPet(petId)

			if fullPublicStrengthens then
				petMo = petMo:usePublicStrengths()
			end

			local str = ""

			str = str .. comStr("战:", msg.curZdl, petMo:getFightingPower())
			str = str .. comStr("战Max:", msg.maxZdl, petMo:getMaxFightingPower())

			local maxMo = FightingPowerPetMo.getRealMaxPetMo(petMo.raceId, petMo.curFaceId)

			str = str .. comStr("战MaxMax:", msg.maxZdl, maxMo:getFightingPower())

			print(">>>>>>>>>>>ssssssssssssss开始对比前后端收集羁绊")

			for i, v in ipairs(petMo.collectRelationIds or {}) do
				if table.indexof(maxMo.collectRelationIds, v) == false then
					print(">>>>>>>>后端羁绊>>>>>>>>>", i, v)
				end
			end

			print(">>>>>>>>>>>ssssssssssssss")

			for i, v in ipairs(maxMo.collectRelationIds or {}) do
				if table.indexof(petMo.collectRelationIds, v) == false then
					print(">>>>>>>>后端羁绊>>>>>>>>>", i, v)
				end
			end

			print(">>>>>>>>>>>ssssssssssssss结束对比前后端收集羁绊")
			petMo.attrMo:compare(maxMo.attrMo)
			print(">>>>>>>>>>>ssssssssssssss结束对比前后端 好感度222222222")

			local tmpG = {}

			for i, v in ipairs(maxMo.goodFeelingInfos or {}) do
				tmpG[v.raceId] = v.level
			end

			local temp = {}

			for raceId, unlockLv in pairs(GoodFeelModel.instance._raceId2UnlockLv) do
				temp[raceId] = unlockLv

				if tmpG[raceId] == nil then
					print(">>>>>>>>>>>>>>>> 前端少， 好感度 没有：", raceId, unlockLv)
				elseif tmpG[raceId] ~= unlockLv then
					print(">>>>>>>>>>>>>>>> 前端少， 好感度 不等：", raceId, unlockLv)
				end
			end

			print(">>>>>>>>>>>ssssssssssssss")

			for raceId, v in ipairs(tmpG) do
				if temp[raceId] == nil then
					print(">>>>>>>>>>>>>>>> 后端少， 好感度 没有：", raceId, v)
				elseif temp[raceId] ~= v then
					print(">>>>>>>>>>>>>>>> 后端少， 好感度不等：", raceId, v)
				end
			end

			print(">>>>>>>>>>>ssssssssssssss结束对比前后端好感度2222222222222")
			print(">>>>>>>>>>>ssssssssssssss结束对比前后端 图鉴ppppppppp22222222")

			local temp1 = {}

			for raceId, lvl in pairs(HandbookModel.instance._attributeMap or {}) do
				if lvl >= 0 then
					local petCo = CharacterConfig.instance:getPetCo(raceId)

					if petCo and checknumber(petCo.bookIds) ~= 0 and HandbookModel.instance:isHasPet(raceId) then
						local manualBenefitId = petCo.manualBenefitId

						temp1[manualBenefitId .. "_" .. lvl] = checknumber(temp1[manualBenefitId .. "_" .. lvl]) + 1
					end
				end
			end

			local temp2 = {}

			for i, info in ipairs(maxMo.benefitInfoList.benefitInfo) do
				local lvl = info.benefitLv

				if lvl >= 0 then
					local benefitId = info.benefitId

					temp2[benefitId .. "_" .. lvl] = info.num
				end
			end

			for k, v in pairs(temp1) do
				if checknumber(v) ~= checknumber(temp2[k]) then
					print(">>>>>>>>>>>>>>>> 图鉴p", k, v, temp2[k])
				end
			end

			print(">>>>>>>>>>>ssssssssssssss")

			for k, v in pairs(temp2) do
				if checknumber(v) ~= checknumber(temp1[k]) then
					print(">>>>>>>>>>>>>>>> 图鉴p", k, v, temp1[k])
				end
			end

			print(">>>>>>>>>>>ssssssssssssss结束对比前后端 图鉴ppppppppp22222222")

			str = str .. comStr("hp:", tb.maxHp, petMo._maxHp)
			str = str .. comStr("速:", tb.speed, petMo._speed)
			str = str .. comStr("攻击:", tb.attack, petMo._attack)
			str = str .. comStr("物防:", tb.physicalDefence, petMo._physicalDefence)
			str = str .. comStr("魔防:", tb.magicDefence, petMo._magicDefence)
			str = str .. comStr("命中:", string.format("%.6f", tb2.hitRate), string.format("%.6f", petMo._hitRate))
			str = str .. comStr("闪避:", string.format("%.6f", tb2.dodgeRate), string.format("%.6f", petMo._dodgeRate))
			str = str .. comStr("破击:", string.format("%.6f", tb2.strikeRate), string.format("%.6f", petMo._strikeRate))
			str = str .. comStr("格挡:", string.format("%.6f", tb2.blockRate), string.format("%.6f", petMo._blockRate))
			str = str .. comStr("暴击:", string.format("%.6f", tb2.criticalRate), string.format("%.6f", petMo._criticalRate))
			str = str .. comStr("防爆:", string.format("%.6f", tb2.antiCriticalRate), string.format("%.6f", petMo._antiCriticalRate))
			str = str .. comStr("额外战斗力:", string.format("%.6f", tb2.provideZdl), string.format("%.6f", petMo.attrMo._provideZdl))
			str = str .. comStr("额外战斗力万分比:", string.format("%.6f", tb2.provideZdlRate), string.format("%.6f", petMo.attrMo._provideZdlRate))
			str = str .. "\n==========server========="

			for i, v in ipairs(tb3) do
				str = str .. "\n[" .. v.name .. "]\n"

				local base = v.basePropertyView

				for ii, vv in pairs(GameEnum.AttrType) do
					local a = 0

					if vv == GameEnum.AttrType.Hp then
						a = base.maxHp
					elseif vv == GameEnum.AttrType.DefensePhysical then
						a = base.physicalDefence
					elseif vv == GameEnum.AttrType.DefenseMagic then
						a = base.magicDefence
					elseif vv == GameEnum.AttrType.Speed then
						a = base.speed
					elseif vv == GameEnum.AttrType.Attack then
						a = base.attack
					end

					local b = 0
					local attrMo = petMo.attrMo
					local attr = getClicntAttrs(attrMo, v.name)

					if attr then
						b = checknumber(attr[vv])
					end

					if a > 0 or b > 0 then
						str = str .. comStr(ConstString.Attr[vv] .. ":", a, b)
					end
				end
			end

			str = str .. "\n[zdl]\n"

			for i, v in ipairs(tb4) do
				str = str .. v.name .. ":" .. v.value
			end

			str = str .. "\n[maxzdl]\n"

			for i, v in ipairs(tb5) do
				str = str .. v.name .. ":" .. v.value
			end

			str = str .. "\n==========client========="

			local raceId = petMo.raceId

			str = str .. "\n[zdl]\n"

			local value = FightingPowerFormula.instance:getLevelFightingPower(raceId, petMo.level)
			local v1 = FightingPowerFormula.instance:getAwakenFightingPower(raceId, petMo.awakeLevel)
			local v2 = FightingPowerFormula.instance:getGeniusTrainingFightingPower(raceId, petMo.talentLevel)
			local v3 = FightingPowerFormula.instance:getEquipFightingPower(raceId, petMo.curFaceId, petMo.equipments)
			local v5 = FightingPowerFormula.instance:getPetTeamFightingPower(raceId, petMo.teamInfo, petMo.isMyPackPet)
			local v6 = "??"

			str = str .. "race:" .. value .. " awaken:" .. v1 .. " talent" .. v2 .. " equip" .. v3 .. " team" .. v5 .. " mount" .. v6
			str = str .. "\n[maxzdl]\n"

			local value = FightingPowerFormula.instance:getMaxLevelFightingPower(raceId)
			local v1 = FightingPowerFormula.instance:getMaxAwakenFightingPower(raceId)
			local v2 = FightingPowerFormula.instance:getMaxGeniusTrainingFightingPower(raceId)
			local v3 = FightingPowerFormula.instance:getMaxEquipmentFightingPower(raceId)
			local v5 = FightingPowerFormula.instance:getMaxTeamFightingPower(raceId)
			local v6 = "??"

			str = str .. "race:" .. value .. " awaken:" .. v1 .. " talent" .. v2 .. " equip" .. v3 .. " team" .. v5 .. " mount" .. v6

			TipsFacade.instance:openTipWindow(petMo.name .. "[" .. petMo.raceId .. "_" .. petMo.petId .. "]后端（前端）", str)
		end)
	end
end

function GMView:petCompare(arr)
	local fullPublicStrengthens = checkbool(arr[2])

	local function filterFunc(petData)
		return true
	end

	PetSelectController.instance:OpenView(true, "随便选一个精灵，查看数值", filterFunc, function(data)
		GMView.onSeletCallBack(data, nil, fullPublicStrengthens)
	end, nil)
end

GMView.currErrorDetail = nil

function GMView.petCompareForm(arr)
	local detail = GMView.currErrorDetail

	if detail then
		local formPetZdl = detail.formPetZdl
		local list = {}

		for i, v in ipairs(formPetZdl) do
			table.insert(list, v)
		end

		local function filterFunc(petData)
			for i, v in ipairs(list) do
				if v.petId == petData.petId then
					return true
				end
			end

			return false
		end

		local clientZdl = GMView.currErrorDetailClient.formZdl
		local petIds = GMView.currErrorClientPets
		local petStr = table.concat(petIds, ",")

		PetSelectController.instance:OpenView(true, "GM:战力不对，后【" .. detail.formZdl .. "】前[" .. clientZdl .. "]精灵:[" .. petStr .. "]", filterFunc, GMView.onSeletCallBack, nil, nil, nil, BagPetsController.instance:getBagAndBorrowPets())
	end
end

function GMView:changeTimeScale(arr)
	if #arr == 2 then
		UnityEngine.Time.timeScale = checknumber(arr[2])
	end
end

function GMView:testSkippedBattle(arr)
	BattleModel.instance.testSkippedBattle = true
end

function GMView:generateTilingScene(arr)
	TilingSceneMgr.instance:enterRandomScene(120012145, 1, 12, 12)
end

function GMView:generateSeasonSystem(arr)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() == SceneType.SeasonTiling then
		return
	end

	SeasonController.instance:enterSeasonTilingScene()
end

function GMView:enterDomainAdventureScene(arr)
	DomainAdventureController.instance:enterDomainAdventureScene()
end

function GMView:domainAdventureSceneGmTest(arr)
	if arr[2] == "test" then
		GlobalDispatcher:dispatch(GlobalNotify.DomainAdventureSceneOpenTestMode)
	else
		local activityId = checknumber(arr[2])
		local blockId = checknumber(arr[3])
		local incProgress = checknumber(arr[4])

		GMAgent.instance:sendPM_GM_DomainAdventureIncProgressReq(activityId, blockId, incProgress)
	end
end

function GMView:generateSeasonRainbowCircle(arr)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.gridUnitsMgr then
		local bossMo = SeasonModel.instance.bossMo

		bossMo.phaseId = 5

		GlobalDispatcher:dispatch(GlobalNotify.SeasonBossInfoUpdated, 4, 5)
		scene.eventsAnimation:playBoss2Doppelganger()
	end
end

function GMView:generateSeasonJump(arr)
	if #arr == 3 then
		local scene = SceneMgr.instance:getCurScene()

		if scene then
			GMAgent.instance:sendPM_SeasonModePveMapJumpReq(checknumber(arr[2]), checknumber(arr[3]))
		end
	end
end

function GMView:petShow()
	local function filterFunc(petData)
		return true
	end

	local function onSeletCallBack(data)
		local petMo = BagPetsController.instance:getPet(data)

		UIStateManager.instance:open(ViewName.PetDetailView, petMo)
	end

	PetSelectController.instance:OpenView(true, "随便选一个精灵查看展示", filterFunc, onSeletCallBack, nil)
end

function GMView:playMv(arr)
	if #arr == 2 then
		local str = arr[2]

		if not string.find(str, "/") then
			str = "storyconfig/animations/" .. str
		end

		AnimationPlayer.instance:PlayAnim(str, 1, true)
	end
end

function GMView:guideTest(arr)
	if #arr == 3 then
		local guideBranch = GuideBranchFactory.createBranch(checknumber(arr[2]), checknumber(arr[3]))

		GuideController.instance:startGuide(guideBranch)
	end
end

function GMView:sendZouMaDeng(arr)
	local params = string.split(arr[2], ",")
	local id = checknumber(params[1])
	local startTime = checknumber(params[2])
	local endTime = checknumber(params[3])
	local frequency = checknumber(params[4])
	local content = params[5]
	local showdMode_s_Ary = {}

	GMAgent.instance:sendPM_BgmSendBroadcastReq(id, showdMode_s_Ary, startTime, endTime, frequency, content, function()
		printInfo("收到走马灯！！！")
	end)
end

local settingView = usingnow("logic.setting.setting_view")

function GMView:openView(arr, noClose)
	local function check(name)
		if settingView[name] ~= nil then
			return true, name
		end

		for k, v in pairs(settingView) do
			if string.upper(k) == string.upper(name) then
				TipsFacade.instance:openPopupWindow(lang("tip"), langPara("必须告诉你正确配置名字是：\n%s\n不是：\n%s", k, name))

				return true, k
			end
		end

		FloatWordMgr.instance:show("打开面板：没配置！name:" .. name)

		return false
	end

	if #arr == 2 then
		local view = arr[2] .. ""
		local boo, viewName = check(view)

		if boo then
			if noClose then
				ViewMgr.instance:open(viewName)
			else
				UIStateManager.instance:push(viewName)
			end
		end
	elseif #arr == 3 then
		local view = arr[2] .. ""
		local boo, viewName = check(view)

		if boo then
			local str = arr[3] .. ""
			local parms = checknumber(str) ~= 0 and {
				checknumber(str)
			} or GameUtil.jsonToTable(str)

			if noClose then
				ViewMgr.instance:open(viewName, unpack(parms))
			else
				UIStateManager.instance:push(viewName, unpack(parms))
			end
		end
	else
		print("打开面板  参数错误")
	end
end

function GMView:addItems(arr)
	local cId

	if #arr == 2 then
		local mat = arr[2] .. ""

		GMAgent.instance:sendPM_AddMaterialsReq(mat, 0, function()
			FloatWordMgr.instance:show("添加物品成功")
		end)
	else
		print("添加物品  参数错误")
	end
end

function GMView:setChallenge(arr)
	local cId

	if #arr == 2 then
		ChallengeFacade.instance:startChallange((checknumber(arr[2])))
	else
		print("设置在线时间  参数错误")
	end
end

function GMView:setOnlineTime(arr)
	local sec

	if #arr == 2 then
		GMAgent.instance:sendPM_SetOnlineTimeReq(checknumber(arr[2]), function()
			print("设置在线时间成功 handlePM_SetOnlineTimeRes 重登吧")
		end)
	else
		print("设置在线时间  参数错误")
	end
end

function GMView:jumpTask(arr)
	local taskId, stepId

	if #arr == 2 then
		taskId = checknumber(arr[2])

		GMAgent.instance:sendPM_StepOverTaskReq(taskId, function()
			print("跳过任务成功 handlePM_StepOverTaskRes")
		end)
	elseif #arr >= 3 then
		taskId = checknumber(arr[2])

		GMAgent.instance:sendPM_GotoTaskStepReq(taskId, checknumber(arr[3]), function()
			print("跳过任务成功 sendPM_GotoTaskStepReq")
		end)
	else
		print("跳过任务  参数错误")
	end
end

function GMView:playStory(arr)
	for i = 2, #arr do
		local storyId = checknumber(arr[i])

		if storyId > 0 then
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId)
		else
			print("播放剧情  参数错误")
		end
	end
end

function GMView:playNpcChatStory(arr)
	for i = 2, #arr do
		local npcId = checknumber(arr[i])

		if npcId > 0 then
			GlobalController.instance:_checkNpcDefaultStory(npcId)
		else
			print("对话  参数错误")
		end
	end
end

function GMView:_enabledLog(enbaled)
	Framework.CLogger.enableLog = enbaled

	setglobal("enableLog", enbaled)
end

function GMView:parseSceneTrans(arr)
	local sceneId = checknumber(arr[2])

	if sceneId ~= 0 then
		UnlockFacade.dontcheckTaskUnlockScene = true

		SceneFacade.instance:enterCityFromThisScene(sceneId)

		UnlockFacade.dontcheckTaskUnlockScene = nil
	end
end

function GMView:parseFestivalSceneTrans(arr)
	SceneFestivalMgr.instance:exchangeFestival(arr[2] or "default")
end

function GMView:parseGotoNpc(arr)
	local npcId = checknumber(arr[2])

	if npcId ~= 0 then
		local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

		mainPlayer:gotoNpcCrossSceneWithFullScenePath(npcId)
	end
end

function GMView:parsePetIntrod(arr)
	local id = checknumber(arr[2])

	if id ~= 0 then
		ViewMgr.instance:open(ViewName.PetIntroductionView, id)
	end
end

function GMView:parseNpcIntrod(arr)
	local id = checknumber(arr[2])

	if id ~= 0 then
		ViewMgr.instance:open(ViewName.NpcIntrodView, id)
	end
end

function GMView:fengkongTest(arr)
	AntiAddictionController.instance:sendGetRoleInfo()
end

function GMView:enterTreasureRaiderScene(arr)
	TREnterSceneSequenceController.instance:enterScene()
end

function GMView:parseOuterLinkUrl(arr)
	local url = arr[2]

	if not url or #url == 0 then
		url = "https://www.wjx.cn/jq/52610876.aspx"
	end

	UnityEngine.Application.OpenURL(url)
end

function GMView:parseExpedMapPath(arr)
	GMModel.instance:setExpedTilingMapPath(arr[2], checknumber(arr[3]), checknumber(arr[4]))
end

function GMView:showMainPlayerPos(arr)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()
	local px, py = mainPlayer.transform:getPos()

	TipsFacade.instance:openCommonTips("主角坐标  x=" .. px .. "   y=" .. py)
end

function GMView:exportChallengeTeamSpeed(arr)
	local cfgs = ChallengeConfig.instance._creepCfg
	local strs = {}
	local keys = {}

	for k, v in pairs(cfgs) do
		if type(k) == "number" then
			table.insert(keys, k)
		end
	end

	table.sort(keys)
	table.insert(strs, "[16:06:53][ERROR][main] MonsterManager.reload - [,,] monster speeds : \n")

	for i = 1, #keys do
		local cCfg = ChallengeConfig.instance:getCreepCfg(keys[i])
		local teams = {}

		for i, v in pairs(cCfg) do
			local petMo = FightingPowerPetMo.New()

			petMo:fromChallengeCreepCo(v, cCfg)

			petMo.creepName = v.creepsName

			table.insert(teams, petMo)
		end

		local speed = 0

		for k, v in pairs(teams) do
			local petMo = v

			if not petMo.isSummonedPet then
				speed = speed + petMo._speed
			end
		end

		table.insert(strs, keys[i] .. "\t")
		table.insert(strs, speed .. "\n")
	end

	io.writefile("E:/Speed.txt", table.concat(strs))
end

function GMView:exportTowerTeamSpeed(arr)
	local cfgs = WTowerConfig.instance._crpCfg
	local strs = {}
	local keys = {}

	for k, v in pairs(cfgs) do
		if type(k) == "number" then
			table.insert(keys, k)
		end
	end

	table.sort(keys)

	for i = 1, #keys do
		local cCfg = WTowerConfig.instance:getCrpCfg(keys[i])
		local teams = {}

		for i, v in pairs(cCfg) do
			local petMo = FightingPowerPetMo.New()

			petMo:fromChallengeCreepCo(v, cCfg)

			petMo.creepName = v.creepsName

			table.insert(teams, petMo)
		end

		local speed = 0

		for k, v in pairs(teams) do
			local petMo = v

			if not petMo.isSummonedPet then
				speed = speed + petMo._speed
			end
		end

		table.insert(strs, keys[i] .. "_")
		table.insert(strs, speed .. "\n")
	end

	io.writefile("E:/Speed.txt", table.concat(strs))
end

function GMView:completeFuben(arr)
	local chapterId = checknumber(arr[2])
	local stageId = checknumber(arr[3])

	GMAgent.instance:sendPM_PlotPassStageReq(chapterId, stageId, function(msg)
		local cfg = CopyConfig.instance:getStageById(chapterId, stageId)

		PlotCopyController.instance:loadCopyInfo()
		FloatWordMgr.instance:show(string.format("成功达成副本 %s", cfg.stageName))
	end)
end

function GMView:_setPlayerSpeed(spd)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	mainPlayer.transform:setMoveSpeed(spd or 4.5)
end

function GMView:_onClickSearch()
	removetimer(self._onSearchView, self)
	removetimer(self.onSerachItem, self)
	settimer(0.5, self.onSerachItem, self, false)
end

function GMView:_onClickMsg()
	self:_show(false)
	GlobalDispatcher:dispatch(GMModel.Notify.MSGVIEW_CLICK_SHOW)
end

function GMView:_onClickMsgRedPoint()
	self:_show(false)
	GlobalDispatcher:dispatch(GMModel.Notify.MSGVIEW_CLICK_ERROR_TIPS)
end

function GMView:_onClickBtnSpeed()
	UnityEngine.Time.timeScale = 10
end

function GMView:_onClickBtnChange()
	if ReConnectionMgr.instance:isConnected() then
		RoleAgent.instance:sendExitGameReq()
	else
		ReConnectionMgr.instance:returnToLogin()
	end
end

function GMView:onSerachItem()
	local ret = GMModel.instance:searchByStr(self._searchText:GetText())

	if #ret > 0 then
		local descList = {}

		for _, v in ipairs(ret) do
			if not v.ViewName then
				table.insert(descList, v.ViewName)
			end
		end

		self:_onUpdateItemScr(descList, GmEnum.ItemScrType_Prop)
	else
		self:_showLocalSearchToScr(GmEnum.ItemScrType_Prop)
	end
end

function GMView:_onClickClgSearch()
	self:_setClgText(self._clgText:GetText())
	removetimer(self.onSerachItem, self)
	removetimer(self._onSearchView, self)
	settimer(0.5, self._onSearchView, self, false)
end

function GMView:_onSearchView()
	local str = self._clgText:GetText()
	local ret = GMModel.instance:searchByViewStr(str)

	if #ret > 0 then
		local descList = {}

		for _, v in ipairs(ret) do
			if not v.ViewName then
				table.insert(descList, v.ViewName)
			end
		end

		self:_onUpdateItemScr(descList, GmEnum.ItemScrType_Search)
	else
		self:_showLocalSearchToScr(GmEnum.ItemScrType_Command)
	end
end

function GMView:_setClgText(value)
	self._clgText:RemoveOnValueChanged()
	self._clgText:SetText(value)
	GameUtil.setLocalString("GM_SearchChanged", value)
	self._clgText:AddOnValueChanged(self._onClickClgSearch, self)
end

function GMView:_setItemSearchText(value)
	self._searchText:RemoveOnValueChanged()
	self._searchText:SetText(value)
	self._searchText:AddOnValueChanged(self._onClickSearch, self)
end

function GMView:_onClickMoreButton()
	local popupConfig = {}

	popupConfig.displayOpts = {
		"任务测试",
		"战斗",
		"xx",
		"星辉",
		"投诉",
		"福利",
		"远征",
		"三消",
		"勇者之塔",
		"契約",
		"图鉴",
		"战斗阵型",
		"跳一跳",
		"竞技场",
		"平衡球",
		"九宫八阵",
		"源兽捕捉",
		"王者之路",
		"三主宠",
		"最强攻略"
	}
	popupConfig.onSelectIndex = self._onPopupMenuSelectTagIndex
	popupConfig.handlerTarget = self
	popupConfig.showClose = true
	popupConfig.align = 1
	popupConfig.closeInSelect = true
	popupConfig.closeOnClickOutside = true

	TipsFacade.instance:openPopupMenu(popupConfig)
end

function GMView:_onPopupMenuSelectTagIndex(idx)
	if idx == 1 then
		TaskModel.instance.isTesting = true

		ViewMgr.instance:open(ViewName.TaskView)
	elseif idx == 2 then
		UIStateManager.instance:push(ViewName.DebugView)
	elseif idx == 3 then
		-- block empty
	elseif idx == 4 then
		-- block empty
	elseif idx == 5 then
		UIStateManager.instance:push("feedback")
	elseif idx == 6 then
		UIStateManager.instance:push("bonus")
	elseif idx == 7 then
		ExpeditionController.instance:enterView()
	elseif idx == 8 then
		UIStateManager.instance:push(ViewName.warriortower)
	elseif idx == 9 then
		UIStateManager.instance:push("contractView")
	elseif idx == 10 then
		UIStateManager.instance:push("handBookView")
	elseif idx == 11 then
		UIStateManager.instance:push("debugViewBtl")
	elseif idx == 12 then
		UIStateManager.instance:push(ViewName.DebugViewBtl)
	elseif idx == 13 then
		ArenaController.instance:openArenaSafe()
	elseif idx == 14 then
		local levelId = 0
		local sceneId = 10000
		local curScene = SceneMgr.instance:getCurScene()
		local lastSceneType = curScene:getSceneType()
		local lastSceneId = curScene:getSceneId()

		BalanceBallModel.instance:setLastScene(lastSceneType, lastSceneId)
		BalanceBallModel.instance:setLevelId(levelId)
		SceneMgr.instance:enter(SceneType.BalanceBall, sceneId, 0, 0)
	elseif idx == 15 then
		-- block empty
	elseif idx == 16 then
		FloatWordMgr.instance:show("源兽捕捉功能已被移除")
	elseif idx == 17 then
		UIStateManager.instance:push(ViewName.KingRoad)
	elseif idx == 19 then
		UIStateManager.instance:push(ViewName.Sxgamestart)
	elseif idx == 20 then
		-- block empty
	end

	self:_onClickClose()
end

function GMView:_testAB(arr)
	FloatWordMgr.instance:show(tostring(UnityEngine.Application.backgroundLoadingPriority))
	print("Application.backgroundLoadingPriority", tostring(UnityEngine.Application.backgroundLoadingPriority))

	local tab = {
		UnityEngine.ThreadPriority.Low,
		UnityEngine.ThreadPriority.BelowNormal,
		UnityEngine.ThreadPriority.Normal,
		UnityEngine.ThreadPriority.High
	}

	UnityEngine.Application.backgroundLoadingPriority = tab[checknumber(arr[2])]
end

function GMView:_testAnimation(arr)
	AnimationPlayer.play(arr[2])
end

function GMView:_testBattleLogSwtch(arr)
	local rateValue = checknumber(arr[2])

	if rateValue == 0 then
		GMAgent.instance:sendPM_BattleKMPLogSwitchReq(false)
	else
		GMAgent.instance:sendPM_BattleKMPLogSwitchReq(true)
	end
end

function GMView:_testRate(arr)
	local rateValue = checknumber(arr[2])

	if rateValue > 0 then
		HardwareQuality.setFrameRateType(4, false)
		HardwareQuality.setFrameRate(rateValue, false)
	else
		local value = HardwareQuality.getFrameRate()

		FloatWordMgr.instance:show(string.format("当前设置帧率为：%s", value))
	end
end

function GMView:_testQA(arr)
	FloatWordMgr.instance:show(tostring(UnityEngine.QualitySettings.asyncUploadBufferSize) .. "  " .. tostring(UnityEngine.QualitySettings.asyncUploadTimeSlice))
	print("QualitySettings.asyncUpload", tostring(UnityEngine.QualitySettings.asyncUploadBufferSize), tostring(UnityEngine.QualitySettings.asyncUploadTimeSlice))

	UnityEngine.QualitySettings.asyncUploadBufferSize = checknumber(arr[2]) * 2
	UnityEngine.QualitySettings.asyncUploadTimeSlice = checknumber(arr[2])
end

function GMView:_answerProblemSelectTypeReq(typeId)
	local activityId = AnswerFuncConfig.instance:getAnswerFuncActivityId()

	if activityId <= 0 then
		FloatWordMgr.instance:show("不在活动时间范围内")

		return
	end

	if typeId <= 0 then
		FloatWordMgr.instance:show("请输入typeId")

		return
	end

	AnswerFuncController.instance:sendPM_AnswerProblemSelectTypeReq(activityId, typeId)
end

function GMView:_onSelectChallenge(idx)
	local indexTable = {
		17,
		19,
		nil,
		nil,
		nil,
		nil,
		8,
		15,
		16,
		18,
		30,
		31,
		32,
		33,
		34,
		37,
		35,
		36,
		38
	}

	if indexTable[idx] then
		ChallengeFacade.instance:startChallange(indexTable[idx])
	else
		ChallengeFacade.instance:startChallange(idx)
	end

	self:_onClickClose()
end

function GMView:_updateMsgRedPoint()
	local errorStatusNum = GMController.instance:getStatusTypeNumOfMsg(GMController.StatusType.Error)

	if errorStatusNum <= 0 then
		GameUtil.setUIGroupIdx(self._btnMsg._redPoint, 0)
		GameUtil.SetActive(self._btnMsg._redPoint, false)
	else
		GameUtil.setUIGroupIdx(self._btnMsg._redPoint, 1)

		self._btnMsg._txtRedPoint.text = string.format("%s", errorStatusNum)

		GameUtil.SetActive(self._btnMsg._redPoint, true)
	end
end

function GMView:_openRemoteHierarchy()
	UIStateManager.instance:popByName(ViewName.RemotehierarchyView)
	UIStateManager.instance:push(ViewName.RemotehierarchyView)
end

function GMView:_changeSkin(arr)
	if Framework.OSDef.isEditor == false then
		return
	end

	print("切换精灵为")

	local skinId = checknumber(arr[2])

	if skinId > 0 then
		print(string.format("切换精灵为: %s", skinId))

		local data = CharacterConfig.instance:getModelCo(skinId)
		local bustName = data and data.bustName
		local resName = data and data.resName

		function GameUrl.getSpineUrl(rName, eName)
			local dic = GameUrl._handleSpineDic(resName)
			local path = ""

			if not string.nilorempty(eName) then
				path = string.format("character/%s/%s_p.prefab", dic, data.battleResName)
			elseif not string.nilorempty(rName) then
				path = string.format("character/%s/%s_p.prefab", dic, resName)
			end

			if Framework.OSDef.isEditor then
				return GameUrl._checkDefultSpinePath(path)
			end

			return path
		end

		function GameUrl.getSpineUIUrl()
			local dic = GameUrl._handleSpineDic(resName)
			local path = string.format("character/%s/%s-ui_p.prefab", dic, resName)

			if Framework.OSDef.isEditor then
				return GameUrl._checkDefultSpineUIPath(path)
			end

			return path
		end

		function GameUrl.getLihuiSpineUrl()
			local name = data.bustName
			local dic = GameUrl._handleSpineDic(name)
			local path = string.format("lihui_spine/%s/%s_p.prefab", dic, name)

			if Framework.OSDef.isEditor then
				return GameUrl._checkDefultSpinePath(path)
			end

			return path
		end

		function GameUrl.getLihuiSpineUIUrl(tempName)
			local name = resName

			if string.find(tempName, "_beibao_lihui") then
				name = resName .. "_beibao_lihui"
			elseif string.find(tempName, "_lihui") then
				name = resName .. "_lihui"
			end

			local dic = GameUrl._handleSpineDic(name)
			local path = string.format("lihui_spine/%s/%s-ui_p.prefab", dic, name)

			if Framework.OSDef.isEditor then
				return GameUrl._checkDefultSpineUIPath(path)
			end

			return path
		end

		function GameUrl.getSpineAssetRrl()
			local path = string.format("character/%s/%s_skeletondata.asset", resName, resName)

			if Framework.OSDef.isEditor and not GoUtil.IsAssetExist(path) then
				return "character/10002_xiaobao/10002_xiaobao_skeletondata.asset"
			end

			return path
		end

		function GameUrl.getPetImgUrl()
			local path = string.format("ui/bigbg/pet/%s.png", data.cardName)

			if Framework.OSDef.isEditor and not GoUtil.IsAssetExist(path) then
				return "ui/bigbg/pet/img_10002_xiaobao.png"
			end

			return path
		end

		function GameUrl.getPosterSpineUrl()
			local posterCfg = PetskinController.instance:getPosterCfg(skinId)
			local posterId = posterCfg and checknumber(posterCfg.posterId)
			local cfg = PetSkinConfig.instance:getPosterModelCo(posterId)

			if cfg then
				if not cfg.resName then
					local name = ""
					local dic = GameUrl._handleSpineDic(name)
					local path = string.format("haibao_spine/%s/%s_p.prefab", dic, name)

					if Framework.OSDef.isEditor then
						return GameUrl._checkDefultSpinePath(path)
					end

					return path
				end
			end
		end

		function CharacterConfig.GetCharacterResIdx(instance, faceId, isAtuo)
			local resPath

			if isAtuo then
				if not string.nilorempty(bustName) then
					resPath = GameUrl.getLihuiSpineUIUrl(bustName)

					return 2, resPath
				end

				if not string.nilorempty(resName) then
					resPath = GameUrl.getSpineUIUrl(resName)

					return 1, resPath
				end
			elseif not string.nilorempty(resName) then
				resPath = GameUrl.getSpineUIUrl(resName)

				return 1, resPath
			end

			return nil, nil
		end
	else
		print(string.format("恢复精灵"))
		self:_onResetFunction()
	end
end

function GMView:_onResetFunction()
	GameUrl.getSpineUrl = GameUrl_getSpineUrl
	GameUrl.getSpineUIUrl = GameUrl_getSpineUIUrl
	GameUrl.getLihuiSpineUrl = GameUrl_getLihuiSpineUrl
	GameUrl.getLihuiSpineUIUrl = GameUrl_getLihuiSpineUIUrl
	GameUrl.getSpineAssetRrl = GameUrl_getSpineAssetRrl
	GameUrl.getPetImgUrl = GameUrl_getPetImgUrl
	GameUrl.getPosterSpineUrl = GameUrl_getPosterSpineUrl
	CharacterConfig.GetCharacterResIdx = CharacterConfig_GetCharacterResIdx
end

function GMView:_updateExInfoUI()
	if not Framework.OSDef.isEditor then
		self._exInfo_txt2.text = string.format("RunOS: %s", Framework.OSDef.RunOS)

		return
	end

	self:_updateExInfoTxt1UI()
	self:_updateExInfoTxt2UI()
end

function GMView:_updateExInfoTxt1UI()
	local assetPath = UnityEngine.Application.dataPath
	local path = assetPath:sub(1, assetPath:len() - 16) .. ".git/"
	local www = UnityEngine.WWW.New(path .. "HEAD")

	local function finishCallBack(wwwLoader)
		local result = "???"

		if string.nilorempty(wwwLoader.error) then
			local log = wwwLoader.text

			log = log:rtrim():split("\n")

			if #log > 0 then
				local nowRef = string.split(log[#log], " ")
				local ref = nowRef[2]

				if not string.nilorempty(ref) then
					local arr = string.split(ref, "/")

					result = arr[#arr]
				end
			end
		end

		self._exInfo_txt1.text = result

		local lowerInput = string.lower(result)

		GameUtil.setUIImageColorIdx(self._imgBranchesTag, string.find(lowerInput, "dev") and 0 or string.find(lowerInput, "rel") and 1 or string.find(lowerInput, "hot") and 2 or 3)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._exInfo:GetComponent(goutil.Type_RectTransform))
		wwwLoader:Dispose()
	end

	self:_regWWWLoad(www, finishCallBack)
end

function GMView:_updateExInfoTxt2UI()
	local assetPath = UnityEngine.Application.dataPath
	local path = assetPath:sub(1, assetPath:len() - 16) .. ".git/"
	local www = UnityEngine.WWW.New(path .. "logs/HEAD")

	local function finishCallBack(wwwLoader)
		local result = "???"

		if string.nilorempty(wwwLoader.error) then
			local log = wwwLoader.text

			log = log:rtrim():split("\n")

			if #log > 0 then
				local nowRef = string.split(log[#log], " ")
				local clientId = nowRef[2]
				local timeStamp = checknumber(nowRef[5])
				local clientTimeStr = GameUtil.getFormatTimeByStamp(timeStamp, nil)
				local userId = RoleModel.instance:getUserId()

				result = string.format("userId: %s | %s | %s", userId, clientId:sub(1, 6), clientTimeStr)
			end
		end

		self._exInfo_txt2.text = result or ""

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._exInfo:GetComponent(goutil.Type_RectTransform))
		wwwLoader:Dispose()
	end

	self:_regWWWLoad(www, finishCallBack)
end

function GMView:_regWWWLoad(wwwLoader, finishCallBack)
	if self._wwwLoadInfoList == nil then
		self._wwwLoadInfoList = {}
	end

	local info = {}

	info.curTime = 0
	info.wwwLoader = wwwLoader
	info.finishCallBack = finishCallBack

	table.insert(self._wwwLoadInfoList, info)

	self._deltaTimeOfWwwLoadTicking = 0.1
	self._deltaTimeLimitOfWwwLoadTicking = 2

	if not self._isRuningOfWwwLoadTicking then
		self._isRuningOfWwwLoadTicking = true

		settimer(self._deltaTimeOfWwwLoadTicking, self._wwwLoadTicking, self)
	end
end

function GMView:_stopWwwLoadTicking()
	self._isRuningOfWwwLoadTicking = false

	removetimer(self._wwwLoadTicking, self)
end

function GMView:_clearWwwLoadList()
	self:_stopWwwLoadTicking()

	if self._wwwLoadInfoList then
		for idx, info in ipairs(self._wwwLoadInfoList) do
			if info.wwwLoader then
				info.wwwLoader:Dispose()
			end

			table.clear(info)
		end

		table.clear(self._wwwLoadInfoList)
	end
end

function GMView:_wwwLoadTicking()
	local rmList = {}

	for idx, info in ipairs(self._wwwLoadInfoList) do
		info.curTime = info.curTime + self._deltaTimeOfWwwLoadTicking

		if info.wwwLoader.isDone then
			GameUtil.callBack(info.finishCallBack, info.wwwLoader)
			table.insert(rmList, idx)
		elseif info.curTime >= self._deltaTimeLimitOfWwwLoadTicking then
			info.wwwLoader:Dispose()
			table.insert(rmList, idx)
		end
	end

	local length = #self._wwwLoadInfoList

	for idx = 1, length do
		if table.indexof(rmList, idx) ~= false then
			local info = self._wwwLoadInfoList[idx]

			table.clear(info)

			self._wwwLoadInfoList[idx] = nil
		end
	end

	for idx = 1, length do
		local info = self._wwwLoadInfoList[idx]

		for i = 1, idx do
			if self._wwwLoadInfoList[i] == nil then
				self._wwwLoadInfoList[i] = info
				self._wwwLoadInfoList[idx] = nil

				break
			end
		end
	end

	if #self._wwwLoadInfoList <= 0 then
		self:_stopWwwLoadTicking()

		return
	end
end

function GMView:_onViewOpened()
	self:_onViewStateChange()
end

function GMView:_onViewClosed()
	self:_onViewStateChange()
end

function GMView:_onViewStateChange()
	local topName
	local modalViews = ViewMgr.instance._curOpenModalViews

	if #modalViews > 0 then
		topName = modalViews[#modalViews]
	end

	if string.nilorempty(topName) then
		topName = UIStateManager.instance:getTopName()
	end

	local rootNode = {
		current = topName,
		children = {}
	}
	local queue = {}

	table.insert(queue, rootNode)

	while #queue > 0 do
		local node = table.remove(queue, 1)

		for viewName, v in pairs(ViewMgr.instance._curOpenViews) do
			local presentor = ViewMgr.instance._views[viewName]

			if presentor and presentor.parentPresentor and presentor and presentor.parentPresentor.viewName == node.current then
				local childNode = {
					current = viewName,
					parent = node,
					children = {}
				}

				table.insert(node.children, childNode)
				table.insert(queue, childNode)
			end
		end
	end

	local stack = {}

	table.insert(stack, {
		depth = 1,
		node = rootNode
	})

	local childStr = ""

	while #stack > 0 do
		local current = table.remove(stack, 1)

		if current.depth > 1 then
			local stars = string.rep("*", current.depth - 1)

			childStr = childStr .. stars .. current.node.current .. " "
		end

		for _, child in ipairs(current.node.children) do
			table.insert(stack, {
				node = child,
				depth = current.depth + 1
			})
		end
	end

	local topName = rootNode.current
	local extStr = ""

	if SceneMgr.instance.isGogingToEnterBattleScene then
		local round = BattleController.instance:getCurRound()

		if round then
			local result = round:getCharactorResult()

			if result then
				extStr = string.format("出手回合：%s", result.curRound)
			end
		end
	end

	self._txtTips.text = string.nilorempty(childStr) and string.format("%s %s", topName, extStr) or string.format("%s +( %s ) %s", topName, childStr, extStr)
end

function GMView:_onBattleRoundStart(round)
	if round.roundType == BattleRoundBase.Round then
		self:_onViewStateChange()
	end
end

return GMView
