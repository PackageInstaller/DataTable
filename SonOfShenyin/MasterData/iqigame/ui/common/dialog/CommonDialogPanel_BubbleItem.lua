-- chunkname: @IQIGame\\UI\\Common\\Dialog\\CommonDialogPanel_BubbleItem.lua

local CommonDialogPanel_BubbleItem = {}
local WORD_SPAN = CfgUtil.GetDiscreteDataWithID(Constant.DiscreteData.DialogTextTime)[1] / 1000
local NEXT_DELAY = CfgUtil.GetDiscreteDataWithID(Constant.DiscreteData.DialogTextTime)[2] / 1000
local DisplayAlpha = "_DisplayAlpha"

function CommonDialogPanel_BubbleItem.New(go, mainView)
	local o = Clone(CommonDialogPanel_BubbleItem)

	o:Initialize(go, mainView)

	return o
end

function CommonDialogPanel_BubbleItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitDelegate()
	self:AddListener()
	self:InitComponent()
end

function CommonDialogPanel_BubbleItem:InitComponent()
	self.npcNameTextBackgroundSource = self.speakerName:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))
	self.contentTextBackgroundSource = self.speakContent:GetComponent(typeof(BordlessFramework.UI.TextBackgroundSource))
	self.nameBackground = self.speakerNameBackground:GetComponent(typeof(BordlessFramework.UI.TextBackground))
	self.contentBackground = self.speakContentBackground:GetComponent(typeof(BordlessFramework.UI.TextBackground))

	LuaUtility.ResetTextBackGround(self.speakerNameBackground)
	LuaUtility.ResetTextBackGround(self.speakContentBackground)

	self.FloatEffectComponent = LuaUtility.GameObjectGetOrAddComponent(self.gameObject, typeof(IQIGame.Onigao.Game.FloatEffectComponent))

	local publicParametersData = CfgUtil.GetPublicParametersData()
	local SpeakViewFloatOffset = publicParametersData.SpeakViewFloatOffset
	local v = Vector3.New(SpeakViewFloatOffset.x, SpeakViewFloatOffset.y, 0)

	self.FloatEffectComponent:Init(v, publicParametersData.SpeakViewFloatFrequency)

	self.UIFollowerComponent = LuaUtility.GameObjectGetOrAddComponent(self.gameObject, typeof(UIFollower))
	self.canvas = self.CommonDialogPanel:GetComponent(typeof(UnityEngine.Canvas))
	self.timer = ModuleTimerUtil.NewFrameTimer(self, function()
		LuaUtility.SetGameObjectShow(self.speakerNameBackground, false)
		LuaUtility.SetGameObjectShow(self.speakerNameBackground, true)

		if self.timer then
			self.timer:Stop()

			self.timer = nil
		end
	end, 1, 1):Start()

	self:Hide()
end

function CommonDialogPanel_BubbleItem:InitDelegate()
	function self.delegateOnClickButtonConfirm()
		self:OnClickButtonConfirm()
	end
end

function CommonDialogPanel_BubbleItem:AddListener()
	self.buttonConfirm:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonConfirm)
end

function CommonDialogPanel_BubbleItem:RemoveListener()
	if self.buttonConfirm then
		self.buttonConfirm:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonConfirm)
	end
end

function CommonDialogPanel_BubbleItem:OnClickButtonConfirm()
	if self.isFree then
		return
	end

	if self.isShowAll then
		self.confirmEnd = true
	else
		self.duration = 0.1
	end
end

function CommonDialogPanel_BubbleItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
	self:AddListener()
end

function CommonDialogPanel_BubbleItem:Hide()
	self:RemoveListener()

	self.isShowAll = true

	if self.co then
		coroutine.stop(self.co)

		self.co = nil
	end

	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function CommonDialogPanel_BubbleItem:Refresh(mountPoint, name, text, duration, uiPoint, notUseAuto)
	self:StopCoroutine()

	self.isFree = false
	self.mountPoint = mountPoint
	self.notUseAuto = notUseAuto
	self.isEmpty = false

	if duration and duration > 0 then
		self.duration = duration
	else
		self.duration = utf8.len(text) * WORD_SPAN
	end

	self.confirmEnd = false
	self.dStartTime = Time.time
	self.isShowAll = false

	if uiPoint then
		self.UIFollowerComponent:Init(GameEntry.UICamera, GameEntry.UICamera, mountPoint.transform, self.canvas)
	else
		self.UIFollowerComponent:Init(UnityEngine.Camera.main, GameEntry.UICamera, mountPoint.transform, self.canvas)
		self.UIFollowerComponent:LimitUIInScreen(self.Root:GetComponent("RectTransform"), 10)
	end

	self.mainView:SetSetConfirmButtonShow(true)

	if LuaUtility.StrIsNullOrEmpty(text) then
		self.isEmpty = true

		return
	end

	LuaUtility.SetText(self.speakerName, name)
	LuaUtility.SetText(self.speakContent, text)
	LuaUtility.ResetTextBackGround(self.speakerNameBackground)
	self.npcNameTextBackgroundSource:SetProgress(1)
	self.contentTextBackgroundSource:SetProgress(0)
	LuaUtility.SetGameObjectShow(self.imageCanGoNext, false)
	self:Show()
end

function CommonDialogPanel_BubbleItem:IsFree()
	return self.isFree
end

function CommonDialogPanel_BubbleItem:Free()
	self.isFree = true
end

function CommonDialogPanel_BubbleItem:Update()
	if self.isFree then
		return
	end

	if self.isShowAll then
		return
	end

	local elapsedTime = Time.time - self.dStartTime
	local progress = math.min(1, elapsedTime / self.duration)

	self.contentTextBackgroundSource:SetProgress(progress)

	if progress == 1 then
		self.isShowAll = true

		LuaUtility.SetGameObjectShow(self.imageCanGoNext, true)
		self.contentTextBackgroundSource:SetEndFlag()

		if self:_GetIsAuto() then
			self.co = coroutine.start(function()
				coroutine.wait(NEXT_DELAY)
				self:Hide()
				EventDispatcher.Dispatch(EventID.CommonDialogPanel_OnBubbleShowComplete, self.mountPoint)
			end)
		else
			self.co = coroutine.start(function()
				coroutine.Until(function()
					if self:_GetIsAuto() or self.isEmpty then
						return true
					end

					return self.confirmEnd
				end)
				self:Hide()
				EventDispatcher.Dispatch(EventID.CommonDialogPanel_OnBubbleShowComplete, self.mountPoint)
			end)
		end
	end
end

function CommonDialogPanel_BubbleItem:_GetIsAuto()
	return not self.notUseAuto and ConversationModule.isAuto
end

function CommonDialogPanel_BubbleItem:StopCoroutine()
	if self.co then
		coroutine.stop(self.co)

		self.co = nil
	end
end

function CommonDialogPanel_BubbleItem:OnDestroy()
	self:RemoveListener()

	if self.co then
		coroutine.stop(self.co)

		self.co = nil
	end

	self.npcNameTextBackgroundSource = nil
	self.contentTextBackgroundSource = nil
	self.nameBackground = nil
	self.contentBackground = nil
	self.FloatEffectComponent = nil
	self.UIFollowerComponent = nil
	self.mountPoint = nil
	self.canvas = nil
	self.isFree = true

	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	GameObject.Destroy(self.gameObject)

	self.gameObject = nil
end

return CommonDialogPanel_BubbleItem
