-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsidehint/BattleSideHintView.lua

module("logic.extensions.battle.viewsidehint.BattleSideHintView", package.seeall)

local M = class("BattleSideHintView", ViewComponent)
local kDuration = 3

function M:buildUI()
	local goHintItem = self:getGoByPath("hint1")

	self._animation = goutil.addComponentOnce(goHintItem, ComponentType.Animation)
	self._hintItem = Astral.SimpleLuaComponentContainer.Add(goHintItem, BattleSideHintItem)
	self._timeWaiter = TimeWaiter.New()
	self._dungeonStarCodes = {}
end

function M:destroyUI()
	self._hintItem:destroy()
	self._timeWaiter:destroy()

	self._animation = nil
	self._hintItem = nil
	self._dungeonStarCodes = nil
end

function M:onEnter()
	BattleSideHintViewFacade.instance:registerView(self)
	self:_setEvent(true)
	self:_tryShowNextHintItem()
	self:_onBattleSpeedUpdate()
end

function M:onExit()
	BattleSideHintViewFacade.instance:unregisterView()
	self:_setEvent(false)
	self._hintItem:hide()
	self._timeWaiter:clear()
end

function M:showHint(dungeonStarCode)
	table.insert(self._dungeonStarCodes, dungeonStarCode)
	self:_tryShowNextHintItem()
end

function M:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnBattleSpeedUpdate, self._onBattleSpeedUpdate, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleSpeedUpdate, self._onBattleSpeedUpdate, self)
	end
end

function M:_tryShowNextHintItem()
	local dungeonStarCode = table.remove(self._dungeonStarCodes, 1)

	if dungeonStarCode then
		self._timeWaiter:start(kDuration, self._tryShowNextHintItem, self)
		self._timeWaiter:setTimeScale(BattleTime.timeScale)
		self._hintItem:setDungeonStarCode(dungeonStarCode)
		self._hintItem:show()
	else
		self._hintItem:hide()
		self._timeWaiter:clear()
	end
end

function M:_onBattleSpeedUpdate()
	AnimationUtils.SetPlaySpeed(self._animation, BattleTime.timeScale)
end

return M
