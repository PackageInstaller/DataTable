-- chunkname: @IQIGame\\UI\\GuideUI.lua

local GuideUI = Base:Extend("GuideUI ", "IQIGame.Onigao.UI.GuideUI ", {
	disabled = false,
	isShow = false,
	guideViews = {}
})
local GuideArrowPointingView = require("IQIGame.UI.Guide.GuideArrowPointingView")
local GuideClickAreaView = require("IQIGame.UI.Guide.GuideClickAreaView")
local GuideNpcTalkView = require("IQIGame.UI.Guide.GuideNpcTalkView")
local GuidePictureGuideView = require("IQIGame.UI.Guide.GuidePictureGuideView")
local GuidePlayEffectView = require("IQIGame.UI.Guide.GuidePlayEffectView")

function GuideUI:OnInit()
	function self.delegateUpgradePosition()
		self:OnUpgradePosition()
	end

	function self.delegateTalkEnd(data)
		self:OnTalkViewEnd(data)
	end

	function self.delegateBtnJump()
		self:OnBtnJump()
	end
end

function GuideUI:GetPreloadAssetPaths()
	return nil
end

function GuideUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuideUI:OnOpen(userData)
	if userData == nil then
		return
	end

	self.disabled = false
	self.guideSubData = userData[1]
	self.guideID = userData[2]
	self.isShow = false

	self.Root:SetActive(false)

	local cfgGuide = CfgGuideTable[self.guideID]

	self.BtnJump:SetActive(cfgGuide.IsSkip)

	if self.guideSubData.GuideSubShow ~= "" then
		local index = string.find(self.guideSubData.GuideSubShow, "/", 1)

		if index == nil then
			index = string.len(self.guideSubData.GuideSubShow) + 1
		end

		local strUIName = string.sub(self.guideSubData.GuideSubShow, 1, index - 1)

		self.uiName = string.gsub(strUIName, "%(Clone%)", "")
		self.pathObj = string.sub(self.guideSubData.GuideSubShow, index + 1, #self.guideSubData.GuideSubShow)

		LuaCodeInterface.SetEventSystemEnabled("GuideUI_" .. self.UIController.UIForm.SerialId, false)
	else
		self:CreateGuideModule()
		self:CheckDisable()
	end
end

function GuideUI:OnClose(userData)
	self.uiName = nil
	self.pathObj = nil
	self.disabled = false

	if self.timerClose ~= nil then
		self.timerClose:Stop()

		self.timerClose = nil
	end

	for i, v in pairs(self.guideViews) do
		v:Close()
	end
end

function GuideUI:OnAddListeners()
	self.BtnJump:GetComponent("Button").onClick:AddListener(self.delegateBtnJump)
end

function GuideUI:OnRemoveListeners()
	self.BtnJump:GetComponent("Button").onClick:RemoveListener(self.delegateBtnJump)
end

function GuideUI:OnPause()
	return
end

function GuideUI:OnResume()
	return
end

function GuideUI:OnCover()
	return
end

function GuideUI:OnReveal()
	return
end

function GuideUI:OnRefocus(userData)
	return
end

function GuideUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.isShow == true then
		if self.guideViews then
			for i, v in pairs(self.guideViews) do
				v:OnUpdate(elapseSeconds, realElapseSeconds)
			end
		end
	elseif self.uiName then
		local targetUI = GameEntry.UI:GetUIFormByName(self.uiName)

		if targetUI ~= nil then
			if self.pathObj ~= "" then
				local targetObjTransform = targetUI.transform:Find(self.pathObj)

				if targetObjTransform and targetObjTransform.gameObject.activeInHierarchy then
					self:CreateGuideModule()
					LuaCodeInterface.SetEventSystemEnabled("GuideUI_" .. self.UIController.UIForm.SerialId, true)
				end
			else
				self:CreateGuideModule()
				LuaCodeInterface.SetEventSystemEnabled("GuideUI_" .. self.UIController.UIForm.SerialId, true)
			end
		end
	end

	self:CheckDisable()
end

function GuideUI:CheckDisable()
	if UIModule.HasUI(Constant.UIControllerName.QueueTipUI) or UIModule.HasUI(Constant.UIControllerName.DialogUI) then
		self.disabled = true

		GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.GuideUI, false)
	elseif self.disabled then
		GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.GuideUI, true)

		self.disabled = false
	end
