-- chunkname: @IQIGame\\UI\\Achievement\\AchievementBadgeItem.lua

local AchievementBadgeItem = {}

function AchievementBadgeItem.New(go, mainView)
	local o = Clone(AchievementBadgeItem)

	o:Initialize(go, mainView)

	return o
end

function AchievementBadgeItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go

	self.gameObject:SetActive(true)

	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function AchievementBadgeItem:InitComponent()
	self.badgeItemImgButton = self.badgeItemImg:GetComponent("Button")
end

function AchievementBadgeItem:InitDelegate()
	function self.badgeItemImgButtonClickDelegate()
		self:OnbadgeItemImgButtonClick()
	end
end

function AchievementBadgeItem:AddListener()
	self.badgeItemImgButton.onClick:AddListener(self.badgeItemImgButtonClickDelegate)
end

function AchievementBadgeItem:RemoveListener()
	self.badgeItemImgButton.onClick:RemoveListener(self.badgeItemImgButtonClickDelegate)
end

function AchievementBadgeItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function AchievementBadgeItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function AchievementBadgeItem:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
end

function AchievementBadgeItem:Refresh(Data)
	self.Data = Data

	if self.Data == nil or self.Data.cid == 0 or self.Data.cid == nil then
		return
	end

	local cfgData = TaskSystemModule.GetCfgTaskDataWithID(self.Data.cid)

	LuaUtility.SetText(self.badgeItemNameText, cfgData.Name)
	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(cfgData.EmblemIcon), self.badgeItemImg:GetComponent("Image"))

	if TaskSystemModule.GetFinishedTaskWithID(self.Data.cid) then
		LuaUtility.SetImageColorWithGameObject(self.badgeItemImg, 1, 1, 1, 1)
	elseif self.Data.status == Constant.TaskStatus.doing then
		LuaUtility.SetImageColorWithGameObject(self.badgeItemImg, 0.5, 0.5, 0.5, 0.8)
	elseif self.Data.status == Constant.TaskStatus.hasDone then
		LuaUtility.SetImageColorWithGameObject(self.badgeItemImg, 1, 1, 1, 1)
	end
end

function AchievementBadgeItem:OnbadgeItemImgButtonClick()
	EventDispatcher.Dispatch(EventID.AchievementPop, self.Data.cid)
end

return AchievementBadgeItem
