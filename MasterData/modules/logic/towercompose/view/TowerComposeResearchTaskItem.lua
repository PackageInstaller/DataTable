-- chunkname: @modules/logic/towercompose/view/TowerComposeResearchTaskItem.lua

module("modules.logic.towercompose.view.TowerComposeResearchTaskItem", package.seeall)

local TowerComposeResearchTaskItem = class("TowerComposeResearchTaskItem", ListScrollCellExtend)

function TowerComposeResearchTaskItem:onInitView()
	self._gonormalbg = gohelper.findChild(self.viewGO, "bg/#go_normalbg")
	self._goisgetbg = gohelper.findChild(self.viewGO, "bg/#go_isgetbg")
	self._gocangetbg = gohelper.findChild(self.viewGO, "bg/#go_cangetbg")
	self._txttaskdesc = gohelper.findChildText(self.viewGO, "#txt_taskdesc")
	self._imageicon = gohelper.findChildImage(self.viewGO, "reward/#image_icon")
	self._txtnum = gohelper.findChildText(self.viewGO, "reward/#txt_num")
	self._btnnormal = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_normal")
	self._btncanget = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_canget")
	self._gohasget = gohelper.findChild(self.viewGO, "#go_hasget")
	self._btnlock = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_lock")
	self._btndesc = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeResearchTaskItem:addEvents()
	self._btnnormal:AddClickListener(self._btnnormalOnClick, self)
	self._btncanget:AddClickListener(self._btncangetOnClick, self)
	self._btnlock:AddClickListener(self._btnlockOnClick, self)
	self._btndesc:AddClickListener(self._btndescOnClick, self)
	TowerComposeController.instance:registerCallback(TowerComposeEvent.OnResearchTaskRewardGetFinish, self.playFinishAnim, self)
end

function TowerComposeResearchTaskItem:removeEvents()
	self._btnnormal:RemoveClickListener()
	self._btncanget:RemoveClickListener()
	self._btnlock:RemoveClickListener()
	self._btndesc:RemoveClickListener()
	TowerComposeController.instance:unregisterCallback(TowerComposeEvent.OnResearchTaskRewardGetFinish, self.playFinishAnim, self)
end

TowerComposeResearchTaskItem.BlockKey = "TowerComposeResearchTaskItemRewardGetAnim"
TowerComposeResearchTaskItem.TaskMaskTime = 0.65

function TowerComposeResearchTaskItem:_btnnormalOnClick()
	if not self.isUnlock then
		return
	end

	if self.config.jumpId == 0 and self.config.taskType == TowerComposeEnum.TaskType.Research and not string.nilorempty(self.config.params) then
		local paramInfo = string.split(self.config.params, "|")
		local themeId = tonumber(paramInfo[1])
		local modList = string.splitToNumber(paramInfo[2], "#")
		local lockModConfig = TowerComposeModel.instance:checkHasModsLock(themeId, modList)

		if lockModConfig then
			GameFacade.showToast(ToastEnum.TowerComposeModLock, lockModConfig.name)

			return
		end

		local curNotLockPlane = TowerComposeModel.instance:getCurLockPlaneId(themeId, true)

		if curNotLockPlane == 0 then
			GameFacade.showOptionMessageBox(MessageBoxIdDefine.TowerComposeResearchJumpAllPlaneLock, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, self.dropAndReplaceModCallBack, nil, nil, self)
		else
			GameFacade.showOptionMessageBox(MessageBoxIdDefine.TowerComposeResearchJumpPlane, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, self.dropAndReplaceModCallBack, nil, nil, self, nil, nil, luaLang("towercompose_plane" .. curNotLockPlane))
		end
	end
end

function TowerComposeResearchTaskItem:dropAndReplaceModCallBack()
	local jumpSucc = TowerComposeController.instance:jumpToModEquipView(self.config)

	if jumpSucc then
		ViewMgr.instance:closeView(ViewName.TowerComposeResearchView)
	end
end

function TowerComposeResearchTaskItem:_btnlockOnClick()
	if not self.lockModId then
		return
	end

	local modConfig = TowerComposeConfig.instance:getComposeModConfig(self.lockModId)

	GameFacade.showToast(ToastEnum.TowerComposeModLock, modConfig.name)
