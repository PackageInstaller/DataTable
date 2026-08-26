-- chunkname: @modules/logic/versionactivity2_2/lopera/view/LoperaLevelView.lua

module("modules.logic.versionactivity2_2.lopera.view.LoperaLevelView", package.seeall)

local LoperaLevelView = class("LoperaLevelView", BaseView)
local actionPointIconRichTxt = "<sprite=0>"
local LoperaLevelState = {
	SelectDir = 1,
	OptionDesc = 3,
	SelectOption = 2
}
local mapCfgIdx = LoperaEnum.MapCfgIdx
local dirEnum = LoperaEnum.DirEnum
local loperaActId = VersionActivity2_2Enum.ActivityId.Lopera
local loperaLevelBgDir = "singlebg/v2a2_lopera_singlebg/"
local normalLevelBg = "v2a2_lopera_levelmap1.png"
local eventDescColorFormat = "<color=#403933>%s</color>"
local rewardColorFormat = "<color=#b25712>%s</color>"
local moveDuration = 1.5
local showOptionListDelay = 0.75
local moveUIBlock = "LoperaLevelViewMovingBlock"
local descScrollHeight = 150

function LoperaLevelView:onInitView()
	self._goDir = gohelper.findChild(self.viewGO, "#go_Compass")
	self._btnN = gohelper.findChildClick(self._goDir, "Compass/ClickArea/clickN")
	self._btnW = gohelper.findChildClick(self._goDir, "Compass/ClickArea/clickW")
	self._btnE = gohelper.findChildClick(self._goDir, "Compass/ClickArea/clickE")
	self._btnS = gohelper.findChildClick(self._goDir, "Compass/ClickArea/clickS")
	self._goNPress = gohelper.findChild(self._goDir, "Compass/#go_CompassFG1/#go_N")
	self._goWPress = gohelper.findChild(self._goDir, "Compass/#go_CompassFG1/#go_W")
	self._goEPress = gohelper.findChild(self._goDir, "Compass/#go_CompassFG1/#go_E")
	self._goSPress = gohelper.findChild(self._goDir, "Compass/#go_CompassFG1/#go_S")
	self._goNNormal = gohelper.findChild(self._goDir, "Compass/#go_CompassFG2/#go_N")
	self._goWNormal = gohelper.findChild(self._goDir, "Compass/#go_CompassFG2/#go_W")
	self._goENormal = gohelper.findChild(self._goDir, "Compass/#go_CompassFG2/#go_E")
	self._goSNormal = gohelper.findChild(self._goDir, "Compass/#go_CompassFG2/#go_S")
	self._txtPowerCostNum = gohelper.findChildText(self._goDir, "image_PowerIcon/#txt_PowerNum")
	self._btnAlchemy = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Smelt")
	self._goSmeltRed = gohelper.findChild(self.viewGO, "#btn_Smelt/#go_reddot")
	self._goSmeltBtn = gohelper.findChild(self.viewGO, "#btn_Smelt")
	self._goOption = gohelper.findChild(self.viewGO, "#go_Question")
	self._goOptionItemRoot = gohelper.findChild(self._goOption, "List")
	self._goOptionItem = gohelper.findChild(self._goOption, "List/#go_Item")
	self._bgRoot = gohelper.findChild(self.viewGO, "BG")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "BG/bg")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "BG/bg1")
	self._bgAnimator = self._bgRoot:GetComponent(gohelper.Type_Animator)
	self._textLocation = gohelper.findChildText(self.viewGO, "TargetList/Title/image_TitleBG/#txt_Title")
	self._goLocationEffect = gohelper.findChild(self.viewGO, "TargetList/Title/vx_hint1")
	self._textStageName = gohelper.findChildText(self.viewGO, "TargetList/Title/image_TitleBG/txt_TitleEn")
	self._textActionPoint = gohelper.findChildText(self.viewGO, "TargetList/mainTarget/#txt_TargetDesc")
	self._gpActionPointEffect = gohelper.findChild(self.viewGO, "TargetList/mainTarget/vx_hint2")
	self._eventDescRoot = gohelper.findChild(self.viewGO, "#go_Descr")
	self._btnEventDesc = gohelper.findChildButtonWithAudio(self._eventDescRoot, "btn_descClose")
	self._btnEventDescViewPort = gohelper.findChildButtonWithAudio(self._eventDescRoot, "Scroll View/Viewport")
	self._textEventDesc = gohelper.findChildText(self.viewGO, "#go_Descr/Scroll View/Viewport/#txt_Descr")
	self._goDescArrow = gohelper.findChild(self.viewGO, "#go_Descr/#go_ArrowTips")
	self._goBuff = gohelper.findChild(self.viewGO, "#btn_State")
	self._btnState = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_State")
	self._goBuffItemRoot = gohelper.findChild(self.viewGO, "#btn_State/#go_StateBG")
	self._goBuffInfoItem = gohelper.findChild(self.viewGO, "#btn_State/#go_StateBG/#txt_State")
