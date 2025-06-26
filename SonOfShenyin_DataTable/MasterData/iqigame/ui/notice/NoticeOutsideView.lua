-- chunkname: @IQIGame\\UI\\Notice\\NoticeOutsideView.lua

local NoticeOutsideView = {
	notices = {}
}

function NoticeOutsideView.__New(ui, parent, uiController)
	local o = Clone(NoticeOutsideView)

	o:InitView(ui, parent, uiController)

	return o
end

function NoticeOutsideView:InitView(ui, parent, uiController)
	self.UIController = uiController
	self.rootParent = parent
	self.rootUI = ui

	self.rootUI:SetActive(false)
	LuaCodeInterface.BindOutlet(self.rootUI, self)

	self.warpContent = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.warpContent.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	function self.warpContent.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.DelegateTabClick(isOn)
		self:OnClickTab(isOn)
	end
end

function NoticeOutsideView:AddEventListener()
	if self.noticeToggleList ~= nil then
		for k, v in pairs(self.noticeToggleList) do
			v:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateTabClick)
		end
	end
end

function NoticeOutsideView:RemoveEventListener()
	if self.noticeToggleList ~= nil then
		for k, v in pairs(self.noticeToggleList) do
			v:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateTabClick)
		end
	end
end

function NoticeOutsideView:UpdateView()
	local parentTransform = self.Content.transform

	for i = 0, parentTransform.childCount - 1 do
		local obj = parentTransform:GetChild(0).gameObject

		UnityEngine.GameObject.Destroy(obj)
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

function NoticeOutsideView:Dispose()
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
	self.rootParent = nil
end

function NoticeOutsideView:Open(data)
	self.noticeToggleList = {}

	LuaUtility.SetGameObjectShow(self.UniWebViewPanel, IQIGame.Onigao.Game.Device.isMobile)

	self.notices = data

	table.sort(self.notices, function(o1, o2)
		return o1.sort > o2.sort
	end)
	self.rootUI:SetActive(true)

	self.selectNotice = self.notices[1]

	self.warpContent:Refresh(#self.notices)
	self:AddEventListener()

	if #self.notices > 0 then
		self:ShowTab(1)

		self.noticeToggleList[1]:GetComponent("Toggle").isOn = true
	else
		UGUIUtil.SetText(self.TextContent, NoticeUIApi:GetEmptyNoticeText())
	end
end

function NoticeOutsideView:Close()
	if self.UniWebViewClone then
		UnityEngine.GameObject.Destroy(self.UniWebViewClone)

		self.UniWebViewClone = nil
		self.UniWebViewComponent = nil
	end

	self:RemoveEventListener()
	self.rootUI:SetActive(false)
end

function NoticeOutsideView:RefreshNoticesContent()
	if IQIGame.Onigao.Game.Device.isMobile then
		UGUIUtil.SetText(self.TextContent, "")

		if self.UniWebViewClone ~= nil then
			UnityEngine.GameObject.Destroy(self.UniWebViewClone)
		end

		self.UniWebViewClone = UnityEngine.Object.Instantiate(self.UniWebView)

		self.UniWebViewClone.transform:SetParent(self.UniWebViewPanel.transform, false)
		LuaUtility.SetGameObjectShow(self.UniWebViewClone, true)

		self.UniWebViewComponent = self.UniWebViewClone:GetComponent("UniWebView")

		self.UniWebViewComponent:LoadHTMLString(self.selectNotice.content, LoginModule.GetRequestUrl(Constant.LoginConst.GetNoticeContentUrl), false)
		self.UniWebViewComponent:Show()
		self.UniWebViewComponent:UpdateFrame()
	else
		UGUIUtil.SetText(self.TextContent, self.selectNotice.content)
	end
end

function NoticeOutsideView:OnSelectedGridCell(cell)
	return
end

function NoticeOutsideView:OnRenderGridCell(cell)
	self.noticeToggleList[cell.index + 1] = cell.gameObject

	local notice = self.notices[cell.index + 1]

	cell.gameObject:GetComponent("ToggleHelperComponent"):SetTexts({
		notice.title
	})

	local item = cell.gameObject
	local IsRead = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.Notice_IsNew .. notice.id)
	local isNew = IsRead == ""

	item.transform:Find("Tag").gameObject:SetActive(isNew)
end

function NoticeOutsideView:OnClickTab(isOn)
	if isOn then
		local currentTarget = self.UIController:GetCurrentTarget()

		for i = 1, #self.noticeToggleList do
			if self.noticeToggleList[i] == currentTarget then
				self:ShowTab(i)

				return
			end
		end
	end
end

function NoticeOutsideView:ShowTab(index)
	self.selectNotice = self.notices[index]

	local IsRead = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.Notice_IsNew .. self.selectNotice.id)

	if IsRead == "" then
		PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.Notice_IsNew .. self.selectNotice.id, "true")
	end

	self.noticeToggleList[index].transform:Find("Tag").gameObject:SetActive(false)
	self:RefreshNoticesContent()
end

return NoticeOutsideView
