-- chunkname: @IQIGame\\UI\\ExploreHall\\RestaurantOperation\\RestaurantOperationMain\\ROMainAssetCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateUpdateItem()
		self:OnUpdateItem()
	end

	function self.DelegateBuildLevelUp()
		self:OnBuildLevelUp()
	end

	function self.DelegatePlayerNumAttrsChange(cid, num)
		self:OnPlayerNumAttrsChange(cid, num)
	end

	self:AddListener()
end

function m:AddListener()
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
	EventDispatcher.AddEventListener(EventID.ROBuildLevelUpEvent, self.DelegateBuildLevelUp)
	EventDispatcher.AddEventListener(EventID.PlayerNumAttrsChange, self.DelegatePlayerNumAttrsChange)
end

function m:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.ROBuildLevelUpEvent, self.DelegateBuildLevelUp)
	EventDispatcher.RemoveEventListener(EventID.PlayerNumAttrsChange, self.DelegatePlayerNumAttrsChange)
end

function m:OnUpdateItem()
	if self.cid > 0 then
		local num = WarehouseModule.GetItemNumByCfgID(self.cid)

		UGUIUtil.SetText(self.TextValue, num)
	end
end

function m:OnBuildLevelUp()
	if self.cid == -1 then
		UGUIUtil.SetText(self.TextValue, RestaurantOperationModule.ROAttributePOD.level)
	end
end

function m:OnPlayerNumAttrsChange(cid, num)
	self:OnUpdateItem()
end

function m:SetData(id, name, num, icon)
	self.cid = id

	UGUIUtil.SetText(self.TextName, name)
	UGUIUtil.SetText(self.TextValue, num)

	if icon ~= nil and icon ~= "" then
		local path = UIGlobalApi.GetImagePath(icon)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
