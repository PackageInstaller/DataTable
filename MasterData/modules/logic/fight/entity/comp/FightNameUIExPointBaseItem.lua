-- chunkname: @modules/logic/fight/entity/comp/FightNameUIExPointBaseItem.lua

module("modules.logic.fight.entity.comp.FightNameUIExPointBaseItem", package.seeall)

local FightNameUIExPointBaseItem = class("FightNameUIExPointBaseItem", UserDataDispose)

FightNameUIExPointBaseItem.AnimName = {
	LockClose = "lock_close",
	Lost = "fightname_expoint_out",
	Add = "fightname_expoint_in",
	Loop = "fightname_expoint_loop",
	Explosion = "fightname_expoint_all",
	LockOpen = "lock_open",
	StoredAdd = "overflow_open",
	StoredLost = "overflow_close",
	Client = "fightname_expoint_flash",
	UsingSkillExplosion = "withholding_open"
}
FightNameUIExPointBaseItem.AnimNameDuration = {
	[FightNameUIExPointBaseItem.AnimName.Add] = 0.5
}
FightNameUIExPointBaseItem.ExPointType = {
	Extra = 2,
	Normal = 1
}

function FightNameUIExPointBaseItem:getType()
	return FightNameUIExPointBaseItem.ExPointType.Normal
end

function FightNameUIExPointBaseItem:init(exPointGo)
	self:__onInit()

	self.exPointGo = exPointGo

	gohelper.setActive(self.exPointGo, true)

	self.goFull = gohelper.findChild(self.exPointGo, "full")
	self.imageFull = self.goFull:GetComponent(gohelper.Type_Image)

	self:_initEffectNode()

	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.exPointGo)
	self.animator = self.exPointGo:GetComponent(gohelper.Type_Animator)
	self.state = FightEnum.ExPointState.Empty

	self:initHandle()
end

function FightNameUIExPointBaseItem:_initEffectNode()
	self.goEffectExPoint = gohelper.findChild(self.exPointGo, "effectexpoint")
	self.goEffectIn = gohelper.findChild(self.goEffectExPoint, "in")
	self.goEffectLoop = gohelper.findChild(self.goEffectExPoint, "loop")
	self.goEffectOut = gohelper.findChild(self.goEffectExPoint, "out")
	self.goEffectAll = gohelper.findChild(self.goEffectExPoint, "all")
	self.goEffectWithHolding = gohelper.findChild(self.goEffectExPoint, "withholding")
	self.goEffectLock = gohelper.findChild(self.goEffectExPoint, "lock")
end

function FightNameUIExPointBaseItem:resetToEmpty()
	self.animatorPlayer:Stop()

	self.animator.enabled = false
	self.imageFull.color = Color.white

	gohelper.setActive(self.goFull, false)
	gohelper.setActive(self.goEffectIn, false)
	gohelper.setActive(self.goEffectLoop, false)
	gohelper.setActive(self.goEffectOut, false)
	gohelper.setActive(self.goEffectAll, false)
	gohelper.setActive(self.goEffectWithHolding, false)
	gohelper.setActive(self.goEffectLock, false)
end

function FightNameUIExPointBaseItem:setIndex(index)
	self.index = index
end

function FightNameUIExPointBaseItem:setMgr(mgr)
	self.mgr = mgr
end

function FightNameUIExPointBaseItem:playAnimToLastFrame(animName)
	self.animator.enabled = true

	self.animatorPlayer:Stop()
	self.animator:Play(animName, 0, 1)
end

function FightNameUIExPointBaseItem:initHandle()
	self.directSetStateHandleDict = {
		[FightEnum.ExPointState.Empty] = self.directSetEmptyState,
		[FightEnum.ExPointState.Server] = self.directSetServerState,
		[FightEnum.ExPointState.Client] = self.directSetClientState,
		[FightEnum.ExPointState.ServerFull] = self.directSetServerFullState,
		[FightEnum.ExPointState.UsingUnique] = self.directSetUsingUniqueState,
		[FightEnum.ExPointState.Lock] = self.directSetLockState,
		[FightEnum.ExPointState.Stored] = self.directSetStoredState
	}
	self.switchToStateHandleDict = {
		[FightEnum.ExPointState.Empty] = self.switchToEmptyState,
		[FightEnum.ExPointState.Server] = self.switchToServerState,
		[FightEnum.ExPointState.Client] = self.switchToClientState,
		[FightEnum.ExPointState.ServerFull] = self.switchToServerFullState,
		[FightEnum.ExPointState.UsingUnique] = self.switchToUsingUniqueState,
		[FightEnum.ExPointState.Lock] = self.switchToLockState,
		[FightEnum.ExPointState.Stored] = self.switchToStoredState
	}
