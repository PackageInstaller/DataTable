-- chunkname: @IQIGame\\Scene\\Battle\\BattleScene.lua

local BattleTileView = require("IQIGame/Scene/Battle/BattleTileView")
local BattleUnitView = require("IQIGame/Scene/Battle/BattleUnitView")
local BattleInputController = require("IQIGame/Scene/Battle/BattleInputController")
local BattleScene = {
	battleTilesView = {},
	battleUnitsView = {},
	virtualCamerasTable = {}
}

function BattleScene.New(callback)
	local obj = Clone(BattleScene)

	obj:__Init(callback)

	return obj
end

function BattleScene:__Init(callback)
	GameEntry.Input:RemoveTapGesture()
	GameEntry.Input:RemovePanGesture()
	GameEntry.Input:RemoveLongPressGesture()
	self:__InitDelegates()

	local sceneListConfig = CfgSceneListTable[BattleConstant.BattleViewRootConfigID]

	if sceneListConfig == nil then
		logError(string.format("SceneList表找不到sceneID为%d的场景配置", BattleConstant.BattleViewRootConfigID))

		return
	end

	BattleScene.__LoadScene(self, "BattleViewRoot", function(_asset)
		self:__OnBattleViewLoaded(_asset, callback)
	end, function()
		logError("战斗场景显示节点加载失败： {0}", tostring(BattleConstant.BattleViewRootConfigID))
	end)
	self:__AddListeners()
end

function BattleScene:__InitDelegates()
	function self.__delegateOnBattleUnitTapEvent(_transform, _gesture)
		self:__OnBattleUnitTapEventHandler(_transform, _gesture)
	end

	function self.__delegateOnBattleUnitLongPressEvent(_transform, _gesture)
		self:__OnBattleUnitLongPressEventHandler(_transform, _gesture)
	end

	function self.__delegateOnBattleUnitBeginDragEvent(_transform, _gesture)
		return self:__OnBattleUnitBeginDragEventHandler(_transform, _gesture)
	end

	function self.__delegateOnBattleUnitDraggingEvent(_battleUnitID, _transform, _gesture)
		self:__OnBattleUnitDraggingEventHandler(_battleUnitID, _transform, _gesture)
	end

	function self.__delegateOnBattleUnitEndDragEvent(_battleUnitID, _transform, _gesture)
		self:__OnBattleUnitEndDragEventHandler(_battleUnitID, _transform, _gesture)
	end

	function self.delegateOnBattleUnitSetTurnOrder(battleUnitID)
		self:__OnBattleUnitSetTurnOrder(battleUnitID)
	end

	function self.delegateOnBattleUnitSelectedSkill(battleUnitID, skillCid)
		self:__OnBattleUnitSelectedSkill(battleUnitID, skillCid)
	end

	function self.delegateOnBattleUnitOrderComplete()
		self:__OnBattleUnitOrderComplete()
	end

	function self.delegateOnBattleUnitSelectedTarget(anchorTile, hitTiles)
		self:__OnBattleUnitSelectedTarget(anchorTile, hitTiles)
	end

	function self.delegateOnRemoveBattleUnit(battleUnitID)
		self:RemoveBattleUnit(battleUnitID)
	end

	function self.delegateOnBattleUnitDead(battleUnitID)
		self:OnBattleUnitDie(battleUnitID)
	end

	function self.delegateOnBattleUnitPosChange(battleUnitID)
		self:ChangeBattleUnitPos(battleUnitID)
	end

	function self.delegateOnSoundVolumeChanged(value)
		self:OnSoundVolumeChanged(value)
	end

	function self.delegateOnShowBattleSkillTargetTilePreview(_anchorTilePos, _allHitTilePos, _battleUnitID, _skillCid)
		self:__OnShowBattleSkillTargetTilePreview(_anchorTilePos, _allHitTilePos, _battleUnitID, _skillCid)
	end

	function self.delegateOnShowEnemyBattleSkillAreaWarning(_battleUnitID, _skillCid, _anchorTilePos, _allHitTilePos)
		self:__OnShowEnemyBattleSkillAreaWarning(_battleUnitID, _skillCid, _anchorTilePos, _allHitTilePos)
	end

	function self.delegateOnHideEnemyBattleSkillAreaWarning()
		self:__OnHideEnemyBattleSkillAreaWarning()
	end

	function self.delegateOnRefreshBattleTileMoveStateShow(_battleUnitID)
		self:__OnRefreshBattleTileMoveStateShow(_battleUnitID)
	end

	function self.delegateOnHideBattleSkillTargetRolePreview()
		self:__OnHideBattleSkillTargetRolePreview()
	end

	function self.__delegateOnUpdateBattleUnitsDataComplete(_battleUpdatePoint)
		self:__OnUpdateBattleUnitsDataComplete(_battleUpdatePoint)
	end

	function self.__delegateOnRefreshBattleSkillTargetRolePreview()
		self:__OnRefreshBattleSkillTargetRolePreview()
	end

	function self.__delegateOnNotifyBattleTileMoveNodeClicked(_, _battlePos)
		BattleTeamActionModule.SendMoveOrder(_battlePos)
	end
end

function BattleScene:__InitVirtualCameras()
	self.virtualCamerasTable = {}

	for _, _cameraName in pairs(BattleConstant.BattleVirtualCameras) do
		local virtualCamera = self.virtualCamera.transform:Find(_cameraName).gameObject

		self.virtualCamerasTable[_cameraName] = virtualCamera

		TimelineUtility.commonVirtualCameras:set_Item(_cameraName, virtualCamera:GetComponent(typeof(Cinemachine.CinemachineVirtualCamera)))
	end
end

