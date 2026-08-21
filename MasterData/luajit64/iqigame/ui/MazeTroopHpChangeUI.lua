-- chunkname: @IQIGame\\UI\\MazeTroopHpChangeUI.lua

local MazeTroopHpChangeUI = Base:Extend("MazeTroopHpChangeUI", "IQIGame.Onigao.UI.MazeTroopHpChangeUI", {
	FinishedTweenNum = 0
})
local MazeTroopHpChangeItem = require("IQIGame.UI.MazeTroopHpChange.MazeTroopHpChangeItem")

function MazeTroopHpChangeUI:OnInit()
	self.AddViewController = MazeTroopHpChangeItem.New(self.AddView, true)
	self.ReduceViewController = MazeTroopHpChangeItem.New(self.ReduceView, false)
	self.Tweens = self.gameObject:GetComponentsInChildren(typeof(UITweener))

	for i = 0, self.Tweens.Length - 1 do
		self.Tweens[i]:SetOnFinished(function()
			self.FinishedTweenNum = self.FinishedTweenNum + 1

			if self.FinishedTweenNum == self.Tweens.Length then
				self.FinishedTweenNum = 0

				UIModule.Close(Constant.UIControllerName.MazeTroopHpChangeUI)
			end
		end)
	end
end

function MazeTroopHpChangeUI:GetPreloadAssetPaths()
	return nil
end

function MazeTroopHpChangeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeTroopHpChangeUI:OnOpen(userData)
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

function MazeTroopHpChangeUI:OnClose(userData)
	for i = 0, self.Tweens.Length - 1 do
		local tween = self.Tweens[i]

		tween:ResetToBeginning()

		tween.enabled = true
	end

	self.Root:SetActive(false)
end

function MazeTroopHpChangeUI:OnAddListeners()
	return
end

function MazeTroopHpChangeUI:OnRemoveListeners()
	return
end

function MazeTroopHpChangeUI:OnPause()
	return
end

function MazeTroopHpChangeUI:OnResume()
	return
end

function MazeTroopHpChangeUI:OnCover()
	return
end

function MazeTroopHpChangeUI:OnReveal()
	return
end

function MazeTroopHpChangeUI:OnRefocus(userData)
	return
end

function MazeTroopHpChangeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeTroopHpChangeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeTroopHpChangeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeTroopHpChangeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeTroopHpChangeUI:OnDestroy()
	return
end

return MazeTroopHpChangeUI
