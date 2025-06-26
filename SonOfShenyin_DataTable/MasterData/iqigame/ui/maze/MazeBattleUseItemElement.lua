-- chunkname: @IQIGame\\UI\\Maze\\MazeBattleUseItemElement.lua

local Element = {
	curSelectNum = 1
}

function Element.New(view)
	local obj = Clone(Element)

	obj:__Init(view)

	return obj
end

function Element:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.__delegateOnCloseBtnClick()
		self:__OnCloseBtnClick()
	end

	function self.__delegateOnUseButtonClick()
		self:__OnUseButtonClick()
	end

	function self.__OnMinButtonClickProxy()
		self:__OnMinButtonClickHandler()
	end

	function self.__OnReduceBtnClickProxy()
		self:__OnReduceBtnClickHandler()
	end

	function self.__OnAddButtonClickProxy()
		self:__OnAddButtonClickHandler()
	end

	function self.__OnMaxButtonClickProxy()
		self:__OnMaxButtonClickHandler()
	end

	function self.__OnUseButtonClickProxy()
		self:__OnUseButtonClickHandler()
	end

	function self.__delegateOnMazeBagItemChange()
		self:__OnMazeBagItemChange()
	end

	self:AddListeners()
end

function Element:AddListeners()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnCloseBtnClick)
	self.minBtn:GetComponent("Button").onClick:AddListener(self.__OnMinButtonClickProxy)
	self.reduceBtn:GetComponent("Button").onClick:AddListener(self.__OnReduceBtnClickProxy)
	self.addBtn:GetComponent("Button").onClick:AddListener(self.__OnAddButtonClickProxy)
	self.maxBtn:GetComponent("Button").onClick:AddListener(self.__OnMaxButtonClickProxy)
	self.useBtn:GetComponent("Button").onClick:AddListener(self.__OnUseButtonClickProxy)
end

function Element:RemoveListeners()
	self.minBtn:GetComponent("Button").onClick:RemoveListener(self.__OnMinButtonClickProxy)
	self.reduceBtn:GetComponent("Button").onClick:RemoveListener(self.__OnReduceBtnClickProxy)
	self.addBtn:GetComponent("Button").onClick:RemoveListener(self.__OnAddButtonClickProxy)
	self.maxBtn:GetComponent("Button").onClick:RemoveListener(self.__OnMaxButtonClickProxy)
	self.useBtn:GetComponent("Button").onClick:RemoveListener(self.__OnUseButtonClickProxy)
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnCloseBtnClick)
end

function Element:Show()
	self.gameObject:SetActive(true)
	EventDispatcher.AddEventListener(EventID.MazeBagItemChange, self.__delegateOnMazeBagItemChange)
end

function Element:SetData(itemCid)
	self.curSelectNum = 1
	self.itemCid = itemCid

	self:__RefreshItemsShow()
end

function Element:__RefreshItemsShow()
	self.itemCfg = CfgItemTable[self.itemCid]
	self.curItemData = {
		itemCid = self.itemCid,
		num = MazeModule.GetMazeWarehouseItemCount(self.itemCid)
	}

	UGUIUtil.SetText(self.haveNumText, self.curItemData.num)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.itemCfg.Icon), self.itemImg:GetComponent("Image"))
	self:__RefreshUseNumber()
end

function Element:__OnMazeBagItemChange()
	self:Hide()
end

function Element:Hide()
	EventDispatcher.RemoveEventListener(EventID.MazeBagItemChange, self.__delegateOnMazeBagItemChange)
	self.gameObject:SetActive(false)
end

function Element:__RefreshUseNumber()
	LuaUtility.SetText(self.numText, self.curSelectNum)
end

function Element:__OnCloseBtnClick()
	self:Hide()
end

function Element:__OnMinButtonClickHandler()
	self.curSelectNum = 1

	self:__RefreshUseNumber()
end

function Element:__OnReduceBtnClickHandler()
	self.curSelectNum = self.curSelectNum - 1

	if self.curSelectNum < 1 then
		self.curSelectNum = 1
	end

	self:__RefreshUseNumber()
end

function Element:__OnAddButtonClickHandler()
	self.curSelectNum = self.curSelectNum + 1

	if self.curSelectNum > self.curItemData.num then
		self.curSelectNum = self.curItemData.num
	end

	self:__RefreshUseNumber()
end

function Element:__OnMaxButtonClickHandler()
	self.curSelectNum = math.min(99, self.curItemData.num)

	self:__RefreshUseNumber()
end

function Element:__OnUseButtonClickHandler()
	local itemMap = {}

	itemMap[self.itemCid] = self.curSelectNum

	MazeModule.OnUseLabyrinthItem(itemMap)
end

function Element:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return Element
