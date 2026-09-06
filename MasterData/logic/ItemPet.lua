-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/item/ItemPet.lua

module("logic.extensions.bag.view.item.ItemPet", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local ItemPet = class("ItemPet")

ItemPet.ResPath = "ui/views/common/item_pet.prefab"
ItemPet.Events = {}
ItemPet.Events.Click = "ItemPet.Events.Click"
ItemPet.Events.Press = "ItemPet.Events.Press"
ItemPet.Events.GuideClick = "ItemPet.Events.GuideClick"

function ItemPet.AddOnce(go)
	local component = ItemPet.Get(go)

	component = component or LuaComponentContainer.Add(go, ItemPet)

	return component
end

function ItemPet.Remove(go)
	LuaComponentContainer.Remove(go, ItemPet)
end

function ItemPet.Get(go)
	return (LuaComponentContainer.Get(go, ItemPet))
end

function ItemPet:ctor(target)
	NotifyDispatcher.extend(self)

	self._target = target.gameObject
	self._data = nil
	self._isInTeam = false
end

function ItemPet:Init(pet)
	if self._data and self._data ~= pet then
		-- block empty
	end

	self._data = pet
	self.proxy = nil

	MaterialMgr.resetAll(self._target)

	local isEmpty = not pet

	if isEmpty then
		return
	end

	self.proxy = MaterialMgr.setCellByData(MatType.Pet, pet, self._target)

	if self.proxy then
		self.proxy.binder:setCallBack(GameUtil.handler(self._OnClick, self))
		self.proxy.binder:showHireInfo()

		local isYuan = PetSkinConfig.instance:getFisrtEleAttrIdx(pet.curFaceId) == GameEnum.RaceType.Yuan
		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(pet.curFaceId)
		local isShenshi = skinCfg and checknumber(skinCfg.oracleSkillId) > 0
		local hasBookSpirit = ContractConfig.instance:getBookSpiritCfgs(pet.raceId) ~= nil

		if pet.isMyPackPet then
			local hasBody = PetSkinConfig.instance:checkHasMutiBody(pet.raceId)

			self.proxy.binder:setTagShow(hasBody or isYuan or isShenshi or hasBookSpirit)
		else
			self.proxy.binder:setTagShow(isYuan)
		end

		self.proxy.binder:setEffGainAllSkin(pet)
	end

	self:setGray(pet.forbit)
end

function ItemPet:setGray(isGray)
	if self.proxy then
		self.proxy.binder:setGray(isGray)
	end
end

function ItemPet:setContractTag(masterId, summonId)
	if self.proxy then
		self.proxy.binder:setContractTag(masterId, summonId)
	end
end

function ItemPet:setUseLock(useLock)
	if self.proxy then
		self.proxy.binder:setUseLock(useLock)
	end
end

function ItemPet:setPetIsDead(isDead)
	if self.proxy then
		self.proxy.binder:setPetIsDead(isDead)
	end
end

function ItemPet:setSupportPet(isShow)
	if self.proxy then
		self.proxy.binder:setSupportPet(isShow)
	end
end

function ItemPet:OnDestroy()
	if self._data then
		self._data:resetCellStatus()
	end

	self:removeAllListener(ItemPet.Events.Click)
	MaterialMgr.resetAll(self._target)

	self._data = nil
end

function ItemPet:_OnClick()
	self:dispatch(ItemPet.Events.GuideClick, self._data)
	self:dispatch(ItemPet.Events.Click, self._data)
end

function ItemPet:setSelected(isSelected)
	return
end

function ItemPet:SetInTeam(boo)
	self._isInTeam = not not boo

	if self.proxy then
		self.proxy.binder:SetInTeam(boo)
	end
end

function ItemPet:isInTeam()
	return self._isInTeam
end

function ItemPet:GetData()
	return self._data
end

function ItemPet:GetTarget()
	return self._target
end

function ItemPet:setFormConditionLabel(str)
	if self.proxy then
		self.proxy.binder:setFormConditionLabel(str)
	end
end

return ItemPet
