-- chunkname: @modules/logic/gm/view/GMToolView.lua

module("modules.logic.gm.view.GMToolView", package.seeall)

local GMToolView = class("GMToolView", BaseView)

function GMToolView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._btnOK1 = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item1/btnOK")
	self._btnCommand = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item1/btnCommand")
	self._inp1 = gohelper.findChildInputField(self.viewGO, "viewport/content/item1/inpText")
	self._inp21 = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item2/inpItem")
	self._inp22 = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item2/inpNum")
	self._btnOK2 = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item2/btnOK")
	self._txtServerTime = gohelper.findChildText(self.viewGO, "viewport/content/item3/txtServerTime")
	self._txtLocalTime = gohelper.findChildText(self.viewGO, "viewport/content/item3/txtLocalTime")
	self._scroll = gohelper.findChildScrollRect(self.viewGO, "viewport")
	self._btnOK4 = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item4/btnOK")
	self._toggleEar = gohelper.findChildToggle(self.viewGO, "viewport/content/item4/earToggle")
	self._btnQualityLow = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item5/btnQualityLow")
	self._btnQualityMid = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item5/btnQualityMid")
	self._btnQualityHigh = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item5/btnQualityHigh")
	self._btnQualityNo = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item5/btnQualityNo")
	self._btnPP = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item5/btnPP")
	self._btnSetting = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item5/btnSetting")
	self._txtBtnPP = gohelper.findChildText(self.viewGO, "viewport/content/item5/btnPP/Text")
	self._txtAccountId = gohelper.findChildText(self.viewGO, "viewport/content/item40/Text")
	self._btnNewbiePrepare = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item40/btnNewbiePrepare")
	self._imgQualitys = {
		self._btnQualityNo.gameObject:GetComponent(gohelper.Type_Image),
		self._btnQualityHigh.gameObject:GetComponent(gohelper.Type_Image),
		self._btnQualityMid.gameObject:GetComponent(gohelper.Type_Image),
		self._btnQualityLow.gameObject:GetComponent(gohelper.Type_Image)
	}
	self._txtSpeed = gohelper.findChildText(self.viewGO, "viewport/content/item6/Text")
	self._sliderSpeed = gohelper.findChildSlider(self.viewGO, "viewport/content/item6/Slider")
	self._btnClearPlayerPrefs = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item7/btnClearPlayerPrefs")
	self._btnBlockLog = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item7/btnBlockLog")
	self._btnProtoTestView = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item8/Button")
	self._btnfastaddhero = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item8/#btn_addhero")
	self._inpTestFight = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item9/inpText")
	self._btnTestFight = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item9/btnTestFight")
	self._btnTestFightId = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item9/btnTestFightId")
	self._btnPostProcess = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item10/Button")
	self._btnEffectStat = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item10/btnEffectStat")
	self._btnIgnoreSomeMsgLog = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item11/Button")
	self._btnFightJoin = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item11/btnFightJoin")
	self._inpSpeed1 = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item11/inpSpeed1")
	self._inpSpeed2 = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item11/inpSpeed2")
	self._btnCurSpeed = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item11/btnCurSpeed")
	self._btnHideDebug = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item12/Button")
	self._btnShowError = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item12/btnError")
	self._inpJump = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item13/inpText")
	self._btnJumpOK = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item13/btnOK")
	self._inpGuide = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item14/inpText")
	self._btnGuideStart = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item14/btnStart")
	self._btnGuideFinish = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item14/btnFinish")
	self._btnGuideForbid = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item14/btnForbid")
	self._btnGuideReset = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item14/btnReset")
	self._inpEpisode = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item18/inpText")
	self._btnEpisodeOK = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item18/btnOK")
	self._btnSkinOffsetAdjust = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item20/Button")
	self._btnFightFocusAdjust = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item20/Button1")
	self._toggleSkipPatFace = gohelper.findChildToggle(self.viewGO, "viewport/content/skipPatFace/toggleSkipPatFace")
	self._btnGuideEditor = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/guideEditor/Button")
	self._btnHelpViewBrowse = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/guideEditor/btnHelpViewBrowse")
	self._btnGuideStatus = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item14/btnGuideStatus")
	self._inpScreenWidth = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item24/inpTextWidth")
	self._inpScreenHeight = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item24/inpTextHeight")
	self._btnConfirm = gohelper.getClick(gohelper.findChild(self.viewGO, "viewport/content/item24/btnConfirm"))
	self._dropSkinGetView = gohelper.findChildDropdown(self.viewGO, "viewport/content/item25/Dropdown")
	self._btnOpenSeasonView = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item27/ButtonSeason")
	self._inptSeason = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item27/inpTextSeason")
	self._btnOpenHuaRongView = gohelper.getClick(gohelper.findChild(self.viewGO, "viewport/content/item27_2/huarong"))
	self._inpChangeColor = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item27_2/changecolor/inpchangecolortxt")
	self._btnChangeColorOK = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item27_2/changecolor/btnchangecolorok")
	self._btnFightSimulate = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item333/btnOK")
	self._btnResetCards = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item333/btnOK2")
	self._btnFightEntity = gohelper.getClick(gohelper.cloneInPlace(self._btnFightSimulate.gameObject))
	gohelper.findChildText(self._btnFightEntity.gameObject, "Text").text = "战中外挂"

	recthelper.setWidth(self._btnFightEntity.transform, 200)
	recthelper.setWidth(self._btnFightSimulate.transform, 200)
	recthelper.setWidth(self._btnResetCards.transform, 200)
	recthelper.setAnchorX(self._btnFightEntity.transform, 0)
	recthelper.setAnchorX(self._btnFightSimulate.transform, -220)
	recthelper.setAnchorX(self._btnResetCards.transform, 220)

	self._dropHeroFaith = gohelper.findChildDropdown(self.viewGO, "viewport/content/item34/Dropdown")
	self._btnHeroFaith = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item34/btnOK")
	self._dropHeroLevel = gohelper.findChildDropdown(self.viewGO, "viewport/content/item36/Dropdown")
	self._btnHeroLevel = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item36/btnOK")
	self._inpHeroLevel = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item36/inpNum")
	self._dropWeather = gohelper.findChildDropdown(self.viewGO, "viewport/content/item38/Dropdown")
	self._btnGetAllHero = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item35/Button1")
	self._btnDeleteAllHeroInfo = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item35/Button2")
	self._btnHideGM = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item37/Button1")
	self._txtGM = gohelper.findChildText(self.viewGO, "viewport/content/item37/Button1/Text")
	self._btnUnLockAllEpisode = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item37/Button2")
	self._btnExplore = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item39/Button1")
	self._inpExplore = gohelper.findChildInputField(self.viewGO, "viewport/content/item39/inpText")
	self._btnshowHero = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item40/Button1")
	self._btnshowUI = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item40/Button2")
	self._btnshowHeroDia = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item40/Button3")
	self._btnshowId = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item42/btn_userid")
	self._btnwatermark = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item42/btn_watermark")
	self._txtshowHero = gohelper.findChildText(self.viewGO, "viewport/content/item40/Button1/Text")
	self._txtshowUI = gohelper.findChildText(self.viewGO, "viewport/content/item40/Button2/Text")
	self._txtshowHeroDia = gohelper.findChildText(self.viewGO, "viewport/content/item40/Button3/Text")
	self._txtshowId = gohelper.findChildText(self.viewGO, "viewport/content/item42/btn_userid/Text")
	self._txtwatermark = gohelper.findChildText(self.viewGO, "viewport/content/item42/btn_watermark/Text")
	self._btncopytalentdata = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item41/btn_copy_talent_data")
	self._btnprintallentitybuff = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item41/btn_print_all_entity_buff")
	self._btnReplaceSummonHero = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item46/Button1")
	self._inpHeroList = gohelper.findChildInputField(self.viewGO, "viewport/content/item46/inpText")

	self._inpHeroList:SetText("3039;3052;3017;3010;3015;3013;3031;3006;3040;3012")

	self._btnCrash1 = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/crash/btnCrash1")
	self._btnCrash2 = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/crash/btnCrash2")
	self._btnCrash3 = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/crash/btnCrash3")
	self._btnEnterView = gohelper.findChildButton(self.viewGO, "viewport/content/item50/Button")
	self._inpViewName = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/item50/InputField (TMP)")