end

function LoperaLevelView:addEvents()
	self._btnN:AddClickListener(self._onClickDir, self, dirEnum.North)
	self._btnN:AddClickDownListener(self._onClickDirDown, self, dirEnum.North)
	self._btnN:AddClickUpListener(self._onClickDirUp, self, dirEnum.North)
	self._btnW:AddClickListener(self._onClickDir, self, dirEnum.West)
	self._btnW:AddClickDownListener(self._onClickDirDown, self, dirEnum.West)
	self._btnW:AddClickUpListener(self._onClickDirUp, self, dirEnum.West)
	self._btnE:AddClickListener(self._onClickDir, self, dirEnum.East)
	self._btnE:AddClickDownListener(self._onClickDirDown, self, dirEnum.East)
	self._btnE:AddClickUpListener(self._onClickDirUp, self, dirEnum.East)
	self._btnS:AddClickListener(self._onClickDir, self, dirEnum.South)
	self._btnS:AddClickDownListener(self._onClickDirDown, self, dirEnum.South)
	self._btnS:AddClickUpListener(self._onClickDirUp, self, dirEnum.South)
	self._btnAlchemy:AddClickListener(self._onClickAlchemy, self)
	self._btnEventDesc:AddClickListener(self._onClickOptionResult, self)
	self._btnEventDescViewPort:AddClickListener(self._onClickOptionResult, self)
	self._btnState:AddClickListener(self._onClickBtnState, self)
end

function LoperaLevelView:removeEvents()
	self._btnN:RemoveClickListener()
	self._btnN:RemoveClickDownListener()
	self._btnN:RemoveClickUpListener()
	self._btnW:RemoveClickListener()
	self._btnW:RemoveClickDownListener()
	self._btnW:RemoveClickUpListener()
	self._btnE:RemoveClickListener()
	self._btnE:RemoveClickDownListener()
	self._btnE:RemoveClickUpListener()
	self._btnS:RemoveClickListener()
	self._btnS:RemoveClickDownListener()
	self._btnS:RemoveClickUpListener()
	self._btnAlchemy:RemoveClickListener()
	self._btnEventDesc:RemoveClickListener()
	self._btnEventDescViewPort:RemoveClickListener()
	self._btnState:RemoveClickListener()
end

function LoperaLevelView:_onClickAlchemy()
	LoperaController.instance:openSmeltView()
end

function LoperaLevelView:_onClickDir(dir)
	if not self._moveAbleDirs[dir] then
		return
	end

	self._dir = dir

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_common_click)
	LoperaController.instance:moveToDir(dir)
end

function LoperaLevelView:_onClickDirDown(dir)
	if not self._moveAbleDirs[dir] then
		return
	end

	gohelper.setActive(self._dirBtnPressStatsGos[dir], true)
end

function LoperaLevelView:_onClickDirUp(dir)
	if not self._moveAbleDirs[dir] then
		return
	end

	gohelper.setActive(self._dirBtnPressStatsGos[dir], false)
end

function LoperaLevelView:_onClickOptionResult()
	if self._curState == LoperaLevelState.OptionDesc then
		if self._isShowingDescTyping then
			self._isShowingDescTyping = false

			if self._tweenId then
				ZProj.TweenHelper.KillById(self._tweenId, true)

				self._tweenId = nil
			end

			if self._moveRectTweenId then
				ZProj.TweenHelper.KillById(self._moveRectTweenId)

				self._moveRectTweenId = nil
			end

			self._textEventDesc.text = self._descContent

			local descHeight = self._textEventDesc.preferredHeight

			if descHeight > descScrollHeight then
				local textEventDescTrans = self._textEventDesc.transform

				recthelper.setHeight(textEventDescTrans, descHeight - descScrollHeight)
			end
		else
			self:_changeLevelState(LoperaLevelState.SelectDir)
		end
	end
