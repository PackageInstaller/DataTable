-- chunkname: @modules/logic/versionactivity2_6/xugouji/controller/XugoujiGameStepController.lua

module("modules.logic.versionactivity2_6.xugouji.controller.XugoujiGameStepController", package.seeall)

local XugoujiGameStepController = class("XugoujiGameStepController", BaseController)

function XugoujiGameStepController:ctor()
	self._stepList = {}
	self._stepPool = nil
	self._curStep = nil
	self.muteAutoNext = false
end

function XugoujiGameStepController:insertStepList(serverData)
	Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.UnOperatable)

	local len = #serverData

	for i = 1, len do
		local stepData = serverData[i]

		self:insertStep(stepData)
	end
end

function XugoujiGameStepController:insertStep(serverData)
	local step = self:buildStep(serverData)

	if step then
		self._stepList = self._stepList or {}

		table.insert(self._stepList, step)
	end

	if self._curStep == nil then
		self:nextStep()
	end
end

function XugoujiGameStepController:insertStepListClient(clientStepList, atFirst)
	local len = #clientStepList

	for i = 1, len do
		local step = self:buildStepClient(clientStepList[i])

		if step then
			self._stepList = self._stepList or {}

			if atFirst then
				table.insert(self._stepList, i, step)
			else
				table.insert(self._stepList, step)
			end
		end

		if self._curStep == nil then
			self:nextStep()
		end
	end
end

XugoujiGameStepController.StepClzMap = {
	[XugoujiEnum.GameStepType.HpUpdate] = XugoujiGameStepHpUpdate,
	[XugoujiEnum.GameStepType.UpdateCardStatus] = XugoujiGameStepCardUpdate,
	[XugoujiEnum.GameStepType.Result] = XugoujiGameStepResult,
	[XugoujiEnum.GameStepType.ChangeTurn] = XugoujiGameStepChangeTurn,
	[XugoujiEnum.GameStepType.NewCards] = XugoujiGameStepNewCards,
	[XugoujiEnum.GameStepType.GotCardPair] = XugoujiGameStepPairsUpdate,
	[XugoujiEnum.GameStepType.OperateNumUpdate] = XugoujiGameStepOperateNumUpdate,
	[XugoujiEnum.GameStepType.BuffUpdate] = XugoujiGameStepBuffUpdate,
	[XugoujiEnum.GameStepType.UpdateCardEffectStatus] = XugoujiGameStepCardEffectStatue,
	[XugoujiEnum.GameStepType.WaitGameStart] = XugoujiGameStepWaitGameStart,
	[XugoujiEnum.GameStepType.UpdateInitialCard] = XugoujiGameStepInitialCard,
	[XugoujiEnum.GameStepType.GameReStart] = XugoujiGameStepGameReStart
}

function XugoujiGameStepController:buildStep(serverData)
	local data = cjson.decode(serverData.param)

	if data.stepType == XugoujiEnum.GameStepType.HpUpdate then
		local isSelf = data.isSelf
		local hpChangeValue = data.hpChange

		if isSelf then
			Activity188Model.instance:checkHpZero(hpChangeValue)
		end
	end

	local stepClz = XugoujiGameStepController.StepClzMap[data.stepType]

	if stepClz then
		local stepObj

		self._stepPool = self._stepPool or {}

		if self._stepPool[stepClz] ~= nil and #self._stepPool[stepClz] >= 1 then
			local len = #self._stepPool[stepClz]

			stepObj = self._stepPool[stepClz][len]
			self._stepPool[stepClz][len] = nil
		else
			stepObj = stepClz.New()
		end

		stepObj:init(data)

		return stepObj
	end
end

function XugoujiGameStepController:buildStepClient(stepData)
	local stepClz = XugoujiGameStepController.StepClzMap[stepData.stepType]

	if stepClz then
		local stepObj

		self._stepPool = self._stepPool or {}

		if self._stepPool[stepClz] ~= nil and #self._stepPool[stepClz] >= 1 then
			local len = #self._stepPool[stepClz]

			stepObj = self._stepPool[stepClz][len]
			self._stepPool[stepClz][len] = nil
		else
			stepObj = stepClz.New()
		end

		stepObj:init(stepData)

		return stepObj
	end
end

function XugoujiGameStepController:nextStep()
	self:recycleCurStep()

	self._doingStepAction = self._stepList and #self._stepList > 0

	if not self._doingStepAction then
		Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.Operatable)
	end

	if not self._isStepStarting then
		self._isStepStarting = true

		while self._curStep == nil and self._stepList and #self._stepList > 0 do
			self._curStep = self._stepList[1]

			table.remove(self._stepList, 1)
			self._curStep:start()
		end

		self._isStepStarting = false
	end
end

function XugoujiGameStepController:recycleCurStep()
	if self._curStep then
		self._curStep:dispose()

		self._stepPool[self._curStep.class] = self._stepPool[self._curStep.class] or {}

		table.insert(self._stepPool[self._curStep.class], self._curStep)

		self._curStep = nil
	end
end

function XugoujiGameStepController:disposeAllStep()
	if self._curStep then
		self._curStep:dispose()

		self._curStep = nil
	end

	if self._stepList then
		for _, step in pairs(self._stepList) do
			step:dispose()
		end

		self._stepList = nil
	end

	self._stepPool = nil
	self._isStepStarting = false
end

function XugoujiGameStepController:clear()
	self._stepList = nil
	self._curStep = nil

	self:disposeAllStep()
end

XugoujiGameStepController.instance = XugoujiGameStepController.New()

return XugoujiGameStepController
