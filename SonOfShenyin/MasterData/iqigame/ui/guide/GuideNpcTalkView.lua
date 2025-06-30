-- chunkname: @IQIGame\\UI\\Guide\\GuideNpcTalkView.lua

local GuideNpcTalkView = {
	talkIndex = 0,
	talkRenders = {},
	npcTalks = {}
}
local GuideNpcTalkRender = require("IQIGame.UI.Guide.GuideNpcTalkRender")

function GuideNpcTalkView.__New(ui, parent)
	local o = Clone(GuideNpcTalkView)

	o:InitView(ui, parent)

	return o
end

function GuideNpcTalkView:InitView(ui, parent)
	self.rootParent = parent
	self.rootUI = ui

	self.rootUI:SetActive(false)

	function self.delegateSpineSpeakEnd()
		self:OnSpineSpeakEnd()
	end

	function self.delegateStart(data)
		self:OnStart(data)
	end

	function self.delegateEnd(data)
		self:OnEnd(data)
	end

	LuaCodeInterface.BindOutlet(self.rootUI, self)
	self:AddEventListener()
end

function GuideNpcTalkView:AddEventListener()
	return
end

function GuideNpcTalkView:RemoveEventListener()
	return
end

function GuideNpcTalkView:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuideNpcTalkView:OnUpdate(elapseSeconds, realElapseSeconds)
	if not self.IsGuiding then
		return
	end

	for _, v in pairs(self.talkRenders) do
		v:OnUpdate(elapseSeconds, realElapseSeconds)
	end
end

function GuideNpcTalkView:UpDateView()
	local cfgNpc = CfgNPCTable[self.guideModuleData[3]]

	if cfgNpc.Picture ~= nil then
		self:LoadNpcImage(cfgNpc)
	elseif cfgNpc.Spine ~= nil then
		if self.skeletonAnimation == nil then
			local path = UIGlobalApi.GetNpcPortraitPath(cfgNpc.Spine)

			AssetUtil.LoadAsset(self, path, self.OnLoadEffectAssetSucceed, self.OnLoadEffectAssetFailed)
		end
	elseif cfgNpc.LIve2D ~= nil then
		-- block empty
	end

	local col = self:HexToColor(self.guideModuleData[9])

	self.ImgBG:GetComponent("Image").color = col

	local top = self.guideModuleData[12] == 1 and true or false

	self.ImgBG:SetActive(top)
end

function GuideNpcTalkView:HexToColor(hex)
	local str = string.sub(hex, 2, 17)
	local s = string.sub(str, 1, 2)
	local r = tonumber(s, 16) / 255

	s = string.sub(str, 3, 4)

	local g = tonumber(s, 16) / 255

	s = string.sub(str, 5, 6)

	local b = tonumber(s, 16) / 255

	s = string.sub(str, 7, 8)

	local a = tonumber(s, 16) / 255

	return Color.New(r, g, b, a)
end

function GuideNpcTalkView:OnLoadEffectAssetSucceed(assetName, asset, duration, userData)
	self.npcObj = UnityEngine.Object.Instantiate(asset)

	self.npcObj.transform:SetParent(self.SpinePoint.transform, false)

	self.npcObj.transform.transform.localPosition = Vector3.New(self.guideModuleData[6], self.guideModuleData[7], 0)
	self.npcObj.transform.transform.localScale = Vector3.New(self.guideModuleData[4], self.guideModuleData[5], 1)
	self.skeletonAnimation = self.npcObj:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

	self:ShowNpc()
end

function GuideNpcTalkView:OnLoadEffectAssetSucceed(assetName, asset, duration, userData)
	self.npcObj = UnityEngine.Object.Instantiate(asset)

	self.npcObj.transform:SetParent(self.SpinePoint.transform, false)

	self.npcObj.transform.transform.localPosition = Vector3.New(self.guideModuleData[6], self.guideModuleData[7], 0)
	self.npcObj.transform.transform.localScale = Vector3.New(self.guideModuleData[4], self.guideModuleData[5], 1)

	self:ShowNpc()
end

