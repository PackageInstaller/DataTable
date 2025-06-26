-- chunkname: @IQIGame\\UI\\GirlOpening\\GirlOpenBranchLineView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tweenAlpha = self.View:GetComponent("TweenAlpha")

	function self.DelegateOnFadeoutComplete()
		self:OnFadeoutComplete()
	end
end

function m:UpdateView(type, dialogName)
	UGUIUtil.SetText(self.TextNameBg, GirlOpeningUIApi:GetString("TextNameBg", type, dialogName))
	UGUIUtil.SetText(self.TextName, GirlOpeningUIApi:GetString("TextName", type, dialogName))
	UGUIUtil.SetText(self.TextType, GirlOpeningUIApi:GetString("TextType", type))
end

function m:Open()
	self.View:SetActive(true)

	self.tweenAlpha.enabled = false

	self.tweenAlpha:ResetToBeginning()
end

function m:Close()
	self.View:SetActive(false)
end

function m:CloseEffect()
	self.tweenAlpha.enabled = true

	self.tweenAlpha:SetOnFinished(self.DelegateOnFadeoutComplete)
end

function m:OnFadeoutComplete()
	self.tweenAlpha:RemoveOnFinished(self.DelegateOnFadeoutComplete)

	if self.fadeoutCallBack then
		self.fadeoutCallBack()

		self.fadeoutCallBack = nil
	end
end

function m:Dispose()
	self.fadeoutCallBack = nil, LuaCodeInterface.ClearOutlet(self.View, self)
	self.View = nil
end

return m
