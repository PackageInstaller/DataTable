-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemsetting/view/SystemSettingView.lua

module("logic.extensions.systemsetting.view.SystemSettingView", package.seeall)

local SystemSettingView = class("SystemSettingView", ViewComponent)

SystemSettingView.ID_SHOW_VIP_TIPS = "SystemSettingView.ID_SHOW_VIP_TIPS"

local GLOW_DISPLAY_KEY = "PJAQM_BLOOM_DISPLAY_KEY_LOCAL_STORAGE"

SystemSettingView.TabId = {
	Jiyixiazai = 5,
	Youxi = 2,
	HuaYin = 1,
	Tuishong = 3,
	Anquansuo = 4
}
SystemSettingView.TabConfigs = {
	{
		title = "画音",
		id = SystemSettingView.TabId.HuaYin,
		redpointIds = {}
	},
	{
		title = "游戏",
		id = SystemSettingView.TabId.Youxi,
		redpointIds = {
			RedPointModel.ID_First_GameSetViewSharetask,
			RedPointModel.ID_First_GameSetViewFormBond,
			RedPointModel.ID_SHOW_VIP_TIPS
		}
	},
	{
		title = "推送",
		id = SystemSettingView.TabId.Tuishong,
		redpointIds = {}
	},
	{
		title = "安全锁",
		id = SystemSettingView.TabId.Anquansuo,
		redpointIds = {},
		viewName = ViewName.SystemsettingpasswordlockView
	},
	{
		title = "记忆下载",
		id = SystemSettingView.TabId.Jiyixiazai,
		redpointIds = {}
	}
}

function SystemSettingView:ctor()
	SystemSettingView.super.ctor(self)
end

function SystemSettingView:_buildOptionCells(rootPath, count)
	local cells = {}

	for i = 1, count do
		local go = self:getGo(string.format("%s/cell%s", rootPath, i))
		local tagRec = goutil.findChild(go, "tagRec")

		if tagRec then
			goutil.setActive(tagRec, false)
		end

		table.insert(cells, {
			go = go,
			checkbox = goutil.findChild(go, "checkbox"),
			tagRec = tagRec
		})
	end

	return cells
end

function SystemSettingView:_bindOptionCells(cells, values, callback)
	for idx, cell in ipairs(cells) do
		cell.value = values[idx]

		GameUtil.addClickHandler(cell.go, GameUtil.handler(callback, self, values[idx]))
	end
end

function SystemSettingView:_unbindOptionCells(cells)
	for _, cell in ipairs(cells) do
		GameUtil.rmClickHandler(cell.go)
	end
end

function SystemSettingView:_refreshOptionCells(cells, selectedValue)
	for _, cell in ipairs(cells) do
		goutil.setActive(cell.checkbox, cell.value == selectedValue)
	end
end

function SystemSettingView:_refreshOptionRecommendTags(cells, settingKey)
	if not HardwareQualityRecommend or not HardwareQualityRecommend.instance then
		return
	end

	for _, cell in ipairs(cells) do
		if cell.tagRec then
			local value = cell.value

			if type(value) == "table" then
				value = value[1]
			end

			goutil.setActive(cell.tagRec, HardwareQualityRecommend.instance:isRecommended(settingKey, value))
		end
	end
end

function SystemSettingView:bindEvents()
	GameUtil.addClickHandler(self._tabRed, self._onClickTabRed, self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self:_bindOptionCells(self._sceneQualityCells, self._sceneQualityValues, self._onClickSceneQuality)
	self:_bindOptionCells(self._frameRateCells, self._frameRateValues, self._onClickFrameRateType)
	self:_bindOptionCells(self._resolutionCells, self._resolutionValues, self._onClickResolution)
	GameUtil.addClickHandler(self._glowBtn, self._onClickGlow, self)
	self._btnDownMusic:AddClickListener(function()
		self:_onClickDown(1)
	end)
	self._btnUpMusic:AddClickListener(function()
		self:_onClickUp(1)
	end)
	self._btnDownAudio:AddClickListener(function()
		self:_onClickDown(2)
	end)
	self._btnUpAudio:AddClickListener(function()
		self:_onClickUp(2)
	end)
	self._btnDownVoice:AddClickListener(function()
		self:_onClickDown(3)
	end)
	self._btnUpVoice:AddClickListener(function()
		self:_onClickUp(3)
	end)
	self._btnJianyi:AddClickListener(function()
		self:close()
		UIStateManager.instance:push(ViewName.feedback)
	end)
	self._btnQiehuan:AddClickListener(function()
		self:close()
		RoleAgent.instance:sendExitGameReq()
	end)
	self._btnExchange:AddClickListener(self._onClickExchangeCode, self)
	self._btnAssist:AddClickListener(self._onClickBtnAssist, self)
	self._powerAllBtn:AddClickListener(self._onClickPowerAll, self)
	self._powerCompleteBtn:AddClickListener(self._onClickPowerComplete, self)
	self._assignBtn:AddClickListener(self._onClickAssign, self)
	self._pigBtn:AddClickListener(self._onClickPig, self)
	self._worldbossBtn:AddClickListener(self._onClickWorldBoss, self)
	self._fanilyBtn:AddClickListener(self._onClickFanily, self)
	self._pkOpenBtn:AddClickListener(self._onClickPkOpen, self)
	self._pkStrangerBtn:AddClickListener(self._onClickPkStranger, self)
	self._toggleAdapter:AddOnValueChanged(self._onToggleChange, self)
	self._pushBtn:AddClickListener(self._onClickPushBtn, self)
	self._personaliseBtn:AddClickListener(self._onClickPersonaliseBtn, self)
	self._btnPushTipCustomInput:AddListener(self._onClickPushTipCustomInput, self)
	self._btnPersonaliseCustomInput:AddListener(self._onClickPersonaliseCustomInput, self)
	GameUtil.addClickHandler(self._btnDownloadPaint, self._onClickDownloadPaint, self)
	GameUtil.addClickHandler(self._btnDelRole, self._onClickDelRole, self)
	GameUtil.addClickHandler(self._btnAI, self._onClickbtnAI, self)
	self._lowDetails:AddClickListener(function()
		self:_setDetails(BattleModel.InfoType_Hp_None)
	end)
	self._midDetails:AddClickListener(function()
		self:_setDetails(BattleModel.InfoType_Hp_Vigour)
	end)
	self._highDetails:AddClickListener(function()
		self:_setDetails(BattleModel.InfoType_Hp_Vigour_Attr_Name_Level)
	end)
	self._btnSkipUtlSkill:AddClickListener(self._onClickSkipUtlSkill, self)
	self._btnSkipSkillShenyao:AddClickListener(self._onClickSkipShenyaoSkill, self)
	self._btnSkipStartAni:AddClickListener(self._onClickSkipStartAni, self)
	self._btnShenhuaEnterToggle:AddClickListener(self._onClickSkipShenHuaEnter, self)
	self._btnShenhuaOnlySelfToggle:AddClickListener(self._onClickOnlyShowSelfShenHuaEnter, self)
	self._btnBattleCoverbg:AddClickListener(self._onClickBtnBattleCoverbg, self)
	self._btnShareTask:AddClickListener(self._onClickBtnShareTask, self)
	self._btnTipsInShareTask:AddClickListener(function()
		RedPointController.instance:saveUserOnceRedPoint(RedPointModel.ID_First_GameSetViewSharetask, true)
		GameUtil.SetActive(self._txtTipsBtnShareTask.gameObject, not GameUtil.GetActive(self._txtTipsBtnShareTask.gameObject))
	end, self)
	self._btnFormBond:AddClickListener(self._onClickBtnFormBond, self)
	self._btnTipInFormBond:AddClickListener(self._onClickBtnTipInFormBond, self)
	self._btnStrangerMsg:AddClickListener(self._onClickBtnStrangerMsg, self)
	self._btnShowvip:AddClickListener(self._onClickBtnShowvip, self)
	self._btnTipsInShowVip:AddClickListener(function()
		GameUtil.saveUserData(SystemSettingView.ID_SHOW_VIP_TIPS, true)
		RedPointController.instance:saveUserOnceRedPoint(RedPointModel.ID_SHOW_VIP_TIPS, true)
		GameUtil.SetActive(self._txtTipsBtnShowVip.gameObject, not GameUtil.GetActive(self._txtTipsBtnShowVip.gameObject))
	end, self)
	GameUtil.addClickHandler(self._btnComment, self._onClickComment, self)
	GameUtil.addClickHandler(self._btnUserProtocal, self._onClickPrivateProtocal, self)
	GameUtil.addClickHandler(self._btnScan, self._onClickScanLogin, self)

	for i, v in ipairs(self._fightBgmList) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickBgm, self, i))
	end
