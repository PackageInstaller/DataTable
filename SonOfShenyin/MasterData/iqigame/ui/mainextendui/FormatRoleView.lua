-- chunkname: @IQIGame\\UI\\MainExtendUI\\FormatRoleView.lua

FormatRoleView = {
	ToggleChangeFormatRole = false,
	StartPosAndSize = {},
	MoveRange = {
		Buttom = -302,
		Top = 480,
		Left = -429,
		Right = 530
	}
}

function FormatRoleView.New(go, UIController, mainView)
	local o = Clone(FormatRoleView)

	o:Initialize(go, UIController, mainView)

	return o
end

function FormatRoleView:Initialize(go, UIController, mainView)
	self.UIController = UIController
	self.mainView = mainView
	self.gameObject = go

	LuaCodeInterface.BindOutlet(go, self)
	self:InitDelegates()

	self.FormatRoleImage = self.mainView.FormatRoleImage
	self.RoleRootRectTransform = self.FormatRoleImage:GetComponent("RectTransform")
	self.FormatRoleImg = self.FormatRoleImage:GetComponent("Image")
	self.FormatRoleImageBtn = self.FormatRoleImage:GetComponent("Button")
	self.MoveRoleCloseBtn = self.MoveRoleCloseBtn:GetComponent("Button")
	self.MoveRoleSaveBtn = self.MoveRoleSaveBtn:GetComponent("Button")
	self.MoveRoleResetBtn = self.MoveRoleResetBtn:GetComponent("Button")
	self.DragProgressSlider = self.DragProgress:GetComponent("Slider")
	self.CurProportionText = self.CurProportion:GetComponent("Text")
	self.MoveRoleXText = self.MoveRoleX:GetComponent("Text")
	self.MoveRoleYText = self.MoveRoleY:GetComponent("Text")
	self.FormatRoleSpineRoot = self.mainView.RoleSpineRoot

	local eventTrigger = UGUIUtil.GetEventTriggerListener(self.FormatRoleImage)

	if eventTrigger then
		eventTrigger._onBeginDrag = eventTrigger._onBeginDrag + self.OnBeginDragDel
		eventTrigger._onDrag = eventTrigger._onDrag + self.OnDragDel
		eventTrigger._onEndDrag = eventTrigger._onEndDrag + self.OnEndDragDel
	end

	self.ChangeRoleWeightDiffValue = CfgDiscreteDataTable[39].Data[1] / 100
	self.ChangeRoleWeightValue = 1 - self.ChangeRoleWeightDiffValue

	self:AddListener()
	UGUIUtil.SetText(self.mainView.OtherLuaOutlet1, MainUIExtendApi:GetTips_Type1_1())
	UGUIUtil.SetText(self.mainView.OtherLuaOutlet2, MainUIExtendApi:GetTips_Type1_2())
	UGUIUtil.SetText(self.mainView.OtherLuaOutlet3, MainUIExtendApi:GetTips_Type1_3())
	UGUIUtil.SetText(self.mainView.OtherLuaOutlet4, MainUIExtendApi:GetTips_Type1_4())
end

function FormatRoleView:InitDelegates()
	function self.DelegateOnChangeShowHcidSucced()
		self:ShowFormatRole()
	end

	function self.DelegateOnChangeFormatRolePosition()
		self:ChangeFormatRolePosition()
	end

	function self.OnDragDel(go, eventData, eventData_go)
		self:OnDrag(go, eventData, eventData_go)
	end

	function self.OnEndDragDel(go, eventData, eventData_go)
		self:OnEndDrag(go, eventData, eventData_go)
	end

	function self.OnBeginDragDel(go, eventData, eventData_go)
		self:OnBeginDrag(go, eventData, eventData_go)
	end

	function self.OnClickCloseLive2D()
		self:CloseLive2D()
	end

	function self.OnClickMoveRoleSave()
		self:MoveRoleSave()
	end

	function self.OnClickMoveRoleReset()
		self:MoveRoleReset()
	end

	function self.OnDeleDragProgressSlider()
		self:DragProgressSliderFunc()
	end

	function self.OnDelegation_LoadRoleAssetSuccess(RoleObj)
		self:OnLoadRoleAssetSuccess(RoleObj)
	end
end

