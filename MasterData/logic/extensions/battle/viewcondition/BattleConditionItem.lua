-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcondition/BattleConditionItem.lua

module("logic.extensions.battle.viewcondition.BattleConditionItem", package.seeall)

local BattleConditionItem = class("BattleConditionItem")
local kDuration = 0.2

function BattleConditionItem:ctor(mainGO)
	self.mainGO = mainGO

	self:buildUI()
end

function BattleConditionItem:destroy()
	self:destroyUI()
	goutil.destroy(self.mainGO)

	self.mainGO = false
end

function BattleConditionItem:buildUI()
	self._txtDesc1 = goutil.findChildTextComponent(self.mainGO, "txtDesc1")
	self._txtDesc2 = goutil.findChildTextComponent(self.mainGO, "txtDesc2")
	self._transformDesc = self._txtDesc2.transform
	self._canvasGroupDesc = goutil.addComponentOnce(self._txtDesc2.gameObject, ComponentType.CanvasGroup)
	self._timelineTask = TimelineTask.New()
	self._tag = false
end

function BattleConditionItem:destroyUI()
	self._timelineTask:clear()

	self._timelineTask = nil
	self._txtDesc1 = nil
	self._txtDesc2 = nil
	self._transformDesc = nil
	self._canvasGroupDesc = nil
end

function BattleConditionItem:setTag(tag)
	self._tag = tag
end

function BattleConditionItem:getTag()
	return self._tag
end

function BattleConditionItem:setContent(content)
	self:stopAnimation()

	self._txtDesc1.text = content
	self._txtDesc2.text = content
end

function BattleConditionItem:getHeight()
	return RectTransformUtils.GetHeight(self._txtDesc1.transform)
end

function BattleConditionItem:flyout(delay)
	self._timelineTask:clear()
	self._timelineTask:addTask(delay, self._tOut_Part1, self)
	self._timelineTask:addTask(kDuration, self._tOut_Part2, self)
	self._timelineTask:start()
end

function BattleConditionItem:flyin(delay)
	self._timelineTask:clear()
	self._timelineTask:addTask(delay, self._tIn_Part1, self)
	self._timelineTask:addTask(kDuration)
	self._timelineTask:start()
end

function BattleConditionItem:flyTo(delay, deltaY)
	self._timelineTask:clear()
	self._timelineTask:addTask(delay, self._tTo_Part1, self)
	self._timelineTask:addTask(kDuration)
	self._timelineTask:start(deltaY)
end

function BattleConditionItem:stopAnimation()
	self._timelineTask:clear()
	self._transformDesc:DOKill(true)

	self._canvasGroupDesc.alpha = 1

	Astral.TransformUtil.SetAnchoredPos(self._transformDesc, 0, 0)
end

function BattleConditionItem:_tTo_Part1(deltaY)
	Astral.TransformUtil.SetAnchoredPos(self._transformDesc, 0, 0)
	self._transformDesc:DOAnchorPosY(deltaY, kDuration, false):SetTarget(self._transformDesc)
end

function BattleConditionItem:_tIn_Part1()
	self._canvasGroupDesc.alpha = 0

	Astral.TransformUtil.SetAnchoredPos(self._transformDesc, 0, -10)
	self._canvasGroupDesc:DOFade(1, kDuration):SetTarget(self._transformDesc)
	self._transformDesc:DOAnchorPosY(0, kDuration, false):SetTarget(self._transformDesc)
end

function BattleConditionItem:_tOut_Part1()
	self._transformDesc:DOAnchorPosX(-20, kDuration, false):SetTarget(self._transformDesc)
end

function BattleConditionItem:_tOut_Part2()
	self._canvasGroupDesc:DOFade(0, kDuration):SetTarget(self._transformDesc)
	self._transformDesc:DOAnchorPosX(30, kDuration, false):SetTarget(self._transformDesc)
end

return BattleConditionItem