end

function GMToolView:addEvents()
	self._scroll:AddOnValueChanged(self._onScrollValueChanged, self)
	self._btnClose:AddClickListener(self.closeThis, self)
	self._btnOK1:AddClickListener(self._onClickBtnOK1, self)
	self._btnCommand:AddClickListener(self._onClickBtnCommand, self)
	self._btnOK2:AddClickListener(self._onClickBtnOK2, self)
	self._btnOK4:AddClickListener(self._onClickBtnOK4, self)
	self._toggleEar:AddOnValueChanged(self._onEarToggleValueChange, self)
	self._btnQualityLow:AddClickListener(self._onClickBtnQualityLow, self)
	self._btnQualityMid:AddClickListener(self._onClickBtnQualityMid, self)
	self._btnQualityHigh:AddClickListener(self._onClickBtnQualityHigh, self)
	self._btnQualityNo:AddClickListener(self._onClickBtnQualityNo, self)
	self._btnPP:AddClickListener(self._onClickBtnPP, self)
	self._btnSetting:AddClickListener(self._onClickBtnSetting, self)
	SLFramework.UGUI.UIClickListener.Get(self._txtSpeed.gameObject):AddClickListener(self._onClickSpeedText, self)

	if self._btnNewbiePrepare then
		self._btnNewbiePrepare:AddClickListener(self._onClickBtnNewbiePrepare, self)
	end

	self._sliderSpeed:AddOnValueChanged(self._onSpeedChange, self)
	self._btnClearPlayerPrefs:AddClickListener(self._onClickBtnClearPlayerPrefs, self)
	self._btnBlockLog:AddClickListener(self._onClickBtnBlockLog, self)
	self._btnProtoTestView:AddClickListener(self._onClickBtnProtoTestView, self)
	self._btnfastaddhero:AddClickListener(self._onClickBtnFastAddHero, self)
	self._btnTestFight:AddClickListener(self._onClickTestFight, self)
	self._btnTestFightId:AddClickListener(self._onClickTestFightId, self)
	self._btnPostProcess:AddClickListener(self._onClickPostProcess, self)
	self._btnEffectStat:AddClickListener(self._onClickEffectStat, self)
	self._btnIgnoreSomeMsgLog:AddClickListener(self._onClickIgnoreSomeMsgLog, self)
	self._btnFightJoin:AddClickListener(self._onClickFightJoin, self)
	self._btnHideDebug:AddClickListener(self._onClickHideBug, self)
	self._btnShowError:AddClickListener(self._onClickShowError, self)
	self._btnSkinOffsetAdjust:AddClickListener(self._onClickSkinOffsetAdjust, self)
	self._btnFightFocusAdjust:AddClickListener(self._onClickFightFocusAdjust, self)

	if self._toggleSkipPatFace then
		self._toggleSkipPatFace:AddOnValueChanged(self._onSkipPatFaceToggleValueChange, self, "123")
	end

	self._btnGuideEditor:AddClickListener(self._onClickGuideEditor, self)
	self._btnHelpViewBrowse:AddClickListener(self._onClickHelpViewBrowse, self)
	self._btnGuideStatus:AddClickListener(self._onClickGuideStatus, self)
	self._btnJumpOK:AddClickListener(self._onClickJumpOK, self)
	self._btnEpisodeOK:AddClickListener(self._onClickEpisodeOK, self)
	self._btnGuideStart:AddClickListener(self._onClickGuideStart, self)
	self._btnGuideFinish:AddClickListener(self._onClickGuideFinish, self)
	self._btnGuideForbid:AddClickListener(self._onClickGuideForbid, self)
	self._btnGuideReset:AddClickListener(self._onClickGuideReset, self)
	self._btnChangeColorOK:AddClickListener(self._onClickChangeColorOK, self)
	self._btnFightSimulate:AddClickListener(self._onClickFightSimulate, self)
	self._btnFightEntity:AddClickListener(self._onClickFightEntity, self)
	self._btnResetCards:AddClickListener(self._onClickResetCards, self)
	self._btnHeroFaith:AddClickListener(self._onClickHeroFaithOk, self)
	self._btnHeroLevel:AddClickListener(self._onClickHeroLevelOk, self)
	self._dropSkinGetView:AddOnValueChanged(self._onSkinGetValueChanged, self)
	self._dropHeroFaith:AddOnValueChanged(self._onHeroFaithSelectChanged, self)
	self._dropHeroLevel:AddOnValueChanged(self._onHeroLevelSelectChanged, self)
	self._btnGetAllHero:AddClickListener(self._onClickGetAllHeroBtn, self)
	self._btnDeleteAllHeroInfo:AddClickListener(self._onClickDeleteAllHeroInfoBtn, self)
	self._btnHideGM:AddClickListener(self._onClickHideGMBtn, self)
	self._btnUnLockAllEpisode:AddClickListener(self._onClickUnLockAllEpisode, self)
	self._btnOpenHuaRongView:AddClickListener(self._onClickOpenHuaRongViewBtn, self)
	self._btnOpenSeasonView:AddClickListener(self._onClickOpenSeasonViewBtn, self)

	if not SLFramework.FrameworkSettings.IsEditor and BootNativeUtil.isWindows() then
		self._btnConfirm:AddClickListener(self._onClickScreenSize, self)
	end

	self._btnExplore:AddClickListener(self._onClickExplore, self)
	self._inpSpeed1:AddOnEndEdit(self._onEndEdit1, self)
	self._inpSpeed2:AddOnEndEdit(self._onEndEdit2, self)
	self._btnshowHero:AddClickListener(self._onClickShowHero, self)
	self._btnshowUI:AddClickListener(self._onClickShowUI, self)
	self._btnshowHeroDia:AddClickListener(self._onClickShowHeroDia, self)
	self._btnshowId:AddClickListener(self._onClickShowID, self)
	self._btnwatermark:AddClickListener(self._onClickWaterMark, self)
	self._btnCurSpeed:AddClickListener(self._onClickCurSpeed, self)
	self._btncopytalentdata:AddClickListener(self._onBtnCopyTalentData, self)
	self._btnReplaceSummonHero:AddClickListener(self._OnBtnReplaceSummonHeroClick, self)

	if self._btnprintallentitybuff then
		self._btnprintallentitybuff:AddClickListener(self._onBtnPrintAllEntityBuff, self)
	end

	self._AddClickListener(self, self._btnCrash1, self._testJavaCrash, self)
	self._AddClickListener(self, self._btnCrash2, self._testOcCrash, self)
	self._AddClickListener(self, self._btnCrash3, self._testNativeCrash, self)
	self._btnEnterView:AddClickListener(self._onClickEnterView, self)
end

