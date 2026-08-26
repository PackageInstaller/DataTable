-- chunkname: @modules/logic/rouge/view/RougeMainView.lua

module("modules.logic.rouge.view.RougeMainView", package.seeall)

local RougeMainView = class("RougeMainView", BaseViewExtended)

function RougeMainView:onInitView()
	self._btnfavorite = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_favorite")
	self._btncultivate = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_cultivate")
	self._goCultivateCanUp = gohelper.findChild(self.viewGO, "Left/#btn_cultivate/#go_up")
	self._goCultivateNew = gohelper.findChild(self.viewGO, "Left/#btn_cultivate/#go_new")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_reward")
	self._goRewardNew = gohelper.findChild(self.viewGO, "Left/#btn_reward/#go_new")
	self._txtRewardNum = gohelper.findChildText(self.viewGO, "Left/#btn_reward/#txt_RewardNum")
	self._btndlc = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_dlc")
	self._godlcreddot = gohelper.findChild(self.viewGO, "Left/#btn_dlc/#go_dlcreddot")
	self._btnexchange = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_exchange")
	self._btnachievement = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_achievement")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_start")
	self._gonew = gohelper.findChild(self.viewGO, "Right/#btn_start/#go_new")
	self._gofavoritenew = gohelper.findChild(self.viewGO, "Left/#btn_favorite/#go_new")
	self._goimage_start = gohelper.findChild(self.viewGO, "Right/#btn_start/#go_image_start")
	self._goimage_start2 = gohelper.findChild(self.viewGO, "Right/#btn_start/#go_image_start2")
	self._golocked = gohelper.findChild(self.viewGO, "Right/#go_locked")
	self._txttime = gohelper.findChildText(self.viewGO, "Right/#go_locked/#txt_time")
	self._goprogress = gohelper.findChild(self.viewGO, "Right/#go_progress")
	self._txtname = gohelper.findChildText(self.viewGO, "Right/#go_progress/#txt_name")
	self._txtdiffculty = gohelper.findChildText(self.viewGO, "Right/#go_progress/#txt_difficulty")
	self._btnend = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_end")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._gotitle = gohelper.findChild(self.viewGO, "title")
	self._gonormaltitle = gohelper.findChild(self.viewGO, "title/normal")
	self._godlctitles = gohelper.findChild(self.viewGO, "title/#go_dlctitles")
	self._txttoken = gohelper.findChildText(self.viewGO, "Right/#go_token/#txt_token")
	self._gotips = gohelper.findChild(self.viewGO, "Right/#go_token/#go_tips")
	self._txttoken2 = gohelper.findChildText(self.viewGO, "Right/#go_token/#go_tips/txt_title/#txt_token2")
	self._btnopentips = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_token/#btn_opentips")
	self._btnclosetips = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_token/#go_tips/#btn_closetips")
	self._txttips = gohelper.findChildText(self.viewGO, "Right/#go_token/#go_tips/TipsView/Viewport/Content/#txt_tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMainView:addEvents()
	self._btnfavorite:AddClickListener(self._btnfavoriteOnClick, self)
	self._btncultivate:AddClickListener(self._btncultivateOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btndlc:AddClickListener(self._btndlcOnClick, self)
	self._btnexchange:AddClickListener(self._btnexchangeOnClick, self)
	self._btnachievement:AddClickListener(self._btnachievementOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnend:AddClickListener(self._btnendOnClick, self)
	self._btnopentips:AddClickListener(self._btnopentipsOnClick, self)
	self._btnclosetips:AddClickListener(self._btnclosetipsOnClick, self)
end

function RougeMainView:removeEvents()
	self._btnfavorite:RemoveClickListener()
	self._btncultivate:RemoveClickListener()
	self._btnreward:RemoveClickListener()
	self._btndlc:RemoveClickListener()
	self._btnexchange:RemoveClickListener()
	self._btnachievement:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnend:RemoveClickListener()
	self._btnopentips:RemoveClickListener()
	self._btnclosetips:RemoveClickListener()
end

function RougeMainView:_btnfavoriteOnClick()
	RougeController.instance:openRougeFavoriteView()
end

function RougeMainView:_btncultivateOnClick()
	RougeController.instance:openRougeTalentTreeTrunkView()
end

function RougeMainView:_btnrewardOnClick()
	RougeController.instance:openRougeRewardView()
end

function RougeMainView:_btndlcOnClick()
	RougeController.instance:openRougeDLCSelectView()
end

function RougeMainView:_btnexchangeOnClick()
	return
end

function RougeMainView:_btnachievementOnClick()
	JumpController.instance:jump(RougeConfig1.instance:achievementJumpId())
end

function RougeMainView:_btnstartOnClick()
	self:_start()
end

function RougeMainView:_btnendOnClick()
	self:_end()
end

function RougeMainView:_btnopentipsOnClick()
	self:_refreshExtraPointTips(true)
	self._tipAnimatorPlayer:Play("open", function()
		return
	end, self)
end

function RougeMainView:_btnclosetipsOnClick()
	self._tipAnimatorPlayer:Play("close", self._closeExtraPointTips, self)
end

function RougeMainView:_editableInitView()
	RougeOutsideController.instance:initDLCReddotInfo()

	self._btnstartCanvasGroup = self._btnstart.gameObject:GetComponent(gohelper.Type_CanvasGroup)
	self._btnEndGo = self._btnend.gameObject
	self._gotitleeffect = gohelper.findChild(self.viewGO, "title/eff_switch")
	self._gotipscontent = gohelper.findChild(self.viewGO, "Right/#go_token/#go_tips/TipsView/Viewport/Content")

	gohelper.setActive(self._goimage_start, false)
	gohelper.setActive(self._goimage_start2, false)
	gohelper.setActive(self._btnEndGo, false)
	gohelper.setActive(self._golocked, false)
	gohelper.setActive(self._goprogress, false)
	gohelper.setActive(self._gonew, false)

	self._btnstartCanvasGroup.alpha = 1
	self._txtRewardNum.text = "0"
	self._txttime.text = ""
	self._originVersionStr = RougeDLCHelper.getCurVersionString()
	self._tipAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._gotips)

	self:_refreshExtraPointTips(false)
end

function RougeMainView:onUpdateParam()
	self:_refresh()
end

function RougeMainView:onOpen()
	self:onUpdateParam()
	RedDotController.instance:addRedDot(self._godlcreddot, RedDotEnum.DotNode.RougeDLCNew)
	RougeController.instance:registerCallback(RougeEvent.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
	RougeOutsideController.instance:registerCallback(RougeEvent.OnUpdateRougeOutsideInfo, self._onUpdateRougeOutsideInfo, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateFavoriteReddot, self._updateFavoriteNew, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, self._onUpdateRougeInfo, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, self._onUpdateRougeInfo, self)
	self.addEventCb(self, RougeDLCController.instance, RougeEvent.OnGetVersionInfo, self._onUpdateVersion, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewCallBack, self)
end

function RougeMainView:_updateFavoriteNew()
	local showNew = RougeFavoriteModel.instance:getAllReddotNum() > 0

	gohelper.setActive(self._gofavoritenew, showNew)
end

function RougeMainView:onOpenFinish()
	RougeController.instance:startEndFlow()
	RougeController.instance:dispatchEvent(RougeEvent.OpenRougeView)
end

function RougeMainView:onClose()
	self:_clearCdTick()
	RougeController.instance:unregisterCallback(RougeEvent.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
	RougeOutsideController.instance:unregisterCallback(RougeEvent.OnUpdateRougeOutsideInfo, self._onUpdateRougeOutsideInfo, self)
	self.removeEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, self._onUpdateRougeInfo, self)
	self.removeEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, self._onUpdateRougeInfo, self)
	TaskDispatcher.cancelTask(self._onSwitchTitleDone, self)
end

function RougeMainView:onDestroyView()
	self:_clearCdTick()
	TaskDispatcher.cancelTask(self._refreshDLCTitle, self)
end

function RougeMainView:_onUpdateRougeInfo()
	self:_refresh()
end

function RougeMainView:_onUpdateRougeOutsideInfo()
	self:_refresh()
end

function RougeMainView:_isContinueLast()
	return RougeModel.instance:isContinueLast()
end

function RougeMainView:_isInCdStart()
	return not self:_isContinueLast() and RougeOutsideModel.instance:isInCdStart()
end

function RougeMainView:_refresh()
	self:_refreshStartBtn()
	self:_refreshProgress()
	self:_refreshCDLocked()
	self:_updateFavoriteNew()
	self:_refreshTalentBtn()
	self:_refreshRewardBtn()
	self:_refreshExchangeBtn()
	self:_refreshTitle()
	self:_refreshExtraPoints()
end

function RougeMainView:_refreshTalentBtn()
	local isNew = RougeTalentModel.instance:checkIsNewStage()

	gohelper.setActive(self._goCultivateNew, isNew)

	local canup = RougeTalentModel.instance:checkAnyNodeCanUp()

	gohelper.setActive(self._goCultivateCanUp, canup)
end

function RougeMainView:_refreshRewardBtn()
	self._txtRewardNum.text = RougeRewardModel.instance:getRewardPoint()

	local isNew = RougeRewardModel.instance:checkIsNewStage()

	gohelper.setActive(self._goRewardNew, isNew)
end

function RougeMainView:_refreshStartBtn()
	local isContinueLast = self:_isContinueLast()

	gohelper.setActive(self._goimage_start, not isContinueLast)
	gohelper.setActive(self._goimage_start2, isContinueLast)
	self:_refreshEndBtn()
end

function RougeMainView:_refreshEndBtn()
	local isContinueLast = self:_isContinueLast()
	local inInCdStart = self:_isInCdStart()

	self._btnstartCanvasGroup.alpha = inInCdStart and 0.5 or 1

	gohelper.setActive(self._btnEndGo, not inInCdStart and isContinueLast)
end

function RougeMainView:_refreshProgress()
	gohelper.setActive(self._goprogress, false)

	local difficulty = RougeModel.instance:getDifficulty()

	if not difficulty or difficulty == 0 then
		return
	end

	gohelper.setActive(self._goprogress, true)

	local cfg = RougeOutsideModel.instance:config()
	local difficultyCO = cfg:getDifficultyCO(difficulty)

	self._txtdiffculty.text = difficultyCO.title

	if RougeModel.instance:isStarted() then
		local layerCo = RougeMapModel.instance:getLayerCo()
		local middleLayerCo = RougeMapModel.instance:getMiddleLayerCo()

		self._txtname.text = middleLayerCo and middleLayerCo.name or layerCo.name
	else
		self._txtname.text = ""
	end
end

function RougeMainView:_refreshCDLocked()
	self:_clearCdTick()

	if not self:_isInCdStart() then
		return
	end

	gohelper.setActive(self._golocked, true)
	self:_onRefreshCdTick()
	TaskDispatcher.runRepeat(self._onRefreshCdTick, self, 1)
end

function RougeMainView:_clearCdTick()
	gohelper.setActive(self._golocked, false)
	TaskDispatcher.cancelTask(self._onRefreshCdTick, self)
end

function RougeMainView:_onRefreshCdTick()
	local leftSec = RougeOutsideModel.instance:leftCdSec()

	if leftSec < 0 then
		self:_onCdTickEnd()

		return
	end

	local h, m, s = TimeUtil.secondToHMS(leftSec)

	self._txttime.text = formatLuaLang("rougemainview_cd_fmt", h, m, s)
end

function RougeMainView:_onCdTickEnd()
	self._txttime.text = ""

	self:_clearCdTick()
	self:_refreshStartBtn()
end

function RougeMainView:_start()
	if self:_isInCdStart() then
		return
	end

	if RougeController.instance:tryShowMessageBox() then
		return
	end

	if self:_isContinueLast() then
		if RougeModel.instance:isStarted() then
			RougeController.instance:enterRouge()
		elseif RougeModel.instance:isFinishedStyle() then
			RougeController.instance:openRougeInitTeamView()
		elseif RougeModel.instance:isFinishedLastReward() then
			RougeController.instance:openRougeFactionView()
		elseif RougeModel.instance:isFinishedDifficulty() then
			if RougeModel.instance:isCanSelectRewards() then
				RougeController.instance:openRougeSelectRewardsView()
			else
				RougeController.instance:openRougeFactionView()
			end
		else
			RougeController.instance:enterRouge()
		end

		RougeStatController.instance:statStart()

		return
	end

	RougeController.instance:openRougeDifficultyView()
	RougeStatController.instance:statStart()
end

function RougeMainView:_end()
	GameFacade.showMessageBox(MessageBoxIdDefine.RougeMainView_AbortRequest, MsgBoxEnum.BoxType.Yes_No, self._endYesCallback, nil, nil, self, nil, nil)
end

function RougeMainView:_endYesCallback()
	RougeStatController.instance:setReset()
	RougeRpc.instance:sendRougeAbortRequest(RougeModel.instance:getSeason(), self._onReceiveEndReply, self)
end

function RougeMainView:_onReceiveEndReply()
	RougeController.instance:startEndFlow()
end

function RougeMainView:_refreshExchangeBtn()
	local gameRecordInfo = RougeOutsideModel.instance:getRougeGameRecord()
	local versions = gameRecordInfo and gameRecordInfo:getVersionIds()
	local hasAddDLC = versions and #versions > 0

	gohelper.setActive(self._btnexchange.gameObject, not hasAddDLC)
end

function RougeMainView:_refreshTitle()
	self:_switchDLCTitle()
end

local TitleSwitchAnimDuration = 1.6

function RougeMainView:_switchDLCTitle()
	local newVersionStr = RougeDLCHelper.getCurVersionString()

	if newVersionStr == self._originVersionStr then
		self:_refreshDLCTitle()

		return
	end

	local originTitle, newTitle

	originTitle = string.nilorempty(self._originVersionStr) and self._gonormaltitle or gohelper.findChild(self._godlctitles, self._originVersionStr)
	newTitle = string.nilorempty(newVersionStr) and self._gonormaltitle or gohelper.findChild(self._godlctitles, newVersionStr)

	if not gohelper.isNil(originTitle) then
		gohelper.setActive(originTitle, true)

		local animator = gohelper.onceAddComponent(originTitle, gohelper.Type_Animator)

		animator:Play("fadeout", 0, 0)
	end

	if not gohelper.isNil(newTitle) then
		gohelper.setActive(newTitle, true)

		local animator = gohelper.onceAddComponent(newTitle, gohelper.Type_Animator)

		animator:Play("fadein", 0, 0)
	end

	gohelper.setActive(self._gotitleeffect, true)
	AudioMgr.instance:trigger(AudioEnum.UI.SwitchRougeDLC)
	TaskDispatcher.runDelay(self._onSwitchTitleDone, self, TitleSwitchAnimDuration)
end

function RougeMainView:_onSwitchTitleDone()
	self:_refreshDLCTitle()
end

function RougeMainView:_refreshDLCTitle()
	local newVersionStr = RougeDLCHelper.getCurVersionString()
	local dlcTitleCount = self._godlctitles.transform.childCount

	for i = 1, dlcTitleCount do
		local goDLCTitle = self._godlctitles.transform:GetChild(i - 1).gameObject
		local goDLCName = goDLCTitle.name

		gohelper.setActive(goDLCTitle, goDLCName == newVersionStr)
	end

	local notAddDLC = string.nilorempty(newVersionStr)

	gohelper.setActive(self._gonormaltitle, notAddDLC)
	gohelper.setActive(self._gotitleeffect, false)

	self._originVersionStr = newVersionStr
end

function RougeMainView:_refreshExtraPoints()
	self._maxExtraPoint = tonumber(lua_rouge_const.configDict[RougeEnum.Const.MaxExtraPoint].value)
	self._recoverExtraPoint = tonumber(lua_rouge_const.configDict[RougeEnum.Const.RecoverExtraPoint].value)
	self._curExtraPoint = RougeOutsideModel.instance:getCurExtraPoint()

	local str = string.format("%s/%s", self._curExtraPoint, self._maxExtraPoint)

	self._txttoken.text = str
	self._txttoken2.text = str
end

function RougeMainView:_refreshExtraPointTips(isVisible)
	gohelper.setActive(self._gotips, isVisible)

	if not isVisible then
		return
	end

	local tipStr = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("rougemainview_extrapointtips"), self._recoverExtraPoint, self._maxExtraPoint)
	local tipStrList = string.split(tipStr or "", "|")

	gohelper.CreateObjList(self, self._refreshSingleExtraPointTip, tipStrList, self._gotipscontent, self._txttips.gameObject)
end

function RougeMainView:_closeExtraPointTips()
	self:_refreshExtraPointTips(false)
end

function RougeMainView:_refreshSingleExtraPointTip(obj, tipStr, index)
	local txtComp = gohelper.onceAddComponent(obj, gohelper.Type_TextMesh)

	txtComp.text = tipStr
end

function RougeMainView:_onUpdateVersion()
	local isTop = self:checkIsTopView()

	if not isTop then
		self._waitUpdate = true

		return
	end

	self._waitUpdate = nil

	self:_refreshExchangeBtn()
	self:_refreshTitle()
end

function RougeMainView:_onCloseViewCallBack(viewName)
	if viewName == ViewName.RougeDLCSelectView and self._waitUpdate then
		self:_onUpdateVersion()
	end
end

local IgnoreViewMap = {
	[ViewName.ToastView] = true,
	[ViewName.ToastTopView] = true,
	[ViewName.WaterMarkView] = true,
	[ViewName.GuideView] = true
}

function RougeMainView:checkIsTopView()
	local openViewList = ViewMgr.instance:getOpenViewNameList()

	for i = #openViewList, 1, -1 do
		local viewName = openViewList[i]

		if not IgnoreViewMap[viewName] then
			return viewName == ViewName.RougeMainView
		end
	end
end

return RougeMainView
