-- chunkname: @IQIGame\\UI\\MonsterAcademyPlayerUI.lua

local MonsterAcademyPlayerUI = {
	monsterAcademyAtt = {}
}

MonsterAcademyPlayerUI = Base:Extend("MonsterAcademyPlayerUI", "IQIGame.Onigao.UI.MonsterAcademyPlayerUI", MonsterAcademyPlayerUI)

require("IQIGame.UIExternalApi.MonsterAcademyPlayerUIApi")

local MonsterAcademyPlayerHeadView = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyPlayerHeadView")

function MonsterAcademyPlayerUI:OnInit()
	UGUIUtil.SetTextInChildren(self.FavorBtn, MonsterAcademyPlayerUIApi:GetString("FavorBtnLabel"))
	UGUIUtil.SetTextInChildren(self.BtnClose, MonsterAcademyPlayerUIApi:GetString("BtnCloseLabel"))
	UGUIUtil.SetText(self.AttributeTitle, MonsterAcademyPlayerUIApi:GetString("AttributeTitle"))
	UGUIUtil.SetText(self.TextMonsterTitle, MonsterAcademyPlayerUIApi:GetString("TextMonsterTitle"))

	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateOnClickFavorBtn()
		self:OnClickFavorBtn()
	end

	function self.DelegateUpdateItem()
		self:RefreshAchieve()
	end

	function self.DelegateOnBtnAchievement()
		self:OnBtnAchievement()
	end

	self.playerHeadView = MonsterAcademyPlayerHeadView.New(self.PlayerInformation)
end

function MonsterAcademyPlayerUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademyPlayerUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademyPlayerUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyPlayerUI:GetBGM(userData)
	return nil
end

function MonsterAcademyPlayerUI:OnOpen(userData)
	self.monsterAcademyAtt = MonsterAcademyModule.GetMonsterAcademyAtt()

	self:UpdateView()
end

function MonsterAcademyPlayerUI:OnClose(userData)
	return
end

function MonsterAcademyPlayerUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.FavorBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFavorBtn)
	self.BtnAchievement:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnAchievement)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
end

function MonsterAcademyPlayerUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.FavorBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFavorBtn)
	self.BtnAchievement:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnAchievement)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
end

function MonsterAcademyPlayerUI:OnPause()
	return
end

function MonsterAcademyPlayerUI:OnResume()
	return
end

function MonsterAcademyPlayerUI:OnCover()
	return
end

function MonsterAcademyPlayerUI:OnReveal()
	return
end

function MonsterAcademyPlayerUI:OnRefocus(userData)
	return
end

function MonsterAcademyPlayerUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterAcademyPlayerUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyPlayerUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyPlayerUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyPlayerUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.playerHeadView:Dispose()
end

function MonsterAcademyPlayerUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.MonsterAcademyPlayerUI)
end

function MonsterAcademyPlayerUI:OnClickFavorBtn()
	UIModule.Open(Constant.UIControllerName.MonsterAcademyMoodUI, Constant.UILayer.UI)
end

function MonsterAcademyPlayerUI:UpdateView()
	self.playerHeadView:UpdateView()
	UGUIUtil.SetText(self.TextTitle, MonsterAcademyPlayerUIApi:GetString("TextTitle", PlayerModule.PlayerInfo.baseInfo.pName))

	for i = 1, #self.monsterAcademyAtt do
		local attributeID = self.monsterAcademyAtt[i]
		local value = MonsterAcademyModule.SaveDataDetailPOD.basePOD.baseProps[attributeID]

		if value == nil then
			value = 0
		end

		local cfgAttr = CfgGalgameMonsterAttributeTable[attributeID]

		UGUIUtil.SetText(self["AttributeLabel" .. i], MonsterAcademyPlayerUIApi:GetString("AttributeLabel", cfgAttr.Name))
		UGUIUtil.SetText(self["Attribute" .. i], MonsterAcademyPlayerUIApi:GetString("Attribute", value))
		UGUIUtil.SetText(self["AttrState" .. i], MonsterAcademyPlayerUIApi:GetString("AttrState", value))

		local star = MonsterAcademyPlayerUIApi:GetString("AttrStar", value)
		local count = self["Star" .. i].transform.childCount

		for j = 1, count do
			local show = j <= star

			self["Star" .. i].transform:Find("Star_" .. j .. "/Image_02").gameObject:SetActive(show)
		end

		if cfgAttr.Icon ~= nil and cfgAttr.Icon ~= "" then
			local path = UIGlobalApi.GetImagePath(cfgAttr.Icon)

			AssetUtil.LoadImage(self, path, self["AttributeIcon" .. i]:GetComponent("Image"))
		end
	end

	self:RefreshAchieve()
end

function MonsterAcademyPlayerUI:RefreshAchieve()
	local value = WarehouseModule.GetItemNumByCfgID(CfgGalgameMonsterActivityGlobalTable[MonsterAcademyModule.GlobalCid].AchPointShow)

	UGUIUtil.SetText(self.TextMonster, value)
end

function MonsterAcademyPlayerUI:OnBtnAchievement()
	UIModule.Open(Constant.UIControllerName.MonsterAcademyAchievementUI, Constant.UILayer.UI)
end

return MonsterAcademyPlayerUI