end

function SystemSettingView:unbindEvents()
	GameUtil.rmClickHandler(self._tabRed)
	self:_unbindOptionCells(self._sceneQualityCells)
	self:_unbindOptionCells(self._frameRateCells)
	self:_unbindOptionCells(self._resolutionCells)
	GameUtil.rmClickHandler(self._glowBtn)
	self._closeButton:RemoveClickListener()
	self._btnDownMusic:RemoveClickListener()
	self._btnUpMusic:RemoveClickListener()
	self._btnDownAudio:RemoveClickListener()
	self._btnUpAudio:RemoveClickListener()
	self._btnDownVoice:RemoveClickListener()
	self._btnUpVoice:RemoveClickListener()
	self._btnJianyi:RemoveClickListener()
	self._btnQiehuan:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnAssist:RemoveClickListener()
	self._powerAllBtn:RemoveClickListener()
	self._powerCompleteBtn:RemoveClickListener()
	self._assignBtn:RemoveClickListener()
	self._pigBtn:RemoveClickListener()
	self._worldbossBtn:RemoveClickListener()
	self._fanilyBtn:RemoveClickListener()
	self._pkOpenBtn:RemoveClickListener()
	self._pkStrangerBtn:RemoveClickListener()
	self._toggleAdapter:RemoveOnValueChanged()
	self._pushBtn:RemoveClickListener()
	self._personaliseBtn:RemoveClickListener()
	self._btnPushTipCustomInput:RemoveListener()
	self._btnPersonaliseCustomInput:RemoveListener()
	GameUtil.rmClickHandler(self._btnDownloadPaint)
	GameUtil.rmClickHandler(self._btnDelRole)
	GameUtil.rmClickHandler(self._btnAI)
	GameUtil.rmClickHandler(self._btnUserProtocal)
	GameUtil.rmClickHandler(self._btnScan)
	self._lowDetails:RemoveClickListener()
	self._midDetails:RemoveClickListener()
	self._highDetails:RemoveClickListener()
	self._btnSkipUtlSkill:RemoveClickListener()
	self._btnSkipSkillShenyao:RemoveClickListener()
	self._btnSkipStartAni:RemoveClickListener()
	self._btnShenhuaOnlySelfToggle:RemoveClickListener()
	self._btnShenhuaEnterToggle:RemoveClickListener()
	self._btnBattleCoverbg:RemoveClickListener()
	self._btnShareTask:RemoveClickListener()
	self._btnTipsInShareTask:RemoveClickListener()
	self._btnFormBond:RemoveClickListener()
	self._btnTipInFormBond:RemoveClickListener()
	self._btnStrangerMsg:RemoveClickListener()
	self._btnShowvip:RemoveClickListener()
	self._btnTipsInShowVip:RemoveClickListener()

	for i, v in ipairs(self._fightBgmList) do
		GameUtil.rmClickHandler(v)
	end
end

