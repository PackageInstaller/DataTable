-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitactivity/view/TimeLimitActivityEntranceItem.lua

module("logic.extensions.timelimitactivity.view.TimeLimitActivityEntranceItem", package.seeall)

local M = class("TimeLimitActivityEntranceItem", CellBaseComponent)
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._roleCompList = {}
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	self._nameTxt = goutil.findChildTextComponent(self._go, "txtActivitiesName")
	self._timeTxt = goutil.findChildTextComponent(self._go, "txtTime")
	self._bgImg = goutil.findChildImageComponent(self._go, "imgDi1")
	self._clickBtn = ButtonAdapter.Get(goutil.findChild(self._go, "click"))

	self._clickBtn:AddClickListener(self._onClickItem, self)
end

function M:setData(activityId)
	self._timelimitActivityId = activityId
	self._timelimitActivityCO = TimeLimitActivityConfig.instance:getCfgTimeLimitActivity(activityId)
	self._activityMO = TimeLimitActivityModel.instance:getActivityMO(activityId)

	self:_refreshCell()
end

function M:_refreshCell()
	self._nameTxt.text = self._timelimitActivityCO.iconName

	local leftSeconds = self._activityMO and self._activityMO:getLeftSeconds() or 0

	if leftSeconds <= 0 then
		self._timeTxt.text = lang("tip_activity_over")
	else
		self._timeTxt.text = TimeUtil.instance:trsSeconds2TimeStr(leftSeconds, "剩余$d天$h时")
	end
end

function M:_onClickItem()
	if not self._activityMO or not self._activityMO:getIsActivityOpen() then
		FloatWordMgr.instance:show(lang("tip_activity_over"))

		return
	end

	if self._clickFunc then
		self._clickFunc(self._clickHandler, self._timelimitActivityId)
	end
end

function M:setClickCallBack(func, handler)
	self._clickFunc = func
	self._clickHandler = handler
end

function M:OnDestroy()
	self._clickBtn:RemoveClickListener()
end

return M
