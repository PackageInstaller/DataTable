-- chunkname: @IQIGame\\UI\\Notice\\NoticeInsideView.lua

local NoticeInsideView = {}

function NoticeInsideView.__New(ui, parent)
	local o = Clone(NoticeInsideView)

	o:InitView(ui, parent)

	return o
end

function NoticeInsideView:InitView(ui, parent)
	self.rootParent = parent
	self.rootUI = ui

	self.rootUI:SetActive(false)
	LuaCodeInterface.BindOutlet(self.rootUI, self)
	UGUIUtil.SetText(self.TextTitle, NoticeUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.TextTitleEng, NoticeUIApi:GetString("TextTitleEng"))

	self.btnCloseComponent = self.BtnClose:GetComponent("Button")
	self.scrollList = self.ToggleScroll:GetComponent("ScrollAreaList")

	function self.scrollList.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.delegateBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateOnButtonTrigger(sender, args)
		self:OnButtonTrigger(sender, args)
	end
end

function NoticeInsideView:AddEventListener()
	self.btnCloseComponent.onClick:AddListener(self.delegateBtnClose)
	GameEntry.LuaEvent:Subscribe(ButtonTriggerEventArgs.EventId, self.delegateOnButtonTrigger)
end

function NoticeInsideView:RemoveEventListener()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateBtnClose)
	GameEntry.LuaEvent:Unsubscribe(ButtonTriggerEventArgs.EventId, self.delegateOnButtonTrigger)
end

function NoticeInsideView:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.NoticeUI)
end

function NoticeInsideView:UpdateView()
	self.notices = {}

	local curChannel = tostring(PlayerModule.PlayerInfo.baseInfo.channelNo)

	for i, v in pairsCfg(CfgGameEventadsTable) do
		local isShowChannel = true

		if #v.Channels > 0 then
			isShowChannel = table.indexOf(v.Channels, curChannel) ~= -1 and true or false
		end

		local remainTime = 1
		local beginTime = 0

		if v.BeginTime ~= "" and v.EndTime ~= "" then
			beginTime = cfgDateTimeToTimeStamp(v.BeginTime, PlayerModule.TimeZone)
			remainTime = beginTime + v.EndTime - PlayerModule.GetServerTime()
		end

		local resultCondition = true

		if v.CloseCondition > 0 then
			resultCondition = not ConditionModule.Check(v.CloseCondition)
		end

		if remainTime > 0 and beginTime <= PlayerModule.GetServerTime() and resultCondition and isShowChannel then
			table.insert(self.notices, v)
		end
	end

	table.sort(self.notices, function(a, b)
		return a.Order < b.Order
	end)
	self.scrollList:Refresh(#self.notices)
end

function NoticeInsideView:OnSelectedGridCell(cell)
	self.selectNotice = self.notices[cell.index + 1]

	if self.selectObj ~= nil then
		self.selectObj:GetComponent("Toggle").isOn = false
	end

	self.selectObj = cell.gameObject
	self.selectObj:GetComponent("Toggle").isOn = true

	self.selectObj.transform:Find("Tag").gameObject:SetActive(false)
	self:ShowNoticeMsg()
end

function NoticeInsideView:OnRenderGridCell(cell)
	local notice = self.notices[cell.index + 1]

	if notice == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local item = cell.gameObject

	item:SetActive(true)

	item:GetComponent("ToggleHelperComponent").text = notice.EventName

	local toggle = item:GetComponent("Toggle")

	if self.selectNotice ~= nil then
		if self.selectNotice.Id == notice.Id then
			toggle.isOn = true
			self.selectObj = item

			self:ShowNoticeMsg()
		else
			toggle.isOn = false
		end
	else
		self.selectNotice = notice
		toggle.isOn = true
		self.selectObj = item

		self:ShowNoticeMsg()
	end

	local dataTab = PlayerPrefsUtil.GetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.Notice_IsNew)
	local isNew = true

	if dataTab ~= nil and dataTab[tostring(notice.Id)] ~= nil then
		isNew = false
	end

	item.transform:Find("Tag").gameObject:SetActive(isNew)
end

function NoticeInsideView:ShowNoticeMsg()
	if self.selectNotice ~= nil then
		local dataTab = PlayerPrefsUtil.GetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.Notice_IsNew)

		if dataTab == nil then
			dataTab = {}
		end

		if dataTab[tostring(self.selectNotice.Id)] == nil then
			dataTab[tostring(self.selectNotice.Id)] = self.selectNotice.Id

			PlayerPrefsUtil.SetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.Notice_IsNew, dataTab)
		end

		local prefabPath = UIGlobalApi.GetNoticePrefab(self.selectNotice.NoticePrefab)

		AssetUtil.LoadAsset(self, prefabPath, self.OnLoadIconSucceed, nil)
	end
end

function NoticeInsideView:OnLoadIconSucceed(assetName, asset, duration, userData)
	local parentTransform = self.Content.transform

	for i = 0, parentTransform.childCount - 1 do
		local obj = parentTransform:GetChild(0).gameObject

		UnityEngine.GameObject.DestroyImmediate(obj)
	end

	local obj = UnityEngine.GameObject.Instantiate(asset)

	obj.transform:SetParent(parentTransform, false)

	parentTransform.anchoredPosition = Vector2.New(0, 0)
end

function NoticeInsideView:OnButtonTrigger(sender, args)
	if args.valueInt == 1 then
		JumpModule.Jump(tonumber(args.valueString))
	elseif args.valueInt == 2 then
		UnityEngine.Application.OpenURL(args.valueString)
	elseif args.valueInt == 3 then
		HeroSdkMono.instance:openBrowser(args.valueString)
	end
end

function NoticeInsideView:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function NoticeInsideView:Open(id)
	if id ~= nil and id ~= "" then
		self.selectNotice = CfgGameEventadsTable[id]
	end

	LoginModule.isOpenNotice = true

	self:AddEventListener()
	self.rootUI:SetActive(true)
	self:UpdateView()
end

function NoticeInsideView:Close()
	self:RemoveEventListener()
	self.rootUI:SetActive(false)
end

return NoticeInsideView
