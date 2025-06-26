-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandChooseRoomView.lua

local HomeLandChooseRoomView = {
	cameraSize = 0,
	roomIsOpen = false
}

function HomeLandChooseRoomView.__New(ui, parent)
	local o = Clone(HomeLandChooseRoomView)

	o:InitView(ui, parent)

	return o
end

function HomeLandChooseRoomView:InitView(ui, parent)
	self.rootUI = ui
	self.rootParent = parent

	LuaCodeInterface.BindOutlet(self.rootUI, self)
	UGUIUtil.SetText(self.TextBtnLock, HomeLandChooseCastleApi:GetString("TextBtnLock"))
	UGUIUtil.SetText(self.TextBtnTheme, HomeLandChooseCastleApi:GetString("TextBtnTheme"))
	UGUIUtil.SetText(self.TextBtnBackGift, HomeLandChooseCastleApi:GetString("TextBtnBackGift"))
	AssetUtil.LoadImage(self, HomeLandChooseCastleApi:GetString("ImgLockPath"), self.ImgTheme:GetComponent("Image"))
	AssetUtil.LoadImage(self, HomeLandChooseCastleApi:GetString("ImgThemePath"), self.ImgTheme:GetComponent("Image"))
	AssetUtil.LoadImage(self, HomeLandChooseCastleApi:GetString("ImgBtnBackGiftPath"), self.ImgBtnBackGift:GetComponent("Image"))

	self.btnLockComponent = self.BtnLock:GetComponent("Button")
	self.btnEnterRoomComponent = self.BtnEnterRoom:GetComponent("Button")
	self.btnFunction1Component = self.BtnFunction1:GetComponent("Button")
	self.btnFunction2Component = self.BtnFunction2:GetComponent("Button")
	self.btnThemeComponent = self.BtnTheme:GetComponent("Button")
	self.btnBackGiftComponent = self.BtnBackGift:GetComponent("Button")

	function self.delegateClickBtnLock()
		self:OnClickBtnLock()
	end

	function self.delegateClickBtnFunction1()
		self:OnClickBtnFunction1()
	end

	function self.delegateClickBtnFunction2()
		self:OnClickBtnFunction2()
	end

	function self.delegateClickBtnTheme()
		self:OnBtnTheme()
	end

	function self.delegateOnSelectRoomEvent(sender, args)
		self:OnSelectedRoomEvent(sender, args)
	end

	function self.delegateHomelandUnlockRoomEvent(cid)
		self:OnUnlockRoomEvent(cid)
	end

	function self.delegateClickBtnEnterRoom()
		self:OnClickBtnEnter()
	end

	function self.delegateOnHomelandDragIngEventArgs(sender, args)
		self:OnDragIng(sender, args)
	end

	function self.delegateClickBtnBackGift()
		self:OnBtnBackGift()
	end

	function self.delegateRebateGiftSuccess()
		self:OnRebateGiftSuccess()
	end
end

function HomeLandChooseRoomView:AddEventListener()
	self.btnLockComponent.onClick:AddListener(self.delegateClickBtnLock)
	self.btnEnterRoomComponent.onClick:AddListener(self.delegateClickBtnEnterRoom)
	self.btnFunction1Component.onClick:AddListener(self.delegateClickBtnFunction1)
	self.btnFunction2Component.onClick:AddListener(self.delegateClickBtnFunction2)
	self.btnThemeComponent.onClick:AddListener(self.delegateClickBtnTheme)
	self.btnBackGiftComponent.onClick:AddListener(self.delegateClickBtnBackGift)
	EventDispatcher.AddEventListener(EventID.GetRebateGiftSuccess, self.delegateRebateGiftSuccess)
	GameEntry.LuaEvent:Subscribe(HomelandSelectRoomEventArgs.EventId, self.delegateOnSelectRoomEvent)
	EventDispatcher.AddEventListener(EventID.HomelandUnlockRoomEvent, self.delegateHomelandUnlockRoomEvent)
	GameEntry.LuaEvent:Subscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
end

function HomeLandChooseRoomView:RemoveEventListener()
	self.btnLockComponent.onClick:RemoveListener(self.delegateClickBtnLock)
	self.btnEnterRoomComponent.onClick:RemoveListener(self.delegateClickBtnEnterRoom)
	self.btnFunction1Component.onClick:RemoveListener(self.delegateClickBtnFunction1)
	self.btnFunction2Component.onClick:RemoveListener(self.delegateClickBtnFunction2)
	self.btnThemeComponent.onClick:RemoveListener(self.delegateClickBtnTheme)
	self.btnBackGiftComponent.onClick:RemoveListener(self.delegateClickBtnBackGift)
	EventDispatcher.RemoveEventListener(EventID.GetRebateGiftSuccess, self.delegateRebateGiftSuccess)
	GameEntry.LuaEvent:Unsubscribe(HomelandSelectRoomEventArgs.EventId, self.delegateOnSelectRoomEvent)
	EventDispatcher.RemoveEventListener(EventID.HomelandUnlockRoomEvent, self.delegateHomelandUnlockRoomEvent)
	GameEntry.LuaEvent:Unsubscribe(HomelandDragIngEventArgs.EventId, self.delegateOnHomelandDragIngEventArgs)
