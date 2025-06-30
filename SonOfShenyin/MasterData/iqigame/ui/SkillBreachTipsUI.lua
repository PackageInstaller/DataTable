-- chunkname: @IQIGame\\UI\\SkillBreachTipsUI.lua

local SkillBreachTipsUI = {
	presentStatItemList = {}
}

SkillBreachTipsUI = Base:Extend("SkillBreachTipsUI", "IQIGame.Onigao.UI.SkillBreachTipsUI", SkillBreachTipsUI)

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local diyBreachStarItemCell = require("IQIGame.UI.DiySkill.Strengthen.DiyBreachStarItemCell")
local diyBreachAttrItemCell = require("IQIGame.UI.DiySkill.Strengthen.DiyBreachAttrItemCell")

function SkillBreachTipsUI:OnInit()
	self:InitComponent()
	self:InitDelegate()
end

function SkillBreachTipsUI:InitComponent()
	self.attributeObjectPool = UIViewObjectPool.New(self.propertyPrefab, self.propertyContent.transform, function(_view)
		return diyBreachAttrItemCell.New(_view)
	end)
	self.closeBtnCom = self.CloseBtn:GetComponent("Button")
	self.currentBreachStars = self.currentBreachStars:GetComponent("StartsHelperComponent")
	self.lastBreachStars = self.lastBreachStars:GetComponent("StartsHelperComponent")
end

function SkillBreachTipsUI:InitDelegate()
	function self.DelegateOnCloseBtnClick()
		UIModule.CloseSelf(self)
	end
end

function SkillBreachTipsUI:GetPreloadAssetPaths()
	return nil
end

function SkillBreachTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SkillBreachTipsUI:IsManualShowOnOpen(userData)
	return false
end

function SkillBreachTipsUI:GetBGM(userData)
	return nil
end

function SkillBreachTipsUI:OnOpen(userData)
	self.skillData = userData.curSkillData
	self.skillAttributes = userData.SkillAttributes

	self:RefreshSkillInfo()
end

function SkillBreachTipsUI:OnClose(userData)
	return
end

function SkillBreachTipsUI:OnAddListeners()
	self.closeBtnCom.onClick:AddListener(self.DelegateOnCloseBtnClick)
end

function SkillBreachTipsUI:OnRemoveListeners()
	self.closeBtnCom.onClick:RemoveListener(self.DelegateOnCloseBtnClick)
end

function SkillBreachTipsUI:OnPause()
	return
end

function SkillBreachTipsUI:OnResume()
	return
end

function SkillBreachTipsUI:OnCover()
	return
end

function SkillBreachTipsUI:OnReveal()
	return
end

function SkillBreachTipsUI:OnRefocus(userData)
	return
end

function SkillBreachTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SkillBreachTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SkillBreachTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SkillBreachTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SkillBreachTipsUI:OnDestroy()
	self.attributeObjectPool:Dispose(function(item)
		item:Dispose()
	end)
	AssetUtil.UnloadAsset(self)
end

function SkillBreachTipsUI:RefreshSkillInfo2()
	self.presentStatItemList = {}

	local maxStrengthenLevel = DiySkillModule.GetSkillMaxStrengthenLevel(self.skillData.skillCid)

	self.curStartItemPool:ForItems(function(_item)
		_item:Hide()
	end)
	self.attributeObjectPool:ForItems(function(_item)
		_item:Hide()
	end)
	CoroutineUtility.StartCoroutine(function()
		CoroutineUtility.Yield(CustomWaitForSeconds(1))
		self.breachStarsGridAnimCom:Play("SkillBreachTipsUI_01")

		for i = 1, maxStrengthenLevel do
			local presentStartItem = self.curStartItemPool:GetFree(function(_item)
				return not _item.gameObject.activeSelf
			end)

			presentStartItem:Show()
			presentStartItem:SetOnState(false)

			self.presentStatItemList[i] = presentStartItem
		end

		CoroutineUtility.Yield(CustomWaitForSeconds(0.5))

		for i = 1, self.skillData.strengLv + 1 do
			self.presentStatItemList[i]:SetOnState(true)

			local tween = TweenAlpha.Begin(self.presentStatItemList[i].gameObject, 0.15, 0, 1)

			tween:SetOnFinished(function()
				UnityEngine.GameObject.Destroy(tween)
			end)
			CoroutineUtility.Yield(CustomWaitForSeconds(0.2))
		end

		CoroutineUtility.Yield(CustomWaitForSeconds(0.5))

		for i = 1, #self.skillAttributes do
			local attributeItem = self.attributeObjectPool:GetFree(function(_item)
				return not _item.gameObject.activeSelf
			end)

			attributeItem:Show()
			attributeItem:SetData(self.skillAttributes[i])
			CoroutineUtility.Yield(CustomWaitForSeconds(0.2))
		end

		self.closeBtnCom.interactable = true
	end)

	local curMaxUpgradeLevel = DiySkillModule.GetSkillMaxUpgradeLevel(self.skillData.Quality, self.skillData.strengLv)
	local previewMaxUpgradeLevel = DiySkillModule.GetSkillMaxUpgradeLevel(self.skillData.Quality, self.skillData.strengLv + 1)

	UGUIUtil.SetText(self.presentLevelText, curMaxUpgradeLevel)
	UGUIUtil.SetText(self.lastLevelText, curMaxUpgradeLevel)
	UGUIUtil.SetText(self.limitLevelText, previewMaxUpgradeLevel)
end

function SkillBreachTipsUI:RefreshSkillInfo()
	self.attributeObjectPool:ForItems(function(_item)
		_item:Hide()
	end)

	local maxStartNum = DiySkillModule.GetSkillMaxStrengthenLevel(self.skillData.skillCid)
	local lastMaxUpgradeLevel = DiySkillModule.GetSkillMaxUpgradeLevel(self.skillData.Quality, self.skillData.strengLv)

	self.lastBreachStars:Refresh(self.skillData.strengLv, maxStartNum)
	LuaUtility.SetText(self.lastMaxLevelText, lastMaxUpgradeLevel)
	LuaUtility.SetText(self.lastLevelText, lastMaxUpgradeLevel)

	local curMaxUpgradeLevel = DiySkillModule.GetSkillMaxUpgradeLevel(self.skillData.Quality, self.skillData.strengLv + 1)

	self.currentBreachStars:Refresh(self.skillData.strengLv + 1, maxStartNum)
	LuaUtility.SetText(self.currentMaxLevelText, curMaxUpgradeLevel)
	LuaUtility.SetText(self.currentLevelText, lastMaxUpgradeLevel)

	for i = 1, #self.skillAttributes do
		local attributeItem = self.attributeObjectPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		attributeItem:Show()
		attributeItem:SetData(self.skillAttributes[i])
	end

	LuaUtility.SetText(self.levelTips, DiySkillStrengthenUIApi:GetTextLevelUp(curMaxUpgradeLevel))
end

return SkillBreachTipsUI
