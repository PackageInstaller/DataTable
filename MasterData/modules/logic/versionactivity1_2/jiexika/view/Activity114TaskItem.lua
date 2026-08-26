-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114TaskItem.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114TaskItem", package.seeall)

local Activity114TaskItem = class("Activity114TaskItem", ListScrollCell)

function Activity114TaskItem:init(go)
	self.go = go
	self._simagebg = gohelper.findChildSingleImage(self.go, "#simage_bg")
	self._txtTaskDesc = gohelper.findChildText(self.go, "#txt_taskdes")
	self._txtTaskTotal = gohelper.findChildText(self.go, "#txt_total")
	self._txtTaskComplete = gohelper.findChildText(self.go, "#txt_complete")
	self._goNotFinish = gohelper.findChildButtonWithAudio(self.go, "#go_notget/#btn_notfinishbg")
	self._goGetBonus = gohelper.findChild(self.go, "#go_notget/#btn_finishbg")
	self._goFinishBg = gohelper.findChildButtonWithAudio(self.go, "#go_notget/#go_getbonus")
	self._scrollreward = gohelper.findChild(self.go, "scroll_reward"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._gorewards = gohelper.findChild(self.go, "scroll_reward/Viewport/#go_rewards")
	self._gorewarditem = gohelper.findChild(self.go, "scroll_reward/Viewport/#go_rewards/#go_rewarditem")

	self._simagebg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("task/bg_renwulan.png"))

	self._rewardItems = {}
	self._anim = self.go:GetComponent(typeof(UnityEngine.Animator))
end

function Activity114TaskItem:addEventListeners()
	self._goFinishBg:AddClickListener(self._goFinishBgOnClick, self)
end

function Activity114TaskItem:removeEventListeners()
	self._goFinishBg:RemoveClickListener()
end

function Activity114TaskItem:onUpdateMO(mo)
	self.mo = mo
	self._txtTaskDesc.text = self.mo.config.desc
	self._txtTaskTotal.text = self.mo.config.maxProgress
	self._txtTaskComplete.text = self.mo.progress

	gohelper.setActive(self._goNotFinish.gameObject, self.mo.finishStatus == Activity114Enum.TaskStatu.NoFinish)
	gohelper.setActive(self._goFinishBg.gameObject, self.mo.finishStatus == Activity114Enum.TaskStatu.Finish)
	gohelper.setActive(self._goGetBonus, self.mo.finishStatus == Activity114Enum.TaskStatu.GetBonus)

	self._scrollreward.parentGameObject = self._view._csListScroll.gameObject
	self.bonusItems = self.bonusItems or {}

	for _, v in pairs(self._rewardItems) do
		gohelper.destroy(v.itemIcon.go)
		gohelper.destroy(v.parentGo)
		v.itemIcon:onDestroy()
	end

	self._rewardItems = {}

	local rewards = string.split(mo.config.bonus, "|")

	self._gorewards:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #rewards > 2

	for i = 1, #rewards do
		local item = {}

		item.parentGo = gohelper.cloneInPlace(self._gorewarditem)

		gohelper.setActive(item.parentGo, true)

		local itemCo = string.splitToNumber(rewards[i], "#")

		item.itemIcon = IconMgr.instance:getCommonPropItemIcon(item.parentGo)

		item.itemIcon:setMOValue(itemCo[1], itemCo[2], itemCo[3], nil, true)
		item.itemIcon:isShowCount(itemCo[1] ~= MaterialEnum.MaterialType.Hero)
		item.itemIcon:setCountFontSize(40)
		item.itemIcon:showStackableNum2()
		item.itemIcon:setHideLvAndBreakFlag(true)
		item.itemIcon:hideEquipLvAndBreak(true)
		table.insert(self._rewardItems, item)
	end
end

function Activity114TaskItem:_goFinishBgOnClick()
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	Activity114Rpc.instance:receiveTaskReward(Activity114Model.instance.id, self.mo.id)
end

function Activity114TaskItem:getAnimator()
	return self._anim
end

function Activity114TaskItem:onDestroyView()
	self._simagebg:UnLoadImage()

	for _, v in pairs(self._rewardItems) do
		gohelper.destroy(v.itemIcon.go)
		gohelper.destroy(v.parentGo)
		v.itemIcon:onDestroy()
	end

	self._rewardItems = nil
end

return Activity114TaskItem
