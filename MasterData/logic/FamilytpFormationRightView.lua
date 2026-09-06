-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/FamilytpFormationRightView.lua

module("logic.extensions.familyteamplay.view.FamilytpFormationRightView", package.seeall)

local FamilytpFormationRightView = class("FamilytpFormationRightView", FormationRightView)

function FamilytpFormationRightView:_bindUIEvents()
	FamilytpFormationRightView.super._bindUIEvents(self)
end

function FamilytpFormationRightView:_unbindUIEvents()
	FamilytpFormationRightView.super._unbindUIEvents(self)
end

function FamilytpFormationRightView:onEnter()
	FamilytpFormationRightView.super.onEnter(self)

	self._petlimitLv = FamilyteamplayConfig.instance:getPetLimitLv()
	self.tiredGoCloneTrigger = {}

	local params = self:getOpenParam()

	self._tpType = params[3] or FamilyteamplayController.teamPlayType.Common
end

function FamilytpFormationRightView:onExit()
	FamilytpFormationRightView.super.onExit(self)
end

function FamilytpFormationRightView:_clearTableview()
	for k, v in pairs(self.tiredGoCloneTrigger) do
		self.tiredGoCloneTrigger[k]:RemoveClickListener()

		self.tiredGoCloneTrigger[k] = nil
	end
end

function FamilytpFormationRightView:_updateCell(view, cell, data)
	local component = ItemPet.AddOnce(cell.gameObject)

	self:updateForbit(data)
	component:Init(data)
	component:setSelected(false)

	local inTeam = self:getInTeam(data)

	component:SetInTeam(inTeam)

	if FamilyteamplayModel.instance:isFatiguePetId(data.petId, self._tpType) then
		local tiredGoClone = goutil.findChild(cell.gameObject, "tiredGo")

		if not tiredGoClone then
			local tiredGo = FamilyteamplayController.instance:getBtnTiredGo()

			if tiredGo then
				tiredGoClone = goutil.clone(tiredGo, "tiredGo")

				goutil.addChildToParent(tiredGoClone, cell.gameObject.transform)
			end
		end

		tiredGoClone:SetActive(true)
		tiredGoClone.transform:SetAsLastSibling()

		self.tiredGoCloneTrigger[tiredGoClone] = Framework.UIClickTrigger.Get(tiredGoClone)

		self.tiredGoCloneTrigger[tiredGoClone]:AddClickListener(function()
			FloatWordMgr.instance:show(lang("world_Boss_tip5"))
		end, self)
	else
		local tiredGoClone = goutil.findChild(cell.gameObject, "tiredGo")

		if tiredGoClone then
			tiredGoClone:SetActive(false)
		end
	end
end

function FamilytpFormationRightView:_updateView()
	self._tableview:ReloadData()
end

function FamilytpFormationRightView:_OnDragPetBegin(go, data)
	local pet = ItemPet.Get(go):GetData()
	local petId = pet.petId

	if petId <= 0 then
		return
	end

	if FamilyteamplayModel.instance:isFatiguePetId(petId, self._tpType) then
		FloatWordMgr.instance:show(lang("world_Boss_tip5"))

		self._dragging = nil

		self._tableview:GetScrollRect():OnBeginDrag(data)
		self._tableview:OnBeginDrag(data)

		return
	elseif pet:getPetLv() < self._petlimitLv then
		FloatWordMgr.instance:show("需上阵大于等于" .. self._petlimitLv .. "级的精灵")

		self._dragging = nil

		self._tableview:GetScrollRect():OnBeginDrag(data)
		self._tableview:OnBeginDrag(data)
	else
		FamilytpFormationRightView.super._OnDragPetBegin(self, go, data)
	end
end

function FamilytpFormationRightView:onFilter(pet)
	if pet:getPetLv() < self._petlimitLv then
		return false
	end

	return (FamilytpFormationRightView.super.onFilter(self, pet))
end

return FamilytpFormationRightView
