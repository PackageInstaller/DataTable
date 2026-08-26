-- chunkname: @modules/logic/turnback/view/TurnbackPopupRewardView.lua

module("modules.logic.turnback.view.TurnbackPopupRewardView", package.seeall)

local TurnbackPopupRewardView = class("TurnbackPopupRewardView", BaseViewExtended)

function TurnbackPopupRewardView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagebgicon = gohelper.findChildSingleImage(self.viewGO, "#simage_bg/#simage_bgicon")
	self._simagerolebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg/#simage_rolebg")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#simage_bg/#simage_line")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "reward/#scroll_reward")
	self._gorewardcontent = gohelper.findChild(self.viewGO, "reward/#scroll_reward/Viewport/#go_rewardcontent")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "reward/#btn_reward")
	self._gocanget = gohelper.findChild(self.viewGO, "reward/#btn_reward/#go_canget")
	self._gohasget = gohelper.findChild(self.viewGO, "reward/#btn_reward/#go_hasget")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_jump")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "#txt_remainTime")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gosubmoduleContent = gohelper.findChild(self.viewGO, "#go_submoduleContent")
	self._gosubmoduleItem = gohelper.findChild(self.viewGO, "#go_submoduleContent/#go_submoduleItem")
	self._txtTitle = gohelper.findChildText(self.viewGO, "mask/#txt_title")
	self._subModuleContentLayout = self._gosubmoduleContent:GetComponentInChildren(gohelper.Type_GridLayoutGroup)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnbackPopupRewardView:addEvents()
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshOnceBonusGetState, self.refreshOnceBonusGetState, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshRemainTime, self.refreshTime, self)
end

function TurnbackPopupRewardView:removeEvents()
	self._btnreward:RemoveClickListener()
	self._btnjump:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshOnceBonusGetState, self.refreshOnceBonusGetState, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshRemainTime, self.refreshTime, self)
end

function TurnbackPopupRewardView:_btnrewardOnClick()
	if TurnbackModel.instance:isInOpenTime() then
		if not self.hasGet then
			TurnbackRpc.instance:sendTurnbackOnceBonusRequest(self.turnbackId)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_task_slide)
		end
	else
		ViewMgr.instance:closeView(ViewName.TurnbackPopupBeginnerView)
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)
	end
end

function TurnbackPopupRewardView:_btnjumpOnClick()
	if TurnbackModel.instance:isInOpenTime() then
		local config = TurnbackConfig.instance:getTurnbackCo(self.turnbackId)

		if config.jumpId ~= 0 then
			GameFacade.jump(config.jumpId)
		end
	else
		ViewMgr.instance:closeView(ViewName.TurnbackPopupBeginnerView)
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)
	end
end

function TurnbackPopupRewardView:_btncloseOnClick()
	if self._param and self._param.closeCallback then
		self._param.closeCallback(self._param.callbackObject)
	end
end

function TurnbackPopupRewardView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getTurnbackIcon("turnback_windowbg"))
	self._simagebgicon:LoadImage(ResUrl.getTurnbackIcon("turnback_windowbg2"))
	self._simagerolebg:LoadImage(ResUrl.getTurnbackIcon("turnback_windowrolebg"))
	self._simageline:LoadImage(ResUrl.getTurnbackIcon("turnback_windowlinebg"))
	gohelper.setActive(self._gosubmoduleItem, false)

	self.subModuleItemTab = self:getUserDataTb_()
end

function TurnbackPopupRewardView:onUpdateParam()
	return
end

function TurnbackPopupRewardView:onRefreshViewParam(param)
	self._param = param
end

function TurnbackPopupRewardView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_feedback_open)

	self.turnbackId = TurnbackModel.instance:getCurTurnbackId()

	self:createReward()
	self:createSubModuleItem()
	self:refreshTime()
	self:refreshOnceBonusGetState()
end

function TurnbackPopupRewardView:createReward()
	local config = TurnbackConfig.instance:getTurnbackCo(self.turnbackId)
	local rewards = string.split(config.onceBonus, "|")

	for i = 1, #rewards do
		local itemCo = string.split(rewards[i], "#")
		local rewardItem = IconMgr.instance:getCommonPropItemIcon(self._gorewardcontent)

		rewardItem:setMOValue(itemCo[1], itemCo[2], itemCo[3], nil, true)
		rewardItem:setPropItemScale(0.75)
		rewardItem:setCountFontSize(36)
		rewardItem:setHideLvAndBreakFlag(true)
		rewardItem:hideEquipLvAndBreak(true)
		gohelper.setActive(rewardItem.go, true)
	end
end

function TurnbackPopupRewardView:createSubModuleItem()
	local subModules = TurnbackConfig.instance:getAllTurnbackSubModules(self.turnbackId)
	local showInPopupCount = 0

	for i = 1, #subModules do
		local subModuleCo = TurnbackConfig.instance:getTurnbackSubModuleCo(subModules[i])

		if subModuleCo.showInPopup == TurnbackEnum.showInPopup.Show then
			local item = {}

			item.go = gohelper.clone(self._gosubmoduleItem, self._gosubmoduleContent, "subModule" .. subModules[i])
			item.name = gohelper.findChildText(item.go, "txt_name")
			item.point1 = gohelper.findChild(item.go, "point/go_point1")
			item.point2 = gohelper.findChild(item.go, "point/go_point2")
			item.name.text = subModuleCo.name

			table.insert(self.subModuleItemTab, item)
			gohelper.setActive(item.go, true)

			showInPopupCount = showInPopupCount + 1
		else
			self._txtTitle.text = subModuleCo.name
		end
	end

	self:setSubModuleItemContent(showInPopupCount)
end

function TurnbackPopupRewardView:setSubModuleItemContent(showInPopupCount)
	if showInPopupCount > 3 then
		self._subModuleContentLayout.startAxis = UnityEngine.UI.GridLayoutGroup.Axis.Horizontal or UnityEngine.UI.GridLayoutGroup.Axis.Vertical
	end

	for i = 1, #self.subModuleItemTab do
		if showInPopupCount > 3 then
			gohelper.setActive(self.subModuleItemTab[i].point1, (i - 1) % 4 < 2)
			gohelper.setActive(self.subModuleItemTab[i].point2, (i - 1) % 4 >= 2)
		else
			gohelper.setActive(self.subModuleItemTab[i].point1, i % 2 ~= 0)
			gohelper.setActive(self.subModuleItemTab[i].point2, i % 2 == 0)
		end
	end
end

function TurnbackPopupRewardView:refreshOnceBonusGetState()
	self.hasGet = TurnbackModel.instance:getOnceBonusGetState()

	gohelper.setActive(self._gocanget, not self.hasGet)
	gohelper.setActive(self._gohasget, self.hasGet)
end

function TurnbackPopupRewardView:refreshTime()
	self._txtremaintime.text = TurnbackController.instance:refreshRemainTime()
end

function TurnbackPopupRewardView:onClose()
	self._simagebg:UnLoadImage()
	self._simagebgicon:UnLoadImage()
	self._simagerolebg:UnLoadImage()
	self._simageline:UnLoadImage()
end

function TurnbackPopupRewardView:onDestroyView()
	return
end

return TurnbackPopupRewardView
