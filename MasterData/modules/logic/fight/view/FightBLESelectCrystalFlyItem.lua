-- chunkname: @modules/logic/fight/view/FightBLESelectCrystalFlyItem.lua

module("modules.logic.fight.view.FightBLESelectCrystalFlyItem", package.seeall)

local FightBLESelectCrystalFlyItem = class("FightBLESelectCrystalFlyItem", UserDataDispose)

function FightBLESelectCrystalFlyItem:initItem(goFly, goFlyScript, flyMgr)
	self:__onInit()

	self.flyMgr = flyMgr
	self.goFlyScript = gohelper.cloneInPlace(goFlyScript)
	self.flyScript = self.goFlyScript:GetComponent(typeof(UnityEngine.UI.UIFlying))

	self.flyScript:SetAllFlyItemDoneCallback(self.onAllFlyDone, self)
	self.flyScript:SetEventCallback(self.onEventCallback, self)
	self.flyScript:SetFlyItemObj(goFly)

	self.flyScript.emitCount = 1
	self.crystal = FightEnum.CrystalEnum.None
	self.startIndex = 0
	self.targetIndex = 0
end

function FightBLESelectCrystalFlyItem:startFly(startPos, endPos, doneCallback, eventCallback, callbackObj)
	gohelper.setActive(self.goFlyScript, true)

	self.doneCallback = doneCallback
	self.eventCallback = eventCallback
	self.callbackObj = callbackObj
	self.flyScript.startPosition = startPos
	self.flyScript.endPosition = endPos

	self.flyScript:StartFlying()
end

function FightBLESelectCrystalFlyItem:onAllFlyDone()
	self.flyMgr:onItemFlyDone(self)

	if self.doneCallback then
		self.doneCallback(self.callbackObj, self)
	end
end

function FightBLESelectCrystalFlyItem:onEventCallback(param, event, index)
	if self.eventCallback then
		self.eventCallback(self.callbackObj, self, event, index)
	end
end

function FightBLESelectCrystalFlyItem:stopFly()
	self.flyScript:StopAllFlying()
end

function FightBLESelectCrystalFlyItem:destroy()
	if self.flyScript then
		self.flyScript:RemoveAllCallback()
		self.flyScript:StopAllFlying()

		self.flyScript = nil
	end

	self.doneCallback = nil
	self.eventCallback = nil
	self.callbackObj = nil

	self:__onDispose()
end

return FightBLESelectCrystalFlyItem