function BattleScene:SwitchVirtualCamera(cameraName)
	for _name, _cameraObj in pairs(self.virtualCamerasTable) do
		_cameraObj:SetActive(false)
	end

	self.virtualCamerasTable[cameraName]:SetActive(true)
end

function BattleScene:HideAllBattleCurve()
	ForPairs(self.targetCurves, function(_, _curve)
		_curve:ClearLine()
	end)
end

function BattleScene:__InitBattleCurves()
	self.targetCurves = {}

	ForTransformChild(self.battleCurvesRoot.transform, function(_trans, _index)
		local curveCom = _trans.gameObject:GetComponent(typeof(BattleTargetCurve))

		curveCom:ClearLine()
		table.insert(self.targetCurves, curveCom)
	end)
end

function BattleScene:__OnBattleViewLoaded(asset, callback)
	self.battleViewRoot = GameObject.Instantiate(asset)

	LuaCodeInterface.BindOutlet(self.battleViewRoot, self)
	self.templateRoot.gameObject:SetActive(false)

	self.battleCameraCom = GameEntry.RenderingComponent:GetMainCamera()
	self.inputController = BattleInputController.New(self.battleCameraCom)
	self.inputController.BattleUnitTapEvent = self.__delegateOnBattleUnitTapEvent
	self.inputController.BattleUnitLongPressEvent = self.__delegateOnBattleUnitLongPressEvent
	self.inputController.BattleUnitBeginDragEvent = self.__delegateOnBattleUnitBeginDragEvent
	self.inputController.BattleUnitDraggingEvent = self.__delegateOnBattleUnitDraggingEvent
	self.inputController.BattleUnitEndDragEvent = self.__delegateOnBattleUnitEndDragEvent

	self:__InitBattleTileView(self.heroPosition.transform, BattleConstant.BattleTilePosTroopTypeOffset)
	self:__InitBattleTileView(self.enemyPosition.transform, BattleConstant.BattleTilePosTroopTypeOffset * 2)
	self:__InitVirtualCameras()
	self:__InitBattleCurves()

	if callback ~= nil then
		callback()
	end
end

function BattleScene:OnSoundVolumeChanged(value)
	BattleTimelineModule.OnSoundVolumeChanged(value)
end

function BattleScene:__AddListeners()
	EventDispatcher.AddEventListener(EventID.SoundVolumeChange_MusicGroup, self.delegateOnSoundVolumeChanged)
	EventDispatcher.AddEventListener(EventID.OnBattleUnitSetTurnOrder, self.delegateOnBattleUnitSetTurnOrder)
	EventDispatcher.AddEventListener(EventID.OnBattleUnitOrderComplete, self.delegateOnBattleUnitOrderComplete)
	EventDispatcher.AddEventListener(EventID.RemoveBattleUnit, self.delegateOnRemoveBattleUnit)
	EventDispatcher.AddEventListener(EventID.BattleUnitDead, self.delegateOnBattleUnitDead)
	EventDispatcher.AddEventListener(EventID.BattleUnitChangePos, self.delegateOnBattleUnitPosChange)
	EventDispatcher.AddEventListener(EventID.ShowBattleSkillTargetTilePreview, self.delegateOnShowBattleSkillTargetTilePreview)
	EventDispatcher.AddEventListener(EventID.ShowEnemyBattleSkillAreaWarning, self.delegateOnShowEnemyBattleSkillAreaWarning)
	EventDispatcher.AddEventListener(EventID.HideEnemyBattleSkillAreaWarning, self.delegateOnHideEnemyBattleSkillAreaWarning)
	EventDispatcher.AddEventListener(EventID.RefreshBattleTileMoveStateShow, self.delegateOnRefreshBattleTileMoveStateShow)
	EventDispatcher.AddEventListener(EventID.HideBattleSkillTargetRolePreview, self.delegateOnHideBattleSkillTargetRolePreview)
	EventDispatcher.AddEventListener(EventID.UpdateBattleUnitsDataComplete, self.__delegateOnUpdateBattleUnitsDataComplete)
	EventDispatcher.AddEventListener(EventID.RefreshBattleSkillTargetRolePreview, self.__delegateOnRefreshBattleSkillTargetRolePreview)
	EventUtil.AddEventListener(self, EventID.SetBattleTileActiveWithTimelinePlay, self.__OnSetBattleTileActiveWithTimelinePlayHandler)
	EventUtil.AddEventListener(self, EventID.BattleUnitPreviewSkillChange, self.__OnBattleUnitPreviewSkillChangeHandler)
	EventUtil.AddEventListener(self, EventID.NotifyBattleTileMoveNodeClicked, self.__delegateOnNotifyBattleTileMoveNodeClicked)
end

function BattleScene:__RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.SoundVolumeChange_MusicGroup, self.delegateOnSoundVolumeChanged)
	EventDispatcher.RemoveEventListener(EventID.OnBattleUnitSetTurnOrder, self.delegateOnBattleUnitSetTurnOrder)
	EventDispatcher.RemoveEventListener(EventID.OnBattleUnitOrderComplete, self.delegateOnBattleUnitOrderComplete)
	EventDispatcher.RemoveEventListener(EventID.RemoveBattleUnit, self.delegateOnRemoveBattleUnit)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitDead, self.delegateOnBattleUnitDead)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitChangePos, self.delegateOnBattleUnitPosChange)
	EventDispatcher.RemoveEventListener(EventID.ShowBattleSkillTargetTilePreview, self.delegateOnShowBattleSkillTargetTilePreview)
	EventDispatcher.RemoveEventListener(EventID.ShowEnemyBattleSkillAreaWarning, self.delegateOnShowEnemyBattleSkillAreaWarning)
	EventDispatcher.RemoveEventListener(EventID.HideEnemyBattleSkillAreaWarning, self.delegateOnHideEnemyBattleSkillAreaWarning)
	EventDispatcher.RemoveEventListener(EventID.RefreshBattleTileMoveStateShow, self.delegateOnRefreshBattleTileMoveStateShow)
	EventDispatcher.RemoveEventListener(EventID.HideBattleSkillTargetRolePreview, self.delegateOnHideBattleSkillTargetRolePreview)
	EventDispatcher.RemoveEventListener(EventID.UpdateBattleUnitsDataComplete, self.__delegateOnUpdateBattleUnitsDataComplete)
	EventDispatcher.RemoveEventListener(EventID.RefreshBattleSkillTargetRolePreview, self.__delegateOnRefreshBattleSkillTargetRolePreview)
	EventUtil.ClearEventListener(self)