function GMToolView:removeEvents()
	self._scroll:RemoveOnValueChanged()
	self._btnClose:RemoveClickListener()
	self._btnOK1:RemoveClickListener()
	self._btnCommand:RemoveClickListener()
	self._btnOK2:RemoveClickListener()
	self._btnOK4:RemoveClickListener()
	self._toggleEar:RemoveOnValueChanged()
	self._btnQualityLow:RemoveClickListener()
	self._btnQualityMid:RemoveClickListener()
	self._btnQualityHigh:RemoveClickListener()
	self._btnQualityNo:RemoveClickListener()
	self._btnPP:RemoveClickListener()

	if self._btnNewbiePrepare then
		self._btnNewbiePrepare:RemoveClickListener()
	end

	self._btnSetting:RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(self._txtSpeed.gameObject):RemoveClickListener()
	self._sliderSpeed:RemoveOnValueChanged()
	self._btnClearPlayerPrefs:RemoveClickListener()
	self._btnBlockLog:RemoveClickListener()
	self._btnProtoTestView:RemoveClickListener()
	self._btnfastaddhero:RemoveClickListener()
	self._btnTestFight:RemoveClickListener()
	self._btnTestFightId:RemoveClickListener()
	self._btnPostProcess:RemoveClickListener()
	self._btnEffectStat:RemoveClickListener()
	self._btnIgnoreSomeMsgLog:RemoveClickListener()
	self._btnFightJoin:RemoveClickListener()
	self._btnHideDebug:RemoveClickListener()
	self._btnShowError:RemoveClickListener()
	self._btnSkinOffsetAdjust:RemoveClickListener()
	self._btnFightFocusAdjust:RemoveClickListener()

	if self._toggleSkipPatFace then
		self._toggleSkipPatFace:RemoveOnValueChanged()
	end

	self._btnGuideEditor:RemoveClickListener()
	self._btnHelpViewBrowse:RemoveClickListener()
	self._btnGuideStatus:RemoveClickListener()
	self._btnJumpOK:RemoveClickListener()
	self._btnGuideStart:RemoveClickListener()
	self._btnGuideFinish:RemoveClickListener()
	self._btnGuideForbid:RemoveClickListener()
	self._btnGuideReset:RemoveClickListener()
	self._btnChangeColorOK:RemoveClickListener()
	self._btnFightSimulate:RemoveClickListener()
	self._btnFightEntity:RemoveClickListener()
	self._btnResetCards:RemoveClickListener()
	self._btnEpisodeOK:RemoveClickListener()
	self._btnHeroFaith:RemoveClickListener()
	self._btnHeroLevel:RemoveClickListener()
	self._dropSkinGetView:RemoveOnValueChanged()
	self._dropHeroFaith:RemoveOnValueChanged()
	self._dropHeroLevel:RemoveOnValueChanged()
	self._dropWeather:RemoveOnValueChanged()
	self._btnGetAllHero:RemoveClickListener()
	self._btnDeleteAllHeroInfo:RemoveClickListener()
	self._btnHideGM:RemoveClickListener()
	self._btnUnLockAllEpisode:RemoveClickListener()
	self._btnOpenHuaRongView:RemoveClickListener()
	self._btnOpenSeasonView:RemoveClickListener()

	if not SLFramework.FrameworkSettings.IsEditor and BootNativeUtil.isWindows() then
		self._btnConfirm:RemoveClickListener()
	end

	self._btnExplore:RemoveClickListener()
	self._inpSpeed1:RemoveOnEndEdit()
	self._inpSpeed2:RemoveOnEndEdit()
	self._btnshowHero:RemoveClickListener()
	self._btnshowUI:RemoveClickListener()
	self._btnshowHeroDia:RemoveClickListener()
	self._btnshowId:RemoveClickListener()
	self._btnwatermark:RemoveClickListener()
	self._btnCurSpeed:RemoveClickListener()
	self._btncopytalentdata:RemoveClickListener()
	self._btnReplaceSummonHero:RemoveClickListener()

	if self._btnprintallentitybuff then
		self._btnprintallentitybuff:RemoveClickListener()
	end

	self:_RemoveClickListener(self._btnCrash1)
	self:_RemoveClickListener(self._btnCrash2)
	self:_RemoveClickListener(self._btnCrash3)
	self._btnEnterView:RemoveClickListener()
end

function GMToolView:_AddClickListener(btn, callback, cbObj)
	if btn then
		btn:AddClickListener(callback, cbObj)
	end
end

function GMToolView:_RemoveClickListener(btn)
	if btn then
		btn:RemoveClickListener()
	end
end

function GMToolView:_AddOnValueChanged(slider, callback, cbObj)
	if slider then
		slider:AddOnValueChanged(callback, cbObj)
	end
end

function GMToolView:_RemoveOnValueChanged(slider)
	if slider then
		slider:RemoveOnValueChanged()
	end
end

function GMToolView:onDestroyView()
	return
end

function GMToolView:onOpen()
	self.initDone = false
	self.selectHeroLevelId = 0
	self.selectHeroFaithId = 0
	self._prePlayingAudioId = 0
	self.showHero = PlayerPrefsHelper.getNumber(PlayerPrefsKey.ShowHeroKey, 1) == 1
	self.showUI = PlayerPrefsHelper.getNumber(PlayerPrefsKey.ShowUIKey, 1) == 1
	self.showHeroDia = PlayerPrefsHelper.getNumber(PlayerPrefsKey.ShowHeroDiaKey, 1) == 1
	self.showID = PlayerPrefsHelper.getNumber(PlayerPrefsKey.ShowIDKey, 1) == 1
	self.showWaterMark = OpenConfig.instance:isShowWaterMarkConfig()

	self:_showHero()
	self:_showUI()
	self:_showHeroDia()
	self:_showID()
	self:_showWaterMark()

	self._txtAccountId.text = "账号:" .. (LoginModel.instance.userName or "nil")
	self._scroll.verticalNormalizedPosition = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewScroll, 1)

	self._inp1:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewGeneral, ""))
	self._inpViewName:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewOpenView, ""))
	self._inp21:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewAddItem1, ""))
	self._inp22:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewAddItem2, ""))
	self._inpTestFight:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewTestFight, ""))
	self._inpJump:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewJump, ""))
	self._inpGuide:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewGuide, ""))
	self._inpEpisode:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewEpisode, ""))

	self._toggleEar.isOn = SDKMgr.instance:isEarphoneContact()

	if self._toggleSkipPatFace then
		self._toggleSkipPatFace.isOn = PatFaceModel.instance:getIsSkipPatFace()
	end

	TaskDispatcher.runRepeat(self._updateServerTime, self, 0.2)
	self:_updateQualityBtn()
	self:_updateSpeedText()
	self:_refreshPP()
	self:_updateHeartBeatLogText()
	self:_updateLogStateText()
	self:_initScreenSize()
	self:_initSkinViewSelect()
	self:_initHeroFaithSelect()
	self:_initHeroLevelSelect()
	self:_initWeatherSelect()
	self:_refreshGMBtnText()

	self.initDone = true

	self:_updateFightJoinText()
	self:_updateFightSpeedText()
end

function GMToolView:onClose()
	TaskDispatcher.cancelTask(self._updateServerTime, self, 0.2)
end

function GMToolView:_onScrollValueChanged(x, y)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewScroll, y)
end

function GMToolView:_updateServerTime()
	local t = os.date("!*t", ServerTime.now() + ServerTime.serverUtcOffset())

	self._txtServerTime.text = string.format("%04d-%02d-%02d %02d:%02d:%02d", t.year, t.month, t.day, t.hour, t.min, t.sec)
	self._txtLocalTime.text = os.date("%Y-%m-%d %H:%M:%S", os.time())
end

