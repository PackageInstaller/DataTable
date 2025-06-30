-- chunkname: @IQIGame\\UI\\Common\\RoleStar\\CommonRoleStarItemCell.lua

local m = {}

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

function m:SetData(lv)
	if self.LastLv ~= lv then
		AssetUtil.LoadImage(self, RoleDevelopmentApi:GetRoleStarImg(lv), self.StarImage:GetComponent("Image"))
	end

	self.LastLv = lv
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
