-- chunkname: @modules/logic/teach/view/TeachNoteRewardListItem.lua

module("modules.logic.teach.view.TeachNoteRewardListItem", package.seeall)

local TeachNoteRewardListItem = class("TeachNoteRewardListItem", ListScrollCellExtend)

function TeachNoteRewardListItem:init(go)
	self._txtDesc = gohelper.findChildText(go, "right/#txt_des")
	self._gopoint = gohelper.findChild(go, "right/#go_process/#go_point")
	self._gorewarditem = gohelper.findChild(go, "right/#go_reward/#go_rewarditem")
	self._gofinish = gohelper.findChild(go, "#go_finish")
	self._golock = gohelper.findChild(go, "#go_lock")
	self._goreceive = gohelper.findChild(go, "#go_receive")
	self._goreceivebg = gohelper.findChild(go, "#go_receive/receivebg")
	self._goreward = gohelper.findChild(go, "right/#go_reward")
	self._txtrewardcount = gohelper.findChildText(go, "right/#go_reward/rewardcountbg/#txt_rewardcount")
	self._txtindex = gohelper.findChildText(go, "right/#txt_index")
	self._rewardClick = gohelper.getClick(self._goreceive.gameObject)
	self._rewardCanvasGroup = self._goreward:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._processItems = self:getUserDataTb_()
end

function TeachNoteRewardListItem:addEventListeners()
	self._rewardClick:AddClickListener(self._onRewardClick, self)
end

function TeachNoteRewardListItem:removeEventListeners()
	self._rewardClick:RemoveClickListener()
end

function TeachNoteRewardListItem:_onRewardClick()
	if TeachNoteModel.instance:isRewardCouldGet(self._mo.id) then
		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_activity_act)
		DungeonRpc.instance:sendInstructionDungeonRewardRequest(self._mo.id)
	end
end

function TeachNoteRewardListItem:onUpdateMO(mo)
	self._mo = mo

	self:_refreshItem()
end

function TeachNoteRewardListItem:_refreshItem()
	if self._processItems then
		for _, v in pairs(self._processItems) do
			gohelper.setActive(v.go, false)
		end
	end

	self._txtDesc.text = DungeonConfig.instance:getChapterCO(self._mo.chapterId).name
	self._txtindex.text = "NO." .. self._index

	local finishCount = TeachNoteModel.instance:getTeachNoteTopicFinishedLevelCount(self._mo.id)
	local total = TeachNoteModel.instance:getTeachNoteTopicLevelCount(self._mo.id)

	for i = 1, total do
		if not self._processItems[i] then
			self._processItems[i] = {}
			self._processItems[i].go = gohelper.cloneInPlace(self._gopoint, "point" .. i)
			self._processItems[i].gofinish = gohelper.findChild(self._processItems[i].go, "finish")
			self._processItems[i].gounfinish = gohelper.findChild(self._processItems[i].go, "unfinish")
		end

		gohelper.setActive(self._processItems[i].go, true)
		gohelper.setActive(self._processItems[i].gofinish, i <= finishCount)
		gohelper.setActive(self._processItems[i].gounfinish, finishCount < i)
	end

	gohelper.setActive(self._goreceive, TeachNoteModel.instance:isRewardCouldGet(self._mo.id))
	gohelper.setActive(self._gofinish, TeachNoteModel.instance:isTopicRewardGet(self._mo.id))
	gohelper.setActive(self._golock, not TeachNoteModel.instance:isTopicUnlock(self._mo.id))
	gohelper.setActive(self._txtDesc.gameObject, TeachNoteModel.instance:isTopicUnlock(self._mo.id))

	self._rewardCanvasGroup.alpha = TeachNoteModel.instance:isTopicUnlock(self._mo.id) and 1 or 0.5

	local bonus = string.splitToNumber(TeachNoteConfig.instance:getInstructionTopicCO(self._mo.id).bonus, "#")

	self._itemIcon = self._itemIcon or IconMgr.instance:getCommonItemIcon(self._gorewarditem)

	self._itemIcon:setMOValue(bonus[1], bonus[2], bonus[3])
	self._itemIcon:isShowEffect(false)
	self._itemIcon:isShowCount(false)
	self._itemIcon:isShowQuality(false)

	self._txtrewardcount.text = bonus[3]
end

function TeachNoteRewardListItem:onDestroyView()
	if self._processItems then
		self._processItems = {}
	end

	if self._itemIcon then
		self._itemIcon:onDestroy()
	end
end

return TeachNoteRewardListItem