function SystemSettingView:buildUI()
	self._screenSound = self:getGo("screenSoundView")
	self._pushset = self:getGo("pushset")
	self._powerAllBtn = self:getBtn("pushset/powerAll/btnToggle")
	self._powerAllOn = self:getGo("pushset/powerAll/btnToggle/on")
	self._powerAllOff = self:getGo("pushset/powerAll/btnToggle/off")
	self._powerCompleteBtn = self:getBtn("pushset/powerComplete/btnToggle")
	self._powerCompleteOn = self:getGo("pushset/powerComplete/btnToggle/on")
	self._powerCompleteOff = self:getGo("pushset/powerComplete/btnToggle/off")
	self._assignBtn = self:getBtn("pushset/assign/btnToggle")
	self._assignOn = self:getGo("pushset/assign/btnToggle/on")
	self._assignOff = self:getGo("pushset/assign/btnToggle/off")
	self._pigBtn = self:getBtn("pushset/pig/btnToggle")
	self._pigOn = self:getGo("pushset/pig/btnToggle/on")
	self._pigOff = self:getGo("pushset/pig/btnToggle/off")
	self._worldbossBtn = self:getBtn("pushset/worldboss/btnToggle")
	self._worldbossOn = self:getGo("pushset/worldboss/btnToggle/on")
	self._worldbossOff = self:getGo("pushset/worldboss/btnToggle/off")
	self._fanilyBtn = self:getBtn("pushset/fanily/btnToggle")
	self._fanilyOn = self:getGo("pushset/fanily/btnToggle/on")
	self._fanilyOff = self:getGo("pushset/fanily/btnToggle/off")
	self._toggleAdapter = self:getToggle("pushset/Toggle")
	self._pushBtn = self:getBtn("pushset/push/btnToggle")
	self._pushOn = self:getGo("pushset/push/btnToggle/on")
	self._pushOff = self:getGo("pushset/push/btnToggle/off")
	self._personaliseBtn = self:getBtn("pushset/personalise/btnToggle")
	self._personaliseOn = self:getGo("pushset/personalise/btnToggle/on")
	self._personaliseOff = self:getGo("pushset/personalise/btnToggle/off")
	self._btnPushTipCustomInput = UICustomInput.Get(self:getGo("pushset/push/btnPushTip"))
	self._btnPersonaliseCustomInput = UICustomInput.Get(self:getGo("pushset/personalise/btnPersonTip"))
	self._pushTxtTip = self:getGo("pushset/push/txtTip")
	self._personaliseTxtTip = self:getGo("pushset/personalise/txtTip")
	self._pkset = self:getGo("gameSetView/scrolview/viewport/content/basicSetting/pkset")
	self._pkOpenBtn = self:getBtn("gameSetView/scrolview/viewport/content/basicSetting/pkset/pkOpen/btnToggle")
	self._pkOpenOn = self:getGo("gameSetView/scrolview/viewport/content/basicSetting/pkset/pkOpen/btnToggle/checkbox")
	self._pkStrangerBtn = self:getBtn("gameSetView/scrolview/viewport/content/basicSetting/pkset/pkStranger/btnToggle")
	self._pkStrangerOn = self:getGo("gameSetView/scrolview/viewport/content/basicSetting/pkset/pkStranger/btnToggle/checkbox")
	self._fightBgmList = {}

	for i = 1, 6 do
		local go = self:getGo("screenSoundView/scrolview/viewport/content/fightBGM/bgm_" .. i)

		table.insert(self._fightBgmList, go)
	end

	self._sceneQualityValues = {
		HardwareQuality.QualityLevelType.Low,
		HardwareQuality.QualityLevelType.Medium,
		HardwareQuality.QualityLevelType.High
	}
	self._sceneQualityCells = self:_buildOptionCells("screenSoundView/scrolview/viewport/content/huamian/sceneQuality/group", 3)
	self._frameRateValues = {
		HardwareQuality.FrameRateLevelType.Low,
		HardwareQuality.FrameRateLevelType.Medium,
		HardwareQuality.FrameRateLevelType.High,
		HardwareQuality.FrameRateLevelType.Ultra
	}
	self._frameRateCells = self:_buildOptionCells("screenSoundView/scrolview/viewport/content/huamian/frameRate/group", 4)
	self._resolutionValues = {
		HardwareQuality.ResolutionLevelType.Low,
		HardwareQuality.ResolutionLevelType.Medium,
		HardwareQuality.ResolutionLevelType.High
	}
	self._resolutionCells = self:_buildOptionCells("screenSoundView/scrolview/viewport/content/huamian/resolution/group", 3)
	self._glowBtn = self:getGo("screenSoundView/scrolview/viewport/content/huamian/glow/toggle")
	self._glowCheckbox = goutil.findChild(self._glowBtn, "checkbox")
	self._glowTagRec = goutil.findChild(self._glowBtn, "tagRec")

	if self._glowTagRec then
		goutil.setActive(self._glowTagRec, false)
	end

	self._progressPlayerBar = Framework.SliderAdapter.GetFrom(self.mainGO, "screenSoundView/scrolview/viewport/content/huamian/peopleNum/progressBar")
	self._txtPlayerNum = self:getGo("screenSoundView/scrolview/viewport/content/huamian/peopleNum/txtPlayerNum"):GetComponent("Text")
	self._goRecCount = self:getGo("screenSoundView/scrolview/viewport/content/huamian/peopleNum/txtRecCount")
	self._txtRecCount = self._goRecCount:GetComponent("Text")

	goutil.setActive(self._goRecCount, false)
	goutil.setActive(self:getGo("txt"), false)
	printInfo("test buildUI HardwareQuality.getMaxPlayers", HardwareQuality.getMaxPlayers())

	self._txtPlayerNum.text = HardwareQuality.getMaxPlayers()
	self._closeButton = self:getBtn("btnClose")
	self._screenSoundScrol = self:getGo("screenSoundView/scrolview/viewport/content")
	self._musicProgress = Framework.SliderAdapter.GetFrom(self._screenSoundScrol, "music/progressBar")
	self._audioProgress = Framework.SliderAdapter.GetFrom(self._screenSoundScrol, "audio/progressBar")
	self._voiceProgress = Framework.SliderAdapter.GetFrom(self._screenSoundScrol, "voice/progressBar")
	self._btnDownMusic = self:getBtn("screenSoundView/scrolview/viewport/content/music/down")
	self._btnUpMusic = self:getBtn("screenSoundView/scrolview/viewport/content/music/up")
	self._btnDownAudio = self:getBtn("screenSoundView/scrolview/viewport/content/audio/down")
	self._btnUpAudio = self:getBtn("screenSoundView/scrolview/viewport/content/audio/up")
	self._btnDownVoice = self:getBtn("screenSoundView/scrolview/viewport/content/voice/down")
	self._btnUpVoice = self:getBtn("screenSoundView/scrolview/viewport/content/voice/up")
	self._btnJianyi = self:getBtn("btns/btnSuggest")
	self._btnJianyiRed = self:getGo("btns/btnSuggest/imgRed")
	self._btnQiehuan = self:getBtn("btns/btnChange")
	self._btnAssist = self:getBtn("btnAssist")
	self._btnDelRole = self:getGo("btns/btnDelRole")
	self._btnExchange = self:getBtn("btnExchange")
	self._btnScan = self:getGo("btnScan")
	self._goPaintset = self:getGo("paintset")
	self._btnDownloadPaint = self:getGo("paintset/btnSure")

	goutil.setActive(self._goPaintset, true)

	local txtTip = self:getTxt("paintset/txtTip")

	txtTip.text = "后续版本开放下载"

	local tableview = self:getGo("paintset/tableview")
	local cell = self:getGo("paintset/cell")

	goutil.setActive(self._btnDownloadPaint, false)

	self._paintTableView = ScrollerList.create(tableview, cell, GameUtil.handler(self._updatePaintCell, self), GameUtil.handler(self._clearPaintCell, self))
	self._gameSetView = self:getGo("gameSetView")
	self._lowDetails = self:getBtn("gameSetView/scrolview/viewport/content/battleSetting/details/low")
	self._midDetails = self:getBtn("gameSetView/scrolview/viewport/content/battleSetting/details/mid")
	self._highDetails = self:getBtn("gameSetView/scrolview/viewport/content/battleSetting/details/high")
	self._btnSkipUtlSkill = self:getBtn("gameSetView/scrolview/viewport/content/battleSetting/skillToggle")
	self._btnSkipSkillShenyao = self:getBtn("gameSetView/scrolview/viewport/content/battleSetting/skillShenyaoToggle")
	self._btnSkipStartAni = self:getBtn("gameSetView/scrolview/viewport/content/basicSetting/bagstartToggle")
	self._btnShenhuaOnlySelfToggle = self:getBtn("gameSetView/scrolview/viewport/content/battleSetting/shenhuaOnlySelfToggle")
	self._btnShenhuaEnterToggle = self:getBtn("gameSetView/scrolview/viewport/content/battleSetting/shenhuaEnterToggle")
	self._btnBattleCoverbg = self:getBtn("gameSetView/scrolview/viewport/content/battleSetting/battlecoverbgToggle")
	self._btnShareTask = self:getBtn("gameSetView/scrolview/viewport/content/basicSetting/sharetask/toggle")
	self._btnTipsInShareTask = self:getBtn("gameSetView/scrolview/viewport/content/basicSetting/sharetask/btnTip")
	self._redBtnShareTask = self:getGo("gameSetView/scrolview/viewport/content/basicSetting/sharetask/btnTip/redpoint")
	self._txtTipsBtnShareTask = self:getTxt("gameSetView/scrolview/viewport/content/basicSetting/sharetask/txtTips")
	self._btnFormBond = self:getBtn("gameSetView/scrolview/viewport/content/basicSetting/formbond/toggle")
	self._btnTipInFormBond = self:getBtn("gameSetView/scrolview/viewport/content/basicSetting/formbond/btnTip")
	self._redBtnFormBond = self:getGo("gameSetView/scrolview/viewport/content/basicSetting/formbond/btnTip/redpoint")
	self._btnStrangerMsg = self:getBtn("gameSetView/scrolview/viewport/content/basicSetting/strangerMsg/toggle")
	self._btnShowvip = self:getBtn("gameSetView/scrolview/viewport/content/basicSetting/showvip/toggle")
	self._btnTipsInShowVip = self:getBtn("gameSetView/scrolview/viewport/content/basicSetting/showvip/btnTip")
	self._redBtnShowVip = self:getGo("gameSetView/scrolview/viewport/content/basicSetting/showvip/btnTip/redpoint")
	self._txtTipsBtnShowVip = self:getTxt("gameSetView/scrolview/viewport/content/basicSetting/showvip/txtTips")
	self._lowDetailsBox = goutil.findChild(self._lowDetails.gameObject, "checkbox")
	self._midDetailsBox = goutil.findChild(self._midDetails.gameObject, "checkbox")
	self._highDetailsBox = goutil.findChild(self._highDetails.gameObject, "checkbox")
	self._utlSkillCheckBox = goutil.findChild(self._btnSkipUtlSkill.gameObject, "checkbox")
	self._skillShenyaoCheckBox = goutil.findChild(self._btnSkipSkillShenyao.gameObject, "checkbox")
	self._startAniCheckBox = goutil.findChild(self._btnSkipStartAni.gameObject, "checkbox")
	self._shenhuaEnterCheckBox = goutil.findChild(self._btnShenhuaEnterToggle.gameObject, "checkbox")
	self._shenhuaOnlySelfCheckBox = goutil.findChild(self._btnShenhuaOnlySelfToggle.gameObject, "checkbox")
	self.__battleCoverbgCheckBox = goutil.findChild(self._btnBattleCoverbg.gameObject, "checkbox")
	self._shareTaskCheckBox = goutil.findChild(self._btnShareTask.gameObject, "checkbox")
	self._formBondCheckBox = goutil.findChild(self._btnFormBond.gameObject, "checkbox")
	self._strangerMsgBox = goutil.findChild(self._btnStrangerMsg.gameObject, "checkbox")
	self._showvipBox = goutil.findChild(self._btnShowvip.gameObject, "checkbox")
	self._tabRed = self:getGo("tabRed")
	self._redSetView = self:getGo("redSetView")
	self._redSetView_detailCell = self:getGo("gameSetView/scrolview/viewport/content/redSetView/detailCell")
	self._redSetView_detailView = self:getGo("gameSetView/scrolview/viewport/content/redSetView/detailView")

	GameUtil.SetActive(self._redSetView_detailCell, false)

	self._btnAI = self:getGo("btns/btnAI")
	self._btnComment = self:getGo("btns/btnComment")
	self._btnUserProtocal = self:getGo("btns/btnUserProtocal")

	goutil.setActive(self._btnAI.gameObject, false)
	goutil.setActive(self._btnJianyi.gameObject, true)
	GameUtil.SetActive(self._btnComment, BootstrapUtil.getPlatformId() == 2 and SDKManager.isSupportTapTap())

	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._containerGo = self:getGo("container")
