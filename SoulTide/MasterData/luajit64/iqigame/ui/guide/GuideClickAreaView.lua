-- chunkname: @IQIGame\\UI\\Guide\\GuideClickAreaView.lua

local GuideClickAreaView = {}
local GuideTalkMsgCell = require("IQIGame.UI.Guide.GuideTalkMsgCell")

function GuideClickAreaView.__New(ui, parent)
	local o = Clone(GuideClickAreaView)

	o:InitView(ui, parent)

	return o
end

function GuideClickAreaView:InitView(ui, parent)
	self.rootParent = parent
	self.rootUI = ui

	self.rootUI:SetActive(false)
	LuaCodeInterface.BindOutlet(self.rootUI, self)

	self.imgComponent = self.Image1:GetComponent("Button")

	self.Image1:SetActive(false)

	function self.delegateClickArea()
		self:OnClickArea()
	end
end

function GuideClickAreaView:AddEventListener()
	self.imgComponent.onClick:AddListener(self.delegateClickArea)
end

function GuideClickAreaView:RemoveEventListener()
	self.imgComponent.onClick:RemoveListener(self.delegateClickArea)
end

function GuideClickAreaView:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuideClickAreaView:OnClickArea()
	if self.targetObj == nil then
		return
	end

	local targetObj = self.targetObj

	UIModule.Close(Constant.UIControllerName.GuideUI)
	GuideModule.GuideSubEnd(self.guideSubID)

	if self.cfgSubGuide.UseTapGesture then
		local targetPosition

		if self.cfgSubGuide.SceneMountPointId ~= nil then
			targetPosition = getMountPoint(targetObj.transform, tonumber(self.cfgSubGuide.SceneMountPointId)).position
		else
			targetPosition = targetObj.transform.position
		end

		local screenPosition = UnityEngine.Camera.main:WorldToScreenPoint(targetPosition)

		GameEntry.Input.TapGesture:Simulate(screenPosition.x, screenPosition.y)
	else
		GameEntry.Input:SimulatedClick(targetObj)
	end
end

function GuideClickAreaView:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.targetObj ~= nil and self.targetUITransform ~= nil and self.guideModuleData ~= nil then
		local checkPos = GuideUIUtil.FindObjectAndRefreshCache(self, self.guideModuleData[7], Vector3.New(self.guideModuleData[8], self.guideModuleData[9], 0))

		if checkPos ~= self.createPos then
			self.createPos = checkPos
			self.Image1.transform.anchoredPosition = self.createPos
			self.Image1.transform.sizeDelta = Vector2.New(self.guideModuleData[5], self.guideModuleData[6])

			local posY = 0

			if self.guideModuleData[18] ~= nil then
				posY = self.guideModuleData[18]
			end

			self.TextEffect.transform.anchoredPosition = Vector2.New(self.createPos.x, self.TextEffect.transform.anchoredPosition.y + posY)

			self:SetImageHollowOut()
		end
	end
end

function GuideClickAreaView:UpDateView()
	self.rootUI:GetComponent("SortedComponentOrder").Order = self.guideModuleData[2]

	local pos = GuideUIUtil.FindObjectAndRefreshCache(self, self.guideModuleData[7], Vector3.New(self.guideModuleData[8], self.guideModuleData[9], 0))
	local path = UIGlobalApi.GetImagePath(self.guideModuleData[3])

	self.Image1:SetActive(false)
	AssetUtil.LoadAsset(self, path, self.OnLoadAss, nil, self.Image1)

	self.createPos = pos
	self.Image1.transform.anchoredPosition = pos
	self.Image1.transform.sizeDelta = Vector2.New(self.guideModuleData[5], self.guideModuleData[6])

	local posY = 0

	if self.guideModuleData[18] ~= nil then
		posY = self.guideModuleData[18]
	end

	self.TextEffect.transform.anchoredPosition = Vector2.New(pos.x, self.TextEffect.transform.anchoredPosition.y + posY)

	local alpha = 1

	if self.guideModuleData[13] ~= nil then
		alpha = self.guideModuleData[13]
	end

	local img = self.Image2:GetComponent("Image")
	local color = img.color

	img.color = Color.New(color.r, color.g, color.b, alpha)

	local path1 = self.guideModuleData[4]

	AssetUtil.LoadAsset(self, path1, self.OnLoadAss1, nil)
	self:ShowTalkPos()

	local showEffectTextCVID = self.guideModuleData[17]

	if showEffectTextCVID and showEffectTextCVID > 0 then
		self.TextEffect:SetActive(true)
		UGUIUtil.SetText(self.TextEffect, CfgCVTable[showEffectTextCVID].Text)
	else
		self.TextEffect:SetActive(false)
	end
end

function GuideClickAreaView:ShowTalkPos()
	local showPos = self.guideModuleData[14]

	for i = 1, 5 do
		local show = showPos == i

		self["Talk" .. i]:SetActive(show)
	end

	if showPos > 0 then
		local npcID = self.guideModuleData[15]
		local cvID = self.guideModuleData[16]

		self.guideTalkMsg = GuideTalkMsgCell.New(self["Talk" .. showPos])

		self.guideTalkMsg:SetData(npcID, cvID)
	end
end

function GuideClickAreaView:OnLoadAss(assetName, asset, duration, userData)
	if LuaCodeInterface.GameObjIsDestroy(userData) then
		return
	end

	userData:SetActive(true)

	userData:GetComponent("Image").sprite = LuaCodeInterface.ToSprite(asset)

	local alpha = 0
	local img = userData:GetComponent("Image")
	local color = img.color

	img.color = Color.New(color.r, color.g, color.b, alpha)
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

	local sizeDelta = self.Image1.transform.sizeDelta
	local pos = self.Image1.transform.anchoredPosition
	local rect = Rect.New(pos.x - sizeDelta.x / 2, pos.y - sizeDelta.y / 2, sizeDelta.x, sizeDelta.y)

	imgHollowOut:SetHollowRect(rect)
end

function GuideClickAreaView:Dispose()
	if self.guideTalkMsg then
		self.guideTalkMsg:Dispose()
	end

	self.targetUITransform = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
	self.rootParent = nil
end

function GuideClickAreaView:Open(data, guideSubID)
	self.guideModuleData = data
	self.guideSubID = guideSubID
	self.cfgSubGuide = GuideModule.GetSubGuide(self.guideSubID)

	self:UpDateView()
	self:AddEventListener()

	local startShow = self.guideModuleData[10]
	local endShow = self.guideModuleData[11]

	self.timerShow = Timer.New(function()
		self.rootUI:SetActive(true)
	end, startShow)

	self.timerShow:Start()

	if endShow > 0 then
		self.timerEnd = Timer.New(function()
			self:Close()
		end, endShow)

		self.timerEnd:Start()
	end
end

function GuideClickAreaView:Close()
	self:RemoveEventListener()
	self.rootUI:SetActive(false)

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

return GuideClickAreaView
