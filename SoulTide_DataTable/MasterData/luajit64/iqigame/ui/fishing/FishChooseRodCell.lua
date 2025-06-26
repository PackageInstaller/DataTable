-- chunkname: @IQIGame\\UI\\Fishing\\FishChooseRodCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(data)
	self.itemData = data

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.itemData:GetCfg().Icon), self.Icon:GetComponent("Image"))

	local cfgItemData = self.itemData:GetCfg()

	if cfgItemData.IsShowUseNum and cfgItemData.UseNum > 0 then
		local haveNum = self.itemData:GetLeftUseCount()

		UGUIUtil.SetText(self.TagNoChooseNum, HomeLandFishChooseUIApi:GetString("TagNoChooseNum", haveNum, self.itemData:GetCfg().UseNum))
		UGUIUtil.SetText(self.TagChooseNum, HomeLandFishChooseUIApi:GetString("TagChooseNum", haveNum, self.itemData:GetCfg().UseNum))
	else
		UGUIUtil.SetText(self.TagNoChooseNum, self.itemData.num)
		UGUIUtil.SetText(self.TagChooseNum, self.itemData.num)
	end
end

function m:SetSelect(top)
	self.Choose:SetActive(top)
	self.TagChoose:SetActive(top)
	self.TagNoChoose:SetActive(not top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
