-- chunkname: @IQIGame\\UI\\Maze\\MazeBattleTreasureChestElement.lua

local ChooseItem = {
	sendMessage = true
}

function ChooseItem.New(view, callback)
	local obj = Clone(ChooseItem)

	obj:__Init(view, callback)

	return obj
end

function ChooseItem:__Init(view, callback)
	self.gameObject = view
	self.chooseCallback = callback

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnItemChoose()
		if self.chooseCallback ~= nil then
			self.chooseCallback(self.labyrinthEventOptionCid, self.sendMessage)
		end
	end

	self.buttonRoot:GetComponent("Button").onClick:AddListener(self.__delegateOnItemChoose)
end

function ChooseItem:Show(labyrinthEventOptionCid, chooseIndex)
	self.labyrinthEventOptionCid = labyrinthEventOptionCid
	self.chooseItemIndex = chooseIndex

	self.gameObject:SetActive(true)

	local cfg = CfgLabyrinthEventOptionTable[labyrinthEventOptionCid]

	self.sendMessage = cfg.OptionType ~= true
	self.contentText:GetComponent("Text").text = cfg.Text
end

function ChooseItem:Hide()
	self.gameObject:SetActive(false)
end

function ChooseItem:Dispose()
	self.buttonRoot:GetComponent("Button").onClick:RemoveListener(self.__delegateOnItemChoose)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local Element = {
	treasureCid = 0,
	chooseItemList = {}
}

function Element.New(view)
	local obj = Clone(Element)

	obj:__Init(view)

	return obj
end

function Element:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	ForTransformChild(self.buttonRoot.transform, function(_trans, _index)
		local item = ChooseItem.New(_trans.gameObject, function(_optionCid, _sendMessage)
			self:__OnChooseItemSelect(_optionCid, _sendMessage)
		end)

		table.insert(self.chooseItemList, item)
	end)
end

function Element:__OnChooseItemSelect(labyrinthEventOptionCid, sendMessage)
	MazeModule.OnSubmitEvent(self.stageEventPOD.eventId, labyrinthEventOptionCid)
	self:Hide()
end

function Element:Show(stageEventPOD, labyrinthEventTreasureCid)
	self.gameObject:SetActive(true)

	self.treasureCid = labyrinthEventTreasureCid
	self.stageEventPOD = stageEventPOD

	ForArray(self.chooseItemList, function(_, _item)
		_item:Hide()
	end)

	local cfg = CfgLabyrinthEventTreasureTable[labyrinthEventTreasureCid]

	ForPairs(cfg.mutualIds, function(_index, _labyrinthEventOptionCid)
		local chooseItem = self.chooseItemList[_index]

		if chooseItem == nil then
			return
		end

		chooseItem:Show(_labyrinthEventOptionCid, _index)
	end)

	self.descText:GetComponent("Text").text = cfg.Text
end

function Element:Hide()
	self.gameObject:SetActive(false)
end

function Element:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return Element
