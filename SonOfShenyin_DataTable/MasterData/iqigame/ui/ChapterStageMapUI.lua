-- chunkname: @IQIGame\\UI\\ChapterStageMapUI.lua

local ChapterStageMapUI = {
	CurMapItemCells = {},
	LastStageItemDatas = {}
}

ChapterStageMapUI = Base:Extend("ChapterStageMapUI", "IQIGame.Onigao.UI.ChapterStageMapUI", ChapterStageMapUI)

local mapMainChapterPanel = require("IQIGame.UI.Map.MapChapterDetails.MapMainChapterPanel")
local mapDailyPanel = require("IQIGame.UI.Map.MapChapterDetails.MapDailyPanel")
local arrowInstruction = require("IQIGame.UI.Map.Common.ArrowInstruction")
local mainStageTabItem = require("IQIGame.UI.Map.ItemCell.TabItemCell.MainStageTabItem")
local classifitaionPanel = require("IQIGame.UI.Map.MapChapterDetails.ClassifitaionPanel")

function ChapterStageMapUI:OnInit()
	function self.DelegateClickMarkItemMoveMapEvent(pos, isPlayAnim)
		self:ClickMarkItemMoveMapEvent(pos, isPlayAnim)
	end

	function self.DelegateNotifyUpdateStage(dups)
		self:NotifyUpdateStage(dups)
	end

	function self.DelegateOnClickTypeTab(isOn)
		self:OnClickTab(isOn)
	end

	function self.DelegateOnClickWorldMapBtn()
		self:OnClickWorldMapBtn()
	end

	function self.DelegateOnClickStageItemCellEvent(stageId, onlyMovePos, ignoreLocation)
		self:OnClickStageItemEvent(stageId, onlyMovePos, ignoreLocation)
	end

	function self.DelegateOnCloseChapterDetailsEvent()
		self:OnCloseChapterDetailsEvent()
	end

	function self.DelegateOnSingleDailyDupUpdateEvent(smallId)
		self:OnSingleDailyDupUpdateEvent(smallId)
	end

	function self.DelegateOnAllDailyDupsUpdateEvent()
		self:OnAllDailyDupsUpdateEvent()
	end

	self.MapObjectRect = self.MapObject:GetComponent("RectTransform")
	self.UIMapImgRect = self.UIMapRawImg:GetComponent("RectTransform")
	self.UIMapImgCom = self.UIMapRawImg:GetComponent("RawImage")
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.moneyCell = CurrencyCell.New(self.CurrencyContainer)
	self.mapScroll = self.MapScroll:GetComponent("ScrollRect")
	self.MapMainChapterView = mapMainChapterPanel.New(self.MainChapterPanel)
	self.MapDailyView = mapDailyPanel.New(self.DailyPanel)
	self.ArrowInstructionView = arrowInstruction.New(self.Arrow)
	self.MainStageTabItem = mainStageTabItem.New(self.MainStageParent)
	self.ClassifitaionView = classifitaionPanel.New(self.ClassifitaionPanel, self)
	self.AlphaEffectCanvasGroup = self.AlphaEffect:GetComponent("CanvasGroup")
	self.MapObjectRect.sizeDelta = Vector2.New(MapModule.MapMaxX, MapModule.MapMaxY)
	self.UIMapImgRect.sizeDelta = Vector2.New(MapModule.MapMaxX, MapModule.MapMaxY)
	self.PlayerHeadRect = self.PlayerHead:GetComponent("RectTransform")

	self:LoadPlayerHeadImg()

	self.RootRect = self.Root:GetComponent("RectTransform")
	self.rootRectX = self.RootRect.sizeDelta.x
	self.rootRectY = self.RootRect.sizeDelta.y
end

function ChapterStageMapUI:GetPreloadAssetPaths()
	return nil
end

function ChapterStageMapUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChapterStageMapUI:IsManualShowOnOpen(userData)
	return false
end

