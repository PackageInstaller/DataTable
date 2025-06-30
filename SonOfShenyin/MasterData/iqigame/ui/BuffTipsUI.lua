-- chunkname: @IQIGame\\UI\\BuffTipsUI.lua

local BuffTipsUI = {}

BuffTipsUI = Base:Extend("BuffTipsUI", "IQIGame.Onigao.UI.BuffTipsUI", BuffTipsUI)

function BuffTipsUI:OnInit()
	return
end

function BuffTipsUI:GetPreloadAssetPaths()
	return nil
end

function BuffTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BuffTipsUI:IsManualShowOnOpen(userData)
	return false
end

function BuffTipsUI:GetBGM(userData)
	return nil
end

function BuffTipsUI:OnOpen(userData)
	local buffCid = userData.buffCid
	local worldPosition = userData.position
	local buffCfg = GlobalBuffModule.GetBuffCfg(buffCid)
	local buffData = GlobalBuffModule.GetBuffPODData(buffCid)

	self.NameText:GetComponent("Text").text = buffCfg.Name

	if LuaUtility.StrIsNullOrEmpty(buffCfg.Icon) then
		self.IconRoot.gameObject:SetActive(false)
	else
		self.IconRoot.gameObject:SetActive(true)
		self.Icon.gameObject:SetActive(true)

		local iconPath = UIGlobalApi.GetIconPath(buffCfg.Icon)

		AssetUtil.LoadImage(self, iconPath, self.Icon:GetComponent("Image"))
	end

	self.TipsText:GetComponent("Text").text = buffCfg.Describe

	local removeType = TryToNumber(buffCfg.RemoveType[1], 4)

	if removeType == 1 then
		LuaCodeInterface.SetGameObjectShow(self.TimeRoot.gameObject, true)

		self.TimeText:GetComponent("Text").text = UIGlobalApi.GetGlobalBuffTips(removeType)
	elseif removeType == 2 then
		LuaCodeInterface.SetGameObjectShow(self.TimeRoot.gameObject, true)

		self.TimeText:GetComponent("Text").text = UIGlobalApi.GetGlobalBuffTips(removeType)
	elseif removeType == 3 then
		local totalDurationTime = GlobalBuffModule.GetBuffDurationTime(buffCfg, buffData)

		self:__ShowDurationTime(buffData.createTime, totalDurationTime)
	elseif removeType == 4 then
		self:__HideDurationTime()
	end

	local leftCount = GlobalBuffModule.GetBuffTriggerCount(buffCfg, buffData)

	if leftCount > 0 then
		LuaCodeInterface.SetGameObjectShow(self.LeftRoot.gameObject, true)

		self.LeftText:GetComponent("Text").text = leftCount
	else
		LuaCodeInterface.SetGameObjectShow(self.LeftRoot.gameObject, false)
	end

	local screenPos = GameEntry.UICamera:WorldToScreenPoint(worldPosition)
	local _, resultPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.ContentRoot.transform.parent, screenPos, GameEntry.UICamera, nil)
	local sizeDelta = self.ContentRoot.transform.sizeDelta

	resultPos.x = resultPos.x + sizeDelta.x / 2 + 50

	if resultPos.x + sizeDelta.x > UnityEngine.Screen.width / 2 then
		resultPos.x = resultPos.x - sizeDelta.x
	end

	self.ContentRoot.transform.localPosition = resultPos
end

function BuffTipsUI:OnClose(userData)
	self:__HideDurationTime()
end

function BuffTipsUI:OnAddListeners()
	UIEventUtil.AddClickEventListener_Button(self, "buttonClose", self.__OnCloseBtnClickHandler)
end

function BuffTipsUI:OnRemoveListeners()
	UIEventUtil.ClearEventListener(self)
end

function BuffTipsUI:OnPause()
	return
end

function BuffTipsUI:OnResume()
	return
end

function BuffTipsUI:OnCover()
	return
end

function BuffTipsUI:OnReveal()
	return
end

function BuffTipsUI:OnRefocus(userData)
	return
end

function BuffTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BuffTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BuffTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BuffTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BuffTipsUI:OnDestroy()
	return
end

function BuffTipsUI:__OnCloseBtnClickHandler()
	UIModule.Close(Constant.UIControllerName.BuffTipsUI)
end

function BuffTipsUI:__ShowDurationTime(startTime, durationTime)
	local endTime = startTime + durationTime * 1000

	self.leftTime = (endTime - PlayerModule.GetServerTimeByMs()) / 1000

	LuaCodeInterface.SetGameObjectShow(self.TimeRoot.gameObject, true)

	if not self:__RefreshDurationTime() then
		return
	end

	self.durationTime = Timer.New(function()
		self.leftTime = self.leftTime - 1

		self:__RefreshDurationTime()
	end, 1, -1)

	self.durationTime:Start()
end

function BuffTipsUI:__RefreshDurationTime()
	if self.leftTime < 0 then
		self:__HideDurationTime()

		return false
	end

	local timeStr = DateTimeFormat(self.leftTime, "hh:mm:ss")

	self.TimeText:GetComponent("Text").text = timeStr

	return true
end

function BuffTipsUI:__HideDurationTime()
	LuaCodeInterface.SetGameObjectShow(self.TimeRoot.gameObject, false)

	if self.durationTime == nil then
		return
	end

	self.durationTime:Stop()

	self.durationTime = nil
end

return BuffTipsUI
