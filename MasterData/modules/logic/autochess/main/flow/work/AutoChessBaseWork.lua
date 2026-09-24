-- chunkname: @modules/logic/autochess/main/flow/work/AutoChessBaseWork.lua

module("modules.logic.autochess.main.flow.work.AutoChessBaseWork", package.seeall)

local AutoChessBaseWork = class("AutoChessBaseWork", BaseWork)

function AutoChessBaseWork:ctor(effect)
	self.delayFuncMap = {}
	self.effect = effect
	self.entityMgr = AutoChessEntityMgr.instance

	if self.effect.effectType == AutoChessEnum.EffectType.NextFightStep then
		logError("异常:NextFightStep类型的数据不该出现在这里")
	end
end

function AutoChessBaseWork:onStart()
	self:finishWork()
end

function AutoChessBaseWork:onStop()
	self:clearTask()
end

function AutoChessBaseWork:onResume()
	self:finishWork()
end

function AutoChessBaseWork:onDestroy()
	self:clearTask()

	self.delayFuncMap = nil
	self.effect = nil
	self.entityMgr = nil
end

function AutoChessBaseWork:markSkillEffect(fromUid, effectId)
	self.skillFromUid = fromUid
	self.skillEffectId = effectId
end

function AutoChessBaseWork:finishWork()
	self:delDelayFunc(self.finishWork)
	self:onDone(true)
end

function AutoChessBaseWork:clearTask()
	for func, _ in pairs(self.delayFuncMap) do
		self.delayFuncMap[func] = false

		TaskDispatcher.cancelTask(func, self)
	end
end

function AutoChessBaseWork:delayCall(func, delayTime)
	if delayTime <= 0 then
		func(self)

		return
	end

	if self.delayFuncMap[func] then
		TaskDispatcher.cancelTask(func, self)
	else
		self.delayFuncMap[func] = true
	end

	TaskDispatcher.runDelay(func, self, delayTime)
end

function AutoChessBaseWork:delDelayFunc(func)
	self.delayFuncMap[func] = false
end

return AutoChessBaseWork
