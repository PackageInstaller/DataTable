-- chunkname: @modules/logic/versionactivity2_2/warmup/view/V2a2_WarmUpLeftView_Day4.lua

module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day4", package.seeall)

local Base = require("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_DayBase")
local V2a2_WarmUpLeftView_Day4 = class("V2a2_WarmUpLeftView_Day4", Base)

function V2a2_WarmUpLeftView_Day4:onInitView()
	self._simageicon1 = gohelper.findChildSingleImage(self.viewGO, "before/#simage_icon1")
	self._btn1 = gohelper.findChildButtonWithAudio(self.viewGO, "before/#btn_1")
	self._btn2 = gohelper.findChildButtonWithAudio(self.viewGO, "before/#btn_2")
	self._btn3 = gohelper.findChildButtonWithAudio(self.viewGO, "before/#btn_3")
	self._simageicon2 = gohelper.findChildSingleImage(self.viewGO, "after/#simage_icon2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a2_WarmUpLeftView_Day4:addEvents()
	self._btn1:AddClickListener(self._btn1OnClick, self)
	self._btn2:AddClickListener(self._btn2OnClick, self)
	self._btn3:AddClickListener(self._btn3OnClick, self)
end

function V2a2_WarmUpLeftView_Day4:removeEvents()
	self._btn1:RemoveClickListener()
	self._btn2:RemoveClickListener()
	self._btn3:RemoveClickListener()
end

local csAnimatorPlayer = SLFramework.AnimatorPlayer

local function _getStateName(stateList)
	local name = ""

	for _, ok in ipairs(stateList) do
		name = (ok and "1" or "0") .. name
	end

	return "_" .. name
end

local States = {}
local s_stateValue = 0

local function _S(...)
	local stateList = {
		...
	}

	tabletool.revert(stateList)

	local name = _getStateName(stateList)

	States[name] = s_stateValue
	s_stateValue = s_stateValue + 1
end

local _0, _1 = false, true

_S(_0, _0, _0)
_S(_0, _0, _1)
_S(_0, _1, _0)
_S(_0, _1, _1)
_S(_1, _0, _0)
_S(_1, _0, _1)
_S(_1, _1, _0)
_S(_1, _1, _1)

function V2a2_WarmUpLeftView_Day4:_btn1OnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_home_role_put_20220223)
end

function V2a2_WarmUpLeftView_Day4:_btn2OnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_home_role_put_20220223)
end

function V2a2_WarmUpLeftView_Day4:_btn3OnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_home_role_put_20220223)
end

function V2a2_WarmUpLeftView_Day4:ctor(ctorParam)
	Base.ctor(self, ctorParam)

	self._context = {
		needWaitCount = 0,
		dragEnabled = false
	}
end

function V2a2_WarmUpLeftView_Day4:_editableInitView()
	Base._editableInitView(self)

	self._guideGo = gohelper.findChild(self.viewGO, "guide_day4")
	self._startDefaultPosList = {}
	self._startGoList = self:getUserDataTb_()
	self._endGoList = self:getUserDataTb_()
	self._startTransList = self:getUserDataTb_()
	self._endTransList = self:getUserDataTb_()
	self._startAnimPlayerList = self:getUserDataTb_()

	for i = 1, 3 do
		local endGo = gohelper.findChild(self.viewGO, "before/btn_highlight_" .. i)
		local startGo = gohelper.findChild(self.viewGO, "before/#btn_" .. i)
		local endTrans = endGo.transform
		local startTrans = startGo.transform
		local startX, startY = recthelper.getAnchor(startTrans)
		local startAnimPlayer = csAnimatorPlayer.Get(startGo)

		table.insert(self._startDefaultPosList, {
			x = startX,
			y = startY
		})
		table.insert(self._startGoList, startGo)
		table.insert(self._endGoList, endGo)
		table.insert(self._startTransList, startTrans)
		table.insert(self._endTransList, endTrans)
		table.insert(self._startAnimPlayerList, startAnimPlayer)
		CommonDragHelper.instance:registerDragObj(startGo, self._onBeginDrag, nil, self._onEndDrag, self._checkCanDrag, self, i)
	end
end

local kToastId = -313

function V2a2_WarmUpLeftView_Day4:_checkCanDrag()
	local isNotAllowDrag = not self:_canDrag()

	if self:_isDone3() and isNotAllowDrag then
		GameFacade.showToast(kToastId)
	end

	return isNotAllowDrag
end

function V2a2_WarmUpLeftView_Day4:_canDrag()
	return self._context.dragEnabled
end

function V2a2_WarmUpLeftView_Day4:_setDragEnabled(isEnable)
	self._context.dragEnabled = isEnable
end

function V2a2_WarmUpLeftView_Day4:_setActive_anim(isActive)
	local animator = self._anim_before

	animator.enabled = isActive
end

function V2a2_WarmUpLeftView_Day4:_onBeginDrag(i, pointerEventData)
	if not self:_canDrag() then
		return
	end

	self:_setActive_anim(false)
	Base._onDragBegin(self)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_home_role_put_20220223)
end

function V2a2_WarmUpLeftView_Day4:_onEndDrag(i, pointerEventData)
	if not self:_canDrag() then
		return
	end

	local startTrans = self._startTransList[i]
	local endTrans = self._endTransList[i]

	self._context.lastDragIndex = i

	self:_setNeedWait(1)
	self.setPosToEnd(self, endTrans, startTrans, true, nil, self._setPostEndTweeen_doneCb, self)
