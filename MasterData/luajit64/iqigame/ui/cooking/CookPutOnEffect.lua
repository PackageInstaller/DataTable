-- chunkname: @IQIGame\\UI\\Cooking\\CookPutOnEffect.lua

local CookPutOnEffect = {}

function CookPutOnEffect.New(view)
	local obj = Clone(CookPutOnEffect)

	obj:Init(view)

	return obj
end

function CookPutOnEffect:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function CookPutOnEffect:UpdateSate(queueData)
	for i = 1, #queueData.items do
		local itemID = queueData.items[i]

		if itemID > 0 then
			local cfgItemData = CfgItemTable[itemID]

			if self["PutOnEffect" .. i] then
				AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self["PutOnEffect" .. i]:GetComponent("Image"))
			end
		end
	end
end

function CookPutOnEffect:ShowRewardIcon(menuData)
	if menuData then
		local path
		local str = ""

		if menuData.unlock then
			local itemData = CfgItemTable[menuData.cfgInfo.ItemId[1]]

			str = itemData.Name
			path = UIGlobalApi.GetIconPath(itemData.Icon)
		end

		if self.ImgRewardEffect then
			AssetUtil.LoadImage(self, path, self.ImgRewardEffect:GetComponent("Image"))
		end

		if self.TextRewardEffect then
			UGUIUtil.SetText(self.TextRewardEffect, str)
		end
	end
end

function CookPutOnEffect:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return CookPutOnEffect
