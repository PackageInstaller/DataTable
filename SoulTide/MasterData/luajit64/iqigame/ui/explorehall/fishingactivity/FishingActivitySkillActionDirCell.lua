-- chunkname: @IQIGame\\UI\\ExploreHall\\FishingActivity\\FishingActivitySkillActionDirCell.lua

local m = {
	Dir = 1
}

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

function m:SetData(dir)
	self.Dir = dir

	for i = 1, 4 do
		self["SkillAction" .. i]:SetActive(i == self.Dir)
	end
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
