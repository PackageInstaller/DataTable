-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\AvgModelStage.lua

local ModelStage = require("UI/Control/Com/ModelStage")
local TalkScenery = require("UI/TalkScenery")
local ResTalkSpecialOpt = require("ClientData/ResTalkSpecialOpt")
local AvgModelStage = Class("AvgModelStage", ModelStage)

function AvgModelStage:ctor(prefabPath, callback)
	self.prefabPath = prefabPath
	self._models = {}
	self._modelsActive = {}
	self._modelsVisible = {}
	self._modelInsIds = {}
	self.loadedCallback = callback
	self.slotOfFingerDown = Slot(self.onFingerDown, self)
	self.slotOfFingerUp = Slot(self.onFinegerUp, self)
	self.slotOfClick = Slot(self.onClick, self)
end

function AvgModelStage:initAvgModelStage(modelControl, sliderControl, sliderBgControl, sliderEndEfx, efxControl)
	self.modelControl = modelControl
	self.processSlider = sliderControl
	self.processBg = sliderBgControl
	self.processEndEfx = sliderEndEfx
	self.efxPanel = efxControl

	self:initOperation(modelControl)
end

function AvgModelStage:setOptMode(optId, endCallback)
	local optInfo = ResTalkSpecialOpt[optId]

	if not optInfo then
		return
	end

	self.actionEndCallback = endCallback

	local npcId = optInfo.target_npc

	self.actionNpc = TalkScenery.getNpc(npcId)
	self.optAnim = optInfo.opt_anim
	self.noticeEfx = optInfo.notice_efx
	self.noticeEfxPos = optInfo.efx_pos
	self.endAnim = optInfo.end_anim
	self.endEfx = optInfo.end_efx
	self.endSpAct = optInfo.end_special

	local optMode = optInfo.opt_type

	if optMode == UIConst.AVG_OPT_MODE_PRESS then
		self.inOptDelay = optInfo.opt_delay
		self.optPeriod = optInfo.opt_period
		self.optStep = optInfo.process_step
		self.inAnim = optInfo.opt_in_anim
		self.outAnim = optInfo.opt_out_anim
		self.optEfx = optInfo.opt_efx
		self.waitEndDelay = optInfo.wait_end_delay

		self.processBg:setVisible(false)
		self.processEndEfx:setVisible(false)
		self:_setActionSlider(0, true)

		self.mEventOprFingerDown = self.slotOfFingerDown
		self.mEventOprFingerUp = self.slotOfFingerUp
		self.mEventOprClick = nil

		self:_switchNoticeEfx(true, self.noticeEfx, self.noticeEfxPos)
	elseif optMode == UIConst.AVG_OPT_MODE_CLICK then
		self.comboCount = optInfo.combo_count
		self.judgeLength = optInfo.combo_judge

		self.processBg:setVisible(false)

		self.mEventOprFingerDown = nil
		self.mEventOprFingerUp = nil
		self.mEventOprClick = self.slotOfClick

		self:_switchNoticeEfx(true, self.noticeEfx, self.noticeEfxPos)
	end
end

function AvgModelStage:onFingerDown()
	if self.actionProcess >= 1 then
		return
	end

	self:_switchNoticeEfx(true, self.optEfx, self.noticeEfxPos)

	if self.pressActionCo then
		coroutine.stop(self.pressActionCo)
	end

	self.pressActionCo = coroutine.start(self._coPressAction, self)
end

function AvgModelStage:onFinegerUp(...)
	if self.actionProcess >= 1 then
		return
	end

	self:_switchNoticeEfx(true, self.noticeEfx, self.noticeEfxPos)

	if self.pressActionCo then
		coroutine.stop(self.pressActionCo)
	end

	if self.actionNpc then
		self.actionNpc:playAnimation(self.outAnim)
	end
end

function AvgModelStage:onClick(delta)
	local completeCombo = self:_judgeCombo(Time.time, self.judgeLength, self.comboCount)

	if completeCombo then
		if self.actionNpc then
			self.actionNpc:playAnimation(self.optAnim)
		end

		self:_onActionEnd()
	end
end

function AvgModelStage:_coPressAction()
	if self.actionNpc then
		self.actionNpc:playAnimation(self.inAnim)
	end

	self.processBg:setVisible(true)
	coroutine.wait(self.inOptDelay)

	if self.actionNpc then
		self.actionNpc:playAnimation(self.optAnim)
	end

	while self.actionProcess < 1 do
		coroutine.wait(self.optPeriod)
		self:_setActionSlider(self.actionProcess + self.optStep)
	end

	if self.actionProcess >= 1 then
		if self.actionNpc then
			self.actionNpc:playAnimation(self.endAnim)
		end

		self:_switchNoticeEfx(true, self.endEfx, self.noticeEfxPos)
		self.processBg:setVisible(false)
		self.processSlider:setVisible(false)
		self.processEndEfx:setVisible(true)
		self:_endSpecialAction()

		if self.waitEndDelay then
			coroutine.wait(self.waitEndDelay)
		end

		self.processEndEfx:setVisible(false)
		self:_onActionEnd()
	end
end

function AvgModelStage:_setActionSlider(value, immediately)
	self.actionProcess = value

	if self.processSlider then
		self.processSlider:setVisible(true)

		if immediately then
			self.processSlider:setRate(self.actionProcess, 0)
		else
			self.processSlider:setRate(self.actionProcess, 0.2)
		end
	end
end

function AvgModelStage:_onActionEnd(...)
	self.mEventOprFingerDown = nil
	self.mEventOprFingerUp = nil
	self.mEventOprClick = nil

	self:_switchNoticeEfx(false)

	if self.actionEndCallback then
		self.actionEndCallback()
	end
end

function AvgModelStage:_endSpecialAction()
	if self.endSpAct then
		local actionInfo = utils.splitString(self.endSpAct, ",")

		if #actionInfo >= 2 then
			local npcId = tonumber(actionInfo[1])
			local actionId = actionInfo[2]
			local actionNpc = TalkScenery.getNpc(npcId)

			if actionNpc then
				actionNpc:doSpecialAction({
					actionId
				})
			end
		end
	end
end

function AvgModelStage:_judgeCombo(nowTime, comboWindow, comboCount)
	if not self.nowCombo then
		self.nowCombo = 0
	end

	if not self.lastClickTime then
		self.lastClickTime = nowTime
	end

	if comboWindow < nowTime - self.lastClickTime then
		self.nowCombo = 1
	else
		self.nowCombo = self.nowCombo + 1
	end

	local comboThisTime = false

	if comboCount <= self.nowCombo then
		comboThisTime = true
		self.nowCombo = 0
	end

	self.lastClickTime = nowTime

	return comboThisTime
end

function AvgModelStage:_switchNoticeEfx(turnOn, noticeEfx, noticeEfxPos)
	if turnOn and noticeEfx then
		self.efxPanel:setVisible(true)
		self.efxPanel:playEffectByPath(noticeEfx)

		noticeEfxPos = noticeEfxPos or {
			0,
			0
		}

		self.efxPanel:setPosition(noticeEfxPos[1], noticeEfxPos[2])
	else
		self.efxPanel:setVisible(false)
	end
end

function AvgModelStage:initOperation(panel)
	if self._obj then
		self._obj:SetOperationDefault(panel:getGameObject())
	end
end

return AvgModelStage