end

function SystemSettingView:_setDetails(detail)
	if detail == BattleModel.instance:getAutoSkipUtilSkill() then
		return
	end

	BattleModel.instance:saveBtlInfoType(detail)
	self:_refreshDetails()
end

function SystemSettingView:_refreshDetails()
	local detail = BattleModel.instance:getBtlInfoType()

	goutil.setActive(self._lowDetailsBox, detail == 1)
	goutil.setActive(self._midDetailsBox, detail == 2)
	goutil.setActive(self._highDetailsBox, detail == 3)
end

function SystemSettingView:_refreshSkipShenyaoSkill()
	local skip = BattleModel.instance:getAutoSkipShenyaoSkill()

	goutil.setActive(self._skillShenyaoCheckBox, skip)
end

function SystemSettingView:_onClickSkipShenyaoSkill()
	local skip = BattleModel.instance:getAutoSkipShenyaoSkill()

	BattleModel.instance:setAutoSkipShenyaoSkill(not skip)
	self:_refreshSkipShenyaoSkill()
end

function SystemSettingView:_refreshSkipUtlSkill()
	local skip = BattleModel.instance:getAutoSkipUtilSkill()

	goutil.setActive(self._utlSkillCheckBox, skip)
end

function SystemSettingView:_onClickSkipUtlSkill()
	local skip = BattleModel.instance:getAutoSkipUtilSkill()

	BattleModel.instance:setAutoSkipUtilSkill(not skip)
	self:_refreshSkipUtlSkill()
end

function SystemSettingView:_refreshAutoSkipShenHuaEnter()
	local skip = BattleModel.instance:getAutoSkipShenHuaEnter()

	goutil.setActive(self._shenhuaEnterCheckBox, skip)
end

function SystemSettingView:_onClickSkipShenHuaEnter()
	local skip = BattleModel.instance:getAutoSkipShenHuaEnter()

	BattleModel.instance:setAutoSkipShenHuaEnter(not skip)
	self:_refreshAutoSkipShenHuaEnter()
end

function SystemSettingView:_refreshOnlyShowSelfShenHuaEnter()
	local skip = BattleModel.instance:getOnlyShowSelfShenHuaEnter()

	goutil.setActive(self._shenhuaOnlySelfCheckBox, skip)
end

function SystemSettingView:_onClickOnlyShowSelfShenHuaEnter()
	local skip = BattleModel.instance:getOnlyShowSelfShenHuaEnter()

	BattleModel.instance:setOnlyShowSelfShenHuaEnter(not skip)
	self:_refreshOnlyShowSelfShenHuaEnter()
end

function SystemSettingView:_refreshSkipStartAni()
	local skip = BagPetSkinController.instance:getAutoSkipStartAni()

	goutil.setActive(self._startAniCheckBox, skip)
end

function SystemSettingView:_onClickSkipStartAni()
	local skip = BagPetSkinController.instance:getAutoSkipStartAni()

	BagPetSkinController.instance:setAutoSkipStartAni(not skip)
	self:_refreshSkipStartAni()
end

function SystemSettingView:_refreshBattleCoverbg()
	local flag = BattleModel.instance:getBattleBgCoverDomain()

	goutil.setActive(self.__battleCoverbgCheckBox, flag)
end

function SystemSettingView:_onClickBtnBattleCoverbg()
	local flag = BattleModel.instance:getBattleBgCoverDomain()

	BattleModel.instance:setBattleBgCoverDomain(not flag)
	self:_refreshBattleCoverbg()
end

function SystemSettingView:_onClickBtnShareTask()
	local flag = ShareTaskController.instance.isStopTrigger

	ShareTaskController.instance:sendGetShareTaskSetting(not flag)
end

function SystemSettingView:_refreshShareTask()
	local flag = ShareTaskController.instance.isStopTrigger

	goutil.setActive(self._shareTaskCheckBox, flag)
end

function SystemSettingView:_onClickBtnFormBond()
	local flag = PetRelationController.instance:getIsShowDetail()

	PetRelationController.instance:setIsShowDetail(not flag)
	self:_refreshFormBond()
end

function SystemSettingView:_refreshFormBond()
	local flag = PetRelationController.instance:getIsShowDetail()

	goutil.setActive(self._formBondCheckBox, flag)
end

function SystemSettingView:_onClickBtnStrangerMsg()
	local flag = RoleModel.instance:getSettingSwitchIsOpen(GameEnum.PlayerSettingSwitchBitPos.ALLOW_STRANGER_CHAT)
	local settingSwitch = RoleModel.instance:getSettingSwitch()
	local setNum = flag and 0 or 1
	local curSettingSwitch = MmUtil.setBitSetAndGetReturnNum(settingSwitch, GameEnum.PlayerSettingSwitchBitPos.ALLOW_STRANGER_CHAT, setNum)

	RoleModel.instance:setSettingSwitch(curSettingSwitch)

	local playerSettings = RoleModel.instance:getSettings()

	RoleController.instance:sendUpdatePlayerSettingsReq(playerSettings)
	self:_refreshStrangerMsg()
	GlobalDispatcher:dispatch(GlobalNotify.ChangeStrangerSwitch, not flag)
