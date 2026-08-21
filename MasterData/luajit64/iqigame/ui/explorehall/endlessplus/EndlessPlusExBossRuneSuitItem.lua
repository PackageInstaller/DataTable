-- chunkname: @IQIGame\\UI\\ExploreHall\\EndlessPlus\\EndlessPlusExBossRuneSuitItem.lua

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

function m:SetData(cfgRuneData)
	self.View:SetActive(cfgRuneData ~= nil)

	if cfgRuneData == nil then
		return
	end

	AssetUtil.LoadImage(self, EndlessPlusExBossDetailUIApi:GetString("SuitItemBg", cfgRuneData.Quality), self.View:GetComponentInChildren(typeof(UnityEngine.UI.Image)))
	UGUIUtil.SetTextInChildren(self.View, EndlessPlusExBossDetailUIApi:GetString("SuitItemText", cfgRuneData.Name, cfgRuneData.Quality))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
