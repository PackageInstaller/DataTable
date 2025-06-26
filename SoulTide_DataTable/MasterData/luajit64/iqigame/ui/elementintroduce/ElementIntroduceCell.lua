-- chunkname: @IQIGame\\UI\\ElementIntroduce\\ElementIntroduceCell.lua

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

function m:SetData(iconSprite)
	self.View:SetActive(iconSprite ~= nil)

	if iconSprite ~= nil then
		self.Icon:GetComponent("Image").sprite = iconSprite
	end
end

function m:SetWidth(width)
	local v2 = self.View.transform.sizeDelta

	v2.x = width
	self.View.transform.sizeDelta = v2
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
