-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recastglory/view/RecastGlorymainView.lua

module("logic.extensions.recastglory.view.RecastGlorymainView", package.seeall)

local RecastGlorymainView = class("RecastGlorymainView", ViewComponent)

function RecastGlorymainView:ctor()
	RecastGlorymainView.super.ctor(self)
end

function RecastGlorymainView:unbindEvents()
	RecastGlorymainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBreakThrough)
	self._tipsCustomInput:RemoveListener()

	for _, restoreCell in ipairs(self._restoreUI) do
		GameUtil.rmClickHandler(restoreCell.btnRestore)
		GameUtil.rmClickHandler(restoreCell.btnJump)
	end

	for _, tagData in ipairs(self._tagUI) do
		for _, tagCell in ipairs(tagData) do
			GameUtil.rmClickHandler(tagCell.go)
		end
	end
end

function RecastGlorymainView:bindEvents()
	RecastGlorymainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnBreakThrough, self._onClickBreakthrough, self)
	self._tipsCustomInput:AddListener(self._onCustomInputCallback, self)
end

function RecastGlorymainView:buildUI()
	RecastGlorymainView.super.buildUI(self)

	self._tip = self:getGo("tip")

	local bottom = self:getGo("bottom/reward")

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnBreakThrough = self:getBtn("btnBreakthrough")
	self._breakThroughEffect = self:getGo("btnBreakthrough/effect")
	self._rdBreakThrough = self:getGo("btnBreakthrough/redPoint")
	self._txtBreakthroughTip = self:getTxt("breakthroughTip/txt")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtTip = self:getTxt("tip/txtscrollContent/Viewport/Content")
	self._txtCumulative = self:getTxt("bottom/txtCumulative/txtNumber")
	self._tipsCustomInput = UICustomInput.Get(self._tip)
	self._playerSliderMo = PlayerSliderMo.New(bottom)
	self._restoreUI = {}
	self._tagUI = {}
	self._restoreUIRoot = self:getGo("restore")

	for restoreId = 1, self._restoreUIRoot.transform.childCount do
		local restoreCell = {}

		restoreCell.go = goutil.findChild(self._restoreUIRoot, "cell_" .. restoreId)

		if restoreCell.go then
			restoreCell.role = goutil.findChildImageComponent(restoreCell.go, "role")
			restoreCell.redPoint = goutil.findChild(restoreCell.go, "redPoint")
			restoreCell.btnRestore = goutil.findChildButtonComponent(restoreCell.go, "btnRestore")
			restoreCell.btnJump = goutil.findChildButtonComponent(restoreCell.go, "btnJump")
			restoreCell.btnGet = goutil.findChildButtonComponent(restoreCell.go, "btnGet")
			restoreCell.lock = goutil.findChild(restoreCell.btnRestore, "lock")
			restoreCell.tagRoot = goutil.findChild(restoreCell.go, "tag")

			local tagData = {}

			for tagId = 1, restoreCell.tagRoot.transform.childCount do
				local tagCell = {}

				tagCell.go = goutil.findChild(restoreCell.tagRoot, "tagCell_" .. tagId)

				if tagCell.go then
					tagCell.changeImageCom = tagCell.go:GetComponent(ComponentType.UIImageSpriteChange)
					tagCell.con = goutil.findChild(tagCell.go, "con")
					tagCell.effect = goutil.findChild(tagCell.go, "effect")
					tagCell.txtTitle = goutil.findChildTextComponent(tagCell.go, "txtTitle")

					table.insert(tagData, tagCell)
				end
			end

			self._tagUI[restoreId] = tagData

			table.insert(self._restoreUI, restoreCell)
		end
	end
end

function RecastGlorymainView:onExit()
	RecastGlorymainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.RestoreGloryInfoReq, self._refreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.RestoreGloryGainSpacePrizeReq, self._refreshUI, self)
	self._playerSliderMo:onExit()
	RedPointController.instance:unregRedPoint(self._rdBreakThrough)

	for _, cell in ipairs(self._restoreUI) do
		RedPointController.instance:unregRedPoint(cell.redPoint)
		uGuiUtil.clearImage(cell.role.gameObject)
	end

	for _, effect in ipairs(self._effectList) do
		UIEffectManager.instance:stopEffect(effect)
	end

	self._effectList = {}
end

