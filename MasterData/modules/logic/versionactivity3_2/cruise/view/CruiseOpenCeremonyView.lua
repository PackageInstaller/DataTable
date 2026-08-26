-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseOpenCeremonyView.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseOpenCeremonyView", package.seeall)

local CruiseOpenCeremonyView = class("CruiseOpenCeremonyView", BaseView)

function CruiseOpenCeremonyView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_bg")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "root/#simage_Title")
	self._txttime = gohelper.findChildText(self.viewGO, "root/LimitTime/image_LimitTimeBG/#txt_time")
	self._goreward1 = gohelper.findChild(self.viewGO, "root/#go_reward1")
	self._goreward2 = gohelper.findChild(self.viewGO, "root/#go_reward2")
	self._goitem = gohelper.findChild(self.viewGO, "root/#go_item")
	self._imagequality = gohelper.findChildImage(self.viewGO, "root/#go_item/#image_quality")
	self._imagecircle = gohelper.findChildImage(self.viewGO, "root/#go_item/#image_circle")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/#go_item/#txt_num")
	self._gobtns = gohelper.findChild(self.viewGO, "root/#go_btns")
	self._btnget = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_btns/#btn_get")
	self._gohasget = gohelper.findChild(self.viewGO, "root/#go_btns/#go_hasget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CruiseOpenCeremonyView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnget:AddClickListener(self._btngetOnClick, self)
end

function CruiseOpenCeremonyView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnget:RemoveClickListener()
end

function CruiseOpenCeremonyView:_addSelfEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
end

function CruiseOpenCeremonyView:_removeSelfEvents()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onCheckActState, self)
end

function CruiseOpenCeremonyView:_onCheckActState()
	local actId = VersionActivity3_2Enum.ActivityId.CruiseOpenCeremony
	local status = ActivityHelper.getActivityStatus(actId)

	if status == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

function CruiseOpenCeremonyView:_btncloseOnClick()
	self:closeThis()
end

function CruiseOpenCeremonyView:_btngetOnClick()
	if not self._canget then
		return
	end

	Activity101Rpc.instance:sendGet101BonusRequest(self._actId, 1)
end

function CruiseOpenCeremonyView:_editableInitView()
	self._txttime.text = ""
	self._actId = VersionActivity3_2Enum.ActivityId.CruiseOpenCeremony
	self._baseRewardItems = self:getUserDataTb_()
	self._taskRewardItems = self:getUserDataTb_()
	self._gobaserewardicons = self:getUserDataTb_()

	for i = 1, 2 do
		local go = gohelper.findChild(self._goreward1, "go_icon" .. tostring(i))

		table.insert(self._gobaserewardicons, go)
	end

	self._gotaskrewardicons = self:getUserDataTb_()

	for i = 1, 4 do
		local go = gohelper.findChild(self._goreward2, "go_icon" .. tostring(i))

		table.insert(self._gotaskrewardicons, go)
	end

	self:_addSelfEvents()
end

function CruiseOpenCeremonyView:onUpdateParam()
	return
end

function CruiseOpenCeremonyView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_2.Cruise.play_ui_shengyan_box_xunyou_open)
	NavigateMgr.instance:addEscape(ViewName.CruiseOpenCeremonyView, self._btncloseOnClick, self)
	self:_refreshTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
	self:_refresh()
end

function CruiseOpenCeremonyView:_refreshTimeTick()
	self._txttime.text = ActivityModel.getRemainTimeStr(self._actId)
end

function CruiseOpenCeremonyView:_refresh()
	self._canget = CruiseModel.instance:isCeremonyHasReward()

	self:_refreshUI()
	self:_refreshBaseRewards()
	self:_refreshGlobalTaskRewards()
end

function CruiseOpenCeremonyView:_refreshUI()
	gohelper.setActive(self._btnget.gameObject, self._canget)
	gohelper.setActive(self._gohasget, not self._canget)
end

