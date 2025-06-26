-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkPuzzleGame\\AmusementParkPuzzleGameBlockCell.lua

local m = {
	blockNum = 0,
	isPutDown = false,
	collider2DList = {},
	blockData = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.blockData = {}
	self.blockNum = self.View.transform.childCount

	for i = 0, self.View.transform.childCount - 1 do
		local childObj = self.View.transform:GetChild(i).gameObject
		local collider = childObj:GetComponent(typeof(UnityEngine.Collider2D))

		self.collider2DList[i] = collider

		local nameStr = childObj.name
		local posTab = string.split(nameStr, "_")

		table.insert(self.blockData, {
			tonumber(posTab[1]),
			tonumber(posTab[2])
		})
	end

	self.View:GetComponent("UIDrag").onBeginDrag = function(eventData)
		self:OnBeginDrag(eventData)
	end
	self.View:GetComponent("UIDrag").onDrag = function(pointerEventData)
		self:OnDrag(pointerEventData)
	end
	self.View:GetComponent("UIDrag").onReachTargetSuccess = function(eventData)
		self:OnDragSuccess(eventData)
	end
	self.View:GetComponent("UIDrag").onReachTargetFailure = function(eventData)
		self:OnFailure(eventData)
	end

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:OnBeginDrag()
	return
end

function m:OnDrag(eventData)
	if self.onDrag then
		self.onDrag(self)
	end
end

function m:OnDragSuccess(eventData)
	if self.endDrag then
		self.endDrag(self)
	end
end

function m:OnFailure(eventData)
	self.View.transform.position = self.startPos
end

function m:PutDownMap()
	self.isPutDown = true

	self.View:SetActive(false)

	self.View.transform.position = self.startPos
end

function m:SetData(id)
	self.isPutDown = false
	self.cid = id
	self.startPos = self.View.transform.position
end

function m:Dispose()
	self.collider2DList = {}

	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
