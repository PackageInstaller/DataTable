-- chunkname: @IQIGame\\UI\\Main\\MainUIWhisperDLController.lua

local m = {
	soulCid = 0,
	updateTotalLength = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelf()
		self:OnClickSelf()
	end

	function self.DelegateOnResourceUpdateChanged(sender, args)
		self:OnResourceUpdateChanged(sender, args)
	end
end

function m:AddListeners()
	self.View:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.DelegateOnClickSelf)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ResourceUpdateChangedEventArgs.EventId, self.DelegateOnResourceUpdateChanged)
end

function m:RemoveListeners()
	self.View:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.DelegateOnClickSelf)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ResourceUpdateChangedEventArgs.EventId, self.DelegateOnResourceUpdateChanged)
end

function m:SetData(soulCid, updateTotalLength)
	self.soulCid = soulCid
	self.updateTotalLength = updateTotalLength

	self.View:SetActive(updateTotalLength > 0)

	if updateTotalLength <= 0 then
		return
	end

	self:RefreshDownloadingState()
end

function m:RefreshDownloadingState()
	local isDownloading = ResourceUpdateChecker.isDownloading

	self.BtnMainText:GetComponent(typeof(UnityEngine.UI.Text)).text = MainUIApi:GetWhisperUpdateBtnText(isDownloading)

	self.ProgressView:SetActive(isDownloading)
end

function m:OnClickSelf()
	if ResourceUpdateChecker.isDownloading then
		NoticeModule.ShowNotice(21045075)

		return
	end

	local sizeStr = ResourceUpdateChecker.GetSizeStr(self.updateTotalLength)

	NoticeModule.ShowNotice(21045080, function()
		local resTag = SoulModule.GetWhisperResTag(self.soulCid)

		if ResourceUpdateChecker.checkingTags == nil or ResourceUpdateChecker.checkingTags[1] ~= resTag then
			ResourceUpdateChecker.CheckResourcesByTag(resTag, function(pTag, updateCount, updateTotalLength)
				if self.View == nil then
					return
				end

				if updateTotalLength > 0 then
					self:UpdateRes()
				elseif pTag == SoulModule.GetWhisperResTag(SoulModule.curSoulData.soulCid) then
					self:SetData(SoulModule.curSoulData.soulCid, 0)
				end
			end)
		else
			self:UpdateRes()
		end
	end, nil, nil, sizeStr)
end

function m:UpdateRes()
	self.ProgressView:SetActive(true)

	self.BtnMainText:GetComponent(typeof(UnityEngine.UI.Text)).text = MainUIApi:GetWhisperUpdateBtnText(true)

	self:UpdateProgress(0)
	ResourceUpdateChecker.UpdateResourcesByTag(self.soulCid)
end

function m:OnResourceUpdateChanged(sender, args)
	local info = args.UserData

	self:UpdateProgress(info.ProcessNormalize)
end

function m:UpdateProgress(ratio)
	local progressImage = self.ProgressBar:GetComponent(typeof(UnityEngine.UI.Image))

	progressImage.fillAmount = ratio

	local textField = self.ProgressText:GetComponent(typeof(UnityEngine.UI.Text))

	textField.text = math.round(ratio * 100) .. "%"
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
