-- chunkname: @IQIGame\\UI\\Cooking\\CookReadyView.lua

local CookReadyView = {}

function CookReadyView.New(view, parentView)
	local obj = Clone(CookReadyView)

	obj:Init(view, parentView)

	return obj
end

function CookReadyView:Init(view, parentView)
	self.View = view
	self.parentView = parentView

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextPutDes, HomeLandCookingUIApi:GetString("TextPutDes"))
	self:AddEventListener()
end

function CookReadyView:AddEventListener()
	return
end

function CookReadyView:RemoveEventListener()
	return
end

function CookReadyView:UpDateText(str)
	return
end

function CookReadyView:Open()
	self.TextPutDes:SetActive(false)
	self.View:SetActive(true)
end

function CookReadyView:Close()
	self.View:SetActive(false)
end

function CookReadyView:Dispose()
	self:RemoveEventListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return CookReadyView
