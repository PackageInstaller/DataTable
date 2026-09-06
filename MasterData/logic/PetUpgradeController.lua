-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petupgrade/controller/PetUpgradeController.lua

module("logic.extensions.petupgrade.controller.PetUpgradeController", package.seeall)

local PetUpgradeController = class("PetUpgradeController", BaseController)

PetUpgradeController.TYPE_LVLUP = 0
PetUpgradeController.TYPE_TALENT = 1
PetUpgradeController.TYPE_STARGOD = 2
PetUpgradeController.TYPE_SOURCEMON = 3

function PetUpgradeController:ctor()
	self._cacheData = {}
	self.popEnable = true
	self.lock = false
end

function PetUpgradeController:onReset()
	self.unregisterNotify(self, GlobalNotify.BagPetAttrChanged, self.onPetPowerChange, self)
	self.registerNotify(self, GlobalNotify.BagPetAttrChanged, self.onPetPowerChange, self)

	self._cacheData = {}
end

function PetUpgradeController:onInit()
	self:onReset()
end

function PetUpgradeController:setPopEnable(boo)
	self.popEnable = boo
end

function PetUpgradeController:setLock(boo)
	self.lock = boo
end

function PetUpgradeController:onPetPowerChange(oldPet, newPet)
	local mo = BagPetsController.instance:GetCurPetMo()

	if (ViewMgr.instance:isOpen(ViewName.PetShowView) or ViewMgr.instance:isOpen(ViewName.PetUp) or ViewMgr.instance:isOpen(ViewName.PetskillsuccessView) or ViewMgr.instance:isOpen(ViewName.PetAwakeView) or ViewMgr.instance:isOpen(ViewName.PetAwakeLvupView) or ViewMgr.instance:isOpen(ViewName.PetEquipStrengthen) or ViewMgr.instance:isOpen(ViewName.StargodplusstrengthView)) and mo and oldPet and newPet and newPet.petId == mo.petId and newPet:getFightingPower() > oldPet:getFightingPower() then
		UIStateManager.instance:popByName(ViewName.PetattrpowerupView)
		UIStateManager.instance:open(ViewName.PetattrpowerupView, newPet.name, oldPet:getFightingPower(), newPet:getFightingPower())
	end
end

function PetUpgradeController:onPetChange(oldPet, newPet)
	if SceneMgr.instance.isGogingToEnterBattleScene then
		return
	end

	local petData

	if oldPet:getFightingPower() < newPet:getFightingPower() then
		petData = self:updatePet(oldPet, newPet, PetUpgradeController.TYPE_STARGOD)
	end

	if self.popEnable and (oldPet.level < newPet.level or nil) and self:updatePet(oldPet, newPet, PetUpgradeController.TYPE_LVLUP) then
		self._cacheData[oldPet.petId] = nil
	end
end

function PetUpgradeController:updatePet(oldPet, newPet, type)
	local petData = self._cacheData[oldPet.petId]

	if petData == nil then
		petData = {
			oldPet,
			newPet
		}
	else
		petData[2] = newPet
	end

	petData[3] = type
	self._cacheData[oldPet.petId] = petData

	return petData
end

function PetUpgradeController:_OnSceneChanged()
	if SceneMgr.instance.isGogingToEnterBattleScene then
		return nil
	end

	self:popAllChange()
end

function PetUpgradeController:popAllChange()
	if self.popEnable == true then
		for i, v in pairs(self._cacheData) do
			-- block empty
		end

		self._cacheData = {}
	end
end

PetUpgradeController.instance = PetUpgradeController.New()

return PetUpgradeController
