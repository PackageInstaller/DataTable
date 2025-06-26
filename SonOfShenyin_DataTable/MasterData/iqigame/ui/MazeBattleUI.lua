-- chunkname: @IQIGame\\UI\\MazeBattleUI.lua

local MazeBattleRoom = require("IQIGame/UI/Maze/MazeBattle/MazeBattleRoom")
local MazeBattleHero = require("IQIGame/UI/Maze/MazeBattle/MazeBattleHero")
local MazeBattleNpc = require("IQIGame/UI/Maze/MazeBattle/MazeBattleNpc")
local MazeBattleHeadElement = require("IQIGame/UI/Maze/MazeBattleHeadElement")
local MazeBusinessmanShopElement = require("IQIGame/UI/Maze/MazeBusinessmanShopElement")
local MazeBattleBagElement = require("IQIGame/UI/Maze/MazeBattleBagElement")
local MazeBattleSelectBuffElement = require("IQIGame/UI/Maze/MazeBattleSelectBuffElement")
local MazeBattleTreasureChestElement = require("IQIGame/UI/Maze/MazeBattleTreasureChestElement")
local MazeBattleInteractiveElement = require("IQIGame/UI/Maze/MazeBattleInteractiveElement")
local MazeBattleMapElement = require("IQIGame/UI/Maze/MazeBattleMapElement")
local MazeBattleSamllMapElement = require("IQIGame/UI/Maze/MazeBattleSmallMapElement")
local MazeBattleVideoElement = require("IQIGame/UI/Maze/MazeBattleVideoElement")
local MazeBattleBuffListElement = require("IQIGame/UI/Maze/MazeBattleBuffListElement")
local MazeBattleUseItemElement = require("IQIGame/UI/Maze/MazeBattleUseItemElement")
local MazeBattleHavingBuffsElement = require("IQIGame/UI/Maze/MazeBattleHavingBuffsElement")
local MazeBattleBuffGroupTipsElement = require("IQIGame/UI/Maze/MazeBattleBuffGroupTipsElement")
local MazeBattleUI = {
	curRoomCid = 0,
	isSpecialEvent = false,
	lastRoomCid = 0,
	heroHeadView = {},
	heroEntity = {}
}

MazeBattleUI = Base:Extend("MazeBattleUI", "IQIGame.Onigao.UI.MazeBattleUI", MazeBattleUI)

function MazeBattleUI:OnInit()
	self.heroHeadView = {}

	for i = 0, self.heroHeadViewRoot.transform.childCount - 1 do
		local childTrans = self.heroHeadViewRoot.transform:GetChild(i)
		local headView = MazeBattleHeadElement.New(childTrans)

		table.insert(self.heroHeadView, headView)
	end

	self:__OnInitEventDelegateFunc()

	self.businessmanShop = MazeBusinessmanShopElement.New(self.businessmanShopRoot)
	self.bag = MazeBattleBagElement.New(self.bagPanelRoot)
	self.selectBuffElement = MazeBattleSelectBuffElement.New(self.chooseBuffPanelRoot)
	self.treasureChestElement = MazeBattleTreasureChestElement.New(self.treasureChestRoot)
	self.interactiveElement = MazeBattleInteractiveElement.New(self.interactiveRoot)
	self.mapElement = MazeBattleMapElement.New(self.MapRoot)
	self.videoElement = MazeBattleVideoElement.New(self.VideoRoot)
	self.buffListElement = MazeBattleBuffListElement.New(self.buffListRoot)
	self.useItemElement = MazeBattleUseItemElement.New(self.useItemRoot)
	self.havingBuffElement = MazeBattleHavingBuffsElement.New(self.havingBuffRoot)
	self.smallMapElement = MazeBattleSamllMapElement.New(self.smallMapRoot)
	self.buffGroupElement = MazeBattleBuffGroupTipsElement.New(self.buffGroupTipsRoot)
	self.moneyCell = CurrencyCell.New(self.moneyTopRoot)
	self.uiCanvas = self.UIController:GetComponent("Canvas")
end

function MazeBattleUI:GetPreloadAssetPaths()
	return nil
end

function MazeBattleUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeBattleUI:IsManualShowOnOpen(userData)
	return false
end

function MazeBattleUI:GetBGM(userData)
	local bgmId = MazeModule.GetMazeStageCfg(MazeModule.GetLabyrinthData().curDifficulty).BGM

	if bgmId ~= 0 then
		return bgmId
	end

	return nil
end

function MazeBattleUI:OnOpen(userData)
	MazeEventModule.Initialize()
	MazeBattleStepModule.Initialize()

	self.curRoomCid = 0
	self.lastRoomCid = 0
	self.lastMoodIndex = nil
	self.lastMoodValue = nil

	self:RefreshSurplusTime()

	if userData.lastFightingHero ~= nil then
		self:__OnCreateFightingHero(userData.lastFightingHero)

		self.__fightingHero = userData.fightingHero
	else
		self.__fightingHero = nil

		self:__OnCreateFightingHero(userData.fightingHero)
	end

	self.smallMapElement:Show()
	self.businessmanShop:Hide()
	self.bag:Hide()
	self.selectBuffElement:Hide()
	self.treasureChestElement:Hide()
	self.interactiveElement:Hide()
	self.mapElement:Hide()
	self.videoElement:Hide()
	self.buffListElement:Hide()
	self.useItemElement:Hide()
	self.havingBuffElement:Hide()
	self.buffGroupElement:Hide()
	self.moneyCell:RefreshItem(Constant.TopMoneyType.MazeBattleUI)
end

function MazeBattleUI:OnClose(userData)
	MazeBattleStepModule.Shutdown()
	MazeEventModule.Shutdown()
end

