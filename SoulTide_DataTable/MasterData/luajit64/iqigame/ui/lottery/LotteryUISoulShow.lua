-- chunkname: @IQIGame\\UI\\Lottery\\LotteryUISoulShow.lua

local m = {}
local SoulUnlockDetailView = require("IQIGame.UI.SoulUnlock.SoulUnlockDetailView")

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.SoulUnlockDetailView = SoulUnlockDetailView.New(self.Panel)
end

function m:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function m:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function m:Show(userData)
	self.OnCloseCallback = userData.onClose

	self.View:SetActive(true)
	self.SoulUnlockDetailView:SetVisible(false)
	self.SoulUnlockDetailView:SetVoiceVisible(false)

	local soulData = SoulModule.GetSoulData(userData.soulCid)

	if soulData == nil then
		logError("祈愿错误，灵魂解锁界面SoulData == nil, soulCid: " .. tostring(userData.soulCid) .. " item id: " .. (userData.cfgItemData ~= nil and userData.cfgItemData.Id or "nil"))

		return
	end

	self.SoulUnlockDetailView:RefreshView(soulData, 0, not userData.isNew)
	AssetUtil.LoadAsset(self, UIGlobalApi.GetSoulPortraitPath(soulData.soulCid, soulData:GetOriginalCfgSoulRes2D().Id), self.OnLoadSuccess, self.OnLoadFail, soulData)
end

function m:OnLoadSuccess(assetName, asset, duration, userData)
	self.SoulUnlockDetailView:ShowSoul(asset)
	self.SoulUnlockDetailView:SetVisible(true)
	self.SoulUnlockDetailView:SetVoiceVisible(true)
end

function m:OnLoadFail(assetName, status, errorMessage, userData)
	return
end

function m:Hide()
	self.View:SetActive(false)
end

function m:OnClickCloseBtn()
	self:Hide()

	if self.OnCloseCallback ~= nil then
		self.OnCloseCallback()
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self.SoulUnlockDetailView:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