end

function BattleScene:OnFrameUpdate(deltaTime)
	for _unitID, _unitView in pairs(self.battleUnitsView) do
		if _unitView ~= nil then
			_unitView:OnUpdate()
		end
	end
end

function BattleScene:IsPrepareSuccess()
	for _battleUnitId, _battleUnitView in pairs(self.battleUnitsView) do
		if not _battleUnitView.isReadyToShow then
			return false
		end

		if not BattleTimelineModule.CheckBattleUnitTimelineIsReady(_battleUnitId) then
			return false
		end
	end

	return true
end

function BattleScene:PlayAnimationBeforeBattle(callback)
	local recordTable = {}
	local bossCount = #BattleModule.bossTable

	if bossCount == 0 then
		self:__PlayBattleUnitsBorn(recordTable, callback)
		CVModule.PlayFightCVWithBattleUnit(Constant.CVActionType.FightStart, self.battleUnitsView)

		return
	end

	for i = 1, bossCount do
		recordTable[BattleModule.bossTable[i]] = i == 1
	end

	self:BattleUnitJoinBattle(BattleModule.bossTable[1], function(__battleUnitID)
		self:__PlayBattleUnitsBorn(recordTable, callback)
	end)
end

function BattleScene:__PlayBattleUnitsBorn(recordTable, callback)
	ForPairs(self.battleUnitsView, function(_battleUnitId, _battleUnitView)
		if recordTable[_battleUnitId] == true then
			_battleUnitView:PlayAnimation("idle", true)

			return false
		end

		local ignoreTimeline = false

		if recordTable[_battleUnitId] == nil then
			recordTable[_battleUnitId] = false
		else
			ignoreTimeline = true
		end

		local function joinCompleteFunc(__battleUnitID)
			recordTable[__battleUnitID] = true

			_battleUnitView:PlayAnimation("idle", true)

			for _, _complete in pairs(recordTable) do
				if not _complete then
					return
				end
			end

			if callback ~= nil then
				for unitID, _ in pairs(recordTable) do
					EventDispatcher.Dispatch(EventID.BattleUnitJoinFight, unitID)
				end

				callback()
			end
		end

		self:BattleUnitJoinBattle(_battleUnitId, joinCompleteFunc, ignoreTimeline)
	end)
end

function BattleScene:PlayAnimationAfterBattle(callback)
	return
end

function BattleScene:Dispose()
	self:__RemoveListeners()

	if self.inputController ~= nil then
		self.inputController:Dispose()

		self.inputController = nil
	end

	ForPairs(self.battleUnitsView, function(k, v)
		self:RemoveBattleUnit(k)
	end)

	self.battleUnitsView = nil

	ForPairs(self.battleTilesView, function(k, v)
		v:Dispose()
	end)

	self.battleTilesView = nil
	self.virtualCamerasTable = nil
	self.battleCameraCom = nil

	self:__RemoveBattleScene()
	LuaCodeInterface.ClearOutlet(self.battleViewRoot, self)

	local battleViewRoot = self.battleViewRoot

	self.battleViewRoot = nil

	GameObject.Destroy(battleViewRoot)
	AssetUtil.UnloadAsset(self)
end

function BattleScene:Clear()
	ForPairs(self.battleUnitsView, function(k, v)
		self:RemoveBattleUnit(k)
	end)

	self.battleUnitsView = {}

	ForPairs(self.battleTilesView, function(k, v)
		v:Clear()
	end)
end

function BattleScene:__OnBattleUnitTapEventHandler(transform, gesture)
	if transform.gameObject.name == "MoveLayer" then
		self:__OnBattleTileBlockClick(transform)

		return
	end
end

function BattleScene:__OnBattleTileBlockClick(transform)
	if not BattleTeamActionModule.CanManualOperateMover() then
		return
	end

	local insID = transform.gameObject:GetInstanceID()
	local battleTileView = self:GetBattleTileViewByMovePointInstanceID(insID)

	if battleTileView == nil then
		return
	end

	if battleTileView.fightBattleUnitID ~= 0 then
		local targetBattleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleTileView.fightBattleUnitID)

		if targetBattleUnitData:IsInFightStatus(Constant.BattleFightStatus.MOVE_LIMIT) then
			return
		end

		if not targetBattleUnitData:CanSetTurnOrder() then
			return
		end
	end

	BattleTeamActionModule.SendMoveOrder(battleTileView.battlePos)
end

function BattleScene:__OnBattleUnitLongPressEventHandler(transform, gesture)
	local instanceID = transform.gameObject:GetInstanceID()
	local battleUnitView = BattleModule.battleScene:GetBattleUnitViewByInstanceID(instanceID)

	if battleUnitView == nil then
		return
	end

	EventDispatcher.Dispatch(EventID.ShowBattleUnitDetailView, battleUnitView.battleUnitID)
end