function MazeBattleUI:__OnInitEventDelegateFunc()
	function self.__delegateOnStartEnterMazeRoom(_roomCid)
		self:__OnStartEnterMazeRoom(_roomCid)
	end

	function self.__delegateOnEnterMazeRoomFinish(_roomCid)
		self:__OnEnterMazeRoomFinish(_roomCid)
	end

	function self.__delegateOnMoveTopBtnClick()
		self:__OnMoveTopBtnClick()
	end

	function self.__delegateOnMoveLeftBtnClick()
		self:__OnMoveLeftBtnClick()
	end

	function self.__delegateOnMoveBottomBtnClick()
		self:__OnMoveBottomBtnClick()
	end

	function self.__delegateOnMoveRightBtnClick()
		self:__OnMoveRightBtnClick()
	end

	function self.__delegateOnOpenMazeBusinessmanShop(_stageEventPOD)
		self:__OnOpenMazeBusinessmanShop(_stageEventPOD)
	end

	function self.__delegateOnMazeStageMapPODChange(_roomCid)
		self:__OnMazeStageMapPODChange(_roomCid)
	end

	function self.__delegateOnExitButtonClick()
		self:__OnExitButtonClick()
	end

	function self.__delegateOnBagButtonClick()
		self:__OnBagButtonClick()
	end

	function self.__delegateOnMoodBtnClick()
		self:__OnMoodBtnClick()
	end

	function self.__delegateOnIllustratedButtonClick()
		self:__OnIllustratedButtonClick()
	end

	function self.__delegateOnMouldBuffBtnClick()
		self:__OnMouldBuffBtnClick()
	end

	function self.__delegateOnMazeStagePODChange(_difficulty)
		self:__OnMazeStagePODChange(_difficulty)
	end

	function self.__delegateOnMazeFormationChange()
		self:__OnMazeFormationChange()
	end

	function self.__delegateOnMazeSelectBuffComplete()
		self:__OnMazeSelectBuffComplete()
	end

	function self.__delegateOnMazeStageWarehouseChange()
		self:__RefreshPowerShow()
	end

	function self.__delegateOnOpenMazeChooseTreasureChestUI(_stageEventPOD, _treasureCid)
		self:__OnOpenMazeChooseTreasureChestUI(_stageEventPOD, _treasureCid)
	end

	function self.__delegateOnOpenMazeInteractiveUI(_stageEventPOD, _mutualEventCid, _startIndex)
		self:__OnOpenMazeInteractiveUI(_stageEventPOD, _mutualEventCid, _startIndex)
	end

	function self.__delegateOnMazeUpdateLabyrinthHerosAndFormationEvent()
		self:__OnMazeUpdateLabyrinthHerosAndFormationEvent()
	end

	function self.__delegateOnOpenMazeBuffListUI()
		self:__OnOpenMazeBuffListUI()
	end

	function self.__delegateOnOpenMazeUseItemUI(itemCid)
		self:__OnOpenMazeUseItemUI(itemCid)
	end

	function self.__delegateOnOpenMazeMapUI()
		self:__OnOpenMazeMapUI()
	end

	function self.__delegateOnOpenMazeVideoUI(storySrc, callback)
		self:__OnOpenMazeVideoUI(storySrc, callback)
	end

	function self.__delegateOnDisableMazeMoveBtn()
		self:__OnDisableMazeMoveBtn()
	end

	function self.__delegateOnUpdateFormationEvent()
		self:__OnUpdateFormationEvent()
	end

	function self.__delegateOnHpChangeEvent(changeType)
		self:__OnHpChangeEvent(changeType)
	end

	function self.__delegateOnSelectBuffEvent(stageEventPOD, stageMapPod)
		self:__OnSelectBuffEvent(stageEventPOD, stageMapPod)
	end

	function self.__delegateOnHoldEventResult(stageEventPOD)
		self:__OnHoldEventResult(stageEventPOD)
	end

	function self.__delegateOnSubmitEventResult()
		self:__OnSubmitEventResult()
	end

	function self.__delegateOnEnterManualTriggerEventNode()
		self:__OnEnterManualTriggerEventNode()
	end

	function self.delegateOnOpenBuffGroupTips(buffId)
		self:__OnOpenBuffGroupTips(buffId)
	end
end

function MazeBattleUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.StartEnterMazeRoom, self.__delegateOnStartEnterMazeRoom)
	EventDispatcher.AddEventListener(EventID.EnterMazeRoomFinish, self.__delegateOnEnterMazeRoomFinish)
	self.moveTopBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnMoveTopBtnClick)
	self.moveLeftBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnMoveLeftBtnClick)
	self.moveBottomBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnMoveBottomBtnClick)
	self.moveRightBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnMoveRightBtnClick)
	self.exitButton:GetComponent("Button").onClick:AddListener(self.__delegateOnExitButtonClick)
	self.bagBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnBagButtonClick)
	self.illustratedBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnIllustratedButtonClick)
	self.moodBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnMoodBtnClick)
	self.mouldBuff:GetComponent("Button").onClick:AddListener(self.__delegateOnMouldBuffBtnClick)
	EventDispatcher.AddEventListener(EventID.OpenMazeBusinessmanShop, self.__delegateOnOpenMazeBusinessmanShop)
	EventDispatcher.AddEventListener(EventID.MazeStageMapPODChange, self.__delegateOnMazeStageMapPODChange)
	EventDispatcher.AddEventListener(EventID.MazeStagePODChange, self.__delegateOnMazeStagePODChange)
	EventDispatcher.AddEventListener(EventID.MazeFormationChange, self.__delegateOnMazeFormationChange)
	EventDispatcher.AddEventListener(EventID.MazeSelectBuffComplete, self.__delegateOnMazeSelectBuffComplete)
	EventDispatcher.AddEventListener(EventID.MazeStageWarehouseChange, self.__delegateOnMazeStageWarehouseChange)
	EventDispatcher.AddEventListener(EventID.OpenMazeChooseTreasureChestUI, self.__delegateOnOpenMazeChooseTreasureChestUI)
	EventDispatcher.AddEventListener(EventID.OpenMazeInteractiveUI, self.__delegateOnOpenMazeInteractiveUI)
	EventDispatcher.AddEventListener(EventID.MazeUpdateLabyrinthHerosAndFormationEvent, self.__delegateOnMazeUpdateLabyrinthHerosAndFormationEvent)
	EventDispatcher.AddEventListener(EventID.OpenMazeBuffListUI, self.__delegateOnOpenMazeBuffListUI)
	EventDispatcher.AddEventListener(EventID.OpenMazeUseItemUI, self.__delegateOnOpenMazeUseItemUI)
	EventDispatcher.AddEventListener(EventID.OpenMazeMapUI, self.__delegateOnOpenMazeMapUI)
	EventDispatcher.AddEventListener(EventID.OpenMazeVideoUI, self.__delegateOnOpenMazeVideoUI)
	EventDispatcher.AddEventListener(EventID.DisableMazeMoveBtn, self.__delegateOnDisableMazeMoveBtn)
	EventDispatcher.AddEventListener(EventID.GoIntoBattleSuccessEvent, self.__delegateOnUpdateFormationEvent)
	EventDispatcher.AddEventListener(EventID.MazeHpChangeEvent, self.__delegateOnHpChangeEvent)
	EventDispatcher.AddEventListener(EventID.MazeSelectBuff, self.__delegateOnSelectBuffEvent)
	EventDispatcher.AddEventListener(EventID.OnHoldEventResult, self.__delegateOnHoldEventResult)
	EventDispatcher.AddEventListener(EventID.OnSubmitEventResult, self.__delegateOnSubmitEventResult)
	EventDispatcher.AddEventListener(EventID.OnEnterManualTriggerEventNode, self.__delegateOnEnterManualTriggerEventNode)
	EventDispatcher.AddEventListener(EventID.OpenBuffGroupTips, self.delegateOnOpenBuffGroupTips)