end

function LoperaLevelView:_onClickBtnState()
	gohelper.setActive(self._goBuffItemRoot, not self._goBuffItemRoot.activeSelf)
end

function LoperaLevelView:onOpen()
	self.addEventCb(self, LoperaController.instance, LoperaEvent.ExitGame, self.onExitGame, self)
	self.addEventCb(self, LoperaController.instance, LoperaEvent.EpisodeMove, self._onMoveInEpisode, self)
	self.addEventCb(self, LoperaController.instance, LoperaEvent.SelectOption, self._onSelectedOption, self)
	self.addEventCb(self, LoperaController.instance, LoperaEvent.EpisodeFinish, self._onGetToDestination, self)
	self.addEventCb(self, LoperaController.instance, LoperaEvent.ComposeDone, self._onSmeltResult, self)

	self._redDotComp = RedDotController.instance:addNotEventRedDot(self._goSmeltRed, self._hasSmeltRed, self)

	local curGameState = Activity168Model.instance:getCurGameState()

	self._curEventId = curGameState.eventId
	self._curActionPoint = Activity168Model.instance:getCurActionPoint()
	self._moveAbleDirs = {}
	self._endLessId = curGameState.endlessId
	self._isEndLess = self._endLessId > 0
	self._curEpisode = Activity168Model.instance:getCurEpisodeId()

	local episodeCfg = Activity168Config.instance:getEpisodeCfg(loperaActId, self._curEpisode)

	self:_initBgView()

	self._dirBtnNormalStateGos = self:getUserDataTb_()
	self._dirBtnNormalStateGos[dirEnum.North] = self._goNNormal
	self._dirBtnNormalStateGos[dirEnum.South] = self._goSNormal
	self._dirBtnNormalStateGos[dirEnum.West] = self._goWNormal
	self._dirBtnNormalStateGos[dirEnum.East] = self._goENormal
	self._dirBtnPressStatsGos = self:getUserDataTb_()
	self._dirBtnPressStatsGos[dirEnum.North] = self._goNPress
	self._dirBtnPressStatsGos[dirEnum.South] = self._goSPress
	self._dirBtnPressStatsGos[dirEnum.West] = self._goWPress
	self._dirBtnPressStatsGos[dirEnum.East] = self._goEPress

	self:_resetDirPressState()

	self._showTipsRoundNum = Activity168Config.instance:getConstCfg(loperaActId, 6).value1

	if self._curEventId ~= 0 then
		if curGameState.option <= 0 then
			self._curState = LoperaLevelState.SelectOption or LoperaLevelState.SelectDir
		end
	else
		self._curState = LoperaLevelState.SelectDir
	end

	local isNewGame = curGameState.round == 1

	if self._isEndLess then
		-- block empty
	else
		local curMapId = episodeCfg.mapId

		self._curMapCfg = Activity168Config.instance:getMapCfg(curMapId)

		if isNewGame then
			local var_10_0 = Activity168Config.instance:getMapStartCell()

			if not var_10_0 then
				var_10_0 = Activity168Config.instance:getMapCellByCoord({
					curGameState.x,
					curGameState.y
				})

				local startCell = var_10_0

				self._curCellIdx = startCell[mapCfgIdx.id] + 1
			end
		end
	end

	if isNewGame then
		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_2LoperaPlayStory, "")
	end

	self:_initLeftInfoView()
	self:updatePowerInfoView()
	self:updateLocationInfoView()
	self:_changeLevelState(self._curState)
end

function LoperaLevelView:onExitGame()
	self:closeThis()
end

