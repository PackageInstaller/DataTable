-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkPuzzleGame\\AmusementParkPuzzleGameMapTileCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.Effect:SetActive(false)

	self.collider2D = self.View:GetComponent(typeof(UnityEngine.Collider2D))

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.tileData = data
	self.View.name = self.tileData.index

	self:UpdateView()
end

function m:ShowPassNode(top)
	self.PassNode:SetActive(top)
end

function m:UpdateView()
	self:ShowPassNode(false)
	self.ImgBlock:SetActive(self.tileData.blockId > 0)

	if self.tileData.blockId > 0 then
		local cfgData = CfgAmusementParkBlockListTable[self.tileData.blockId]
		local path = UIGlobalApi.GetImagePath(cfgData.ImageRes)

		AssetUtil.LoadImage(self, path, self.ImgBlock:GetComponent("Image"))
	end
end

function m:PlayEffect()
	if self.timer then
		self.timer:Stop()
	end

	self.Effect:SetActive(true)

	self.timer = Timer.New(function()
		self.Effect:SetActive(false)
	end, 0.5)

	self.timer:Start()
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.collider2D = nil
	self.View = nil
end

return m
