-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkOneConnectGame\\AmusementParkOneConnectBlockCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnSelf()
		self:OnClickBtnSelf()
	end

	self.BlockCollider = self.View:GetComponent(typeof(UnityEngine.Collider2D))
	self.DrgCollider = self.ImgDrag:GetComponent(typeof(UnityEngine.Collider2D))
	self.StartPos = self.ImgDrag.transform.position
	self.ImgDrag:GetComponent("UIDrag").onBeginDrag = function(eventData)
		self:OnBeginDrag(eventData)
	end
	self.ImgDrag:GetComponent("UIDrag").onDrag = function(pointerEventData)
		self:OnDrag(pointerEventData)
	end
	self.ImgDrag:GetComponent("UIDrag").onReachTargetSuccess = function(eventData)
		self:OnDragSuccess(eventData)
	end
	self.ImgDrag:GetComponent("UIDrag").onReachTargetFailure = function(eventData)
		self:OnFailure(eventData)
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateBtnSelf)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSelf)
end

function m:OnClickBtnSelf()
	if self.OnBeginDragCallBack then
		self.OnBeginDragCallBack(self)
	end
end

function m:OnBeginDrag()
	if self.OnBeginDragCallBack then
		self.OnBeginDragCallBack(self)
	end
end

function m:OnDrag(eventData)
	if self.OnDragCallBack then
		self.OnDragCallBack(self)
	end
end

function m:OnDragSuccess(eventData)
	self.ImgDrag.transform.position = self.StartPos
end

function m:OnFailure(eventData)
	self.ImgDrag.transform.position = self.StartPos
end

function m:UpdateView()
	self.ImgDefault:SetActive(self.BlockData.State == 0)
	self.ImgCheck:SetActive(self.BlockData.State == 1)
	self.ImgTag:SetActive(self.BlockData.IsFirst)
end

function m:SetData(blockData)
	self.BlockData = blockData
	self.View.name = self.BlockData.Index

	self:UpdateView()
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	self.OnBeginDragCallBack = nil
	self.OnDragCallBack = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