end

function SystemSettingView:_refreshStrangerMsg()
	local flag = RoleModel.instance:getSettingSwitchIsOpen(GameEnum.PlayerSettingSwitchBitPos.ALLOW_STRANGER_CHAT)

	GameUtil.SetActive(self._strangerMsgBox, flag)
end

function SystemSettingView:_onClickBtnTipInFormBond()
	RedPointController.instance:saveUserOnceRedPoint(RedPointModel.ID_First_GameSetViewFormBond, true)
	TipsFacade.instance:openImageTipsView(lang("系统设置"), "勾选后激活羁绊、上阵效果时，如下图飘窗提示。", "ui/bigbg/views/fuben_zhandou/board_zd_57")
end

function SystemSettingView:_onClickBtnShowvip()
	local flag = RoleModel.instance:getSettingSwitchIsOpen(GameEnum.PlayerSettingSwitchBitPos.NO_SHOW_VIP_LV)
	local settingSwitch = RoleModel.instance:getSettingSwitch()
	local setNum = flag and 0 or 1
	local curSettingSwitch = MmUtil.setBitSetAndGetReturnNum(settingSwitch, GameEnum.PlayerSettingSwitchBitPos.NO_SHOW_VIP_LV, setNum)

	RoleModel.instance:setSettingSwitch(curSettingSwitch)

	local playerSettings = RoleModel.instance:getSettings()

	RoleController.instance:sendUpdatePlayerSettingsReq(playerSettings)
	self:_refreshShowvip()
end

function SystemSettingView:_refreshShowvip()
	local flag = RoleModel.instance:getSettingSwitchIsOpen(GameEnum.PlayerSettingSwitchBitPos.NO_SHOW_VIP_LV)

	GameUtil.SetActive(self._showvipBox, flag)
end

function SystemSettingView:_setTabShowByIndex(id)
	if id == SystemSettingView.TabId.Youxi then
		local all, stranger = TraincampqiecuoModel.instance:getPkSwitch()

		self._needPkRefresh = false

		if all == nil then
			TrainCampQieCuoAgent.instance:sendPM_TC_FightSwitchInfoReq()

			self._needPkRefresh = true

			return
		end
	elseif id == SystemSettingView.TabId.Jiyixiazai then
		local list = SeasonConfig.instance:getSeasonConfigList()

		if self._paintTableView then
			self._paintTableView:reloadData(list)
		end

		SeasonModePvePlusAgent.instance:sendPM_SMPVEEmakiFragmentInfosReq()
	end

	if self._screenSound then
		self._screenSound.gameObject:SetActive(id == SystemSettingView.TabId.HuaYin)
	end

	if self._pushset then
		self._pushset.gameObject:SetActive(id == SystemSettingView.TabId.Tuishong)
	end

	if self._goPaintset then
		self._goPaintset.gameObject:SetActive(id == SystemSettingView.TabId.Jiyixiazai)
	end

	GameUtil.SetActive(self._gameSetView, id == SystemSettingView.TabId.Youxi)
end

function SystemSettingView:_onClickTabRed()
	return
end

function SystemSettingView:destroyUI()
	return
end

function SystemSettingView:onEnter()
	self.addGEvent(self, TrainCampQieCuoAgent.TC_FightSwitchInfoRes, self._getSwitchPk, self)
	self.addGEvent(self, TrainCampQieCuoAgent.TC_SetSwitchRes, self._onSetSwitch, self)
	self.addGEvent(self, GlobalNotify.UpdataShareTaskBossSetting, self._refreshShareTask, self)
	self._screenSound.gameObject:SetActive(true)
	self._pushset.gameObject:SetActive(false)

	local var_49_0 = self._btnDelRole

	GameUtil.SetActive(var_49_0, BootstrapUtil.getPlatformId() ~= -1 and (Framework.OSDef.isEditor or SDKManager.isHuawei()) or true)
	self:_initPersonaliseBtn()
	self:_initTxtTip()
	self:_initRedSetView()
	self:_refreshFightBgmMode()
	self:_udpateScreenSettingTab()
	self:_refreshPush()
	self:_refreshPk()
	self:_refreshRedSetView()
	self._progressPlayerBar:AddOnValueChanged(function(val)
		pcall(self._setPlayerNum, self, val)
	end)
	self:_refreshSound()
	self._musicProgress:AddOnValueChanged(function(val)
		pcall(self._setVolume, self, 1, val)
	end)
	self._audioProgress:AddOnValueChanged(function(val)
		pcall(self._setVolume, self, 2, val)
	end)
	self._voiceProgress:AddOnValueChanged(function(val)
		pcall(self._setVolume, self, 3, val)
	end)
	self:_onEnterPaint()

	local firstParam = self:getFirstParam()

	self._curSelectId = checknumber(firstParam)

	if self._curSelectId <= 0 then
		self._curSelectId = SystemSettingView.TabId.HuaYin
	end

	local datas = self:_calTabDatas()

	self._scrollerList:reloadData(datas)

	local tabData

	for i = 1, #datas do
		if datas[i].id == self._curSelectId then
			tabData = datas[i]

			break
		end
	end

	if not tabData then
		tabData = datas[1]
		self._curSelectId = datas[1].id
	end

	self:_onClickTab(tabData)
	RedPointController.instance:regRedPoint(self._btnJianyiRed, RedPointModel.ID_FEEDBACK)
	RedPointController.instance:regRedPoint(self._redBtnShareTask, RedPointModel.ID_First_GameSetViewSharetask)
	RedPointController.instance:regRedPoint(self._redBtnFormBond, RedPointModel.ID_First_GameSetViewFormBond)
	RedPointController.instance:regRedPoint(self._redBtnShowVip, RedPointModel.ID_SHOW_VIP_TIPS)
	goutil.setActive(self._btnScan.gameObject, false)

	local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

	if SDKManager.isOfficial() and versionCode >= 870 then
		goutil.setActive(self._btnScan.gameObject, not BootstrapPjaqGameConfigMgr.isReview)
	end

	goutil.setActive(self._btnExchange.gameObject, not BootstrapPjaqGameConfigMgr.isReview)

	if not GameUtil.getUserData(SystemSettingView.ID_SHOW_VIP_TIPS) then
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_SHOW_VIP_TIPS, true)
	end
end

function SystemSettingView:_onClickScanLogin()
	SDKManager.pcQRScanLogin()
end

function SystemSettingView:_udpateScreenSettingTab()
	self:_refreshSceneQuality()
	self:_refreshFrameRateType()
	self:_refreshResolution()
	self:_refreshGlow()
	self:_refreshMaxPlayerNum()
	self:_refreshSkipUtlSkill()
	self:_refreshSkipShenyaoSkill()
	self:_refreshDetails()
	self:_refreshSkipStartAni()
	self:_refreshBattleCoverbg()
	self:_refreshShareTask()
	self:_refreshFormBond()
	self:_refreshStrangerMsg()
	self:_refreshShowvip()
	self:_refreshAutoSkipShenHuaEnter()
	self:_refreshOnlyShowSelfShenHuaEnter()
end

function SystemSettingView:onEnterFinished()
	return
end

