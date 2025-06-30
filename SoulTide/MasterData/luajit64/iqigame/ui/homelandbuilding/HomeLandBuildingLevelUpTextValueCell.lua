-- chunkname: @IQIGame\\UI\\HomeLandBuilding\\HomeLandBuildingLevelUpTextValueCell.lua

local HomeLandBuildingLevelUpTextValueCell = {}

function HomeLandBuildingLevelUpTextValueCell.New(view)
	local obj = Clone(HomeLandBuildingLevelUpTextValueCell)

	obj:Init(view)

	return obj
end

function HomeLandBuildingLevelUpTextValueCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function HomeLandBuildingLevelUpTextValueCell:SetTextValue(str1, str2)
	UGUIUtil.SetText(self.TextValue1, str1)
	UGUIUtil.SetText(self.TextValue2, str2)
end

function HomeLandBuildingLevelUpTextValueCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.GameObject.Destroy(self.View)

	self.View = nil
end

return HomeLandBuildingLevelUpTextValueCell
