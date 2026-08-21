-- chunkname: @IQIGame\\UI\\LunaBattleLine\\DetailUI\\LunaBattleLineSetCampController.lua

local m = {
	IsShow = false
}

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSetCampBtn()
		self:OnClickSetCampBtn()
	end

	self.IsShow = self.View.activeSelf

	UGUIUtil.SetText(self.SetCampTipText, LunaBattleLineDetailUIApi:GetString("SetCampTipText"))
end

function m:Show(zonePOD)
	if self.IsShow then
		return
	end

	self.IsShow = true

	self:AddListeners()
	self.View:SetActive(true)
	self:SetData(zonePOD)
end

function m:Hide()
	if not self.IsShow then
		return
	end

	self.IsShow = false

	self:RemoveListeners()
	self.View:SetActive(false)
end

function m:AddListeners()
	self.SetCampBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSetCampBtn)
end

function m:RemoveListeners()
	self.SetCampBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSetCampBtn)
end

function m:SetData(zonePOD)
	self.ZonePOD = zonePOD
end

function m:OnClickSetCampBtn()
	if LunaBattleLineModule.IsOutOfMazeLimitTime() then
		NoticeModule.ShowNotice(21062004)

		return
	end

	local defaultTabIndex = FormationModule.GetLastChooseFormationId()

	UIModule.Open(Constant.UIControllerName.LunaBattleLineFormationUI, Constant.UILayer.UI, {
		index = defaultTabIndex,
		onComplete = function(soulPrefabId)
			LunaBattleLineModule.SendGarrison(self.ZonePOD.zoneId, soulPrefabId, function(zoneId)
				self.Host:OnSetCampSuccess(zoneId, self.ZonePOD)
			end)
		end
	})
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
end

return m