function SystemSettingView:onExit()
	self._musicProgress:RemoveOnValueChanged()
	self._audioProgress:RemoveOnValueChanged()
	self._voiceProgress:RemoveOnValueChanged()
	RedPointController.instance:unregRedPoint(self._btnJianyiRed)
	RedPointController.instance:unregRedPoint(self._redBtnShareTask)
	self._progressPlayerBar:RemoveOnValueChanged()
	QieCuoAgent.instance:getDispatcher():removeAllListener(QieCuoAgent.PM_FightSwitchInfoRes)
	self:_onExitPaint()
	self._scrollerList:dispose()
end

function SystemSettingView:onExitFinished()
	return
end

function SystemSettingView:_onClickBgm(idx)
	local mode = idx - 1

	SystemSettingController.instance:setBattleBGMMode(mode)
	self:_refreshFightBgmMode()
end

function SystemSettingView:_refreshFightBgmMode()
	local mode = SystemSettingController.instance:getBattleBGMMode()
	local idx = mode + 1

	for i, v in ipairs(self._fightBgmList) do
		local checkbox = goutil.findChild(v, "checkbox")

		GameUtil.SetActive(checkbox, idx == i)
	end
end

function SystemSettingView:_refreshPush()
	self:_refreshPushOnOff(1, self._powerAllOn, self._powerAllOff)
	self:_refreshPushOnOff(2, self._powerCompleteOn, self._powerCompleteOff)
	self:_refreshPushOnOff(3, self._assignOn, self._assignOff)
	self:_refreshPushOnOff(4, self._pigOn, self._pigOff)
	self:_refreshPushOnOff(5, self._worldbossOn, self._worldbossOff)
	self:_refreshPushOnOff(6, self._fanilyOn, self._fanilyOff)

	local isOn = false

	for i = 1, 6 do
		local flag = GameUtil.getLocalString(NotificationConfig.SaveFlag .. i)

		if tostring(flag) ~= "false" then
			isOn = true

			break
		end
	end

	self._isToggleChanged = false
	self._toggleAdapter.toggle.isOn = isOn

	self:_changePushBtnState(isOn)

	self._isToggleChanged = true
end

function SystemSettingView:_refreshPk()
	local switch, stranger = TraincampqiecuoModel.instance:getPkSwitch()

	goutil.setActive(self._pkOpenOn, switch)
	goutil.setActive(self._pkStrangerOn, stranger)
end

function SystemSettingView:_refreshPushOnOff(id, onGo, offGo)
	local flag = GameUtil.getLocalString(NotificationConfig.SaveFlag .. id)

	goutil.setActive(onGo, flag ~= "false")
	goutil.setActive(offGo, flag == "false")
end

function SystemSettingView:_initRedSetView()
	return
end

function SystemSettingView:_refreshRedSetView()
	local parentTran = self._redSetView_detailView.transform
	local childGo = self._redSetView_detailCell
	local children = GameUtil.getChildren(parentTran)
	local dataList = RedPointSetConfig.instance:getRdsViewDataList()
	local length = #dataList

	for idx, data in ipairs(dataList) do
		local mainGo = children[idx]

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))
		end

		self:_updateRedSetViewDetailCell(mainGo, data.detailId)
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= length)
	end
end

function SystemSettingView:_clearRedSetView()
	local parentTran = self._redSetView_detailView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in pairs(children) do
		self:_clearRedSetViewDetailCell(mainGo)
	end
end

function SystemSettingView:_updateRedSetViewDetailCell(mainGo, detailId)
	local data = RedPointSetConfig.instance:getRdsViewData(detailId)

	if not data.commandIdList then
		local commandIdList = {}
		local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
		local btnTip = goutil.findChild(mainGo, "btnTip")
		local btnToggle = goutil.findChild(mainGo, "btnToggle")
		local on = goutil.findChild(mainGo, "btnToggle/checkbox")
		local isOn = RedPointSetController.instance:isOnOfCommandIdList(commandIdList)

		GameUtil.SetActive(on, isOn)

		txtDesc.text = data.name

		GameUtil.addClickHandler(btnTip, GameUtil.handler(self._onClickRedSetViewDetailCellTip, self, detailId))
		GameUtil.addClickHandler(btnToggle, GameUtil.handler(self._onClickRedSetViewDetailCellToggle, self, detailId))
	end
end

function SystemSettingView:_clearRedSetViewDetailCell(mainGo)
	local btnTip = goutil.findChild(mainGo, "btnTip")
	local btnToggle = goutil.findChild(mainGo, "btnToggle")

	GameUtil.rmClickHandler(btnTip)
	GameUtil.rmClickHandler(btnToggle)
end

function SystemSettingView:_onClickRedSetViewDetailCellTip(detailId)
	local data = RedPointSetConfig.instance:getRdsViewData(detailId)

	TipsFacade.instance:openImageTipsView(data.tipsTitle, data.tipsDesc, data.tipsImagPath)
end

function SystemSettingView:_onClickRedSetViewDetailCellToggle(detailId)
	local detailData = RedPointSetConfig.instance:getRdsViewData(detailId)

	if not detailData.commandIdList then
		local commandIdList = {}
		local isOn = RedPointSetController.instance:isOnOfCommandIdList(commandIdList)

		for _, commandId in pairs(commandIdList) do
			RedPointSetController.instance:setRedPointSetCommandValue(commandId, not isOn)
			RedPointSetController.instance:notifyRedPointSetCommandChange(commandId)
		end

		self:_refreshRedSetView()
	end
end

function SystemSettingView:_refreshSceneQuality()
	self:_refreshOptionCells(self._sceneQualityCells, HardwareQuality.getSceneQuality())

	if HardwareQualityRecommend then
		self:_refreshOptionRecommendTags(self._sceneQualityCells, HardwareQualityRecommend.SettingKey.SceneQuality)
	end
end

function SystemSettingView:_onClickSceneQuality(sceneQuality)
	if sceneQuality == HardwareQuality.getSceneQuality() then
		return
	end

	HardwareQuality.setSceneQuality(sceneQuality, true)
	self:_refreshSceneQuality()
end

function SystemSettingView:_refreshFrameRateType()
	local _rateType = HardwareQuality.getFrameRateType()

	for idx, cell in ipairs(self._frameRateCells) do
		goutil.setActive(cell.checkbox, _rateType == self._frameRateValues[idx][1])
	end

	if HardwareQualityRecommend then
		self:_refreshOptionRecommendTags(self._frameRateCells, HardwareQualityRecommend.SettingKey.FrameRateType)
	end
end

function SystemSettingView:_onClickFrameRateType(_rateInfo)
	local _rateType = _rateInfo[1]

	if _rateType ~= HardwareQuality.getFrameRateType() then
		self:_setFrameRateType(_rateType)
	end
end

function SystemSettingView:_setFrameRateType(_rateType)
	HardwareQuality.setFrameRateType(_rateType, true)
	self:_refreshFrameRateType()
end

function SystemSettingView:_refreshResolution()
	local _resolution = HardwareQuality.getResolution()

	self:_refreshOptionCells(self._resolutionCells, _resolution)

	if HardwareQualityRecommend then
		self:_refreshOptionRecommendTags(self._resolutionCells, HardwareQualityRecommend.SettingKey.Resolution)
	end
end

function SystemSettingView:_onClickResolution(_resolution)
	if _resolution == HardwareQuality.getResolution() then
		return
	end

	self:_setResolution(_resolution)