end

function HomeLandChooseRoomView:OnUpdate(elapseSeconds, realElapseSeconds)
	self:OnDragIng()
end

function HomeLandChooseRoomView:OnSelectedRoomEvent(sender, args)
	if args.RoomID > 0 then
		if self.roomID == args.RoomID then
			self:EnterRoom()
		end

		self.roomID = args.RoomID
		self.pos = args.Pos

		self:UpdateView()

		if HomeLandLuaModule.currentEnterRoomID == args.RoomID then
			-- block empty
		end

		self.rootUI:SetActive(true)
	else
		self.roomID = 0

		self.rootUI:SetActive(false)
	end
end

function HomeLandChooseRoomView:QuiteRoom()
	if HomeLandLuaModule.currentEnterRoomID > 0 then
		GameEntry.LuaEvent:Fire(nil, HomelandQuitRoomEventArgs():Fill(HomeLandLuaModule.currentEnterRoomID))
	end
end

function HomeLandChooseRoomView:OnUnlockRoomEvent(cid)
	if CfgHomeLandRoomTable[cid].CastleIndex == 1 then
		self.roomID = cid
		self.pos = UnityEngine.GameObject.Find("Root/Castle/Rooms/Room" .. cid).transform.position

		self:UpdateView()
	end
end

function HomeLandChooseRoomView:UpdateView()
	self.SelectBox:SetActive(true)

	if not HomeLandLuaModule.isVisitHome then
		self.BtnBox:SetActive(true)
	end

	self.roomIsOpen = false

	if self.roomID > 0 then
		local cfgRoom = CfgHomeLandRoomTable[self.roomID]

		UGUIUtil.SetText(self.TextRoomName, cfgRoom.Name)

		self.roomIsOpen = HomeLandLuaModule.GetRoomDataByID(self.roomID) ~= nil

		self.BtnLock:SetActive(not self.roomIsOpen)
		self.BtnTheme:SetActive(self.roomIsOpen)

		self.funBuildIds = {}

		if self.roomIsOpen then
			for i, v in pairsCfg(CfgHomeLandBuildingTable) do
				if v.BelongRoom == self.roomID and table.indexOf(Constant.HomelandRoomFunBuild, v.Id) ~= -1 then
					table.insert(self.funBuildIds, v.Id)
				end
			end
		end

		self.BtnFunction1:SetActive(false)
		self.BtnFunction2:SetActive(false)

		for i = 1, #self.funBuildIds do
			local buildId = self.funBuildIds[i]

			self["BtnFunction" .. i]:SetActive(true)
			UGUIUtil.SetText(self["TextBtnFunction" .. i], HomeLandChooseCastleApi:GetString("TextBtnFunction", buildId))
			AssetUtil.LoadImage(self, HomeLandChooseCastleApi:GetString("ImgBtnFunctionPath", buildId), self["ImgBtnFunction" .. i]:GetComponent("Image"))
		end

		local backGiftNum = HomeLandLuaModule.BackGiftNum()

		UGUIUtil.SetText(self.TextBackGiftNum, tostring(backGiftNum))

		local isBackGiftRoom = self:IsBackGiftRoom()

		self.BtnBackGift:SetActive(backGiftNum > 0 and self.roomIsOpen and isBackGiftRoom)

		local p = self:ConvertPosToUI(self.pos)

		self.SelectBox.transform.position = p

		local value = self.rootParent.transform.sizeDelta.x / self.rootParent.transform.sizeDelta.y

		if UnityEngine.Camera.main then
			local scale = UnityEngine.Camera.main.orthographicSize / self.cameraSize

			self.SelectBox.transform.sizeDelta = Vector2.New(cfgRoom.RoomWidth / scale / UnityEngine.Camera.main.aspect * value, cfgRoom.RoomHeight / scale / UnityEngine.Camera.main.aspect * value)
		end
	end
end

function HomeLandChooseRoomView:IsBackGiftRoom()
	for i, v in pairsCfg(CfgHomeLandBuildingTable) do
		if v.BelongRoom == self.roomID and Constant.HomelandBuildType.BuildBackGift == v.Id then
			return true
		end
	end

	return false
end

