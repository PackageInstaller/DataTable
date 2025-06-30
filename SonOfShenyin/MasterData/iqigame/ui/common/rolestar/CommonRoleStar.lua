-- chunkname: @IQIGame\\UI\\Common\\RoleStar\\CommonRoleStar.lua

local m = {
	StarItemList = {}
}
local commonRoleStarItemCell = require("IQIGame.UI.Common.RoleStar.CommonRoleStarItemCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:RefreshStar(heroData, isReserve)
	local starLv = heroData.starLevel
	local starTime = heroData.starTime

	self:InitStarShowState()

	local starNum = math.max(starLv, starTime)

	if isReserve then
		for i = starNum, 1, -1 do
			local starItem = self:CreatrStarItem(i)

			if i <= starTime then
				starItem:SetData(starLv + 1)
			else
				starItem:SetData(starLv)
			end

			starItem:Show()
		end
	else
		for i = 1, starNum do
			local starItem = self:CreatrStarItem(i)

			if starTime < i then
				starItem:SetData(starLv)
			else
				starItem:SetData(starLv + 1)
			end

			starItem:Show()
		end
	end
end

function m:RefreshStarByNumber(starLv, starTime, isReserve)
	self:InitStarShowState()

	local starNum = math.max(starLv, starTime)

	if isReserve then
		for i = starNum, 1, -1 do
			local starItem = self:CreatrStarItem(i)

			if i <= starTime then
				starItem:SetData(starLv + 1)
			else
				starItem:SetData(starLv)
			end

			starItem:Show()
		end
	else
		for i = 1, starNum do
			local starItem = self:CreatrStarItem(i)

			if starTime < i then
				starItem:SetData(starLv)
			else
				starItem:SetData(starLv + 1)
			end

			starItem:Show()
		end
	end
end

function m:InitStarShowState()
	for k, v in pairs(self.StarItemList) do
		v:Hide()
	end
end

function m:CreatrStarItem(index)
	local starItem = self:InstantiateStarItem(index)

	return starItem
end

function m:InstantiateStarItem(index)
	local starItem = self.StarItemList[index]

	if starItem == nil then
		local obj = UnityEngine.Object.Instantiate(self.StarItemPrefab)

		obj.transform:SetParent(self.StarGrid.transform, false)

		starItem = commonRoleStarItemCell.New(obj)
		self.StarItemList[index] = starItem
	end

	return starItem
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()

	for k, v in pairs(self.StarItemList) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
