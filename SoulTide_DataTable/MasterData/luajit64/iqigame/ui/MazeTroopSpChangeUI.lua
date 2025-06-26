-- chunkname: @IQIGame\\UI\\MazeTroopSpChangeUI.lua

local MazeTroopSpChangeUI = Base:Extend("MazeTroopSpChangeUI", "IQIGame.Onigao.UI.MazeTroopSpChangeUI", {
	FinishedTweenNum = 0
})
local MazeTroopSpChangeItem = require("IQIGame.UI.MazeTroopSpChange.MazeTroopSpChangeItem")

function MazeTroopSpChangeUI:OnInit()
	self.AddViewController = MazeTroopSpChangeItem.New(self.AddView, true)
	self.ReduceViewController = MazeTroopSpChangeItem.New(self.ReduceView, false)
	self.Tweens = self.gameObject:GetComponentsInChildren(typeof(UITweener))

	for i = 0, self.Tweens.Length - 1 do
		self.Tweens[i]:SetOnFinished(function()
			self.FinishedTweenNum = self.FinishedTweenNum + 1

			if self.FinishedTweenNum == self.Tweens.Length then
				self.FinishedTweenNum = 0

				UIModule.Close(Constant.UIControllerName.MazeTroopSpChangeUI)
			end
		end)
	end
end

function MazeTroopSpChangeUI:GetPreloadAssetPaths()
	return nil
end

function MazeTroopSpChangeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeTroopSpChangeUI:OnOpen(userData)
	local percentage = userData.percentage

	self.AddView:SetActive(percentage > 0)
	self.ReduceView:SetActive(percentage < 0)

	if percentage > 0 then
		self.AddViewController:SetData(percentage)
	else
		self.ReduceViewController:SetData(percentage)
	end

	self.Root:SetActive(true)
end

function MazeTroopSpChangeUI:OnClose(userData)
	for i = 0, self.Tweens.Length - 1 do
		local tween = self.Tweens[i]

		tween:ResetToBeginning()

		tween.enabled = true
	end

	self.Root:SetActive(false)
end

function MazeTroopSpChangeUI:OnAddListeners()
	return
end

function MazeTroopSpChangeUI:OnRemoveListeners()
	return
end

function MazeTroopSpChangeUI:OnPause()
	return
end

function MazeTroopSpChangeUI:OnResume()
	return
end

function MazeTroopSpChangeUI:OnCover()
	return
end

function MazeTroopSpChangeUI:OnReveal()
	return
end

function MazeTroopSpChangeUI:OnRefocus(userData)
	return
end

function MazeTroopSpChangeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeTroopSpChangeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeTroopSpChangeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeTroopSpChangeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeTroopSpChangeUI:OnDestroy()
	return
end

return MazeTroopSpChangeUI