function HomeLandChooseRoomView:OnDragIng()
	if self.roomID and self.roomID > 0 then
		local cfgRoom = CfgHomeLandRoomTable[self.roomID]
		local p = self:ConvertPosToUI(self.pos)

		self.SelectBox.transform.position = p

		local value = self.rootParent.transform.sizeDelta.x / self.rootParent.transform.sizeDelta.y

		if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
			local scale = UnityEngine.Camera.main.orthographicSize / self.cameraSize

			self.SelectBox.transform.sizeDelta = Vector2.New(cfgRoom.RoomWidth / scale / UnityEngine.Camera.main.aspect * value, cfgRoom.RoomHeight / scale / UnityEngine.Camera.main.aspect * value)
		end
	end
end

function HomeLandChooseRoomView:ConvertPosToUI(pos)
	local canvas = self.rootParent:GetComponent("Canvas")
	local v_v3 = pos

	if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
		v_v3 = UnityEngine.Camera.main:WorldToScreenPoint(pos)
	end

	local v_ui = canvas.worldCamera:ScreenToWorldPoint(v_v3)
	local v_new = Vector3(v_ui.x, v_ui.y, canvas.transform.anchoredPosition3D.z - 1)

	return v_new
end

function HomeLandChooseRoomView:OnClickBtnLock()
	if self.roomID ~= nil then
		UIModule.Open(Constant.UIControllerName.HomeLandUnlockRoomUI, Constant.UILayer.UI, self.roomID)
	end
end

function HomeLandChooseRoomView:OnClickBtnFunction1()
	local buildID = self.funBuildIds[1]

	self:OnClickBtnFunction(buildID)
end

function HomeLandChooseRoomView:OnClickBtnFunction2()
	local buildID = self.funBuildIds[2]

	self:OnClickBtnFunction(buildID)
end

function HomeLandChooseRoomView:OnClickBtnFunction(buildId)
	local data

	if buildId == Constant.HomelandBuildType.BuildGold then
		data = Constant.HomelandRoomFunDecorateType.BuildDecorateGold
	elseif buildId == Constant.HomelandBuildType.BuildManufacture then
		data = Constant.HomelandRoomFunDecorateType.BuildDecorateManufacture
	elseif buildId == Constant.HomelandBuildType.BuildCooking then
		data = Constant.HomelandRoomFunDecorateType.BuildDecorateCooking
	elseif buildId == Constant.HomelandBuildType.BuildWork then
		data = Constant.HomelandRoomFunDecorateType.BuildDecorateWork
	end

	if data then
		GameEntry.LuaEvent:Fire(nil, HomelandClickFunctionDecorationEventArgs():Fill(data, true))
	end
end

function HomeLandChooseRoomView:OnBtnTheme()
	local roomPOD = HomeLandLuaModule.GetRoomDataByID(self.roomID)

	UIModule.Open(Constant.UIControllerName.HomeLandChangeThemeRoomUI, Constant.UILayer.UI, roomPOD)
end

function HomeLandChooseRoomView:OnBtnBackGift()
	UIModule.Open(Constant.UIControllerName.HomeLandGirlRewardUI, Constant.UILayer.UI)
end

function HomeLandChooseRoomView:OnRebateGiftSuccess()
	local backGiftNum = HomeLandLuaModule.BackGiftNum()

	UGUIUtil.SetText(self.TextBackGiftNum, tostring(backGiftNum))

	local isBackGiftRoom = self:IsBackGiftRoom()

	self.BtnBackGift:SetActive(backGiftNum > 0 and self.roomIsOpen and isBackGiftRoom)
end

function HomeLandChooseRoomView:EnterRoom()
	GameEntry.LuaEvent:Fire(nil, HomelandEnterRoomEventArgs():Fill(self.roomID))
end

function HomeLandChooseRoomView:OnClickBtnEnter()
	if self.roomID ~= nil then
		self:EnterRoom()
	end
end

function HomeLandChooseRoomView:Dispose()
	AssetUtil.UnloadAsset(self)
	self:Close()
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
	self.rootParent = nil
end

function HomeLandChooseRoomView:Open()
	self.cameraSize = 3.75

	local aspect = UnityEngine.Camera.main.aspect
	local uiEdgeCoverComponent = UnityEngine.GameObject.Find("UIEdgeCover"):GetComponent("UIEdgeCoverComponent")

	if uiEdgeCoverComponent.basedOnWidth then
		self.cameraSize = self.cameraSize * uiEdgeCoverComponent.limitedCanvasSize.x / uiEdgeCoverComponent.limitedCanvasSize.y / aspect
	end

	self.rootUI:SetActive(true)
	self.SelectBox:SetActive(false)
	self.BtnBox:SetActive(false)
	self:AddEventListener()
end

function HomeLandChooseRoomView:Close()
	self.rootUI:SetActive(false)
	self:RemoveEventListener()
end

return HomeLandChooseRoomView
