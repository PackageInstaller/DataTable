-- chunkname: @IQIGame\\UI\\AffinityChat\\AffinityChat_RoleItem.lua

local AffinityChat_RoleItem = {}
local DataName_roleItem = "roleItem"
local stateName_selected = "selected"
local stateName_UnSelected = "unSelected"
local EventItemClass = require("IQIGame/UI/AffinityChat/AffinityChat_RoleItem_Event")
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")

function AffinityChat_RoleItem.New(go, mainView)
	local o = Clone(AffinityChat_RoleItem)

	o:Initialize(go, mainView)

	return o
end

function AffinityChat_RoleItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.isExpand = false

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function AffinityChat_RoleItem:InitComponent()
	self.eventItemPool = UIViewObjectPool.New(self.eventItem, self.expandRoot.transform, function(_view)
		return EventItemClass.New(_view, self)
	end)
end

function AffinityChat_RoleItem:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end

	function self.delegateOnClickArrowClick()
		self:OnClickArrowClick()
	end
end

function AffinityChat_RoleItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
	self.arrowClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickArrowClick)
	EventUtil.AddEventListener(self, EventID.RoleAttrChange)
end

function AffinityChat_RoleItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
	self.arrowClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickArrowClick)
	EventUtil.ClearEventListener(self)
end

function AffinityChat_RoleItem:__OnRoleAttrChangeHandler()
	LuaUtility.SetText(self.textFavorLv, self.data.favorabilityLevel)
end

function AffinityChat_RoleItem:OnClickArrowClick()
	if self.mainView.isAnimate then
		return
	end

	if self.isExpand then
		self:UnExpand()
	else
		self:Expand()
	end
end

function AffinityChat_RoleItem:OnClickButtonClick()
	self.mainView:RoleSelected(self)
end

function AffinityChat_RoleItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function AffinityChat_RoleItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function AffinityChat_RoleItem:Selected()
	LuaUtility.SetStateController(self.gameObject, DataName_roleItem, stateName_selected)
	self:Expand()
end

function AffinityChat_RoleItem:UnSelected()
	LuaUtility.SetStateController(self.gameObject, DataName_roleItem, stateName_UnSelected)
end

function AffinityChat_RoleItem:Expand()
	LuaUtility.SetGameObjectShow(self.expandRoot, true)

	self.isExpand = true
end

function AffinityChat_RoleItem:UnExpand()
	LuaUtility.SetGameObjectShow(self.expandRoot, false)

	self.isExpand = false
end

function AffinityChat_RoleItem:GetActive()
	return self.gameObject.activeSelf
end

function AffinityChat_RoleItem:OnDestroy()
	self:RemoveListener()
	self.eventItemPool:Dispose(function(item)
		item:OnDestroy()
	end)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function AffinityChat_RoleItem:Refresh(Data, index, isPlayAni)
	self.data = Data
	self.index = index

	self:UnSelected()

	local cfgHero = CfgUtil.GetCfgHeroDataWithID(self.data.cid)

	LuaUtility.SetText(self.heroNameText, cfgHero.Name)
	LuaUtility.LoadImage(self, SkinModule.GetHeroCurrentSkinImgPath(self.data.cid, Constant.SkinImageType.FriendHeadImg), self.heroHeadImg:GetComponent("Image"))
	LuaUtility.SetText(self.textFavorLv, self.data.favorabilityLevel)
	self.eventItemPool:ForItems(function(item)
		item:Hide()
	end)

	local favorData = AffinityModule.GetSortFavorArray(self.data.favor)
	local haveNew = false
	local len = #favorData

	for i = 1, len do
		local item = self.eventItemPool:GetFree(function(_item)
			return not _item:GetActive()
		end)
		local isNew = AffinityModule.GetEventIsNew(favorData[i])

		if isNew then
			haveNew = true
		end

		item:Refresh(favorData[i], i, isNew, isPlayAni)
		item:Show()
	end

	if not self.isExpand then
		self:UnExpand()
	end

	LuaUtility.SetGameObjectShow(self.newsImg, haveNew)
end

function AffinityChat_RoleItem:RefreshNew()
	local favorData = AffinityModule.GetSortFavorArray(self.data.favor)
	local len = #favorData
	local haveNew = false

	for i = 1, len do
		local isNew = AffinityModule.GetEventIsNew(favorData[i])

		if isNew then
			haveNew = true
		end

		self.eventItemPool:ForItems(function(_item)
			if _item:GetActive() and _item.index == i then
				_item:RefreshNew(isNew)

				return true
			end
		end)
	end

	LuaUtility.SetGameObjectShow(self.newsImg, haveNew)
end

function AffinityChat_RoleItem:SelectFirstGroup()
	local isSelected = false

	self.eventItemPool:ForItems(function(item)
		if item.index == 1 then
			item:OnClickButtonClick()

			isSelected = true

			return true
		end
	end)

	if isSelected then
		self:Selected()
	end
end

function AffinityChat_RoleItem:SelectGroupWithID(groupId)
	local isSelected = false

	self.eventItemPool:ForItems(function(item)
		if not item:GetActive() then
			return
		end

		if not item.data then
			return
		end

		if item.data.cid == groupId then
			item:OnClickButtonClick()

			isSelected = true

			return true
		end
	end)

	if isSelected then
		self:Selected()

		return true
	else
		return false
	end
end

function AffinityChat_RoleItem:OnEventClick(eventItem)
	self.mainView:OnEventClick(eventItem)
end

return AffinityChat_RoleItem