end

function SystemSettingView:_setResolution(_resolution)
	HardwareQuality.setResolution(_resolution, true)
	self:_refreshResolution()
end

function SystemSettingView:_getGlowDisplaySwitch()
	return Framework.LocalStorage.Instance:GetInt(GLOW_DISPLAY_KEY, 0) == 1
end

function SystemSettingView:_setGlowDisplaySwitch(isOpen)
	Framework.LocalStorage.Instance:SetInt(GLOW_DISPLAY_KEY, isOpen and 1 or 0)
	Framework.LocalStorage.Instance:Save()
end

function SystemSettingView:_refreshGlow()
	local _glow = self:_getGlowDisplaySwitch()

	goutil.setActive(self._glowCheckbox, _glow == HardwareQuality.GlowLevelType.Open)

	if self._glowTagRec and HardwareQualityRecommend and HardwareQualityRecommend.instance then
		goutil.setActive(self._glowTagRec, HardwareQualityRecommend.instance:isRecommended(HardwareQualityRecommend.SettingKey.BloomSwitch, _glow))
	end
end

function SystemSettingView:_onClickGlow()
	local _glow = not self:_getGlowDisplaySwitch()

	self:_setGlowDisplaySwitch(_glow)
	HardwareQuality.setBloomSwitch(HardwareQuality.GlowLevelType.Close, true)
	self:_refreshGlow()
end

function SystemSettingView:_setPlayerNum(val)
	self._txtPlayerNum.text = math.ceil(val * HardwareQuality.MaxPlayerNum)

	HardwareQuality.setMaxPlayers(math.ceil(val * HardwareQuality.MaxPlayerNum), true)
end

function SystemSettingView:_refreshMaxPlayerNum()
	printInfo("test SystemSettingView:_refreshMaxPlayerNum", HardwareQuality.getMaxPlayers(), HardwareQuality.MaxPlayerNum, HardwareQuality.getMaxPlayers() / HardwareQuality.MaxPlayerNum)
	self._progressPlayerBar:SetValue(HardwareQuality.getMaxPlayers() / HardwareQuality.MaxPlayerNum)

	if self._goRecCount and HardwareQualityRecommend and HardwareQualityRecommend.instance then
		local recNum = HardwareQualityRecommend.instance:getRecommendedValue(HardwareQualityRecommend.SettingKey.MaxPlayers)

		goutil.setActive(self._goRecCount, recNum ~= nil)

		if self._txtRecCount then
			self._txtRecCount.text = string.format("推荐:%s", recNum)
		end
	end
end

function SystemSettingView:_refreshSound()
	self._musicProgress:SetValue(AudioPlayerEx.instance:getMusicVolume())
	self._audioProgress:SetValue(AudioPlayerEx.instance:getAudioVolume())
	self._voiceProgress:SetValue(AudioPlayerEx.instance:getVoiceVolume())
end

function SystemSettingView:_onClickDown(soundType)
	if soundType == 1 then
		self._musicProgress:SetValue(math.max(0, AudioPlayerEx.instance:getMusicVolume() - 0.2))
	elseif soundType == 2 then
		self._audioProgress:SetValue(math.max(0, AudioPlayerEx.instance:getAudioVolume() - 0.2))
	elseif soundType == 3 then
		self._voiceProgress:SetValue(math.max(0, AudioPlayerEx.instance:getVoiceVolume() - 0.2))
	end
end

function SystemSettingView:_onClickUp(soundType)
	if soundType == 1 then
		self._musicProgress:SetValue(math.min(1, AudioPlayerEx.instance:getMusicVolume() + 0.2))
	elseif soundType == 2 then
		self._audioProgress:SetValue(math.min(1, AudioPlayerEx.instance:getAudioVolume() + 0.2))
	elseif soundType == 3 then
		self._voiceProgress:SetValue(math.min(1, AudioPlayerEx.instance:getVoiceVolume() + 0.2))
	end
end

function SystemSettingView:_onClickClose()
	AudioPlayerEx.instance:saveToLocalStorage()
	self:close()
end

function SystemSettingView:_getVolume(soundType)
	if soundType == 1 then
		return AudioPlayerEx.instance:getMusicVolume()
	elseif soundType == 2 then
		return AudioPlayerEx.instance:getAudioVolume()
	elseif soundType == 3 then
		return AudioPlayerEx.instance:getVoiceVolume()
	end
end

function SystemSettingView:_setVolume(soundType, val)
	if soundType == 1 then
		AudioPlayerEx.instance:setMusicVolume(val)
	elseif soundType == 2 then
		AudioPlayerEx.instance:setAudioVolume(val)
	elseif soundType == 3 then
		AudioPlayerEx.instance:setVoiceVolume(val)
	end
end

function SystemSettingView:_onClickExchangeCode()
	UIStateManager.instance:open(ViewName.ExchangeCodeTipView)
	self:_onClickClose()
end

function SystemSettingView:_onClickBtnAssist()
	return
end

function SystemSettingView:_notPushFlag(flag)
	if tostring(flag) ~= "false" then
		return "false"
	else
		return "true"
	end
end

function SystemSettingView:_onClickPowerAll()
	local flag = GameUtil.getLocalString(NotificationConfig.SaveFlag .. 1)

	GameUtil.setLocalString(NotificationConfig.SaveFlag .. 1, self:_notPushFlag(flag))
	self:_refreshPush()
end

function SystemSettingView:_onClickPowerComplete()
	local flag = GameUtil.getLocalString(NotificationConfig.SaveFlag .. 2)

	GameUtil.setLocalString(NotificationConfig.SaveFlag .. 2, self:_notPushFlag(flag))
	self:_refreshPush()
end

function SystemSettingView:_onClickAssign()
	local flag = GameUtil.getLocalString(NotificationConfig.SaveFlag .. 3)

	GameUtil.setLocalString(NotificationConfig.SaveFlag .. 3, self:_notPushFlag(flag))
	self:_refreshPush()
end

function SystemSettingView:_onClickPig()
	local flag = GameUtil.getLocalString(NotificationConfig.SaveFlag .. 4)

	GameUtil.setLocalString(NotificationConfig.SaveFlag .. 4, self:_notPushFlag(flag))
	self:_refreshPush()
end

function SystemSettingView:_onClickWorldBoss()
	local flag = GameUtil.getLocalString(NotificationConfig.SaveFlag .. 5)

	GameUtil.setLocalString(NotificationConfig.SaveFlag .. 5, self:_notPushFlag(flag))
	self:_refreshPush()
end

function SystemSettingView:_onClickFanily()
	local flag = GameUtil.getLocalString(NotificationConfig.SaveFlag .. 6)

	GameUtil.setLocalString(NotificationConfig.SaveFlag .. 6, self:_notPushFlag(flag))
	self:_refreshPush()
end

function SystemSettingView:_onClickPkOpen()
	local switch, stranger = TraincampqiecuoModel.instance:getPkSwitch()

	TraincampqiecuoController.instance:sendPM_TC_SetSwitchReq(not switch, (switch or nil) and false)
end

function SystemSettingView:_onClickPkStranger()
	local switch, stranger = TraincampqiecuoModel.instance:getPkSwitch()

	if switch then
		TraincampqiecuoController.instance:sendPM_TC_SetSwitchReq(switch, not stranger)
	end
end

