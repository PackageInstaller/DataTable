-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_MainItem.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_MainItem", package.seeall)

local V3a2_BossRush_MainItem = class("V3a2_BossRush_MainItem", LuaCompBase)

function V3a2_BossRush_MainItem:ctor(viewContainer)
	self.viewContainer = viewContainer
end

function V3a2_BossRush_MainItem:init(go)
	self.viewGO = go
	self._btnItemBG = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_item")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Locked/#btn_Locked")
	self._goUnlocked = gohelper.findChild(self.viewGO, "#go_Unlocked")
	self._simageBG2 = gohelper.findChildSingleImage(self.viewGO, "#go_Unlocked/#simage_BG")
	self._simageBoss2 = gohelper.findChildSingleImage(self.viewGO, "#go_Unlocked/#simage_BOSS")
	self._imageIssxIcon = gohelper.findChildImage(self.viewGO, "#go_Unlocked/Title/image_TitleBG/#image_IssxIcon")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#go_Unlocked/Title/image_TitleBG/#txt_Title")
	self._btnGo = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Unlocked/#btn_Go", AudioEnum.ui_activity.play_ui_activity_open)
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._txtLocked = gohelper.findChildText(self.viewGO, "#go_Locked/#txt_Locked")
	self._goRecord = gohelper.findChild(self.viewGO, "#go_Record")
	self._txtRecordNum = gohelper.findChildText(self.viewGO, "#go_Record/#txt_RecordNum")
	self._goAssessIcon = gohelper.findChild(self.viewGO, "#go_Record/#go_AssessIcon")
	self._goRed = gohelper.findChild(self.viewGO, "#go_Red")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a2_BossRush_MainItem:addEventListeners()
	self._btnItemBG:AddClickListener(self._btnItemBGOnClick, self)

	if self._btnLocked then
		self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
	end
end

function V3a2_BossRush_MainItem:removeEventListeners()
	self._btnItemBG:RemoveClickListener()

	if self._btnLocked then
		self._btnLocked:RemoveClickListener()
	end
end

function V3a2_BossRush_MainItem:_btnItemBGOnClick()
	self:_onClick()
end

function V3a2_BossRush_MainItem:_btnLockedOnClick()
	self:_onClick()
end

function V3a2_BossRush_MainItem:_editableInitView()
	self._unlockAnim = self._goUnlocked:GetComponent(gohelper.Type_Animator)

	local go3s = gohelper.findChild(self.viewGO, "3s")
	local go4s = gohelper.findChild(self.viewGO, "4s")
	local go5s = gohelper.findChild(self.viewGO, "5s")

	self._govx = self:getUserDataTb_()
	self._govx[BossRushEnum.ScoreLevelStr.SSS] = go3s
	self._govx[BossRushEnum.ScoreLevelStr.SSSS] = go4s
	self._govx[BossRushEnum.ScoreLevelStr.SSSSS] = go5s
	self._govx[BossRushEnum.ScoreLevelStr.SSSSSS] = go5s

	self:_initAssessIcon()

	if self._txtLocked then
		self._txtLocked.text = ""
	end

	if self._txtRecordNum then
		self._txtRecordNum.text = ""
	end

	self._simageBG1 = gohelper.findChildSingleImage(self.viewGO, "#go_Locked/#simage_BG")
	self._simageBoss1 = gohelper.findChildSingleImage(self.viewGO, "#go_Locked/#simage_BOSS")
	self._simageBG1 = self._simageBG1 or gohelper.findChildSingleImage(self.viewGO, "#go_Unlocked/locked/#simage_BG")
	self._simageBoss1 = self._simageBoss1 or gohelper.findChildSingleImage(self.viewGO, "#go_Unlocked/locked/#simage_BOSS")
end

function V3a2_BossRush_MainItem:setData(mo, index)
	self._mo = mo
	self._index = index

	self:_refresh()

	if not self:_isOpen() then
		self:_onRefreshDeadline()
		TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
	end

	self:_refreshRed()
end

function V3a2_BossRush_MainItem:_refresh()
	local mo = self._mo
	local stageCO = mo.stageCO
	local stage = stageCO.stage
	local isOpened = self:_isOpen()
	local issxIconName = BossRushConfig.instance:getIssxIconName(stage)

	self._actId = stageCO.activityId

	local stageMo = V3a9_BossRushModel.instance:getStageMo(self._actId, stage)

	if stageMo then
		if not stageMo.highestPoint then
			local highestPoint = 0
			local stageName = stageCO.name

			UISpriteSetMgr.instance:setCommonSprite(self._imageIssxIcon, issxIconName)
			gohelper.setActive(self._goRecord, isOpened)

			if self._txtRecordNum then
				self._txtRecordNum.text = BossRushConfig.instance:getScoreStr(highestPoint)
			end

			self._txtTitle.text = stageName

			local type = BossRushEnum.AssessType.V3a2

			if not self._assessIcon then
				self:_initAssessIcon()
			end

			self._assessIcon:setData(stage, highestPoint, type)

			if isOpened then
				gohelper.addUIClickAudio(self._btnItemBG.gameObject, AudioEnum.UI.UI_Activity_open)
			end

			local _, _, strLevel = BossRushConfig.instance:getAssessSpriteName(stage, highestPoint, type)
			local scoreVX = self._govx[strLevel]

			for lv, go in pairs(self._govx) do
				local isShow = isOpened and scoreVX == go

				gohelper.setActive(go, isShow)
			end

			local iconName = string.format("%s_0%s", stageCO.bossRushMainItemBossSprite, self._index)
			local bossIcon = ResUrl.getBossRushBossPath(iconName)

			if self._simageBoss1 then
				self._simageBoss1:LoadImage(bossIcon)
			end

			if self._simageBoss2 then
				self._simageBoss2:LoadImage(bossIcon)
			end

			local bgName = string.format("%s_bg%s", stageCO.bossRushMainBg, self._index)

			if self._simageBG1 then
				self._simageBG1:LoadImage(ResUrl.getBossRushBossBGPath(bgName))
			end

			if self._simageBG2 then
				self._simageBG2:LoadImage(ResUrl.getBossRushBossBGPath(bgName))
			end

			self:_refreshStatus()
		end
	end
