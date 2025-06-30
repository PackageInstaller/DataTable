-- chunkname: @IQIGame\\UI\\HomeLandBuilding\\HomeLandBuildingLevelDesCell.lua

local HomeLandBuildingLevelDesCell = {}

function HomeLandBuildingLevelDesCell.New(view)
	local obj = Clone(HomeLandBuildingLevelDesCell)

	obj:Init(view)

	return obj
end

function HomeLandBuildingLevelDesCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function HomeLandBuildingLevelDesCell:SetTextValue(str)
	UGUIUtil.SetText(self.TextValue, str)
end

function HomeLandBuildingLevelDesCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.GameObject.Destroy(self.View)

	self.View = nil
end

return HomeLandBuildingLevelDesCell
