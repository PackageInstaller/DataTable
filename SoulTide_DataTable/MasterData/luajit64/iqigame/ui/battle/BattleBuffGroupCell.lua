-- chunkname: @IQIGame\\UI\\Battle\\BattleBuffGroupCell.lua

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

function m:SetData(cfgBuffData)
	self.View:SetActive(cfgBuffData ~= nil)

	if cfgBuffData ~= nil then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgBuffData.Icon), self.Icon:GetComponent("Image"))

		local bgPath = MiscApi:GetString("BuffBg", cfgBuffData.BuffTag)

		self.Bg:SetActive(bgPath ~= nil)

		if bgPath ~= nil then
			AssetUtil.LoadImage(self, bgPath, self.Bg:GetComponent("Image"))
		end

		local arrowPath = MiscApi:GetString("BuffArrow", cfgBuffData.BuffTag)

		self.Arrow:SetActive(arrowPath ~= nil)

		if arrowPath ~= nil then
			AssetUtil.LoadImage(self, arrowPath, self.Arrow:GetComponent("Image"))
		end
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
