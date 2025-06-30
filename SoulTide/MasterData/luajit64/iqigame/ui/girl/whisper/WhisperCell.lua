-- chunkname: @IQIGame\\UI\\Girl\\Whisper\\WhisperCell.lua

local m = {}

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.BtnLinkLabel, GirlUIApi:GetString("WhisperBtnLinkLabel"))
	UGUIUtil.SetText(self.BtnPlayLabel, GirlUIApi:GetString("WhisperBtnPlayLabel"))

	function self.delegateBtnLink()
		self:OnBtnLink()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnLink:GetComponent("Button").onClick:AddListener(self.delegateBtnLink)
end

function m:RemoveListener()
	self.BtnLink:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLink)
end

function m:SetData(data)
	self.cfgWhisperListData = data

	self:UpdateView()
end

function m:UpdateView()
	local isUnlock = GirlModule.CheckWhisperUnlock(self.cfgWhisperListData.Id)

	self.UnLock:SetActive(isUnlock)
	self.Lock:SetActive(not isUnlock)
	UGUIUtil.SetText(self.UnlockName, self.cfgWhisperListData.Title)
	UGUIUtil.SetText(self.LockName, self.cfgWhisperListData.Title)
	UGUIUtil.SetText(self.TextCondition, self.cfgWhisperListData.LockingDescribe)
	self:RefreshStateAboutRes()
end

function m:OnBtnLink()
	if self.cfgWhisperListData.MallId > 0 then
		UIModule.Open(Constant.UIControllerName.BuyPanelUI, Constant.UILayer.UI, {
			mallCid = self.cfgWhisperListData.MallId
		})
	end
end

function m:RefreshStateAboutRes()
	self.BtnPlay:SetActive(self.Host.needUpdateResSize == 0)
	self.BtnDownload:SetActive(self.Host.needUpdateResSize > 0)

	if self.Host.needUpdateResSize > 0 then
		UGUIUtil.SetText(self.DownloadLabel, GirlUIApi:GetDownloadLabelText(self.Host.downloadProgress ~= nil))
		self.DLProgressView:SetActive(self.Host.downloadProgress ~= nil)

		if self.Host.downloadProgress ~= nil then
			self.DLProgressBar:GetComponent(typeof(UnityEngine.UI.Image)).fillAmount = self.Host.downloadProgress

			UGUIUtil.SetText(self.DLProgressText, math.round(self.Host.downloadProgress * 100) .. "%")
		end
	end
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
end

return m