function FormatRoleView:AddListener()
	self.MoveRoleCloseBtn.onClick:AddListener(self.OnClickCloseLive2D)
	self.MoveRoleSaveBtn.onClick:AddListener(self.OnClickMoveRoleSave)
	self.MoveRoleResetBtn.onClick:AddListener(self.OnClickMoveRoleReset)
	self.DragProgressSlider.onValueChanged:AddListener(self.OnDeleDragProgressSlider)
	EventDispatcher.AddEventListener(EventID.ChangeShowHcid, self.DelegateOnChangeShowHcidSucced)
	EventDispatcher.AddEventListener(EventID.ChangeSkinResult, self.DelegateOnChangeShowHcidSucced)
	EventDispatcher.AddEventListener(EventID.ChangeFormatRolePosition, self.DelegateOnChangeFormatRolePosition)
end

function FormatRoleView:RemoveListener()
	self.MoveRoleCloseBtn.onClick:RemoveListener(self.OnClickCloseLive2D)
	self.MoveRoleSaveBtn.onClick:RemoveListener(self.OnClickMoveRoleSave)
	self.MoveRoleResetBtn.onClick:RemoveListener(self.OnClickMoveRoleReset)
	self.DragProgressSlider.onValueChanged:RemoveListener(self.OnDeleDragProgressSlider)
	EventDispatcher.RemoveEventListener(EventID.ChangeShowHcid, self.DelegateOnChangeShowHcidSucced)
	EventDispatcher.RemoveEventListener(EventID.ChangeSkinResult, self.DelegateOnChangeShowHcidSucced)
	EventDispatcher.RemoveEventListener(EventID.ChangeFormatRolePosition, self.DelegateOnChangeFormatRolePosition)
end

function FormatRoleView:StartFunction()
	self:ShowFormatRole()
	self:SaveLastPosAndSize()
end

function FormatRoleView:SaveLastPosAndSize()
	self.StartPosAndSize.Pos = self.FormatRoleImage.gameObject.transform.localPosition
	self.StartPosAndSize.SlideValue = self.DragProgressSlider.value
	self.StartPosAndSize.Size = self.FormatRoleImage.gameObject.transform.localScale
end

function FormatRoleView:ShowFormatRole()
	if FormatRoleModule.CurChangeType == FormatRoleModule.Type.Pos then
		self:CloseLive2DOther()

		FormatRoleModule.CurChangeType = nil

		return
	end

	local WarlockData = FormatRoleModule.GetFormatRole()

	if WarlockData == nil then
		logError("未拥有英雄cid  " .. PlayerModule.PlayerInfo.baseInfo.showHeroCid)
	end

	self.FormatRoleImage.gameObject.transform.localPosition = Vector3.New(WarlockData.showXPos, WarlockData.showYPos, 0)
	self.DragProgressSlider.value = WarlockData.proportion + self.ChangeRoleWeightDiffValue

	local roleImagePath = WarlockData:GetSkinPath()

	AssetUtil.LoadImage(self, roleImagePath, self.FormatRoleImg, function()
		self.FormatRoleImg:SetNativeSize()

		self.FormatRoleImg.enabled = true

		local cfgHeroData = WarlockData:GetDefaultBaseCid(WarlockData.cid)
		local aniPrefabFullPath = WarlockData:GetCurStaticSkinImagePath(Constant.SkinImageType.DynamicPrefab)

		if aniPrefabFullPath ~= nil and aniPrefabFullPath ~= "" then
			self:ShowSpineFormatRole(WarlockData, aniPrefabFullPath)

			self.FormatRoleImg.enabled = false
		end
	end)
end

function FormatRoleView:CloseLive2D()
	self:CloseLive2DOther()

	self.FormatRoleImage.gameObject.transform.localPosition = self.StartPosAndSize.Pos
	self.DragProgressSlider.value = self.StartPosAndSize.SlideValue
	self.FormatRoleImage.gameObject.transform.localScale = self.StartPosAndSize.Size
end

function FormatRoleView:CloseLive2DOther()
	self.FormatRoleImageBtn.enabled = false
	self.ToggleChangeFormatRole = false

	self.gameObject:SetActive(false)
	self.FormatRoleImage.gameObject.transform:SetParent(self.mainView.Live2DRoot.gameObject.transform)
end

function FormatRoleView:GetFormatRolePos(WarlockData)
	return
end

function FormatRoleView:ChangeFormatRolePosition()
	self.FormatRoleImageBtn.enabled = true

	self.FormatRoleImage.gameObject.transform:SetParent(self.MoveRoleRoot.gameObject.transform)
	self.gameObject:SetActive(true)

	self.ToggleChangeFormatRole = true
end

