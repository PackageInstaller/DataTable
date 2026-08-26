-- chunkname: @modules/logic/pcInput/activityAdapter/BattleActivityAdapter.lua

module("modules.logic.pcInput.activityAdapter.BattleActivityAdapter", package.seeall)

local BattleActivityAdapter = class("BattleActivityAdapter", BaseActivityAdapter)

BattleActivityAdapter.skillSelectKey = {
	21,
	22
}
BattleActivityAdapter.keytoFunction = {
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleOpenEnemyInfo)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleOpentips)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSpeedUp)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleAutoFight)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelect, 1)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelect, 2)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectLeft)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectRight)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 1)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 2)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 3)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 4)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 5)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 6)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 7)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 8)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 9)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleMoveCardEnd)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleBackPack)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSkillOpen)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSkillIndex, 1)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSkillIndex, 2)
	end
}

function BattleActivityAdapter:ctor()
	BaseActivityAdapter.ctor(self)

	self.keytoFunction = BattleActivityAdapter.keytoFunction
	self.activitid = PCInputModel.Activity.battle

	self:registerFunction()
end

function BattleActivityAdapter:OnkeyUp(keyName)
	local config = PCInputModel.instance:getkeyconfigBykeyName(PCInputModel.Activity.battle, keyName)

	if not config then
		return
	end

	if ViewMgr.instance:IsPopUpViewOpen() then
		return
	end

	if GuideModel.instance:isDoingClickGuide() or not GuideModel.instance:isGuideFinish(102) then
		return
	end

	BaseActivityAdapter.OnkeyUp(self, keyName)
end

function BattleActivityAdapter:OnkeyDown(keyName)
	local config = PCInputModel.instance:getkeyconfigBykeyName(PCInputModel.Activity.battle, keyName)

	if not config then
		return
	end

	if ViewMgr.instance:IsPopUpViewOpen() then
		return
	end

	if GuideModel.instance:isDoingClickGuide() or not GuideModel.instance:isGuideFinish(102) then
		return
	end

	BaseActivityAdapter.OnkeyDown(self, keyName)
end

return BattleActivityAdapter
