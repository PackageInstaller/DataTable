-- chunkname: @IQIGame\\UI\\Tips\\BuffInfoCell.lua

local BuffInfoCell = {
	layers = 1
}
local BuffCell = require("IQIGame.UI.Common.BuffCell")

function BuffInfoCell.New(go)
	local o = Clone(BuffInfoCell)

	o:Initialize(go)

	return o
end

function BuffInfoCell:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)

	self.tfName = self.goName:GetComponent("Text")
	self.cell = BuffCell.New(self.goSlotParent.transform:GetChild(0).gameObject)
end

function BuffInfoCell:Refresh(cfgData, layers)
	self.cfgData = cfgData
	self.layers = layers

	self:RefreshMisc()
	self:RefreshCell()
end

function BuffInfoCell:OnDestroy()
	self.cell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function BuffInfoCell:RefreshMisc()
	self.tfName.text = self.cfgData.Name
end

function BuffInfoCell:RefreshCell()
	self.cell:Refresh(self.cfgData, false)
	self.cell:RefreshLayers(self.layers)
end

return BuffInfoCell
