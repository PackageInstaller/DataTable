-- chunkname: @IQIGame\\UI\\LunaBattleLine\\DetailUI\\LunaBattleLineSealingController.lua

local LunaBattleAssistantCell = require("IQIGame.UI.LunaBattleLine.DetailUI.LunaBattleAssistantCell")
local m = {
	IsShow = false,
	AssistantCells = {}
}

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSealBtn()
		self:OnClickSealBtn()
	end

	function self.DelegateOnClickEnhanceBtn()
		self:OnClickEnhanceBtn()
	end

	function self.DelegateOnRefreshAssists(assistUnits)
		self:OnRefreshAssists(assistUnits)
	end

	self.IsShow = self.View.activeSelf

	for i = 1, 10 do
		local cell = LunaBattleAssistantCell.New(UnityEngine.Object.Instantiate(self.PlayerHeadPrefab))

		cell.View.transform:SetParent(self.AllyPoint.transform:Find("Point_" .. i), false)

		cell.View.transform.anchoredPosition = Vector2.zero

		table.insert(self.AssistantCells, cell)
	end

	self.MyCell = LunaBattleAssistantCell.New(UnityEngine.Object.Instantiate(self.PlayerHeadPrefab), true)

	self.MyCell.View.transform:SetParent(self.AllyPoint.transform:Find("Point_0"), false)

	self.MyCell.View.transform.anchoredPosition = Vector2.zero

	UGUIUtil.SetTextInChildren(self.SealBtn, LunaBattleLineDetailUIApi:GetString("SealingViewSealBtnText"))
	UGUIUtil.SetTextInChildren(self.EnhanceBtn, LunaBattleLineDetailUIApi:GetString("SealingViewEnhanceBtnText"))
end

function m:Show(zonePOD, assistUnits, sealNum)
	if self.IsShow then
		return
	end

	self.IsShow = true

	self:AddListeners()
	self.View:SetActive(true)
	self:SetData(zonePOD, assistUnits, sealNum)
end

function m:Hide()
	if not self.IsShow then
		return
	end

	self.IsShow = false

	self:RemoveListeners()
	self.View:SetActive(false)
end

function m:AddListeners()
	self.SealBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSealBtn)
	self.EnhanceBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEnhanceBtn)
	EventDispatcher.AddEventListener(EventID.LunaBattleLineRefreshAssists, self.DelegateOnRefreshAssists)
end

function m:RemoveListeners()
	self.SealBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSealBtn)
	self.EnhanceBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEnhanceBtn)
	EventDispatcher.RemoveEventListener(EventID.LunaBattleLineRefreshAssists, self.DelegateOnRefreshAssists)
end

function m:SetData(zonePOD, assistUnits, sealNum)
	self.ZonePOD = zonePOD

	self.MyCell:SetData(self.ZonePOD, zonePOD.garrison)
	self:RefreshAssists(assistUnits)

	local cfgLunaBattleLineZoneData = CfgLunaBattleLineZoneTable[zonePOD.zoneId]
	local isSealMazeFinished = table.indexOf(PlayerModule.PlayerInfo.finishMazes, cfgLunaBattleLineZoneData.SealedLevel) ~= -1

	self.EnhanceBtn:SetActive(isSealMazeFinished and sealNum == LunaBattleLineModule.MaxSealNum)

	local cfgMazeInstanceData = CfgMazeInstanceTable[cfgLunaBattleLineZoneData.SealedLevel]
	local cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]
	local unfinishedSealMazeCid = PlayerModule.GetUnfinishedMazeCid(cfgChapterData.Type)

	self.SealUnfinishedTag:SetActive(unfinishedSealMazeCid == cfgLunaBattleLineZoneData.SealedLevel)

	cfgMazeInstanceData = CfgMazeInstanceTable[cfgLunaBattleLineZoneData.TrainingLevel]
	cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]

	local unfinishedEnhanceMazeCid = PlayerModule.GetUnfinishedMazeCid(cfgChapterData.Type)

	self.EnhanceUnfinishedTag:SetActive(unfinishedEnhanceMazeCid == cfgLunaBattleLineZoneData.TrainingLevel)
end

function m:RefreshAssists(assistUnits)
	for i = 1, #self.AssistantCells do
		local cell = self.AssistantCells[i]
		local assistUnitPOD = assistUnits[i]
		local soulPrefab

		if assistUnitPOD ~= nil then
			soulPrefab = assistUnitPOD.soulPrefab
		end

		cell:SetData(self.ZonePOD, soulPrefab)
	end
end

function m:OnClickSealBtn()
	if LunaBattleLineModule.IsOutOfMazeLimitTime() then
		NoticeModule.ShowNotice(21062004)

		return
	end

	local cfgLunaBattleLineZoneData = CfgLunaBattleLineZoneTable[self.ZonePOD.zoneId]
	local cfgMazeInstanceData = CfgMazeInstanceTable[cfgLunaBattleLineZoneData.SealedLevel]
	local cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]
	local unfinishedMazeCid = PlayerModule.GetUnfinishedMazeCid(cfgChapterData.Type)

	if unfinishedMazeCid ~= nil then
		if unfinishedMazeCid == cfgLunaBattleLineZoneData.SealedLevel then
			MazeModule.SaveEntranceDataBeforeEnter(LunaBattleLineModule.GetRecoverMazeEntranceData(self.ZonePOD.zoneId))
			MazeModule.SendRestore(unfinishedMazeCid)
		else
			NoticeModule.ShowNotice(21062001)

			return
		end
	else
		self.Host:ShowZoneDetail(cfgLunaBattleLineZoneData.SealedLevel, self.ZonePOD)
	end
end

function m:OnShowDetail(isShow)
	self.HideByDetailNode:SetActive(not isShow)
end

function m:OnClickEnhanceBtn()
	if LunaBattleLineModule.IsOutOfMazeLimitTime() then
		NoticeModule.ShowNotice(21062004)

		return
	end

	local cfgLunaBattleLineZoneData = CfgLunaBattleLineZoneTable[self.ZonePOD.zoneId]
	local cfgMazeInstanceData = CfgMazeInstanceTable[cfgLunaBattleLineZoneData.TrainingLevel]
	local cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]
	local unfinishedMazeCid = PlayerModule.GetUnfinishedMazeCid(cfgChapterData.Type)

	if unfinishedMazeCid ~= nil then
		if unfinishedMazeCid == cfgLunaBattleLineZoneData.TrainingLevel then
			MazeModule.SaveEntranceDataBeforeEnter(LunaBattleLineModule.GetRecoverMazeEntranceData(self.ZonePOD.zoneId))
			MazeModule.SendRestore(unfinishedMazeCid)
		else
			NoticeModule.ShowNotice(21062001)

			return
		end
	else
		LunaBattleLineModule.SendGetStrengthenSoulPrefab(self.ZonePOD.zoneId, function(soulPrefabs)
			UIModule.Open(Constant.UIControllerName.LunaBattleLineEnhanceFormationUI, Constant.UILayer.UI, {
				zoneId = self.ZonePOD.zoneId,
				soulPrefabs = soulPrefabs
			})
		end)
	end
end

function m:OnRefreshAssists(assistUnits)
	self:RefreshAssists(assistUnits)
end

function m:Dispose()
	self.MyCell:Dispose()

	for i = 1, #self.AssistantCells do
		local cell = self.AssistantCells[i]

		cell:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
	self.ZonePOD = nil
end

return m
