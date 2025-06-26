-- chunkname: @IQIGame\\UI\\Login\\BindIDCardView.lua

local m = {
	isBind = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateBindBtn()
		self:ConfrimBindBtnClick()
	end

	function self.delegateCloseBtn()
		return
	end

	self.NameInputCom = self.NameInput:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.CardInputCom = self.CardNumInput:GetComponent("IQIGame.Onigao.Game.UI.InputField")

	self:AddListeners()
end

function m:AddListeners()
	self.ConfirmBindBtn:GetComponent("Button").onClick:AddListener(self.delegateBindBtn)
end

function m:RemoveListeners()
	self.ConfirmBindBtn:GetComponent("Button").onClick:AddListener(self.delegateBindBtn)
end

function m:SetData(uid)
	self.UID = uid
	self.isBind = PlayerPrefsUtil.GetString("", "IDCard" .. self.UID) == "true"

	if not self.isBind then
		self:Show()

		return
	end
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.NameInputCom.text = ""
	self.CardInputCom.text = ""

	self.View:SetActive(false)
end

function m:ConfrimBindBtnClick()
	if self.NameInputCom.text == nil or #self.NameInputCom.text < 3 then
		NoticeModule.ShowNotice(21051001)

		return
	end

	if self.CardInputCom.text == nil or #self.CardInputCom.text <= 0 then
		NoticeModule.ShowNotice(21051001)

		return
	end

	if not self:IsHasEnStr(self.NameInputCom.text) then
		NoticeModule.ShowNotice(21051001)

		return
	end

	if #self.CardInputCom.text < 18 then
		NoticeModule.ShowNotice(21051001)

		return
	end

	PlayerPrefsUtil.SetString("", "IDCard" .. self.UID, "true")
	PlayerPrefsUtil.Save()
	self:Hide()
end

function m:IsHasEnStr(str)
	local bytes
	local isAllCN = false

	for i = 1, #str do
		bytes = string.byte(str, i)

		if bytes > 127 then
			isAllCN = true
		else
			isAllCN = false

			return isAllCN
		end
	end

	return isAllCN
end

function m:CloseBtn()
	return
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