function LoperaLevelView:updateStateView()
	if self._redDotComp then
		self._redDotComp:refreshRedDot()
	end

	local newValue = Activity168Model.instance:getCurActionPoint()

	if newValue ~= self._curActionPoint then
		self:updatePowerInfoView()
	end

	self._curActionPoint = Activity168Model.instance:getCurActionPoint()

	if self._curState == LoperaLevelState.SelectDir then
		gohelper.setActive(self._goDir, true)
		gohelper.setActive(self._goOption, false)
		gohelper.setActive(self._eventDescRoot, false)
		self:updateLeftInfoView()
		self:_resetDirPressState()
		self:updateDirView()

		local oriCost = Activity168Config.instance:getConstCfg(loperaActId, LoperaEnum.OriStepCostId).value1
		local costNum = Activity168Model.instance:getCurMoveCost(oriCost)

		if costNum <= self._curActionPoint then
			self:refreshDestinationTips()
		end
	elseif self._curState == LoperaLevelState.SelectOption then
		self:_refreshOptionStateView()
	elseif self._curState == LoperaLevelState.OptionDesc then
		gohelper.setActive(self._goOption, false)
		self:updateOptionReusltDescView()
		self:updateLeftInfoView()
	end
end

function LoperaLevelView:_refreshOptionStateView()
	gohelper.setActive(self._goDir, false)
	gohelper.setActive(self._eventDescRoot, true)
	self:updateLeftInfoView()
	self:updateEventDescView()
	self:createEventOptions()
	self:_playEventAni()
	TaskDispatcher.runDelay(self._delayShowOptionList, self, showOptionListDelay)
end

function LoperaLevelView:_delayShowOptionList()
	gohelper.setActive(self._goOption, true)
end

function LoperaLevelView:_initLeftInfoView()
	self._curEpisode = Activity168Model.instance:getCurEpisodeId()

	local episodeCfg = Activity168Config.instance:getEpisodeCfg(loperaActId, self._curEpisode)

	self._textStageName.text = episodeCfg.orderId
end

function LoperaLevelView:updateLeftInfoView()
	self:updateBuffInfoView()
end

function LoperaLevelView:updatePowerInfoView()
	local value = Activity168Model.instance:getCurActionPoint()

	value = value < 0 and 0 or value

	local actionPointStr = string.format(" <color=#ffd06b>%s</color>", value)

	self._textActionPoint.text = formatLuaLang("remain", actionPointStr)

	gohelper.setActive(self._gpActionPointEffect, false)
	gohelper.setActive(self._gpActionPointEffect, true)
	self:_playViewAudio(AudioEnum.VersionActivity2_2Lopera.play_ui_molu_exit_appear)
end

function LoperaLevelView:updateLocationInfoView()
	if self._isEndLess then
		self._textLocation.text = luaLang("p_v2a2_lopera_endless_location")
	else
		local curCell = self._curMapCfg[self._curCellIdx]

		self._textLocation.text = curCell[mapCfgIdx.name]

		gohelper.setActive(self._goLocationEffect, false)
		gohelper.setActive(self._goLocationEffect, true)
		self:_playViewAudio(AudioEnum.VersionActivity2_2Lopera.play_ui_checkpoint_elementappear)
	end
end

