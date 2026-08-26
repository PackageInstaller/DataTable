-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/puzzle/FairyLandPuzzles.lua

module("modules.logic.versionactivity1_9.fairyland.view.puzzle.FairyLandPuzzles", package.seeall)

local FairyLandPuzzles = class("FairyLandPuzzles", BaseView)

function FairyLandPuzzles:onInitView()
	self.goPuzzle = gohelper.findChild(self.viewGO, "main/#go_Root/#go_Puzzle")
	self.goText = gohelper.findChild(self.viewGO, "main/#go_Root/#go_Text")
	self.animText = self.goText:GetComponent(typeof(UnityEngine.Animator))

	self:setTextVisible(true)
end

function FairyLandPuzzles:addEvents()
	self.addEventCb(self, FairyLandController.instance, FairyLandEvent.SetTextBgVisible, self.setTextVisible, self)
	self.addEventCb(self, FairyLandController.instance, FairyLandEvent.ElementFinish, self.refreshView, self)
	self.addEventCb(self, FairyLandController.instance, FairyLandEvent.DialogFinish, self.refreshView, self)
	self.addEventCb(self, FairyLandController.instance, FairyLandEvent.ElementLoadFinish, self.refreshView, self)
	self.addEventCb(self, FairyLandController.instance, FairyLandEvent.ResolveSuccess, self.refreshView, self)
end

function FairyLandPuzzles:removeEvents()
	return
end

function FairyLandPuzzles:refreshView()
	local puzzleId = FairyLandModel.instance:getCurPuzzle()

	self:changePuzzle(puzzleId)
end

function FairyLandPuzzles:changePuzzle(puzzleId)
	if puzzleId == self.puzzleId then
		return
	end

	self.puzzleId = puzzleId

	local compId = self:getCompId(puzzleId)
	local puzzleConfig = FairyLandConfig.instance:getFairlyLandPuzzleConfig(puzzleId)

	if self.compId == compId then
		if self.puzzleComp then
			self.puzzleComp:refresh(puzzleConfig)
		end

		return
	end

	self.compId = compId

	self:closePuzzle()
	self:startPuzzle(puzzleConfig)
end

function FairyLandPuzzles:startPuzzle(config)
	if not config then
		if FairyLandModel.instance:isPuzzleAllStepFinish(10) then
			self:setTextVisible(false)
		else
			self:setTextVisible(true)
		end

		return
	end

	local clsName = "FairyLandPuzzle" .. tostring(self.compId)
	local cls = _G[clsName]

	self.puzzleComp = cls.New()

	local param = {
		config = config,
		viewGO = self.viewGO
	}

	self.puzzleComp:init(param)
	self:setTextVisible(false)
end

function FairyLandPuzzles:getCompId(puzzleId)
	if puzzleId > 3 then
		return 4
	end

	return puzzleId
end

function FairyLandPuzzles:closePuzzle()
	if self.puzzleComp then
		self.puzzleComp:destory()

		self.puzzleComp = nil
	end
end

function FairyLandPuzzles:setTextVisible(visible)
	visible = not not visible

	if self.textVisible == visible then
		return
	end

	self.textVisible = visible

	if visible then
		gohelper.setActive(self.goText, false)
		gohelper.setActive(self.goText, true)
	else
		self.animText:Play("close")
	end
end

function FairyLandPuzzles:onDestroyView()
	self:closePuzzle()
end

return FairyLandPuzzles