end

function MazeBattleUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.StartEnterMazeRoom, self.__delegateOnStartEnterMazeRoom)
	EventDispatcher.RemoveEventListener(EventID.EnterMazeRoomFinish, self.__delegateOnEnterMazeRoomFinish)
	self.moveTopBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnMoveTopBtnClick)
	self.moveLeftBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnMoveLeftBtnClick)
	self.moveBottomBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnMoveBottomBtnClick)
	self.moveRightBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnMoveRightBtnClick)
	self.exitButton:GetComponent("Button").onClick:RemoveListener(self.__delegateOnExitButtonClick)
	self.bagBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnBagButtonClick)
	self.illustratedBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnIllustratedButtonClick)
	self.moodBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnMoodBtnClick)
	self.mouldBuff:GetComponent("Button").onClick:RemoveListener(self.__delegateOnMouldBuffBtnClick)
	EventDispatcher.RemoveEventListener(EventID.OpenMazeBusinessmanShop, self.__delegateOnOpenMazeBusinessmanShop)
	EventDispatcher.RemoveEventListener(EventID.MazeStageMapPODChange, self.__delegateOnMazeStageMapPODChange)
	EventDispatcher.RemoveEventListener(EventID.MazeStagePODChange, self.__delegateOnMazeStagePODChange)
	EventDispatcher.RemoveEventListener(EventID.MazeFormationChange, self.__delegateOnMazeFormationChange)
	EventDispatcher.RemoveEventListener(EventID.MazeSelectBuffComplete, self.__delegateOnMazeSelectBuffComplete)
	EventDispatcher.RemoveEventListener(EventID.MazeStageWarehouseChange, self.__delegateOnMazeStageWarehouseChange)
	EventDispatcher.RemoveEventListener(EventID.OpenMazeChooseTreasureChestUI, self.__delegateOnOpenMazeChooseTreasureChestUI)
	EventDispatcher.RemoveEventListener(EventID.OpenMazeInteractiveUI, self.__delegateOnOpenMazeInteractiveUI)
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateLabyrinthHerosAndFormationEvent, self.__delegateOnMazeUpdateLabyrinthHerosAndFormationEvent)
	EventDispatcher.RemoveEventListener(EventID.OpenMazeBuffListUI, self.__delegateOnOpenMazeBuffListUI)
	EventDispatcher.RemoveEventListener(EventID.OpenMazeUseItemUI, self.__delegateOnOpenMazeUseItemUI)
	EventDispatcher.RemoveEventListener(EventID.OpenMazeMapUI, self.__delegateOnOpenMazeMapUI)
	EventDispatcher.RemoveEventListener(EventID.OpenMazeVideoUI, self.__delegateOnOpenMazeVideoUI)
	EventDispatcher.RemoveEventListener(EventID.DisableMazeMoveBtn, self.__delegateOnDisableMazeMoveBtn)
	EventDispatcher.RemoveEventListener(EventID.GoIntoBattleSuccessEvent, self.__delegateOnUpdateFormationEvent)
	EventDispatcher.RemoveEventListener(EventID.MazeHpChangeEvent, self.__delegateOnHpChangeEvent)
	EventDispatcher.RemoveEventListener(EventID.MazeSelectBuff, self.__delegateOnSelectBuffEvent)
	EventDispatcher.RemoveEventListener(EventID.OnHoldEventResult, self.__delegateOnHoldEventResult)
	EventDispatcher.RemoveEventListener(EventID.OnSubmitEventResult, self.__delegateOnSubmitEventResult)
	EventDispatcher.RemoveEventListener(EventID.OnEnterManualTriggerEventNode, self.__delegateOnEnterManualTriggerEventNode)
	EventDispatcher.RemoveEventListener(EventID.OpenBuffGroupTips, self.delegateOnOpenBuffGroupTips)
end

function MazeBattleUI:OnPause()
	return
end

function MazeBattleUI:OnResume()
	return
end

function MazeBattleUI:OnCover()
	return
end

function MazeBattleUI:OnReveal()
	return
end

function MazeBattleUI:OnRefocus(userData)
	return
end

function MazeBattleUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeBattleUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeBattleUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeBattleUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeBattleUI:OnDestroy()
	self.businessmanShop:Dispose()

	self.businessmanShop = nil

	self.bag:Dispose()

	self.bag = nil

	self.treasureChestElement:Dispose()

	self.treasureChestElement = nil

	self.interactiveElement:Dispose()

	self.interactiveElement = nil

	self.selectBuffElement:Dispose()

	self.selectBuffElement = nil

	self.mapElement:Dispose()

	self.mapElement = nil

	self.videoElement:Dispose()

	self.videoElement = nil

	self.buffListElement:Dispose()

	self.buffListElement = nil

	self.useItemElement:Dispose()

	self.useItemElement = nil

	self.havingBuffElement:Dispose()

	self.havingBuffElement = nil

	self.smallMapElement:Dispose()

	self.smallMapElement = nil

	self.buffGroupElement:Dispose()

	self.buffGroupElement = nil

	self.moneyCell:Dispose()

	self.moneyCell = nil

	ForArray(self.heroHeadView, function(_index, _headView)
		_headView:Dispose()
	end)
	ForPairs(self.heroEntity, function(k, _entity)
		_entity:Dispose()
	end)
	self.playerEntity:Dispose()

	self.playerEntity = nil

	self:__OnReleaseRoom()
	self:StopTimer()

	self.uiCanvas = nil

	self:StopMoodChangeEffect()
	self:StopMoodEffect()
	self:__StopLoadEntityCoroutine()
	AssetUtil.UnloadAsset(self)
end

function MazeBattleUI:__OnMouldBuffBtnClick()
	if self.mouldBuffItemCid == nil or self.mouldBuffItemCid == 0 then
		return
	end

	ItemModule.OpenTipByCid(self.mouldBuffItemCid, true, true)
end

function MazeBattleUI:__OnMoodBtnClick()
	if not MazeModule.GetMazeCanInteractive() then
		return
	end

	NoticeModule.ShowNotice(80008)
end

function MazeBattleUI:__OnBagButtonClick()
	if not MazeModule.GetMazeCanInteractive() then
		return
	end

	self.bag:Show()
end

function MazeBattleUI:__OnIllustratedButtonClick()
	if not MazeModule.GetMazeCanInteractive() then
		return
	end

	self.havingBuffElement:Show()
end

function MazeBattleUI:__OnOpenMazeBuffListUI()
	self.buffListElement:Show()
end

function MazeBattleUI:__OnOpenMazeUseItemUI(itemCid)
	self.useItemElement:Show()
	self.useItemElement:SetData(itemCid)
end

function MazeBattleUI:__OnOpenMazeMapUI()
	if not MazeModule.GetMazeCanInteractive() then
		return
	end

	self.mapElement:Show()
	self.mapElement:SetData()
end

function MazeBattleUI:__OnOpenMazeVideoUI(storySrc, callback)
	self.videoElement:Show()
	self.videoElement:SetData(storySrc, callback)
end

function MazeBattleUI:__OnOpenBuffGroupTips(buffId)
	self.buffGroupElement:Show()
	self.buffGroupElement:SetData(buffId)
end

function MazeBattleUI:__OnDisableMazeMoveBtn()
	self:__HideAllRoomMoveBtn()
end

function MazeBattleUI:__OnExitButtonClick()
	if not MazeModule.GetMazeCanInteractive() then
		return
	end

	NoticeModule.ShowNotice(80002, function()
		MazeModule.OnExitStage(nil, Constant.MazeStageExploreState.HerosDeath)
	end)
end

function MazeBattleUI:__OnMazeSelectBuffComplete()
	self.selectBuffElement:Hide()
end

function MazeBattleUI:__OnMazeStagePODChange(difficulty)
	local stagePOD = MazeModule.GetCurStagePOD()

	if stagePOD == nil then
		return
	end

	if difficulty ~= stagePOD.difficulty then
		return
	end
end

function MazeBattleUI:__OnMazeFormationChange()
	self:__OnCreateFightingHero(MazeModule.GetMazeFightingHeroData(), true)
end

function MazeBattleUI:__OnCreateFightingHero(heroDic, isChange)
	self:__OnClearFightingHero()

	local playerEntityIsLoad = false
	local isUnitFlip

	if isChange then
		isUnitFlip = self.room.isFlip
	end

	MazeModule.log("开始创建代理人")

	self.playerEntity = MazeBattleNpc.New(MazeApi:GetPlayerEntityID(PlayerModule.PlayerInfo.baseInfo.sex), nil, nil, nil, self.heroRoot.transform:GetChild(0), nil, function(entity)
		if isChange then
			self.playerEntity:SetFlip(isUnitFlip)
		end

		self.playerEntity:SetClickBtnState(false)
		self.playerEntity:PlayIdleAnim()

		playerEntityIsLoad = true

		MazeModule.log("创建代理人成功")
	end)

	local tempHeroDic = MazeModule.CreateHeroCidData(heroDic)
	local attackOrder = MazeModule.GetFormationAttackOrder()
	local tempAttackOrderData = MazeModule.CreateHeroCidData(attackOrder)
	local index = 1

	if table.len(tempAttackOrderData) == 0 then
		tempAttackOrderData = tempHeroDic
	end

	ForPairs(tempAttackOrderData, function(_battlePos, _heroCid)
		self.heroEntity[_battlePos] = MazeBattleHero.New(_heroCid, self.heroRoot.transform:GetChild(_battlePos), function(entity)
			if isChange then
				entity:SetFlip(isUnitFlip)
			end

			entity:PlayIdleAnim()
		end)

		local _headView = self.heroHeadView[_battlePos]

		_headView:Show(_heroCid)

		index = index + 1
	end)
	ForArrayByCount(index, #self.heroHeadView, 1, function(_index)
		self.heroHeadView[_index]:Hide()
	end)

	self.waitCor = coroutine.start(function()
		while playerEntityIsLoad == false or not self:__GetNpcIsAllLoad(tempAttackOrderData) do
			coroutine.wait(0.02)
		end

		MazeModule.UpdatePlayerEntity(self.playerEntity)
		MazeModule.UpdateHeroEntitys(self.heroEntity)

		local labyrinthStagePOD = MazeModule.GetCurStagePOD()

		MazeModule.OnStartEnterRoom(labyrinthStagePOD.curRoomId, false)
		self:__StopLoadEntityCoroutine()
	end)
end

function MazeBattleUI:__GetNpcIsAllLoad(tempAttackOrderData)
	if table.len(tempAttackOrderData) ~= table.len(self.heroEntity) then
		return false
	end

	local checkResult = true

	ForPairs(self.heroEntity, function(_pos, _entity)
		if _entity.showComplete == false then
			checkResult = false

			return true
		end
	end)

	return checkResult