function ChapterStageMapUI:GetBGM(userData)
	return nil
end

function ChapterStageMapUI:OnOpen(userData)
	self.CurMapItemCells = {}
	self.CurSelectItemCell = nil
	MapModule.LastSelectedStageID = nil
	self.LastStageItemDatas = MapModule.GetAllUnlockItem()

	self:LoadMapItem(MapModule.GetAllMarkItem(), true)
	self:LoadMapItem(self.LastStageItemDatas)
	self:LoadMapItem(MapModule.GetDailyStages())

	self.curStageCfg = MapModule.GetMainLineNewUnlock()

	if MapModule.GetMainlineFinishState() then
		self:UpdateMainLineState()

		MapModule.TargetMapItem = nil
	else
		local mapItemCell = self:GetMarkMapItemCell(self.curStageCfg)

		if mapItemCell == nil and self.curStageCfg.WorldMapMarkID ~= 0 then
			logError(string.format("%s 标志建筑不存在 请检查该地标建筑所属地图是否解锁", self.curStageCfg.WorldMapMarkID))
		end

		self:ClickMarkItemMoveMapEvent(mapItemCell:GetPos(), false)
		mapItemCell:OnDefaultState()
		self:PlayLastStageAnim()

		MapModule.TargetMapItem = mapItemCell.View
	end

	self:PlayMapCloundMask()
	self:UpdatePlayerHeadLocation(true)
	self.moneyCell:RefreshItem(Constant.TopMoneyType.GameLevelUI)
	self.MapMainChapterView:Hide()
	self.MapDailyView:Hide()

	local itemId = userData.itemId

	if itemId then
		local mapItemCell = self:GetMapItemCell(itemId)

		if mapItemCell ~= nil then
			self:ClickMarkItemMoveMapEvent(mapItemCell:GetPos(), false)

			if userData.forShowDetails then
				EventDispatcher.Dispatch(EventID.OpenChapterDetailsEvent, itemId)
			end
		end
	end

	self.ClassifitaionView:Show()
	self.ClassifitaionView:SetData()
	self:LoadPlayerHeadImg()
	self:OnOpenAddListeners()
	self:CheckChallengeTips()

	if userData.chooseChallenge then
		self.ClassifitaionView.TabList[2]:GetComponent("Toggle").isOn = true

		self.ClassifitaionView:ShowChangeTab()
	end
end

function ChapterStageMapUI:OnClose(userData)
	self.lastUnlockCfg = nil

	if self.effectCoroutine then
		self.effectCoroutine:Stop()

		self.effectCoroutine = nil
	end

	if self.LastStageItemCell ~= nil then
		self:RemoveMapItemCell(self.LastStageId)
		MapItemManager.ReleaseMapItem(self.LastStageItemCell)

		self.LastStageItemCell = nil
		self.LastStageId = nil
	end

	self:ReleaseMapItem()
	self.ClassifitaionView:ResetLastIndex()
	self:OnCloseRemoveLiseners()
end

function ChapterStageMapUI:OnAddListeners()
	self.WroldMapBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickWorldMapBtn)
	EventDispatcher.AddEventListener(EventID.ClickMarkItemMoveMapEvent, self.DelegateClickMarkItemMoveMapEvent)
	EventDispatcher.AddEventListener(EventID.ClickStageItemCellEvent, self.DelegateOnClickStageItemCellEvent)
	EventDispatcher.AddEventListener(EventID.CloseChapterDetailEvent, self.DelegateOnCloseChapterDetailsEvent)
	EventDispatcher.AddEventListener(EventID.OnSingleDailyDupUpdate, self.DelegateOnSingleDailyDupUpdateEvent)
	EventDispatcher.AddEventListener(EventID.OnAllDailyDupsUpdate, self.DelegateOnAllDailyDupsUpdateEvent)
end