end

function FightNameUIExPointBaseItem:updateExPoint()
	local state = self.mgr:getPointCurState(self.index)

	self:directSetState(state)
end

function FightNameUIExPointBaseItem:switchToNextState()
	if not self.nextState then
		return
	end

	self:stopSwitchToNextState()

	local nextState = self.nextState

	self.nextState = nil

	self:directSetState(nextState)
end

function FightNameUIExPointBaseItem:setNextState(state)
	self.nextState = state

	self:log("set next state : " .. state)
end

function FightNameUIExPointBaseItem:delaySwitchToNextState(state, delay)
	self:stopSwitchToNextState()
	self:setNextState(state)
	TaskDispatcher.runDelay(self.switchToNextState, self, delay)
end

function FightNameUIExPointBaseItem:stopSwitchToNextState()
	TaskDispatcher.cancelTask(self.switchToNextState, self)
end

function FightNameUIExPointBaseItem:log(text)
	return
end

function FightNameUIExPointBaseItem:directSetState(state)
	self:switchToNextState()
	self:log("direct set state : " .. state)

	local preState = self.state

	self.state = state

	local handle = self.directSetStateHandleDict[self.state]

	handle(self, preState)
end

function FightNameUIExPointBaseItem:switchToState(state)
	self:switchToNextState()
	self:log("switch to state : " .. state)

	local preState = self.state

	self.state = state

	local handle = self.switchToStateHandleDict[self.state]

	handle(self, preState)
end

function FightNameUIExPointBaseItem:getCurState()
	return self.state
end

function FightNameUIExPointBaseItem:playAnim(animName, callback, callbackObj, nextState)
	self:setNextState(nextState or self.mgr:getPointCurState(self.index))

	callback = callback or self.switchToNextState
	callbackObj = callbackObj or self

	if self.exPointGo.activeInHierarchy then
		self.animator.enabled = true

		self.animatorPlayer:Play(animName, callback, callbackObj)
	else
		self:switchToNextState()
	end
end

function FightNameUIExPointBaseItem:playAnimNoCallback(animName)
	if self.exPointGo.activeInHierarchy then
		self.animator.enabled = true

		self.animatorPlayer:Play(animName)
	end
end

function FightNameUIExPointBaseItem:playAddPointEffect(nextState, delay)
	nextState = nextState or FightEnum.ExPointState.Server

	gohelper.setActive(self.goFull, true)

	if delay then
		self:setNextState(nextState)
		self:playAnimNoCallback(FightNameUIExPointBaseItem.AnimName.Add)
		TaskDispatcher.runDelay(self.switchToNextState, self, delay)
	else
		self.playAnim(self, FightNameUIExPointBaseItem.AnimName.Add, self.switchToNextState, self, nextState)
	end

	local entity = self.mgr.entity

	if FightBuffHelper.checkPlayDuDuGuAddExPointEffect(entity) then
		local entityMo = entity:getMO()
		local skin = entityMo.skin
		local co = lua_fight_sp_effect_ddg.configDict[skin]
		local effectRes = "v2a3_ddg/ddg_innate_03"
		local hangPoint = ModuleEnum.SpineHangPointRoot

		if co then
			effectRes = co.addExPointEffect
			hangPoint = co.addExPointHang
		end

		local effectWrap = entity.uniqueEffect:addHangEffect(effectRes, hangPoint, nil, 1)

		effectWrap:setLocalPos(0, 0, 0)
	end
end

function FightNameUIExPointBaseItem:playRemoveStoredEffect()
	gohelper.setActive(self.goFull, true)
	self:playAnim(FightNameUIExPointBaseItem.AnimName.StoredLost)
end

