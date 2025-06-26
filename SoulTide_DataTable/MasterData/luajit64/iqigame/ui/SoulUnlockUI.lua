-- chunkname: @IQIGame\\UI\\SoulUnlockUI.lua

local SoulUnlockUI = Base:Extend("SoulUnlockUI", "IQIGame.Onigao.UI.SoulUnlockUI", {
	btnContinue = false,
	btnUnlock = false,
	timeSum = 0,
	effectId_1 = 9001121,
	effectId_2 = 9001120,
	canUnlockIDList = {}
})
local SoulUnlockDetailView = require("IQIGame.UI.SoulUnlock.SoulUnlockDetailView")

function SoulUnlockUI:OnInit()
	self:Initialize()
end

function SoulUnlockUI:GetPreloadAssetPaths()
	return nil
end

function SoulUnlockUI:GetOpenPreloadAssetPaths(userData)
	return self:PreloadAssetOnOpen(userData)
end

function SoulUnlockUI:OnOpen(userData)
	self:RefreshView(userData)
end

function SoulUnlockUI:OnClose(userData)
	self:Dispose()
	EventDispatcher.Dispatch(EventID.CloseSoulUnlockUI, self.type, self.index)
	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "CloseSoulUnlockUI")
end

function SoulUnlockUI:OnPause()
	return
end

function SoulUnlockUI:OnResume()
	return
end

function SoulUnlockUI:OnCover()
	return
end

function SoulUnlockUI:OnReveal()
	return
end

function SoulUnlockUI:OnRefocus(userData)
	return
end

function SoulUnlockUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.startContinueTimer == true then
		self.timer = self.timer + elapseSeconds

		if self.timer >= 1.5 then
			self.enableClickContinue = true
			self.startContinueTimer = false
			self.timer = 0
		end
	end
end

function SoulUnlockUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SoulUnlockUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SoulUnlockUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulUnlockUI:PreloadAssetOnOpen(userData)
	self.canUnlockIDList = userData[UIParam.soulUnlockUI.soulIds]
	self.type = userData[UIParam.soulUnlockUI.type]
	self.index = userData[UIParam.soulUnlockUI.index]

	local ret = {}

	for i, v in pairs(self.canUnlockIDList) do
		local soulData = SoulData.New()

		soulData:Initialize(v)

		ret[#ret + 1] = UIGlobalApi.ImagePath .. soulData:GetCfgSoulRes2D().SoulSoulImage
		ret[#ret + 1] = UIGlobalApi.GetImagePath(soulData:GetCfgSoul().FragmentIcon)
	end

	return ret
end

function SoulUnlockUI:Initialize()
	self.detailView = SoulUnlockDetailView.New(self.goDetailView)
	self.timerProgress = Timer.New(function()
		self:OnTimer()
	end, 0.1, -1)
	self.imgHead = self.goSoulHead:GetComponent("Image")
	self.btnContinue = self.goBtnContinue:GetComponent("Button")
	self.btnUnlock = self.goBtnUnlock:GetComponent("Button")

	function self.onClickContinueDelegate()
		self:OnClickBtnContinue()
	end

	function self.onClickBtnUnlockDelegate()
		self:OnClickBtnUnlock()
	end

	function self.onSoulUnlockFailureDelegate()
		self:OnSoulUnlockFailure()
	end

	function self.onSoulUnlockSuccessDelegate(soulID)
		self:OnSoulUnlockSuccess(soulID)
	end
end

function SoulUnlockUI:RefreshView(userData)
	if self.type == nil then
		self.type = 1
	end

	self:Reset()
	self:RefreshDatum()
	self:RefreshMisc()
	self:RefreshSoulHead()
	self:ShowEffect1()
	self:LoadAsset(4)
	self.detailView:RefreshView(self.soulData, self.type, self.soulData.insecureNotFirstUnlock)

	if self.type == 2 then
		self.detailView:SetVisible(true)
		self.goBtnContinue:SetActive(true)
		self.detailView:SetVoiceVisible(true)

		self.startContinueTimer = true
	end
end

function SoulUnlockUI:Reset()
	self:StopEffect(self.effectId_1)
	self:StopEffect(self.effectId_2)
	self:StopTimer()

	self.enableClickUnlock = true
	self.startContinueTimer = false
	self.timer = 0
	self.enableClickContinue = false
end

function SoulUnlockUI:Dispose()
	if self.detailView ~= nil then
		self.detailView:OnHide()
	end

	self:Reset()
	EventDispatcher.Dispatch(EventID.RefreshSoulList)
end

function SoulUnlockUI:OnDestroy()
	self.detailView:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function SoulUnlockUI:RefreshDatum()
	local soulCid = self.canUnlockIDList[1]

	self.soulData = SoulModule.GetSoulData(soulCid)

	if self.soulData == nil then
		self.soulData = SoulData.New()

		self.soulData:Initialize(soulCid)
	end

	table.remove(self.canUnlockIDList, 1)
end

function SoulUnlockUI:RefreshMisc()
	self.detailView:SetVisible(false)
	self.goBtnContinue:SetActive(false)
	self.goUnlock:SetActive(self.type == 1)
end

function SoulUnlockUI:RefreshSoulHead()
	if self.type == 1 then
		self.goSoulHead:SetActive(true)
		self:LoadAsset(2)
	else
		self.goSoulHead:SetActive(false)
	end
end

function SoulUnlockUI:ShowEffect1()
	if self.type ~= 1 then
		return
	end

	self:PlayEffect(self.effectId_1, self.goUnlock)
end

function SoulUnlockUI:ShowEffect2()
	self:PlayEffect(self.effectId_2, self.goUnlock)
	self:StartTimer()
end

function SoulUnlockUI:LoadAsset(sourceType)
	local path

	if sourceType == 1 then
		-- block empty
	elseif sourceType == 2 then
		path = UIGlobalApi.GetImagePath(self.soulData:GetCfgSoul().FragmentIcon)
	elseif sourceType == 3 then
		-- block empty
	elseif sourceType == 4 then
		path = UIGlobalApi.GetSoulPortraitPath(self.soulData.soulCid, self.soulData:GetCfgSoulRes2D().Id)
	end

	AssetUtil.LoadAsset(self, path, self.OnLoadAssetSucceed, self.OnLoadAssetFailed, sourceType)
end

function SoulUnlockUI:StartTimer()
	self.timeSum = 0

	self.timerProgress:Start()
	self.goBtnContinue:SetActive(false)
end

function SoulUnlockUI:StopTimer()
	self.timerProgress:Stop()
end

function SoulUnlockUI:PlayEffect(id, goParent)
	self:StopEffect(self.curEffectId)

	self.curEffectId = GameEntry.Effect:PlayUIMountPointEffect(id, 50000, 0, goParent, 0)
end

function SoulUnlockUI:StopEffect(effectId)
	if effectId ~= nil then
		GameEntry.Effect:StopEffect(effectId)
	end
end

function SoulUnlockUI:OnTimer()
	local durationProgress1 = SoulUnlockUIApi:GetString("durationProgress", 1)
	local durationProgress2 = SoulUnlockUIApi:GetString("durationProgress", 2)

	self.timeSum = self.timeSum + 0.1

	if durationProgress1 <= self.timeSum and self.timeSum < durationProgress1 + 0.1 then
		self.detailView:SetVisible(true)
		self.goBtnContinue:SetActive(true)
		self.detailView:SetVoiceVisible(true)
	elseif durationProgress2 <= self.timeSum and self.timeSum < durationProgress2 + 0.1 then
		self:StopTimer()

		self.startContinueTimer = false
		self.timer = 0
		self.enableClickContinue = true

		self.goBtnContinue:SetActive(true)
	end
end

function SoulUnlockUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.SoulUnlockFailure, self.onSoulUnlockFailureDelegate)
	EventDispatcher.AddEventListener(EventID.SoulUnlockSuccess, self.onSoulUnlockSuccessDelegate)
	self.btnContinue.onClick:AddListener(self.onClickContinueDelegate)
	self.btnUnlock.onClick:AddListener(self.onClickBtnUnlockDelegate)
end

function SoulUnlockUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.SoulUnlockFailure, self.onSoulUnlockFailureDelegate)
	EventDispatcher.RemoveEventListener(EventID.SoulUnlockSuccess, self.onSoulUnlockSuccessDelegate)
	self.btnContinue.onClick:RemoveListener(self.onClickContinueDelegate)
	self.btnUnlock.onClick:RemoveListener(self.onClickBtnUnlockDelegate)
end

function SoulUnlockUI:OnLoadAssetSucceed(assetName, asset, duration, userData)
	local sourceType = userData

	if sourceType == 1 then
		-- block empty
	elseif sourceType == 2 then
		self.imgHead.sprite = LuaCodeInterface.ToSprite(asset)
	elseif sourceType == 3 then
		-- block empty
	elseif sourceType == 4 then
		self.detailView:ShowSoul(asset)
	end
end

function SoulUnlockUI:OnLoadAssetFailed(assetName, status, errorMessage, userData)
	return
end

function SoulUnlockUI:OnClickBtnContinue()
	if self.enableClickContinue then
		if #self.canUnlockIDList > 0 then
			self:RefreshView({
				[UIParam.soulUnlockUI.soulIds] = self.canUnlockIDList,
				[UIParam.soulUnlockUI.type] = self.type
			})
		else
			UIModule.Close(Constant.UIControllerName.SoulUnlockUI)
		end
	end
end

function SoulUnlockUI:OnClickBtnUnlock()
	if self.enableClickUnlock == true then
		GameEntry.Sound:PlaySound(10213, Constant.SoundGroup.UI)
		SoulModule.ReqUnlockSoul(self.soulData.soulCid)
	end

	self.enableClickUnlock = false
end

function SoulUnlockUI:OnSoulUnlockFailure()
	UIModule.Close(Constant.UIControllerName.SoulUnlockUI)
end

function SoulUnlockUI:OnSoulUnlockSuccess(soulCid)
	self.goSoulHead:SetActive(false)
	self:ShowEffect2()
end

return SoulUnlockUI
