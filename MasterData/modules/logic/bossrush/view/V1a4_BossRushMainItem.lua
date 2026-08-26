-- chunkname: @modules/logic/bossrush/view/V1a4_BossRushMainItem.lua

module("modules.logic.bossrush.view.V1a4_BossRushMainItem", package.seeall)

local V1a4_BossRushMainItem = class("V1a4_BossRushMainItem", LuaCompBase)
local EAnime = BossRushEnum.AnimMainItem

function V1a4_BossRushMainItem:init(go)
	self.viewGO = gohelper.findChild(go, "Root")
	self._btnItemBG = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_ItemBG")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goUnlocked = gohelper.findChild(self.viewGO, "#go_Unlocked")
	self._imageIssxIcon = gohelper.findChildImage(self.viewGO, "#go_Unlocked/Title/#image_IssxIcon")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#go_Unlocked/Title/#txt_Title")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "#go_Unlocked/Title/#txt_TitleEn")
	self._btnGo = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Unlocked/#btn_Go", AudioEnum.ui_activity.play_ui_activity_open)
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._txtLocked = gohelper.findChildText(self.viewGO, "#go_Locked/#txt_Locked")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Locked/#btn_Locked")
	self._goRecord = gohelper.findChild(self.viewGO, "#go_Record")
	self._txtRecordNum = gohelper.findChildText(self.viewGO, "#go_Record/#txt_RecordNum")
	self._goAssessIcon = gohelper.findChild(self.viewGO, "#go_Record/#go_AssessIcon")
	self._goRed = gohelper.findChild(self.viewGO, "#go_Red")
	self._imgItemBG = gohelper.findChildImage(self.viewGO, "#btn_ItemBG")
	self._go3s = gohelper.findChild(self.viewGO, "3s")
	self._go4s = gohelper.findChild(self.viewGO, "4s")
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a4_BossRushMainItem:addEventListeners()
	self._btnItemBG:AddClickListener(self._btnItemBGOnClick, self)
	self._btnGo:AddClickListener(self._btnGoOnClick, self)
	self._btnLocked:AddClickListener(self._btnLockedOnClick, self)
end

function V1a4_BossRushMainItem:removeEventListeners()
	self._btnItemBG:RemoveClickListener()
	self._btnGo:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
end

function V1a4_BossRushMainItem:_btnItemBGOnClick()
	self:_onClick()
end

function V1a4_BossRushMainItem:_btnGoOnClick()
	self:_onClick()
end

function V1a4_BossRushMainItem:_btnLockedOnClick()
	self:_onClick()
end

function V1a4_BossRushMainItem:_editableInitView()
	self:_initAssessIcon()

	self._txtLocked.text = ""
	self._txtRecordNum.text = ""
end

function V1a4_BossRushMainItem:onDestroy()
	self:onDestroyView()
end

function V1a4_BossRushMainItem:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_assessIcon")

	self._isForcePlayUnlock = false
	self._openAnim = false

	self._simagebg:UnLoadImage()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.cancelTask(self._delayOpenCallBack, self)
end

function V1a4_BossRushMainItem:_initAssessIcon()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.V1a4_BossRushMainView)
	local itemClass = V1a4_BossRush_AssessIcon
	local go = viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_mainview_assessicon, self._goAssessIcon, itemClass.__cname)

	self._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)

	self._assessIcon:initData(self, false)
end

function V1a4_BossRushMainItem:setData(mo, isOpenTween)
	self._mo = mo

	self:_refresh()
	self:_setActive(false)

	if isOpenTween then
		TaskDispatcher.runDelay(self._delayOpenCallBack, self, self._index * 0.06)
	else
		self:_playIdle()
	end

	if not self:_isOpen() then
		self:_onRefreshDeadline()
		TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
	end

	self:_refreshRed()
end

