-- chunkname: @IQIGame\\UI\\HomeLand\\HLWorkList\\WorkRecordCell.lua

local WorkRecordCell = {}

function WorkRecordCell.New(view)
	local obj = Clone(WorkRecordCell)

	obj:Init(view)

	return obj
end

function WorkRecordCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfNum = self.goNum:GetComponent("Text")
	self.tfName = self.goName:GetComponent("Text")
	self.tfFinishDesc = self.goFinishDesc:GetComponent("Text")
end

function WorkRecordCell:Refresh(cfgWorkData, index, isPerfect)
	self.cfgWorkData = cfgWorkData
	self.index = index
	self.tfNum.text = HomeLandWorkListUIApi:GetString("workViewCellNum", self.index)
	self.tfName.text = HomeLandWorkListUIApi:GetString("workViewCellWorkName", self.cfgWorkData.WorkName)
	self.tfFinishDesc.text = HomeLandWorkListUIApi:GetString("workViewCellFinishDesc", isPerfect)

	self.goSignPerfect:SetActive(isPerfect)
end

function WorkRecordCell:OnHide()
	return
end

function WorkRecordCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return WorkRecordCell