end

function V2a2_WarmUpLeftView_Day4:_setNeedWait(waitCount)
	self._context.needWaitCount = assert(tonumber(waitCount))
	self._context.dragEnabled = false
end

function V2a2_WarmUpLeftView_Day4:_subNeedWait()
	self._context.needWaitCount = self._context.needWaitCount - 1

	local isStillNeed = self._context.needWaitCount > 0

	self._context.dragEnabled = not isStillNeed

	return isStillNeed
end

function V2a2_WarmUpLeftView_Day4:_saveState(i)
	local stateList = self:_getLastState()

	if stateList[i] == true then
		return
	end

	stateList[i] = true

	local state = self:_getState(stateList)

	self:saveState(state)
end

function V2a2_WarmUpLeftView_Day4:_getState(stateList)
	local stateName = _getStateName(stateList or self:_getLastState())

	return States[stateName]
end

function V2a2_WarmUpLeftView_Day4:_setPostEndTweeen_doneCb()
	if self:_subNeedWait() then
		return
	end

	local i = self._context.lastDragIndex

	self:_saveState(i)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_home_door_effect_put_20220224)
	self._onPutState(self, i, self._onPut_doneCb, self)
end

function V2a2_WarmUpLeftView_Day4:_onPutState(i, cb, cbObj)
	local animPlayer = self._startAnimPlayerList[i]

	local function warpCb(Self)
		local endGo = Self._endGoList[i]

		gohelper.setActive(endGo, false)

		if cb then
			cb(cbObj)
		end
	end

	if not animPlayer.isActiveAndEnabled then
		warpCb(self)

		return
	end

	animPlayer:Play("put", warpCb, self)
end

function V2a2_WarmUpLeftView_Day4:_isDone3()
	local state = self:_getState()

	return state == States._111
end

function V2a2_WarmUpLeftView_Day4:_onPut_doneCb()
	if self:_subNeedWait() then
		return
	end

	if self:_isDone3() and not self:isFinishInteractive() then
		self:markIsFinishedInteractive(true)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_youyu_yure_release_20220225)
		self:_setDragEnabled(false)
		self:_setNeedWait(2)
		self.playAnim_before_out(self, self._onAfterDone, self)
		self.playAnim_after_in(self, self._onAfterDone, self)
	end
end

function V2a2_WarmUpLeftView_Day4:_onAfterDone()
	if self:_subNeedWait() then
		return
	end

	self:saveStateDone(true)
	self:setActive_before(false)
	self:setActive_after(true)
	self:openDesc()
end

function V2a2_WarmUpLeftView_Day4:onDestroyView()
	Base.onDestroyView(self)

	for _, go in ipairs(self._startGoList) do
		CommonDragHelper.instance:unregisterDragObj(go)
	end
end

function V2a2_WarmUpLeftView_Day4:_getLastState()
	local isDone = self:checkIsDone()

	if isDone then
		self._lastState = {
			_1,
			_1,
			_1
		}

		return self._lastState, isDone
	end

	if not self._lastState then
		self._lastState = {
			_0,
			_0,
			_0
		}

		local state = self:getState(States._000)

		if States._001 == state or States._011 == state or States._101 == state or States._111 == state then
			self._lastState[1] = true
		end

		if States._010 == state or States._011 == state or States._110 == state or States._111 == state then
			self._lastState[2] = true
		end

		if States._100 == state or States._101 == state or States._110 == state or States._111 == state then
			self._lastState[3] = true
		end
	end

	return self._lastState, isDone
end

function V2a2_WarmUpLeftView_Day4:_setPosToDefault(i, isTween)
	local startTrans = self._startTransList[i]
	local v2 = self._startDefaultPosList[i]

	if isTween then
		self:tweenAnchorPos(startTrans, v2.x, v2.y)
	else
		recthelper.setAnchor(startTrans, v2.x, v2.y)
	end
end

function V2a2_WarmUpLeftView_Day4:setData()
	Base.setData(self)

	local stateList, isDone = self:_getLastState()

	self:setActive_before(not isDone)
	self:setActive_after(isDone)
	self:_setDragEnabled(not isDone)

	if not isDone then
		local doneCount = 0

		for i, ok in ipairs(stateList) do
			local startTrans = self._startTransList[i]
			local endTrans = self._endTransList[i]
			local startGo = self._startGoList[i]
			local endGo = self._endGoList[i]

			gohelper.setActive(startGo, true)
			gohelper.setActive(endGo, not ok)

			if ok then
				doneCount = doneCount + 1

				self:setPosToEnd(endTrans, startTrans)
			else
				self:_setPosToDefault(i)
			end
		end

		local isStateDone = doneCount > 0 and doneCount == #stateList

		if isStateDone then
			self:_setActive_anim(true)
			self:playAnimRaw_before_idle(0, 1)
			self:_setNeedWait(3)

			for i, _ in ipairs(stateList) do
				self._onPutState(self, i, self._onPut_doneCb, self)
			end

			self:_setDragEnabled(false)
		end
	end
end

return V2a2_WarmUpLeftView_Day4