function BattleScene:__OnBattleUnitBeginDragEventHandler(transform, gesture)
	if not BattleTeamActionModule.CanManualOperateMover() then
		return
	end

	local instanceID = transform.gameObject:GetInstanceID()
	local battleUnitView = BattleModule.battleScene:GetBattleUnitViewByInstanceID(instanceID)

	if battleUnitView == nil then
		return 0
	end

	if not BattleTeamActionModule.CanDragMover(battleUnitView.battleUnitID) then
		return 0
	end

	return battleUnitView.battleUnitID
end

function BattleScene:__OnBattleUnitDraggingEventHandler(battleUnitID, transform, gesture)
	local battleUnitView = self:GetBattleUnitViewByID(battleUnitID)

	if battleUnitView == nil then
		return
	end

	if transform ~= nil and transform.gameObject.name == "Block" then
		battleUnitView.skinEntityGo.gameObject.transform.position = transform.position

		return
	end

	battleUnitView.skinEntityGo.gameObject.transform.localPosition = Vector3.zero
end

function BattleScene:__OnBattleUnitEndDragEventHandler(battleUnitID, transform, gesture)
	local battleUnitView = self:GetBattleUnitViewByID(battleUnitID)

	if battleUnitView == nil then
		return
	end

	if transform ~= nil and transform.gameObject.name == "Block" then
		local insID = transform.gameObject:GetInstanceID()
		local battleTileView = self:GetBattleTileViewByMovePointInstanceID(insID)

		if battleTileView ~= nil then
			BattleTeamActionModule.SendBattleUnitSelectedMoveOrder2(battleUnitID, battleTileView.battlePos)
		end

		return
	end

	battleUnitView.skinEntityGo.gameObject.transform.localPosition = Vector3.zero
end

function BattleScene:LoadBattleScene(sceneCfgID)
	if self.sceneCfgID == sceneCfgID then
		return
	end

	if self.sceneCfgID ~= sceneCfgID then
		self:__RemoveBattleScene()
	end

	self.sceneCfgID = sceneCfgID

	local sceneListConfig = CfgSceneListTable[sceneCfgID]

	if sceneListConfig == nil then
		logError(string.format("SceneList表找不到sceneID为%d的场景配置", sceneCfgID))

		return
	end

	if self.bgmSerialID ~= nil then
		LuaUtility.ReplaceBGM(self.bgmSerialID, sceneListConfig.BGM)
	else
		self.bgmSerialID = LuaUtility.PlayBGMWithID(sceneListConfig.BGM)
	end

	BattleScene.__LoadScene(self, sceneListConfig.SceneFile, function(_asset)
		self.sceneObj = GameObject.Instantiate(_asset)

		self:__LoadSceneRenderConfig(BattleApi:GetSceneRenderConfigPath(sceneListConfig.RenderConfig))
	end)
end

function BattleScene:__LoadSceneRenderConfig(path)
	BattleScene.__LoadObject(self, path, function(_asset)
		log("BattleView 应用战斗场景配置 {0}", path)
		SceneRenderConfigManager.ApplyConfig(_asset)
	end)
end

function BattleScene:__RemoveBattleScene()
	if self.sceneObj == nil then
		return
	end

	local sceneObj = self.sceneObj

	self.sceneObj = nil

	GameObject.Destroy(sceneObj)
end

function BattleScene:__InitBattleTileView(parentTrans, offsetIndex)
	for i = 1, parentTrans.childCount do
		local tileViewParentTrans = parentTrans:Find(tostring(i))
		local tileView = tileViewParentTrans:Find(Battle.BattleTimelineManager.Tile_ROOT_NAME)
		local tileIndex = i + offsetIndex

		self.battleTilesView[tileIndex] = BattleTileView.New(tileIndex, tileView.gameObject)
	end
end

function BattleScene:RefreshBattleTileData(battleTileData)
	local battleUnitView = self:GetBattleTileView(battleTileData.tileIndex)

	battleUnitView:InitByTileData(battleTileData)
end

function BattleScene:GetBattleTileView(tileIndex)
	return self.battleTilesView[tileIndex]
end

function BattleScene:GetBattleTileViewByUnitID(unitID)
	local result

	self:ForeachBattleTileView(function(tileIndex, tileView)
		if tileView.battleUnitID == unitID then
			result = tileView

			return true
		end
	end)

	return result
end

function BattleScene:GetBattleTileViewByMovePointInstanceID(instanceID)
	for tileIndex, tileView in pairs(self.battleTilesView) do
		if tileView:GetMovePointInstanceID() == instanceID then
			return tileView
		end
	end

	return nil
end

function BattleScene:ForeachBattleTileView(action)
	for tileIndex, tileView in pairs(self.battleTilesView) do
		if action(tileIndex, tileView) == true then
			return
		end
	end
end

function BattleScene:AddBattleUnitView(battleUnitData)
	local battleUnitView = BattleUnitView.New(battleUnitData.battleUnitID)

	battleUnitView:CreateView(battleUnitData, nil, self.tempSourceRoot.transform)

	self.battleUnitsView[battleUnitData.battleUnitID] = battleUnitView

	for _skillCid, _timelineCid in pairs(battleUnitData.PODData.SkillSkinId) do
		BattleTimelineModule.AddSkillTimeline(battleUnitData.battleUnitID, _skillCid, _timelineCid)
	end

	for _stateType, _timelineCid in pairs(battleUnitData.StateTimeLine) do
		BattleTimelineModule.AddStateTimeline(battleUnitData.battleUnitID, _stateType, _timelineCid)
	end

	local tileKey = BattleModule.BattleTilePosStoC(battleUnitData.troopType, battleUnitData.battlePos)
	local tileView = self.battleTilesView[tileKey]

	tileView:RefreshTileShowStateWithBattleFightUnitID(battleUnitData.battleUnitID)
end