function LoperaLevelView:updateBuffInfoView()
	local buffs = Activity168Model.instance:getCurGameState().buffs
	local buffInfoList = {}

	for _, buff in ipairs(buffs) do
		local buffInfo = {}

		buffInfo.id = buff.id
		buffInfo.round = buff.round
		buffInfo.ext = buff.ext
		buffInfoList[#buffInfoList + 1] = buffInfo
	end

	gohelper.setActive(self._goBuff, #buffInfoList > 0)
	gohelper.CreateObjList(self, self._createBuffItem, buffInfoList, self._goBuffItemRoot, self._goBuffInfoItem)
end

function LoperaLevelView:_createBuffItem(itemGo, buffInfo, index)
	local buffText = gohelper.onceAddComponent(itemGo, gohelper.Type_TextMesh)
	local effectCfg = Activity168Config.instance:getOptionEffectCfg(buffInfo.id)
	local effectParams = effectCfg.effectParams
	local effectParamArr = string.splitToNumber(effectParams, "#")
	local effectNum = effectParamArr[1]

	if effectNum > 0 then
		if not ("+" .. effectNum) then
			local effectNumStr = effectNum
			local effectRound = buffInfo.round
			local lang = luaLang("lopera_buff_info_desc1")
			local param = {
				effectNumStr,
				effectRound
			}

			buffText.text = GameUtil.getSubPlaceholderLuaLang(lang, param)
		end
	end
end

function LoperaLevelView:updateDirView()
	local dirArray

	if self._isEndLess then
		dirArray = Activity168Model.instance:getCurGameState().dirs
	else
		local curCell = self._curMapCfg[self._curCellIdx]
		local dirStr = curCell[mapCfgIdx.dir]

		dirArray = string.splitToNumber(dirStr, "#")
	end

	for _, dirGo in ipairs(self._dirBtnNormalStateGos) do
		gohelper.setActive(dirGo, false)
	end

	self._moveAbleDirs = {}

	for _, dirValue in ipairs(dirArray) do
		self._moveAbleDirs[dirValue] = true

		gohelper.setActive(self._dirBtnNormalStateGos[dirValue], true)
	end

	local oriCost = Activity168Config.instance:getConstCfg(loperaActId, LoperaEnum.OriStepCostId).value1
	local costNum = Activity168Model.instance:getCurMoveCost(oriCost)

	self._txtPowerCostNum.text = costNum <= 0 and 0 or "-" .. math.abs(costNum)
end

function LoperaLevelView:_resetDirPressState()
	for dir, pressGo in pairs(self._dirBtnPressStatsGos) do
		gohelper.setActive(pressGo, false)
	end
end

function LoperaLevelView:_initBgView()
	local bgPath

	gohelper.setActive(self._bgRoot, true)

	if self._isEndLess then
		local endLessCfg = Activity168Config.instance:getEndlessLevelCfg(loperaActId, self._endLessId)
		local bgName = endLessCfg.scene

		bgPath = loperaLevelBgDir .. bgName .. ".png"
	else
		bgPath = loperaLevelBgDir .. normalLevelBg
	end

	if bgPath then
		self._simagebg:LoadImage(bgPath)
		self._simagebg1:LoadImage(bgPath)
	end
end

function LoperaLevelView:updateEventDescView()
	local eventCfg = Activity168Config.instance:getEventCfg(VersionActivity2_2Enum.ActivityId.Lopera, self._curEventId)

	self:beginShowDescContent((eventCfg or nil) and string.format(eventDescColorFormat, eventCfg.name))
	gohelper.setActive(self._goDescArrow, false)
	gohelper.setActive(self._btnEventDesc.gameObject, false)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_mIn_unlock)
end

function LoperaLevelView:beginShowDescContent(content)
	self._isShowingDescTyping = true
	self._descContent = content
	self._tweenTime = 0
	self._separateChars = self:getSeparateChars(content)

	local txtLen = #self._separateChars
	local time = txtLen * 0.02

	self:_destroyTween()

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(1, txtLen, time, self._onTweenFrameCallback, self._onTypingTweenFinish, self, nil, EaseType.Linear)
end

function LoperaLevelView:_onTweenFrameCallback(value)
	if self._finsihShowTxt or value - self._tweenTime < 1 then
		return
	end

	if value <= #self._separateChars then
		local index = math.floor(value)

		self._textEventDesc.text = self._separateChars[index]

		local descHeight = self._textEventDesc.preferredHeight

		if descHeight > descScrollHeight and not self._moveRectTweenId then
			local textEventDescTrans = self._textEventDesc.transform

			self._moveRectTweenId = ZProj.TweenHelper.DOLocalMoveY(textEventDescTrans, descHeight - descScrollHeight, 0.25, nil, nil)

			recthelper.setHeight(textEventDescTrans, descHeight - descScrollHeight)
		end
	else
		self._textEventDesc.text = self._descContent
	end

	self._tweenTime = value
end

function LoperaLevelView:_onTypingTweenFinish()
	self:_destroyTween()

	self._isShowingDescTyping = false
	self._textEventDesc.text = self._descContent
end

function LoperaLevelView:updateOptionReusltDescView()
	local optionCfg = Activity168Config.instance:getEventOptionCfg(VersionActivity2_2Enum.ActivityId.Lopera, self._curOptionId)

	if not optionCfg then
		return
	end

	local content = ""

	content = string.format(eventDescColorFormat, optionCfg.desc)

	local effectCfg = Activity168Config.instance:getOptionEffectCfg(optionCfg.effectId)

	if effectCfg then
		content = content .. "\n" .. luaLang("lopera_event_effect_title")

		if effectCfg.effectType == LoperaEnum.EffectType.ActionPointChange then
			content = content .. actionPointIconRichTxt .. effectCfg.effectParams
		else
			local effectParams = string.splitToNumber(effectCfg.effectParams, "#")

			if effectParams[1] > 0 then
				if not ("+" .. effectParams[1]) then
					local effectCostStr = effectParams[1]
					local effectRound = effectParams[2]
					local lang = luaLang("lopera_event_effect_buff_info")
					local param = {
						actionPointIconRichTxt,
						effectCostStr,
						effectRound
					}
					local effectContent = GameUtil.getSubPlaceholderLuaLang(lang, param)

					content = content .. effectContent
				end
			end
		end
	end

	local getItems = Activity168Model.instance:getItemChangeDict()

	if getItems then
		local rewardStr = ""

		for itemId, count in pairs(getItems) do
			local itemCfg = Activity168Config.instance:getGameItemCfg(loperaActId, itemId)

			if count > 0 then
				rewardStr = rewardStr .. (rewardStr == "" and "" or ",") .. itemCfg.name .. "*" .. count
			end
		end

		rewardStr = string.format(rewardColorFormat, rewardStr)
		content = content .. "\n" .. luaLang("p_seasonsettlementview_rewards") .. rewardStr
	end

	self:beginShowDescContent(content)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_mIn_unlock)
	gohelper.setActive(self._goDescArrow, false)
	gohelper.setActive(self._goDescArrow, true)
	gohelper.setActive(self._btnEventDesc.gameObject, true)
