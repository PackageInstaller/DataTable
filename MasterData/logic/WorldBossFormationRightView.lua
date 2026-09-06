-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/view/WorldBossFormationRightView.lua

module("logic.extensions.worldboss.view.WorldBossFormationRightView", package.seeall)

local WorldBossFormationRightView = class("WorldBossFormationRightView", FormationRightView)

function WorldBossFormationRightView:_bindUIEvents()
	WorldBossFormationRightView.super._bindUIEvents(self)
	GlobalDispatcher:addListener(GlobalNotify.WorldBossMedicine, self._updateView, self)
end

function WorldBossFormationRightView:_unbindUIEvents()
	WorldBossFormationRightView.super._unbindUIEvents(self)
	GlobalDispatcher:removeListener(GlobalNotify.WorldBossMedicine, self._updateView, self)
end

function WorldBossFormationRightView:onEnter()
	WorldBossFormationRightView.super.onEnter(self)

	self.tiredGoCloneTrigger = {}
end

function WorldBossFormationRightView:onExit()
	WorldBossFormationRightView.super.onExit(self)
	self._tableview:Travel(self._clearTableview, self)
end

function WorldBossFormationRightView:_clearTableview()
	for k, v in pairs(self.tiredGoCloneTrigger) do
		self.tiredGoCloneTrigger[k]:RemoveClickListener()

		self.tiredGoCloneTrigger[k] = nil
	end
end

function WorldBossFormationRightView:_updateCell(view, cell, data)
	local component = ItemPet.AddOnce(cell.gameObject)

	self:updateForbit(data)
	component:Init(data)
	component:setSelected(false)

	local inTeam = self:getInTeam(data)

	component:SetInTeam(inTeam)

	if WorldBossController.instance:isLockPetIds(data.petId) then
		local tiredGoClone = goutil.findChild(cell.gameObject, "tiredGo")

		if not tiredGoClone then
			local tiredGo = WorldBossController.instance:getBtnTiredGo()

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

function WorldBossFormationRightView:_updateView()
	self._tableview:ReloadData()
	FloatWordMgr.instance:show(lang("world_Boss_tip6"))
end

function WorldBossFormationRightView:_OnDragPetBegin(go, data)
	local pet = ItemPet.Get(go):GetData()
	local petId = pet.petId

	if petId <= 0 then
		return
	end

	if WorldBossController.instance:isLockPetIds(petId) then
		FloatWordMgr.instance:show(lang("world_Boss_tip5"))

		self._dragging = nil

		self._tableview:GetScrollRect():OnBeginDrag(data)
		self._tableview:OnBeginDrag(data)

		return
	else
		WorldBossFormationRightView.super._OnDragPetBegin(self, go, data)
	end
end

function WorldBossFormationRightView:getAllShowPetList()
	return WorldBossModel.instance:getAllShowPetList()
end

function WorldBossFormationRightView:_getCurFormation()
	return WorldBossModel.instance:_getCurFormation()
end

return WorldBossFormationRightView
