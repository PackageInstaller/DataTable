-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroStageItem.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroStageItem", package.seeall)

local DiceHeroStageItem = class("DiceHeroStageItem", LuaCompBase)

function DiceHeroStageItem:init(go)
	self._btnClick = gohelper.findChildButton(go, "")
	self.viewGo = gohelper.findChild(go, "#go_levelitem")
	self._gonormal = gohelper.findChild(self.viewGo, "#go_normal")
	self._golock = gohelper.findChild(self.viewGo, "#go_lock")
	self._gochallenge = gohelper.findChild(self.viewGo, "#go_challenge")
	self._gocompleted = gohelper.findChild(self.viewGo, "#go_completed")
	self._gopart = gohelper.findChild(go, "Part")
	self._gobossicon1 = gohelper.findChild(go, "Part/#go_BossIcon")
	self._gobossicon2 = gohelper.findChild(go, "Part/#go_BigBossIcon")
	self._lockAnim = gohelper.findChildAnim(self.viewGo, "#go_lock")
	self._completedAnim = gohelper.findChildAnim(self.viewGo, "#go_completed")
end

function DiceHeroStageItem:addEventListeners()
	self._btnClick:AddClickListener(self._onClickStage, self)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.InfoUpdate, self._onInfoUpdate, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function DiceHeroStageItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.InfoUpdate, self._onInfoUpdate, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function DiceHeroStageItem:initData(data, isInfinite)
	self._co = data
	self.isInfinite = isInfinite

	gohelper.setActive(self._gobossicon1, data.enemyType == 1)
	gohelper.setActive(self._gobossicon2, data.enemyType == 2)
	self:_onInfoUpdate()
end

function DiceHeroStageItem:_onCloseViewFinish()
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.DiceHeroLevelView) then
		return
	end

	self:_onInfoUpdate()

	if self._showUnlockAnim then
		gohelper.setActive(self._lockAnim, true)
		self._lockAnim:Play("unlock", 0, 0)
		TaskDispatcher.runDelay(self._hideLock, self, 2.4)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockHelper.instance:startBlock("DiceHeroStageItem_Unlock", 2)
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_unclockglass)
	end

	if self._showPassAnim then
		self._showPassAnim = false

		self._completedAnim:Play("completeglow", 0, 0)
	end
end

function DiceHeroStageItem:_hideLock()
	UIBlockMgrExtend.setNeedCircleMv(true)
	gohelper.setActive(self._lockAnim, false)

	self._showUnlockAnim = false
end

function DiceHeroStageItem:_onInfoUpdate()
	local gameInfo = DiceHeroModel.instance:getGameInfo(self._co.chapter)

	if self._unLockStatu ~= nil and not ViewHelper.instance:checkViewOnTheTop(ViewName.DiceHeroLevelView) then
		local unLockStatu = self._co.room - gameInfo.co.room

		if unLockStatu ~= self._unLockStatu then
			if unLockStatu == 0 then
				self._showUnlockAnim = true
			elseif unLockStatu == -1 and self.isInfinite then
				self._showPassAnim = true
			end
		end

		return
	end

	local var_7_0 = self._gonormal
	local var_7_1

	if not self.isInfinite then
		if self._co.room >= gameInfo.co.room then
			var_7_1 = gameInfo.allPass

			if not gameInfo.allPass then
				var_7_1 = false and false

				goto label_7_0
			end
		end
	end

	::label_7_0::

	gohelper.setActive(var_7_0, true)

	local var_7_2 = self._gocompleted
	local var_7_3

	if self.isInfinite then
		if self._co.room >= gameInfo.co.room then
			var_7_3 = gameInfo.allPass

			if not gameInfo.allPass then
				var_7_3 = false and false

				goto label_7_1
			end
		end
	end

	::label_7_1::

	gohelper.setActive(var_7_2, true)
	gohelper.setActive(self._gochallenge, self._co.room == gameInfo.co.room and not gameInfo.allPass)
	gohelper.setActive(self._golock, self._co.room > gameInfo.co.room)
	gohelper.setActive(self._gopart, self._co.room <= gameInfo.co.room)

	self._unLockStatu = self._co.room - gameInfo.co.room
end

function DiceHeroStageItem:_onClickStage()
	if not self._co then
		return
	end

	local gameInfo = DiceHeroModel.instance:getGameInfo(self._co.chapter)

	if gameInfo.co.room > self._co.room then
		if self.isInfinite then
			GameFacade.showToast(ToastEnum.DiceHeroPassLevel)

			return
		end

		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_glassclick)

		if self._co.type == DiceHeroEnum.LevelType.Story then
			ViewMgr.instance:openView(ViewName.DiceHeroTalkView, {
				co = self._co
			})
		else
			DiceHeroRpc.instance:sendDiceHeroEnterFight(self._co.id, self._onEnterFight, self)
		end

		return
	elseif gameInfo.co.room < self._co.room then
		GameFacade.showToast(ToastEnum.DiceHeroLockLevel)

		return
	end

	AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_wenming_glassclick)

	if self._co.type == DiceHeroEnum.LevelType.Story then
		if DiceHeroModel.instance:hasReward(self._co.chapter) or self._co.rewardSelectType == DiceHeroEnum.GetRewardType.None then
			self:_onOpenDialog()
		else
			DiceHeroRpc.instance:sendDiceHeroEnterStory(self._co.id, self._co.chapter, self._onEnterStory, self)
		end
	elseif self._co.type == DiceHeroEnum.LevelType.Fight then
		if DiceHeroModel.instance:hasReward(self._co.chapter) then
			self:_onOpenDialog()
		else
			DiceHeroRpc.instance:sendDiceHeroEnterFight(self._co.id, self._onEnterFight, self)
		end
	end
end

function DiceHeroStageItem:_onEnterStory(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:_onOpenDialog()
end

function DiceHeroStageItem:_onOpenDialog()
	if not self._co then
		return
	end

	ViewMgr.instance:openView(ViewName.DiceHeroTalkView, {
		co = self._co
	})
end

function DiceHeroStageItem:_onEnterFight(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.DiceHeroGameView)
end

function DiceHeroStageItem:onDestroy()
	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(self._hideLock, self)
end

return DiceHeroStageItem
