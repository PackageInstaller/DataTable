-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/preface/flow/PrefaceFlow.lua

module("logic.extensions.preface.flow.PrefaceFlow", package.seeall)

local M = class("PrefaceFlow")

function M:ctor()
	self._compList = {}
	self._workingWork = false

	self:_registerComponents()
end

function M:enter(info)
	local work = self:_createWork()

	work:setDoneCaller(self._onEnterFinish, self)

	local sequence = FlowSequence.New()
	local hasFinishStages = PlayerModel.instance:getPrologueStages()
	local len = #hasFinishStages

	if len > 0 then
		self:_simulationUpdateSystem(true)

		for i = 1, len do
			sequence:addChild(PrefaceWorkInitData.New())

			if info.showLoading then
				sequence:addChild(WorkShowLoading.New())
			end

			sequence:addChild(PrefaceWorkShowPlotBeforeBattle.New())
			sequence:addChild(PrefaceBattleWorkStartBattle.New())
			sequence:addChild(PrefaceBattleWorkAfterBattle.New())

			if i == len then
				sequence:addChild(PrefaceBattleWorkExit.New(true))
			end
		end
	else
		sequence:addChild(PrefaceBattleWorkExit.New(false))
	end

	work:addChild(sequence)
	work:start(self)
end

function M:_simulationUpdateSystem(isOpen)
	SystemOpenFacade.instance:simulationUpdateSystem(GameEnum.SystemEnum.FightSpecialSkill, isOpen)
	SystemOpenFacade.instance:simulationUpdateSystem(GameEnum.SystemEnum.FightTrumpSkill, isOpen)
	SystemOpenFacade.instance:simulationUpdateSystem(GameEnum.SystemEnum.FightSanStrengthen, isOpen)
end

function M:exit()
	return
end

function M:_registerComponents()
	self:_addComponent("model", PrefaceModel)
end

function M:_onEnterFinish(result)
	if result ~= WorkResult.Succeed then
		printError("enterPrefaceBattlefalse")

		return
	end

	PlayerModel.instance:setPrologueFinished(true)
	PrefaceController.instance:clearPrefaceBattleFlow()
end

function M:simulationCloseSystem()
	self:_simulationUpdateSystem(false)
end

function M:_createWork()
	self:_destroyWork()

	self._workingWork = WorkFlow.New()

	return self._workingWork
end

function M:_destroyWork()
	if self._workingWork then
		self._workingWork:destroy()

		self._workingWork = false
	end
end

function M:clearWork()
	self:_destroyWork()
end

function M:_notifyComponents(functionName)
	for _, component in pairs(self._compList) do
		local func = component[functionName]

		if func then
			func(component)
		end
	end
end

function M:_addComponent(compName, compClass)
	local compInst = compClass.New()

	self[compName] = compInst
	compInst.flow = self

	table.insert(self._compList, compInst)
end

function M:_removeComponent(compName)
	local compInst = self[compName]

	if compInst then
		self[compName] = nil

		table.removebyvalue(self._compList, compInst, true)
	end
end

function M:internal_NotifyComponent(functionName)
	self:_notifyComponents(functionName)
end

return M
