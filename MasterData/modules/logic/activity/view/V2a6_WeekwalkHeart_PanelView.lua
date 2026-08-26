-- chunkname: @modules/logic/activity/view/V2a6_WeekwalkHeart_PanelView.lua

module("modules.logic.activity.view.V2a6_WeekwalkHeart_PanelView", package.seeall)

local V2a6_WeekwalkHeart_PanelView = class("V2a6_WeekwalkHeart_PanelView", Activity189BaseView)

V2a6_WeekwalkHeart_PanelView.SigninId = 530007
V2a6_WeekwalkHeart_PanelView.ConstItemId = 1261301

function V2a6_WeekwalkHeart_PanelView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Left/reward/btn_reward")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/rightbg/reward/btn")
	self._goreceive = gohelper.findChild(self.viewGO, "Root/Left/go_receive")
	self._gohasget = gohelper.findChild(self.viewGO, "Root/Left/go_receive/go_hasget")
	self._animGet = self._gohasget:GetComponent(typeof(UnityEngine.Animator))
	self._gocanget = gohelper.findChild(self.viewGO, "Root/Left/go_canget")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/Top/#txt_LimitTime")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Top/#btn_close")
	self._btngoto = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/#btn_goto")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a6_WeekwalkHeart_PanelView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function V2a6_WeekwalkHeart_PanelView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btngoto:RemoveClickListener()
	self._btnreward:RemoveClickListener()
	self._btnright:RemoveClickListener()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function V2a6_WeekwalkHeart_PanelView:_btncloseOnClick()
	self:closeThis()
end

function V2a6_WeekwalkHeart_PanelView:_btngotoOnClick()
	ActivityModel.instance:setTargetActivityCategoryId(self:actId())
	ActivityController.instance:openActivityBeginnerView()
end

function V2a6_WeekwalkHeart_PanelView:_btnrewardOnClick()
	if self.rewardMo.hasFinished and self.rewardMo.finishCount <= 0 then
		TaskRpc.instance:sendFinishTaskRequest(V2a6_WeekwalkHeart_PanelView.SigninId)
	end
end

function V2a6_WeekwalkHeart_PanelView:_btnrightOnClick()
	MaterialTipController.instance:showMaterialInfo(self._itemCo[1], self._itemCo[2])
end

function V2a6_WeekwalkHeart_PanelView:_editableInitView()
	self:_initTip()
end

function V2a6_WeekwalkHeart_PanelView:_initTip()
	local item = self:getUserDataTb_()

	item.go = gohelper.findChild(self.viewGO, "Root/Left")
	item.isLike = false
	item.isUnLike = false
	item.golike = gohelper.findChild(item.go, "like")
	item.txtlike = gohelper.findChildText(item.golike, "num")
	item.likenum = math.random(50, 99)
	item.txtlike.text = item.likenum
	item.govxlike = gohelper.findChild(item.golike, "vx_like")
	item.golikeSelect = gohelper.findChild(item.golike, "go_selected")
	item.btnlikeclick = gohelper.findChildButton(item.golike, "#btn_click")

	local function likefunc()
		if not item.isUnLike then
			item.likenum = item.isLike and item.likenum - 1 or item.likenum + 1
			item.isLike = not item.isLike
		end

		gohelper.setActive(item.govxlike, item.isLike)
		gohelper.setActive(item.golikeSelect, item.isLike)

		item.txtlike.text = item.likenum

		AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_nameplate_switch)
	end

	item.btnlikeclick:AddClickListener(likefunc, self, item)

	item.gounlike = gohelper.findChild(item.go, "unlike")
	item.txtunlike = gohelper.findChildText(item.gounlike, "num")
	item.unlikenum = math.random(50, 99)
	item.txtunlike.text = item.unlikenum
	item.govxunlike = gohelper.findChild(item.gounlike, "vx_unlike")
	item.gounlikeSelect = gohelper.findChild(item.gounlike, "go_selected")
	item.btnunlikeclick = gohelper.findChildButton(item.gounlike, "#btn_click")

	local function unlikefunc()
		if not item.isLike then
			item.unlikenum = item.isUnLike and item.unlikenum - 1 or item.unlikenum + 1
			item.isUnLike = not item.isUnLike
		end

		gohelper.setActive(item.govxunlike, item.isUnLike)
		gohelper.setActive(item.gounlikeSelect, item.isUnLike)

		item.txtunlike.text = item.unlikenum

		AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_nameplate_switch)
	end

	item.btnunlikeclick:AddClickListener(unlikefunc, self, item)
	gohelper.setActive(item.govxlike, item.isLike)
	gohelper.setActive(item.golikeSelect, item.isLike)
	gohelper.setActive(item.govxunlike, item.isUnLike)
	gohelper.setActive(item.gounlikeSelect, item.isUnLike)

	self._rewardItem = item
end

function V2a6_WeekwalkHeart_PanelView:onUpdateParam()
	return
end

function V2a6_WeekwalkHeart_PanelView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		self:_refresh()
		self._animGet:Play("open")
	end
end

function V2a6_WeekwalkHeart_PanelView:_refresh()
	self._txtLimitTime.text = self:getRemainTimeStr()

	local moList = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity189, self:actId())

	if moList and #moList > 0 then
		for index, rewardmo in ipairs(moList) do
			if rewardmo.id == V2a6_WeekwalkHeart_PanelView.SigninId then
				self.rewardMo = rewardmo

				break
			end
		end
	end

	if self.rewardMo.finishCount > 0 then
		gohelper.setActive(self._gocanget, false)
		gohelper.setActive(self._goreceive, true)
		gohelper.setActive(self._btnreward.gameObject, false)
	elseif self.rewardMo.hasFinished then
		gohelper.setActive(self._gocanget, true)
		gohelper.setActive(self._goreceive, false)
		gohelper.setActive(self._btnreward.gameObject, true)
	else
		gohelper.setActive(self._gocanget, false)
		gohelper.setActive(self._goreceive, false)
		gohelper.setActive(self._btnreward.gameObject, false)
	end
end

function V2a6_WeekwalkHeart_PanelView:onOpen()
	local constValue = Activity189Config.instance:getConstCoById(V2a6_WeekwalkHeart_PanelView.ConstItemId)

	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_Interface_entry_04)

	self._itemCo = string.split(constValue.numValue, "#")

	self:_refresh()
end

function V2a6_WeekwalkHeart_PanelView:onClose()
	self._rewardItem.btnlikeclick:RemoveClickListener()
	self._rewardItem.btnunlikeclick:RemoveClickListener()
end

function V2a6_WeekwalkHeart_PanelView:onDestroyView()
	return
end

return V2a6_WeekwalkHeart_PanelView
