-- chunkname: @IQIGame\\UI\\Battle\\BattleCommonAPView.lua

local Item = {}

function Item.New(view)
	local obj = Clone(Item)

	obj:__Init(view)

	return obj
end

function Item:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:ShowEmpty()
end

function Item:ShowEmpty()
	self.gameObject:SetActive(true)
	self.fullState.gameObject:SetActive(false)
	self.costState.gameObject:SetActive(false)
end

function Item:ShowFull()
	self.gameObject:SetActive(true)
	self.fullState.gameObject:SetActive(true)
	self.costState.gameObject:SetActive(false)
end

function Item:ShowCost()
	self.gameObject:SetActive(true)
	self.fullState.gameObject:SetActive(true)
	self.costState.gameObject:SetActive(true)
end

function Item:Hide()
	self.gameObject:SetActive(false)
end

function Item:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local View = {
	itemList = {}
}

function View.New(view)
	local obj = Clone(View)

	obj:__Init(view)

	return obj
end

function View:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:__InitEventDelegate()
	ForTransformChild(self.itemRoot.transform, function(_trans, _index)
		local item = Item.New(_trans.gameObject)

		table.insert(self.itemList, item)
	end)
	self:__HideCost()
	self:__AddEventListener()
end

function View:__InitEventDelegate()
	function self.__delegateOnBattleUnitAPChange(_battleUnitID)
		self:__RefreshAPValue()
	end

	function self.__delegateOnBattleUnitMaxAPChange(_battleUnitID)
		self:__RefreshAPValue()
	end

	function self.__delegateOnShowAPCost(_costValue)
		self:__ShowAPCost(_costValue)
	end

	function self.__delegateOnHideAPCost()
		self:__HideCost()
	end
end

function View:__AddEventListener()
	EventDispatcher.AddEventListener(EventID.BattleUnitAPChange, self.__delegateOnBattleUnitAPChange)
	EventDispatcher.AddEventListener(EventID.BattleUnitMaxAPChange, self.__delegateOnBattleUnitMaxAPChange)
	EventDispatcher.AddEventListener(EventID.ShowBattleSkillAPCost, self.__delegateOnShowAPCost)
	EventDispatcher.AddEventListener(EventID.HideBattleSkillAPCost, self.__delegateOnHideAPCost)
end

function View:__RemoveEventListener()
	EventDispatcher.RemoveEventListener(EventID.BattleUnitAPChange, self.__delegateOnBattleUnitAPChange)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitMaxAPChange, self.__delegateOnBattleUnitMaxAPChange)
	EventDispatcher.RemoveEventListener(EventID.ShowBattleSkillAPCost, self.__delegateOnShowAPCost)
	EventDispatcher.RemoveEventListener(EventID.HideBattleSkillAPCost, self.__delegateOnHideAPCost)
end

function View:Show()
	self.gameObject:SetActive(true)
	self:__RefreshAPValue()
end

function View:Hide()
	self.gameObject:SetActive(false)
end

function View:Dispose()
	self:__RemoveEventListener()
	ForPairs(self.itemList, function(k, v)
		v:Dispose()
	end)

	self.itemList = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function View:__RefreshAPValue()
	local totalEnergy, maxEnergy = BattleSkillModule.GetCommonEnergyData()

	self.apText:GetComponent("Text").text = totalEnergy .. "/" .. maxEnergy

	ForArray(self.itemList, function(_index, _item)
		if _index > maxEnergy then
			_item:Hide()

			return
		end

		if _index > totalEnergy then
			_item:ShowEmpty()
		else
			_item:ShowFull()
		end
	end)
end

function View:__ShowAPCost(value)
	local totalEnergy, maxEnergy = BattleSkillModule.GetCommonEnergyData()

	if totalEnergy < value then
		return
	end

	self.costText:GetComponent("Text").text = "-" .. value

	self.costText.gameObject:SetActive(true)

	local temp_value = totalEnergy - value

	ForArrayTable(self.itemList, function(_index, _item)
		if _index > maxEnergy then
			_item:Hide()

			return
		end

		if _index > totalEnergy then
			_item:ShowEmpty()

			return
		end

		if _index > temp_value then
			_item:ShowCost()

			return
		end

		_item:ShowFull()
	end, true)
end

function View:__HideCost()
	self.costText.gameObject:SetActive(false)
	self:__RefreshAPValue()
end

return View