function ChapterStageMapUI:OnRemoveListeners()
	self.WroldMapBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickWorldMapBtn)
	EventDispatcher.RemoveEventListener(EventID.ClickMarkItemMoveMapEvent, self.DelegateClickMarkItemMoveMapEvent)
	EventDispatcher.RemoveEventListener(EventID.ClickStageItemCellEvent, self.DelegateOnClickStageItemCellEvent)
	EventDispatcher.RemoveEventListener(EventID.CloseChapterDetailEvent, self.DelegateOnCloseChapterDetailsEvent)
	EventDispatcher.RemoveEventListener(EventID.OnSingleDailyDupUpdate, self.DelegateOnSingleDailyDupUpdateEvent)
	EventDispatcher.RemoveEventListener(EventID.OnAllDailyDupsUpdate, self.DelegateOnAllDailyDupsUpdateEvent)
end

function ChapterStageMapUI:OnOpenAddListeners()
	EventDispatcher.AddEventListener(EventID.OnNotifyStage, self.DelegateNotifyUpdateStage)
end

function ChapterStageMapUI:OnCloseRemoveLiseners()
	EventDispatcher.RemoveEventListener(EventID.OnNotifyStage, self.DelegateNotifyUpdateStage)
end

function ChapterStageMapUI:OnPause()
	return
end

function ChapterStageMapUI:OnResume()
	return
end

function ChapterStageMapUI:OnCover()
	return
end

function ChapterStageMapUI:OnReveal()
	return
end

function ChapterStageMapUI:OnRefocus(userData)
	return
end

function ChapterStageMapUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.UIMapImgRect.anchoredPosition = self.MapObjectRect.anchoredPosition

	self.ArrowInstructionView:OnUpdate(elapseSeconds, realElapseSeconds)
end

function ChapterStageMapUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChapterStageMapUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChapterStageMapUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChapterStageMapUI:OnDestroy()
	MapModule.TargetMapItem = nil
	self.lastUnlockCfg = nil

	self.commonReturnBtn:Dispose()
	self.ArrowInstructionView:Dispose()
	self.MapMainChapterView:Dispose()
	self.MapDailyView:Dispose()
	self.moneyCell:Dispose()
	self.MainStageTabItem:Dispose()
	self.ClassifitaionView:Dispose()
	AssetUtil.UnloadAsset(self)
end

function ChapterStageMapUI:LoadPermanentItem()
	return
end

function ChapterStageMapUI:UpdateMainLineInfo()
	if self.curStageCfg then
		UGUIUtil.SetText(self.chapterNameText, self.curStageCfg.Name)
	end
end

function ChapterStageMapUI:ClickMarkItemMoveMapEvent(pos, isPlayAnim, callBack)
	local worldPos = Clone(pos)
	local screenPos = GameEntry.UICamera:WorldToScreenPoint(worldPos)
	local isRect, resultPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.MapObjectRect, screenPos, GameEntry.UICamera, nil)

	if not isRect then
		logError("转换错误")
	else
		self.mapScroll.enabled = false

		local mouseWorldPos = GameEntry.UICamera:ScreenToWorldPoint(resultPos)
		local targetPosX = math.clamp(-resultPos.x, -(self.MapObjectRect.sizeDelta.x - self.rootRectX / 2), -(self.rootRectX / 2))
		local targetPosY = math.clamp(-resultPos.y, self.rootRectY / 2, self.MapObjectRect.sizeDelta.y - self.rootRectY / 2)
		local distance = Vector3.Distance(worldPos, mouseWorldPos)

		if isPlayAnim == true then
			local playTime = distance / 100 * 0.15

			LuaCodeInterface.DoLocalMoveWithRect(self.MapObjectRect, Vector2.New(targetPosX, targetPosY), playTime, DoTweenEase.Linear, function()
				self.mapScroll.enabled = true

				if callBack then
					callBack()
				end
			end)
			LuaCodeInterface.DoLocalMoveWithRect(self.UIMapImgRect, Vector2.New(targetPosX, targetPosY), playTime, DoTweenEase.Linear, function()
				return
			end)

			return
		end

		LuaUtility.SetAnchoredPositionWithRectTransform(self.MapObjectRect, targetPosX, targetPosY)
		LuaUtility.SetAnchoredPositionWithRectTransform(self.UIMapImgRect, targetPosX, targetPosY)

		if callBack then
			callBack()
		end

		self.mapScroll.enabled = true
	end
