-- chunkname: @IQIGame\\UI\\LunaBattleLine\\DetailUI\\LunaBattleLineNoCampController.lua

local m = {
	IsShow = false
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

	function self.DelegateOnClickEnterBtn()
		self:OnClickEnterBtn()
	end

	self.IsShow = self.View.activeSelf

	UGUIUtil.SetTextInChildren(self.EnterBtn, LunaBattleLineDetailUIApi:GetString("NoCampViewEnterBtnText"))
end

function m:Show(zonePOD)
	if self.IsShow then
		return
	end

	self.IsShow = true

	self:AddListeners()
	self.View:SetActive(true)
	self:SetData(zonePOD)
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
	self.EnterBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEnterBtn)
end

function m:RemoveListeners()
	self.EnterBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEnterBtn)
end

function m:SetData(zonePOD)
	self.ZonePOD = zonePOD

	local cfgLunaBattleLineZoneData = CfgLunaBattleLineZoneTable[zonePOD.zoneId]
	local cfgMazeInstanceData = CfgMazeInstanceTable[cfgLunaBattleLineZoneData.StationingLevel]
	local cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]
	local unfinishedGarrisonMazeCid = PlayerModule.GetUnfinishedMazeCid(cfgChapterData.Type)

	self.GarrisonUnfinishedTag:SetActive(unfinishedGarrisonMazeCid == cfgLunaBattleLineZoneData.StationingLevel)
end

function m:OnClickEnterBtn()
	if LunaBattleLineModule.IsOutOfMazeLimitTime() then
		NoticeModule.ShowNotice(21062004)

		return
	end

	local cfgLunaBattleLineZoneData = CfgLunaBattleLineZoneTable[self.ZonePOD.zoneId]
	local cfgMazeInstanceData = CfgMazeInstanceTable[cfgLunaBattleLineZoneData.StationingLevel]
	local cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]
	local unfinishedMazeCid = PlayerModule.GetUnfinishedMazeCid(cfgChapterData.Type)

	if unfinishedMazeCid ~= nil then
		if unfinishedMazeCid == cfgLunaBattleLineZoneData.StationingLevel then
			MazeModule.SaveEntranceDataBeforeEnter(LunaBattleLineModule.GetRecoverMazeEntranceData(self.ZonePOD.zoneId))
			MazeModule.SendRestore(unfinishedMazeCid)
		else
			NoticeModule.ShowNotice(21062001)

			return
		end
	else
		self.Host:ShowZoneDetail(cfgLunaBattleLineZoneData.StationingLevel, self.ZonePOD)
	end
end

function m:OnShowDetail(isDetailViewShow)
	self.HideByDetailNode:SetActive(not isDetailViewShow)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
	self.ZonePOD = nil
end

return m