function BattleScene:AddBattleUnitSkinView(battleUnitID)
	local oldBattleUnitView = self:GetBattleUnitViewByID(battleUnitID)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)
	local battleUnitView = BattleUnitView.New(battleUnitID)

	battleUnitView:CreateView(battleUnitData, oldBattleUnitView, self.tempSourceRoot.transform)

	for _stateType, _timelineCid in pairs(battleUnitData.StateTimeLine) do
		BattleTimelineModule.AddStateTimeline(battleUnitID, _stateType, _timelineCid)
	end

	if self.battleUnitSkinView == nil then
		self.battleUnitSkinView = {}
	end

	self.battleUnitSkinView[battleUnitID] = battleUnitView
end

function BattleScene:GetBattleUnitSkinView(battleUnitID)
	local view

	if self.battleUnitSkinView ~= nil then
		view = self.battleUnitSkinView[battleUnitID]
	end

	if view == nil then
		logError("获取战斗单位 {0} 皮肤预制体错误", battleUnitID)
	end

	return view
end

function BattleScene:BattleUnitViewSkinPrepareJoinByTimeline(battleUnitID)
	local skinView = self:GetBattleUnitSkinView(battleUnitID)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)
	local tileKey = BattleModule.BattleTilePosStoC(battleUnitData.troopType, battleUnitData.battlePos)
	local tileView = self.battleTilesView[tileKey]

	skinView.skinEntityGo:SetActive(false)
	skinView:ChangeParent(tileView.gameObject.transform.parent, battleUnitData.isUnitFlip)
end

function BattleScene:BattleUnitSkinViewJoinBattleByTimeline(battleUnitID)
	local oldView = self.battleUnitsView[battleUnitID]

	oldView:Dispose()

	local skinView = self:GetBattleUnitSkinView(battleUnitID)

	skinView:OnJoinBattleComplete()
	skinView.skinEntityGo:SetActive(true)

	self.battleUnitsView[battleUnitID] = skinView
	self.battleUnitSkinView[battleUnitID] = nil

	EventDispatcher.Dispatch(EventID.BattleUnitSkinViewJoinBattle, battleUnitID)
end

function BattleScene:BattleUnitSkinViewJoinBattle(battleUnitID)
	local oldView = self.battleUnitsView[battleUnitID]
	local skinView = self:GetBattleUnitSkinView(battleUnitID)

	if oldView == nil then
		logError("角色 {0} 已经死亡还收到变身消息,需要检查Buff逻辑", battleUnitID)
		skinView:Dispose()

		self.battleUnitSkinView[battleUnitID] = nil

		return
	end

	oldView:Dispose()

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)
	local tileKey = BattleModule.BattleTilePosStoC(battleUnitData.troopType, battleUnitData.battlePos)
	local tileView = self.battleTilesView[tileKey]

	skinView:ChangeParent(tileView.gameObject.transform.parent, battleUnitData.isUnitFlip)
	skinView:OnJoinBattleComplete()
	skinView:PlayChangeSkinEffect()

	self.battleUnitsView[battleUnitID] = skinView
	self.battleUnitSkinView[battleUnitID] = nil

	EventDispatcher.Dispatch(EventID.BattleUnitSkinViewJoinBattle, battleUnitID)
end

function BattleScene:BattleUnitJoinBattle(battleUnitId, callback, ignoreTimeline)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitId)

	battleUnitData.joinBattle = true

	local battleUnitView = self.battleUnitsView[battleUnitId]
	local tileKey = BattleModule.BattleTilePosStoC(battleUnitData.troopType, battleUnitData.battlePos)
	local tileView = self.battleTilesView[tileKey]

	battleUnitView:JoinBattle(tileView.gameObject.transform.parent, battleUnitData.isUnitFlip, battleUnitData.PODData.CreateType)
	tileView:RefreshTileShowStateWithBattleFightUnitID(battleUnitId)

	if ignoreTimeline then
		battleUnitView:OnJoinBattleComplete()

		if callback ~= nil then
			callback(battleUnitId)
		end

		return
	end

	BattleTimelineModule.PlayStateTimeline(battleUnitId, BattleConstant.BattleStateTimelineType.Born, function()
		battleUnitView:OnJoinBattleComplete()

		if callback ~= nil then
			callback(battleUnitId)
		end
	end)
end

function BattleScene:ChangeBattleUnitPos(battleUnitId)
	ForPairs(self.battleTilesView, function(_, _battleTileView)
		if _battleTileView.fightBattleUnitID ~= battleUnitId then
			return
		end

		_battleTileView:RefreshTileShowStateWithBattleFightUnitID(0)
	end)

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitId)
	local battleUnitView = self:GetBattleUnitViewByID(battleUnitId)

	battleUnitView:ShowNormalState()

	if battleUnitData.troopType == BattleModule.playerBattleTroop then
		battleUnitView:PlayAnimation("move", false)
	end

	local timer = BattleApi:GetHeroMoveHalfTimer() / BattleTimeScaleManager.TimeScale

	BattleModule.AddCustomWaitSecondCondition(timer, function()
		local tileKey = BattleModule.BattleTilePosStoC(battleUnitData.troopType, battleUnitData.battlePos)
		local tileView = self.battleTilesView[tileKey]

		GameEntry.Effect:PlayNormalEffect(42001, tileView.gameObject.transform.position, 0, 0.5)
		battleUnitView:ChangeParent(tileView.gameObject.transform.parent, battleUnitData.isUnitFlip)
		tileView:RefreshTileShowStateWithBattleFightUnitID(battleUnitId)

		if BattleTeamActionModule.InState(BattleConstant.BattleTeamActionState.ManualOperate) and BattleTeamActionModule.IsManualOperateMoverID(battleUnitId) then
			battleUnitView:ShowSelectOrderState(true)
		end

		if GuideModule.IsGuiding then
			EventDispatcher.Dispatch(EventID.BattleUnitMovePosComplete, battleUnitId, battleUnitData.battlePos)
		end

		BattleTeamActionModule.OnMoveOrderComplete()
	end)
