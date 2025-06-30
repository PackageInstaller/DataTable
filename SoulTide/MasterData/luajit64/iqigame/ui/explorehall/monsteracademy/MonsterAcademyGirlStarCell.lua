-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyGirlStarCell.lua

local m = {}

function m.New(view, index)
	local obj = Clone(m)

	obj:Init(view, index)

	return obj
end

function m:Init(view, index)
	self.View = view
	self.index = index

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(num, maxNum)
	local per = num / maxNum

	self.ImgPre:GetComponent("Image").fillAmount = per
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