function GMToolView:_onClickBtnOK1()
	local input = self._inp1:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGeneral, input)

	local delay = 0
	local setDungeonCmd

	for oneLine in input:gmatch("[^\r\n]+") do
		if not string.nilorempty(oneLine) then
			if string.find(oneLine, "set dungeon") then
				setDungeonCmd = oneLine
			else
				if delay == 0 then
					self:_sendGM(oneLine)
				else
					TaskDispatcher.runDelay(function()
						self:_sendGM(oneLine)
					end, nil, delay)
				end

				delay = delay + 0.1
			end
		end
	end

	if setDungeonCmd then
		if delay == 0 then
			self:_sendGM(setDungeonCmd)
		else
			TaskDispatcher.runDelay(function()
				self:_sendGM(setDungeonCmd)
			end, nil, delay)
		end
	end
end

function GMToolView:_sendGM(input)
	GameFacade.showToast(ToastEnum.IconId, input)

	if input:find("bossrush") then
		BossRushController_Test.instance:_test(input)

		return
	end

	GMCommandHistoryModel.instance:addCommandHistory(input)

	local tar = "小瑞安依"

	if string.sub(input, 1, #tar) == tar then
		TravelGoController.instance:exeGM(input)

		return
	end

	if string.find(input, "#") == 1 then
		local param = string.split(input, " ")

		self:_clientGM(param)

		return
	end

	GMRpc.instance:sendGMRequest(input)
	self:_onServerGM(input)
end

function GMToolView:_onServerGM(input)
	if string.find(input, "delete%sexplore") then
		PlayerPrefsHelper.deleteKey(PlayerPrefsKey.ExploreRedDotData .. PlayerModel.instance:getMyUserId())
		ExploreSimpleModel.instance:reInit()
		ExploreRpc.instance:sendGetExploreSimpleInfoRequest()
	end

	if string.find(input, "diceFightWin") then
		TaskDispatcher.runDelay(function()
			if DiceHeroFightModel.instance.finishResult ~= DiceHeroEnum.GameStatu.None then
				ViewMgr.instance:openView(ViewName.DiceHeroResultView, {
					status = DiceHeroFightModel.instance.finishResult
				})
				DiceHeroStatHelper.instance:sendFightEnd(DiceHeroFightModel.instance.finishResult, DiceHeroFightModel.instance.isFirstWin)

				DiceHeroFightModel.instance.finishResult = DiceHeroEnum.GameStatu.None
			end
		end, self, 0.5)
	end
end

function GMToolView:_clientGM(param)
	local cmdName = param[1]:sub(2)

	GMCommand.processCmd(cmdName, unpack(param, 2))
end

function GMToolView:_onClickBtnCommand()
	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
		UnityEngine.Application.OpenURL("http://doc.sl.com/pages/viewpage.action?pageId=3342342")

		return
	end

	GMController.instance:dispatchEvent(GMCommandView.OpenCommand)
end

function GMToolView:_onClickBtnOK2()
	local itemTypeIdStr = self._inp21:GetText()
	local numStr = self._inp22:GetText()
	local itemTypeIdStrs = string.split(itemTypeIdStr, "#")
	local itemType = itemTypeIdStrs[1]
	local itemId = tonumber(itemTypeIdStrs[2])
	local num = 1

	if not string.nilorempty(numStr) then
		num = tonumber(numStr)
	end

	if num and num < 0 then
		GameFacade.showToast(ToastEnum.GMTool1, itemId)
		GMRpc.instance:sendGMRequest(string.format("delete material %d#%d#%d", itemType, itemId, -num))

		return
	end

	if tonumber(itemType) == MaterialEnum.MaterialType.Hero then
		GameFacade.showToast(ToastEnum.GMTool2, itemId)
		GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", MaterialEnum.MaterialType.Hero, itemId, num))
	elseif itemType == GMAddItemView.LevelType then
		GameFacade.showToast(ToastEnum.GMTool3, num)
		GMRpc.instance:sendGMRequest(string.format("set level %d", num))
	elseif tonumber(itemType) == MaterialEnum.MaterialType.Exp then
		GameFacade.showToast(ToastEnum.GMTool4, num)
		GMRpc.instance:sendGMRequest(string.format("add material 3#0#%d", num))
	elseif itemTypeIdStrs[1] == GMAddItemView.HeroAttr then
		local sp = string.splitToNumber(numStr, "#")

		if not sp[1] then
			if not sp[2] then
				local p2 = 3

				if not sp[3] then
					local p3 = 10

					if not sp[4] then
						local p4 = 0

						GameFacade.showToast(ToastEnum.GMToolFastAddHero, string.format(" 等级%d 洞悉%d 共鸣%d 塑造%d", sp[1], p2, p3, p4))
						GMRpc.instance:sendGMRequest(string.format("add heroAttr %d#%d#%d#%d#%d", itemId, sp[1], p2, p3, p4))
					end
				end
			end
		end
	else
		GameFacade.showToast(ToastEnum.GMTool5, itemId)
		GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", itemType, itemId, num))
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewAddItem1, itemTypeIdStr)
	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewAddItem2, numStr)
end

function GMToolView:_onClickBtnOK4()
	GMRpc.instance:sendGMRequest("logout")
	LoginController.instance:logout()
end

function GMToolView:_updateQualityBtn()
	local qualitySetting = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.Undefine)

	for i, imgQuality in ipairs(self._imgQualitys) do
		if i == qualitySetting + 1 then
			imgQuality.color = Color.green or Color.white
		end
	end
end

function GMToolView:_onClickBtnQualityLow()
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.Low)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.Low)
	FightEffectPool.dispose()
	self:_updateQualityBtn()
end

function GMToolView:_onClickBtnQualityMid()
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.Middle)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.Middle)
	FightEffectPool.dispose()
	self:_updateQualityBtn()
end

function GMToolView:_onClickBtnQualityHigh()
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.High)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.High)
	FightEffectPool.dispose()
	self:_updateQualityBtn()
end

function GMToolView:_onClickBtnQualityNo()
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewQuality, ModuleEnum.Performance.Undefine)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(ModuleEnum.Performance.Undefine)
	FightEffectPool.dispose()
	self:_updateQualityBtn()
end

function GMToolView:_onClickBtnPP()
	GMPostProcessModel.instance.ppType = (GMPostProcessModel.instance.ppType + 1) % 4

	self:_refreshPP()
end

function GMToolView:_onClickBtnSetting()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenSettingFinish, self)
	SettingsController.instance:openView()
end

function GMToolView:_onClickBtnNewbiePrepare()
	self:_sendGM("gmSet onekey")
end

function GMToolView:_onOpenSettingFinish(viewName)
	if viewName == ViewName.SettingsView then
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenSettingFinish, self)

		local viewContainer = ViewMgr.instance:getContainer(ViewName.SettingsView)

		viewContainer:switchTab(3)
	end
end

function GMToolView:_refreshPP()
	if GMPostProcessModel.instance.ppType == 0 then
		PostProcessingMgr.instance:setUIActive(false)
		PostProcessingMgr.instance:setUnitActive(false)

		self._txtBtnPP.text = "OFF"
	elseif GMPostProcessModel.instance.ppType == 1 then
		PostProcessingMgr.instance:setUIActive(true)
		PostProcessingMgr.instance:setUnitActive(false)

		self._txtBtnPP.text = "UI"
	elseif GMPostProcessModel.instance.ppType == 2 then
		PostProcessingMgr.instance:setUIActive(false)
		PostProcessingMgr.instance:setUnitActive(true)

		self._txtBtnPP.text = "Unit"
	else
		PostProcessingMgr.instance:setUIActive(true)
		PostProcessingMgr.instance:setUnitActive(true)

		self._txtBtnPP.text = "ALL"
	end
end

