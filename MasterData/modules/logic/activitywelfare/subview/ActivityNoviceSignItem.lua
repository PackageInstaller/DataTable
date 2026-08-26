-- chunkname: @modules/logic/activitywelfare/subview/ActivityNoviceSignItem.lua

module("modules.logic.activitywelfare.subview.ActivityNoviceSignItem", package.seeall)

local ActivityNoviceSignItem = class("ActivityNoviceSignItem", ListScrollCell)

function ActivityNoviceSignItem:init(go)
	self._go = go
	self._gobg = gohelper.findChild(go, "#go_normalday/normalbg")
	self._gotomorrowtag = gohelper.findChild(go, "#go_tomorrowtag")
	self._gotodaynormalbg = gohelper.findChild(go, "#go_todaynormalbg")
	self._txtdate = gohelper.findChildText(go, "date/datecn")
	self._gonormalday = gohelper.findChild(go, "#go_normalday")
	self._gonormalget = gohelper.findChild(go, "#go_normalget")
	self._finalget = gohelper.findChild(go, "#go_finalget")
	self._itemClick = gohelper.getClickWithAudio(self._gotodaynormalbg)
	self._gofinalbg = gohelper.findChild(go, "#go_finalday/finalbg")
	self._finalitemClick = gohelper.getClickWithAudio(self._gofinalbg)
	self._siamgefinalrewardicon = gohelper.findChildSingleImage(go, "#go_finalday/#siamge_finalrewardicon")
	self._gofinalday = gohelper.findChild(go, "#go_finalday")
	self._goicon1 = gohelper.findChild(go, "#go_normalday/content/#go_icon1")
	self._goicon2 = gohelper.findChild(go, "#go_normalday/content/#go_icon2")
	self._canvascontent = gohelper.findChild(go, "#go_normalday/content"):GetComponent(typeof(UnityEngine.CanvasGroup))
	self._canvasdate = gohelper.findChild(go, "date"):GetComponent(typeof(UnityEngine.CanvasGroup))
	self._anim = go:GetComponent(typeof(UnityEngine.Animator))
	self._anim.enabled = false

	gohelper.setActive(go, false)

	self._rewardTab = {}
end

ActivityNoviceSignItem.finalday = 8

function ActivityNoviceSignItem:addEventListeners()
	self._itemClick:AddClickListener(self._onItemClick, self)
	self._finalitemClick:AddClickListener(self._onItemClick, self)
end

function ActivityNoviceSignItem:removeEventListeners()
	self._itemClick:RemoveClickListener()
	self._finalitemClick:RemoveClickListener()
end

function ActivityNoviceSignItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)

	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(ActivityEnum.Activity.NoviceSign, self._index)
	local totalday = ActivityType101Model.instance:getType101LoginCount(ActivityEnum.Activity.NoviceSign)

	if couldGet then
		Activity101Rpc.instance:sendGet101BonusRequest(ActivityEnum.Activity.NoviceSign, self._index)
	end

	if self._index == ActivityNoviceSignItem.finalday and not couldGet then
		MaterialTipController.instance:showMaterialInfo(tonumber(self._prop[1]), tonumber(self._prop[2]))
	end
end

function ActivityNoviceSignItem:onUpdateMO(mo)
	self._mo = mo

	self:_refreshItem()
	TaskDispatcher.runDelay(self._playAnimation, self, self._index * 0.03)
end

function ActivityNoviceSignItem:_refreshItem()
	ActivityType101Model.instance:setCurIndex(self._index)

	if self._index ~= ActivityNoviceSignItem.finalday then
		local rewards = string.split(ActivityConfig.instance:getNorSignActivityCo(ActivityEnum.Activity.NoviceSign, self._index).bonus, "|")

		for i = 1, #rewards do
			local itemCo = string.splitToNumber(rewards[i], "#")
			local item = self._rewardTab[i]

			if not item then
				item = IconMgr.instance:getCommonPropItemIcon(self["_goicon" .. i])

				table.insert(self._rewardTab, item)
			end

			item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
			item:setCountFontSize(46)
			item:setHideLvAndBreakFlag(true)
			item:hideEquipLvAndBreak(true)
		end

		SLFramework.UGUI.GuiHelper.SetColor(self._txtdate, "#ADA697")
	else
		self._prop = string.splitToNumber(ActivityConfig.instance:getNorSignActivityCo(ActivityEnum.Activity.NoviceSign, self._index).bonus, "#")

		local config, icon = ItemModel.instance:getItemConfigAndIcon(self._prop[1], self._prop[2], true)

		self._siamgefinalrewardicon:LoadImage(icon)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtdate, "#B57F50")
	end

	gohelper.setActive(self._gofinalday, tonumber(self._index) == ActivityNoviceSignItem.finalday)
	gohelper.setActive(self._gonormalday, tonumber(self._index) ~= ActivityNoviceSignItem.finalday)

	self._txtdate.text = string.format("%02d", self._index)

	local rewardGet = ActivityType101Model.instance:isType101RewardGet(ActivityEnum.Activity.NoviceSign, self._index)
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(ActivityEnum.Activity.NoviceSign, self._index)
	local totalday = ActivityType101Model.instance:getType101LoginCount(ActivityEnum.Activity.NoviceSign)

	gohelper.setActive(self._gonormalget, rewardGet and self._index ~= ActivityNoviceSignItem.finalday)
	gohelper.setActive(self._finalget, rewardGet and self._index == ActivityNoviceSignItem.finalday)
	gohelper.setActive(self._gotodaynormalbg, couldGet)
	gohelper.setActive(self._gotomorrowtag, self._index == totalday + 1)

	self._canvascontent.alpha = rewardGet and 0.8 or 1
	self._canvasdate.alpha = rewardGet and 0.8 or 1

	ZProj.UGUIHelper.SetColorAlpha(self._siamgefinalrewardicon:GetComponent(gohelper.Type_Image), rewardGet and 0.8 or 1)
end

function ActivityNoviceSignItem:_playAnimation()
	gohelper.setActive(self._go, true)

	self._anim.enabled = true
end

function ActivityNoviceSignItem:onDestroy()
	if self._index and tonumber(self._index) == 8 then
		self._siamgefinalrewardicon:UnLoadImage()
	end

	TaskDispatcher.cancelTask(self._playAnimation, self)
end

return ActivityNoviceSignItem
