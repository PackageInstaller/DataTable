-- chunkname: @IQIGame\\UI\\ExploreHall\\Survival\\SurvivalChallengeUpgrade\\SurvivalChallengeStarView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.playerData = data

	local maxLv = self.playerData.maxLv

	for i = 1, maxLv do
		self["Lv" .. i]:SetActive(i <= self.playerData.grade)
	end
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