end

function TowerComposeResearchTaskItem:_btncangetOnClick()
	if not self.taskId then
		return
	end

	UIBlockMgr.instance:startBlock(TowerComposeResearchTaskItem.BlockKey)

	local removeIndexList = TowerComposeTaskModel.instance:getAllCanGetIndexList()

	TowerComposeController.instance:dispatchEvent(TowerComposeEvent.OnResearchTaskRewardGetFinish, removeIndexList)
	TowerComposeController.instance:dispatchEvent(TowerComposeEvent.PlayResearchItemFlyAnim, self._btncanget)
	TaskDispatcher.runDelay(self._onPlayActAniFinished, self, TowerComposeResearchTaskItem.TaskMaskTime)
end

function TowerComposeResearchTaskItem:_btngetallOnClick()
	self:_btncangetOnClick()
end

function TowerComposeResearchTaskItem:_btndescOnClick()
	if string.nilorempty(self.config.params) then
		return
	end

	local paramInfo = string.split(self.config.params, "|")
	local modList = string.splitToNumber(paramInfo[2], "#") or {}

	if #modList > 0 then
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.ShowModDescTip, modList)
	end
end

function TowerComposeResearchTaskItem:_onPlayActAniFinished()
	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)

	local canGetIdList = TowerComposeTaskModel.instance:getAllCanGetList()

	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.TowerCompose, 0, canGetIdList, nil, nil, 0)
	UIBlockMgr.instance:endBlock(TowerComposeResearchTaskItem.BlockKey)
end

function TowerComposeResearchTaskItem:playFinishAnim(removeIndexList)
	local isFinishIndex = tabletool.indexOf(removeIndexList, self._index)

	if isFinishIndex then
		self._animator:Play(UIAnimationName.Finish)
	end
end

function TowerComposeResearchTaskItem:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function TowerComposeResearchTaskItem:onUpdateMO(mo)
	if mo == nil then
		return
	end

	self.mo = mo

	self:refreshNormal()
end

function TowerComposeResearchTaskItem:refreshNormal()
	self.taskId = self.mo.id
	self.config = self.mo.config
	self.jumpId = self.config.jumpId
	self._txttaskdesc.text = TowerComposeController.instance:setModDescColor(self.config.desc, true, "#D2C197")

	self:refreshReward()
	self:refreshState()
end

function TowerComposeResearchTaskItem:replaceDesc()
	return
end

function TowerComposeResearchTaskItem:refreshReward()
	local config = self.mo.config
	local pointInfoList = string.splitToNumber(config.pointBonus, "#")
	local themeId = pointInfoList[1]
	local pointNum = pointInfoList[2]

	self._txtnum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), pointNum)

	local themeConfig = TowerComposeConfig.instance:getThemeConfig(themeId)
end

function TowerComposeResearchTaskItem:refreshState()
	local isGet = TowerComposeTaskModel.instance:isTaskFinished(self.mo)
	local canGet = self.mo.hasFinished

	self.isUnlock, self.lockModId = TowerComposeTaskModel.checkHaveBodyMod(self.mo.config)

	gohelper.setActive(self._gonormalbg, not isGet and not canGet)
	gohelper.setActive(self._btnnormal, not isGet and not canGet and self.isUnlock)
	gohelper.setActive(self._goisgetbg, isGet and self.isUnlock)
	gohelper.setActive(self._gohasget, isGet and self.isUnlock)
	gohelper.setActive(self._gocangetbg, canGet and self.isUnlock)
	gohelper.setActive(self._btncanget, canGet and self.isUnlock)
	gohelper.setActive(self._btnlock, not self.isUnlock)
	ZProj.UGUIHelper.SetColorAlpha(self._txttaskdesc, isGet and self.isUnlock and 0.5 or 1)
	ZProj.UGUIHelper.SetColorAlpha(self._txtnum, isGet and self.isUnlock and 0.5 or 1)
end

function TowerComposeResearchTaskItem:getAnimator()
	return self._animator
end

function TowerComposeResearchTaskItem:onDestroyView()
	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)
end

return TowerComposeResearchTaskItem
