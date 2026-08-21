-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\TalkBox.lua

local ResTalkNpc = require("ClientData/ResTalkNpc")
local ResTalkPos = require("ClientData/ResTalkPos")
local ResTalkCamera = require("ClientData/ResTalkCamera")
local ResTalkActionDetail = require("ClientData/ResTalkActionDetail")
local ResSectionInfo = require("ClientData/ResSectionInfo")
local ResTalkIntroduction = require("ClientData/ResTalkIntroduction")
local ResColor = require("ClientData/ResColor")
local TalkScenery = require("UI/TalkScenery")
local AvgConfig = require("DesignerScript/AvgConfig")
local CameraManager = Framework.CameraSystem.CameraManager
local ChapterEndPanel = require("UI/AVG/ChapterEndPanel")
local ChapterPosterPanel = require("UI/AVG/ChapterPosterPanel")
local SectionIntroPanel = require("UI/AVG/SectionIntroPanel")
local IDCardPanel = require("UI/AVG/IDCardPanel")
local TalkBranchBtn = Class("TalkBranchBtn", UIControls.Child)
local GameSettings = require("Helper/GameSettings")
local SubpackageHelper = require("Helper/SubpackageHelper")
local AVGInfo = require("UI/AVG/AVGInfo")
local AVGCommonMixin = require("UI/AVG/AVGCommonMixin")
local VersionUtils = require("System/VersionUtils")
local MatUtils = require("UI/MatUtils")
local ResTalkSwitchShow = require("ClientData/ResTalkSwitchShow")
local GameFsm = GameFsm

function TalkBranchBtn:ctor()
	self.btnSensor = UIControls.Button(self, "", "Text")

	self.btnSensor:addEventClick(self.onBranchSelect)
end

function TalkBranchBtn:setInfo(txt, branchID, finishCB)
	self.btnSensor:setText(txt)

	self._id = tonumber(branchID)
	self.finishCB = finishCB

	self:setVisible(true)
end

function TalkBranchBtn:onBranchSelect(sender)
	local data = AVGInfo:getResTalk(self._id)

	if data then
		self.mWindow:selectBranch(data.section, data.page, self.finishCB)
	end
end

local WHITE_MASK = 0
local BLACK_MASK = 1
local ACTION_TYPE_ANIM = 1
local ACTION_TYPE_EMOJI = 2
local CHECK_LOADING_PERIOD = 0.2
local AVGBullet_Misc_ID = 1
local strClassName = "TalkBox"
local TalkBox = Class(strClassName, UIControls.Window)

function TalkBox:ctor()
	self.roleRootPath = "UnderEfx/Roles"
	self.customRoleRootPanel = UIControls.Panel(self, "UnderEfx/Roles")
	self.btnNext = UIControls.Button(self, "AboveEfx/BtnNext")

	self.btnNext:addEventClick(self.onNextClick)

	self.nextSkipCD = AvgConfig.SKIP_TEXT_RUNNING_CD
	self.talkTxt = UIControls.Label(self, "AboveEfx/Content/Text")
	self.imgBgContent = UIControls.Image(self, "AboveEfx/Content")

	self.imgBgContent:setVisible(false)

	self.imgBgContentAni = UIControls.UIAni(self, "AboveEfx/Content")
	self.imgBgCloud = UIControls.Panel(self, "AboveEfx/Content/ImgCloud")
	self.namePanel = UIControls.Image(self, "AboveEfx/Content/BgNameL")
	self.nameTxt = UIControls.Label(self, "AboveEfx/Content/BgNameL/Text")
	self.nextImg = UIControls.Image(self, "AboveEfx/Content/ImgManual")
	self.nextAni = UIControls.UIAni(self, "AboveEfx/Content/ImgManual")
	self.autoImgPanel = UIControls.Panel(self, "AboveEfx/Content/ImgAuto")
	self.autoAni = UIControls.UIAni(self, "AboveEfx/Content/ImgAuto")
	self.headPanel = UIControls.Panel(self, "AboveEfx/Content/RolesHead")
	self.headImg = UIControls.Image(self, "AboveEfx/Content/RolesHead/Mask/Roles")
	self.headEmojiImg = UIControls.Image(self, "AboveEfx/Content/RolesHead/Mask/Roles/Emoji")
	self.titlePanel = UIControls.Panel(self, "AboveEfx/BgTitle")
	self.titleLogoTxt = UIControls.Label(self, "AboveEfx/BgTitle/TextLogo")
	self.titleNumTxt = UIControls.Label(self, "AboveEfx/BgTitle/TextTitleNum")
	self.titleNameTxt = UIControls.Label(self, "AboveEfx/BgTitle/TextTltle")
	self.bgAC = UIControls.Image(self, "BgAC")
	self.screenOriBg = UIControls.RawImage(self, "ImgBg")
	self.screenBgAni = UIControls.UIAni(self, "ImgBg")
	self.screenWidthBg = UIControls.RawImage(self, "ImgBgL")
	self.screenBgPrev = UIControls.RawImage(self, "ImgBgPrev")
	self.screenBgPrevAnim = UIControls.UIAni(self, "ImgBgPrev")
	self.screenBgPrevL = UIControls.RawImage(self, "ImgBgPrevL")
	self.screenBgPrevLAnim = UIControls.UIAni(self, "ImgBgPrevL")

	ModelStageManager.registerAllModelStageLight(false)

	self.bgStage = ModelStageManager.createUIModelStage(self, "ModelStage/AvgBgStage")
	self.optPanel = UIControls.Panel(self, "AboveEfx/OperatingPanel")
	self.optSliderBg = UIControls.Panel(self, "AboveEfx/OperatingPanel/BgSlider")
	self.optSliderEndEfx = UIControls.Panel(self, "AboveEfx/OperatingPanel/EfxHeartDis")
	self.optSlider = UIControls.RateEffectPlayer(self, "AboveEfx/OperatingPanel/BallBlue")
	self.optModelControl = UIControls.Panel(self, "AboveEfx/OperatingPanel/ModelControl")
	self.optEfxPanel = UIControls.LazyEffectPlayer(self, "AboveEfx/OperatingPanel/Efx")

	self.bgStage:initAvgModelStage(self.optModelControl, self.optSlider, self.optSliderBg, self.optSliderEndEfx, self.optEfxPanel)

	self.introPanel = UIControls.Panel(self, "AboveEfx/HeroInfoPanel")
	self.introPanelAni = UIControls.UIAni(self, "AboveEfx/HeroInfoPanel")

	self.introPanelAni:addEventFinish(self._introAnimEnd)

	self.introHeroImg = UIControls.Image(self, "AboveEfx/HeroInfoPanel/BgHero")
	self.blackCampImg = UIControls.Image(self, "AboveEfx/HeroInfoPanel/ImgBlackCamp")
	self.introNameTxt = UIControls.Label(self, "AboveEfx/HeroInfoPanel/TextName")
	self.introCampImg = UIControls.Image(self, "AboveEfx/HeroInfoPanel/TextName/IconGroup")
	self.introTitleTxt = UIControls.Label(self, "AboveEfx/HeroInfoPanel/TextDes")
	self.introTxtList = {}
	self.introTitleTxtList = {}

	for i = 1, 5 do
		local introTxt = UIControls.Label(self, "AboveEfx/HeroInfoPanel/Text" .. i)

		self.introTxtList[i] = introTxt

		local introTitleTxt = UIControls.Label(self, "AboveEfx/HeroInfoPanel/Text" .. i .. "/TextTitle2")

		self.introTitleTxtList[i] = introTitleTxt
	end

	self.panelMountPath = "AboveEfx/MoreFuncPanel"
	self.panelMoreFunc = UIControls.Panel(self, "AboveEfx/MoreFuncPanel")

	self.panelMoreFunc:setVisible(false)

	self.liveIcon = UIControls.Child(self, self.panelMountPath, "System/AVG/AvgLiveChannelIconPanel")

	self.liveIcon:setVisible(false)

	self.underMountPath = "UnderEfx/MoreFuncPanel"
	self.underPanelMoreFunc = UIControls.Panel(self, "UnderEfx/MoreFuncPanel")

	self.underPanelMoreFunc:setVisible(false)

	self.panelFunc = UIControls.Panel(self, "FuncPanel")
	self.autoBtn = UIControls.Button(self, "FuncPanel/BtnAuto")

	self.autoBtn:addEventClick(self.onClickAutoBtn)

	self.autoBtnIcon = UIControls.Panel(self, "FuncPanel/BtnAuto/Icon")
	self.autoBtnTxt = UIControls.Label(self, "FuncPanel/BtnAuto/Icon/Text")
	self.autoBtnAni = UIControls.UIAni(self, "FuncPanel/BtnAuto/AutoPanel")
	self.skipBtn = UIControls.Button(self, "FuncPanel/BtnSkip")

	self.skipBtn:addEventClick(self.onBtnSkipClick)

	self.underEfxPanel = UIControls.Panel(self, "UnderEfx")
	self.aboveEfxPanel = UIControls.Panel(self, "AboveEfx")
	self.bgEfxPanel = UIControls.LazyEffectPlayer(self, "ScreenEfx")
	self.npcMaps = {}
	self.customNpcMaps = {}
	self.terminalNpcMaps = {}
	self.npcShows = {}
	self.customNpcShows = {}
	self.terminalNpcShows = {}

	self:_preInitAVGBullet()

	self._npcDefPos = {}
	self.curPage = 1
	self.btnBranchs = {}

	for i = 1, 3 do
		local btn = TalkBranchBtn(self, "AboveEfx/BranchPanel", "System/AVG/BtnBranch")

		self.btnBranchs[i] = btn
	end

	self.panelBranch = UIControls.Panel(self, "AboveEfx/BranchPanel")
	self.branchAni = UIControls.UIAni(self, "AboveEfx/BranchPanel")
	self._callback = nil

	if UIControls.checkControlFunc(self, "Block") then
		self.alphaMask = UIControls.Image(self, "Block")
	end

	self._nextPageAutoTimer = Timer.New(Slot(self._onAutoNextPage, self), AvgConfig.AUTO_NEXT_PAGE_CD)
	self._slotOfAutoShowAll = Slot(self._onAutoShowAll, self)
	self._introRoleAutoTimer = Timer.New(Slot(self._onAutoNextPage, self), AvgConfig.ROLE_INTRO_LENGTH)
	self._idCardAutoTimer = Timer.New(Slot(self._onAutoNextPage, self), AvgConfig.ROLE_IDCARD_CLICKCD)
	self._terminalTimer = Timer.New(Slot(self._onAutoNextPage, self), AvgConfig.ROLE_TERMINAL_CD)
end

function TalkBox:postInit(uiName, uiData)
	TalkBox.super.postInit(self, uiName, uiData)

	self.otherCamRejected = self.mUIData.shut_down_cam == 1
end

function TalkBox:onOpen()
	TalkBox.super.onOpen(self)

	if CurAvatar then
		self.autoPlay = CurAvatar:getAvgAutoState()
	else
		self.autoPlay = false
	end

	self:_setAutoPlayState(self.autoPlay)
