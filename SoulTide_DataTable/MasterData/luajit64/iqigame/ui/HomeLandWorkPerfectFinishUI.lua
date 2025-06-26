-- chunkname: @IQIGame\\UI\\HomeLandWorkPerfectFinishUI.lua

local HomeLandWorkPerfectFinishUI = Base:Extend("HomeLandWorkPerfectFinishUI", "IQIGame.Onigao.UI.HomeLandWorkPerfectFinishUI", {})

function HomeLandWorkPerfectFinishUI:OnInit()
	self:Initialize()
end

function HomeLandWorkPerfectFinishUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandWorkPerfectFinishUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandWorkPerfectFinishUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandWorkPerfectFinishUI:GetBGM(userData)
	return nil
end

function HomeLandWorkPerfectFinishUI:OnOpen(userData)
	self:Refresh(userData)
end

function HomeLandWorkPerfectFinishUI:OnClose(userData)
	return
end

function HomeLandWorkPerfectFinishUI:OnAddListeners()
	return
end

function HomeLandWorkPerfectFinishUI:OnRemoveListeners()
	return
end

function HomeLandWorkPerfectFinishUI:OnPause()
	return
end

function HomeLandWorkPerfectFinishUI:OnResume()
	return
end

function HomeLandWorkPerfectFinishUI:OnCover()
	return
end

function HomeLandWorkPerfectFinishUI:OnReveal()
	return
end

function HomeLandWorkPerfectFinishUI:OnRefocus(userData)
	return
end

function HomeLandWorkPerfectFinishUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.counter = self.counter + elapseSeconds

	if self.counter >= self.duration then
		UIModule.CloseSelf(self)

		if self.rewards ~= nil then
			NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, self.rewards)
		end
	end
end

function HomeLandWorkPerfectFinishUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandWorkPerfectFinishUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandWorkPerfectFinishUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandWorkPerfectFinishUI:OnDestroy()
	return
end

function HomeLandWorkPerfectFinishUI:Initialize()
	self.goDesc:GetComponent("Text").text = HomeLandWorkSoulUIApi:GetString("perfectSuccessUIDesc")
	self.duration = HomeLandWorkSoulUIApi:GetString("perfectSuccessUIDuration")
end

function HomeLandWorkPerfectFinishUI:Refresh(userData)
	self.rewards = userData
	self.counter = 0
end

return HomeLandWorkPerfectFinishUI
