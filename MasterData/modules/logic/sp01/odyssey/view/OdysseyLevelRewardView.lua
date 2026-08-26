-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyLevelRewardView.lua

module("modules.logic.sp01.odyssey.view.OdysseyLevelRewardView", package.seeall)

local OdysseyLevelRewardView = class("OdysseyLevelRewardView", BaseView)

function OdysseyLevelRewardView:onInitView()
	self._scrollRewardList = gohelper.findChildScrollRect(self.viewGO, "root/Reward/#scroll_RewardList")
	self._goContent = gohelper.findChild(self.viewGO, "root/Reward/#scroll_RewardList/Viewport/#go_Content")
	self._gorewarditem = gohelper.findChild(self.viewGO, "root/Reward/#scroll_RewardList/Viewport/#go_Content/#go_rewarditem")
	self._txtlevel = gohelper.findChildText(self.viewGO, "root/Level/image_level/#txt_level")
	self._imageexpProgress = gohelper.findChildImage(self.viewGO, "root/Level/image_level/#image_expProgress")
	self._txtexp = gohelper.findChildText(self.viewGO, "root/Level/image_exp/#txt_exp")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyLevelRewardView:addEvents()
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.OdysseyTaskUpdated, self.refreshUI, self)
end

function OdysseyLevelRewardView:removeEvents()
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.OdysseyTaskUpdated, self.refreshUI, self)
end

function OdysseyLevelRewardView:_editableInitView()
	gohelper.setActive(self._gorewarditem, false)
end

function OdysseyLevelRewardView:onUpdateParam()
	return
end

function OdysseyLevelRewardView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_award)
	self:refreshUI()
	self:setScrollMove()
end

function OdysseyLevelRewardView:refreshUI()
	self.curLevel, self.curExp = OdysseyModel.instance:getHeroCurLevelAndExp()

	local curLevelConfig = OdysseyConfig.instance:getLevelConfig(self.curLevel)

	self._txtlevel.text = self.curLevel

	if curLevelConfig and curLevelConfig.needExp > 0 then
		self._imageexpProgress.fillAmount = self.curExp / curLevelConfig.needExp or 1
	end

	self._txtexp.text = curLevelConfig and curLevelConfig.needExp > 0 and string.format("XP: <#ffac54>%s</color>/%s", self.curExp, curLevelConfig.needExp) or "XP: MAX"
end

OdysseyLevelRewardView.rewardItemWidth = 384
OdysseyLevelRewardView.rewardItemSpace = 42
OdysseyLevelRewardView.leftOffset = 18

function OdysseyLevelRewardView:setScrollMove()
	local scrollWidth = recthelper.getWidth(self._scrollRewardList.gameObject.transform)
	local itemWidth = OdysseyLevelRewardView.rewardItemWidth + OdysseyLevelRewardView.rewardItemSpace

	self.taskList = OdysseyTaskModel.instance:getCurTaskList(OdysseyEnum.TaskType.LevelReward)

	if #self.taskList == 0 then
		recthelper.setAnchorX(self._goContent.transform, 0)

		return
	end

	local scrollMaxMoveX = #self.taskList * itemWidth - OdysseyLevelRewardView.rewardItemSpace + OdysseyLevelRewardView.leftOffset - scrollWidth
	local allCanGetList = OdysseyTaskModel.instance:getAllCanGetMoList(OdysseyEnum.TaskType.LevelReward)

	if #allCanGetList > 0 then
		local firstCanGetMo = allCanGetList[1]
		local firstCanGetLevel = firstCanGetMo.config.maxProgress

		recthelper.setAnchorX(self._goContent.transform, Mathf.Max(-Mathf.Max(firstCanGetLevel - 3, 0) * itemWidth), -scrollMaxMoveX)
	else
		recthelper.setAnchorX(self._goContent.transform, Mathf.Max(-Mathf.Max(self.curLevel - 2, 0) * itemWidth), -scrollMaxMoveX)
	end
end

function OdysseyLevelRewardView:onClose()
	return
end

function OdysseyLevelRewardView:onDestroyView()
	return
end

return OdysseyLevelRewardView