function GMToolView:_updateSpeedText()
	local value = GameTimeMgr.instance:getTimeScale(GameTimeMgr.TimeScaleType.GM)

	self._sliderSpeed:SetValue(value)

	self._txtSpeed.text = string.format("Speed x%.2f", value)
end

function GMToolView:_onClickSpeedText()
	self:_onSpeedChange(nil, 1)
end

function GMToolView:_onSpeedChange(param, value)
	self._sliderSpeed:SetValue(value)

	self._txtSpeed.text = string.format("Speed x%.2f", value)

	GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.GM, value)
end

function GMToolView:_onClickBtnClearPlayerPrefs()
	PlayerPrefsHelper.deleteAll()
	GameFacade.showToast(ToastEnum.GMToolClearPlayerPrefs)
end

function GMToolView:_onClickBtnBlockLog()
	local newLogState = not getGlobal("canLogNormal")

	setGlobal("canLogNormal", newLogState)
	setGlobal("canLogWarn", newLogState)
	setGlobal("canLogError", newLogState)

	SLFramework.SLLogger.CanLogNormal = newLogState
	SLFramework.SLLogger.CanLogWarn = newLogState
	SLFramework.SLLogger.CanLogError = newLogState
	GuideController.EnableLog = newLogState

	self:_updateLogStateText()
end

function GMToolView:_updateLogStateText()
	local txt = gohelper.findChildText(self._btnBlockLog.gameObject, "Text")

	txt.text = getGlobal("canLogNormal") and "屏蔽所有log" or "恢复所有log"
end

function GMToolView:_onClickBtnProtoTestView()
	self:closeThis()
	ViewMgr.instance:openView(ViewName.ProtoTestView)
end

function GMToolView:_onClickTestFight()
	local inputText = self._inpTestFight:GetText()

	if not string.nilorempty(inputText) then
		local temp = string.splitToNumber(inputText, "#")

		if #temp > 0 then
			PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewTestFight, inputText)
			HeroGroupModel.instance:setParam(nil, nil, nil)

			local curGroupMO
			local groupList = HeroGroupPresetHeroGroupChangeController.instance:getHeroGroupList(HeroGroupPresetEnum.HeroGroupType.Common)

			for i, v in ipairs(groupList) do
				local count = 0

				for index, heroId in ipairs(v.heroList) do
					if heroId ~= "0" then
						count = count + 1
					end
				end

				if count > 0 then
					curGroupMO = v

					break
				end
			end

			if not curGroupMO then
				logError("current HeroGroupMO is nil")
				GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

				return
			end

			local main, mainCount = curGroupMO:getMainList()
			local sub, subCount = curGroupMO:getSubList()
			local equips = curGroupMO:getAllHeroEquips()

			self:closeThis()

			local fightParam = FightParam.New()

			fightParam.monsterGroupIds = temp
			fightParam.isTestFight = true

			fightParam:setSceneLevel(10601)
			fightParam:setMySide(curGroupMO.clothId, main, sub, equips)
			FightModel.instance:setFightParam(fightParam)
			FightController.instance:sendTestFight(fightParam)

			return
		end
	end

	logError("please input monsterGroupIds, split with '#'")
end

function GMToolView:_onClickTestFightId()
	local inputText = self._inpTestFight:GetText()
	local battleId = tonumber(inputText)
	local battleCO = battleId and lua_battle.configDict[battleId]

	if battleCO then
		local fightParam = FightController.instance:setFightParamByBattleId(battleId)

		HeroGroupModel.instance:setParam(battleId, nil, nil)

		local curGroupMO
		local groupList = HeroGroupPresetHeroGroupChangeController.instance:getHeroGroupList(HeroGroupPresetEnum.HeroGroupType.Common)

		for i, v in ipairs(groupList) do
			local count = 0

			for index, heroId in ipairs(v.heroList) do
				if heroId ~= "0" then
					count = count + 1
				end
			end

			if count > 0 then
				curGroupMO = v

				break
			end
		end

		if not curGroupMO then
			logError("current HeroGroupMO is nil")
			GameFacade.showMessageBox(MessageBoxIdDefine.HeroGroupPleaseAdd, MsgBoxEnum.BoxType.Yes)

			return
		end

		local main, mainCount = curGroupMO:getMainList()
		local sub, subCount = curGroupMO:getSubList()
		local equips = curGroupMO:getAllHeroEquips()

		PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewTestFight, inputText)
		self:closeThis()

		for i, v in ipairs(lua_episode.configList) do
			if v.battleId == battleId then
				fightParam.episodeId = v.id
				FightResultModel.instance.episodeId = v.id

				DungeonModel.instance:SetSendChapterEpisodeId(v.chapterId, v.id)

				break
			end
		end

		fightParam.episodeId = fightParam.episodeId or 10101

		fightParam:setMySide(curGroupMO.clothId, main, sub, equips)
		FightController.instance:sendTestFightId(fightParam)
	end
end

function GMToolView:_onClickPostProcess()
	self:closeThis()
	ViewMgr.instance:openView(ViewName.GMPostProcessView)
end

function GMToolView:_onClickEffectStat()
	if ViewMgr.instance:isOpen(ViewName.SkillEffectStatView) then
		ViewMgr.instance:closeView(ViewName.SkillEffectStatView)
	else
		ViewMgr.instance:openView(ViewName.SkillEffectStatView)
	end
end

function GMToolView:_onClickIgnoreSomeMsgLog()
	if LuaSocketMgr.instance._ignoreSomeCmdLog then
		GMController.instance:resumeHeartBeatLog()
	else
		GMController.instance:ignoreHeartBeatLog()
	end

	self:_updateHeartBeatLogText()
end

function GMToolView:_updateHeartBeatLogText()
	gohelper.findChildText(self.viewGO, "viewport/content/item11/Button/Text").text = LuaSocketMgr.instance._ignoreSomeCmdLog and "恢复心跳打印" or "屏蔽心跳打印"
end

function GMToolView:_onClickFightJoin()
	FightModel.instance:switchGMFightJoin()
	self:_updateFightJoinText()
end

function GMToolView:_updateFightJoinText()
	gohelper.findChildText(self.viewGO, "viewport/content/item11/btnFightJoin/Text").text = FightModel.instance:isGMFightJoin() and "关闭战斗衔接" or "启用战斗衔接"
end

function GMToolView:_onEndEdit1(inputStr)
	self:_setFightSpeed()
end

function GMToolView:_onEndEdit2(inputStr)
	self:_setFightSpeed()
end

function GMToolView:_onClickCurSpeed()
	local normal = FightModel.instance._normalSpeed
	local replay = FightModel.instance._replaySpeed
	local replayUI = FightModel.instance._replayUISpeed

	logError("手动战斗速度：一倍" .. normal[1] .. " 二倍" .. normal[2])
	logError("战斗回溯速度：一倍" .. replay[1] .. " 二倍" .. replay[2])
	logError("战斗回溯UI速：一倍" .. replayUI[1] .. " 二倍" .. replayUI[2])
	logError("玩家选择速度：" .. FightModel.instance:getUserSpeed())
	logError("当前战斗速度：" .. FightModel.instance:getSpeed())
	logError("当前战斗UI速：" .. FightModel.instance:getUISpeed())
end

function GMToolView:_setFightSpeed()
	local normalSpeed = tonumber(self._inpSpeed1:GetText()) or 1
	local replaySpeed = tonumber(self._inpSpeed2:GetText()) or 1

	FightModel.instance:setGMSpeed(normalSpeed, replaySpeed)
	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
end

function GMToolView:_updateFightSpeedText()
	local normalSpeed = FightModel.instance:getNormalSpeed()
	local replaySpeed = FightModel.instance:getReplaySpeed()

	self._inpSpeed1:SetText(tostring(normalSpeed))
	self._inpSpeed2:SetText(tostring(replaySpeed))
