-- chunkname: @modules/logic/achievement/view/AchievementToastItem.lua

module("modules.logic.achievement.view.AchievementToastItem", package.seeall)

local AchievementToastItem = class("AchievementToastItem", UserDataDispose)

function AchievementToastItem:init(toastItem, toastParams)
	self:__onInit()

	self._toastItem = toastItem
	self._toastParams = toastParams
	self._achievementRootGO = self._toastItem:getToastRootByType(ToastItem.ToastType.Achievement)

	self:_onUpdate()
end

AchievementToastItem.ToastGOName = "achievementToastItem"

function AchievementToastItem:_onUpdate()
	self.viewGO = gohelper.findChild(self._achievementRootGO, AchievementToastItem.ToastGOName)

	if not self.viewGO then
		local toastPrefab = AchievementToastController.instance:tryGetToastAsset()

		if toastPrefab then
			self.viewGO = gohelper.clone(toastPrefab, self._achievementRootGO, AchievementToastItem.ToastGOName)
		else
			self._toastLoader = self._toastLoader or MultiAbLoader.New()

			self._toastLoader:addPath(AchievementEnum.AchievementToastPath)
			self._toastLoader:startLoad(self._onToastLoadedCallBack, self)
		end
	end

	if self.viewGO then
		self:initComponents()
		self:refreshUI()
	end
end

function AchievementToastItem:_onToastLoadedCallBack(loader)
	self.viewGO = gohelper.findChild(self._achievementRootGO, AchievementToastItem.ToastGOName)

	if not self.viewGO then
		local assetItem = loader:getAssetItem(AchievementEnum.AchievementToastPath)
		local toastPrefab = assetItem:GetResource(AchievementEnum.AchievementToastPath)

		self.viewGO = gohelper.clone(toastPrefab, self._achievementRootGO, AchievementToastItem.ToastGOName)
	end

	self:initComponents()
	self:refreshUI()
end

function AchievementToastItem:initComponents()
	if self.viewGO then
		self._txtAchievement = gohelper.findChildText(self.viewGO, "Tips/#txt_Achievement")
		self._simageAssessIcon = gohelper.findChildSingleImage(self.viewGO, "Tips/#simage_AssessIcon")
	end
end

function AchievementToastItem:refreshUI()
	self._txtAchievement.text = tostring(self._toastParams.toastTip)

	self._simageAssessIcon:LoadImage(self._toastParams.icon)
	self._toastItem:setToastType(ToastItem.ToastType.Achievement)
end

function AchievementToastItem:dispose()
	if self._toastLoader then
		self._toastLoader:dispose()

		self._toastLoader = nil
	end

	if self._simageAssessIcon then
		self._simageAssessIcon:UnLoadImage()
	end

	self._toastItem = nil
	self._toastParams = nil

	self:__onDispose()
end

return AchievementToastItem
