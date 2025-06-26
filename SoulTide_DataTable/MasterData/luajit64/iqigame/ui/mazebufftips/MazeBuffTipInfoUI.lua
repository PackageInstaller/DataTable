-- chunkname: @IQIGame\\UI\\MazeBuffTips\\MazeBuffTipInfoUI.lua

local m = {}
local BuffCell = require("IQIGame.UI.Common.BuffCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.BuffCell = BuffCell.New(self.BuffCellGO)
end

function m:SetData(mazeBuffPOD)
	local cfgBuffData = CfgBuffTable[mazeBuffPOD.CID]

	self.BuffCell:Refresh(cfgBuffData, false)

	self.NameText:GetComponent("Text").text = cfgBuffData.Name
	self.DescText:GetComponent("Text").text = cfgBuffData.Describe
	self.LeftCountText:GetComponent("Text").text = MazeBuffTipsUIApi:GetString("LeftCountText", mazeBuffPOD.TriggerCount)
end

function m:Dispose()
	self.BuffCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
