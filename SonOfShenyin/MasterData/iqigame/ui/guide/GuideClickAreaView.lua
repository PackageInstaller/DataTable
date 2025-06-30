-- chunkname: @IQIGame\\UI\\Guide\\GuideClickAreaView.lua

local GuideClickAreaView = {
	InsOver = false
}
local GuideTalkMsgCell = require("IQIGame.UI.Guide.GuideTalkMsgCell")

function GuideClickAreaView.__New(ui, parent)
	local o = Clone(GuideClickAreaView)

	o:InitView(ui, parent)

	return o
end

function GuideClickAreaView:InitView(ui, parent)
	self.ParentView = parent
	self.rootUI = ui

	LuaCodeInterface.BindOutlet(self.rootUI, self)
	self:InitMembers()
	self:InitDelegate()
	self:InitComponent()
	self:AddEventListener()
end

function GuideClickAreaView:InitMembers()
	self.Offset = Vector3.New(0, 0, 0)
	self.SizeDelta = Vector2.New(0, 0)
end

function GuideClickAreaView:InitDelegate()
	function self.delegateClickArea()
		self:OnClickArea()
	end
end

function GuideClickAreaView:InitComponent()
	self.imgComponent = self.Image1:GetComponent("Button")
	self.Image3 = self.Image3:GetComponent("Image")
	self.RectTransformImage1 = self.Image1:GetComponent("RectTransform")
	self.RectTransformImage3 = self.Image3.transform:GetComponent("RectTransform")
	self.ImageImage2 = self.Image2:GetComponent("Image")

	LuaUtility.SetGameObjectShow(self.Image1, false)
end

function GuideClickAreaView:AddEventListener()
	self.imgComponent.onClick:AddListener(self.delegateClickArea)
end

function GuideClickAreaView:RemoveEventListener()
	self.imgComponent.onClick:RemoveListener(self.delegateClickArea)
end

function GuideClickAreaView:OnClickArea()
	if self.targetObj == nil then
		return
	end

	if not self.targetObj.activeInHierarchy then
		return
	end

	if self.cfgSubGuide.BattlePosClickEvent then
		EventDispatcher.Dispatch(EventID.NotifyBattleTileMoveNodeClicked, self.cfgSubGuide.BattlePosClickEvent)

		self.IsClick = true

		self.ParentView:ShowGuideNext()

		return
	end

	if self.guideModuleData[18] and self.guideModuleData[18] == true then
		if self.ClickEvent then
			self.ClickEvent()
			self:Close()
			self.ParentView.PlayEffectView:Close()

			self.ClickEvent = nil

			return
		end

		self.IsClick = true

		self.ParentView:ShowGuideNext()

		return
	end

	local targetObj = self.targetObj
	local targetTrans = targetObj.transform

	if not targetTrans:GetComponent("Button") and not targetTrans:GetComponent("ButtonEx") and not targetTrans:GetComponent("Toggle") then
		logError(string.format("引导物体 = %s 身上没有挂载 Button 组件，无法触发点击，请策划检查子引导配置", targetObj.name))

		return
	end

	if self.cfgSubGuide.BattleTapGesture then
		EventDispatcher.Dispatch(EventID.BattleTap, targetTrans)
	else
		GameEntry.Input:SimulatedClick(targetObj)
	end

	if self.ClickEvent then
		self.ClickEvent()
		self:Close()
		self.ParentView.PlayEffectView:Close()

		self.ClickEvent = nil

		return
	end

	self.IsClick = true

	self.ParentView:ShowGuideNext()

	if self.cfgSubGuide.TriggerStoryEvent then
		StoryModule.SendTreeEvent(self.cfgSubGuide.TriggerStoryEvent.npcID, self.cfgSubGuide.TriggerStoryEvent.treeName, self.cfgSubGuide.TriggerStoryEvent.eventName)
	end
end

function GuideClickAreaView:OnImage3LoadSuccess()
	self.RectTransformImage3.anchoredPosition = self.RectTransformImage1.anchoredPosition
	self.RectTransformImage3.sizeDelta = self.RectTransformImage1.sizeDelta
end

function GuideClickAreaView:OnLoadAss(assetName, asset, duration, userData)
	if LuaCodeInterface.GameObjIsDestroy(userData) then
		return
	end

	userData:SetActive(true)

	userData:GetComponent("Image").sprite = LuaCodeInterface.ToSprite(asset)

	local alpha = 1

	if self.guideModuleData[13] ~= nil then
		alpha = self.guideModuleData[13]
	end

	local img = userData:GetComponent("Image")
	local color = img.color

	img.color = Color.New(color.r, color.g, color.b, 0)
	self.IsLoadImage1 = true
