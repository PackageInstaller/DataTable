-- chunkname: @IQIGame\\UI\\Notice\\NoticeInsideView.lua

local NoticeInsideView = {}

function NoticeInsideView.__New(ui, parent, uiController)
	local o = Clone(NoticeInsideView)

	o:InitView(ui, parent, uiController)

	return o
end

function NoticeInsideView:InitView(ui, parent, uiController)
	self.UIController = uiController
	self.rootParent = parent
	self.rootUI = ui

	self.rootUI:SetActive(false)
	LuaCodeInterface.BindOutlet(self.rootUI, self)
	UGUIUtil.SetText(self.TextTitle, NoticeUIApi:GetTextTitle())
	UGUIUtil.SetText(self.TextTitleEng, NoticeUIApi:GetTextTitleEng())

	self.uniWebView = self.UniWebView:GetComponent("UniWebView")
	self.scrollList = self.ToggleScroll:GetComponent("ScrollAreaList")

	function self.scrollList.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.delegateOnButtonTrigger(sender, args)
		self:OnButtonTrigger(sender, args)
	end

	function self.DelegateTabClick(isOn)
		self:OnClickTab(isOn)
	end
end

function NoticeInsideView:AddEventListener()
	if self.noticeToggleList ~= nil then
		for k, v in pairs(self.noticeToggleList) do
			v:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateTabClick)
		end
	end

	GameEntry.LuaEvent:Subscribe(ButtonTriggerEventArgs.EventId, self.delegateOnButtonTrigger)
end

function NoticeInsideView:RemoveEventListener()
	if self.noticeToggleList ~= nil then
		for k, v in pairs(self.noticeToggleList) do
			v:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateTabClick)
		end
	end

	GameEntry.LuaEvent:Unsubscribe(ButtonTriggerEventArgs.EventId, self.delegateOnButtonTrigger)
end

function NoticeInsideView:UpdateView()
	self.notices = {}

	for i = 1, #self.noticesData do
		table.insert(self.notices, self.noticesData[i])
	end

	table.sort(self.notices, function(a, b)
		return a.sort < b.sort
	end)
	self.scrollList:Refresh(#self.notices)
end

function NoticeInsideView:OnSelectedGridCell(cell)
	return
end

function NoticeInsideView:OnRenderGridCell(cell)
	self.noticeToggleList[cell.index + 1] = cell.gameObject

	local notice = self.notices[cell.index + 1]
	local time = getMonthText(notice.endDate / 1000) .. "/" .. getOnlyDateText(notice.endDate / 1000)

	cell.gameObject:GetComponent("ToggleHelperComponent"):SetTexts({
		notice.title,
		time
	})

	local item = cell.gameObject
	local IsRead = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.Notice_IsNew .. notice.id)
	local isNew = IsRead == ""

	item.transform:Find("Tag").gameObject:SetActive(isNew)
end

function NoticeInsideView:ShowNoticeMsg()
	if self.selectNotice ~= nil then
		local prefabPath = UIGlobalApi.GetNoticePrefab(self.selectNotice.content)

		AssetUtil.LoadAsset(self, prefabPath, self.OnLoadIconSucceed, nil)
	end
end

function NoticeInsideView:OnLoadIconSucceed(assetName, asset, duration, userData)
	local parentTransform = self.Content.transform

	for i = 0, parentTransform.childCount - 1 do
		local obj = parentTransform:GetChild(0).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	local obj = UnityEngine.GameObject.Instantiate(asset)

	obj.transform:SetParent(parentTransform, false)

	parentTransform.anchoredPosition = Vector2.New(0, 0)
	obj.transform:Find("Button"):GetComponent("ButtonTrigger").valueInt = 1
	obj.transform:Find("Button"):GetComponent("ButtonTrigger").valueString = self.selectNotice.expand
end

function NoticeInsideView:OpenWebNotice(url)
	self.uniWebView:Load(url, false)
	self.uniWebView:Show()
	self.uniWebView:UpdateFrame()
end

function NoticeInsideView:OnButtonTrigger(sender, args)
	if args.valueInt == 1 then
		JumpModule.Jump(tonumber(args.valueString))
	elseif args.valueInt == 2 then
		UnityEngine.Application.OpenURL(args.valueString)
	end
end

function NoticeInsideView:OnClickTab(isOn)
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

function NoticeInsideView:ShowTab(index)
	self.selectNotice = self.notices[index]

	local IsRead = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.Notice_IsNew .. self.selectNotice.id)

	if IsRead == "" then
		PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.Notice_IsNew .. self.selectNotice.id, "true")
	end

	self.noticeToggleList[index].transform:Find("Tag").gameObject:SetActive(false)
	self:ShowNoticeMsg()
end

function NoticeInsideView:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function NoticeInsideView:Open(notices)
	self.noticeToggleList = {}
	self.noticesData = notices

	self:UpdateView()
	self.rootUI:SetActive(true)

	self.selectNotice = self.notices[1]

	self:AddEventListener()

	if #self.notices > 0 then
		self:ShowTab(1)

		self.noticeToggleList[1]:GetComponent("Toggle").isOn = true
	end
end

function NoticeInsideView:Close()
	self:RemoveEventListener()
	self.rootUI:SetActive(false)
end

return NoticeInsideView
