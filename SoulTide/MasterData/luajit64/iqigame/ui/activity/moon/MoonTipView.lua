-- chunkname: @IQIGame\\UI\\Activity\\Moon\\MoonTipView.lua

local MoonTipView = {}

function MoonTipView.New(view)
	local obj = Clone(MoonTipView)

	obj:Init(view)

	return obj
end

function MoonTipView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.goTitle1:GetComponent("Text").text = ActivityUIApi:GetString("moonTip_title1")
	self.goTitle2:GetComponent("Text").text = ActivityUIApi:GetString("moonTip_title2")
	self.goDesc1:GetComponent("Text").text = ActivityUIApi:GetString("moonTip_desc1")
	self.goDesc2:GetComponent("Text").text = ActivityUIApi:GetString("moonTip_desc2")
	self.goNpc1:GetComponent("Text").text = ActivityUIApi:GetString("moonTip_npc1")
	self.goNpc2:GetComponent("Text").text = ActivityUIApi:GetString("moonTip_npc2")
end

function MoonTipView:Open()
	self.View:SetActive(true)
end

function MoonTipView:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function MoonTipView:OnHide()
	return
end

function MoonTipView:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return MoonTipView