end

function GuideClickAreaView:OnLoadAss1(assetName, asset, duration, userData)
	self:SetImageHollowOut(asset)
end

function GuideClickAreaView:SetImageHollowOut(asset)
	local imgHollowOut = self.Image2:GetComponent("ImageHollowOut")

	imgHollowOut:SetHollowClipEnable(true)

	if asset then
		imgHollowOut:SetHollowTex(asset)
	end

	local sizeDelta = self.RectTransformImage1.sizeDelta
	local pos = self.RectTransformImage1.anchoredPosition
	local rect = Rect.New(pos.x - sizeDelta.x / 2, pos.y - sizeDelta.y / 2, sizeDelta.x, sizeDelta.y)

	imgHollowOut:SetHollowRect(rect)
	LuaUtility.SetGameObjectShow(self.Image2, true)

	if self.guideModuleData[18] then
		LuaUtility.SetAnchoredPositionWithRectTransform(self.RectTransformImage1, 0, 0)
		LuaUtility.SetSizeDeltaWithRectTransform(self.RectTransformImage1, 2000, 2000)
	end
end

function GuideClickAreaView:ShowTalk()
	local npcID = self.guideModuleData[14]
	local cvID = self.guideModuleData[15]

	if npcID == nil and cvID == nil then
		self.Talk:SetActive(false)

		return
	end

	self.Talk:SetActive(true)

	local posx = self.guideModuleData[16]
	local posy = self.guideModuleData[17]
	local siblingIndex = 0

	if not self.guideTalkMsg then
		self.guideTalkMsg = GuideTalkMsgCell.New(self.Talk)
	end

	self.guideTalkMsg:SetData(npcID, cvID, posx, posy, siblingIndex)
end

function GuideClickAreaView:Dispose()
	self:RemoveEventListener()

	self.targetUITransform = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
	self.ParentView = nil
end

function GuideClickAreaView:Close()
	self:Hide()

	if self.timerShow ~= nil then
		self.timerShow:Stop()

		self.timerShow = nil
	end

	if self.timerEnd ~= nil then
		self.timerEnd:Stop()

		self.timerEnd = nil
	end

	self.targetObj = nil
end

function GuideClickAreaView:TriggerSelf()
	self:OnClickArea()
end

function GuideClickAreaView:Show()
	LuaUtility.SetGameObjectShow(self.rootUI, true)
end

function GuideClickAreaView:Hide()
	LuaUtility.SetGameObjectShow(self.rootUI, false)
	self:OnClose()
end

function GuideClickAreaView:OnClose()
	self.IsGetData = false
	self.targetObj = nil
	self.IsClick = false
	self.IsLoadImage1 = false
	self.createPos = nil
end

function GuideClickAreaView:Refresh(guideModuleData, cfgSubGuide)
	self.guideModuleData = guideModuleData
	self.cfgSubGuide = cfgSubGuide
	self.IsGetData = true
	self.targetObj = nil
	self.IsClick = false
	self.IsLoadImage1 = false
	self.createPos = nil

	LuaUtility.SetGameObjectShow(self.Image1, false)
	LuaUtility.SetGameObjectShow(self.Image2, false)
end

function GuideClickAreaView:OnUpdate()
	if not self.IsGetData then
		return
	end

	if self.IsClick then
		return
	end

	local pos

	self.Offset.x = self.guideModuleData[8]
	self.Offset.y = self.guideModuleData[9]
	pos = GuideUIUtil.FindObjectAndRefreshCache(self, self.guideModuleData[7], self.Offset)

	if not pos then
		return
	end

	if self.createPos and self.createPos.x == pos.x and self.createPos.y == pos.y then
		return
	end

	self.createPos = pos

	if not self.IsLoadImage1 then
		local path = self.guideModuleData[3]

		AssetUtil.LoadAsset(self, path, self.OnLoadAss, nil, self.Image1)
	end

	self.SizeDelta.x = self.guideModuleData[5]
	self.SizeDelta.y = self.guideModuleData[6]
	self.Image1.transform.anchoredPosition = pos
	self.Image1.transform.sizeDelta = self.SizeDelta

	self:ShowTalk()

	local path1 = self.guideModuleData[4]

	AssetUtil.LoadAsset(self, path1, self.OnLoadAss1, nil)
	self:Show()
end

function GuideClickAreaView:SetClickEvent(func)
	self.ClickEvent = func
end

return GuideClickAreaView