end

function LoperaLevelView:createEventOptions()
	local optionCfgList = {
		0
	}
	local eventCfg = Activity168Config.instance:getEventCfg(VersionActivity2_2Enum.ActivityId.Lopera, self._curEventId)
	local optionIdArray = string.splitToNumber(eventCfg.optionIds, "#")

	for _, optionId in ipairs(optionIdArray) do
		optionCfgList[#optionCfgList + 1] = Activity168Config.instance:getEventOptionCfg(VersionActivity2_2Enum.ActivityId.Lopera, optionId)
	end

	gohelper.CreateObjList(self, self._createOption, optionCfgList, self._goOptionItemRoot, self._goOptionItem, LoperaLevelOptionItem, 2)
end

function LoperaLevelView:_createOption(optionComp, optionCfgData, index)
	optionComp:onUpdateMO(optionCfgData)

	optionComp._view = self
end

function LoperaLevelView:_changeLevelState(state)
	self._curState = state

	if self._waitPopResult then
		self:_onGetToDestination(self._resultParams)

		self._waitPopResult = nil
	end

	self:updateStateView()
end

function LoperaLevelView:refreshDestinationTips()
	local tipsViewParams = {}
	local gameState = Activity168Model.instance:getCurGameState()
	local curRoundNum = gameState.round

	if self._isEndLess then
		if curRoundNum ~= 1 then
			return
		end

		tipsViewParams.isEndLess = self._isEndLess

		ViewMgr.instance:openView(ViewName.LoperaLevelTipsView, tipsViewParams)

		return
	end

	local curCell = self._curMapCfg[self._curCellIdx]

	if curCell[mapCfgIdx.destination] then
		return
	end

	local episodeCfg = Activity168Config.instance:getEpisodeCfg(loperaActId, self._curEpisode)

	tipsViewParams.mapId = episodeCfg.mapId

	if curRoundNum == 1 then
		tipsViewParams.isBeginning = true

		ViewMgr.instance:openView(ViewName.LoperaLevelTipsView, tipsViewParams)
	elseif curRoundNum > 0 and curRoundNum % self._showTipsRoundNum == 0 and not self._isEndLess then
		tipsViewParams.cellIdx = self._curCellIdx

		ViewMgr.instance:openView(ViewName.LoperaLevelTipsView, tipsViewParams)
	end
end

function LoperaLevelView:refreshFinishTips()
	local tipsViewParams = {}
	local episodeCfg = Activity168Config.instance:getEpisodeCfg(loperaActId, self._curEpisode)

	tipsViewParams.mapId = episodeCfg.mapId
	tipsViewParams.isFinished = true

	local isTipsViewOpen = ViewMgr.instance:isOpen(ViewName.LoperaLevelTipsView)

	if isTipsViewOpen then
		ViewMgr.instance:closeView(ViewName.LoperaLevelTipsView)
	end

	ViewMgr.instance:openView(ViewName.LoperaLevelTipsView, tipsViewParams)
end

function LoperaLevelView:_onGetToDestination(resultData)
	gohelper.setActive(self._goSmeltBtn, false)

	self._resultParams = resultData

	if self._curState == LoperaLevelState.OptionDesc then
		self._waitPopResult = true

		return
	end

	local reason = resultData.settleReason

	if LoperaEnum.ResultEnum.Quit == reason then
		return
	elseif LoperaEnum.ResultEnum.PowerUseup == reason then
		LoperaController.instance:openGameResultView(resultData)

		return
	end

	if self._playingMoving then
		TaskDispatcher.runDelay(self._doFinishAction, self, moveDuration)
	else
		self:_doFinishAction()
	end
end

function LoperaLevelView:_doFinishAction()
	if self._isEndLess then
		LoperaController.instance:openGameResultView(self._resultParams)
	else
		self:_playFinishStory()
	end
end

function LoperaLevelView:_playFinishStory()
	local endCellData = Activity168Config.instance:getMapEndCell()
	local endStory = endCellData[mapCfgIdx.storyId]
	local isSkipStory = endStory == 0

	if isSkipStory then
		self:_onFinishStoryEnd()
	else
		StoryController.instance:playStory(endStory, nil, self._onFinishStoryEnd, self)

		self._playingCellStory = true
	end
end

function LoperaLevelView:_onFinishStoryEnd()
	self._playingCellStory = false

	LoperaController.instance:openGameResultView(self._resultParams)
	self:refreshFinishTips()
end

function LoperaLevelView:_onMoveInEpisode()
	UIBlockMgr.instance:startBlock(moveUIBlock)
	self:_playMoveAni()
	TaskDispatcher.runDelay(self._onMoveEnd, self, moveDuration)
end

function LoperaLevelView:_playMoveAni()
	self._playingMoving = true

	local playFootprint = true

	if self._isEndLess then
		playFootprint = true
	else
		local curCell = self._curMapCfg[self._curCellIdx]
		local curCoord = curCell[mapCfgIdx.coord]
		local newCellCoord = self:_addDirCoord(curCoord, self._dir)
		local newCell = Activity168Config.instance:getMapCellByCoord(newCellCoord)

		playFootprint = not newCell[mapCfgIdx.destination]
	end

	if playFootprint then
		if self._endLessId == 2 then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_youyu_steps_wood)
		else
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_youyu_steps_jungle)
		end
	end

	self._bgAnimator:Play("move", 0, 0)
