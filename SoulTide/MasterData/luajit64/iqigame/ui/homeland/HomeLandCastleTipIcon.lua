-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandCastleTipIcon.lua

local HomeLandCastleTipIcon = {}

function HomeLandCastleTipIcon.__New(itemCellView)
	local itemCell = Clone(HomeLandCastleTipIcon)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandCastleTipIcon:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function HomeLandCastleTipIcon:AddListener()
	return
end

function HomeLandCastleTipIcon:RemoveListener()
	return
end

function HomeLandCastleTipIcon:SetData(buildIngID)
	self.goView:SetActive(false)

	self.buildingId = buildIngID

	if self.buildingId > 0 then
		local cfgBuild = CfgHomeLandBuildingTable[self.buildingId]
		local path = UIGlobalApi.GetImagePath("/Home/" .. cfgBuild.CompleteImage)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"), function()
			if not LuaCodeInterface.GameObjIsDestroy(self.goView) then
				self.goView:SetActive(true)
			end
		end)
	end
end

function HomeLandCastleTipIcon:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.GameObject.DestroyImmediate(self.goView)

	self.goView = nil
end

return HomeLandCastleTipIcon