end

function MazeBattleUI:__StopLoadEntityCoroutine()
	if self.waitCor then
		coroutine.stop(self.waitCor)

		self.waitCor = nil
	end
end

function MazeBattleUI:__OnClearFightingHero()
	ForArray(self.heroHeadView, function(_index, _headView)
		_headView:Hide()
	end)
	ForPairs(self.heroEntity, function(k, _entity)
		_entity:Dispose()
	end)

	self.heroEntity = {}

	if self.playerEntity then
		self.playerEntity:Dispose()

		self.playerEntity = nil
	end
end

function MazeBattleUI:__InitFightHeroBronPos()
	self.bornTrans = self.room:GetBornTransByRoomCid(self.lastRoomCid)
	self.heroRoot.transform.position = self.bornTrans.position
end

function MazeBattleUI:__CreateNpc()
	local stageMapPOD = MazeModule.GetRoomStageMapData(self.curRoomCid)

	MazeModule.log("当前事件链{0}", stageMapPOD.eventLinkPod.eventLinkId)
	self.room:CreateNpc(stageMapPOD.eventLinkPod, self.npcRoot.transform)
end

function MazeBattleUI:__OnMazeUpdateLabyrinthHerosAndFormationEvent()
	ForArray(self.heroHeadView, function(_index, _headView)
		if _headView.heroCid ~= 0 then
			_headView:UpdateHeroInfo()
		end
	end)
end

function MazeBattleUI:SortFightHeroStandby(isUnitFlip)
	local gridLayout = self.heroRoot:GetComponent("GridLayoutGroup")

	gridLayout.startCorner = isUnitFlip == true and UnityEngine.UI.GridLayoutGroup.Corner.UpperLeft or UnityEngine.UI.GridLayoutGroup.Corner.UpperRight
end

function MazeBattleUI:__ShowRoomMoveButton(roomIds)
	for dir, roomId in pairs(roomIds) do
		if roomId ~= nil and roomId ~= 0 then
			LuaUtility.SetGameObjectShow(self:__GetDirBtn(dir), true)
		end
	end
end

function MazeBattleUI:__GetCanComebackRoomIds(allRoomIds, lastRoomId)
	local roomIds = {}
	local dir = table.indexOf(allRoomIds, lastRoomId)

	if dir ~= -1 then
		roomIds[dir] = lastRoomId
	end

	return roomIds
end

function MazeBattleUI:__HideAllRoomMoveBtn()
	for key, dir in pairs(Constant.MazeMoveDir) do
		LuaUtility.SetGameObjectShow(self:__GetDirBtn(dir), false)
	end
end

function MazeBattleUI:__GetDirBtn(dir)
	if dir == Constant.MazeMoveDir.Top then
		return self.moveTopBtn
	elseif dir == Constant.MazeMoveDir.Left then
		return self.moveLeftBtn
	elseif dir == Constant.MazeMoveDir.Bottom then
		return self.moveBottomBtn
	elseif dir == Constant.MazeMoveDir.Right then
		return self.moveRightBtn
	end
end

function MazeBattleUI:__OnMoveTopBtnClick()
	self:__OnMove(Constant.MazeMoveDir.Top)
end

function MazeBattleUI:__OnMoveLeftBtnClick()
	self:__OnMove(Constant.MazeMoveDir.Left)
end

function MazeBattleUI:__OnMoveBottomBtnClick()
	self:__OnMove(Constant.MazeMoveDir.Bottom)
end

function MazeBattleUI:__OnMoveRightBtnClick()
	self:__OnMove(Constant.MazeMoveDir.Right)
end

function MazeBattleUI:__OnMove(dir)
	local stageMapPOD = MazeModule.GetRoomStageMapData(self.curRoomCid)
	local roomCid = stageMapPOD.roomids[dir]

	if roomCid == nil then
		return
	end

	self:__HideAllRoomMoveBtn()

	MazeModule.previousLastRoomCid = self.curRoomCid
	MazeModule.isClickChangeRoom = true

	MazeModule.OnStartEnterRoom(roomCid, false)
end

function MazeBattleUI:__GetLastRoomId()
	return PlayerPrefsUtil.GetInt(PlayerModule.PlayerInfo.baseInfo.guid, Constant.PlayerPrefsConst.MazeLastRoomCid .. MazeModule.GetMazeStageCfg(MazeModule.GetCurStagePOD().difficulty).Id, 0)
end

function MazeBattleUI:__SaveLastRoomId(roomId)
	PlayerPrefsUtil.SetInt(PlayerModule.PlayerInfo.baseInfo.guid, Constant.PlayerPrefsConst.MazeLastRoomCid .. MazeModule.GetMazeStageCfg(MazeModule.GetCurStagePOD().difficulty).Id, roomId)
	PlayerPrefsUtil.Save()
end

function MazeBattleUI:__OnCreateRoom(roomCid)
	self:__OnReleaseRoom()

	local stageMapPOD = MazeModule.GetRoomStageMapData(roomCid)

	self.room = MazeBattleRoom.New(stageMapPOD, self.uiCanvas, function()
		self:__OnMazeRoomViewPrepareComplete()
	end)

	self.room:SetRoomId(roomCid, self.lastRoomCid)
end

function MazeBattleUI:__OnReleaseRoom()
	if self.room == nil then
		return
	end

	self.room:Dispose()
end

function MazeBattleUI:__ShowRoomTransferEffect()
	self.transferEffectRoot.gameObject:SetActive(true)
end

function MazeBattleUI:__HideRoomTransferEffect()
	self.transferEffectRoot.gameObject:SetActive(false)
end

function MazeBattleUI:__OnStartEnterMazeRoom(roomCid)
	self.ChangeRoomSound = LuaUtility.PlaySoundWithID(MazeApi:GetChangeRoomSoundId())

	MazeModule.log("StartEnterMazeRoom---------->>{0}", roomCid)
	self:__ShowRoomTransferEffect()

	if MazeModule.previousLastRoomCid ~= 0 then
		self.lastRoomCid = MazeModule.previousLastRoomCid
	else
		self.lastRoomCid = self:__GetLastRoomId()
	end

	if self.lastRoomCid == 0 then
		self.lastRoomCid = roomCid
	end

	self.curRoomCid = roomCid
	self.isSpecialEvent = false

	self:__OnSepcialEvent()
	self:__OnCreateRoom(self.curRoomCid)