end

function ChapterStageMapUI:PlayMapCloundMask()
	local newUnlockCfg = MapModule.GetNewUnlockMap()

	if self.lastUnlockCfg ~= nil and self.lastUnlockCfg.Id == newUnlockCfg.Id then
		return
	end

	self.lastUnlockCfg = newUnlockCfg

	AssetUtil.LoadAsset(self, newUnlockCfg.CloudMask, self.LoadMapCloudMaskSuccess, nil, newUnlockCfg)
end

function ChapterStageMapUI:LoadMapCloudMaskSuccess(assetName, asset, duration, userData)
	local newUnlockCfg = userData
	local effectIsPlayed = MapModule.GetCloudIsPlayed(newUnlockCfg.Id)

	self.UIMapImgCom.material:SetTexture("_MainMask", asset)

	if effectIsPlayed then
		self.UIMapImgCom.material:SetFloat("_CloudMaskLerp", 1)
	else
		self.UIMapImgCom.material:SetFloat("_CloudMaskLerp", -1)

		self.effectCoroutine = CoroutineUtility.StartCoroutine(function()
			CoroutineUtility.Yield(CustomWaitForSeconds(1.5))
			UGUIUtil.DoGetValue(-1, 1, 2, DoTweenEase.Linear, function(runNumber)
				self.UIMapImgCom.material:SetFloat("_CloudMaskLerp", runNumber)
			end, function()
				return
			end)
		end)

		MapModule.TakeNotesEffectId(newUnlockCfg.Id)
	end
end

function ChapterStageMapUI:OnClickStageItemEvent(stageId, onlyMovePos, ignoreLocation)
	local pos
	local worldMapItemCfg = CfgWorldMapItemTable[stageId]

	if worldMapItemCfg == nil then
		return
	end

	local mapItemCell = self:GetMarkMapItemCell(worldMapItemCfg)

	if mapItemCell then
		pos = mapItemCell:GetPos()

		self:ResetItemCellStateHandler()

		if not onlyMovePos then
			local stageType = worldMapItemCfg.Type

			if stageType == Constant.MapStageType.MainLine or stageType == Constant.MapStageType.BranchLine then
				self.MapMainChapterView:SetData(stageId)
			else
				self.MapDailyView:SetData(stageId)
			end

			self.ClassifitaionView:Hide()
			self:RefreshItemCellStateHandler(stageId)
		elseif not ignoreLocation then
			self:RefreshItemCellLocationStateHandler(stageId)
		end

		EventDispatcher.Dispatch(EventID.OnUpdateSelected, stageId)
	else
		local location = worldMapItemCfg.Location

		LuaUtility.SetAnchoredPositionWithRectTransform(self.Target:GetComponent("RectTransform"), location[1], location[2])

		pos = self.Target.transform.position
	end

	self:ClickMarkItemMoveMapEvent(pos, true)
end

function ChapterStageMapUI:LoadMapItem(stageDatas, isMark)
	for i, v in pairs(stageDatas) do
		if isMark and v.IsShow == true or not isMark and v.OnMap == 1 then
			local mapItemCell = self:GetMapItemCell(v.Id)

			if mapItemCell == nil then
				mapItemCell = MapItemManager.CreateMapItem(v.Type, self.MapObject.transform, isMark)

				self:AddMapItemCell(mapItemCell, v.Id)
			end

			mapItemCell:SetData(v, isMark)
			mapItemCell:Show()
		end
	end
end

function ChapterStageMapUI:GetMapItemCell(stageId)
	return self.CurMapItemCells[stageId]
