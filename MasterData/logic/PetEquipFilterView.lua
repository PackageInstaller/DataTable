-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/PetEquipFilterView.lua

module("logic.extensions.equipment.view.PetEquipFilterView", package.seeall)

local PetEquipFilterView = class("PetEquipFilterView", ViewComponent)

function PetEquipFilterView:ctor()
	PetEquipFilterView.super.ctor(self)
end

function PetEquipFilterView:buildUI()
	PetEquipFilterView.super.buildUI(self)

	self._cellGo = self:getGo("root/cell")
	self._rootGo = self:getGo("root")
	self._itemGroup = ItemGroup.New(self._rootGo, self._cellGo, nil, nil, true)
	self._customInput = UICustomInput.Get(self:getGo("root"))
end

function PetEquipFilterView:bindEvents()
	PetEquipFilterView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function PetEquipFilterView:unbindEvents()
	PetEquipFilterView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function PetEquipFilterView:destroyUI()
	PetEquipFilterView.super.destroyUI(self)
end

function PetEquipFilterView:onEnter()
	PetEquipFilterView.super.onEnter(self)

	self._selectItem = self:getFirstParam()

	local list = {
		GameEnum.RaceType.Cao,
		GameEnum.RaceType.Shui,
		GameEnum.RaceType.Huo,
		GameEnum.RaceType.Guang,
		GameEnum.RaceType.An,
		GameEnum.RaceType.Kong,
		GameEnum.RaceType.Chuang
	}
	local hasType = {}

	for i, v in pairs(list) do
		if type(i) == "number" then
			hasType[v] = true
		end
	end

	self._currId = self._selectItem
	self._resList = {}

	for k, v in pairs(hasType) do
		table.insert(self._resList, k)
	end

	table.sort(self._resList, function(a, b)
		return a < b
	end)
	self:_updateItem()
end

function PetEquipFilterView:onEnterFinished()
	PetEquipFilterView.super.onEnterFinished(self)
end

function PetEquipFilterView:onExit()
	PetEquipFilterView.super.onExit(self)
end

function PetEquipFilterView:onExitFinished()
	PetEquipFilterView.super.onExitFinished(self)
end

function PetEquipFilterView:_updateItem()
	self._itemGroup:updateWithMoArray(self._resList, function(item, data)
		local nameText = goutil.findChildTextComponent(item.mainGO, "text")
		local change = item.mainGO:GetComponent(ComponentType.UIImageSpriteChange)
		local btn = GameUtil.asBtn(item.mainGO)

		btn:AddClickListener(function()
			if self._currId == data then
				self._currId = nil

				GlobalDispatcher:dispatch(GlobalNotify.EquipChangeRaceTypeFilter)
			else
				self._currId = data

				GlobalDispatcher:dispatch(GlobalNotify.EquipChangeRaceTypeFilter, data)
			end

			self:_updateItem()
		end)
		change:SetState(self._currId == data and 1 or 0)

		nameText.text = GameEnum.RaceTxt[data]
	end)
end

function PetEquipFilterView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

return PetEquipFilterView