end

function MazeBattleUI:__OnMazeRoomViewPrepareComplete()
	self.room:MountRoom(self.roomSceneRoot.transform)
	MazeBattleStepModule.InitMountPoint(self.room, self.UIController:GetComponent("Canvas").sortingOrder)
	self:RefreshTaskProgress()
	self:__HideHpChangeEffect()
	self:__RefreshPowerShow()
	self:__InitFightHeroBronPos()
	self:__CreateNpc()
	self:__HideAllRoomMoveBtn()
	self:__HideRoomTransferEffect()
	self:__PlayEnterMazeAnimation()
	EventDispatcher.Dispatch(EventID.StartEnterMazeRoomComplete)
end

function MazeBattleUI:__StopRunSound(soundSerialId)
	if soundSerialId == nil then
		return
	end

	if soundSerialId == 0 then
		return
	end

	LuaUtility.StopSoundWithSerialId(soundSerialId)
end

function MazeBattleUI:__PlayEnterMazeAnimation()
	local labyrinthPOD = MazeModule.GetLabyrinthData()
	local isUnitFlip = self.room:NeedToFlip(self.lastRoomCid, self.curRoomCid)

	self.room.isFlip = isUnitFlip

	self.playerEntity:SetFlip(isUnitFlip)
	ForPairs(self.heroEntity, function(k, _entity)
		_entity:SetFlip(isUnitFlip)
	end)
	self:SortFightHeroStandby(isUnitFlip)

	local stageMapPOD = MazeModule.GetRoomStageMapData(self.curRoomCid)

	if MazeModule.isClickChangeRoom == false and MazeModule.GetEventAlreadyStarted(stageMapPOD.eventLinkPod) then
		self.heroRoot.transform.position = self.room:GetLeftOrRightDefaultTrans(isUnitFlip).position

		MazeModule.OnEnterCurrentRoomFinish()

		return
	end

	MazeModule.isClickChangeRoom = false

	local walkSoundSerialId = LuaUtility.PlaySoundWithID(MazeApi:GetWalkSoundId())

	ForPairs(self.heroEntity, function(k, _entity)
		_entity:PlayMoveAnim()
	end)
	self.playerEntity:PlayMoveAnim()

	local trans = self.room:GetLeftOrRightDefaultTrans(isUnitFlip)
	local tween = TweenPosition.Begin(self.heroRoot, 1.5, trans.localPosition)

	tween:SetOnFinished(function()
		self:__StopRunSound(walkSoundSerialId)
		ForPairs(self.heroEntity, function(k, _entity)
			_entity:PlayIdleAnim()
		end)
		self.playerEntity:PlayIdleAnim()

		self.heroRoot.transform.localPosition = Vector3.New(self.heroRoot.transform.localPosition.x, self.heroRoot.transform.localPosition.y, 0)

		UnityEngine.Object.Destroy(tween)

		if labyrinthPOD.animation == false then
			MazeBattleStepModule.FirstEnterMaze(labyrinthPOD.seasonId, function()
				MazeModule.OnEnterCurrentRoomFinish()
			end)
		else
			MazeModule.OnEnterCurrentRoomFinish()
		end
	end)
end

function MazeBattleUI:__OnEnterMazeRoomFinish(roomCid)
	if roomCid ~= self.curRoomCid then
		logError("返回进入房间完成的ID和当前房间ID不一致 当前ID：{0} ----> 返回ID：{1}", self.curRoomCid, roomCid)

		return
	end

	self:__OnMazeRoomEventPrepareComplete()
end

function MazeBattleUI:__OnMazeRoomEventPrepareComplete()
	self:RefreshTaskProgress()

	local function actionCall()
		MazeModule.UpdateHeroEntitys(self.heroEntity)

		self.__fightingHero = nil

		self:__OnMazeRoomEnterAnimationComplete()
	end

	if self.__fightingHero ~= nil then
		self:__PlayFightingHeroDieAnim(actionCall)

		return
	end

	actionCall()
end

function MazeBattleUI:__OnMazeRoomEnterAnimationComplete()
	if self.isSpecialEvent == true then
		self.isSpecialEvent = false

		return
	end

	self:__OnRequestEvent()
end

function MazeBattleUI:__OnMazeStageMapPODChange(roomCid)
	if self.room == nil then
		return
	end
end

function MazeBattleUI:__OnHoldEventResult(stageEventPOD)
	self:RefreshTaskProgress()
	self:__OnStartEvnet(stageEventPOD)
end

function MazeBattleUI:__OnSubmitEventResult()
	self:__OnRequestEvent()
end

function MazeBattleUI:__OnStartEvnet(stageEventPOD)
	MazeEventModule.ExecuteEvent(stageEventPOD)
end

function MazeBattleUI:__OnSepcialEvent()
	local stageMapPOD = MazeModule.GetRoomStageMapData(self.curRoomCid)
	local stageEventPOD = stageMapPOD.eventLinkPod.stageEvents[stageMapPOD.eventLinkPod.curEventId]

	if table.len(stageMapPOD.eventLinkPod.stageEvents) == 1 and MazeModule.GetEventIsSpecial(stageEventPOD) then
		self.isSpecialEvent = true

		self:__OnStartEvnet(stageEventPOD)
	end
end

function MazeBattleUI:__OnRequestEvent()
	MazeModule.isEventInProgress = true

	EventDispatcher.Dispatch(EventID.MazeSetNpcClickStateEvent, false)

	if self:__OnCheckMazeSettlement() then
		return
	end

	if self:__OnCheckEventLinkEnd() then
		return
	end

	self:__HideAllRoomMoveBtn()
	MazeModule.OnHoldEvent()
end