end

function ChapterStageMapUI:AddMapItemCell(mapItemCell, stageId)
	self.CurMapItemCells[stageId] = mapItemCell
end

function ChapterStageMapUI:RemoveMapItemCell(stageId)
	self.CurMapItemCells[stageId] = nil
end

function ChapterStageMapUI:ReleaseMapItem()
	for k, v in pairs(self.CurMapItemCells) do
		if v == nil then
			logError(string.format("尝试卸载%s的资源引用,但发现引用不存在!", k))
		else
			MapItemManager.ReleaseMapItem(v)
		end
	end

	self.CurMapItemCells = {}
end

function ChapterStageMapUI:GetMarkMapItemCell(stageCfg)
	if stageCfg.WorldMapMarkID ~= 0 then
		return self:GetMapItemCell(stageCfg.WorldMapMarkID)
	else
		local itemCell = self:GetMapItemCell(stageCfg.Id)

		if itemCell == nil then
			itemCell = MapItemManager.CreateMapItem(Constant.MapStageType.MainLine, self.MapObject.transform, false)

			self:AddMapItemCell(itemCell, stageCfg.Id)
		end

		itemCell:SetData(stageCfg, false)

		return itemCell
	end
end

function ChapterStageMapUI:OnClickWorldMapBtn()
	UIModule.Open(Constant.UIControllerName.ChapterMapUI, Constant.UILayer.UI)
end

function ChapterStageMapUI:OnCloseChapterDetailsEvent()
	self.ClassifitaionView:Show()
	self.ClassifitaionView:SetData()

	if self.CurSelectItemCell ~= nil then
		self.CurSelectItemCell:OnLocationState()
	end
end

function ChapterStageMapUI:NotifyUpdateStage(dups)
	self:ResetItemCellStateHandler()
	self:CompareStageDifference()

	if MapModule.GetIsHasMainlineStage(dups) then
		self:PlayLastStageAnim()
	end

	self:UpdateStageInfoRemoveMainline(dups)

	MapModule.LastSelectedStageID = nil

	self.ClassifitaionView:SetData()
	self:PlayMapCloundMask()

	if MapModule.GetMainlineFinishState() then
		MapModule.TargetMapItem = nil

		self:UpdateMainLineState()
	end

	self:UpdatePlayerHeadLocation()
end

function ChapterStageMapUI:UpdateMainLineState()
	local targetCfg = CfgWorldMapItemTable[MapModule.NormalStageID]
	local location

	if targetCfg.WorldMapMarkID == 0 then
		location = targetCfg.Location
	else
		location = CfgWorldMapMarkTable[targetCfg.WorldMapMarkID].Location
	end

	LuaUtility.SetAnchoredPositionWithRectTransform(self.Target:GetComponent("RectTransform"), location[1], location[2])
	self:ClickMarkItemMoveMapEvent(self.Target.transform.position, false)
	self.ArrowInstructionView:SetState(false)
end

function ChapterStageMapUI:UpdateStageInfoRemoveMainline(dups)
	for k, v in pairs(dups) do
		if CfgWorldMapItemTable[k].Type ~= Constant.MapStageType.MainLine then
			local mapItemCell = self:GetMapItemCell(k)

			if mapItemCell then
				mapItemCell:Hide()
				MapItemManager.ReleaseMapItem(mapItemCell)
				self:RemoveMapItemCell(k)
			end
		end
	end
end

