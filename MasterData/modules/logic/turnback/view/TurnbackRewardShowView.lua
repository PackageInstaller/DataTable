-- chunkname: @modules/logic/turnback/view/TurnbackRewardShowView.lua

module("modules.logic.turnback.view.TurnbackRewardShowView", package.seeall)

local TurnbackRewardShowView = class("TurnbackRewardShowView", BaseView)

function TurnbackRewardShowView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txttime = gohelper.findChildText(self.viewGO, "timebg/#txt_time")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "#scroll_reward")
	self._gorewardContent = gohelper.findChild(self.viewGO, "#scroll_reward/Viewport/#go_rewardContent")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reward")
	self._gocanget = gohelper.findChild(self.viewGO, "#btn_reward/#go_canget")
	self._gohasget = gohelper.findChild(self.viewGO, "#btn_reward/#go_hasget")
	self._btnstory = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_story")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnbackRewardShowView:addEvents()
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btnstory:AddClickListener(self._btnstoryOnClick, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshOnceBonusGetState, self._refreshOnceBonusGetState, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshRemainTime, self._refreshRemainTime, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self._refreshUI, self)
end

function TurnbackRewardShowView:removeEvents()
	self._btnreward:RemoveClickListener()
	self._btnstory:RemoveClickListener()
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshOnceBonusGetState, self._refreshOnceBonusGetState, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshRemainTime, self._refreshRemainTime, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self._refreshUI, self)
end

function TurnbackRewardShowView:_btnrewardOnClick()
	if not self.hasGet then
		TurnbackRpc.instance:sendTurnbackOnceBonusRequest(self.turnbackId)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_task_slide)
	end
end

function TurnbackRewardShowView:_btnstoryOnClick()
	local TurnbackMo = TurnbackModel.instance:getCurTurnbackMo()

	if TurnbackMo then
		::label_5_0::

		local var_5_0 = TurnbackMo.config

		if TurnbackMo.config then
			local storyId = TurnbackMo.config.startStory

			if storyId then
				StoryController.instance:playStory(storyId)
			else
				logError(string.format("TurnbackRewardShowView startStoryId is nil", storyId))
			end
		end
	end
end

function TurnbackRewardShowView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getTurnbackIcon("turnback_rewardfullbg"))
end

function TurnbackRewardShowView:onUpdateParam()
	return
end

function TurnbackRewardShowView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self.turnbackId = TurnbackModel.instance:getCurTurnbackId()

	self:_createReward()
	self:_refreshUI()
	self:_refreshOnceBonusGetState()
end

function TurnbackRewardShowView:_refreshUI()
	self.config = TurnbackConfig.instance:getTurnbackSubModuleCo(self.viewParam.actId)
	self._txtdesc.text = self.config.actDesc

	self:_refreshRemainTime()
	gohelper.setActive(self._btnstory, true)
end

function TurnbackRewardShowView:_refreshRemainTime()
	self._txttime.text = TurnbackController.instance:refreshRemainTime()
end

function TurnbackRewardShowView:_createReward()
	local config = TurnbackConfig.instance:getTurnbackCo(self.turnbackId)
	local rewards = string.split(config.onceBonus, "|")

	for i = 1, #rewards do
		local itemCo = string.split(rewards[i], "#")
		local rewardItem = IconMgr.instance:getCommonPropItemIcon(self._gorewardContent)

		rewardItem:setMOValue(itemCo[1], itemCo[2], itemCo[3], nil, true)
		rewardItem:setPropItemScale(0.9)
		rewardItem:setCountFontSize(36)
		rewardItem:setHideLvAndBreakFlag(true)
		rewardItem:hideEquipLvAndBreak(true)
		gohelper.setActive(rewardItem.go, true)
	end
end

function TurnbackRewardShowView:_refreshOnceBonusGetState()
	self.hasGet = TurnbackModel.instance:getOnceBonusGetState()

	gohelper.setActive(self._gocanget, not self.hasGet)
	gohelper.setActive(self._gohasget, self.hasGet)
end

function TurnbackRewardShowView:onClose()
	self._simagebg:UnLoadImage()
end

function TurnbackRewardShowView:onDestroyView()
	return
end

return TurnbackRewardShowView
