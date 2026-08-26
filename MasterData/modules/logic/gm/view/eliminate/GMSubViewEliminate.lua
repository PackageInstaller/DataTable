-- chunkname: @modules/logic/gm/view/eliminate/GMSubViewEliminate.lua

module("modules.logic.gm.view.eliminate.GMSubViewEliminate", package.seeall)

local GMSubViewEliminate = class("GMSubViewEliminate", GMSubViewBase)

function GMSubViewEliminate:ctor()
	self.tabName = "三消"
end

function GMSubViewEliminate:addLineIndex()
	self.lineIndex = self.lineIndex + 1
end

function GMSubViewEliminate:getLineGroup()
	return "L" .. self.lineIndex
end

function GMSubViewEliminate:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)

	self.lineIndex = 1

	self:addTitleSplitLine("冷周六玩法")
	self:addLineIndex()

	self._textLevel = self:addInputText(self:getLineGroup(), "1270209")

	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "进入玩法", self.enterGame, self)
	self.addButton(self, self:getLineGroup(), "打乱棋盘", self.randomCell, self)
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "随机石化", self.petrifyEliminationBlock, self)
	self.addButton(self, self:getLineGroup(), "随机冰冻", self.freezeEliminationBlock, self)
	self.addButton(self, self:getLineGroup(), "随机致盲", self.contaminate, self)
	self:addLineIndex()

	self._textBuff = self:addInputText(self:getLineGroup(), "1,1")

	self.addButton(self, self:getLineGroup(), "指定冰冻", self.addBuff, self)
	self:addLineIndex()

	self._textChangeIndex = self:addInputText(self:getLineGroup(), "1,1")
	self._typeDropDown = self.addDropDown(self, self:getLineGroup(), "棋子类型：", EliminateEnum_2_7.AllChessType, self._onLangDropChange, self)

	self.addButton(self, self:getLineGroup(), "修改棋子类型", self.changeChessType, self)
	self:addLineIndex()

	self._textChangeStrongIndex = self:addInputText(self:getLineGroup(), "1,1")

	self.addButton(self, self:getLineGroup(), "强化棋子", self.changeToStrong, self)
	self:addLineIndex()

	self._textChangeDieSpeed = self:addInputText(self:getLineGroup(), "0.3")

	self.addButton(self, self:getLineGroup(), "修改棋子死亡步骤时间", self.changeDieSpeed, self)
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "测试随机棋子【100】", self.testRound, self)
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "完成玛丽安娜玩法", self.finishMaLiAnNa, self)
end

function GMSubViewEliminate:initEliminate()
	local data = {}

	data[1] = {
		1,
		3,
		2,
		5,
		4,
		1
	}
	data[2] = {
		2,
		4,
		5,
		3,
		1,
		2
	}
	data[3] = {
		3,
		1,
		4,
		2,
		5,
		3
	}
	data[4] = {
		4,
		2,
		5,
		1,
		3,
		4
	}
	data[5] = {
		5,
		3,
		1,
		4,
		2,
		5
	}
	data[6] = {
		1,
		4,
		2,
		5,
		3,
		1
	}

	LocalEliminateChessModel.instance:initByData(data)
end

function GMSubViewEliminate:eliminateEx()
	local str = self._textEx:GetText()
	local arr = string.split(str, ",")

	if #arr ~= 4 then
		return
	end

	local x1 = tonumber(arr[1])
	local y1 = tonumber(arr[2])
	local x2 = tonumber(arr[3])
	local y2 = tonumber(arr[4])

	LocalEliminateChessModel.instance:exchangeCell(x1, y1, x2, y2)
end

function GMSubViewEliminate:addBuff()
	local str = self._textBuff:GetText()
	local arr = string.split(str, ",")

	if #arr ~= 2 then
		return
	end

	local x = tonumber(arr[1])
	local y = tonumber(arr[2])

	LocalEliminateChessModel.instance:changeCellState(x, y, EliminateEnum.ChessState.Frost)

	local data = {
		x = x,
		y = y
	}
	local updateStateWork = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ChangeState, data)

	LengZhou6EliminateController.instance:buildSeqFlow(updateStateWork)

	local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateCheckAndRefresh)

	LengZhou6EliminateController.instance:buildSeqFlow(step)
	LengZhou6EliminateController.instance:setFlowEndState(true)