function ChapterStageMapUI:PlayLastStageAnim()
	self.LastStageId = MapModule.GetcurstagePreviousStage()

	if self.LastStageId == nil then
		return
	end

	local lastStageCfg = CfgWorldMapItemTable[self.LastStageId]

	if MapModule.GetMainlineFinishState() then
		self:UpdateLastStageItemCellState()

		return
	end

	self.curStageCfg = MapModule.GetMainLineNewUnlock()

	local newStageId = self.curStageCfg.Id

	if MapModule.GetStageIsPlayAnim(newStageId) then
		return
	end

	local newMapItemCell = self:GetMarkMapItemCell(self.curStageCfg)

	if self.curStageCfg.WorldMapMarkID == 0 then
		newMapItemCell:SetData(self.curStageCfg, false)
		newMapItemCell:Hide()
	else
		newMapItemCell:SetData(CfgWorldMapMarkTable[self.curStageCfg.WorldMapMarkID], true)
	end

	MapModule.TargetMapItem = newMapItemCell.View

	MapModule.TakeNotesEffectId(newStageId)

	if lastStageCfg == nil or lastStageCfg.WorldMapMarkID == self.curStageCfg.WorldMapMarkID and self.curStageCfg.WorldMapMarkID ~= 0 then
		return
	end

	self.LastStageItemCell = self:GetMarkMapItemCell(lastStageCfg)

	if lastStageCfg.WorldMapMarkID == 0 then
		self.LastStageItemCell:SetData(lastStageCfg)
	else
		self.LastStageItemCell:SetData(CfgWorldMapMarkTable[lastStageCfg.WorldMapMarkID], true)
	end

	LuaUtility.SetGameObjectShow(self.Mask, true)
	CoroutineUtility.StartCoroutine(function()
		CoroutineUtility.Yield(CustomWaitForSeconds(1.5))
		self:ClickMarkItemMoveMapEvent(self.LastStageItemCell:GetPos(), false, function()
			self:UpdateLastStageItemCellState()
			newMapItemCell:Show()
			self:ClickMarkItemMoveMapEvent(newMapItemCell:GetPos(), true)
			LuaUtility.SetGameObjectShow(self.Mask, false)
		end)
	end)
end

function ChapterStageMapUI:UpdateLastStageItemCellState()
	local lastStageCfg = CfgWorldMapItemTable[self.LastStageId]

	if self.LastStageItemCell ~= nil then
		if lastStageCfg.WorldMapMarkID == 0 then
			self.LastStageItemCell:Hide()
			self:RemoveMapItemCell(self.LastStageId)
			MapItemManager.ReleaseMapItem(self.LastStageItemCell)

			self.LastStageItemCell = nil
		else
			self.LastStageItemCell:SetData(CfgWorldMapMarkTable[lastStageCfg.WorldMapMarkID], true)
		end
	end

	self.LastStageId = nil
end

function ChapterStageMapUI:CompareStageDifference()
	self:LoadMapItem(MapModule.GetAllMarkItem(), true)

	self.LastStageItemDatas = MapModule.GetAllUnlockItem()

	self:LoadMapItem(self.LastStageItemDatas)
end

function ChapterStageMapUI:RefreshItemCellStateHandler(stageID)
	local mapItemCell = self:GetMapItemCell(stageID)

	if mapItemCell == nil and CfgWorldMapItemTable[stageID].WorldMapMarkID ~= 0 then
		mapItemCell = self:GetMapItemCell(CfgWorldMapItemTable[stageID].WorldMapMarkID)
	end

	for k, v in pairs(self.CurMapItemCells) do
		if v == mapItemCell then
			v:OnSelectState()

			self.CurSelectItemCell = v
		else
			v:OnOtherSelectState()
		end
	end
end

function ChapterStageMapUI:RefreshItemCellLocationStateHandler(stageID)
	local mapItemCell = self:GetMapItemCell(stageID)

	if mapItemCell == nil and CfgWorldMapItemTable[stageID].WorldMapMarkID ~= 0 then
		mapItemCell = self:GetMapItemCell(CfgWorldMapItemTable[stageID].WorldMapMarkID)
	end

	for k, v in pairs(self.CurMapItemCells) do
		if v == mapItemCell then
			v:OnLocationState()

			self.CurSelectItemCell = v
		else
			v:OnOtherSelectState()
		end
	end
end

function ChapterStageMapUI:ResetItemCellStateHandler()
	for k, v in pairs(self.CurMapItemCells) do
		v:OnResetOtherSelectState()
	end