function FormatRoleView:MoveRoleSave()
	local x = self.FormatRoleImage.gameObject.transform.localPosition.x
	local y = self.FormatRoleImage.gameObject.transform.localPosition.y

	FormatRoleModule.CurChangeType = FormatRoleModule.Type.Pos

	self:SaveLastPosAndSize()
	FormatRoleModule.ChangeShowHcid(PlayerModule.PlayerInfo.baseInfo.showHeroCid, x, y, self.DragProgressSlider.value - self.ChangeRoleWeightDiffValue)
end

function FormatRoleView:MoveRoleReset()
	self.FormatRoleImage.gameObject.transform.localPosition = Vector3.zero
	self.DragProgressSlider.value = self.ChangeRoleWeightDiffValue
end

function FormatRoleView:DragProgressSliderFunc()
	self.CurProportionText.text = math.ceil(self.DragProgressSlider.value * 200 + 100) .. "%"
	self.FormatRoleImage.gameObject.transform.localScale = Vector3.New(self.DragProgressSlider.value + self.ChangeRoleWeightValue, self.DragProgressSlider.value + self.ChangeRoleWeightValue, 0)
end

function FormatRoleView:OnBeginDrag(go, eventData, eventData_go)
	if self.ToggleChangeFormatRole == false then
		return
	end

	self.DiffPos = UGUIUtil.ScreenPointToWorldPointInRectangleDiff(self.RoleRootRectTransform, eventData)
end

function FormatRoleView:OnDrag(go, eventData, eventData_go)
	if self.ToggleChangeFormatRole == false then
		return
	end

	local Lastpos = self.FormatRoleImage.gameObject.transform.localPosition

	UGUIUtil.ScreenPointToWorldPointInRectangleNoCenter(self.RoleRootRectTransform, eventData, self.DiffPos)

	local pos = self.FormatRoleImage.gameObject.transform.localPosition

	if self:RangeDetection(pos) then
		self.FormatRoleImage.gameObject.transform.localPosition = Lastpos

		return
	end

	self.MoveRoleXText.text = "X:" .. math.ceil(pos.x)
	self.MoveRoleYText.text = "Y:" .. math.ceil(pos.y)
end

function FormatRoleView:RangeDetection(pos)
	if pos.y > self.MoveRange.Top or pos.y < self.MoveRange.Buttom or pos.x < self.MoveRange.Left or pos.x > self.MoveRange.Right then
		return true
	end

	return false
end

function FormatRoleView:OnEndDrag(go, eventData, eventData_go)
	return
end

function FormatRoleView:ShowSpineFormatRole(curWarlockData, aniPrefabFullPath)
	if self.curShowSpineWarlockData ~= nil and self.CurrentRoleObj ~= nil and self.curShowSpineWarlockData.cid == curWarlockData.cid then
		self:OnLoadRoleAssetSuccess(self.CurrentRoleObj)
	else
		self:HideSpineFormatRole()

		self.curShowSpineWarlockData = curWarlockData

		local rolePath = aniPrefabFullPath

		ObjectPoolManager:AsyncLoadAsset(Constant.PoolObjName.MainUIRole, self.curShowSpineWarlockData.cid, rolePath, self, self.OnDelegation_LoadRoleAssetSuccess)
	end
end

function FormatRoleView:HideSpineFormatRole()
	if self.curShowSpineWarlockData == nil then
		return
	end

	ObjectPoolManager:UnLoadAsset(Constant.PoolObjName.MainUIRole, self.curShowSpineWarlockData.cid, self.CurrentRoleObj)

	self.curShowSpineWarlockData = nil
	self.CurrentRoleObj = nil
end

function FormatRoleView:OnLoadRoleAssetSuccess(RoleObj)
	self.CurrentRoleObj = RoleObj

	self.CurrentRoleObj.transform:SetParent(self.FormatRoleSpineRoot.transform, false)

	self.CurrentRoleObj.transform.localPosition = Vector3.zero

	setGameObjectLayers(self.CurrentRoleObj.transform, "UI")

	local skeletonGraphic = self.CurrentRoleObj.transform:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

	skeletonGraphic.AnimationState:SetAnimation(0, "idle", true)
	self.CurrentRoleObj:SetActive(true)
	self.FormatRoleSpineRoot.gameObject:SetActive(true)
end

function FormatRoleView:OnDestroy()
	self:HideSpineFormatRole()
	ObjectPoolManager:UnLoadGameAsset(Constant.PoolObjName.MainUIRole)
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
	self.mainView = nil
end

return FormatRoleView