end

function LoperaLevelView:_playEventAni()
	self._bgAnimator:Play("wiggle", 0, 0)
end

function LoperaLevelView:_onMoveEnd()
	UIBlockMgr.instance:endBlock(moveUIBlock)

	self._playingMoving = false
	self._curEventId = Activity168Model.instance:getCurGameState().eventId

	if self._isEndLess then
		if self._curEventId and self._curEventId ~= 0 then
			if not LoperaLevelState.SelectOption then
				local nextState = LoperaLevelState.SelectDir

				self:_changeLevelState(nextState)
			end
		end
	else
		local curCell = self._curMapCfg[self._curCellIdx]
		local curCoord = curCell[mapCfgIdx.coord]
		local newCellCoord = self:_addDirCoord(curCoord, self._dir)
		local newCell = Activity168Config.instance:getMapCellByCoord(newCellCoord)

		self._curCellIdx = newCell[mapCfgIdx.id] + 1

		local storyId = newCell[mapCfgIdx.storyId]
		local storyEventId = newCell[mapCfgIdx.storyEvent]
		local gameState = Activity168Model.instance:getCurGameState()
		local curRoundNum = gameState.round
		local needPlayStory = true

		if storyId and storyId ~= 0 and storyEventId == 0 and not newCell[mapCfgIdx.destination] then
			local playedStoryRecord = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_2LoperaPlayStory, "")
			local playedStorys = string.splitToNumber(playedStoryRecord, "#")

			for _, playedStoryId in pairs(playedStorys) do
				if playedStoryId == storyId then
					needPlayStory = false

					break
				end
			end

			if newCell[mapCfgIdx.start] and curRoundNum > 1 then
				needPlayStory = false
			end

			if needPlayStory then
				playedStoryRecord = playedStoryRecord .. "#" .. storyId

				GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_2LoperaPlayStory, playedStoryRecord)
				StoryController.instance:playStory(storyId, nil, self._onPlayCellStoryEnd, self)

				self._playingCellStory = true
			else
				self:_onPlayCellStoryEnd()
			end
		elseif self._curEventId and self._curEventId ~= 0 then
			self:_changeLevelState(LoperaLevelState.SelectOption)
		else
			self:_changeLevelState(LoperaLevelState.SelectDir)
		end

		self:updateLocationInfoView()
	end