end

function BattleScene:OnBattleUnitDie(battleUnitId)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitId)

	if battleUnitData == nil then
		return
	end

	local tileKey = BattleModule.BattleTilePosStoC(battleUnitData.troopType, battleUnitData.battlePos)
	local tileView = self.battleTilesView[tileKey]

	tileView:RefreshTileShowStateWithBattleFightUnitID(0)
end

function BattleScene:GetBattleUnitViewByTileKey(tileKey)
	for _battleUnitID, _battleUnitView in pairs(self.battleUnitsView) do
		local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(_battleUnitID)
		local _tileKey = BattleModule.BattleTilePosStoC(battleUnitData.troopType, battleUnitData.battlePos)

		if _tileKey == tileKey then
			return _battleUnitView
		end
	end

	return nil
end

function BattleScene:GetBattleUnitViewByID(battleUnitId)
	return self.battleUnitsView[battleUnitId]
end

function BattleScene:GetBattleUnitViewByInstanceID(instanceID)
	for i, v in pairs(self.battleUnitsView) do
		if v:GetInstanceID() == instanceID then
			return v
		end
	end

	return nil
end

function BattleScene:ForeachBattleUnitView(action)
	for unitID, unitView in pairs(self.battleUnitsView) do
		if action(unitID, unitView) == true then
			return
		end
	end
end

function BattleScene:RemoveBattleUnit(battleUnitId)
	local battleUnitView = self:GetBattleUnitViewByID(battleUnitId)

	if battleUnitView ~= nil then
		battleUnitView:Dispose()

		battleUnitView = nil
		self.battleUnitsView[battleUnitId] = nil
	end

	BattleTimelineModule.RemoveTimeline(battleUnitId)
end

function BattleScene:IsBattleUnitReadyToShow(battleUnitId)
	local battleUnitView = self.battleUnitsView[battleUnitId]

	if not battleUnitView.isReadyToShow then
		return false
	end

	if not BattleTimelineModule.CheckBattleUnitTimelineIsReady(battleUnitId) then
		return false
	end

	return true
end

function BattleScene:__OnSetBattleTileActiveWithTimelinePlayHandler(active)
	ForPairs(self.battleTilesView, function(_tileIndex, _tileView)
		_tileView:SetLandLayerActive(active)
	end)
end

function BattleScene:LoadAsset(path, success, fail)
	BattleScene.__LoadObject(self, path, success, fail)
end

function BattleScene.__LoadScene(owner, sceneName, success, fail)
	local path = AssetPath.Get(GlobalKey.ScenePrefabPath, sceneName)

	BattleScene.__LoadObject(owner, path, function(_asset)
		logDebug("加载场景 " .. sceneName .. " 完成")
		success(_asset)
	end, function()
		logError("Battle View 加载场景 " .. sceneName .. " 失败")

		if fail ~= nil then
			fail()
		end
	end)
end

function BattleScene.__LoadObject(owner, path, success, fail)
	AssetUtil.LoadAsset(owner, path, function(_, _assetUrl, _asset, _duration, _userData)
		success(_asset)
	end, function(_assetName, _status, _errorMessage, _userData)
		if fail ~= nil then
			fail()
		end
	end)
end

function BattleScene:__OnBattleUnitSetTurnOrder(battleUnitID)
	LuaUtility.PlaySoundWithID(BattleApi:BattleUnitSetTurnOrderSoundID())
	self.inputController:SetBattleGestureInputEnable(true)
	ForPairs(self.battleUnitsView, function(_battleUnitID, _battleUnitView)
		local isSelectOrder = _battleUnitID == battleUnitID
		local _battleUnitData = BattleModule.GetBattleUnitDataByUnitID(_battleUnitID)

		if _battleUnitData.troopType == BattleModule.attackBattleTroopType then
			_battleUnitView:ShowSelectOrderState(isSelectOrder)
		else
			_battleUnitView:ShowNormalState()
		end
	end)
	self:__RefreshAttackBattleTroopTypeTileShow(battleUnitID)
end

function BattleScene:__OnRefreshBattleTileMoveStateShow(battleUnitID)
	self:__RefreshAttackBattleTroopTypeTileShow(battleUnitID)
end

function BattleScene:__RefreshAttackBattleTroopTypeTileShow(battleUnitID)
	ForPairs(self.battleTilesView, function(_tileIndex, _battleTileView)
		if _battleTileView.troopType ~= BattleModule.attackBattleTroopType then
			_battleTileView:ShowNormalState()

			return
		end

		local enableMove = true
		local isSelect = _battleTileView.fightBattleUnitID == battleUnitID

		_battleTileView:ShowEnableMoveState(enableMove)
		_battleTileView:ShowSelectState(isSelect)
	end)
end

function BattleScene:__OnBattleUnitSelectedSkill(battleUnitID, skillCid)
	return
end