function SystemSettingView:_onToggleChange(obj, isOn)
	if not self._isToggleChanged and isOn == false then
		for i = 1, 6 do
			GameUtil.setLocalString(NotificationConfig.SaveFlag .. i, "false")
		end

		self:_refreshPush()
	end
end

function SystemSettingView:_changePushBtnState(isOn)
	self._pushBtnState = isOn

	goutil.setActive(self._pushOn, isOn)
	goutil.setActive(self._pushOff, not isOn)
end

function SystemSettingView:_onClickPushBtn()
	local isOn = not self._pushBtnState

	self._pushBtnState = isOn

	goutil.setActive(self._pushOn, isOn)
	goutil.setActive(self._pushOff, not isOn)
end

function SystemSettingView:_initPersonaliseBtn()
	local key = NotificationConfig.SaveFlag .. "personalise"
	local flag = GameUtil.getLocalString(key)
	local isOn = flag == "true"

	goutil.setActive(self._personaliseOn, isOn)
	goutil.setActive(self._personaliseOff, not isOn)
end

function SystemSettingView:_onClickPersonaliseBtn()
	local key = NotificationConfig.SaveFlag .. "personalise"
	local flag = GameUtil.getLocalString(key)
	local isOn = flag ~= "true"

	goutil.setActive(self._personaliseOn, isOn)
	goutil.setActive(self._personaliseOff, not isOn)
	GameUtil.setLocalString(key, isOn and "true" or "false")
end

function SystemSettingView:_initTxtTip()
	goutil.setActive(self._pushTxtTip, false)
	goutil.setActive(self._personaliseTxtTip, false)
end

function SystemSettingView:_onClickPushTipCustomInput(hover)
	goutil.setActive(self._pushTxtTip, hover)
end

function SystemSettingView:_onClickPersonaliseCustomInput(hover)
	goutil.setActive(self._personaliseTxtTip, hover)
end

function SystemSettingView:_refreshPaintTab(data)
	self._paintTableView:refresh()
end

function SystemSettingView:_updatePaintCell(view, goCell, data)
	local cell = self:_clearPaintCell(goCell)

	goutil.setActive(cell.goBtnSelect, false)
	goutil.setActive(cell.goDownload, false)
	goutil.setActive(cell.goProgress, false)
	goutil.setActive(cell.goTxtProgress, false)
	uGuiUtil.clearImage(cell.paintImg)

	local cfg = SeasonConfig.instance:getSeasonFragmentBaseDataConfigBySeasonId(data.seasonId)

	if cfg and cfg[1] then
		local bigBgUrl = "ui/bigbg/season/" .. cfg[1].paintTexture .. ".png"

		uGuiUtil.setSpriteToImage(cell.paintImg, uGuiUtil.SpriteType.BigBg, bigBgUrl)
		GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickPaintItem, self, bigBgUrl))
	end

	goutil.setActive(cell.goNoGet, true)

	local info = SeasonModel.instance:getFragmentInfo(data.seasonId)

	if info then
		local cfg = SeasonConfig.instance:getSeasonFragmentConfigBySeasonId(data.seasonId)
		local maxFragmentNum = 0

		for _, v in pairs(cfg) do
			maxFragmentNum = maxFragmentNum + 1
		end

		local nowFragmentNum = #info.emakiFragmentIds

		goutil.setActive(cell.goNoGet, nowFragmentNum < maxFragmentNum)
	end
end

function SystemSettingView:_clearPaintCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.paintImg = goutil.findChild(goCell, "paintImg")
	cell.goBtnSelect = goutil.findChild(goCell, "btnSelect")
	cell.btnSelect = goutil.findChildButtonComponent(goCell, "btnSelect")
	cell.goProgress = goutil.findChild(goCell, "progress")
	cell.progress = goutil.findChildComponent(goCell, "progress", "Slider")
	cell.goDownload = goutil.findChild(goCell, "download")
	cell.goTxtProgress = goutil.findChild(goCell, "txtProgress")
	cell.txtProgress = goutil.findChildTextComponent(goCell, "txtProgress")
	cell.goNoGet = goutil.findChild(goCell, "noGet")

	GameUtil.rmClickHandler(cell.go)

	return cell
end

function SystemSettingView:_onClickDownloadPaint()
	FloatWordMgr.instance:show("后续版本开放下载")
end

function SystemSettingView:_onClickDelRole()
	local content = lang("zhuxiao_popup_1")

	TipsFacade.instance:openPopupWindow("注销说明", content, function()
		UIStateManager.instance:push(ViewName.HuaweialertView)
	end)
end

function SystemSettingView:_onClickPaintItem(bigBgUrl)
	UIStateManager.instance:push(ViewName.SeasonPaintDisplayView, bigBgUrl)
end

function SystemSettingView:_onEnterPaint()
	GlobalDispatcher:addListener(GlobalNotify.SeasonFragmentUpdate, self._refreshPaintTab, self)
end

function SystemSettingView:_onExitPaint()
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFragmentUpdate, self._refreshPaintTab, self)

	if self._paintTableView then
		self._paintTableView:dispose()
	end
end

function SystemSettingView:_getSwitchPk()
	if not self._needPkRefresh then
		return
	end

	self._needPkRefresh = false

	self:_refreshPk()
	self:_setTabShowByIndex(SystemSettingView.TabId.Youxi)
end

function SystemSettingView:_onSetSwitch()
	local switch, stranger = TraincampqiecuoModel.instance:getPkSwitch()

	goutil.setActive(self._pkOpenOn, switch)
	goutil.setActive(self._pkStrangerOn, stranger)
end

function SystemSettingView:_onClickbtnAI()
	local roleName = RoleModel.instance:getUserName()
	local serverId = RoleModel.instance:getAreaId()

	SDKManager.openAiCustomerService(roleName, serverId)
end

function SystemSettingView:_onClickComment()
	SDKManager.openReviewInTapTap()
end

function SystemSettingView:_onClickPrivateProtocal()
	if Framework.OSDef.RunOS == Framework.OSDef.Android then
		SDKManager.showPrivacyView()
	else
		ViewMgr.instance:open(ViewName.UserProtocalView, 1)
	end
end

function SystemSettingView:_updateCell(view, cell, data, tag)
	local txtTitle = goutil.findChildTextComponent(cell, "Text")
	local change = cell.gameObject:GetComponent(ComponentType.UIChangeGroup)
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local redGo = goutil.findChild(cell, "redpoint")

	change:SetState(self._curSelectId == data.id and 1 or 0)

	txtTitle.text = data.title

	RedPointController.instance:regRedPoint(redGo, GameUtil.unpack10(data.redpointIds))
	btn:AddClickListener(function()
		self:_onClickTab(data)
	end)
end

function SystemSettingView:_clearCell(cell)
	local redGo = goutil.findChild(cell, "redpoint")

	RedPointController.instance:unregRedPoint(redGo)
end

function SystemSettingView:_onClickTab(tabData)
	self._curSelectId = tabData.id

	self._scrollerList:refresh()
	self:showTabAt()

	if not string.nilorempty(tabData.viewName) then
		self:showTabAt(self._containerGo, tabData.viewName)
	else
		self:showTabAt()
	end

	self:_setTabShowByIndex(tabData.id)
end

function SystemSettingView:_calTabDatas()
	local datas = {}

	for k, v in pairs(SystemSettingView.TabConfigs) do
		table.insert(datas, v)
	end

	table.sort(datas, function(a, b)
		return a.id < b.id
	end)

	return datas
end

return SystemSettingView