function FightNameUIExPointBaseItem:directSetEmptyState(preState)
	self:resetToEmpty()
end

function FightNameUIExPointBaseItem:directSetServerState(preState)
	self:resetToEmpty()
	gohelper.setActive(self.goFull, true)
end

function FightNameUIExPointBaseItem:directSetClientState(preState)
	self:resetToEmpty()
	gohelper.setActive(self.goFull, true)

	self.animator.enabled = true

	self.animatorPlayer:Play(FightNameUIExPointBaseItem.AnimName.Client)
end

function FightNameUIExPointBaseItem:directSetServerFullState(preState)
	self:resetToEmpty()
	gohelper.setActive(self.goFull, true)
	self:playAnimToLastFrame(FightNameUIExPointBaseItem.AnimName.Loop)
end

function FightNameUIExPointBaseItem:directSetUsingUniqueState(preState)
	if preState == self.state then
		return
	end

	self:resetToEmpty()

	self.animator.enabled = true

	self.animatorPlayer:Play(FightNameUIExPointBaseItem.AnimName.UsingSkillExplosion)
end

function FightNameUIExPointBaseItem:directSetLockState(preState)
	self:resetToEmpty()
	gohelper.setActive(self.goFull, false)
	self:playAnimToLastFrame(FightNameUIExPointBaseItem.AnimName.LockOpen)
end

function FightNameUIExPointBaseItem:directSetStoredState(preState)
	self:resetToEmpty()
	gohelper.setActive(self.goFull, false)
	self:playAnimToLastFrame(FightNameUIExPointBaseItem.AnimName.StoredAdd)
end

function FightNameUIExPointBaseItem:switchToEmptyState(preState)
	self:resetToEmpty()

	if preState == FightEnum.ExPointState.Lock then
		self.animator.enabled = true

		self.animatorPlayer:Play(FightNameUIExPointBaseItem.AnimName.LockClose)
	elseif preState == FightEnum.ExPointState.Lock then
		self.animator.enabled = true

		self.animatorPlayer:Play(FightNameUIExPointBaseItem.AnimName.Lost)
	end
end

function FightNameUIExPointBaseItem:switchToServerState(preState)
	self:resetToEmpty()
	gohelper.setActive(self.goFull, true)
end

function FightNameUIExPointBaseItem:switchToClientState(preState)
	self:resetToEmpty()
	gohelper.setActive(self.goFull, true)

	self.animator.enabled = true

	self.animatorPlayer:Play(FightNameUIExPointBaseItem.AnimName.Client)
end

function FightNameUIExPointBaseItem:switchToServerFullState(preState)
	self:resetToEmpty()
	gohelper.setActive(self.goFull, true)

	self.animator.enabled = true

	self.animatorPlayer:Play(FightNameUIExPointBaseItem.AnimName.Loop)
end

function FightNameUIExPointBaseItem:switchToUsingUniqueState(preState)
	if preState == self.state then
		return
	end

	self:resetToEmpty()

	self.animator.enabled = true

	self.animatorPlayer:Play(FightNameUIExPointBaseItem.AnimName.UsingSkillExplosion)
end

function FightNameUIExPointBaseItem:switchToLockState(preState)
	self:resetToEmpty()
	gohelper.setActive(self.goFull, false)

	self.animator.enabled = true

	self.animatorPlayer:Play(FightNameUIExPointBaseItem.AnimName.LockOpen)
end

function FightNameUIExPointBaseItem:switchToStoredState(preState)
	if preState == self.state then
		return
	end

	self:resetToEmpty()
	gohelper.setActive(self.goFull, false)

	self.animator.enabled = true

	self.animatorPlayer:Play(FightNameUIExPointBaseItem.AnimName.StoredAdd)
end

function FightNameUIExPointBaseItem:recycle(goPoolContainer)
	gohelper.addChild(goPoolContainer, self.exPointGo)
end

function FightNameUIExPointBaseItem:getPointGo()
	return self.exPointGo
end

function FightNameUIExPointBaseItem:destroy()
	self:stopSwitchToNextState()
	self.animatorPlayer:Stop()
	gohelper.destroy(self.exPointGo)
	self:__onDispose()
end

return FightNameUIExPointBaseItem
