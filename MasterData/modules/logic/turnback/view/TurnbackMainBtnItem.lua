-- chunkname: @modules/logic/turnback/view/TurnbackMainBtnItem.lua

module("modules.logic.turnback.view.TurnbackMainBtnItem", package.seeall)

local TurnbackMainBtnItem = class("TurnbackMainBtnItem", ActCenterItemBase)

function TurnbackMainBtnItem:init(go, turnbackId)
	self.turnbackId = turnbackId
	self._hasSetRefreshTime = false

	TurnbackMainBtnItem.super.init(self, gohelper.cloneInPlace(go))
end

function TurnbackMainBtnItem:onInit(go)
	self:_initReddotitem()
	self:_refreshItem()
end

function TurnbackMainBtnItem:onClick()
	local param = {
		turnbackId = self.turnbackId
	}

	TurnbackController.instance:openTurnbackBeginnerView(param)
	AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_activity_open)
end

function TurnbackMainBtnItem:_refreshItem()
	local isShow = ActivityModel.showActivityEffect()
	local spriteName = self:getActBtnPrefixIconName(isShow, "icon_4")

	UISpriteSetMgr.instance:setMainSprite(self._imgitem, spriteName, true)
	self:setFestival(isShow)

	if TurnbackModel.instance:getCurTurnbackMoWithNilError() then
		gohelper.setActive(self._godeadline, true)
		self:_refreshRemainTime()

		local _, _, _, second = TurnbackModel.instance:getRemainTime()

		TaskDispatcher.runDelay(self._delayUpdateView, self, second)
	else
		gohelper.setActive(self._godeadline, false)
	end

	self._redDot:refreshDot()
end

function TurnbackMainBtnItem:_delayUpdateView()
	self:_refreshRemainTime()

	local day, hour, minute = TurnbackModel.instance:getRemainTime()

	TaskDispatcher.cancelTask(self._refreshRemainTime, self)

	if day <= 0 and hour <= 1 and minute <= 1 and not self._hasSetRefreshTime then
		TaskDispatcher.runRepeat(self._refreshRemainTime, self, 2)

		self._hasSetRefreshTime = true
	else
		TaskDispatcher.runRepeat(self._refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	end
end

function TurnbackMainBtnItem:_refreshRemainTime()
	local day, hour, minute, second = TurnbackModel.instance:getRemainTime()

	if not TurnbackModel.instance:isInOpenTime() then
		TaskDispatcher.cancelTask(self._refreshRemainTime, self)
	end

	if day == 0 and hour <= 1 and minute <= 1 and not self._hasSetRefreshTime then
		TaskDispatcher.cancelTask(self._refreshRemainTime, self)
		TaskDispatcher.runRepeat(self._refreshRemainTime, self, 2)

		self._hasSetRefreshTime = true
	end

	if day >= 1 then
		self._txttime.text = string.format("%d d", day)
	elseif day == 0 and hour >= 1 then
		self._txttime.text = string.format("%d h", hour)
	elseif day == 0 and hour < 1 and minute >= 1 then
		self._txttime.text = string.format("%d m", minute)
	elseif day == 0 and hour < 1 and minute < 1 and second >= 0 then
		self._txttime.text = "<1m"
	elseif day < 0 or not TurnbackModel.instance:isInOpenTime() then
		TaskDispatcher.cancelTask(self._refreshRemainTime, self)
	end

	TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshRemainTime)
end

function TurnbackMainBtnItem:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshRemainTime, self)
	TaskDispatcher.cancelTask(self._delayUpdateView, self)
	TurnbackMainBtnItem.super.onDestroyView(self)
end

function TurnbackMainBtnItem:isShowRedDot()
	return self._redDot.show
end

function TurnbackMainBtnItem:_initReddotitem()
	local go = self.go

	do
		local rGo = gohelper.findChild(go, "go_activityreddot")

		self._redDot = RedDotController.instance:addRedDot(rGo, RedDotEnum.DotNode.TurnbackEntre, nil, self._checkCustomShowRedDotData, self)

		return
	end

	local redGos = gohelper.findChild(go, "go_activityreddot/#go_special_reds")
	local t = redGos.transform
	local n = t.childCount

	for i = 1, n do
		local child = t:GetChild(i - 1)

		gohelper.setActive(child.gameObject, false)
	end

	local redGo = gohelper.findChild(redGos, "#go_turnback_red")

	self._redDot = RedDotController.instance:addRedDotTag(redGo, RedDotEnum.DotNode.TurnbackEntre, false, self._onRefreshDot, self)
	self._btnitem2 = gohelper.getClick(redGo)
end

function TurnbackMainBtnItem:_onRefreshDot(commonRedDotTag)
	local isShow = self:_checkIsShowRed(commonRedDotTag.dotId, 0)

	commonRedDotTag.show = isShow

	gohelper.setActive(commonRedDotTag.go, isShow)
	gohelper.setActive(self._imgGo, not isShow)
end

function TurnbackMainBtnItem:_checkIsShowRed(id, uid)
	if RedDotModel.instance:isDotShow(id, uid or 0) then
		return true
	end

	local curTurnbackMo = TurnbackModel.instance:getCurTurnbackMo()

	if not curTurnbackMo then
		return false
	end

	if curTurnbackMo:isAdditionInOpenTime() and TurnbackController.instance:checkIsShowCustomRedDot(TurnbackEnum.ActivityId.DungeonShowView) then
		return true
	end

	if TurnbackRecommendModel.instance:getCanShowRecommendCount() > 0 and TurnbackController.instance:checkIsShowCustomRedDot(TurnbackEnum.ActivityId.RecommendView) then
		return true
	end

	return false
end

function TurnbackMainBtnItem:_checkCustomShowRedDotData(redDotIcon)
	redDotIcon:defaultRefreshDot()
end

return TurnbackMainBtnItem
