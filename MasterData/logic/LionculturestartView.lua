-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LionculturestartView.lua

module("logic.extensions.lionculture.view.LionculturestartView", package.seeall)

local LionculturestartView = class("LionculturestartView", ViewComponent)

function LionculturestartView:ctor()
	LionculturestartView.super.ctor(self)
end

function LionculturestartView:unbindEvents()
	LionculturestartView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function LionculturestartView:bindEvents()
	LionculturestartView.super.bindEvents(self)
	self._closeButton:AddClickListener(function()
		FloatWordMgr.instance:show("请完成点睛")
	end, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "lionculture_rule1")
	end, self)
	self._btnLeft:AddClickListener(self._leftOnClick, self)
	self._btnRight:AddClickListener(self._rightOnClick, self)
end

function LionculturestartView:buildUI()
	LionculturestartView.super.buildUI(self)

	self._closeButton = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnLeft = self:getBtn("btnLeft")
	self._btnRight = self:getBtn("btnRight")
	self._pen = self:getGo("pen")
	self._openDate = self:getTxt("time/txt")
end

function LionculturestartView:onExit()
	LionculturestartView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._leftEffect)
	UIEffectManager.instance:stopEffect(self._rightEffect)
end

function LionculturestartView:onEnter()
	LionculturestartView.super.onEnter(self)

	self._lefteye = false
	self._righteye = false
	self._leftEffect = self:_showEffect("common/fx_ui_zhiyin_quan_03.prefab", self._btnLeft, true)
	self._rightEffect = self:_showEffect("common/fx_ui_zhiyin_quan_03.prefab", self._btnRight, true)

	local startDate, endDate = ActivityDefineController.instance:getStartTimeAndEndTime(237, LioncultureModel.instance.activityId)
	local startDateTable = GameUtil.time2date(startDate)
	local endDateTable = GameUtil.time2date(endDate)

	self._openDate.text = string.format("活动时间：%02d.%02d %02d:%02d-%02d.%02d %02d:%02d", startDateTable.month, startDateTable.day, startDateTable.hour, startDateTable.min, endDateTable.month, endDateTable.day, endDateTable.hour, endDateTable.min)

	goutil.setActive(self._pen, false)
end

function LionculturestartView:_leftOnClick()
	self._lefteye = true

	UIEffectManager.instance:stopEffect(self._leftEffect)
	self:_showEffect("20230120/xingshiwenhua/fx_ui_xingshiwenhua_bi.prefab", self._btnLeft, false, function()
		self:_onClik()
	end)
end

function LionculturestartView:_rightOnClick()
	self._righteye = true

	UIEffectManager.instance:stopEffect(self._rightEffect)
	self:_showEffect("20230120/xingshiwenhua/fx_ui_xingshiwenhua_bi.prefab", self._btnRight, false, function()
		self:_onClik()
	end)
end

function LionculturestartView:_onClik()
	if self._lefteye and self._righteye then
		FloatWordMgr.instance:show("点睛成功")
		GameUtil.saveUserData(ViewName.LionculturestartView, true)
		self:close()
	end
end

function LionculturestartView:_showEffect(path, go, loop, func)
	local effect = UIEffectManager.instance:playEffect(self, path, go, 0, 0, loop, false, func)

	effect:setParent(go.transform)
	effect:setLocalPos(0, 0, 0)
	effect:setScale(1)

	return effect
end

return LionculturestartView