function BattleScene:__OnBattleUnitSelectedTarget(anchorTile, hitTiles)
	LuaUtility.PlaySoundWithID(BattleApi:BattleUnitSelectTargetSoundID())
	ForPairs(self.battleTilesView, function(_tileIndex, _tileView)
		_tileView:ShowNormalState()
	end)
	ForPairs(self.battleUnitsView, function(_battleUnitID, _battleUnitView)
		BattleEffectModule.RemoveRendererFeatureByManual(_battleUnitID, BattleConstant.RendererFeatureID.AttackTarget)
		BattleEffectModule.RemoveRendererFeatureByManual(_battleUnitID, BattleConstant.RendererFeatureID.FriendTarget)
		BattleEffectModule.RemoveRendererFeatureByManual(_battleUnitID, BattleConstant.RendererFeatureID.SelfTarget)
		BattleEffectModule.RemoveRendererFeatureByManual(_battleUnitID, BattleConstant.RendererFeatureID.MoveStealth)
	end)
	ForPairs(hitTiles, function(_index, _tileIndex)
		local isMain = _index == 1

		if _tileIndex < 0 then
			return
		end

		local tileView = self:GetBattleTileView(_tileIndex)

		tileView:ShowSkillTargetState(isMain)

		local isFriendly = tileView.troopType == BattleModule.attackBattleTroopType
		local battleUnitView = self:GetBattleUnitViewByTileKey(_tileIndex)

		if battleUnitView == nil then
			return
		end

		if not isFriendly then
			BattleEffectModule.AddRendererFeatureByManual(battleUnitView.battleUnitID, BattleConstant.RendererFeatureID.AttackTarget)
		else
			BattleEffectModule.AddRendererFeatureByManual(battleUnitView.battleUnitID, BattleConstant.RendererFeatureID.FriendTarget)
		end
	end)
end

function BattleScene:__OnShowBattleSkillTargetTilePreview(anchorTilePos, allHitTilePos, battleUnitID, skillCid)
	ForPairs(self.battleTilesView, function(_, _battleTileView)
		_battleTileView:HideSkillTargetState()
	end)

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)

	ForPairs(allHitTilePos, function(_, _hitTilePos)
		local isMain = anchorTilePos == _hitTilePos
		local tileView = self:GetBattleTileView(_hitTilePos)

		if tileView == nil then
			return
		end

		local isFriendly = tileView.troopType == battleUnitData.troopType

		tileView:ShowSkillTargetState(isFriendly, isMain)
	end)
end

function BattleScene:__OnShowBattleSkillTargetRolePreview()
	local manualOperateMoverID = BattleTeamActionModule.GetManualOperateID()
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(manualOperateMoverID)

	if battleUnitData.troopType == BattleModule.attackBattleTroopType then
		self:__ShowSkillTargetRolePreview(battleUnitData)
	else
		self:__ShowEnemySkillTarget(battleUnitData)
	end

	local anchorTilePos, targetTiles = BattleSkillModule.GetBattleHitTilesBySkillPreviewData(battleUnitData, battleUnitData.previewSkillData)

	self:__OnShowBattleSkillTargetTilePreview(anchorTilePos, targetTiles, manualOperateMoverID, battleUnitData.previewSkillData.skillCid)
end

function BattleScene:__ShowSkillTargetRolePreview(battleUnitData)
	self:__OnHideBattleSkillTargetRolePreview()

	local troopType = battleUnitData:GetPreviewSkillTargetTroop()

	if troopType < 0 then
		return
	end

	local skillTargetPos = battleUnitData.previewSkillData.targetTilePosTable
	local battleSkillData = battleUnitData:GetSkillData(battleUnitData.previewSkillData.skillCid)
	local castBattleUnitView = self:GetBattleUnitViewByID(battleUnitData.battleUnitID)
	local startLinePos = castBattleUnitView:GetLineTargetPos()

	if startLinePos == nil then
		return
	end

	ForPairs(skillTargetPos, function(_tilePos, _)
		local _tileKey = BattleModule.BattleTilePosStoC(troopType, _tilePos)
		local tileView = self:GetBattleTileView(_tileKey)

		if tileView.fightBattleUnitID == 0 then
			return
		end

		if tileView.fightBattleUnitID == battleUnitData.battleUnitID then
			return
		end

		local battleUnitView = self:GetBattleUnitViewByID(tileView.fightBattleUnitID)

		if battleUnitView == nil then
			return
		end

		if battleSkillData.disPlace > 0 then
			local targetBattleUnitData = BattleModule.GetBattleUnitDataByUnitID(tileView.fightBattleUnitID)

			if not targetBattleUnitData:IsInFightStatus(Constant.BattleFightStatus.MOVE_LIMIT) then
				self:__ShowSkillTargetMoveDisEffect(_tileKey, battleSkillData.disPlace)
			end
		end

		local targetLinePos = battleUnitView:GetLineTargetPos()

		if targetLinePos == nil then
			return
		end

		local curve = self:__GetFreeCurve()

		curve.SampPos = BattleApi:GetBattleLineSampPos(battleUnitData.battlePos, startLinePos, _tilePos, targetLinePos)

		curve:DrawLine(startLinePos, targetLinePos)
		curve:SetColor(Color.New(0, 1, 0, 1), 2)
	end)
	ForPairs(self.battleTilesView, function(_tileIndex, _tileView)
		if _tileView.troopType == BattleModule.attackBattleTroopType then
			return
		end

		if _tileView.fightBattleUnitID == 0 then
			return
		end

		local _battleUnitData = BattleModule.GetBattleUnitDataByUnitID(_tileView.fightBattleUnitID)

		if _battleUnitData == nil then
			return
		end

		if _battleUnitData:IsDead() then
			return
		end

		local attackData = _battleUnitData:GetAttackTargetData(battleUnitData.troopType, battleUnitData.battlePos)

		if attackData == nil then
			return
		end

		local battleUnitView = self:GetBattleUnitViewByID(_tileView.fightBattleUnitID)

		if battleUnitView == nil then
			return
		end

		local targetLinePos = battleUnitView:GetLineTargetPos()

		if targetLinePos == nil then
			return
		end

		local curve = self:__GetFreeCurve()

		curve.SampPos = BattleApi:GetBattleLineSampPos(_tileView.battlePos, targetLinePos, battleUnitData.battlePos, startLinePos)

		curve:DrawLine(targetLinePos, startLinePos)
		curve:SetColor(Color.New(1, 0, 0, 1), 2)
	end)
end