end

function GMSubViewEliminate:enterGame()
	LengZhou6Enum.enterGM = true
	LengZhou6Model.instance._activityId = 12702

	local episodeId = tonumber(self._textLevel:GetText())

	LengZhou6Model.instance:setCurEpisodeId(episodeId)
	LengZhou6Controller.instance:_enterGame(episodeId)
end

function GMSubViewEliminate:randomCell()
	local randomList = LocalEliminateChessModel.instance:randomCell()

	LengZhou6EliminateController.instance:updateAllItemPos(randomList)
end

function GMSubViewEliminate:eliminateCross()
	LocalEliminateChessModel.instance:eliminateCross(4, 4)

	local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, false)

	LengZhou6EliminateController.instance:buildSeqFlow(step)
end

function GMSubViewEliminate:eliminateRange()
	LocalEliminateChessModel.instance:eliminateRange(3, 4, 3)

	local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, false)

	LengZhou6EliminateController.instance:buildSeqFlow(step)
end

function GMSubViewEliminate:petrifyEliminationBlock()
	LengZhou6EffectUtils.instance._petrifyEliminationBlock({
		"PetrifyEliminationBlock",
		2
	})

	local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateCheckAndRefresh)

	LengZhou6EliminateController.instance:buildSeqFlow(step)
end

function GMSubViewEliminate:freezeEliminationBlock()
	LengZhou6EffectUtils.instance._freezeEliminationBlock({
		"FreezeEliminationBlock",
		2
	})

	local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateCheckAndRefresh)

	LengZhou6EliminateController.instance:buildSeqFlow(step)
end

function GMSubViewEliminate:contaminate()
	LengZhou6EffectUtils.instance._contaminate({
		"Contaminate",
		2
	})

	local step = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.CheckEliminate, false)

	LengZhou6EliminateController.instance:buildSeqFlow(step)
end

function GMSubViewEliminate:generateUnsolvableBoard()
	LocalEliminateChessUtils.instance.generateUnsolvableBoard(6, 6)
end

function GMSubViewEliminate:testRound()
	LocalEliminateChessModel.instance:testRound()
end

function GMSubViewEliminate:_onLangDropChange()
	return
end

function GMSubViewEliminate:changeChessType()
	local str = self._textChangeIndex:GetText()
	local arr = string.split(str, ",")

	if #arr ~= 2 then
		return
	end

	local x = tonumber(arr[1])
	local y = tonumber(arr[2])
	local index = self._typeDropDown:GetValue()
	local type = EliminateEnum_2_7.AllChessType[index + 1]

	LengZhou6EliminateController.instance:changeCellType(x, y, type)
end

function GMSubViewEliminate:changeToStrong()
	local str = self._textChangeStrongIndex:GetText()
	local arr = string.split(str, ",")

	if #arr ~= 2 then
		return
	end

	local x = tonumber(arr[1])
	local y = tonumber(arr[2])

	LengZhou6EliminateController.instance:changeCellState(x, y, EliminateEnum.ChessState.SpecialSkill)
end

function GMSubViewEliminate:changeDieSpeed()
	local str = self._textChangeDieSpeed:GetText()

	EliminateEnum_2_7.DieStepTime = tonumber(str)
end

function GMSubViewEliminate:beginMaLiAnNa()
	local str = self._txtMaliAnNa:GetText()

	Activity201MaLiAnNaGameController.instance:enterGame(tonumber(str))
end

function GMSubViewEliminate:stopMaLiAnNa()
	Activity201MaLiAnNaGameController.instance:exitGame()
end

function GMSubViewEliminate:finishMaLiAnNa()
	Activity201MaLiAnNaGameController.instance:finishGame()
end

return GMSubViewEliminate