end

function GuideUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	for i, v in pairs(self.guideViews) do
		v:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	end
end

function GuideUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuideUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuideUI:OnDestroy()
	for i, v in pairs(self.guideViews) do
		v:Dispose()

		v = nil
	end

	self.guideViews = nil
end

function GuideUI:CreateGuideModule()
	if self.isShow then
		return
	end

	self.isShow = true

	self.Root:SetActive(true)

	for i, v in pairs(self.guideViews) do
		v:Close()
		v:Dispose()
	end

	for i = 0, self.Root.transform.childCount - 1 do
		local obj = self.Root.transform:GetChild(0).gameObject

		UnityEngine.GameObject.DestroyImmediate(obj)
	end

	self.guideViews = {}

	local npcTalks = {}

	for k, v in pairs(self.guideSubData.GuideUIType) do
		local objModule, moduleView

		if v[1] == "ClickArea" then
			objModule = UnityEngine.GameObject.Instantiate(self.ClickArea)
			moduleView = GuideClickAreaView.__New(objModule, self)
		elseif v[1] == "PlayEffect" then
			objModule = UnityEngine.GameObject.Instantiate(self.PlayEffect)
			moduleView = GuidePlayEffectView.__New(objModule, self)
		elseif v[1] == "NpcTalk" then
			table.insert(npcTalks, v)
		elseif v[1] == "ArrowPointing" then
			objModule = UnityEngine.GameObject.Instantiate(self.ArrowPointing)
			moduleView = GuideArrowPointingView.__New(objModule, self)
		elseif v[1] == "PictureGuide" then
			objModule = UnityEngine.GameObject.Instantiate(self.PictureGuide)
			moduleView = GuidePictureGuideView.__New(objModule, self)
		end

		if objModule then
			self:EnableObject(objModule)
		end

		if moduleView ~= nil then
			moduleView:Open(v, self.guideSubData.GuideSubID)
			table.insert(self.guideViews, moduleView)
			objModule.transform:SetParent(self.Root.transform, false)
		end
	end

	if #npcTalks > 0 then
		local objModule = UnityEngine.GameObject.Instantiate(self.NpcTalk)

		objModule.transform:SetParent(self.Root.transform, false)

		local moduleView = GuideNpcTalkView.__New(objModule, self)

		moduleView:Open(npcTalks, self.guideSubData.GuideSubID)

		moduleView.talkEndBack = self.delegateTalkEnd

		table.insert(self.guideViews, moduleView)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.Root.transform)
		self:EnableObject(objModule)
	end

	if self.guideSubData.GuideShowTime > 0 then
		self.timerClose = Timer.New(function()
			UIModule.Close(Constant.UIControllerName.GuideUI)
			GuideModule.GuideSubEnd(self.guideSubData.GuideSubID)
		end, self.guideSubData.GuideShowTime)

		self.timerClose:Start()
	end
end

function GuideUI:EnableObject(gameObject)
	local canvases = gameObject:GetComponentsInChildren(typeof(UnityEngine.Canvas))

	for i = 0, canvases.Length - 1 do
		canvases[i].enabled = true
	end

	local rayCasters = gameObject:GetComponentsInChildren(typeof(UnityEngine.UI.GraphicRaycaster))

	for i = 0, rayCasters.Length - 1 do
		rayCasters[i].enabled = true
	end
end

function GuideUI:OnTalkViewEnd(data)
	if self.timerClose then
		self.timerClose:Stop()

		self.timerClose = nil
	end

	UIModule.Close(Constant.UIControllerName.GuideUI)
	GuideModule.GuideSubEnd(data)
end

function GuideUI:OnBtnJump()
	UIModule.Close(Constant.UIControllerName.GuideUI)
	GuideModule.JumpGuide(self.guideID)
end

return GuideUI
