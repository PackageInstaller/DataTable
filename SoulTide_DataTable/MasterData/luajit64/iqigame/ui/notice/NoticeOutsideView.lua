-- chunkname: @IQIGame\\UI\\Notice\\NoticeOutsideView.lua

local NoticeOutsideView = {
	notices = {}
}

function NoticeOutsideView.__New(ui, parent)
	local o = Clone(NoticeOutsideView)

	o:InitView(ui, parent)

	return o
end

function NoticeOutsideView:InitView(ui, parent)
	self.rootParent = parent
	self.rootUI = ui

	self.rootUI:SetActive(false)
	LuaCodeInterface.BindOutlet(self.rootUI, self)
	UGUIUtil.SetText(self.TextTitle, NoticeUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.TextTitleEng, NoticeUIApi:GetString("TextTitleEng"))
	UGUIUtil.SetText(self.TextBtn, NoticeUIApi:GetString("TextBtn"))

	self.btnCloseComponent = self.BtnClose:GetComponent("Button")

	function self.delegateBtnClose()
		self:OnClickBtnClose()
	end
end

function NoticeOutsideView:AddEventListener()
	self.btnCloseComponent.onClick:AddListener(self.delegateBtnClose)
end

function NoticeOutsideView:RemoveEventListener()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateBtnClose)
end

function NoticeOutsideView:UpdateView()
	local parentTransform = self.Content.transform

	for i = 0, parentTransform.childCount - 1 do
		local obj = parentTransform:GetChild(0).gameObject

		UnityEngine.GameObject.DestroyImmediate(obj)
	end

	for i = 1, #self.notices do
		local notice = self.notices[i]

		if notice.title ~= nil and notice.title ~= "" then
			local titleObj = UnityEngine.Object.Instantiate(self.TitleMold)

			titleObj.transform:SetParent(parentTransform, false)
			titleObj:SetActive(true)
			UGUIUtil.SetText(titleObj.transform:Find("Text").gameObject, notice.title)
		end

		if notice.content ~= "" and notice.content ~= nil then
			local contentObj = UnityEngine.Object.Instantiate(self.TextMold)

			contentObj.transform:SetParent(parentTransform, false)
			contentObj:SetActive(true)
			UGUIUtil.SetText(contentObj, notice.content)
		end
	end
end

function NoticeOutsideView:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.NoticeUI)
end

function NoticeOutsideView:Dispose()
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
	self.rootParent = nil
end

function NoticeOutsideView:Open(data)
	self.notices = data

	table.sort(self.notices, function(o1, o2)
		return o1.sort > o2.sort
	end)
	self:AddEventListener()
	self.rootUI:SetActive(true)
	self:UpdateView()
end

function NoticeOutsideView:Close()
	self:RemoveEventListener()
	self.rootUI:SetActive(false)
end

return NoticeOutsideView