end

function GMToolView:_onClickHideBug()
	local isShow = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewDebugView, 0) == 1

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewDebugView, isShow and 0 or 1)
	gohelper.setActive(GMController.debugViewGO, not isShow)
end

function GMToolView:_onClickShowError()
	GMLogController.instance:cancelBlock()
end

function GMToolView:_onClickSkinOffsetAdjust()
	if MainSceneSwitchModel.instance:getCurSceneId() ~= 1 then
		logError("请在箱中布景把主场景切换为《浪潮之初》才能调整皮肤偏移！")

		return
	end

	self:closeThis()
	NavigateButtonsView.homeClick()

	CharacterVoiceEnum.RTSizeLegacy = true

	ViewMgr.instance:openView(ViewName.SkinOffsetAdjustView)
end

function GMToolView:_onClickFightFocusAdjust()
	if not ViewMgr.instance:isOpen(ViewName.FightFocusView) then
		return
	end

	self:closeThis()
	ViewMgr.instance:openView(ViewName.FightFocusCameraAdjustView)
end

function GMToolView:_onSkipPatFaceToggleValueChange(param, isOn)
	if not self.initDone then
		return
	end

	PatFaceModel.instance:setIsSkipPatFace(isOn and true or false)
end

function GMToolView:_onClickGuideEditor()
	self:closeThis()
	ViewMgr.instance:openView(ViewName.GuideStepEditor)
end

function GMToolView:_onClickHelpViewBrowse()
	self:closeThis()
	ViewMgr.instance:openView(ViewName.GMHelpViewBrowseView)
end

function GMToolView:_onClickGuideStatus()
	self:closeThis()
	ViewMgr.instance:openView(ViewName.GMGuideStatusView)
end

function GMToolView:_onClickJumpOK()
	local input = self._inpJump:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewJump, input)
	self:closeThis()

	local jumpId = tonumber(input)

	if jumpId then
		GameFacade.jump(jumpId)
	else
		GameFacade.jumpByStr(input)
	end
end

function GMToolView:_onClickEpisodeOK()
	local input = self._inpEpisode:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewEpisode, input)

	local paramList = string.splitToNumber(input, "#")
	local episodeId = tonumber(paramList[1])
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	if config then
		self:closeThis()

		if DungeonModel.isBattleEpisode(config) then
			DungeonFightController.instance:enterFight(config.chapterId, config.id)
		else
			logError("GMToolView 不支持该类型的关卡" .. episodeId)
		end
	else
		logError("GMToolView 关卡id不正确")
	end
end

function GMToolView:_onClickGuideStart()
	self:closeThis()

	local text = self._inpGuide:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGuide, text)

	local paramList = string.splitToNumber(text, "#")
	local guideId = tonumber(paramList[1])
	local guideStep = tonumber(paramList[2]) or 0

	print(string.format("input guideId:%s,guideStep:%s", guideId, guideStep))

	local guideMO = GuideModel.instance:getById(guideId)

	GuideModel.instance:gmStartGuide(guideId, guideStep)

	if guideMO then
		GuideStepController.instance:clearFlow(guideId)

		guideMO.isJumpPass = false

		GMRpc.instance:sendGMRequest("delete guide " .. guideId)
		GuideRpc.instance:sendFinishGuideRequest(guideId, guideStep)
		logNormal(string.format("<color=#FFA500>set guideId:%s,guideStep:%s</color>", guideId, guideStep))
	elseif guideId then
		GuideController.instance:startGudie(guideId)
		logNormal("<color=#FFA500>start guide " .. guideId .. "</color>")
	end
end

function GMToolView:_onClickGuideFinish()
	local inputStr = self._inpGuide:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGuide, inputStr)

	if not string.nilorempty(inputStr) then
		local guideId = tonumber(inputStr)

		if guideId then
			local guideMO = GuideModel.instance:getById(guideId)

			self:closeThis()
			logNormal("GM one key finish guide " .. guideId)

			local stepList = GuideConfig.instance:getStepList(guideId)

			for j = #stepList, 1, -1 do
				local stepCO = stepList[j]

				if stepCO.keyStep == 1 then
					GuideRpc.instance:sendFinishGuideRequest(guideId, stepCO.stepId)

					break
				end
			end
		else
			local guideStep = string.split(inputStr, "#")

			logNormal("GM one key finish guide " .. inputStr)
			GuideRpc.instance:sendFinishGuideRequest(tonumber(guideStep[1]), tonumber(guideStep[2]))
		end
	else
		logNormal("GM one key finish guides")
		GuideStepController.instance:clearStep()
		GuideController.instance:oneKeyFinishGuides()
	end
end

function GMToolView:_onClickGuideForbid()
	local isForbid = GuideController.instance:isForbidGuides()

	GuideController.instance:forbidGuides(not isForbid)
end

function GMToolView:_onClickGuideReset()
	local text = self._inpGuide:GetText()

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewGuide, text)

	local paramList = string.splitToNumber(text, "#")
	local guideId = tonumber(paramList[1])
	local guideCfg = GuideConfig.instance:getGuideCO(guideId)

	if guideCfg then
		print(string.format("reset guideId:%s", guideId))
		GuideStepController.instance:clearFlow(guideId)
		GMRpc.instance:sendGMRequest("delete guide " .. guideId)

		local temp = string.split(guideCfg.trigger, "#")

		self:_resetEpisode(temp[1], temp[2])

		local invalidList = GameUtil.splitString2(guideCfg.invalid, false, "|", "#")

		if not invalidList then
			return
		end

		for _, one in ipairs(invalidList) do
			-- block empty
		end
	end
end

function GMToolView:_resetEpisode(type, episodeId)
	if type == "EpisodeFinish" or type == "EnterEpisode" then
		self:_doResetEpisode(tonumber(episodeId))

		return
	end

	local openConfig = lua_open.configDict[tonumber(episodeId)]

	if openConfig then
		self:_doResetEpisode(openConfig.episodeId)
	end
end

function GMToolView:_doResetEpisode(episodeId)
	local episodeCfg = lua_episode.configDict[episodeId]

	if not episodeCfg then
		return
	end

	GMRpc.instance:sendGMRequest(string.format("set dungeon %s 0", episodeId))

	if episodeCfg.beforeStory > 0 then
		print(episodeId .. " delete beforeStory")
		GMRpc.instance:sendGMRequest(string.format("delete story %s", episodeCfg.beforeStory))
	end

	if episodeCfg.afterStory > 0 then
		print(episodeId .. " delete afterStory")
		GMRpc.instance:sendGMRequest(string.format("delete story %s", episodeCfg.afterStory))
	end
end

function GMToolView:_onClickChangeColorOK()
	self:closeThis()

	local input = self._inpChangeColor:GetText()

	if not string.nilorempty(input) then
		local lvId = tonumber(input)

		if lvId then
			DungeonPuzzleChangeColorController.instance:enterDecryptChangeColor(lvId)
		end
	end
end

function GMToolView:_onClickFightSimulate()
	self:closeThis()
	ViewMgr.instance:openView(ViewName.GMFightSimulateView)
end

function GMToolView:_onClickFightEntity()
	self:closeThis()
	ViewMgr.instance:openView(ViewName.GMFightEntityView)
end

function GMToolView:_onClickResetCards()
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		self:closeThis()
		ViewMgr.instance:openView(ViewName.GMResetCardsView)
	else
		GameFacade.showToast(ToastEnum.IconId, "not in fight")
	end
end

