-- chunkname: @modules/logic/fight/view/work/FightReadyAttackWork.lua

module("modules.logic.fight.view.work.FightReadyAttackWork", package.seeall)

local FightReadyAttackWork = class("FightReadyAttackWork", BaseWork)
local Time1 = 0.5
local Time2 = 1
local endColor = Color.New(2.119, 1.353, 0.821, 1)
local lerpColor = Color.white

function FightReadyAttackWork:onStart(entity)
	self._count = 3
	self._hasAddEvent = false
	self._entity = entity

	local entityMO = FightDataHelper.entityMgr:getById(self._entity.id)

	if entityMO and self._entity and self._entity.spine and not self._entity.spine:hasAnimation(SpineAnimState.posture) then
		self:onDone(true)

		return
	end

	local spineMat = self._entity.spineRenderer:getReplaceMat()

	self._oldColor = MaterialUtil.GetMainColor(spineMat)

	if not self._oldColor then
		self:onDone(true)

		return
	end

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 2, Time1 / FightModel.instance:getSpeed(), self._onFrameSetColor, self._checkDone, self)

	local buffAnim = entity.buff:getBuffAnim()

	if string.nilorempty(buffAnim) then
		if self._entity.spine:hasAnimation(SpineAnimState.change) then
			self._changeActName = FightHelper.processEntityActionName(self._entity, SpineAnimState.change)

			self._entity.spine:addAnimEventCallback(self._onChangeAnimEvent, self)
			self._entity.spine:play(self._changeActName, false, true, true)

			self._hasAddEvent = true
		else
			self:_playPostureAnim()
		end
	else
		self:_checkDone()
	end

	self._effectWrap = self._entity.effect:addHangEffect(FightPreloadEffectWork.buff_zhunbeigongji, ModuleEnum.SpineHangPoint.mountbottom)

	self._effectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(self._entity.id, self._effectWrap)
	TaskDispatcher.runDelay(self._checkDone, self, Time2 / FightModel.instance:getSpeed())
end

function FightReadyAttackWork:_onFrameSetColor(value)
	local lerpValue = value < 1 and value or 2 - value

	lerpColor.r = Mathf.Lerp(self._oldColor.r, endColor.r, lerpValue)
	lerpColor.g = Mathf.Lerp(self._oldColor.g, endColor.g, lerpValue)
	lerpColor.b = Mathf.Lerp(self._oldColor.b, endColor.b, lerpValue)

	self:_setMainColor(lerpColor)
end

function FightReadyAttackWork:_setMainColor(color)
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		local spineMat = self._entity.spineRenderer:getReplaceMat()

		if not gohelper.isNil(spineMat) then
			MaterialUtil.setMainColor(spineMat, color)
		end
	end
end

function FightReadyAttackWork:_onChangeAnimEvent(actionName, eventName, eventArgs)
	if actionName == self._changeActName and eventName == SpineAnimEvent.ActionComplete then
		self:_playPostureAnim()
	end
end

function FightReadyAttackWork:_playPostureAnim()
	if self._hasAddEvent then
		self._entity.spine:removeAnimEventCallback(self._onChangeAnimEvent, self)

		self._hasAddEvent = false
	end

	self._entity.spine:play(SpineAnimState.posture, true, true)
	self:_checkDone()
end

function FightReadyAttackWork:_checkDone()
	self._count = self._count - 1

	if self._count <= 0 then
		self:_setMainColor(self._oldColor)

		self._tweenId = nil

		self:onDone(true)
	end
end

function FightReadyAttackWork:clearWork()
	if self._effectWrap then
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self._entity.id, self._effectWrap)
		self._entity.effect:removeEffect(self._effectWrap)

		self._effectWrap = nil
	end

	if self._hasAddEvent then
		self._entity.spine:removeAnimEventCallback(self._onChangeAnimEvent, self)

		self._hasAddEvent = false
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil

		if self._oldColor then
			self:_setMainColor(self._oldColor)
		end
	end

	self._entity = nil

	TaskDispatcher.cancelTask(self._checkDone, self)
end

return FightReadyAttackWork
