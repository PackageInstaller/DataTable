-- chunkname: @IQIGame\\UI\\RPGMission\\RPGItemCell.lua

local RPGItemCell = {
	signStatePool = {}
}

function RPGItemCell.New(view)
	local obj = Clone(RPGItemCell)

	obj:Init(view)

	return obj
end

function RPGItemCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.icon = self.goIcon:GetComponent("Image")
	self.tfCount = self.goCount:GetComponent("Text")

	for i = 1, 3 do
		self.signStatePool[i] = self.goBgStateRoot.transform:Find("State_" .. i).gameObject
	end
end

function RPGItemCell:Refresh(itemCid, count, state)
	local cfgItemData = CfgItemTable[itemCid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.icon)

	self.tfCount.text = RPGMissionUIApi:GetString("itemCellGoCount", count)

	for i, v in ipairs(self.signStatePool) do
		v:SetActive(state == i)
	end
end

function RPGItemCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function RPGItemCell:SetActive(vs)
	self.View:SetActive(vs)
end

return RPGItemCell