function GMToolView:_initScreenSize()
	if BootNativeUtil.isWindows() then
		self._inpScreenWidth:SetText(SettingsModel.instance._screenWidth)
		self._inpScreenHeight:SetText(SettingsModel.instance._screenHeight)
	else
		gohelper.setActive(self._inpScreenWidth.gameObject.transform.parent.gameObject, false)
	end
end

function GMToolView:_formatSize(sizeStr, defaultValue)
	local val = tonumber(sizeStr)

	if not val then
		return defaultValue
	end

	if val < 1 then
		return defaultValue
	end

	return val
end

function GMToolView:_onClickExplore()
	local str = self._inpExplore:GetText() or ""
	local oldId = string.match(str, "(%d+)$")
	local mapId = tonumber(oldId) or 101

	if not ExploreSimpleModel.instance:getMapIsUnLock(mapId) then
		local episodeId
		local chapterIndex = 5
		local episodeIndex = 3
		local list = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Normal)

		if list[chapterIndex] then
			local episodeList = DungeonConfig.instance:getChapterNonSpEpisodeCOList(list[chapterIndex].id)

			episodeId = episodeList and episodeList[episodeIndex] and episodeList[episodeIndex].id
		end

		if episodeId then
			GMRpc.instance:sendGMRequest(string.format("set dungeon %d", episodeId))
		end

		if not DungeonMapModel.instance:elementIsFinished(1050302) then
			DungeonRpc.instance:sendMapElementRequest(1050302)
		end

		GMRpc.instance:sendGMRequest("set explore")
		ExploreRpc.instance:sendGetExploreSimpleInfoRequest()
	end

	ExploreController.instance:enterExploreScene(mapId)

	local mapCo = ExploreConfig.instance:getMapIdConfig(mapId)

	if mapCo then
		ExploreSimpleModel.instance:setLastSelectMap(mapCo.chapterId, mapCo.episodeId)
	end
end

function GMToolView:_onClickScreenSize()
	local width = self._inpScreenWidth:GetText()
	local height = self._inpScreenHeight:GetText()

	width = self:_formatSize(width, SettingsModel.instance._screenWidth)
	height = self:_formatSize(height, SettingsModel.instance._screenHeight)

	self._inpScreenWidth:SetText(width)
	self._inpScreenHeight:SetText(height)
	SettingsModel.instance:_setScreenWidthAndHeight(string.format("%d * %d", width, height))
end

function GMToolView:_initHaveHeroNameList()
	if self.haveHeroList then
		return
	end

	self.haveHeroList = {}

	table.insert(self.haveHeroList, "英雄选择")

	for _, heroMo in ipairs(HeroModel.instance:getList()) do
		local str = heroMo.config.name .. "#" .. tostring(heroMo.heroId)

		table.insert(self.haveHeroList, str)
	end
end

function GMToolView:_initSkinViewSelect()
	self:_initHaveHeroNameList()
	self._dropSkinGetView:ClearOptions()
	self._dropSkinGetView:AddOptions(self.haveHeroList)
end

function GMToolView:_initHeroFaithSelect()
	self:_initHaveHeroNameList()
	self._dropHeroFaith:ClearOptions()
	self._dropHeroFaith:AddOptions(self.haveHeroList)
end

function GMToolView:_initHeroLevelSelect()
	self:_initHaveHeroNameList()
	self._dropHeroLevel:ClearOptions()
	self._dropHeroLevel:AddOptions(self.haveHeroList)
end

function GMToolView:_onSkinGetValueChanged(index)
	if not self.haveHeroList then
		return
	end

	if index == 0 then
		return
	end

	local heroId = string.split(self.haveHeroList[index + 1], "#")[2]

	if not heroId then
		logError("not found : " .. self.haveHeroList[index + 1])
	end

	local param = {}

	param.heroId = tonumber(heroId)
	param.newRank = 3
	param.isRank = true

	PopupController.instance:addPopupView(PopupEnum.PriorityType.GainCharacterView, ViewName.CharacterGetView, param)
end

function GMToolView:_onHeroFaithSelectChanged(index)
	if not self.haveHeroList then
		return
	end

	if index == 0 then
		return
	end

	local heroId = string.split(self.haveHeroList[index + 1], "#")[2]

	if not heroId then
		logError("not found : " .. self.haveHeroList[index + 1])
	end

	self.selectHeroFaithId = tonumber(heroId)
end

function GMToolView:_onHeroLevelSelectChanged(index)
	if not self.haveHeroList then
		return
	end

	if index == 0 then
		return
	end

	local heroId = string.split(self.haveHeroList[index + 1], "#")[2]

	if not heroId then
		logError("not found : " .. self.haveHeroList[index + 1])
	end

	self.selectHeroLevelId = tonumber(heroId)
end

function GMToolView:_onClickHeroFaithOk()
	if self.selectHeroFaithId == 0 then
		return
	end

	GameFacade.showToast(ToastEnum.GMTool5, self.selectHeroFaithId)
	GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", 6, self.selectHeroFaithId, HeroConfig.instance.maxFaith))
end

function GMToolView:_onClickHeroLevelOk()
	if self.selectHeroLevelId == 0 then
		return
	end

	local level = self._inpHeroLevel:GetText()

	GameFacade.showToast(ToastEnum.GMToolFastAddHero, string.format(" 等级%d 洞悉%d 共鸣%d 塑造%d", level, 100, 100, 2))
	GMRpc.instance:sendGMRequest(string.format("add heroAttr %d#%d#%d#%d#%d", self.selectHeroLevelId, level, 100, 100, 2))
end

function GMToolView:_initWeatherSelect()
	self.weatherReportIdList = {}

	for _, reportCo in ipairs(lua_weather_report.configList) do
		local lightName = BGMSwitchProgress.WeatherLight[reportCo.lightMode]
		local effectName = WeatherEnum.WeatherEffectName[reportCo.effect]
		local reportStr = string.format("%d %s-%s", reportCo.id, lightName, effectName)

		table.insert(self.weatherReportIdList, reportStr)
	end

	self._dropWeather:ClearOptions()
	self._dropWeather:AddOptions(self.weatherReportIdList)

	if WeatherController.instance._curReport then
		self._dropWeather:SetValue(WeatherController.instance._curReport.id - 1)
	end

	self._dropWeather:AddOnValueChanged(self._onWeatherChange, self)
end

function GMToolView:_onWeatherChange(index)
	WeatherController.instance:setReportId(index + 1)
end

function GMToolView:_onClickGetAllHeroBtn()
	HeroRpc.instance.preventGainView = true

	GMRpc.instance:sendGMRequest("add hero all 1")
	GameFacade.showToast(ToastEnum.IconId, "获取所有上线角色")
	TaskDispatcher.runDelay(function()
		HeroRpc.instance.preventGainView = nil
	end, nil, 5)
end

function GMToolView:_onClickDeleteAllHeroInfoBtn()
	MessageBoxController.instance:showMsgBoxByStr("确定要删除账号吗？", MsgBoxEnum.BoxType.Yes_No, function()
		GMRpc.instance:sendGMRequest("delete account", function()
			LoginController.instance:logout()
		end)
	end)
end

function GMToolView:_refreshGMBtnText()
	self.showGMBtn = self.showGMBtn or PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewShowGMBtn, 1)
	self._txtGM.text = self.showGMBtn == 1 and "隐藏GM按钮" or "显示GM按钮"
end

function GMToolView:_onClickHideGMBtn()
	self.showGMBtn = self.showGMBtn == 1 and 0 or 1

	self:_refreshGMBtnText()
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewShowGMBtn, self.showGMBtn)
	MainController.instance:dispatchEvent(MainEvent.OnChangeGMBtnStatus)
end

