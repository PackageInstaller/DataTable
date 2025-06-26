-- chunkname: @IQIGame\\UI\\LunaBattleLine\\Entry\\LunaBattleLineEntryZoneCell.lua

local m = {
	SealNum = 0,
	ZoneCid = 0
}

function m.New(view, zoneCid)
	local obj = Clone(m)

	obj:Init(view, zoneCid)

	return obj
end

function m:Init(view, zoneCid)
	self.View = view
	self.ZoneCid = zoneCid

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelectBtn()
		self:OnClickSelectBtn()
	end

	function self.DelegateOnGarrisonComplete(zoneId)
		self:OnGarrisonComplete(zoneId)
	end

	local cfgLunaBattleLineZoneData = CfgLunaBattleLineZoneTable[zoneCid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgLunaBattleLineZoneData.ZoneIcon), self.BossIcon:GetComponent("Image"))
	self:AddListeners()
end

function m:AddListeners()
	self.SelectBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelectBtn)
	EventDispatcher.AddEventListener(EventID.LunaBattleLineGarrisonComplete, self.DelegateOnGarrisonComplete)
end

function m:RemoveListeners()
	self.SelectBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelectBtn)
	EventDispatcher.RemoveEventListener(EventID.LunaBattleLineGarrisonComplete, self.DelegateOnGarrisonComplete)
end

function m:SetData(sealNum, zonePOD)
	self.SealNum = sealNum
	self.ZonePOD = zonePOD

	self.FortView:SetActive(zonePOD.garrison ~= nil)

	local maxSealNum = LunaBattleLineModule.MaxSealNum
	local cfgLunaBattleLineZoneData = CfgLunaBattleLineZoneTable[self.ZoneCid]
	local isSealMazeFinished = table.indexOf(PlayerModule.PlayerInfo.finishMazes, cfgLunaBattleLineZoneData.SealedLevel) ~= -1

	self.SealView:SetActive(maxSealNum <= sealNum and isSealMazeFinished)
	self.NormalView:SetActive(sealNum < maxSealNum or not isSealMazeFinished)

	self.SealProgressBar:GetComponent("Image").fillAmount = sealNum / maxSealNum

	UGUIUtil.SetText(self.SealProgressText, LunaBattleLineEntryUIApi:GetString("ZoneCellSealProgressText", sealNum, maxSealNum))

	local cfgMazeInstanceData = CfgMazeInstanceTable[cfgLunaBattleLineZoneData.StationingLevel]
	local cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]
	local unfinishedGarrisonMazeCid = PlayerModule.GetUnfinishedMazeCid(cfgChapterData.Type)

	self.TagGarrison:SetActive(unfinishedGarrisonMazeCid == cfgLunaBattleLineZoneData.StationingLevel)

	cfgMazeInstanceData = CfgMazeInstanceTable[cfgLunaBattleLineZoneData.SealedLevel]
	cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]

	local unfinishedSealMazeCid = PlayerModule.GetUnfinishedMazeCid(cfgChapterData.Type)

	self.TagSeal:SetActive(unfinishedSealMazeCid == cfgLunaBattleLineZoneData.SealedLevel)

	cfgMazeInstanceData = CfgMazeInstanceTable[cfgLunaBattleLineZoneData.TrainingLevel]
	cfgChapterData = CfgChapterTable[cfgMazeInstanceData.ChapterId]

	local unfinishedEnhanceMazeCid = PlayerModule.GetUnfinishedMazeCid(cfgChapterData.Type)

	self.TagEnhance:SetActive(unfinishedEnhanceMazeCid == cfgLunaBattleLineZoneData.TrainingLevel)
	self.TagView:SetActive(unfinishedGarrisonMazeCid == cfgLunaBattleLineZoneData.StationingLevel or unfinishedSealMazeCid == cfgLunaBattleLineZoneData.SealedLevel or unfinishedEnhanceMazeCid == cfgLunaBattleLineZoneData.TrainingLevel)
end

function m:OnClickSelectBtn()
	if LunaBattleLineModule.IsOutOfMazeLimitTime() then
		NoticeModule.ShowNotice(21062004)

		return
	end

	UIModule.Open(Constant.UIControllerName.LunaBattleLineDetailUI, Constant.UILayer.UI, {
		zoneId = self.ZonePOD.zoneId
	})
end

function m:OnGarrisonComplete(zoneId)
	if self.ZonePOD.zoneId == zoneId then
		self.FortView:SetActive(self.ZonePOD.garrison ~= nil)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.ZonePOD = nil
end

return m