end

function TalkBox:onClose()
	self:_stopPlayDelayCo()
	self:_stopAutoTimer()
	self:_stopBgSettingCo()
	self:_stopClearCo()
	self:_clearAVGBullet()

	if self.screenBgCaptured and self.screenBg then
		self.screenBg:clearCaptureImage()

		self.screenBgCaptured = nil
	end

	self:_unmountTerminal()
	TalkBox.super.onClose(self)
end

function TalkBox:setExtraDelay(delay)
	self.extraDelayTime = delay
end

function TalkBox:showSection(sectionID, pageID, finishCB)
	self.inClosing = nil

	if pageID == nil then
		pageID = 1
	end

	self.sectionInfos = AVGInfo:getSection(sectionID)

	if self.sectionInfos ~= nil then
		self.btnNext:setVisible(true)

		self.curSection = sectionID
		self.curPage = pageID
		self._callback = finishCB
		self.startTick = Time.time

		self:_showScript()
	else
		self:setVisible(false)

		if finishCB then
			finishCB()
		end
	end
end

function TalkBox:showFakeSection(fakeSection, sectionID, pageID, finishCB)
	self.inClosing = nil

	if pageID == nil then
		pageID = 1
	end

	self.sectionInfos = fakeSection

	if self.sectionInfos ~= nil then
		self.btnNext:setVisible(true)

		self.curSection = sectionID
		self.curPage = pageID
		self._callback = finishCB
		self.startTick = Time.time

		if not self.curSection then
			self:disableBullet()
		end

		self:_showScript(fakeSection)
	else
		self:setVisible(false)

		if finishCB then
			finishCB()
		end
	end
end

function TalkBox:hideFuncPanel()
	self.panelFunc:setVisible(false)
end

TalkBox.STATE_NODE = {
	Clear = 1,
	Play = 4,
	BgSet = 2,
	Delay = 3
}

