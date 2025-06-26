-- chunkname: @IQIGame\\UI\\Battle\\BattleWaveProgressView.lua

local BattleWaveProgressItem = {}

function BattleWaveProgressItem.New(view)
	local obj = Clone(BattleWaveProgressItem)

	obj:__Init(view)

	return obj
end

function BattleWaveProgressItem:__Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)
end

function BattleWaveProgressItem:Show(isLight)
	self.view.gameObject:SetActive(true)
	self.light.gameObject:SetActive(isLight)
end

function BattleWaveProgressItem:Hide()
	self.view.gameObject:SetActive(false)
end

function BattleWaveProgressItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

local BattleWaveProgressView = {
	items = {}
}

function BattleWaveProgressView.New(view)
	local obj = Clone(BattleWaveProgressView)

	obj:__Init(view)

	return obj
end

function BattleWaveProgressView:__Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)

	for i = 0, self.itemRoot.transform.childCount - 1 do
		local itemView = self.itemRoot.transform:GetChild(i).gameObject
		local item = BattleWaveProgressItem.New(itemView)

		table.insert(self.items, item)
	end
end

function BattleWaveProgressView:Show(wave, maxWave)
	self.view.gameObject:SetActive(true)
	self.items[1]:Show(true)

	if maxWave == 2 then
		self.items[2]:Hide()
		self.items[3]:Show(wave >= 2)
	else
		self.items[2]:Show(wave >= 2)
		self.items[3]:Show(wave >= 3)
	end

	self.text.gameObject:GetComponent("Text").text = string.format("%s/%s", wave, maxWave)
end

function BattleWaveProgressView:Hide()
	self.view.gameObject:SetActive(false)
end

function BattleWaveProgressView:Dispose()
	for i = 1, #self.items do
		self.items[i]:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

return BattleWaveProgressView
