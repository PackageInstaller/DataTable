-- chunkname: @modules/logic/toughbattle/view/ToughBattleMapView.lua

module("modules.logic.toughbattle.view.ToughBattleMapView", package.seeall)

local ToughBattleMapView = class("ToughBattleMapView", BaseView)

function ToughBattleMapView:onInitView()
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._gostage1 = gohelper.findChild(self.viewGO, "#go_stagebg_1")
	self._gostage2 = gohelper.findChild(self.viewGO, "#go_stagebg_2")
	self._imgstage = gohelper.findChildImage(self.viewGO, "title/#simage_stagenum")
	self._txttitle = gohelper.findChildTextMesh(self.viewGO, "title/#txt_title")
	self._btnAbort = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_abort")
	self._goprogress = gohelper.findChild(self.viewGO, "#go_progress")
	self._txtprogress = gohelper.findChildTextMesh(self.viewGO, "#go_progress/bg/#txt_progress")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "#go_progress/progressbg/#image_progress")
end

function ToughBattleMapView:addEvents()
	self._btnAbort:AddClickListener(self._onAbort, self)
end

function ToughBattleMapView:removeEvents()
	self._btnAbort:RemoveClickListener()
	self.removeEventCb(self, GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, self.checkLoadingAndRefresh, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.checkLoadingAndRefresh, self)
end

function ToughBattleMapView:onOpen()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false, DungeonEnum.EpisodeListVisibleSource.ToughBattle)

	local go = self:getResInst(self.viewContainer._viewSetting.otherRes.rolelist, self.viewGO, "rolelist")
	local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, ToughBattleRoleListComp, self.viewParam)

	comp:setClickCallBack(self.onRoleSelect, self)

	self._roleComp = comp

	if self:isSceneLoading() then
		self.addEventCb(self, GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, self.checkLoadingAndRefresh, self)
		self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.checkLoadingAndRefresh, self)
		gohelper.setActive(self.viewGO, false)
	else
		self:checkLoadingAndRefresh()
	end
end

function ToughBattleMapView:isSceneLoading()
	local loadingState = GameGlobalMgr.instance:getLoadingState()

	if loadingState and loadingState:getLoadingViewName() then
		return true
	end
end

function ToughBattleMapView:playOpenAnim()
	self._viewAnim:Play("open", 0, 0)
	self._roleComp:playAnim("open")
end

function ToughBattleMapView:checkLoadingAndRefresh()
	gohelper.setActive(self.viewGO, true)
	self.removeEventCb(self, GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, self.checkLoadingAndRefresh, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.checkLoadingAndRefresh, self)
	self:refreshStage()
	self:playOpenAnim()
end

function ToughBattleMapView:refreshStage()
	local info = self:getInfo()
	local stage = 1

	if #info.passChallengeIds >= 3 and not self.viewParam.lastFightSuccIndex then
		stage = 2
	end

	gohelper.setActive(self._gostage1, stage == 1)
	gohelper.setActive(self._gostage2, stage == 2)
	gohelper.setActive(self._goprogress, stage == 1)
	UISpriteSetMgr.instance:setToughBattleSprite(self._imgstage, "toughbattle_fighttitlebg" .. stage)

	self._txttitle.text = stage == 1 and luaLang("toughbattle_stage1_title") or luaLang("toughbattle_stage2_title")

	if stage == 1 then
		local nowCount = #info.passChallengeIds

		if self.viewParam.lastFightSuccIndex then
			nowCount = nowCount - 1
		end

		self._txtprogress.text = GameUtil.getSubPlaceholderLuaLang(luaLang("toughbattle_mapview_txt_progress"), {
			nowCount,
			3
		})
		self._imageprogress.fillAmount = nowCount / 3

		if self.viewParam.lastFightSuccIndex then
			ToughBattleController.instance:dispatchEvent(ToughBattleEvent.BeginPlayFightSucessAnim)
			UIBlockHelper.instance:startBlock("ToughBattleMapViewAnim", 0.6, self.viewName)
			ZProj.TweenHelper.DOFillAmount(self._imageprogress, (nowCount + 1) / 3, 0.6, self.onTweenEnd, self, nil, EaseType.OutQuad)
		else
			ZProj.TweenHelper.KillByObj(self._imageprogress)
		end
	end
end

function ToughBattleMapView:onTweenEnd()
	local info = self:getInfo()
	local count = #info.passChallengeIds

	self._imageprogress.fillAmount = count / 3
	self._txtprogress.text = GameUtil.getSubPlaceholderLuaLang(luaLang("toughbattle_mapview_txt_progress"), {
		count,
		3
	})

	if self.viewParam.lastFightSuccIndex then
		self.viewParam.lastFightSuccIndex = nil

		if count >= 3 then
			UIBlockHelper.instance:startBlock("ToughBattleMapView_ShowLoading", 0.6, self.viewName)
			TaskDispatcher.runDelay(self._delayShowLoading, self, 0.6)
		end
	end
end

function ToughBattleMapView:_delayShowLoading()
	ToughBattleController.instance:dispatchEvent(ToughBattleEvent.StageUpdate)

	local isAct = self.viewParam.mode == ToughBattleEnum.Mode.Act

	if isAct then
		if not ViewName.ToughBattleActLoadingView then
			local loadingView = ViewName.ToughBattleLoadingView

			ViewMgr.instance:openView(loadingView, {
				stage = 2
			})
			self:refreshStage()
		end
	end
end

function ToughBattleMapView:onClose()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true, DungeonEnum.EpisodeListVisibleSource.ToughBattle)
	TaskDispatcher.cancelTask(self._delayShowLoading, self)
	ZProj.TweenHelper.KillByObj(self._imageprogress)
	self._roleComp:playAnim("close")
	TaskDispatcher.cancelTask(self.checkLoadingAndRefresh, self)
end

function ToughBattleMapView:getInfo()
	if self.viewParam.mode == ToughBattleEnum.Mode.Act then
		local var_12_0 = ToughBattleModel.instance:getActInfo()

		if not var_12_0 then
			var_12_0 = ToughBattleModel.instance:getStoryInfo()

			return var_12_0
		end
	end
end

function ToughBattleMapView:onRoleSelect(co)
	ViewMgr.instance:openView(ViewName.ToughBattleSkillView, {
		isShowList = true,
		showCo = co,
		mode = self.viewParam.mode
	})
end

function ToughBattleMapView:_onAbort()
	GameFacade.showMessageBox(MessageBoxIdDefine.ToughBattleAbort, MsgBoxEnum.BoxType.Yes_No, self._onClickSure, nil, nil, self, nil, nil)
end

function ToughBattleMapView:_onClickSure()
	if self.viewParam.mode == ToughBattleEnum.Mode.Act then
		Activity158Rpc.instance:sendAct158AbandonChallengeRequest(VersionActivity1_9Enum.ActivityId.ToughBattle, self._onRecvMsg, self)
	else
		SiegeBattleRpc.instance:sendAbandonSiegeBattleRequest(self._onRecvMsg, self)
	end
end

function ToughBattleMapView:_onRecvMsg(cmd, resultCode, msg)
	if resultCode == 0 then
		if self.viewParam.mode == ToughBattleEnum.Mode.Act then
			if not ViewName.ToughBattleActEnterView then
				local enterView = ViewName.ToughBattleEnterView

				ViewMgr.instance:openView(enterView, self.viewParam)
				self:closeThis()
			end
		end
	end
end

return ToughBattleMapView
