-- chunkname: @modules/logic/activity/view/ActivityNorSignItem_1_2.lua

module("modules.logic.activity.view.ActivityNorSignItem_1_2", package.seeall)

local ActivityNorSignItem_1_2 = class("ActivityNorSignItem_1_2", ListScrollCell)

function ActivityNorSignItem_1_2:init(go)
	self._gobg = gohelper.findChild(go, "normalbg")
	self._todaybg = gohelper.findChild(go, "todaybg")
	self._txtdate = gohelper.findChildText(go, "datecn")
	self._txtdateEn = gohelper.findChildText(go, "dateen")
	self._goreward = gohelper.findChild(go, "#go_reward")
	self._gotomorrowtag = gohelper.findChild(go, "go_tomorrowtag")
	self._goget = gohelper.findChild(go, "get")
	self._gomask = gohelper.findChild(go, "mask")
	self._itemClick = gohelper.getClickWithAudio(self._gobg)
	self._txtname = gohelper.findChildText(go, "#go_reward/#txt_name")
	self._anim = go:GetComponent(typeof(UnityEngine.Animator))
	self._anim.enabled = false
	self._go = go

	gohelper.setActive(go, false)
end

function ActivityNorSignItem_1_2:addEventListeners()
	self._itemClick:AddClickListener(self._onItemClick, self)
end

function ActivityNorSignItem_1_2:removeEventListeners()
	self._itemClick:RemoveClickListener()
end

function ActivityNorSignItem_1_2:_onItemClick()
	local actId = self._mo.data[1]
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(actId, self._index)
	local totalday = ActivityType101Model.instance:getType101LoginCount(actId)

	if couldGet then
		Activity101Rpc.instance:sendGet101BonusRequest(actId, self._index)
	end

	if totalday < self._index then
		GameFacade.showToast(ToastEnum.NorSign)
	end
end

function ActivityNorSignItem_1_2:onUpdateMO(mo)
	self._mo = mo

	self:_refreshItem()
	TaskDispatcher.runDelay(self._playAnimation, self, self._index * 0.03)
end

function ActivityNorSignItem_1_2:_refreshItem()
	local actId = self._mo.data[1]
	local prop = string.splitToNumber(ActivityConfig.instance:getNorSignActivityCo(actId, self._index).bonus, "#")
	local config, icon = ItemModel.instance:getItemConfigAndIcon(prop[1], prop[2])

	self._item = self._item or IconMgr.instance:getCommonPropItemIcon(self._goreward)

	self._item:setMOValue(prop[1], prop[2], prop[3], nil, true)
	self._item:setScale(0.8)
	self._item:showName(self._txtname)

	self._txtname.text = config.name

	self._item:setNameType("<color=#3A3836><size=38>%s</size></color>")
	self._item:setCountFontSize(35)

	self._txtdate.text = "0" .. self._index
	self._txtdateEn.text = string.format("DAY\n%s", GameUtil.getEnglishNumber(self._index))

	local rewardGet = ActivityType101Model.instance:isType101RewardGet(actId, self._index)
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(actId, self._index)
	local totalday = ActivityType101Model.instance:getType101LoginCount(actId)

	gohelper.setActive(self._goget, rewardGet)
	gohelper.setActive(self._gomask, rewardGet or totalday < self._index)
	gohelper.setActive(self._todaybg, couldGet)
	gohelper.setActive(self._gotomorrowtag, self._index ~= 7 and self._index == totalday + 1)

	if rewardGet then
		ZProj.UGUIHelper.SetColorAlpha(self._gomask:GetComponent("Image"), 0.68)
	else
		ZProj.UGUIHelper.SetColorAlpha(self._gomask:GetComponent("Image"), 0)
	end

	if not rewardGet and couldGet then
		self._item:customOnClickCallback(self._onItemClick, self)
	else
		self._item:customOnClickCallback(nil)
	end
end

function ActivityNorSignItem_1_2:_playAnimation()
	gohelper.setActive(self._go, true)

	self._anim.enabled = true
end

function ActivityNorSignItem_1_2:onDestroy()
	TaskDispatcher.cancelTask(self._playAnimation, self)
end

return ActivityNorSignItem_1_2
