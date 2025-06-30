-- chunkname: @IQIGame\\UI\\HomeLandManufactureDecompose\\HomeLandDecomposeItemCell.lua

local m = {}
local FurnitureSlot = require("IQIGame.UI.Common.FurnitureSlot")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.furnitureCell = FurnitureSlot:__New(self.FurnitureSlot)

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data, num)
	self.decomposeItemData = data

	local cfg = CfgHomeLandDecorateTable[data.cfgDecorateID]

	self.furnitureCell:SetItem(cfg.Item, true, data.cfgDecorateID)

	local showNum = WarehouseModule.GetItemNumByCfgID(cfg.Item)

	if num ~= nil then
		showNum = num
	end

	self.furnitureCell:SetNum(showNum, false)
	UGUIUtil.SetText(self.TextName, cfg.Name)
	UGUIUtil.SetText(self.TextHave, HomeLandManufactureDecomposeUIApi:GetString("TextHave", showNum))
	UGUIUtil.SetText(self.TextTag1, cfg.Score)
	self.Tag1:SetActive(cfg.Score > 0)
end

function m:SetSelect(select)
	self.ImgCheck:SetActive(select)
end

function m:Dispose()
	self.furnitureCell:OnDestroy()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