function RecastGlorymainView:onEnter()
	RecastGlorymainView.super.onEnter(self)

	self._activityId = RestoreGloryController.instance:getActivityId()
	self._activityType = RestoreGloryController.instance:getActivityType()

	local isInTime = RestoreGloryController.instancec:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._gloryCfg = RecastGloryConfig.instance:getGloryCfgById(self._activityId)
	self._progressCfg = RecastGloryConfig.instance:getGloryProgressCfg(self._gloryCfg.progressPlanId)
	self._petCfg = RecastGloryConfig.instance:getGloryPetCfg(self._gloryCfg.progressPlanId)

	RestoreGloryController.instance:sendPM_RestoreGloryGetInfoReq(self._activityId)
	GlobalDispatcher:addListener(GlobalNotify.RestoreGloryInfoReq, self._refreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.RestoreGloryGainSpacePrizeReq, self._refreshUI, self)
	RedPointController.instance:regRedPoint(self._rdBreakThrough, RedPointModel.ID_RECASTGLORY_BREAKTHROUGH)

	local enterKey = ViewName.RecastGlorymainView .. "enter"
	local isFristEnterGame = GameUtil.getUserData(enterKey)

	if not isFristEnterGame then
		StoryController.instance:startStory(self._gloryCfg.storyId)
	end

	GameUtil.saveUserData(enterKey, true)

	self._effectList = {}

	if RecastGloryModel.instance:getRestoreState() then
		RecastGloryModel.instance:setRestoreState(false)
		self:_popBreakthroughTip()
	end

	self:_setTimeUI()
	self:_breakthroughUI()
	self:_initPlayerParams()
end

function RecastGlorymainView:_setTimeUI()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	local startDate, endDate = GameUtil.time2date(startTime), GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

function RecastGlorymainView:_setRestoreUI()
	GameUtil.SetActive(self._tip, false)

	for id, restoreCell in ipairs(self._restoreUI) do
		local cfg = self._petCfg[id]
		local restoreFinishId = RecastGloryModel.instance:getRestoreFinishId()
		local isLock = restoreFinishId < cfg.restoreId - 1
		local isRestore = restoreFinishId >= cfg.restoreId

		if isRestore then
			if not cfg.newBg then
				local imgPath = cfg.oldBg

				local function func()
					restoreCell.role:SetNativeSize()
				end

				uGuiUtil.setSpriteToImage(restoreCell.role.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("recastglory", imgPath), func)
				GameUtil.SetActive(restoreCell.lock, isLock)
				GameUtil.SetActive(restoreCell.btnRestore, not isRestore)
				GameUtil.SetActive(restoreCell.btnJump, isRestore)
				GameUtil.addClickHandler(restoreCell.btnRestore, GameUtil.handler(self._onClickRestore, self, cfg.restoreJumpStr, cfg.restoreId))
				GameUtil.addClickHandler(restoreCell.btnJump, GameUtil.handler(self._onClickJump, self, cfg.restoreId, cfg.jumpTo))
				GameUtil.addClickHandler(restoreCell.btnGet, GameUtil.handler(self._onClickGet, self, cfg.restoreId, cfg.awakenJumpTo))
				self:_setTagInfo(cfg.labelPlanId, isRestore)
				RedPointController.instance:regRedPoint(restoreCell.redPoint, cfg.redPointId)

				if cfg.restoreId >= #self._petCfg and isRestore then
					RedPointController.instance:regRedPoint(restoreCell.redPoint, RedPointModel.ID_RECASTGLORYTASK)
				end

				RedPointController.instance:setRedPointInfo(cfg.redPointId, not isRestore and not isLock)
				SurveyController.instance:reportBehavior(cfg.surveyBehaviorId)
			end
		end
	end
end

function RecastGlorymainView:_setTagInfo(labelPlanId, isRestore)
	local tagCfg = RecastGloryConfig.instance:getGloryTagCfg(labelPlanId)

	for id, tagCell in ipairs(self._tagUI[labelPlanId]) do
		local cfg = tagCfg[id]

		if isRestore then
			tagCell.txtTitle.text = cfg.newTitle or cfg.oldTitle
		end

		tagCell.changeImageCom:SetState(isRestore and 1 or 0)

		if isRestore then
			local effectPath = "20230331/chongzhurongguang/fx_ui_chongzhurongguang_baoqi.prefab"

			self:_restoreEffectPlay(effectPath, tagCell.effect, true)
		else
			local effectPath = "20230331/chongzhurongguang/fx_ui_chongzhurongguang_huibai.prefab"

			self:_restoreEffectPlay(effectPath, tagCell.effect, true)
		end

		GameUtil.addClickHandler(tagCell.go, GameUtil.handler(self._onClickTagCell, self, cfg, tagCell.con, isRestore))
	end
end

