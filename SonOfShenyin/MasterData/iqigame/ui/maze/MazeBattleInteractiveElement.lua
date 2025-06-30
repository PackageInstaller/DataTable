-- chunkname: @IQIGame\\UI\\Maze\\MazeBattleInteractiveElement.lua

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
			self.chooseCallback(self.labyrinthEventOptionCid, self.sendMessage, self.nextIDIndex)
		end
	end

	self.buttonGo:GetComponent("Button").onClick:AddListener(self.__delegateOnItemChoose)
end

function ChooseItem:Show(optionCid, nextIDIndex)
	self.gameObject:SetActive(true)

	self.labyrinthEventOptionCid = optionCid

	local optionCfg = CfgLabyrinthEventOptionTable[optionCid]

	self.sendMessage = optionCfg.OptionType ~= true

	local state = self:RefreshUnlockState(optionCfg)

	if state == true then
		self.contentText:GetComponent("Text").text = string.format(ColorCfg.Maze.White, optionCfg.Text)
	else
		self.contentText:GetComponent("Text").text = string.format(ColorCfg.Maze.Gray, optionCfg.Text)
	end

	self.buttonGo:GetComponent("Button").interactable = state
end

function ChooseItem:RefreshUnlockState(optionCfg)
	local function checkUnlock(type)
		if table.len(optionCfg.OptionCost) == 0 then
			return true
		end

		if optionCfg.OptionCost[1] == Constant.ItemCid.MAZE_POWER then
			return true
		end

		if type == 0 then
			return MazeModule.GetMazeWarehouseItemCount(optionCfg.OptionCost[1]) >= optionCfg.OptionCost[2]
		elseif type == 1 then
			return MazeModule.GetMazeStageWarehouseItemCount(optionCfg.OptionCost[1]) >= optionCfg.OptionCost[2]
		end

		return false
	end

	return checkUnlock(optionCfg.CostType)
end

function ChooseItem:Hide()
	self.gameObject:SetActive(false)
end

function ChooseItem:Dispose()
	self.buttonGo:GetComponent("Button").onClick:RemoveListener(self.__delegateOnItemChoose)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local Element = {
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
	ForTransformChild(self.selectRoot.transform, function(_trans, _index)
		local item = ChooseItem.New(_trans.gameObject, function(_optionCid, _sendMessage, _nextIDIndex)
			self:__OnChooseItemSelect(_optionCid, _sendMessage, _nextIDIndex)
		end)

		table.insert(self.chooseItemList, item)
	end)
end

function Element:__OnChooseItemSelect(optionCid, sendMessage, nextIDIndex)
	self.nextIDIndex = nextIDIndex

	MazeModule.OnSubmitEvent(self.stageEventPOD.eventId, optionCid)
	self:Hide()
end

function Element:__OnMazeMutualEventResult()
	if self.nextIDIndex <= 0 then
		self:Hide()
	else
		self:__RefreshShow(self.nextIDIndex)
	end
end

function Element:Show(stageEventPOD, mutualEventCid, startIndex)
	self.gameObject:SetActive(true)

	self.mutualEventCid = mutualEventCid
	self.stageEventPOD = stageEventPOD

	self:__RefreshShow(startIndex)
end

function Element:__RefreshShow(index)
	ForArray(self.chooseItemList, function(_, _item)
		_item:Hide()
	end)

	local cfg = CfgLabyrinthEventMutualTable[self.mutualEventCid]

	ForPairs(cfg.mutualIds, function(_index, _optionCid)
		local chooseItem = self.chooseItemList[_index]

		if chooseItem == nil then
			return
		end

		chooseItem:Show(_optionCid, nextIndex)
	end)

	self.contentText:GetComponent("Text").text = cfg.Text[1]

	UGUIUtil.SetText(self.titleText, cfg.Title)

	local texturePath = cfg.Picture[1]

	AssetUtil.LoadImage_SetNativeSize(self, texturePath, self.storyImageIcon)

	self.contentSctollView:GetComponent("ScrollRect").verticalNormalizedPosition = 1
end

function Element:Hide()
	self.gameObject:SetActive(false)
end

function Element:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return Element