end

function V3a2_BossRush_MainItem:_onRefreshDeadline()
	if not self._txtLocked then
		return
	end

	local stage = self:_getStage()
	local openTs = BossRushModel.instance:getStageOpenServerTime(stage)
	local deltaTs = openTs - ServerTime.now()

	if deltaTs > 0 then
		self._txtLocked.text = BossRushConfig.instance:getRemainTimeStrWithFmt(deltaTs, Activity128Config.ETimeFmtStyle.UnLock)
	else
		TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
		self:_refresh()
	end
end

function V3a2_BossRush_MainItem:_initAssessIcon()
	if not self.viewContainer then
		local viewContainer = ViewMgr.instance:getContainer(ViewName.V3a2_BossRush_MainView)
		local itemClass = V1a4_BossRush_AssessIcon
		local go = viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_mainview_assessicon, self._goAssessIcon, itemClass.__cname)

		self._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)

		self._assessIcon:initData(self, false)
	end
end

function V3a2_BossRush_MainItem:_onClick()
	BossRushController.instance:openV3a2LevelDetailView(self._mo)
	self:_checkNewUnlock()
	self:_refreshReddotType()
end

function V3a2_BossRush_MainItem:_checkNewUnlock()
	local stage = self:_getStage()

	if BossRushRedModel.instance:getIsNewUnlockStage(stage) then
		BossRushRedModel.instance:setIsNewUnlockStage(stage, false)
	end

	local stageLayerInfos = BossRushModel.instance:getStageLayersInfo(stage)

	if stageLayerInfos then
		for i, info in pairs(stageLayerInfos) do
			local layer = info.layerCO.layer

			if BossRushRedModel.instance:getIsNewUnlockStageLayer(stage, layer) then
				BossRushRedModel.instance:setIsNewUnlockStageLayer(stage, layer, false)
			end
		end
	end
end

function V3a2_BossRush_MainItem:_isOpen()
	return self._mo:isOpen()
end

function V3a2_BossRush_MainItem:_getStage()
	return self._mo.stage
end

function V3a2_BossRush_MainItem:_refreshStatus()
	local stage = self:_getStage()
	local isOpen = self:_isOpen()

	gohelper.setActive(self._goLocked, not isOpen)
	gohelper.setActive(self._goUnlocked, isOpen)
	gohelper.setActive(self._goAssessIcon, isOpen)

	if isOpen and self._index == 1 and self._unlockAnim then
		local isNewUnlock = BossRushRedModel.instance:getIsNewUnlockStage(stage)

		if isNewUnlock then
			if not V3a2BossRushEnum.AnimName.Unlock then
				local animName = V3a2BossRushEnum.AnimName.Idle

				self._unlockAnim:Play(animName, 0, 0)

				if isNewUnlock then
					BossRushRedModel.instance:setIsPlayUnlockAnimStage(stage, false)
					AudioMgr.instance:trigger(AudioEnum3_2.BossRush.play_ui_zongmao_jiesuo)
				end
			end
		end
	end
end

function V3a2_BossRush_MainItem:_refreshRed()
	local stage = self:_getStage()

	self._reddotItem = RedDotController.instance:addRedDot(self._goRed, RedDotEnum.DotNode.BossRushBoss, stage)

	self._reddotItem:overrideRefreshDotFunc(self._refreshReddotType, self)
end

function V3a2_BossRush_MainItem:_refreshReddotType()
	local stage = self:_getStage()
	local isNewUnlock = BossRushRedModel.instance:getIsNewUnlockStage(stage)

	if isNewUnlock then
		local type = RedDotEnum.Style.NewTag

		gohelper.setActive(self._goRed, true)
		self._reddotItem:showRedDot(type)

		return
	end

	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.BossRushBossReward, stage) then
		local type = RedDotConfig.instance:getRedDotCO(RedDotEnum.DotNode.BossRushBoss).style

		gohelper.setActive(self._goRed, true)
		self._reddotItem:showRedDot(type)

		return
	end

	gohelper.setActive(self._goRed, false)
end

function V3a2_BossRush_MainItem:onDestroy()
	self:onDestroyView()
end

function V3a2_BossRush_MainItem:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_assessIcon")
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)

	if self._simageBoss1 then
		self._simageBoss1:UnLoadImage()
	end

	if self._simageBoss2 then
		self._simageBoss2:UnLoadImage()
	end

	if self._simageBG1 then
		self._simageBG1:UnLoadImage()
	end

	if self._simageBG2 then
		self._simageBG2:UnLoadImage()
	end

	self:_checkNewUnlock()
end

return V3a2_BossRush_MainItem
