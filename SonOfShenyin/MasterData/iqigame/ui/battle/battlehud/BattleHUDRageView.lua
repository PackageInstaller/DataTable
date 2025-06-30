-- chunkname: @IQIGame\\UI\\Battle\\BattleHUD\\BattleHUDRageView.lua

local UIObjectPool = require("IQIGame/UI/Common/UIObjectPool")
local RageViewItem = {}

function RageViewItem.New(view)
	local obj = Clone(RageViewItem)

	obj:__Init(view)

	return obj
end

function RageViewItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.normalGo.gameObject:SetActive(false)
	self.fullGo.gameObject:SetActive(false)
end

function RageViewItem:ShowEnergy(isFull)
	self.normalGo.gameObject:SetActive(not isFull)
	self.fullGo.gameObject:SetActive(isFull)
	self.gameObject:SetActive(true)
end

function RageViewItem:ShowEmptyEnergy()
	self.normalGo.gameObject:SetActive(false)
	self.fullGo.gameObject:SetActive(false)
	self.gameObject:SetActive(true)
end

function RageViewItem:Hide()
	self.gameObject:SetActive(false)
end

function RageViewItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	GameObject.Destroy(self.gameObject)

	self.gameObject = nil
end

local m = {
	isEnable = false
}

function m.New(view)
	local obj = Clone(m)

	obj:__Init(view)

	return obj
end

function m:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.rageItemTable = {}
	self.rageItemPool = UIObjectPool.New(5, function()
		local energyObj = UnityEngine.GameObject.Instantiate(self.template)

		return RageViewItem.New(energyObj)
	end, function(_item)
		_item:Dispose()
	end)
end

function m:Show()
	self.gameObject:SetActive(true)
end

function m:Refresh(currentEnergy2, maxEnergy2)
	local isFull = maxEnergy2 <= currentEnergy2

	if maxEnergy2 > #self.rageItemTable then
		local item = self.rageItemPool:Obtain()

		table.insert(self.rageItemTable, item)
	end

	for i = 1, #self.rageItemTable do
		if maxEnergy2 < i then
			self.rageItemTable[i]:Hide()
		elseif currentEnergy2 < i then
			self.rageItemTable[i]:ShowEmptyEnergy()
		else
			self.rageItemTable[i]:ShowEnergy(isFull)
		end
	end
end

function m:Hide()
	self.gameObject:SetActive(false)
end

function m:Dispose()
	for i = 1, #self.rageItemTable do
		self.rageItemTable[i]:Dispose()
	end

	self.rageItemTable = nil

	self.rageItemPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return m
