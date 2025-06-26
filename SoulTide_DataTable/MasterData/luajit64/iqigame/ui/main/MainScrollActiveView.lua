-- chunkname: @IQIGame\\UI\\Main\\MainScrollActiveView.lua

local MainScrollActiveView = {
	currentIndex = 1,
	toggles = {}
}

function MainScrollActiveView.__New(ui)
	local o = Clone(MainScrollActiveView)

	o:InitView(ui)

	return o
end

function MainScrollActiveView:InitView(ui)
	self.rootUI = ui

	LuaCodeInterface.BindOutlet(self.rootUI, self)

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaListPage")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.scrollList.onSelectedCell(cell)
		self:OnClickSoulCell(cell)
	end

	function self.scrollList.onPageReachedMainPos(page)
		self:OnPageReachedMain(page)
	end

	function self.delegateShowNextPage()
		self:ShowNextPate()
	end

	function self.delegateOnUnlockNotify(functionTypeId)
		self:OnUnlockNotify(functionTypeId)
	end
end

function MainScrollActiveView:AddEventListener()
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.delegateOnUnlockNotify)
end

function MainScrollActiveView:RemoveEventListener()
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.delegateOnUnlockNotify)
end

function MainScrollActiveView:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function MainScrollActiveView:OnUnlockNotify(functionTypeId)
	local top = false

	for i, v in pairsCfg(CfgNavigationTable) do
		local cfgFunctionData = CfgFunctionTable[v.FunctionId]

		if cfgFunctionData.FunctionOpen == functionTypeId then
			top = true

			break
		end
	end

	if top then
		self:UpDateView()
	end
end

function MainScrollActiveView:UpDateView()
	self.navigationTab = {}

	local curChannel = tostring(PlayerModule.PlayerInfo.baseInfo.channelNo)

	for i, v in pairsCfg(CfgNavigationTable) do
		local isShowChannel = true

		if #v.Channels > 0 then
			isShowChannel = table.indexOf(v.Channels, curChannel) ~= -1 and true or false
		end

		local isOpenTime = v.EndTime == 0
		local beginTime = cfgDateTimeToTimeStamp(v.BeginTime, PlayerModule.TimeZone)
		local remainTime = beginTime + v.EndTime - PlayerModule.GetServerTime()

		if remainTime > 0 and beginTime <= PlayerModule.GetServerTime() then
			isOpenTime = true
		end

		local cfgFunctionData = CfgFunctionTable[v.FunctionId]
		local top = UnlockFunctionModule.IsUnlock(cfgFunctionData.FunctionOpen)
		local resultCondition = true

		if v.CloseCondition > 0 then
			resultCondition = not ConditionModule.Check(v.CloseCondition)
		end

		if top and isOpenTime and resultCondition and isShowChannel then
			table.insert(self.navigationTab, v)
		end
	end

	table.sort(self.navigationTab, function(tb1, tb2)
		return tb1.ShowOredr < tb2.ShowOredr
	end)

	self.toggles = {}

	for i = 0, self.Toggles.transform.childCount - 1 do
		local obj = self.Toggles.transform:GetChild(0).gameObject

		UnityEngine.GameObject.DestroyImmediate(obj)
	end

	for i = 1, #self.navigationTab do
		local cfgData = self.navigationTab[i]
		local obj = UnityEngine.Object.Instantiate(self.ToggleMould)

		obj.transform:SetParent(self.Toggles.transform, false)
		obj:SetActive(true)

		local toggle = obj:GetComponent("Toggle")

		toggle.group = self.Toggles:GetComponent("ToggleGroup")

		if self.currentIndex == i then
			toggle.isOn = true
		else
			toggle.isOn = false
		end

		self.toggles[cfgData.Id] = toggle
	end

	self.scrollList:Refresh(#self.navigationTab)
	self.rootUI:SetActive(#self.navigationTab > 0)

	if CfgDiscreteDataTable[6520061].Data[1] == 1 and LuaCodeInterface.GetOS() == "IOS" then
		self.rootUI:SetActive(false)
	end

	self:ShowCurrentIndexPage()
end

function MainScrollActiveView:OnRenderCell(cell)
	local cfgData = self.navigationTab[cell.index + 1]
	local goObj = cell.gameObject
	local path = UIGlobalApi.GetImagePath(cfgData.Picture)

	goObj:SetActive(true)

	local ImgComponent = goObj.transform:Find("Img").gameObject:GetComponent("Image")

	AssetUtil.LoadImage(self, path, ImgComponent)
end

function MainScrollActiveView:OnClickSoulCell(cell)
	self.currentIndex = cell.index + 1

	local cfgData = self.navigationTab[cell.index + 1]

	JumpModule.Jump(cfgData.FunctionId, cfgData.FunctionParams)
end

function MainScrollActiveView:OnPageReachedMain(page)
	self.currentIndex = page.index + 1

	self:ShowCurrentIndexPage()
end

function MainScrollActiveView:ShowNextPate()
	self.currentIndex = self.currentIndex + 1

	if self.currentIndex > #self.navigationTab then
		self.currentIndex = 1
		self.scrollList.startIndex = 0

		self.scrollList:Refresh(#self.navigationTab)
	else
		self.scrollList:TurnToForward()
	end

	self:ShowCurrentIndexPage()
end

function MainScrollActiveView:ShowCurrentIndexPage()
	if self.timer ~= nil then
		self.timer:Stop()
	end

	self.timer = nil

	local cfgData = self.navigationTab[self.currentIndex]

	if cfgData then
		self.timer = Timer.New(self.delegateShowNextPage, cfgData.ShowTime, 0)

		self.timer:Start()

		if self.toggles and self.toggles[cfgData.Id] and not LuaCodeInterface.GameObjIsDestroy(self.toggles[cfgData.Id].gameObject) then
			self.toggles[cfgData.Id].isOn = true
		end
	end
end

function MainScrollActiveView:Open()
	self.rootUI:SetActive(true)
	self:AddEventListener()
	self:UpDateView()
end

function MainScrollActiveView:Close()
	self.rootUI:SetActive(false)
	self:RemoveEventListener()

	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end
end

return MainScrollActiveView
