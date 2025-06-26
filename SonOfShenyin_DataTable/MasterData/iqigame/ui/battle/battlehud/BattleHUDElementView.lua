-- chunkname: @IQIGame\\UI\\Battle\\BattleHUD\\BattleHUDElementView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:__Init(view)

	return obj
end

function m:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function m:SetData(monsterConfig)
	AssetUtil.LoadImage(self, BattleApi:GetMonsterElementPath(monsterConfig.Elements), self.elementImg:GetComponent("Image"))
end

function m:Show()
	self.gameObject:SetActive(true)
end

function m:Hide()
	self.gameObject:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return m
