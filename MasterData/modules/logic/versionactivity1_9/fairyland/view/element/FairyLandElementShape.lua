-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/element/FairyLandElementShape.lua

module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandElementShape", package.seeall)

local FairyLandElementShape = class("FairyLandElementShape", FairyLandElementBase)

function FairyLandElementShape:onInitView()
	self.stateGoDict = {}

	for k, v in pairs(FairyLandEnum.ShapeState) do
		local go = gohelper.findChild(self._go, tostring(v))

		if not gohelper.isNil(go) then
			local item = self:getUserDataTb_()

			item.go = go
			item.rootGo = gohelper.findChild(go, "root")
			item.rootAnim = item.rootGo:GetComponent(typeof(UnityEngine.Animator))
			self.stateGoDict[v] = item
		end
	end

	local state = self:getState()

	for k, v in pairs(self.stateGoDict) do
		local enabled = k == state

		gohelper.setActive(v.go, enabled)
	end
end

function FairyLandElementShape:getClickGO()
	return self._go
end

function FairyLandElementShape:refresh()
	local state = self:getState()

	for k, v in pairs(self.stateGoDict) do
		local enabled = k == state

		gohelper.setActive(v.go, enabled)

		if enabled then
			v.rootAnim:Play("open", 0, 0)
		end
	end
end

function FairyLandElementShape:getState()
	local elementId = self:getElementId()

	if FairyLandModel.instance:isFinishElement(elementId) then
		return FairyLandEnum.ShapeState.Hide
	end

	local lastId = elementId - 1
	local config = FairyLandConfig.instance:getElementConfig(lastId)

	if not config then
		return FairyLandEnum.ShapeState.CanClick
	end

	local elementType = FairyLandEnum.ConfigType2ElementType[config.type]
	local lastElement = self._elements.elementDict[lastId]

	if elementType == FairyLandEnum.ElementType.NPC then
		if lastElement then
			return FairyLandEnum.ShapeState.Hide
		end

		local puzzleIds = string.splitToNumber(config.puzzleId, "#")
		local allPass = true

		for i, v in ipairs(puzzleIds) do
			allPass = false

			local puzzleConfig = FairyLandConfig.instance:getFairlyLandPuzzleConfig(v)

			if FairyLandModel.instance:isPassPuzzle(v) and (puzzleConfig.storyTalkId == 0 or FairyLandModel.instance:isFinishDialog(puzzleConfig.storyTalkId)) then
				allPass = true
			end

			if not allPass then
				break
			end
		end

		if allPass then
			return FairyLandEnum.ShapeState.CanClick
		else
			return FairyLandEnum.ShapeState.Hide
		end
	elseif lastElement then
		local state = lastElement:getState()

		if state == FairyLandEnum.ShapeState.Hide then
			return FairyLandEnum.ShapeState.Hide
		end

		if state == FairyLandEnum.ShapeState.CanClick then
			return FairyLandEnum.ShapeState.NextCanClick
		end

		if state == FairyLandEnum.ShapeState.NextCanClick then
			return FairyLandEnum.ShapeState.LockClick
		end

		return FairyLandEnum.ShapeState.LockClick
	end

	return FairyLandEnum.ShapeState.CanClick
end

function FairyLandElementShape:onClick()
	local state = self:getState()

	if state == FairyLandEnum.ShapeState.CanClick and not self._elements:isMoveing() then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_symbol_click)
		self:setFinish()
	end
end

function FairyLandElementShape:finish()
	self:onFinish()
end

function FairyLandElementShape:onFinish()
	local item = self.stateGoDict[FairyLandEnum.ShapeState.CanClick]

	if item then
		item.rootAnim:Play("click", 0, 0)
		TaskDispatcher.runDelay(self._finishCallback, self, 1)
	end

	FairyLandModel.instance:setPos(self:getPos(), true)
	self._elements:characterMove()
end

function FairyLandElementShape:_finishCallback()
	self:onDestroy()
end

function FairyLandElementShape:onDestroyElement()
	TaskDispatcher.cancelTask(self._finishCallback, self)
end

return FairyLandElementShape