function V1a4_BossRushMainItem:_refresh()
	local mo = self._mo
	local stageCO = mo.stageCO
	local stage = stageCO.stage
	local isOpened = self:_isOpen()
	local issxIconName = BossRushConfig.instance:getIssxIconName(stage)
	local highestPoint = BossRushModel.instance:getHighestPoint(stage)
	local stageName = stageCO.name

	if not string.nilorempty(stageName) then
		local charLen = string.len(stageName)

		if charLen >= 4 then
			local bigSize = "<size=67>%s</size>"
			local str1 = stageName:sub(1, 3)
			local str2 = stageName:sub(4, charLen - 3)
			local str3 = stageName:sub(charLen - 2, charLen)

			stageName = string.format(bigSize, str1) .. str2 .. string.format(bigSize, str3)
		end
	end

	UISpriteSetMgr.instance:setCommonSprite(self._imageIssxIcon, issxIconName)
	gohelper.setActive(self._goRecord, isOpened)

	self._txtRecordNum.text = highestPoint
	self._txtTitle.text = stageName
	self._txtTitleEn.text = stageCO.name_en

	self._simagebg:LoadImage(BossRushConfig.instance:getBossRushMainItemBossSprite(stage))

	local special = BossRushModel.instance:getLayer4HightScore(stage) == highestPoint

	if special then
		if not BossRushEnum.AssessType.Layer4 then
			local type = BossRushEnum.AssessType.Normal

			self._assessIcon:setData(stage, highestPoint, type)

			if isOpened then
				gohelper.addUIClickAudio(self._btnItemBG.gameObject, AudioEnum.UI.UI_Activity_open)
			end

			local res, level = BossRushConfig.instance:getAssessMainBossBgName(stage, highestPoint, type)

			UISpriteSetMgr.instance:setV1a4BossRushSprite(self._imgItemBG, res)

			local is3s = level and level == BossRushEnum.ScoreLevel.S_AA
			local is4s = level and level == BossRushEnum.ScoreLevel.S_AAA

			gohelper.setActive(self._go3s, is3s)
			gohelper.setActive(self._go4s, is4s)
		end
	end
end

function V1a4_BossRushMainItem:_isOpen()
	local stage = self:_getStage()

	return BossRushModel.instance:isBossOnline(stage)
end

function V1a4_BossRushMainItem:_getStage()
	local mo = self._mo
	local stageCO = mo.stageCO

	return stageCO.stage
end

function V1a4_BossRushMainItem:_onRefreshDeadline()
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

function V1a4_BossRushMainItem:_onClick()
	local mo = self._mo

	BossRushController.instance:openLevelDetailView(mo)
	BossRushRedModel.instance:setIsNewUnlockStage(self:_getStage(), false)
end

function V1a4_BossRushMainItem:_delayOpenCallBack()
	self:_setActive(true)

	if self:_getIsNewUnlockStage() then
		self:_playUnlock(true)

		return
	end

	self:_playOpen()
end

function V1a4_BossRushMainItem:_getIsNewUnlockStage()
	local stage = self:_getStage()

	return self:_isOpen() and BossRushRedModel.instance:getIsPlayUnlockAnimStage(stage)
end

function V1a4_BossRushMainItem:_playOpen()
	if self:_isOpen() then
		self:_playAnim(EAnime.OpeningUnlocked, 0, 0)
	else
		self:_playAnim(EAnime.OpeningLocked, 0, 0)
	end
end

function V1a4_BossRushMainItem:_playIdle()
	if self:_isOpen() then
		self:_playAnim(EAnime.UnlockedIdle, 0, 1)
	else
		self:_playAnim(EAnime.LockedIdle, 0, 1)
	end
end

function V1a4_BossRushMainItem:_playUnlock(isForce)
	self:_playAnim(EAnime.Unlock, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.play_ui_qiutu_list_maintain)

	self._isForcePlayUnlock = false

	gohelper.setActive(self._goRecord, true)

	local stage = self:_getStage()

	BossRushRedModel.instance:setIsPlayUnlockAnimStage(self:_getStage(), false)

	local stageLayerInfos = BossRushModel.instance:getStageLayersInfo(stage)

	if stageLayerInfos then
		for i, info in ipairs(stageLayerInfos) do
			local layer = info.layerCO.layer

			BossRushRedModel.instance:setIsNewUnlockStageLayer(stage, layer, true)
		end
	end
end

function V1a4_BossRushMainItem:_playUnlocking()
	TaskDispatcher.cancelTask(self._delayOpenCallBack, self)
	self:_playAnim(EAnime.Unlocking, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_4_qiutu.play_ui_qiutu_list_maintain)

	self._isForcePlayUnlock = false

	gohelper.setActive(self._goRecord, true)
end

function V1a4_BossRushMainItem:_setActive(bool)
	gohelper.setActive(self.viewGO, bool)
end

function V1a4_BossRushMainItem:_playAnim(eAnime, ...)
	if self._anim then
		self._anim:Play(eAnime, ...)
	end
end

function V1a4_BossRushMainItem:_refreshRed()
	local stage = self:_getStage()

	RedDotController.instance:addRedDot(self._goRed, RedDotEnum.DotNode.BossRushBoss, stage)
end

return V1a4_BossRushMainItem
