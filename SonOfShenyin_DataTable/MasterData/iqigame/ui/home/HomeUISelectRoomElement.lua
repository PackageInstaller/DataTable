-- chunkname: @IQIGame\\UI\\Home\\HomeUISelectRoomElement.lua

local ChooseItem = {
	roomCid = 0
}

function ChooseItem.New(gameObject, clickEvent)
	local obj = Clone(ChooseItem)

	obj:__Init(gameObject, clickEvent)

	return obj
end

function ChooseItem:__Init(gameObject, clickEvent)
	self.gameObject = gameObject
	self.clickEvent = clickEvent

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnClick()
		if self.clickEvent ~= nil then
			self.clickEvent(self.roomCid)
		end
	end

	self.gameObject:GetComponent("Button").onClick:AddListener(self.__delegateOnClick)
end

function ChooseItem:Show(roomCid)
	self.gameObject:SetActive(true)

	self.roomCid = roomCid

	local cfgData = CfgHomeRoomTable[roomCid]

	self.roomNameText:GetComponent("Text").text = cfgData.Name
end

function ChooseItem:Hide()
	self.gameObject:SetActive(false)
end

function ChooseItem:OnDispose()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.__delegateOnClick)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local Element = {
	itemList = {}
}

function Element.New(gameObject)
	local obj = Clone(Element)

	obj:__Init(gameObject)

	return obj
end

function Element:__Init(gameObject)
	self.gameObject = gameObject

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnRoomSelect(_roomCid)
		self:__OnRoomSelect(_roomCid)
	end

	for i = 0, self.roomBtnRoot.transform.childCount - 1 do
		local childTrans = self.roomBtnRoot.transform:GetChild(i)
		local item = ChooseItem.New(childTrans.gameObject, self.__delegateOnRoomSelect)

		table.insert(self.itemList, item)
	end

	self:Hide()
end

function Element:__OnRoomSelect(roomCid)
	HomeModule.EnterRoom(roomCid)
	self:Hide()
end

function Element:Show(roomList)
	self.gameObject:SetActive(true)
	ForArray(self.itemList, function(_index, _item)
		local roomCid = roomList[_index]

		if roomCid ~= nil then
			_item:Show(roomCid)
		else
			_item:Hide()
		end
	end)
end

function Element:Hide()
	self.gameObject:SetActive(false)
end

function Element:OnDispose()
	ForArray(self.itemList, function(k, _item)
		_item:OnDispose()
	end)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return Element