function MazeBattleUI:__OnEnterManualTriggerEventNode()
	EventDispatcher.Dispatch(EventID.MazeSetNpcClickStateEvent, true)

	local stageMapPOD = MazeModule.GetRoomStageMapData(self.curRoomCid)
	local eventLinkTable = CfgLabyrinthEventLinkTable[stageMapPOD.eventLinkPod.eventLinkId]

	if eventLinkTable.IsCanComeback then
		local roomIds = self:__GetCanComebackRoomIds(stageMapPOD.roomids, self.lastRoomCid)

		self:__ShowRoomMoveButton(roomIds)
	end

	if eventLinkTable.ControlType == false then
		self:__ShowRoomMoveButton(stageMapPOD.roomids)
	end

	MazeModule.isEventInProgress = false
end

function MazeBattleUI:__OnCheckEventLinkEnd()
	local stageMapPOD = MazeModule.GetRoomStageMapData(self.curRoomCid)

	MazeModule.MazeEventLinkIsEnd = stageMapPOD.eventLinkPod.eventLinkState

	if stageMapPOD.eventLinkPod.eventLinkState then
		self:RefreshTaskProgress()
		EventDispatcher.Dispatch(EventID.OnStageEventLinkEnd, stageMapPOD.eventLinkPod)

		local eventLinkTable = CfgLabyrinthEventLinkTable[stageMapPOD.eventLinkPod.eventLinkId]

		if eventLinkTable.EventReturn == true then
			MazeModule.log("传送门需返回上次进入的房间")

			MazeModule.previousLastRoomCid = self.curRoomCid
			MazeModule.isClickChangeRoom = true

			MazeModule.OnStartEnterRoom(stageMapPOD.eventLinkPod.lastRoomId, false)

			return true
		end

		self:__ShowRoomMoveButton(stageMapPOD.roomids)

		MazeModule.isEventInProgress = false

		if MazeModule.GetIsShopEvent(stageMapPOD.eventLinkPod) or MazeModule.GetIsVideoEvent(stageMapPOD.eventLinkPod) then
			EventDispatcher.Dispatch(EventID.MazeSetNpcClickStateEvent, true)
		end

		self:__SaveLastRoomId(stageMapPOD.roomId)

		return true
	end

	return false
end

function MazeBattleUI:__OnCheckMazeSettlement()
	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	if labyrinthStagePOD.exploreFlg == 3 and MazeModule.IsShowFinishNotice == false then
		if MazeModule.isNeedPlayMazeEndAnim then
			MazeModule.isNeedPlayMazeEndAnim = false

			MazeBattleStepModule.MazeOver(function()
				MazeModule.ShowExploreCompleteNotice()

				local stageMapPOD = MazeModule.GetRoomStageMapData(self.curRoomCid)

				self:__ShowRoomMoveButton(stageMapPOD.roomids)

				MazeModule.isEventInProgress = false
			end)
		else
			MazeModule.ShowExploreCompleteNotice(function()
				self:__OnRequestEvent()
			end)
		end

		return true
	end

	if labyrinthStagePOD.exploreFlg ~= 0 and labyrinthStagePOD.exploreFlg ~= 3 then
		MazeModule.ShowExploreCompleteNotice()

		return true
	end

	return false
end

function MazeBattleUI:__HideHpChangeEffect()
	LuaUtility.SetGameObjectShow(self.addHPParent, false)
	LuaUtility.SetGameObjectShow(self.reduceHPParent, false)
end

function MazeBattleUI:__OnUpdateFormationEvent()
	return
end

function MazeBattleUI:__OnHpChangeEvent(changeType)
	self:__HideHpChangeEffect()

	local effectGO

	if changeType == Constant.MazeHpChangeState.Add then
		effectGO = self.addHPParent
	elseif changeType == Constant.MazeHpChangeState.Reduce then
		effectGO = self.reduceHPParent
	end

	LuaUtility.SetGameObjectShow(effectGO, true)
	MazeModule.GetTimeController():AddSecondDelayCall(3, function()
		LuaUtility.SetGameObjectShow(effectGO, false)
	end, nil, 1)
end

function MazeBattleUI:__PlayFightingHeroDieAnim(callback)
	local heroDic = MazeModule.CreateHeroCidData(self.__fightingHero)
	local attackOrder = MazeModule.GetFormationAttackOrder()
	local tempAttackOrderData = MazeModule.CreateHeroCidData(attackOrder)
	local firstIsDie = false

	if table.len(heroDic) == 0 or self.heroEntity[1].heroCid ~= tempAttackOrderData[1] and table.indexOf(tempAttackOrderData, self.heroEntity[1].heroCid) == -1 then
		self.heroEntity[1]:PlayDieAnim()

		firstIsDie = true
	end

	if not firstIsDie then
		self:__PlayFightingHeroJoinAnim(firstIsDie, self.__fightingHero, tempAttackOrderData, callback)
	else
		MazeModule.GetTimeController():AddSecondDelayCall(3, function()
			self:__PlayFightingHeroJoinAnim(firstIsDie, self.__fightingHero, tempAttackOrderData, callback)
		end, nil, 1)
	end
end

function MazeBattleUI:__PlayFightingHeroJoinAnim(firstIsDie, srcHeroData, attackOrderHeroData, callback)
	local heroDic = MazeModule.CreateHeroCidData(srcHeroData)

	if heroDic[1] ~= nil then
		if firstIsDie then
			self.heroEntity[1]:Dispose()

			self.heroEntity[1] = nil
			self.heroEntity[1] = MazeBattleHero.New(attackOrderHeroData[1], self.heroRoot.transform:GetChild(1), function(_heroEntity)
				_heroEntity:PlayBornAnim()
			end)
		elseif self.heroEntity[1].heroCid ~= attackOrderHeroData[1] then
			self.heroEntity[1]:Dispose()

			self.heroEntity[1] = nil
			self.heroEntity[1] = MazeBattleHero.New(attackOrderHeroData[1], self.heroRoot.transform:GetChild(1), function(_heroEntity)
				_heroEntity:PlayBornAnim()
			end)
		end
	elseif self.heroEntity[1] then
		self.heroEntity[1]:Dispose()

		self.heroEntity[1] = nil
	end

	ForArray(self.heroHeadView, function(pos, _headView)
		if attackOrderHeroData[pos] ~= nil then
			_headView:Show(attackOrderHeroData[pos])
		else
			_headView:Hide()
		end
	end)

	local function condition()
		local _needWait = false

		ForPairs(self.heroEntity, function(pos, _hero)
			_needWait = not _hero.showComplete

			return _needWait
		end)

		return not _needWait
	end

	MazeModule.UpdateHeroEntitys(self.heroEntity)
	MazeModule.GetTimeController():AddSecondConditionCall(condition, nil, callback, nil, 1)
