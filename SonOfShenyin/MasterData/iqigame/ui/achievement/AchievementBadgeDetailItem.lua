-- chunkname: @IQIGame\\UI\\Achievement\\AchievementBadgeDetailItem.lua

local AchievementBadgeDetailItem = {
	badgeDetailItems = {}
}
local AchievementBadgeItemClass = require("IQIGame.UI.Achievement.AchievementBadgeItem")

function AchievementBadgeDetailItem.New(go, mainView)
	local o = Clone(AchievementBadgeDetailItem)

	o:Initialize(go, mainView)

	return o
end

function AchievementBadgeDetailItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function AchievementBadgeDetailItem:InitComponent()
	return
end

function AchievementBadgeDetailItem:InitDelegate()
	return
end

function AchievementBadgeDetailItem:AddListener()
	return
end

function AchievementBadgeDetailItem:RemoveListener()
	return
end

function AchievementBadgeDetailItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function AchievementBadgeDetailItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function AchievementBadgeDetailItem:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
end

function AchievementBadgeDetailItem:Refresh(Data, OptimizedViewsHolder)
	self.Data = Data.data
	self.type = Data.type
	self.tabIndex = Data.tabIndex

	for k, v in pairs(self.badgeDetailItems) do
		v:Hide()
	end

	for i = 1, #self.Data do
		local AchievementBadgeItem = self:CreateItems(i)

		AchievementBadgeItem:Refresh(self.Data[i])
	end

	if self.type == 0 then
		LuaUtility.SetGameObjectShow(self.achievementTaskItem, true)
		LuaUtility.SetGameObjectShow(self.typeParent, false)

		OptimizedViewsHolder.ControlSize = 158
	else
		LuaUtility.SetGameObjectShow(self.achievementTaskItem, false)
		LuaUtility.SetGameObjectShow(self.typeParent, true)

		OptimizedViewsHolder.ControlSize = 40
	end
end

function AchievementBadgeDetailItem:CreateItems(index)
	local badgeDetailItem = self.badgeDetailItems[index]

	if badgeDetailItem == nil then
		local gameObject = UnityEngine.GameObject.Instantiate(self.badgeItemPrefab)

		gameObject.transform:SetParent(self.badgeContent.transform, false)

		local materialLuaTable = AchievementBadgeItemClass.New(gameObject, self)

		self.badgeDetailItems[index] = materialLuaTable
		badgeDetailItem = self.badgeDetailItems[index]
	end

	badgeDetailItem:Show()

	return badgeDetailItem
end

return AchievementBadgeDetailItem
