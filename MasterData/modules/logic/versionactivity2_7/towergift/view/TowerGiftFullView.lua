-- chunkname: @modules/logic/versionactivity2_7/towergift/view/TowerGiftFullView.lua

module("modules.logic.versionactivity2_7.towergift.view.TowerGiftFullView", package.seeall)

local TowerGiftFullView = class("TowerGiftFullView", BaseView)

TowerGiftFullView.TaskId = 92001101

function TowerGiftFullView:onInitView()
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_check")
	self._btn1Claim = gohelper.findChildButtonWithAudio(self.viewGO, "root/reward1/go_canget/#btn_Claim")
	self._gocanget = gohelper.findChild(self.viewGO, "root/reward1/go_canget")
	self._goreceive = gohelper.findChild(self.viewGO, "root/reward1/go_receive")
	self._gotaskreceive = gohelper.findChild(self.viewGO, "root/reward2/go_receive")
	self._txtprogress = gohelper.findChildText(self.viewGO, "root/reward2/go_goto/#txt_progress")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/reward2/go_goto/txt_dec")
	self._txttime = gohelper.findChildText(self.viewGO, "root/simage_fullbg/#txt_time")
	self._gogoto = gohelper.findChild(self.viewGO, "root/reward2/go_goto")
	self._golock = gohelper.findChild(self.viewGO, "root/reward2/go_lock")
	self._btngoto = gohelper.findChildButtonWithAudio(self.viewGO, "root/reward2/go_goto/#btn_goto")
	self._btnicon = gohelper.findChildButtonWithAudio(self.viewGO, "root/reward2/icon/click")
	self._bgmId = nil

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerGiftFullView:addEvents()
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
	self._btn1Claim:AddClickListener(self._btn1ClaimOnClick, self)
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
	self._btnicon:AddClickListener(self._btniconOnClick, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshUI, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerRefreshTask, self.refreshUI, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerTaskUpdated, self.refreshUI, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.checkBgm, self)
end

function TowerGiftFullView:removeEvents()
	self._btncheck:RemoveClickListener()
	self._btn1Claim:RemoveClickListener()
	self._btngoto:RemoveClickListener()
	self._btnicon:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshUI, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerRefreshTask, self.refreshUI, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerTaskUpdated, self.refreshUI, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.checkBgm, self)
end

function TowerGiftFullView:_btncheckOnClick()
	local param = {
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect,
		heroId = TowerGiftEnum.ShowHeroList
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, param)
end

function TowerGiftFullView:_btn1ClaimOnClick()
	if not self:checkReceied() and self:checkCanGet() then
		Activity101Rpc.instance:sendGet101BonusRequest(self._actId, 1)
	end
end

function TowerGiftFullView:_btngotoOnClick()
	if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Tower) then
		TowerController.instance:openTowerTaskView()

		self._bgmId = BGMSwitchModel.instance:getCurBgm()
	else
		local canJump, toastId, toastParamList = JumpController.instance:canJumpNew(JumpEnum.JumpView.Tower)

		if not canJump then
			GameFacade.showToastWithTableParam(toastId, toastParamList)

			return false
		end
	end
end

function TowerGiftFullView:_btniconOnClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, TowerGiftEnum.StoneUpTicketId)
end

function TowerGiftFullView:_editableInitView()
	return
end

function TowerGiftFullView:onUpdateParam()
	return
end

function TowerGiftFullView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)

	if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Tower) then
		TowerRpc.instance:sendGetTowerInfoRequest()
		TowerComposeRpc.instance:sendTowerComposeGetInfoRequest()
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Tower
		})
	end

	local parentGO = self.viewParam.parent

	self._actId = self.viewParam.actId

	gohelper.addChild(parentGO, self.viewGO)
	Activity101Rpc.instance:sendGet101InfosRequest(self._actId)
	self:refreshUI()
end

function TowerGiftFullView:refreshUI()
	local isopen = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Tower)
	local actRewardTaskMO

	if isopen then
		actRewardTaskMO = TowerTaskModel.instance:getActRewardTask()
	end

	local hadInfo = actRewardTaskMO and next(actRewardTaskMO)

	if isopen then
		if not hadInfo then
			gohelper.setActive(self._golock, true)
			gohelper.setActive(self._gogoto, false)
		else
			gohelper.setActive(self._golock, false)
			gohelper.setActive(self._gogoto, true)
		end
	else
		gohelper.setActive(self._golock, true)
		gohelper.setActive(self._gogoto, false)
	end

	if actRewardTaskMO then
		local hasget = actRewardTaskMO:isClaimed()

		gohelper.setActive(self._gotaskreceive, hasget)
		gohelper.setActive(self._gogoto, not hasget)

		if hasget then
			self._txtprogress.text = luaLang("p_v2a7_tower_fullview_txt_finished")
		end

		gohelper.setActive(self._txtprogress.gameObject, true)

		self._txtprogress.text = string.format("<#ec5d5d>%s</color>/%s", actRewardTaskMO.progress, actRewardTaskMO.config.maxProgress)
	end

	local received = self:checkReceied()
	local canget = self:checkCanGet()

	gohelper.setActive(self._gocanget, canget)
	gohelper.setActive(self._goreceive, received)

	self._txttime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function TowerGiftFullView:checkReceied()
	return (ActivityType101Model.instance:isType101RewardGet(self._actId, 1))
end

function TowerGiftFullView:checkCanGet()
	return (ActivityType101Model.instance:isType101RewardCouldGet(self._actId, 1))
end

function TowerGiftFullView:checkBgm(viewName)
	if viewName == ViewName.TowerMainView then
		if self._bgmId and self._bgmId ~= -1 then
			local bgmSwitchCO = BGMSwitchConfig.instance:getBGMSwitchCO(self._bgmId)
			local audioId = bgmSwitchCO and bgmSwitchCO.audio

			AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Main, audioId)
		else
			local usedBgmId = BGMSwitchModel.instance:getUsedBgmIdFromServer()

			if BGMSwitchModel.instance:isRandomBgmId(usedBgmId) then
				usedBgmId = BGMSwitchModel.instance:nextBgm(1, true)
			end

			local bgmSwitchCO = BGMSwitchConfig.instance:getBGMSwitchCO(usedBgmId)

			if bgmSwitchCO then
				if not bgmSwitchCO.audio then
					local audioId = AudioEnum.UI.Play_Replay_Music_Daytime

					AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Main, audioId)
				end
			end
		end
	end
end

function TowerGiftFullView:onClose()
	return
end

function TowerGiftFullView:onDestroyView()
	return
end

return TowerGiftFullView