function CruiseOpenCeremonyView:_refreshBaseRewards()
	local rewardStr = CommonConfig.instance:getConstStr(ConstEnum.CruiseBaseReward)
	local rewards = string.split(rewardStr, "|")

	for i = 1, #rewards do
		if not self._baseRewardItems[i] then
			self._baseRewardItems[i] = self:getUserDataTb_()

			local go = gohelper.clone(self._goitem, self._gobaserewardicons[i])

			gohelper.setActive(go, true)

			self._baseRewardItems[i].go = go
			self._baseRewardItems[i].imagequality = gohelper.findChildImage(go, "#image_quality")
			self._baseRewardItems[i].goicon = gohelper.findChild(go, "go_icon")
			self._baseRewardItems[i].item = IconMgr.instance:getCommonPropItemIcon(self._baseRewardItems[i].goicon)
			self._baseRewardItems[i].gocanget = gohelper.findChild(go, "go_canget")
			self._baseRewardItems[i].goreceive = gohelper.findChild(go, "go_receive")
			self._baseRewardItems[i].txtnum = gohelper.findChildText(go, "#txt_num")
			self._baseRewardItems[i].btnclick = gohelper.findChildButtonWithAudio(go, "btn_click")

			self._baseRewardItems[i].btnclick:AddClickListener(self._btngetOnClick, self)
		end

		local rewardCo = string.splitToNumber(rewards[i], "#")

		self._baseRewardItems[i].item:setMOValue(rewardCo[1], rewardCo[2], rewardCo[3])
		self._baseRewardItems[i].item:isShowQuality(false)
		self._baseRewardItems[i].item:isShowEquipAndItemCount(false)

		local itemCO, _ = ItemModel.instance:getItemConfigAndIcon(rewardCo[1], rewardCo[2])

		if not itemCO.rare then
			UISpriteSetMgr.instance:setUiFBSprite(self._baseRewardItems[i].imagequality, "bg_pinjidi_" .. itemCO.rare)

			self._baseRewardItems[i].txtnum.text = rewardCo[3]

			gohelper.setActive(self._baseRewardItems[i].gocanget, self._canget)
			gohelper.setActive(self._baseRewardItems[i].goreceive, not self._canget)
			gohelper.setActive(self._baseRewardItems[i].btnclick.gameObject, self._canget)
		end
	end
end

function CruiseOpenCeremonyView:_refreshGlobalTaskRewards()
	local rewardStr = CommonConfig.instance:getConstStr(ConstEnum.CruiseGlobalTaskReward)
	local rewards = string.split(rewardStr, "|")

	for i = 1, #rewards do
		if not self._taskRewardItems[i] then
			self._taskRewardItems[i] = self:getUserDataTb_()

			local go = gohelper.clone(self._goitem, self._gotaskrewardicons[i])

			gohelper.setActive(go, true)

			self._taskRewardItems[i].go = go
			self._taskRewardItems[i].imagequality = gohelper.findChildImage(go, "#image_quality")
			self._taskRewardItems[i].goicon = gohelper.findChild(go, "go_icon")
			self._taskRewardItems[i].item = IconMgr.instance:getCommonPropItemIcon(self._taskRewardItems[i].goicon)
			self._taskRewardItems[i].gocanget = gohelper.findChild(go, "go_canget")
			self._taskRewardItems[i].goreceive = gohelper.findChild(go, "go_receive")
			self._taskRewardItems[i].txtnum = gohelper.findChildText(go, "#txt_num")
			self._taskRewardItems[i].btnclick = gohelper.findChildButtonWithAudio(go, "btn_click")

			self._taskRewardItems[i].btnclick:AddClickListener(self._btngetOnClick, self)
		end

		local itemCo = string.splitToNumber(rewards[i], "#")

		self._taskRewardItems[i].item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
		self._taskRewardItems[i].item:isShowQuality(false)
		self._taskRewardItems[i].item:isShowEquipAndItemCount(false)

		self._taskRewardItems[i].txtnum.text = itemCo[3]

		gohelper.setActive(self._taskRewardItems[i].gocanget, self._canget)
		gohelper.setActive(self._taskRewardItems[i].goreceive, not self._canget)
		gohelper.setActive(self._taskRewardItems[i].btnclick.gameObject, self._canget)
	end
end

function CruiseOpenCeremonyView:onClose()
	return
end

function CruiseOpenCeremonyView:onDestroyView()
	self:_removeSelfEvents()

	if self._baseRewardItems then
		for _, item in pairs(self._baseRewardItems) do
			item.btnclick:RemoveClickListener()
		end

		self._baseRewardItems = nil
	end

	if self._taskRewardItems then
		for _, item in pairs(self._taskRewardItems) do
			item.btnclick:RemoveClickListener()
		end

		self._taskRewardItems = nil
	end

	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

return CruiseOpenCeremonyView