function TalkBox:_showScript(fakeSection)
	local data

	if fakeSection then
		data = fakeSection
	else
		local id = self.sectionInfos[self.curPage] or 0

		data = AVGInfo:getResTalk(id)
	end

	if data == nil then
		if self.curSection then
			CurAvatar:sendNodeAnalyticsData(Const.OSS_TYPE_FINISH_AVG, self.curSection)
		end

		if self.inClosing then
			return
		end

		if self.curSection then
			Analytics.sendPlotFlowLog(self.curSection, Time.time - self.startTick, self.skipedPage or #self.sectionInfos, self.skipedPage ~= nil and 1 or 0)
		end

		self:_sectionEndClear()
		self:setVisible(false)

		self.inClosing = true

		if self._callback then
			self._callback()
		end

		return
	end

	self.data = data
	self.nodeList = {
		self._clearNode,
		self._bgSettingNode,
		self._delayNode,
		self._playNode
	}
	self.nodeClearList = {
		self._stopClearCo,
		self._stopBgSettingCo,
		self._stopPlayDelayCo
	}

	self:_clearNode()
end

function TalkBox:_clearNode()
	self.curNode = self.STATE_NODE.Clear

	self:_stopClearCo()

	self.clearCor = coroutine.start(self._clearStage, self, self.data)
end

function TalkBox:_bgSettingNode()
	self:displayBullet(self.curPage)

	self.curNode = self.STATE_NODE.BgSet

	self:_avgBgSetting(self.data)
end

function TalkBox:_delayNode()
	self.curNode = self.STATE_NODE.Delay

	self:_stopPlayDelayCo()

	self.playDelayCo = coroutine.start(self._coDelayStage, self, self.data, self.bgData)
end

function TalkBox:_playNode()
	self.curNode = self.STATE_NODE.Play

	local success = true
	local talkType = self.data.talk_type

	self.curTerminalType = self.data.terminal_type

	if talkType == UIConst.AVG_TALK_TYPE_SPECIALOPT then
		self:_playSpecialOperate(tonumber(self.data.talk))
	elseif talkType == UIConst.AVG_TALK_TYPE_INTRODUCTION then
		self:_playIntroduction(tonumber(self.data.talk))
	elseif talkType == UIConst.AVG_TALK_TYPE_CHAPTEREND then
		self:_playChapterEnd(tonumber(self.data.talk))
	elseif talkType == UIConst.AVG_TALK_TYPE_SECTIONINTRO then
		self:_playSectionIntro(tonumber(self.data.talk))
	elseif talkType == UIConst.AVG_TALK_TYPE_VIDEO then
		self:_playVideo(self.data.talk)
	elseif talkType == UIConst.AVG_TALK_TYPE_IDCARD then
		self:_playIDCard(tonumber(self.data.talk))
	elseif talkType == UIConst.AVG_TALK_TYPE_POSTER then
		self:_playChapterPoster(self.data.talk)
	else
		success = self:_playTalk(self.data)
	end

	if success then
		self:_avgPlay(self.data)
	end

	self.lastTerminalType = self.curTerminalType
end

function TalkBox:_nextNode()
	if self.curNode == self.STATE_NODE.Play then
		self:onNextClick()
	else
		if self.nodeClearList[self.curNode] then
			self.nodeClearList[self.curNode](self)
		end

		self.curNode = self.curNode + 1

		if not self.nodeList[self.curNode] then
			return
		end

		self.nodeList[self.curNode](self)
	end
end

function TalkBox:_sectionEndClear(...)
	self.btnNext:setVisible(false)
	self:_stopPlayDelayCo()
	self:_stopAutoTimer()
	self:_stopBgSettingCo()
	self:_stopClearCo()

	local needHideBg = true

	if ResSectionInfo[self.curSection] then
		local outAnimName = ResSectionInfo[self.curSection].out_anim

		if outAnimName and self.screenBg then
			self.screenBg:captureImage()

			self.screenBgCaptured = true

			self:changeOutAnim(outAnimName)

			needHideBg = false
		end
	end

	self.curSection = nil

	self:_stopBGM()
	self:_clearEmojiImg()
	self:_clearBgContent()
	self:_clearNpc()
	self:_clearAVGBullet()
	self:_stopVocal()

	self._bgID = nil

	if needHideBg and self.screenBg then
		self.screenBg:setVisible(false)
	end

	self:_reset3DCamera()
	TalkScenery.clear()
	self:_releaseDynamicPrefab()

	if self.bgExtraStage then
		ModelStageManager.releaseGlobalModelStage(self.bgExtraStage)

		self.bgExtraStage = nil
	end

	ModelStageManager.registerAllModelStageLight(true)
	self:rejectOtherCam(false)

	if self.lightChangeStage then
		self:_revertMainMenuLight()

		self.lightChangeStage = nil
	end

	if self.stageReflectChanged then
		self:_changeModelStageReflect()

		self.stageReflectChanged = nil
	end

	GameSettings.resetShadowDistance("AVG")
end

function TalkBox:_skipClear()
	self:_clearSpecialOperate()
	self:_clearIntroduction()
	self:_clearChapterEnd()
	self:_clearSectionIntro()
	self:_clearIDCard()
	self:_clearVideo()
	self:_clearBranch()
end

function TalkBox:_clearStage(data)
	self.skipedPage = nil
	self.nextSkipCD = AvgConfig.SKIP_TEXT_RUNNING_CD

	self:_clearEmojiEffect()
	self.headEmojiImg:setVisible(false)

	if data.clear_role then
		self:_clearNpc()
	end

	self:_stopIntroduction()
	self:_stopIDCard()

	if data.mask_alpha and self.alphaMask then
		self.alphaMask:setVisible(false)
	end

	if data.bg_blur then
		self:_stopBlurBg()
	end

	self:_bgStopAnim()

	if data.bg_id then
		self:_bgResetAnim()
	end

	self:_clearBgContent()
	self:_nextNode()
end

function TalkBox:_stopClearCo()
	if self.clearCor then
		coroutine.stop(self.clearCor)

		self.clearCor = nil
	end
end

function TalkBox:_avgBgSetting(data)
	local needChangeBg = false
	local needSwitchBg = false
	local needMultiBgSwitch = false
	local hasLastBg = false

	self.bgData = nil

	self:_mountTerminal()

	if data.bg_id and data.bg_id ~= self._bgID then
		hasLastBg = self._bgID ~= nil
		self.bgData = AVGInfo:getBg(data.bg_id)

		if self.bgData then
			needChangeBg = true
			self._bgID = data.bg_id

			if self.screenBg then
				self.screenBg:setVisible(true)
			end

			self:rejectOtherCam(true)

			if data.switch_show and self.alphaMask ~= nil then
				if data.switch_show == WHITE_MASK or data.switch_show == BLACK_MASK then
					needSwitchBg = true
				else
					needMultiBgSwitch = true
				end
			end
		else
			self._bgID = nil

			if self.screenBg then
				self.screenBg:setVisible(false)
			end

			self:rejectOtherCam(false)
		end
	end

	if not self._bgID then
		self:rejectOtherCam(false)
	end

	if data.bg_voice then
		self:_playVocal(data.bg_voice)
	end

	if data.bgm then
		if data.bgm == -1 then
			self:_stopBGM()
		else
			self:_playBGM(data.bgm)
		end
	end

	local isLive = data.talk_type == UIConst.AVG_TALK_TYPE_LIVE

	self.liveIcon:setVisible(isLive)

	if isLive and not self.panelMoreFunc:getVisible() then
		self.panelMoreFunc:setVisible(true)
	end

	self:_stopBgSettingCo()

	self.bgSettingCo = coroutine.start(self._coBgSetting, self, data, needChangeBg, needSwitchBg, hasLastBg, needMultiBgSwitch)
end

function TalkBox:_coBgSetting(data, needChangeBg, needSwitchBg, needFadeOut, needMultiBgSwitch)
	if needChangeBg then
		local bgData = AVGInfo:getBg(data.bg_id)

		if needSwitchBg then
			local startAlpha = 255

			if needFadeOut then
				startAlpha = 0
			end

			if data.switch_show == WHITE_MASK then
				self.alphaMask:setColorByRGBA(255, 255, 255, startAlpha)
			elseif data.switch_show == BLACK_MASK then
				self.alphaMask:setColorByRGBA(0, 0, 0, startAlpha)
			end

			self.imgBgContent:setVisible(false)
			self.terminalPanel:setVisible(false)
			self.headPanel:setVisible(false)
			self.alphaMask:setVisible(true)

			if needFadeOut then
				self.alphaMask:crossFade(0, 1, AvgConfig.LAST_BG_FADEOUT)
				coroutine.wait(AvgConfig.LAST_BG_FADEOUT)
			end
		end

		if needMultiBgSwitch then
			self.imgBgContent:setVisible(false)

			local prevTexture = self:getCurBgTexture()

			self.screenBgPrev:setTexture(prevTexture)

			local switchType = ResTalkSwitchShow[data.switch_show]

			if switchType.need_black then
				self.alphaMask:setColorByRGBA(0, 0, 0, 255)
				self.alphaMask:setVisible(true)
			end

			self.screenBgPrev:setVisible(true)
		end

		self:_clearBgVideo()
		self:_realSetBg(bgData, data.scenery_id)

		if self.screenBg then
			if bgData.material_path then
				self.screenBg:changeMaterial(bgData.material_path)
			else
				self.screenBg:changeMaterial(UIConst.AVG_DEFAULT_BG_MATERIAL)
			end
		end

		local loadingTime = 0

		while not TalkScenery.allModelLoaded() do
			coroutine.wait(CHECK_LOADING_PERIOD)

			loadingTime = loadingTime + CHECK_LOADING_PERIOD

			if loadingTime >= AvgConfig.LOADING_TIMEOUT then
				break
			end
		end

		if needSwitchBg then
			self.alphaMask:crossFade(1, 0, AvgConfig.CUR_BG_FADEIN)
			coroutine.wait(AvgConfig.CUR_BG_FADEIN)
			self.alphaMask:setVisible(false)
		end

		if needMultiBgSwitch then
			local switchType = ResTalkSwitchShow[data.switch_show]

			if switchType then
				self.screenBgPrev:setVisible(true)

				if switchType.effect then
					self:_playBgEffect(switchType.effect)
				elseif switchType.mat and VersionUtils.hasMaterialAndCamSupport() then
					self.screenBgPrev:changeMaterial(switchType.mat)
					MatUtils.startTimeRecord(switchType.mat)
				end

				if switchType.simultaneous and switchType.back_mat and VersionUtils.hasMaterialAndCamSupport() then
					self.screenBg:changeMaterial(switchType.back_mat)
					MatUtils.startTimeRecord(switchType.back_mat)
				end

				if switchType.out_anim then
					self.screenBgPrevAnim:startAni(switchType.out_anim, true)
				end

				if switchType.duration then
					coroutine.wait(switchType.duration)
				end

				if switchType.need_black then
					self.alphaMask:setColorByRGBA(0, 0, 0, 0)
					self.alphaMask:setVisible(false)
				end

				if switchType.mat and VersionUtils.hasMaterialAndCamSupport() then
					MatUtils.resetTimeRecord(switchType.mat)
				end

				self.screenBgPrev:setVisible(false)

				if switchType.in_default then
					self.alphaMask:setVisible(true)

					if switchType.in_default == WHITE_MASK then
						self.alphaMask:setColorByRGBA(255, 255, 255, 255)
					elseif switchType.in_default == BLACK_MASK then
						self.alphaMask:setColorByRGBA(0, 0, 0, 255)
					end

					self.alphaMask:crossFade(1, 0, AvgConfig.CUR_BG_FADEIN)
					coroutine.wait(AvgConfig.CUR_BG_FADEIN)
					self.alphaMask:setVisible(false)
				end
			end
		end
	else
		TalkScenery.showScenery(data.scenery_id)
	end

	if data.special_effect then
		local fadeType = AvgConfig.AVG_TALK_SPECIAL_EFFECT[data.special_effect]

		if fadeType then
			self.screenBg:changeMaterial(fadeType.start_mat)
			MatUtils.startTimeRecord(fadeType.start_mat)
			coroutine.wait(fadeType.duration)
			MatUtils.resetTimeRecord(fadeType.start_mat)
			self.screenBg:changeMaterial(fadeType.end_mat)
		end
	end

	self:_nextNode()
end

function TalkBox:getCurBgTexture()
	self.screenBg:captureImage()

	return self.screenBg:getTexture()
end

function TalkBox:_stopBgSettingCo(...)
	if self.bgSettingCo then
		coroutine.stop(self.bgSettingCo)

		self.bgSettingCo = nil
	end
end

function TalkBox:_realSetBg(bgData, sceneryId)
	self.canPlayPostProcess = false

	if bgData.bg_path then
		self:_ensureScreenBg(bgData.bg_aspec_mode ~= nil)
		self.bgStage:pause()
		self.screenBg:setEnabled(true)

		if bgData.bg_path then
			local pathList = utils.splitString(bgData.bg_path, ";")

			if pathList and #pathList == 1 then
				self.screenBg:setImage(pathList[1])
			else
				local gender = CurAvatar.gender or 0

				self.screenBg:setImage(pathList[gender + 1])
			end
		end

		if bgData.bg_color then
			local color = bgData.bg_color

			self.screenBg:setColorByRGBA(color[1], color[2], color[3])
		else
			self.screenBg:setColorByRGBA(255, 255, 255)
		end
	elseif bgData.video_path then
		self:_ensureScreenBg()
		self:_setBgVideo(bgData.video_path, bgData.is_loop == 1)
	else
		self:_ensureScreenBg()

		if bgData.ui_stage then
			if self.bgExtraStage then
				self.bgExtraStage:manualActiveShadow(false)
				self.bgExtraStage:registerLight(false)
				self.bgExtraStage:setLightHide(true)
				ModelStageManager.releaseGlobalModelStage(self.bgExtraStage)

				self.bgExtraStage = nil
				self.modelStagePos = nil
			end

			if bgData.camera_data and ResTalkCamera[bgData.camera_data] and ResTalkCamera[bgData.camera_data].cull_default then
				if ResTalkCamera[bgData.camera_data].cull_default == 1 then
					ModelStageManager.releaseUIModelStage(self.id, "ModelStage/AvgBgStage")

					self.bgStage = ModelStageManager.createUIModelStage(self, "ModelStage/AvgBgStage_NoDefault")

					self.bgStage:initAvgModelStage(self.optModelControl, self.optSlider, self.optSliderBg, self.optSliderEndEfx, self.optEfxPanel)

					self.cullingDefault = true
				elseif ResTalkCamera[bgData.camera_data].cull_default == 0 and self.cullingDefault then
					ModelStageManager.releaseUIModelStage(self.id, "ModelStage/AvgBgStage_NoDefault")

					self.bgStage = ModelStageManager.createUIModelStage(self, "ModelStage/AvgBgStage")

					self.bgStage:initAvgModelStage(self.optModelControl, self.optSlider, self.optSliderBg, self.optSliderEndEfx, self.optEfxPanel)

					self.cullingDefault = nil
				end
			end

			if bgData.ui_stage ~= "0" then
				local alignStage = bgData.ui_stage
				local isMainMenuStage = bgData.ui_stage == "ModelStage/NewDisplayModelStage"

				if isMainMenuStage then
					self.bgExtraStage = ModelStageManager.createGlobalModelStage(Const.MAIN_MENU_MODEL_STAGE)
					alignStage = Const.MAIN_MENU_MODEL_STAGE

					self.bgExtraStage:resetTimeline(0, true)
				else
					self.bgExtraStage = ModelStageManager.createGlobalModelStage(bgData.ui_stage)
				end

				if bgData.model_stage_pos ~= nil then
					self.modelStagePos = bgData.model_stage_pos

					self.bgExtraStage:setPosition(self.modelStagePos)
				end

				self.bgExtraStage:setLightHide(false)
				self.bgExtraStage:registerLight(true)
				self.bgExtraStage:manualActiveShadow(true)
				self.bgStage:alignToStageByName(alignStage)
			end

			self.bgStage:forceRegisterCamera()
		end

		if bgData.dynamic_path then
			self:_loadDynamicPrefab(bgData.dynamic_path)
		end

		if bgData.main_menu_light then
			self:_turnMainMenuLight(bgData.main_menu_light)
		end

		if bgData.stage_reflect then
			self.stageReflectChanged = true

			self:_changeModelStageReflect(self.bgStage:getCamera())
		end

		local cameraPos = {}

		if bgData.camera_pos ~= nil and self.modelStagePos ~= nil then
			for i = 1, #self.modelStagePos do
				cameraPos[i] = bgData.camera_pos[i] + self.modelStagePos[i]
			end
		else
			cameraPos = bgData.camera_pos
		end

		self.bgStage:moveCamera(cameraPos, bgData.camera_rot)

		if bgData.camera_data and ResTalkCamera[bgData.camera_data] then
			local camData = ResTalkCamera[bgData.camera_data]

			self:_set3DCamera(camData)
		end

		if bgData.shadow_dist then
			GameSettings.setShadowDistance(bgData.shadow_dist, "AVG")
		else
			GameSettings.setShadowDistance(AvgConfig.DEFAULT_SHADOW_DISTANCE, "AVG")
		end

		self.bgStage:resume()
		self.bgStage:connectImage(self.screenBg)

		if bgData.bg_color then
			local color = bgData.bg_color

			self.screenBg:setColorByRGBA(color[1], color[2], color[3])
		else
			self.screenBg:setColorByRGBA(255, 255, 255)
		end

		if self.lightChangeStage then
			self.bgStage:manualActiveShadow(false)
			self.lightChangeStage:manualActiveShadow(false)
		end

		self.canPlayPostProcess = true
	end

	TalkScenery.showScenery(sceneryId)

	if bgData.extra_eff then
		self:_playExtraBgEffect(bgData.extra_eff)
	end

	if bgData.bg_effect then
		self:_playBgEffect(bgData.bg_effect)
	end
end

function TalkBox:_setBgVideo(videoPath, isLoop)
	local jobName = videoPath
	local allLoaded, subJob = SubpackageHelper.checkDownloadFileByPath(jobName, videoPath)

	if allLoaded then
		self:_realSetBgVideo(videoPath, isLoop)
	else
		SubpackageHelper.tryDownloadJob(subJob, Functor(self._realSetBgVideo, self, videoPath, isLoop), Slot(self._realSkipClick, self))
	end
end

function TalkBox:_realSetBgVideo(videoPath, isLoop)
	self.underEfxPanel:setVisible(true)

	self.bgVideoPlayerCell = UIControls.LazyVideoPlayer(self, "Video", "System/Common/VideoPlayerChild", 0, 0, true)

	local needMute = true

	if self.hasBGM then
		needMute = false
	end

	self.bgVideoPlayerCell:playVideo(videoPath, Slot(self._stopBgVideo, self), false, needMute, true, isLoop, true)

	self.inBgVideo = true
end

function TalkBox:_stopBgVideo()
	return
end

function TalkBox:_clearBgVideo()
	if not self.inBgVideo then
		return
	end

	self.inBgVideo = nil

	if self.bgVideoPlayerCell then
		self.bgVideoPlayerCell:stopVideo()
		self.bgVideoPlayerCell:destroy()

		self.bgVideoPlayerCell = nil
	end
end

function TalkBox:_ensureScreenBg(isWidth)
	isWidth = isWidth or false

	self.screenOriBg:setVisible(not isWidth)
	self.bgAC:setVisible(not isWidth)
	self.screenWidthBg:setVisible(isWidth)

	if isWidth then
		self.screenBg = self.screenWidthBg
	else
		self.screenBg = self.screenOriBg
	end
end

function TalkBox:rejectOtherCam(reject)
	local isMainState = GameFsm.isInState(Const.STATE_MAIN_HOME)
	local homeBg = UIManager.getUI("homeBg", nil, false)

	self.otherCamRejected = reject

	if isMainState then
		if homeBg then
			homeBg:setHide(reject)
		end
	else
		CameraManager.SetMainCameraEnable(not self.otherCamVisible)
	end
end

function TalkBox:getMainCamVisible()
	if self.otherCamRejected and self._visible and not self._hide then
		return false
	else
		return true
	end
end

function TalkBox:_turnMainMenuLight(lightIndex)
	if self.bgExtraStage then
		self.lightChangeStage = self.bgExtraStage
	else
		self.lightChangeStage = ModelStageManager.getModelStage(Const.MAIN_MENU_MODEL_STAGE)
	end

	if self.lightChangeStage then
		self.lightChangeStage:setLightHide(false)
		self.lightChangeStage:switchEnvData(lightIndex)
	end
end

function TalkBox:_revertMainMenuLight()
	if self.lightChangeStage then
		self.lightChangeStage:switchEnvData(0)
	end
end

function TalkBox:_changeModelStageReflect(cam)
	local mainMenuStage = ModelStageManager.getModelStage(Const.MAIN_MENU_MODEL_STAGE)

	if mainMenuStage then
		mainMenuStage:changeReflectCamera(cam)
	end
end

function TalkBox:_set3DCamera(cameraData)
	local fov = cameraData.fov

	if fov then
		self.bgStage:setCameraFov(fov, false)
	else
		local msFov = cameraData.ms_fov

		if msFov then
			self.bgStage:setCameraFov(msFov, true)
		end
	end

	local postProcessCueId = cameraData.post_cue_id

	if postProcessCueId then
		if postProcessCueId == -1 then
			self.bgStage:revertPostProcessing()
		else
			self.bgStage:playPostProcessing(postProcessCueId)
		end
	end

	local nearPlane = cameraData.near_plane
	local farPlane = cameraData.far_plane

	if nearPlane or farPlane then
		if not nearPlane or nearPlane == -1 then
			nearPlane = AvgConfig.DEFAULT_NEAR_PLANE
		end

		if not farPlane or farPlane == -1 then
			farPlane = AvgConfig.DEFAULT_FAR_PLANE
		end

		self.bgStage:setCameraClipPlane(nearPlane, farPlane)
	end

	local useHighPrecisionDepth = cameraData.high_depth

	if useHighPrecisionDepth then
		self.bgStage:setCameraDepth(useHighPrecisionDepth ~= -1)
	end

	self.cameraChanged = true
end

function TalkBox:_playExtraBgEffect(bgEfxId)
	if bgEfxId == -1 then
		self:_stopExtraBgEffect()

		return
	end

	if bgEfxId == UIConst.AVG_BG_FAKERECORDER then
		self.fakeRecorderPanel = UIControls.Child(self, self.panelMountPath, "System/AVG/AvgMoviePanel")

		self.fakeRecorderPanel:setVisible(true)
		self.panelMoreFunc:setVisible(true)
	elseif bgEfxId == UIConst.AVG_BG_MEMORY then
		self.fakeMemoryPanel = UIControls.Child(self, self.panelMountPath, "System/AVG/AvgMemoryPanel")

		self.fakeMemoryPanel:setVisible(true)

		self.fakeMemoryAnim = UIControls.UIAni(self.fakeMemoryPanel, "")

		self.fakeMemoryAnim:startAni("ShowAvgMemoryPanel", true)
		self.panelMoreFunc:setVisible(true)
	elseif AvgConfig.BG_EFX_MAP[bgEfxId] then
		self.extraEfxPanel = UIControls.Child(self, self.panelMountPath, AvgConfig.BG_EFX_MAP[bgEfxId])

		self.extraEfxPanel:setVisible(true)
		self.panelMoreFunc:setVisible(true)
	elseif AvgConfig.AVG_LIVE_MAP[bgEfxId] then
		if self.extraPrefabPanel then
			self.extraPrefabPanel:destroy()
		end

		self.extraPrefabPanel = UIControls.Child(self, self.panelMountPath, AvgConfig.AVG_LIVE_MAP[bgEfxId])

		self.panelMoreFunc:setVisible(true)
		self.extraPrefabPanel:setVisible(true)
	end

	self.bgExtraEfxId = bgEfxId
end

function TalkBox:_stopExtraBgEffect()
	if not self.bgExtraEfxId then
		return
	end

	if self.bgExtraEfxId == UIConst.AVG_BG_FAKERECORDER and self.fakeRecorderPanel then
		self.panelMoreFunc:setVisible(false)
		self.fakeRecorderPanel:destroy()

		self.fakeRecorderPanel = nil
	elseif self.bgExtraEfxId == UIConst.AVG_BG_MEMORY and self.fakeMemoryPanel then
		self.panelMoreFunc:setVisible(false)
		self.fakeMemoryPanel:destroy()

		self.fakeMemoryPanel = nil
	elseif AvgConfig.BG_EFX_MAP[self.bgExtraEfxId] and self.extraEfxPanel then
		self.panelMoreFunc:setVisible(false)
		self.extraEfxPanel:destroy()

		self.extraEfxPanel = nil
	elseif AvgConfig.AVG_LIVE_MAP[self.bgExtraEfxId] then
		if self.extraPrefabPanel then
			self.extraPrefabPanel:destroy()
		end

		self.panelMoreFunc:setVisible(false)

		self.extraPrefabPanel = nil
	end

	self.bgExtraEfxId = nil
end

function TalkBox:_playBgEffect(efxPath)
	if efxPath == "-1" then
		self:_stopBgEffect()

		return
	end

	self:_sortPanel(self.underEfxPanel, 3)
	self:_sortPanel(self.aboveEfxPanel, 7)
	self.bgEfxPanel:playEffectByPath(efxPath)
	self.bgEfxPanel:setVisible(true)

	self.bgEfxPath = efxPath
end

function TalkBox:_stopBgEffect()
	if not self.bgEfxPath then
		return
	end

	self:_sortPanel(self.underEfxPanel, 0)
	self:_sortPanel(self.aboveEfxPanel, 0)
	self.bgEfxPanel:stopEffect()
	self.bgEfxPanel:setVisible(false)

	self.bgEfxPath = nil
end

function TalkBox:_reset3DCamera()
	if not self.cameraChanged then
		return
	end

	self.bgStage:revertPostProcessing()
	self.bgStage:setCameraClipPlane(AvgConfig.DEFAULT_NEAR_PLANE, AvgConfig.DEFAULT_FAR_PLANE)
	self.bgStage:setCameraDepth(false)

	self.cameraChanged = nil
end

function TalkBox:_loadDynamicPrefab(path)
	if self.dynamicPrefab == path then
		return
	end

	if self.dynamicPrefab and self.dynamicPrefab ~= path then
		self:_releaseDynamicPrefab()
	end

	DynamicSceneManager.load("Scenes/world/Chunk/" .. path)

	self.dynamicPrefab = path
end

function TalkBox:_releaseDynamicPrefab()
	if self.dynamicPrefab then
		DynamicSceneManager.unload("Scenes/world/Chunk/" .. self.dynamicPrefab)

		self.dynamicPrefab = nil
	end
end

function TalkBox:_coDelayStage(data, bgData)
	if self.extraDelayTime then
		self.imgBgContent:setVisible(false)
		self.headPanel:setVisible(false)
		self.terminalPanel:setVisible(false)
		coroutine.wait(self.extraDelayTime)

		self.extraDelayTime = nil
	end

	if bgData then
		self:_bgPlayAnim(bgData)
	end

	if data.play_delay then
		self.imgBgContent:setVisible(false)
		self.terminalPanel:setVisible(false)
		self.headPanel:setVisible(false)
		coroutine.wait(data.play_delay)
	end

	self:_nextNode()
end

function TalkBox:_bgPlayAnim(data)
	local uiAnimName = data.ui_anim

	if uiAnimName then
		self.screenBgAni:startAni(uiAnimName, true)

		self.nowBgAni = uiAnimName
	end

	local camAnimPath = data.cam_anim

	if camAnimPath then
		self.bgStage:playCameraAnimation(camAnimPath)

		self.nowCamAni = camAnimPath
	end
end

function TalkBox:_bgStopAnim()
	if self.nowBgAni then
		self.screenBgAni:stopAni(self.nowBgAni)

		self.nowBgAni = nil
	end

	if self.nowCamAni then
		self.bgStage:stopCameraAnimation()

		self.nowCamAni = nil
	end
end

function TalkBox:_bgResetAnim()
	self.screenBgAni:startAni("BgReset", true)
end

function TalkBox:_stopPlayDelayCo(...)
	if self.playDelayCo then
		coroutine.stop(self.playDelayCo)

		self.playDelayCo = nil
	end
end

function TalkBox:_playSpecialOperate(specialOptId)
	self.optPanel:setVisible(true)
	self.imgBgContent:setVisible(false)
	self.terminalPanel:setVisible(false)
	self.headPanel:setVisible(false)
	self.bgStage:setOptMode(specialOptId, Slot(self._stopSpecialOperate, self))

	if self.autoPlay then
		self:_stopAutoTimer()
	end
end

function TalkBox:_stopSpecialOperate()
	self:_clearSpecialOperate()
	self:onNextClick()
end

function TalkBox:_clearSpecialOperate()
	self.optPanel:setVisible(false)
end

function TalkBox:_playIntroduction(introId)
	local introInfo = ResTalkIntroduction[introId]

	if not introInfo then
		return
	end

	local introNpc = introInfo.npc_id

	if introNpc then
		local npcData = ResTalkNpc[introNpc]

		if npcData then
			local imgInfo = UIConst.getAvgHeadIconPath(npcData.hero_id)

			if imgInfo[1] and imgInfo[2] then
				self.introHeroImg:setImage(imgInfo[1], imgInfo[2])
			end

			local size = imgInfo[3]

			if size then
				self.introHeroImg:setSize(size[1], size[2])
			end

			local scale = introInfo.scale_fix or imgInfo[4] or 1

			self.introHeroImg:setScale(scale)

			local pos = introInfo.pos_fix or {
				0,
				0
			}

			self.introHeroImg:setPosition(pos[1], pos[2])
		end
	end

	local introName = introInfo.npc_name or ""

	self.introNameTxt:setText(introName)

	local introTitle = introInfo.npc_title or ""

	self.introTitleTxt:setText(introTitle)

	local introCamp = introInfo.npc_camp or 1
	local largeIconPath = UIConst.getHeroCampLargeIconPath(introCamp)

	self.introCampImg:setImage(largeIconPath[1], largeIconPath[2])

	local avgCampPath = UIConst.getHeroCampAvgIconPath(introCamp)

	self.blackCampImg:setImage(avgCampPath[1], avgCampPath[2])

	local introList = introInfo.introduction

	if introList then
		local content

		for i = 1, 5 do
			content = introList[i]

			if content and content ~= " " then
				self.introTxtList[i]:setVisible(true)
				self.introTxtList[i]:setText(content)
			else
				self.introTxtList[i]:setVisible(false)
			end
		end
	end

	local titleList = introInfo.intro_title

	if titleList then
		local title

		for i = 1, 5 do
			title = titleList[i]

			if title and title ~= " " then
				self.introTitleTxtList[i]:setVisible(true)
				self.introTitleTxtList[i]:setText(title)
			else
				self.introTitleTxtList[i]:setVisible(false)
			end
		end
	end

	self.panelFunc:setVisible(true)
	self.introPanel:setVisible(true)
	self.introPanelAni:startAni("AVGHeroInfoStart", true)
	self.imgBgContent:setVisible(false)
	self.terminalPanel:setVisible(false)
	self.headPanel:setVisible(false)

	self.inIntroStep = true
	self.introStartTick = Time.time

	if self.autoPlay then
		self:_startAutoTimer(AvgConfig.AUTO_TIMER_INTROROLE)
	end
end

function TalkBox:_stopIntroduction()
	if not self.inIntroStep then
		return
	end

	self.inIntroStep = nil
	self.introStartTick = nil

	self.introPanelAni:startAni("AVGHeroInfoEnd", true)
end

function TalkBox:_introAnimEnd(animCon, animName)
	if animName == "AVGHeroInfoEnd" then
		self.introPanel:setVisible(false)
	end
end

function TalkBox:_clearIntroduction(...)
	if not self.inIntroStep then
		return
	end

	self.inIntroStep = nil
	self.introStartTick = nil

	self.introPanel:setVisible(false)
end

function TalkBox:_playChapterEnd(chapterEndId)
	self.panelMoreFunc:setVisible(true)

	self.chapterEndChild = ChapterEndPanel(self, self.panelMountPath, "System/AVG/AVGChapterEndPanel")

	self.chapterEndChild:showChapterEnd(chapterEndId, Slot(self._stopChapterEnd, self))
	self.chapterEndChild:setVisible(true)
	self.imgBgContent:setVisible(false)
	self.terminalPanel:setVisible(false)
	self.headPanel:setVisible(false)

	self.inChapterEnd = true

	if self.autoPlay then
		self:_stopAutoTimer()
	end
end

function TalkBox:_stopChapterEnd()
	if not self.inChapterEnd then
		return
	end

	self:_clearChapterEnd()
	self:onNextClick()
end

function TalkBox:_clearChapterEnd()
	if not self.inChapterEnd then
		return
	end

	self.inChapterEnd = nil

	if self.chapterEndChild then
		self.chapterEndChild:destroy()

		self.chapterEndChild = nil
	end

	self.panelMoreFunc:setVisible(false)
end

function TalkBox:_playChapterPoster(posterPath)
	self.panelMoreFunc:setVisible(true)

	self.chapterPosterChild = ChapterPosterPanel(self, self.panelMountPath, "System/AVG/AVGChapterEnd02Panel")

	self.chapterPosterChild:showChapterPoster(posterPath, nil, Slot(self._stopChapterPoster, self))
	self.chapterPosterChild:setVisible(true)
	self.imgBgContent:setVisible(false)
	self.terminalPanel:setVisible(false)
	self.headPanel:setVisible(false)

	self.inChapterPoster = true

	if self.autoPlay then
		self:_stopAutoTimer()
	end
end

function TalkBox:_stopChapterPoster()
	if not self.inChapterPoster then
		return
	end

	self:_clearChapterPoster()
	self:onNextClick()
end

function TalkBox:_clearChapterPoster()
	if not self.inChapterPoster then
		return
	end

	self.inChapterPoster = nil

	if self.chapterPosterChild then
		self.chapterPosterChild:destroy()

		self.chapterPosterChild = nil
	end

	self.panelMoreFunc:setVisible(false)
end

function TalkBox:_playSectionIntro(sectionIntroId)
	self.panelMoreFunc:setVisible(true)

	local prefabPath = SectionIntroPanel.getPrefabPath(sectionIntroId)

	self.sectionIntroChild = SectionIntroPanel(self, self.panelMountPath, prefabPath)

	self.sectionIntroChild:showSectionIntro(sectionIntroId, Slot(self._stopSectionIntro, self))
	self.sectionIntroChild:setVisible(true)
	self.panelFunc:setVisible(false)
	self.headPanel:setVisible(false)
	self.terminalPanel:setVisible(false)

	self.inSectionIntro = true

	if self.autoPlay then
		self:_stopAutoTimer()
	end
end

function TalkBox:_stopSectionIntro()
	if not self.inSectionIntro then
		return
	end

	self:_clearSectionIntro()
	self:onNextClick()
end

function TalkBox:_clearSectionIntro()
	if not self.inSectionIntro then
		return
	end

	self.inSectionIntro = nil

	if self.sectionIntroChild then
		self.sectionIntroChild:destroy()

		self.sectionIntroChild = nil
	end

	self.panelFunc:setVisible(true)
	self.panelMoreFunc:setVisible(false)
end

function TalkBox:_playVideo(videoPath)
	local jobName = videoPath
	local allLoaded, subJob = SubpackageHelper.checkDownloadFileByPath(jobName, videoPath)

	self.inVideoPlay = true

	if allLoaded then
		self:_realPlayVideo(videoPath)
	else
		SubpackageHelper.tryDownloadJob(subJob, Functor(self._realPlayVideo, self, videoPath), Slot(self.onBtnSkipClick, self))
	end
end

function TalkBox:_realPlayVideo(videoPath)
	self.panelMoreFunc:setVisible(true)

	self.videoPlayerCell = UIControls.LazyVideoPlayer(self, "Video", "System/Common/VideoPlayerChild", 0, 0, true)

	local needMute = true

	if self.data and self.data.bgm then
		needMute = false
	end

	self.videoPlayerCell:playVideo(videoPath, Slot(self._stopVideo, self), false, needMute, true)
	self.panelFunc:setVisible(true)
	self.imgBgContent:setVisible(false)

	if self.termianlPanel then
		self.terminalPanel:setVisible(false)
	end

	self.headPanel:setVisible(false)

	if self.autoPlay then
		self:_stopAutoTimer()
	end
end

function TalkBox:_stopVideo()
	if not self.inVideoPlay then
		return
	end

	self:_clearVideo()
	self:onNextClick(true)
end

function TalkBox:_clearVideo(...)
	if not self.inVideoPlay then
		return
	end

	self.inVideoPlay = nil

	if self.videoPlayerCell then
		self.videoPlayerCell:stopVideo()
		self.videoPlayerCell:destroy()

		self.videoPlayerCell = nil
	end
end

function TalkBox:_playIDCard(id)
	self.imgBgContent:setVisible(false)
	self.terminalPanel:setVisible(false)
	self.panelMoreFunc:setVisible(true)

	if not self.idCardPanel then
		self.idCardPanel = IDCardPanel(self, self.panelMountPath, "System/AVG/AVGIDCardPanel")
	end

	self.idCardPanel:setVisible(true)
	self.idCardPanel:showData(id)

	self.inIDCard = true
	self.idCardStartTick = Time.time

	if self.autoPlay then
		self:_startAutoTimer(AvgConfig.AUTO_TIMER_IDCARD)
	end
end

function TalkBox:_stopIDCard()
	if not self.inIDCard then
		return
	end

	if self.idCardPanel then
		self.idCardPanel:Close()
	end

	self.idCardStartTick = nil
end

function TalkBox:_idCardAniEnd(animCon, animName)
	if animName == "CloseAvgIDCardPanel" then
		if not self.inIDCard then
			return
		end

		self.inIDCard = nil

		if self.idCardPanel then
			self.idCardPanel:destroy()

			self.idCardPanel = nil
		end
	end
end

function TalkBox:_clearIDCard()
	if not self.inIDCard then
		return
	end

	self.inIDCard = nil

	if self.idCardPanel then
		self.idCardPanel:destroy()

		self.idCardPanel = nil
	end

	self.panelMoreFunc:setVisible(false)
end

function TalkBox:_terminalAnimEnd(animCon, animName)
	return
end

function TalkBox:_mountTerminal()
	if self.terminalPanel then
		return
	end

	self.terminalRootPath = "UnderEfx/MoreFuncPanel/AvgCallPanel"
	self.terminalPanel = UIControls.Child(self, self.underMountPath, "System/AVG/AvgCallPanel")

	self.terminalPanel:setVisible(false)

	self.terminalTalkPanel = UIControls.Panel(self, self.terminalRootPath .. "/TalkPanel")
	self.terminalAnim = UIControls.UIAni(self, self.terminalRootPath)

	self.terminalAnim:addEventFinish(self._terminalAnimEnd)

	self.connectingPanel = UIControls.Panel(self, self.terminalRootPath .. "/ConnectingPanel")
	self.connectingNameText = UIControls.Label(self, self.terminalRootPath .. "/ConnectingPanel/InfoPanel/TextName")
	self.connectingHeroImage = UIControls.Image(self, self.terminalRootPath .. "/ConnectingPanel/InfoPanel/MaskHero/ImgHero")
	self.connectingHeroPortrait = UIControls.AvgRole(self, self.terminalRootPath .. "/ConnectingPanel/InfoPanel/MaskHero/ImgHero")
	self.inComingCallPanel = UIControls.Panel(self, self.terminalRootPath .. "/ConnectingPanel/InfoPanel/IncomingCallPanel")
	self.callingOutPanel = UIControls.Panel(self, self.terminalRootPath .. "/ConnectingPanel/InfoPanel/ConnectingPanel")
	self.pickUpBtn = UIControls.Button(self, self.terminalRootPath .. "/ConnectingPanel/BtnPickUpPhone")
	self.terminalBlock = UIControls.Panel(self, self.terminalRootPath .. "/Block")

	self.terminalBlock:setVisible(false)

	self.terminalRoleRootPanel = UIControls.Panel(self, self.terminalRootPath .. "/TalkPanel/MaskHero/HeroPaenl")

	self.pickUpBtn:addEventClick(self.onPickUp)

	local terminalHeroMaterialPrefab = UIControls.Image(self, self.terminalRootPath .. "/MaterialPanel1")

	self.terminalHeroMat = terminalHeroMaterialPrefab:getComObj().material

	local image = self.connectingHeroPortrait.image:getComObj()

	image.material = self.terminalHeroMat

	local emojiImage = self.connectingHeroPortrait.imgEmoji:getComObj()

	emojiImage.material = self.terminalHeroMat
end

function TalkBox:_unmountTerminal()
	if self.terminalPanel then
		self.terminalPanel:destroy()
	end

	self.terminalPanel = nil
end

function TalkBox:onPickUp()
	self.btnNext:setVisible(true)

	self.inTerminalCallIn = nil

	self:onNextClick()
end

function TalkBox:_setConnectingData(data)
	if data.action and data.action[1].pos ~= 0 then
		local npcData = ResTalkNpc[data.action[1].npc_id]

		if npcData then
			self.connectingNameText:setText(npcData.name)
			self.connectingHeroPortrait:showRole(npcData.hero_id)

			if npcData.head_pos then
				self.connectingHeroPortrait:setAbsPosition(npcData.head_pos[1], npcData.head_pos[2])
			end

			local flip = npcData.head_flip

			if flip then
				self.connectingHeroPortrait:setScaleAndFlip(-1 * npcData.head_scale)
			else
				self.connectingHeroPortrait:setScaleAndFlip(npcData.head_scale)
			end

			if data.head_emoji then
				if data.head_emoji == 0 then
					self.connectingHeroPortrait:clearEmoji()
				else
					self.connectingHeroPortrait:showEmoji(data.head_emoji)
				end
			end
		end
	end

	self:_playCustomTalk(data)

	if self.autoPlay then
		self:_stopAutoTimer()

		if data.talk_type ~= UIConst.AVG_TALK_TYPE_BRANCH and data.terminal_type ~= UIConst.AVG_TERMINAL_TYPE_CALLIN then
			self:_startAutoTimer(AvgConfig.AUTO_TIMER_TERMINAL)
		end
	end
end

function TalkBox:_playTerminalTalk()
	self:_realPlayTerminalTalk()
end

function TalkBox:_realPlayTerminalTalk()
	local data = self.data
	local terminalType = data.terminal_type

	if terminalType == UIConst.AVG_TERMINAL_TYPE_CALLOUT then
		self.callingOutPanel:setVisible(true)
		self.inComingCallPanel:setVisible(false)
		self.pickUpBtn:setVisible(false)
		self.terminalBlock:setVisible(false)
		self:_setConnectingData(data)
	elseif terminalType == UIConst.AVG_TERMINAL_TYPE_CALLIN then
		self.btnNext:setVisible(false)
		self.callingOutPanel:setVisible(false)
		self.inComingCallPanel:setVisible(true)
		self.pickUpBtn:setVisible(true)
		self.terminalBlock:setVisible(true)

		self.inTerminalCallIn = true

		self:_setConnectingData(data)
	else
		self.terminalBlock:setVisible(false)
		self.pickUpBtn:setVisible(false)
		self:_playCustomTalk(data)
	end
end

function TalkBox:_setTerminalEffect(effect)
	if effect == -1 then
		for index, value in pairs(self.terminalNpcMaps) do
			local image = value.image:getComObj()

			image.material = nil
		end
	else
		for index, value in pairs(self.terminalNpcMaps) do
			local image = value.image:getComObj()

			image.material = self.terminalEffectMat
		end
	end
end

local CONTENT_RECT_COMMON = {
	Vector2(0, -2),
	Vector2(1528, 370)
}
local CONTENT_RECT_SPECIAL = {
	Vector2(-2, 370),
	Vector2(-2, -2)
}
local CONTENT_LIVE_SPECIAL = {
	Vector2(-3, 314),
	Vector2(-3, -3)
}

function TalkBox:_playTalk(data)
	local terminalType = data.terminal_type

	if terminalType then
		self.roleRootPath = "UnderEfx/MoreFuncPanel/AvgCallPanel/TalkPanel/MaskHero/HeroPaenl"

		self.customRoleRootPanel:setVisible(false)
		self:_clearCustomRole()

		self.npcMaps = self.terminalNpcMaps
		self.npcShows = self.terminalNpcShows

		self.underPanelMoreFunc:setVisible(true)
		self:_playTerminalTalk()
	else
		self.customRoleRootPanel:setVisible(true)

		self.roleRootPath = "UnderEfx/Roles"
		self.npcMaps = self.customNpcMaps
		self.npcShows = self.customNpcShows

		self:_clearTerminalRole()
		self:_playCustomTalk(data)
	end

	return true
end

function TalkBox:_clearTerminalRole()
	for npcID, isShown in pairs(self.terminalNpcShows) do
		local npcRole = self.terminalNpcMaps[npcID]

		if npcRole and isShown then
			npcRole:setVisible(false)
		end
	end

	self.terminalNpcShows = {}
end

function TalkBox:_clearCustomRole()
	for npcID, isShown in pairs(self.customNpcShows) do
		local npcRole = self.customNpcMaps[npcID]

		if npcRole and isShown then
			npcRole:setVisible(false)
		end
	end

	self.customNpcShows = {}
end

function TalkBox:_playCustomTalk(data)
	self.talkContent = ClientUtils.ConvertContent(data.talk or "")
	self.talkContent = self:_removeDuplicatePrefix(self.talkContent)
	self.talkNpc = data.npc_id
	self.talkNpcShowHead = data.show_head
	self.talkNpcHeadEmoji = data.head_emoji
	self.talkNpcHideName = data.hide_name == 1
	self.talkHideCustome = data.hide_custom

	self.talkTxt:setFontSize(data.font_size or AvgConfig.DEFAULT_FONT_SIZE)

	if data.talk_type == UIConst.AVG_TALK_TYPE_BRANCH then
		if not self:_showBranch(self.talkContent, data) then
			return
		end
	else
		local needAni = self:_playBgContentAni(data.talk_type, data.talk_in_ani, data.terminal_type)

		if not needAni then
			self:_realSetContent(data.talk_type)
		end
	end

	for i, actionData in pairs(data.action or {}) do
		self:_actionNpc(actionData)
	end

	self:_focusNpc(data.npc_id, data.extra_npc)

	if data.terminal_effect then
		self:_setTerminalEffect(data.terminal_effect)
	end

	if self.autoPlay then
		self:_stopAutoTimer()

		if data.talk_type ~= UIConst.AVG_TALK_TYPE_BRANCH then
			self:_startAutoTimer(AvgConfig.AUTO_TIMER_SHOWALL, self.talkContent)
		end
	end

	return true
end

function TalkBox:_realSetContent(talkType)
	local useCommonRect = true
	local useLiveSpecial = false
	local cloudVisible = false

	if talkType == UIConst.AVG_TALK_TYPE_LEFT or talkType == UIConst.AVG_TALK_TYPE_RIGHT or talkType == UIConst.AVG_TALK_TYPE_BRANCH or talkType == UIConst.AVG_TALK_TYPE_ASIDE then
		self.imgBgContent:setImage("Atlas/AvgAtlas/AvgAtlas", "BgDialogBox01")
	elseif talkType == UIConst.AVG_TALK_TYPE_OS then
		self.imgBgContent:setImage("Atlas/AvgAtlas/AvgAtlas", "BgDialogBox02")

		cloudVisible = true
	elseif talkType == UIConst.AVG_TALK_TYPE_BOOM then
		self.imgBgContent:setImage("Atlas/AvgAtlas/AvgAtlas", "BgDialogBox03")
	elseif talkType == UIConst.AVG_TALK_TYPE_ASIDEBLACK then
		useCommonRect = false

		self.imgBgContent:setImage("Atlas/AvgAtlas/AvgAtlas", "BgDialogBox04")
	elseif talkType == UIConst.AVG_TALK_TERMINAL_LEFT then
		self.imgBgContent:setImage("Atlas/AvgAtlas/AvgCallAtlas", "BgDiaTermi01")
	elseif talkType == UIConst.AVG_TALK_TERMINAL_BLOOM then
		self.imgBgContent:setImage("Atlas/AvgAtlas/AvgCallAtlas", "BgDiaTermi02")
	elseif talkType == UIConst.AVG_TALK_TYPE_LIVE then
		self.imgBgContent:setImage("Atlas/AvgAtlas/AvgAtlas", "BgDialogBox05")

		useLiveSpecial = true
	end

	local needFontColor = AvgConfig.CONTANT_FONT_COLOR

	if useLiveSpecial then
		self.imgBgContent:setRecttransform(UIConst.AnchorPresets.HorStretchBottom, CONTENT_LIVE_SPECIAL[1], CONTENT_LIVE_SPECIAL[2])
	elseif useCommonRect then
		self.imgBgContent:setRecttransform(UIConst.AnchorPresets.BottomCenter, CONTENT_RECT_COMMON[1], CONTENT_RECT_COMMON[2])
	else
		self.imgBgContent:setRecttransform(UIConst.AnchorPresets.HorStretchBottom, CONTENT_RECT_SPECIAL[1], CONTENT_RECT_SPECIAL[2])

		needFontColor = AvgConfig.ASIDE_FONT_COLOR
	end

	if not self.defaultFontColor or self.defaultFontColor ~= needFontColor then
		self.talkTxt:setColorByRGBA(needFontColor[1], needFontColor[2], needFontColor[3], 255)

		self.defaultFontColor = needFontColor
	end

	self.talkTxt:setAvgText(self.talkContent or "", AvgConfig.LABEL_JUMP_INTERVAL)

	self.lastShowAllText = Time.time

	self.imgBgCloud:setVisible(cloudVisible)
	self.namePanel:setVisible(not self.talkNpcHideName)

	local headPanelVisible = false

	if self.talkNpc == AvgConfig.PLAYER_NPC_ID then
		self.nameTxt:setTextWithColor(CurAvatar:getPlayerName(), "ORANGEBTN")
		self.namePanel:setImage("Atlas/AvgAtlas/AvgAtlas", "BgNameSelf")
	else
		local npcData = ResTalkNpc[self.talkNpc]

		if npcData then
			self.nameTxt:setText(npcData.name)

			if self.talkNpcShowHead and npcData.head_scale then
				headPanelVisible = true

				self:_showHead(npcData.hero_id, npcData.head_scale, npcData.head_pos, npcData.head_flip, self.talkNpcHeadEmoji)
			end
		end

		self.namePanel:setImage("Atlas/AvgAtlas/AvgAtlas", "BgName")
	end

	if talkType == UIConst.AVG_TALK_TERMINAL_LEFT or talkType == UIConst.AVG_TALK_TERMINAL_BLOOM then
		self.namePanel:setImage("Atlas/AvgAtlas/AvgCallAtlas", "BgNameTermi")
	end

	self.headPanel:setVisible(headPanelVisible)
	self.panelFunc:setVisible(true)
	self:_setAutoBtns()
end

function TalkBox:_playBgContentAni(talkType, forceAnim, terminalType)
	local terminalVisible = self.terminalPanel:getVisible()
	local needTerminalAni = false
	local needTerminalOut = false
	local needAni = false

	if forceAnim or talkType ~= self.lastValidTalkType then
		needAni = true
	end

	if terminalType and (not terminalVisible or self.lastTerminalType ~= self.curTerminalType) then
		needTerminalAni = true
	end

	if self.lastTerminalType and terminalVisible and self.lastTerminalType ~= self.curTerminalType then
		needTerminalOut = true
	end

	self.lastValidTalkType = talkType

	if self.talkContent == "" then
		needAni = false
	end

	local hasAni = needTerminalAni or needAni or needTerminalOut

	if hasAni then
		self.bgContentSteps = {}
	end

	if needTerminalOut then
		table.insert(self.bgContentSteps, Functor(self._contentTerminalAniStepOut, self, self.lastTerminalType, self.curTerminalType))
	end

	if needTerminalOut then
		local cd = 0.2

		table.insert(self.bgContentSteps, Functor(self._coroutinePause, self, cd, self, talkType))
	else
		if self.talkContent == "" then
			self.imgBgContent:setVisible(false)
		else
			self.imgBgContent:setVisible(true)
		end

		if self.curTerminalType then
			self.terminalPanel:setVisible(true)
		else
			self.terminalPanel:setVisible(false)
		end
	end

	if needTerminalAni then
		table.insert(self.bgContentSteps, Functor(self._contentTerminalAniStepIn, self, self.lastTerminalType, self.curTerminalType))
	end

	if needAni then
		table.insert(self.bgContentSteps, Functor(self._contentAniStepIn, self, talkType))
	end

	if hasAni then
		table.insert(self.bgContentSteps, Functor(self._contentAniAllEnd, self, talkType))

		if self.bgContentCo then
			coroutine.stop(self.bgContentCo)
		end

		self.bgContentCo = coroutine.start(self._coAniBgContent, self)
	end

	return needAni or needTerminalAni
end

function TalkBox:_clearBgContent()
	if self.bgContentCo then
		coroutine.stop(self.bgContentCo)
	end

	self.bgContentSteps = nil
	self.bgContentCo = nil

	if self.bgAniName then
		self.imgBgContentAni:stopAni(self.bgAniName)
	end

	if self.terminalAniName then
		self.terminalAnim:stopAni(self.terminalAniName)
	end
end

function TalkBox:_coAniBgContent()
	for _, coFunc in ipairs(self.bgContentSteps) do
		coFunc()
	end

	self.bgContentSteps = nil
	self.bgContentCo = nil
end

function TalkBox:_contentAniStepOut()
	self.bgAniName = "CloseAVGContentAll"

	self.imgBgContentAni:startAni(self.bgAniName, true)
end

function TalkBox:_contentTerminalAniStepOut(lastTerminalType, curTerminalType)
	self.terminalAniName = nil

	if lastTerminalType then
		if lastTerminalType == UIConst.AVG_TERMINAL_TYPE_CALLOUT or lastTerminalType == UIConst.AVG_TERMINAL_TYPE_CALLIN then
			if curTerminalType ~= UIConst.AVG_TERMINAL_TYPE_TALK then
				self.terminalAniName = "CloseConnectingPanel"
			end
		elseif lastTerminalType == UIConst.AVG_TERMINAL_TYPE_END then
			self.terminalAniName = "CloseAvgCallPanel"
		elseif lastTerminalType == UIConst.AVG_TERMINAL_TYPE_TALK then
			if curTerminalType == UIConst.AVG_TERMINAL_TYPE_CALLOUT or curTerminalType == UIConst.AVG_TERMINAL_TYPE_CALLIN then
				self.terminalAniName = "CloseAvgCallPanel"
			elseif curTerminalType ~= UIConst.AVG_TERMINAL_TYPE_END then
				self.terminalAniName = "HideHeroTalk"
			end
		end

		if self.terminalAniName then
			self.terminalAnim:startAni(self.terminalAniName, true)
		end
	end
end

function TalkBox:_contentAniStepIn(talkType)
	self.bgAniName = "AVGContentOther"

	if talkType == UIConst.AVG_TALK_TYPE_OS then
		self.bgAniName = "AVGContentCloud"
	elseif talkType == UIConst.AVG_TALK_TYPE_ASIDE then
		self.bgAniName = "AVGContentAside"
	elseif talkType == UIConst.AVG_TALK_TERMINAL_LEFT then
		self.bgAniName = "AVGContentCall"
	elseif talkType == UIConst.AVG_TALK_TERMINAL_BLOOM then
		self.bgAniName = "AVGContentCallBoom"
	elseif talkType == UIConst.AVG_TALK_TYPE_LIVE then
		self.bgAniName = "AVGContentLive"
	end

	self.imgBgContentAni:startAni(self.bgAniName, true)
end

function TalkBox:_contentTerminalAniStepIn(lastTerminalType, curTerminalType)
	self.terminalAniName = "ShowHeroTalk"

	if curTerminalType then
		if curTerminalType == UIConst.AVG_TERMINAL_TYPE_CALLOUT or curTerminalType == UIConst.AVG_TERMINAL_TYPE_CALLIN then
			self.terminalAniName = "OpenAvgCallPanel"
			self.nextSkipCD = 0.42
		elseif curTerminalType == UIConst.AVG_TERMINAL_TYPE_TALK then
			if lastTerminalType then
				if lastTerminalType == UIConst.AVG_TERMINAL_TYPE_OPEN then
					self.terminalAniName = nil
				elseif lastTerminalType == UIConst.AVG_TERMINAL_TYPE_CALLOUT or lastTerminalType == UIConst.AVG_TERMINAL_TYPE_CALLIN then
					self.terminalAniName = "ShowTalkPanel"
					self.nextSkipCD = 0.32
				elseif lastTerminalType == UIConst.AVG_TERMINAL_TYPE_TALK then
					self.terminalAniName = nil
				end
			else
				self.terminalAniName = "ShowHeroTalk"
			end
		elseif curTerminalType == UIConst.AVG_TERMINAL_TYPE_OPEN then
			self.nextSkipCD = 0.42
			self.terminalAniName = "OpenAvgCallPanel2"
		elseif curTerminalType == UIConst.AVG_TERMINAL_TYPE_END then
			self.terminalAniName = nil
		end

		if self.terminalAniName then
			self.terminalAnim:startAni(self.terminalAniName, true)
		end
	end
end

function TalkBox:_coroutinePause(cd, talkType)
	self.bgAniName = nil
	self.terminalAniName = nil

	coroutine.wait(cd)

	if self.talkContent == "" then
		self.imgBgContent:setVisible(false)
	else
		self.imgBgContent:setVisible(true)
	end

	if self.curTerminalType then
		self.terminalPanel:setVisible(true)
	else
		self.terminalPanel:setVisible(false)
	end
end

function TalkBox:_contentAniAllEnd(talkType)
	self.bgAniName = nil
	self.terminalAniName = nil

	self:_realSetContent(talkType)
	coroutine.wait(0.2)
end

function TalkBox:_avgPlay(data)
	if self.alphaMask then
		if not data.mask_alpha then
			self.alphaMask:setVisible(self.lastMaskValue ~= nil)

			if self.lastMaskValue then
				self.alphaMask:setColorByRGBA(0, 0, 0, self.lastMaskValue)
			end
		elseif data.mask_alpha == -1 then
			self.lastMaskValue = nil

			self.alphaMask:setVisible(false)
		else
			self.lastMaskValue = data.mask_alpha

			self.alphaMask:setVisible(true)
			self.alphaMask:setColorByRGBA(0, 0, 0, self.lastMaskValue)
		end
	end

	if data.bg_blur and data.bg_blur ~= -1 then
		if self.inIntroStep then
			self:_startBlurBg(data.bg_blur, 5)
		else
			self:_startBlurBg(data.bg_blur)
		end
	end

	if data.vocal then
		self:_playVocal(data.vocal)
	end
end

function TalkBox:_focusNpc(tgtNpcID, extraNpcId)
	for npcID, npcRole in pairs(self.npcMaps) do
		if self.npcShows[npcID] then
			npcRole:setActive(npcID == tgtNpcID or npcID == extraNpcId)
		end
	end
end

function TalkBox:_removeDuplicatePrefix(content)
	local _content = string.gsub(content, "_(.*)_", "")

	return _content
end

function TalkBox:_showBranch(content, data)
	local branchInfos = data.branch_info

	if #branchInfos < 1 then
		self.curPage = self.curPage + 1

		self:_showScript()

		return
	end

	self.talkTxt:stopAvgText()

	local branchNum = #branchInfos

	for i, btn in ipairs(self.btnBranchs) do
		if i <= branchNum then
			local content = self:_removeDuplicatePrefix(branchInfos[i].branch_content)

			btn:setInfo(content, branchInfos[i].id, self._callback)
		else
			btn:setVisible(false)
		end
	end

	self.panelBranch:setVisible(true)
	self.branchAni:startAni("AinBranchPanel", true)

	return true
end

function TalkBox:selectBranch(sectionID, pageID, finishCB)
	self:_clearBranch()
	self:showSection(sectionID, pageID, finishCB)
end

function TalkBox:_clearBranch()
	self.panelBranch:setVisible(false)
end

function TalkBox:_actionNpc(data)
	local npcID = data.npc_id
	local npcData = ResTalkNpc[npcID]

	if npcData == nil then
		return
	end

	if npcData.live2D_path then
		self:_sortPanel(self.underEfxPanel, 3)
		self:_sortPanel(self.aboveEfxPanel, 7)
	end

	local pos = self:_getNPCPos(npcID, data.pos)
	local posEnter = self:_getNPCPos(npcID, data.show)

	if not self.npcMaps[npcID] then
		local role = UIControls.AvgRole(self, self.roleRootPath)

		role:showAvgRole(npcData)

		self.npcMaps[npcID] = role
	end

	if not self.npcShows[npcID] then
		if posEnter then
			self:_jumpNpc(npcID, posEnter)
			self:_moveNpc(npcID, pos)
		else
			self:_jumpNpc(npcID, pos)
		end

		if self.npcMaps[npcID]:getVisible() then
			self.npcMaps[npcID]:playMainAnim("ShowAVGTalkRole")

			self.npcShows[npcID] = true
		end

		if self.curTerminalType then
			local image = self.npcMaps[npcID].image:getComObj()

			image.material = self.terminalHeroMat

			local emojiImage = self.npcMaps[npcID].imgEmoji:getComObj()

			emojiImage.material = self.terminalHeroMat
		end
	else
		self:_moveNpc(npcID, pos)
	end

	local emoji = data.emoji

	if emoji then
		self:_playEmoji(npcID, emoji)
	end

	local action = data.action

	if action then
		for _, actionId in ipairs(action) do
			self:_playAnimAction(npcID, actionId)
		end
	end
end

function TalkBox:_jumpNpc(npcID, pos)
	local npcRole = self.npcMaps[npcID]

	if pos == nil then
		if npcRole then
			npcRole:setVisible(false)
		end

		return
	end

	if npcRole then
		npcRole:setPosition(pos.x, pos.y)
		npcRole:setVisible(true)
	end
end

function TalkBox:_moveNpc(npcID, pos)
	local npcRole = self.npcMaps[npcID]

	if npcRole then
		if pos then
			npcRole:setVisible(true)
			npcRole:moveToPosition(pos.x, pos.y, AvgConfig.DEF_DURATION)
		else
			if npcRole.isLive2D then
				npcRole:_clearAllAnim()
				npcRole:setVisible(false)
			else
				npcRole:playMainAnim("CloseAVGTalkRole")
			end

			self.npcShows[npcID] = nil
		end
	end
end

function TalkBox:_clearNpc()
	self:_clearCustomRole()
	self:_clearTerminalRole()
end

function TalkBox:_showHead(headId, headScale, headPos, flip, emoji)
	local headIconPath = UIConst.getAvgHeadIconPath(headId)

	if headIconPath then
		self.headImg:setImage(headIconPath[1], headIconPath[2])

		local size = headIconPath[3]

		if size then
			self.headImg:setSize(size[1], size[2])
		end

		if headPos then
			self.headImg:setPosition(headPos[1], headPos[2])
		end

		if flip then
			self.headImg:setScaleXYZ(-1 * headScale, headScale, headScale)
		else
			self.headImg:setScaleXYZ(headScale, headScale, headScale)
		end
	end

	if emoji then
		if emoji == 0 then
			self.headEmojiImg:setVisible(false)
		else
			local emojiInfo = UIConst.getAvgHeadEmoji(headId, emoji)

			if not emojiInfo then
				self.headEmojiImg:setVisible(false)
			else
				self.headEmojiImg:setImage(emojiInfo[1], emojiInfo[2])

				local size = emojiInfo[3]

				if size then
					self.headEmojiImg:setSize(size[1], size[2])
				end

				local pos = emojiInfo[4]

				if pos then
					self.headEmojiImg:setPosition(pos[1], pos[2])
				end

				local scale = emojiInfo[5]

				if scale then
					self.headEmojiImg:setScale(scale)
				end

				self.headEmojiImg:setVisible(true)
			end
		end
	end
end

function TalkBox:_playEmoji(npcID, emoji)
	local npcRole = self.npcMaps[npcID]

	if npcRole then
		if emoji == 0 then
			npcRole:clearEmoji()
		else
			npcRole:showEmoji(emoji)
		end
	end
end

function TalkBox:_playAnimAction(npcID, actionId)
	local npcRole = self.npcMaps[npcID]
	local actionDetail = ResTalkActionDetail[actionId]

	if not npcRole or not actionDetail then
		return
	end

	if not npcRole.inMainAnimation then
		self._realPlayAnimAction(npcRole, actionDetail)
	else
		npcRole:addMainAnimEndCallback(Functor(self._realPlayAnimAction, npcRole, actionDetail))
	end
end

function TalkBox._realPlayAnimAction(npcRole, actionDetail)
	local actionType = actionDetail.action_type

	if actionType == ACTION_TYPE_ANIM then
		local animName = actionDetail.anim_name

		if animName then
			npcRole:playRoleAnim(animName)
		end
	elseif actionType == ACTION_TYPE_EMOJI then
		local emojiPos = actionDetail.emoji_pos or AvgConfig.EFF_EMOJI_DEF_POS
		local emojiPath = actionDetail.emoji_path

		npcRole:setAnimEmojiPos(emojiPos)
		npcRole:playAnimEmoji(emojiPath)
	end
end

function TalkBox:_clearEmojiEffect()
	for npcID, isShown in pairs(self.npcShows) do
		local npcRole = self.npcMaps[npcID]

		if npcRole and isShown then
			npcRole:stopAnimEmoji()
		end
	end
end

function TalkBox:_clearEmojiImg(...)
	for npcID, _ in pairs(self.npcShows) do
		local npcRole = self.npcMaps[npcID]

		if npcRole then
			npcRole:clearEmoji()
		end
	end
end

function TalkBox:_playBGM(bgmId)
	CueManager.playAvgBGM(bgmId)

	self.hasBGM = true
end

function TalkBox:_stopBGM()
	if self.hasBGM then
		CueManager.stopAvgBGM()

		self.hasBGM = false
	end
end

function TalkBox:_playVocal(vocalId)
	self.inVocal = true

	CueManager.playVocal(vocalId)
end

function TalkBox:_stopVocal()
	if self.inVocal then
		CueManager.stopVocal()

		self.inVocal = false
	end
end

function TalkBox:_startBlurBg(blurScale, blurOffset)
	if self.screenBg then
		self.screenBg:setImageBlur(blurScale, blurOffset)
	end
end

function TalkBox:_stopBlurBg()
	if self.screenBg then
		self.screenBg:clearImageBlur()
	end
end

function TalkBox:_setAutoPlayState(isAuto)
	if CurAvatar then
		CurAvatar:setAvgAutoState(isAuto)
	end

	self.isAuto = isAuto

	if isAuto then
		if self.sectionInfos then
			self:onNextClick()
		end
	else
		self:_stopAutoTimer()
	end

	self:_setAutoBtns()
end

function TalkBox:_setAutoBtns()
	if self.isAuto then
		self.autoAni:setVisible(true)
		self.autoAni:startAniLoop("AniAuto")
		self.nextAni:setVisible(false)
		self.autoBtnIcon:setVisible(false)
		self.autoBtnAni:setVisible(true)
		self.autoBtnAni:startAniLoop("AniBtnAuto")
	else
		self.autoAni:setVisible(false)
		self.nextAni:setVisible(true)
		self.nextAni:startAniLoop("AniManual")
		self.autoBtnIcon:setVisible(true)
		self.autoBtnAni:setVisible(false)
	end
end

function TalkBox:_startAutoTimer(timerType, text)
	self:_stopAutoTimer()

	if timerType == AvgConfig.AUTO_TIMER_SHOWALL then
		local needCount = self:_calcTextTime(text)

		if needCount > 0 then
			self._autoPlayTimer = Timer.New(self._slotOfAutoShowAll, needCount)

			self._autoPlayTimer:Start()
		elseif text == "" then
			self._autoPlayTimer = self._nextPageAutoTimer

			self._autoPlayTimer:Restart()
		end
	elseif timerType == AvgConfig.AUTO_TIMER_NEXTPAGE then
		self._autoPlayTimer = self._nextPageAutoTimer

		self._autoPlayTimer:Restart()
	elseif timerType == AvgConfig.AUTO_TIMER_INTROROLE then
		self._autoPlayTimer = self._introRoleAutoTimer

		self._autoPlayTimer:Restart()
	elseif timerType == AvgConfig.AUTO_TIMER_IDCARD then
		self._autoPlayTimer = self._idCardAutoTimer

		self._autoPlayTimer:Restart()
	elseif timerType == AvgConfig.AUTO_TIMER_TERMINAL then
		self._autoPlayTimer = self._terminalTimer

		self._autoPlayTimer:Restart()
	end
end

function TalkBox:_stopAutoTimer()
	if self._autoPlayTimer then
		self._autoPlayTimer:Stop()
	end
end

function TalkBox:_onAutoShowAll()
	self:_startAutoTimer(AvgConfig.AUTO_TIMER_NEXTPAGE)
end

function TalkBox:_onAutoNextPage()
	self:onNextClick()
end

function TalkBox:_calcTextTime(text)
	if not text or text == "" then
		return 0
	end

	return math.ceil(#text / 4) * AvgConfig.LABEL_JUMP_INTERVAL
end

function TalkBox:_getNPCPos(npcID, posIdx)
	local idxData = ResTalkPos[posIdx]

	if idxData == nil then
		return
	end

	local defNpcPos = self._npcDefPos[npcID]

	if defNpcPos == nil then
		local npcData = ResTalkNpc[npcID]

		if npcData and npcData.pos then
			defNpcPos = {
				x = npcData.pos[1] or 0,
				y = npcData.pos[2] or 0
			}
		else
			defNpcPos = {
				x = 0,
				y = 0
			}
		end

		self._npcDefPos[npcID] = defNpcPos
	end

	return {
		x = idxData.x + defNpcPos.x,
		y = idxData.y + defNpcPos.y
	}
end

function TalkBox:onNextClick(force)
	if self.curNode == self.STATE_NODE.Play then
		if self.panelBranch:getVisible() then
			return
		end

		if self.inTerminalCallIn then
			return
		end

		if self.terminalAniName or self.bgAniName then
			return
		end

		if self.inBulletEdit and not force then
			return
		end

		if self.inChapterEnd and self.chapterEndChild then
			self.chapterEndChild:onClickNext()

			return
		end

		if self.inChapterPoster and self.chapterPosterChild then
			self.chapterPosterChild:onClickNext()

			return
		end

		if self.inSectionIntro and self.sectionIntroChild then
			return
		end

		if self.inIntroStep and self.introStartTick and self.introStartTick + AvgConfig.ROLE_INTRO_CLICKCD > Time.time then
			return
		end

		if self.inIDCard and self.idCardStartTick and self.idCardStartTick + AvgConfig.ROLE_IDCARD_CLICKCD > Time.time then
			return
		end

		if self.inVideoPlay and self.videoPlayerCell then
			return
		end

		local hasTxtRunning = self.talkTxt:stopAvgText()

		if hasTxtRunning then
			self.lastShowAllText = Time.time

			if self.autoPlay then
				self:_startAutoTimer(AvgConfig.AUTO_TIMER_NEXTPAGE)
			end
		elseif self.lastShowAllText and Time.time < self.lastShowAllText + self.nextSkipCD then
			return
		else
			self.lastShowAllText = nil
			self.curPage = self.curPage + 1

			self:_showScript()
		end
	elseif self.curNode == self.STATE_NODE.Delay then
		self:_nextNode()
	end
end

function TalkBox:_realSkipClick()
	local nowSection = self.curSection
	local nowArrivePage = self.curPage

	self.skipedPage = nowArrivePage

	if self.inVideoPlay then
		self.curPage = self.curPage + 1
	else
		self.curPage = 0
	end

	self:_stopClearCo()
	self:_stopPlayDelayCo()
	self:_stopBgSettingCo()
	self:_skipClear()
	self:_closeBulletEdit()
	self:_showScript()
	CurAvatar:sendAvgAnalyticsData(Const.OSS_TYPE_SKIP_AVG, nowSection, nowArrivePage)
end

function TalkBox:onClickAutoBtn(...)
	if self.inBulletEdit then
		return
	end

	self.autoPlay = not self.autoPlay

	self:_setAutoPlayState(self.autoPlay)
end

local ComponentOrderType = typeof(Framework.UI.UIComponentOrder)
local CanvasType = typeof(UnityEngine.Canvas)
local GraphicRaycasterType = typeof(UnityEngine.UI.GraphicRaycaster)

function TalkBox:_sortPanel(targetPanel, sortOrder)
	local go = targetPanel:getGameObject()
	local uiOrder = go:GetComponent(ComponentOrderType)

	if uiOrder then
		if sortOrder == 0 then
			local canvs = go:GetComponent(CanvasType)
			local raycaster = go:GetComponent(GraphicRaycasterType)

			UnityEngine.Object.DestroyImmediate(uiOrder)
			UnityEngine.Object.DestroyImmediate(raycaster)
			UnityEngine.Object.DestroyImmediate(canvs)
		end
	elseif sortOrder ~= 0 then
		uiOrder = go:AddComponent(ComponentOrderType)
		uiOrder.Order = sortOrder

		go:AddComponent(GraphicRaycasterType)
	end
end

function TalkBox:isSectionEnd(page)
	local id = self.sectionInfos[page] or 0
	local data = AVGInfo:getResTalk(id)

	if not data then
		return true
	else
		return false
	end
end

function TalkBox:_resumeBulletVideoPlay()
	if self.inVideoPlay and self.videoPlayerCell then
		self.videoPlayerCell:resumeVideo()
	end
end

function TalkBox:_pauseBulletVideoPlay()
	if self.inVideoPlay and self.videoPlayerCell then
		self.videoPlayerCell:pauseVideo()
	end
end

MixinClass(TalkBox, AVGCommonMixin)

return TalkBox