function GMToolView:_onClickUnLockAllEpisode()
	GMRpc.instance:sendGMRequest("set dungeon all")
end

function GMToolView:_onClickOpenHuaRongViewBtn()
	ViewMgr.instance:openView(ViewName.DungeonHuaRongView)
end

function GMToolView:_onClickOpenSeasonViewBtn()
	local mapId = self._inptSeason:GetText()

	self._inptSeason:SetText(mapId)

	if string.nilorempty(mapId) then
		mapId = 0
	end

	AtomicDungeonModel.instance:setGMCurMapId(tonumber(mapId))
end

function GMToolView:_onEarToggleValueChange()
	if not self.initDone then
		return
	end

	self._toggleEar.isOn = SDKMgr.instance:isEarphoneContact()
end

function GMToolView:_onClickShowHero()
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		return
	end

	self.showHero = not self.showHero

	self:_showHero()
end

function GMToolView:_showHero()
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		return
	end

	if not self.heroNodes then
		local mainViewContainer = ViewMgr.instance:getContainer(ViewName.MainView)

		self.heroNodes = {}

		table.insert(self.heroNodes, gohelper.findChild(mainViewContainer.viewGO, "#go_spine_scale"))
		table.insert(self.heroNodes, gohelper.findChild(mainViewContainer.viewGO, "#go_spine_scale/lightspine"))
		table.insert(self.heroNodes, gohelper.findChild(mainViewContainer.viewGO, "#go_lightspinecontrol"))
	end

	for _, node in pairs(self.heroNodes) do
		gohelper.setActive(node, self.showHero)
	end

	self._txtshowHero.text = self.showHero and "隐藏主界面角色" or "显示主界面角色"

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.ShowHeroKey, self.showHero and 1 or 0)
end

function GMToolView:_onClickShowUI()
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		return
	end

	self.showUI = not self.showUI

	self:_showUI()
end

function GMToolView:_showUI()
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		return
	end

	if not self.uiNodes then
		self.uiNodes = {}

		table.insert(self.uiNodes, self:getIDCanvasNode())

		local mainViewContainer = ViewMgr.instance:getContainer(ViewName.MainView)

		table.insert(self.uiNodes, gohelper.findChild(mainViewContainer.viewGO, "left"))
		table.insert(self.uiNodes, gohelper.findChild(mainViewContainer.viewGO, "left_top"))
		table.insert(self.uiNodes, gohelper.findChild(mainViewContainer.viewGO, "#go_righttop"))
		table.insert(self.uiNodes, gohelper.findChild(mainViewContainer.viewGO, "right"))
		table.insert(self.uiNodes, gohelper.findChild(mainViewContainer.viewGO, "bottom"))
	end

	for _, node in pairs(self.uiNodes) do
		gohelper.setActive(node, self.showUI)
	end

	self._txtshowUI.text = self.showUI and "隐藏主界面UI" or "显示主界面UI"

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.ShowUIKey, self.showUI and 1 or 0)

	self.showID = self.showUI

	self:_showID()
end

function GMToolView:_onClickShowHeroDia()
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		return
	end

	self.showHeroDia = not self.showHeroDia

	self:_showHeroDia()
end

function GMToolView:_showHeroDia()
	if not ViewMgr.instance:isOpen(ViewName.MainView) then
		return
	end

	if not self.heroDiaNodes then
		self.heroDiaNodes = {}

		table.insert(self.heroDiaNodes, self:getIDCanvasNode())

		local mainViewContainer = ViewMgr.instance:getContainer(ViewName.MainView)

		table.insert(self.heroDiaNodes, gohelper.findChild(mainViewContainer.viewGO, "left"))
		table.insert(self.heroDiaNodes, gohelper.findChild(mainViewContainer.viewGO, "left_top"))
		table.insert(self.heroDiaNodes, gohelper.findChild(mainViewContainer.viewGO, "#go_righttop"))
		table.insert(self.heroDiaNodes, gohelper.findChild(mainViewContainer.viewGO, "right"))
	end

	for _, node in pairs(self.heroDiaNodes) do
		gohelper.setActive(node, self.showHeroDia)
	end

	self._txtshowHeroDia.text = self.showHeroDia and "(不含字幕)隐藏UI" or "(不含字幕)还原UI"

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.ShowHeroDiaKey, self.showHeroDia and 1 or 0)

	self.showID = self.showHeroDia

	self:_showID()
end

function GMToolView:_onClickShowID()
	self.showID = not self.showID

	self:_showID()
end

function GMToolView:_showID()
	gohelper.setActive(self:getIDCanvasNode(), self.showID)

	self._txtshowId.text = self.showID and "隐藏左下角ID" or "显示左下角ID"

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.ShowIDKey, self.showID and 1 or 0)
end

function GMToolView:_onClickWaterMark()
	self.showWaterMark = not self.showWaterMark

	self:_showWaterMark()
end

function GMToolView:_showWaterMark()
	local waterMarkViewContainer = ViewMgr.instance:getContainer(ViewName.WaterMarkView)

	if waterMarkViewContainer then
		if self.showWaterMark then
			waterMarkViewContainer.waterMarkView:showWaterMark()
		else
			waterMarkViewContainer.waterMarkView:hideWaterMark()
		end

		self._txtwatermark.text = self.showWaterMark and "隐藏水印" or "显示水印"
	end
end

function GMToolView:getIDCanvasNode()
	self.goIDRoot = self.goIDRoot or gohelper.find("IDCanvas")
	self.goIDPopup = self.goIDPopup or gohelper.findChild(self.goIDRoot, "POPUP")

	return self.goIDPopup
end

function GMToolView:_onBtnCopyTalentData()
	CharacterController.instance:dispatchEvent(CharacterEvent.CopyTalentData)
end

function GMToolView:_onBtnPrintAllEntityBuff()
	logError("打印角色的当前buffid~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

	local entityList = FightHelper.getAllEntitys()

	for i, v in ipairs(entityList) do
		local entityMO = v:getMO()

		logError("角色id或者怪物id: " .. entityMO.modelId)

		local buffList = entityMO:getBuffList()

		for index, buffMO in ipairs(buffList) do
			logError("携带buffid: " .. buffMO.buffId)
		end
	end
end

function GMToolView:_onClickBtnFastAddHero()
	self:closeThis()
	ViewMgr.instance:openView(ViewName.GMToolFastAddHeroView)
end

function GMToolView:_OnBtnReplaceSummonHeroClick()
	local heroListStr = self._inpHeroList:GetText()

	if string.nilorempty(heroListStr) then
		return
	end

	local heroList = string.splitToNumber(heroListStr, ";")
	local summonResult = {}
	local result

	for i, heroId in ipairs(heroList) do
		table.insert(summonResult, {
			isNew = true,
			duplicateCount = 1,
			heroId = heroId
		})
	end

	local func = SummonController.summonSuccess

	function SummonController:summonSuccess(_)
		func(self, summonResult)
	end
end

function GMToolView:_testJavaCrash()
	CrashSightAgent.TestJavaCrash()
end

function GMToolView:_testOcCrash()
	CrashSightAgent.TestOcCrash()
end

function GMToolView:_testNativeCrash()
	CrashSightAgent.TestNativeCrash()
end

function GMToolView:_onClickEnterView()
	local viewName = self._inpViewName:GetText()

	if string.nilorempty(viewName) then
		GameFacade.showToastString("请输入界面名字")
	elseif ViewName[viewName] then
		self:closeThis()
		ViewMgr.instance:openView(ViewName[viewName])
		PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewOpenView, viewName)
	else
		GameFacade.showToastString(string.format("界面%s不存在", viewName))
	end
end

return GMToolView