function RecastGlorymainView:_breakthroughUI()
	local time = GameUtil.string2time(self._gloryCfg.startTime or "")
	local timeDate = GameUtil.string2date(self._gloryCfg.startTime or "")
	local nowTime = ServerTime.now()
	local isCanBreakthrough = time <= nowTime and RestoreGloryController.instance:isGainAllPrize(self._gloryCfg.progressPlanId)

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_RECASTGLORY_BREAKTHROUGH, isCanBreakthrough)

	local key = "RecastGlorymainguideEffect"

	if time <= nowTime and not GameUtil.getUserData(key) then
		local guideEffectPath = "fx_ui_yongzhezhita/fx_ui_yongzhezhita_xuanzhuan.prefab"

		self:_restoreEffectPlay(guideEffectPath, self._breakThroughEffect, true)
		GameUtil.saveUserData(key, true)
	end

	self._txtBreakthroughTip.text = string.format("%02d月%02d号全民开启突破&满觉获得", timeDate.month, timeDate.day)
end

function RecastGlorymainView:_popBreakthroughTip()
	if RecastGloryModel.instance:getRestoreFinishId() >= #self._petCfg then
		TipsFacade.instance:openRulesView("recastgloryruleview")
	end
end

function RecastGlorymainView:_refreshUI()
	self:_setRestoreUI()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()

	self._txtCumulative.text = RecastGloryModel.instance:getFinishNum()
end

function RecastGlorymainView:_restoreEffectPlay(path, parent, loop)
	local effectPath = path
	local effect = UIEffectManager.instance:playEffect(self, effectPath, parent, 0, 0, loop, nil, nil, nil, self)

	effect:setParent(parent.transform)
	effect:setLocalPos(0, 0, 0)
	effect:setScale(1)
	table.insert(self._effectList, effect)
end

function RecastGlorymainView:_initPlayerParams()
	if not self._progressCfg then
		return
	end

	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = self._progressCfg

	function playerParam.getPlayerProgress()
		return RecastGloryModel.instance:getFinishNum()
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.progress
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		local isFinishRestore = RecastGloryModel.instance:getRestoreFinishId() >= #self._petCfg
		local isReachProgress = RecastGloryModel.instance:getFinishNum() >= rewardCfg.progress
		local isGainPrize = RecastGloryModel.instance:getHasGainPrize(rewardCfg.progressId)

		return isFinishRestore and isReachProgress and not isGainPrize
	end

	playerParam.effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return RecastGloryModel.instance:getHasGainPrize(rewardCfg.progressId)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		RestoreGloryController.instance:sendPM_RestoreGloryGainSpacePrizeReq(self._activityId, rewardCfg.progressId)
	end

	local isSkipAnimation = true

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function RecastGlorymainView:_onClickTip()
	TipsFacade.instance:openRulesView("recastgloryruleview")
end

function RecastGlorymainView:_onClickTagCell(cfg, con, isRestore)
	goutil.addChildToParent(self._tip, con)
	GameUtil.setLocalPos(self._tip, 0, 0, 0)
	GameUtil.SetActive(self._tip, true)

	if isRestore then
		if not cfg.newdes then
			self._txtTip.text = cfg.olddes
		end
	end
end

function RecastGlorymainView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._tip, false)
	end
end

function RecastGlorymainView:_onClickRestore(restoreJumpStr, restoreId)
	local restoreFinishId = RecastGloryModel.instance:getRestoreFinishId()

	if restoreFinishId < restoreId - 1 then
		FloatWordMgr.instance:show("请先通过前一关卡")

		return
	end

	GotoMgr.gotoByString(restoreJumpStr)
end

function RecastGlorymainView:_onClickJump(restoreId, str)
	if restoreId >= #self._petCfg and not self:_isInTime() then
		FloatWordMgr.instance:show("3.31更新后开启获得，敬请期待！")

		return
	end

	GotoMgr.gotoByString(str)
end

function RecastGlorymainView:_onClickGet(restoreId, str)
	GotoMgr.gotoByString(str)
end

function RecastGlorymainView:_onClickBreakthrough()
	local timestamp = GameUtil.string2date(self._gloryCfg.startTime or "")

	if not self:_isInTime() then
		local desc = string.format("%02d月%02d号全民开启突破", timestamp.month, timestamp.day)

		FloatWordMgr.instance:show(desc)

		return
	end

	GotoMgr.gotoByString("func#856")
end

function RecastGlorymainView:_isInTime()
	local time = GameUtil.string2time(self._gloryCfg.startTime or "")
	local nowTime = ServerTime.now()

	if nowTime < time then
		return false
	end

	return true
end

return RecastGlorymainView