end

function MazeBattleUI:__OnOpenMazeBusinessmanShop()
	self.businessmanShop:Show(self.curRoomCid)
end

function MazeBattleUI:__OnOpenMazeChooseTreasureChestUI(stageEventPOD, treasureCid)
	self.treasureChestElement:Show(stageEventPOD, treasureCid)
end

function MazeBattleUI:__OnSelectBuffEvent(stageEventPOD, stageMapPod)
	self.selectBuffElement:Show()
	self.selectBuffElement:SetData(stageEventPOD, stageMapPod)
end

function MazeBattleUI:__OnOpenMazeInteractiveUI(stageEventPOD, mutualEventCid, startIndex)
	self.interactiveElement:Show(stageEventPOD, mutualEventCid, startIndex)
end

function MazeBattleUI:__RefreshPowerShow()
	local mindData = MazeModule.GetMazeStageMindData()
	local curMindValue = MazeModule.GetMazeStageInternalBagItemNum(mindData.itemCid)

	UGUIUtil.SetText(self.powerValueText, curMindValue)

	local index = math.max(MazeModule.GetSectionBuffIndex(), 1)

	if self.lastMoodIndex ~= index then
		AssetUtil.LoadImage(self, MazeApi:GetMoodStageImage(index), self.moodImage:GetComponent("Image"))
		self:StopMoodEffect()

		self.moodEffectSerialId = GameEntry.Effect:PlayUIMountPointEffect(MazeApi:GetMoodEffect(math.max(index, 1)), 50000, 0, self.moodMountPoint, 0)
	end

	self.lastMoodIndex = index

	if self.lastMoodValue ~= curMindValue and self.lastMoodValue ~= nil then
		self:StopMoodChangeEffect()

		self.moodChangeEffectSerialId = GameEntry.Effect:PlayUIMountPointEffect(MazeApi:GetMoodChangeEffect(curMindValue > self.lastMoodValue), 50000, 0, self.moodChangeMountPoint, 0)
	end

	self.lastMoodValue = curMindValue

	self:__RefreshMouldBuff()
end

function MazeBattleUI:StopMoodEffect()
	if self.moodEffectSerialId then
		GameEntry.Effect:StopEffect(self.moodEffectSerialId)

		self.moodEffectSerialId = nil
	end
end

function MazeBattleUI:StopMoodChangeEffect()
	if self.moodChangeEffectSerialId then
		GameEntry.Effect:StopEffect(self.moodChangeEffectSerialId)

		self.moodChangeEffectSerialId = nil
	end
end

function MazeBattleUI:RefreshSurplusTime()
	local curStagePod = MazeModule.GetCurStagePOD()

	if curStagePod == nil then
		return
	end

	self.endTime = math.floor(tonumber(curStagePod.endTime) / 1000)

	self:UpdateSurplusTime()
	self:StopTimer()

	if self.timer == nil then
		self.timer = Timer.New(function()
			self:UpdateSurplusTime()
		end, 1, -1)

		self.timer:Start()
	end
end

function MazeBattleUI:UpdateSurplusTime()
	local surplusTime = math.floor(self.endTime - tonumber(PlayerModule.GetServerTime()))

	surplusTime = math.max(0, surplusTime)

	UGUIUtil.SetText(self.stageTimeText, DateStandardFormation(surplusTime))
end

function MazeBattleUI:StopTimer()
	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end
end

function MazeBattleUI:__RefreshMouldBuff()
	local buffCid = MazeModule.GetSectionBuff()

	if buffCid == nil then
		LuaUtility.SetGameObjectShow(self.mouldBuff, false)

		return
	end

	LuaUtility.SetGameObjectShow(self.mouldBuff, true)

	local itemCfg = MazeModule.GetBuffItemCfg(buffCid)

	self.mouldBuffItemCid = itemCfg.Id

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(itemCfg.Icon), self.mouldBuffImage:GetComponent("Image"))
end

function MazeBattleUI:RefreshTaskProgress()
	local poolId = MazeModule.GetCurStagePOD().poolId
	local poolCfg = CfgLabyrinthBarrierPoolTable[poolId]
	local conditionId = poolCfg.FinishCondition[1]
	local conditionCfg = CfgConditionTable[conditionId]
	local curProgress = 0
	local needProgress = 0
	local isFinish = false
	local taskName = ""

	if conditionCfg.Type[1] == 1 and conditionCfg.SubType[1] == 35 then
		local finishType = conditionCfg.Params[1][1]

		if finishType == Constant.MazeSettlementType.AfterRoom then
			taskName = conditionCfg.Name
		elseif finishType == Constant.MazeSettlementType.ArriveExit then
			taskName = conditionCfg.Name
		elseif finishType == Constant.MazeSettlementType.KillMonster then
			taskName = MazeApi:GetkillMonsterSettlementTitle(conditionCfg.Value[1])
		elseif finishType == Constant.MazeSettlementType.GetItem then
			taskName = MazeApi:GetGetItemSettlementTitle(CfgItemTable[conditionCfg.Value[1]].Name)
		end
	end

	needProgress, curProgress, isFinish = MazeModule.GetMeetTheCondition(conditionId)

	LuaUtility.SetGameObjectShow(self.noFinishIcon, not isFinish)
	LuaUtility.SetGameObjectShow(self.finishIcon, isFinish)
	LuaUtility.SetGameObjectShow(self.finishTag, isFinish)
	UGUIUtil.SetText(self.textTaskProgress, taskName .. " " .. curProgress .. "/" .. needProgress)
end

return MazeBattleUI
