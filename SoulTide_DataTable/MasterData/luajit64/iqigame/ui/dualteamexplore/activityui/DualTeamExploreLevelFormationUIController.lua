-- chunkname: @IQIGame\\UI\\DualTeamExplore\\ActivityUI\\DualTeamExploreLevelFormationUIController.lua

require("IQIGame.UIExternalApi.DualTeamExploreLevelFormationUIApi")

local DualTeamExploreFormationItem = require("IQIGame.UI.DualTeamExplore.DualTeamExploreFormationItem")
local DualTeamExploreLevelFormationUIController = {
	IsEasyMode = false,
	LevelCid = 0,
	FormationItems = {}
}

function DualTeamExploreLevelFormationUIController.New(uiController)
	local obj = Clone(DualTeamExploreLevelFormationUIController)

	obj:__Init(uiController)

	return obj
end

function DualTeamExploreLevelFormationUIController:__Init(uiController)
	self.UIController = uiController
end

function DualTeamExploreLevelFormationUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function DualTeamExploreLevelFormationUIController:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	for i = 1, 2 do
		local item = DualTeamExploreFormationItem.New(UnityEngine.Object.Instantiate(self.FormationItemPrefab), i, self.SoulHeadPrefab, function(index)
			self:OnClickFormationUIBtn(index)
		end, function(index)
			self:OnClickQuickChangeFormationUIBtn(index)
		end)

		item.View.transform:SetParent(self["FormationViewNode" .. i].transform, false)

		self.FormationItems[i] = item
	end
end

function DualTeamExploreLevelFormationUIController:GetPreloadAssetPaths()
	return nil
end

function DualTeamExploreLevelFormationUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreLevelFormationUIController:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreLevelFormationUIController:GetBGM(userData)
	return nil
end

function DualTeamExploreLevelFormationUIController:OnOpen(userData)
	self:UpdateView(userData.levelCid, userData.isEasyMode)
end

function DualTeamExploreLevelFormationUIController:OnClose(userData)
	return
end

function DualTeamExploreLevelFormationUIController:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
end

function DualTeamExploreLevelFormationUIController:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
end

function DualTeamExploreLevelFormationUIController:OnPause()
	return
end

function DualTeamExploreLevelFormationUIController:OnResume()
	return
end

function DualTeamExploreLevelFormationUIController:OnCover()
	return
end

function DualTeamExploreLevelFormationUIController:OnReveal()
	return
end

function DualTeamExploreLevelFormationUIController:OnRefocus(userData)
	return
end

function DualTeamExploreLevelFormationUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DualTeamExploreLevelFormationUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreLevelFormationUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreLevelFormationUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreLevelFormationUIController:OnDestroy()
	for i = 1, #self.FormationItems do
		local item = self.FormationItems[i]

		item:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function DualTeamExploreLevelFormationUIController:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function DualTeamExploreLevelFormationUIController:UpdateView(levelCid, isEasyMode)
	self.LevelCid = levelCid
	self.IsEasyMode = isEasyMode

	local savedFormations = {}
	local teamRecord = PlayerPrefsUtil.GetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.DualTeamExploreTeam)

	if teamRecord ~= nil then
		savedFormations[1] = teamRecord.formation1
		savedFormations[2] = teamRecord.formation2
	end

	for i = 1, #self.FormationItems do
		local item = self.FormationItems[i]

		item:SetData(savedFormations[i], savedFormations[i % 2 + 1])
	end
end

function DualTeamExploreLevelFormationUIController:OnClickFormationUIBtn(formationItemIndex)
	local item = self.FormationItems[formationItemIndex]
	local formationIndex = item.FormationIndex ~= 0 and item.FormationIndex or 1

	UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, {
		tabIndex = formationIndex,
		onConfirm = function(chooseIndex)
			local otherItem = self.FormationItems[formationItemIndex % 2 + 1]

			item:SetData(chooseIndex, otherItem.FormationIndex)
			otherItem:Refresh(item.FormationIndex)
		end
	})
end

function DualTeamExploreLevelFormationUIController:OnClickQuickChangeFormationUIBtn(formationItemIndex)
	local item = self.FormationItems[formationItemIndex]
	local formationIndex = item.FormationIndex ~= 0 and item.FormationIndex or 1

	UIModule.Open(Constant.UIControllerName.QuickChangeFormationUI, Constant.UILayer.UI, {
		tabIndex = formationIndex,
		onConfirm = function(chooseIndex)
			local otherItem = self.FormationItems[formationItemIndex % 2 + 1]

			item:SetData(chooseIndex, otherItem.FormationIndex)
			otherItem:Refresh(item.FormationIndex)
		end
	})
end

function DualTeamExploreLevelFormationUIController:OnClickConfirmBtn()
	local formationItem1 = self.FormationItems[1]
	local formationItem2 = self.FormationItems[2]
	local formationIndex1 = formationItem1.FormationIndex
	local formationIndex2 = formationItem2.FormationIndex

	if formationIndex1 == 0 or formationIndex2 == 0 then
		NoticeModule.ShowNotice(84500003)

		return
	end

	local isFormation1HasSoul = self:CheckFormationHasSoul(formationIndex1)
	local isFormation2HasSoul = self:CheckFormationHasSoul(formationIndex2)

	if not isFormation1HasSoul or not isFormation2HasSoul then
		NoticeModule.ShowNotice(84500003)

		return
	end

	if formationItem1:HasRepeat() or formationItem2:HasRepeat() then
		NoticeModule.ShowNotice(84500003)

		return
	end

	UIModule.CloseSelf(self)

	local formationPOD1 = FormationModule.GetFormationByIndex(formationIndex1)
	local formationPOD2 = FormationModule.GetFormationByIndex(formationIndex2)

	DualTeamExploreModule.SendEnterScene(self.LevelCid, formationPOD1.id, formationPOD2.id, self.IsEasyMode)
	PlayerPrefsUtil.SetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.DualTeamExploreTeam, {
		formation1 = formationIndex1,
		formation2 = formationIndex2
	})
end

function DualTeamExploreLevelFormationUIController:CheckFormationHasSoul(formationIndex)
	local formationPOD = FormationModule.GetFormationByIndex(formationIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

		if soulPrefabData.soulCid ~= nil then
			return true
		end
	end

	return false
end

return DualTeamExploreLevelFormationUIController
