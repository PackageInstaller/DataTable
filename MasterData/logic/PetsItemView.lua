-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petshandbook/view/PetsItemView.lua

module("logic.extensions.petshandbook.view.PetsItemView", package.seeall)

local PetsItemView = class("PetsItemView", ItemPet)

function PetsItemView.AddOnce(go)
	local component = PetsItemView.Get(go)

	component = component or Framework.LuaComponentContainer.Add(go, PetsItemView)

	return component
end

function PetsItemView:Init(pet, ignore)
	self._data = pet

	local isEmpty = not pet

	self:setGray(false)

	self.proxy = nil

	MaterialMgr.resetAll(self._target)

	if isEmpty then
		return
	end

	self.proxy = MaterialMgr.setCell(MatType.Pet, pet.raceId, self._target)

	if self.proxy then
		self.proxy.binder:setCallBack(GameUtil.handler(self._OnClick, self))
	end

	if not PetsHandBookModel.instance:isHasPet(self._data.raceId) then
		self:setGray(true)
	else
		self:setGray(false)
	end
end

function PetsItemView:OnSelectPetChanged(newData)
	if not self._data then
		return
	end

	self:setSelected(self._data.raceId == newData.raceId)
end

function PetsItemView:setGray(isGray)
	uGuiUtil.setImageGrayStateRecursive(self._target, isGray)
end

return PetsItemView