end

function ChapterStageMapUI:OnSingleDailyDupUpdateEvent(smallId)
	MapModule.LastSelectedStageID = nil

	local itemCell = self:GetMapItemCell(smallId)

	if itemCell ~= nil then
		itemCell:Hide()
		MapItemManager.ReleaseMapItem(itemCell)
		self:RemoveMapItemCell(smallId)
		self.ClassifitaionView:SetData()
	end
end

function ChapterStageMapUI:OnAllDailyDupsUpdateEvent()
	MapModule.LastSelectedStageID = nil

	local isRemoveList = {}

	for k, v in pairs(self.CurMapItemCells) do
		if not v.isMark and CfgWorldMapItemTable[k].Type == Constant.MapStageType.Daily then
			table.insert(isRemoveList, k)
		end
	end

	for k, v in pairs(isRemoveList) do
		local itemCell = self:GetMapItemCell(k)

		if itemCell ~= nil then
			itemCell:Hide()
			MapItemManager.ReleaseMapItem(itemCell)
			self:RemoveMapItemCell(k)
		end
	end

	self:LoadMapItem(MapModule.GetDailyStages())
	self.ClassifitaionView:SetData()
end

function ChapterStageMapUI:UpdatePlayerHeadLocation(isFirst)
	if MapModule.TargetMapItem == nil then
		LuaUtility.SetGameObjectShow(self.PlayerHead, false)

		return
	end

	LuaUtility.SetGameObjectShow(self.PlayerHead, true)

	local pos = MapModule.TargetMapItem.transform.localPosition

	if isFirst then
		LuaUtility.SetLocalPositionWithGameObject(self.PlayerHead, pos.x, pos.y + 60, 0)
	else
		local distance = Vector3.Distance(pos, self.PlayerHeadRect.localPosition)

		log("Distance:" .. distance, colorCode.Green)

		local playTime = distance / 100 * 0.5

		LuaCodeInterface.DoLocalMoveWithRect(self.PlayerHeadRect, Vector2.New(pos.x, pos.y + 60), playTime, DoTweenEase.Linear, function()
			return
		end)
	end

	self.PlayerHead.transform:SetSiblingIndex(self.MapObjectRect.childCount - 1)
end

function ChapterStageMapUI:LoadPlayerHeadImg()
	AssetUtil.LoadImage(self, ChapterStageMapUIApi:GetPlayerHeroImagePath(PlayerModule.GetSex()), self.PlayerHead:GetComponent("Image"))
end

function ChapterStageMapUI:CheckChallengeTips()
	local type = MapModule.CheckChallengeTipsShow()

	if type == 0 then
		LuaUtility.SetGameObjectShow(self.challengeTipsPanel, false)

		return
	end

	if type == 3 then
		coroutine.start(function()
			local text1, text2 = ChapterStageMapUIApi:GetChallengeText(2)

			LuaUtility.SetText(self.Text1, text1)
			LuaUtility.SetText(self.Text2, text2)
			LuaUtility.SetGameObjectShow(self.challengeTipsPanel, true)
			coroutine.wait(1)

			local text1, text2 = ChapterStageMapUIApi:GetChallengeText(1)

			LuaUtility.SetText(self.Text1, text1)
			LuaUtility.SetText(self.Text2, text2)
			coroutine.wait(1)
			LuaUtility.SetGameObjectShow(self.challengeTipsPanel, false)
		end)

		return
	end

	local text1, text2 = ChapterStageMapUIApi:GetChallengeText(type)

	LuaUtility.SetText(self.Text1, text1)
	LuaUtility.SetText(self.Text2, text2)
	LuaUtility.SetGameObjectShow(self.challengeTipsPanel, true)
	coroutine.start(function()
		coroutine.wait(1)
		LuaUtility.SetGameObjectShow(self.challengeTipsPanel, false)
	end)
end

return ChapterStageMapUI