end

function LoperaLevelView:_onPlayCellStoryEnd()
	self._playingCellStory = false

	self:_changeLevelState(LoperaLevelState.SelectOption)
end

function LoperaLevelView:_onSelectedOption()
	local curGameState = Activity168Model.instance:getCurGameState()

	if self._isEndLess then
		self._curOptionId = curGameState.option
	else
		self._curOptionId = curGameState.option

		local curCell = self._curMapCfg[self._curCellIdx]

		if curCell and curCell[mapCfgIdx.storyId] and curCell[mapCfgIdx.storyId] ~= 0 then
			local storyId = curCell[mapCfgIdx.storyId]
			local storyEventId = curCell[mapCfgIdx.storyEvent]

			if self._curEventId == storyEventId then
				StoryController.instance:playStory(storyId, nil, nil, self)
			end
		end
	end

	self:_changeLevelState(LoperaLevelState.OptionDesc)
end

function LoperaLevelView:_hasSmeltRed()
	return LoperaController.instance:checkAnyComposable()
end

function LoperaLevelView:_onSmeltResult()
	if self._redDotComp then
		self._redDotComp:refreshRedDot()
	end
end

function LoperaLevelView:_playViewAudio(audioId)
	if self._playingCellStory then
		return
	end

	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local topView = viewNameList[#viewNameList]

	if topView ~= ViewName.LoperaLevelView and topView ~= ViewName.LoperaLevelTipsView then
		return
	end

	AudioMgr.instance:trigger(audioId)
end

function LoperaLevelView:_addDirCoord(oriCoord, dir)
	local newCoord = {
		oriCoord[1],
		oriCoord[2]
	}

	if dir == dirEnum.North then
		newCoord[2] = newCoord[2] + 1
	end

	if dir == dirEnum.South then
		newCoord[2] = newCoord[2] - 1
	end

	if dir == dirEnum.West then
		newCoord[1] = newCoord[1] - 1
	end

	if dir == dirEnum.East then
		newCoord[1] = newCoord[1] + 1
	end

	return newCoord
end

function LoperaLevelView:getSeparateChars(txt)
	local charList = {}

	if not string.nilorempty(txt) then
		local lineList = string.split(txt, "\n")
		local str = ""

		for j = 1, #lineList do
			local waitBrackets = false

			if not string.nilorempty(lineList[j]) then
				local chars = LuaUtil.getUCharArr(lineList[j])

				for i = 1, #chars do
					if chars[i] == "<" then
						waitBrackets = true
					elseif chars[i] == ">" then
						waitBrackets = false
					end

					str = str .. chars[i]

					if not waitBrackets then
						table.insert(charList, str)
					end
				end

				str = str .. "\n"

				table.insert(charList, str)
			end
		end
	end

	return charList
end

function LoperaLevelView:_destroyTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if self._moveRectTweenId then
		ZProj.TweenHelper.KillById(self._moveRectTweenId)

		self._moveRectTweenId = nil
	end
end

function LoperaLevelView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagebg1:UnLoadImage()
	TaskDispatcher.cancelTask(self._doFinishAction, self)
	TaskDispatcher.cancelTask(self._onMoveEnd, self)
	TaskDispatcher.cancelTask(self._delayShowOptionList, self)
	self:_destroyTween()
end

return LoperaLevelView