function BattleScene:__ShowSkillTargetMoveDisEffect(tileKey, disPlace)
	local tileView = self:GetBattleTileView(tileKey)

	if tileView.fightBattleUnitID == 0 then
		return
	end

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(tileView.fightBattleUnitID)

	if not battleUnitData:CanBeAttackMove() then
		return
	end

	local moveTilePos = BattleSkillModule.ConvertRelativeTilePos(tileKey, disPlace)

	if moveTilePos <= 0 then
		return
	end

	local targetTileView = self:GetBattleTileView(moveTilePos)

	if targetTileView.fightBattleUnitID ~= 0 then
		return
	end

	tileView:ShowMoveDisEffect(moveTilePos)
end

function BattleScene:__ShowEnemySkillTarget(battleUnitData)
	EventDispatcher.Dispatch(EventID.HideRoleSkillSelectView)
	self:__OnHideBattleSkillTargetRolePreview()

	for tileIndex, tileView in pairs(self.battleTilesView) do
		tileView:ShowNormalState()
	end

	local troopType = battleUnitData:GetPreviewSkillTargetTroop()

	if troopType < 0 then
		return
	end

	local skillTargetPos = battleUnitData.previewSkillData.targetTilePosTable
	local castBattleUnitView = self:GetBattleUnitViewByID(battleUnitData.battleUnitID)
	local startLinePos = castBattleUnitView:GetLineTargetPos()

	if startLinePos == nil then
		return
	end

	ForPairs(skillTargetPos, function(_tilePos, _)
		local _tileKey = BattleModule.BattleTilePosStoC(troopType, _tilePos)
		local tileView = self:GetBattleTileView(_tileKey)

		if tileView.fightBattleUnitID == 0 then
			return
		end

		if tileView.fightBattleUnitID == battleUnitData.battleUnitID then
			return
		end

		local battleUnitView = self:GetBattleUnitViewByID(tileView.fightBattleUnitID)

		if battleUnitView == nil then
			return
		end

		local targetLinePos = battleUnitView:GetLineTargetPos()

		if targetLinePos == nil then
			return
		end

		local curve = self:__GetFreeCurve()

		curve.SampPos = BattleApi:GetBattleLineSampPos(battleUnitData.battlePos, startLinePos, _tileKey, targetLinePos)

		curve:DrawLine(startLinePos, targetLinePos)
		curve:SetColor(Color.New(1, 0, 0, 1), 2)
	end)
end

function BattleScene:__GetFreeCurve()
	local curve

	ForPairs(self.targetCurves, function(_, _curve)
		if _curve.IsShow then
			return
		end

		curve = _curve

		return true
	end)

	return curve
end

function BattleScene:__OnBattleUnitPreviewSkillChangeHandler(battleUnitID, skillCid)
	local manualOperateMoverID = BattleTeamActionModule.GetManualOperateID()

	if manualOperateMoverID ~= battleUnitID then
		return
	end

	self:__OnShowBattleSkillTargetRolePreview()
end

function BattleScene:__OnHideBattleSkillTargetRolePreview()
	ForPairs(self.battleUnitsView, function(_battleUnitID, _)
		BattleEffectModule.RemoveRendererFeatureByManual(_battleUnitID, BattleConstant.RendererFeatureID.AttackTarget)
		BattleEffectModule.RemoveRendererFeatureByManual(_battleUnitID, BattleConstant.RendererFeatureID.FriendTarget)
	end)

	for unitID, unitView in pairs(self.battleUnitsView) do
		unitView:ShowNormalState()
	end

	ForPairs(self.battleTilesView, function(_, _tileView)
		_tileView:ShowMoveDisEffect(-1)
	end)
	self:HideAllBattleCurve()
end

function BattleScene:__OnUpdateBattleUnitsDataComplete(_battleUpdatePoint)
	if not BattleTeamActionModule.InState(BattleConstant.BattleTeamActionState.ManualOperate) then
		return
	end

	if _battleUpdatePoint == BattleConstant.BattleUpdatePoint.TurnStart then
		-- block empty
	end
end

function BattleScene:__OnRefreshBattleSkillTargetRolePreview()
	self:__OnShowBattleSkillTargetRolePreview()
end

function BattleScene:__OnShowEnemyBattleSkillAreaWarning(battleUnitID, skillCid, anchorTilePos, allHitTilePos)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)

	ForPairs(allHitTilePos, function(_, _hitTilePos)
		local isMain = anchorTilePos == _hitTilePos
		local tileView = self:GetBattleTileView(_hitTilePos)
		local isFriendly = tileView.troopType == battleUnitData.troopType

		tileView:ShowSkillTargetState(isFriendly, isMain)

		if tileView.fightBattleUnitID == 0 then
			return
		end

		if not isFriendly then
			BattleEffectModule.AddRendererFeatureByManual(tileView.fightBattleUnitID, BattleConstant.RendererFeatureID.AttackTarget)
		else
			BattleEffectModule.AddRendererFeatureByManual(tileView.fightBattleUnitID, BattleConstant.RendererFeatureID.FriendTarget)
		end
	end)
end

function BattleScene:__OnHideEnemyBattleSkillAreaWarning()
	for unitID, unitView in pairs(self.battleUnitsView) do
		unitView:ShowNormalState()
	end

	for tileIndex, tileView in pairs(self.battleTilesView) do
		tileView:ShowNormalState()
	end
end

function BattleScene:__OnBattleUnitOrderComplete()
	self:SwitchVirtualCamera(BattleConstant.BattleVirtualCameras.default)
	self.inputController:SetBattleGestureInputEnable(false)
	self:__OnHideBattleSkillTargetRolePreview()

	for tileIndex, tileView in pairs(self.battleTilesView) do
		tileView:ShowNormalState()
	end
end

return BattleScene