function GuideNpcTalkView:LoadNpcImage(Npccfg)
	if not self.ImageNpc then
		self.ImageNpc = GameObject.New()
		self.ImageNpc.name = "NPC"

		self.ImageNpc:AddComponent(typeof(UnityEngine.UI.Image))
	end

	local c = self.ImageNpc:GetComponent(typeof(UnityEngine.UI.Image))

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(Npccfg.Picture), c, self.LoadImageSucess, nil, c)
end

function GuideNpcTalkView:LoadImageSucess(assetName, asset, duration, userData)
	userData:SetNativeSize()
	self.ImageNpc.transform:SetParent(self.SpinePoint.transform, false)

	self.ImageNpc.transform.transform.localPosition = Vector3.New(self.guideModuleData[6], self.guideModuleData[7], 0)
	self.ImageNpc.transform.transform.localScale = Vector3.New(self.guideModuleData[4], self.guideModuleData[5], 1)
end

function GuideNpcTalkView:OnLoadEffectAssetFailed(assetName, status, errorMessage, userData)
	log(assetName .. " 加载失败 msg = " .. errorMessage)
end

function GuideNpcTalkView:ShowNpc()
	local isShowLevel2d = self.guideModuleData[13] == 1 and true or false

	self.rootUI:SetActive(true)
end

function GuideNpcTalkView:Speak(cvId)
	local cvData = CfgCVTable[cvId]

	if cvData ~= nil and self.skeletonAnimation then
		if cvData.SpineActionName ~= nil and cvData.SpineActionName ~= "" then
			self.skeletonAnimation.AnimationName = nil

			self.skeletonAnimation.state:SetEmptyAnimation(0, 0)
			self.skeletonAnimation.state:SetAnimation(0, cvData.SpineActionName, false)

			self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete + self.delegateSpineSpeakEnd
		else
			self.skeletonAnimation.AnimationName = nil

			self.skeletonAnimation.state:SetEmptyAnimation(0, 0)
			self.skeletonAnimation.state:SetAnimation(0, "Idle", true)
		end
	end
end

function GuideNpcTalkView:OnSpineSpeakEnd()
	self.skeletonAnimation.AnimationName = nil

	self.skeletonAnimation.state:SetEmptyAnimation(0, 0)
	self.skeletonAnimation.state:SetAnimation(0, "Idle", true)
end

function GuideNpcTalkView:UpDatePose()
	return
end

function GuideNpcTalkView:OnStart(data)
	self.guideModuleData = data.guideModuleData

	self:UpDateView()
end

function GuideNpcTalkView:OnEnd(data)
	self.talkIndex = data.index

	if self.talkIndex >= #self.npcTalks then
		self:Close()
		self.rootParent:ShowGuideNext()
	else
		local nextTalkRender = self.talkRenders[self.talkIndex + 1]

		nextTalkRender:OpenImmediately()
	end
end

function GuideNpcTalkView:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
	self.rootParent = nil
end

function GuideNpcTalkView:Open(data, guideSubID)
	self.npcTalks = data
	self.guideSubID = guideSubID
	self.talkRenders = {}
	self.talkIndex = 0

	for i = 1, #self.npcTalks do
		local data = self.npcTalks[i]
		local objTalk = UnityEngine.GameObject.Instantiate(self.TalkMould, self.TalkNode.transform)

		LuaUtility.SetGameObjectShow(objTalk, false)

		local talkRender = GuideNpcTalkRender.__New(objTalk, i)

		talkRender.startCallBack = self.delegateStart
		talkRender.endCallBack = self.delegateEnd

		table.insert(self.talkRenders, talkRender)

		if i == 1 then
			talkRender:Open(data, true)
		else
			talkRender:Open(data, false)
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.rootUI.transform)
	self:Show()

	self.IsGuiding = true
end

function GuideNpcTalkView:Close()
	self.IsGuiding = false

	self:Hide()
end

function GuideNpcTalkView:TriggerSelf()
	return
end

function GuideNpcTalkView:Hide()
	LuaUtility.SetGameObjectShow(self.rootUI, false)
end

function GuideNpcTalkView:Show()
	LuaUtility.SetGameObjectShow(self.rootUI, true)
end

return GuideNpcTalkView
