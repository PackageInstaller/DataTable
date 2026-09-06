-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerMainView.lua

module("logic.extensions.summontower.view.SummontowerMainView", package.seeall)

local SummontowerMainView = class("SummontowerMainView", ViewComponent)
local gridEvtShowNodeName = {
	[SummonGridEvtType.Guard] = "guard",
	[SummonGridEvtType.Coin] = "coin",
	[SummonGridEvtType.Box] = "box",
	[SummonGridEvtType.Shop] = "shop",
	[SummonGridEvtType.Door] = "door"
}

function SummontowerMainView:buildUI()
	SummontowerMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnSweep = self:getBtn("btnSweep")
	self._tipNode = self:getGo("tip")
	self._txtTip = self:getTxt("tip/txtTip")
	self._txtRound = self:getTxt("round/txtRound")
	self._btnNumbers = self:getBtn("btnNumbers")

	self:_initDragonBall()
	self:_initSummonMasterInfo()
	self:_initMap()

	self._nodeRole = self:getGo("map/role")
	self._player = SummontowerPlayer.New(self._nodeRole)

	self._player:setScale(0.18)

	self._nextBoss = self:getGo("bossTip")
	self._goldBarCoinNum = self:getTxt("goldBarCon/coin/TxtC_Num")
	self._goldBarCoinIcon = self:getGo("goldBarCon/coin/ImgC_Icon")
	self._goldBarStoneNum = self:getTxt("goldBarCon/stone/TxtC_Num")
	self._goldBarStoneIcon = self:getGo("goldBarCon/stone/ImgC_Icon")
end

function SummontowerMainView:_initMap()
	local canvas = self:getGo("Canvas")

	GameUtil.expandRectTransform(canvas.transform)

	self._gridsList = {}
	self._gridsMap = {}

	local mapNode = self:getGo("map")
	local mapBgNode = self:getGo("Canvas/map")

	for i = 1, 30 do
		local gridData = {}
		local bgNode = goutil.findChild(mapBgNode, "map_" .. i)

		gridData.go = goutil.findChild(mapNode, "map_" .. i)
		gridData.passable = goutil.findChild(bgNode, "pass")
		gridData.clickNode = Framework.UIClickTrigger.Get(goutil.findChild(bgNode, "bg"))
		self._gridsList[i] = gridData

		local row, col = self:_getRowAndCol(i)

		self._gridsMap[row] = self._gridsMap[row] or {}
		self._gridsMap[row][col] = gridData
	end

	self._gridShowNode = self:getGo("map/show")

	self._gridShowNode:SetActive(false)

	self._roleParent = self:getGo("map/role")
end

function SummontowerMainView:_getRowAndCol(idx)
	return SummontowerMapModel.instance:getRowAndCol(idx)
end

function SummontowerMainView:_initDragonBall()
	self._btnDragonBall = self:getBtn("btnDragonBall")
	self._dragonBalls = {}

	local i = 1

	while true do
		local go = self:getGo("btnDragonBall/dragonball/ball_" .. i .. "/lock")

		if not go then
			break
		end

		i = i + 1

		table.insert(self._dragonBalls, go)
	end
end

function SummontowerMainView:_initSummonMasterInfo()
	self._infoNode = self:getGo("info")
	self._summonMasterIcon = self:getGo("info/pet/con")
	self._txtName = self:getTxt("info/txtName")
	self._txtLevel = self:getTxt("info/txtLevel")
	self._expBar = Framework.SliderAdapter.Get(self:getGo("info/exp"))
	self._btnProtagonistHalo = self:getBtn("info/btnProtagonistHalo")
end

function SummontowerMainView:bindEvents()
	SummontowerMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTips, self)
	self._btnSweep:AddClickListener(self._onClickSweep, self)
	self._btnDragonBall:AddClickListener(self._onClickDragonBall, self)
	self._btnProtagonistHalo:AddClickListener(self._onClickProtagonistHalo, self)

	for i = 1, #self._gridsList do
		self._gridsList[i].clickNode:AddClickListener(function()
			self:_onClickGrid(i)
		end)
	end

	self._btnNumbers:AddClickListener(self._onClickMembers, self)
end

function SummontowerMainView:unbindEvents()
	SummontowerMainView.super.unbindEvents(self)

	for i = 1, #self._gridsList do
		self._gridsList[i].clickNode:RemoveClickListener()
	end

	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnSweep:RemoveClickListener()
	self._btnDragonBall:RemoveClickListener()
	self._btnProtagonistHalo:RemoveClickListener()
	self._btnNumbers:RemoveClickListener()
end

function SummontowerMainView:onEnter()
	SummontowerMainView.super.onEnter(self)
	SummontowerController.instance:requestGameInfo()
	self:_initGoldBarIcons()
	self._player:onEnter()
	self._player:loadSpine(SummontowerModel.instance:getPlayerSpineRes())
	self._player:addListener(self._onPlayerMoveToGrid, self)
	self:_refreshView()
	self:_resetPlayerPos()
	self:_playGameScreenEff()
	self:_updateDragonBalls()
	GlobalDispatcher:addListener(GlobalNotify.OnSommonSweep, self._onSommonSweep, self)
	GlobalDispatcher:addListener(GlobalNotify.OnSommonTowerGameInfo, self._onSommonTowerGameInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.OnSommonTowerDoGrid, self._onSommonTowerDoGrid, self)
end

function SummontowerMainView:_initGoldBarIcons()
	local itemCoinCo = SummontowerConfig.instance:getGameItemCo(SummonTowerItemsModel.ItemType.Coin)
	local itemStoneCo = SummontowerConfig.instance:getGameItemCo(SummonTowerItemsModel.ItemType.ReviveStone)

	MaterialMgr.setIcon(self._goldBarCoinIcon, MatType.Item_Fake, itemCoinCo.itemId)
	MaterialMgr.setIcon(self._goldBarStoneIcon, MatType.Item_Fake, itemStoneCo.itemId)
end

function SummontowerMainView:_updateGoldBarNum()
	self._goldBarCoinNum.text = tostring(SummonTowerItemsModel.instance:getItemsNum(SummonTowerItemsModel.ItemType.Coin))
	self._goldBarStoneNum.text = tostring(SummonTowerItemsModel.instance:getItemsNum(SummonTowerItemsModel.ItemType.ReviveStone))
end

function SummontowerMainView:_playGameScreenEff()
	if not self._screenEff then
		self._screenEff = UIEffectManager.instance:playEffectBrief(self, "20211028/zhaohuanmiyu/fx_ui_zhaohuanmiyu_zhumianban.prefab", self.mainGO, true)

		self._screenEff:setParent(self.mainGO.transform)
		self._screenEff:setScale(1)
		self._screenEff:setLocalPos(0, 0, 0)
	end
end

function SummontowerMainView:_stopGameScreenEff()
	if self._screenEff then
		UIEffectManager.instance:stopEffect(self._screenEff)

		self._screenEff = nil
	end
end

function SummontowerMainView:_playPlayerAppearEff()
	self:_stopPlayerAppearEff()

	if not self._playerAppearEff then
		local px, py, pz = Framework.TransformUtil.GetPos(self._nodeRole.transform, nil, nil, nil)

		self._playerAppearEff = UIEffectManager.instance:playEffectBrief(self, "20211028/zhaohuanmiyu/fx_ui_zhaohuanmiyu_chusheng.prefab", self.mainGO, false, function()
			self._playerAppearEff:setPos(px, py, pz)
		end)

		self._playerAppearEff:setParent(self.mainGO.transform)
		self._playerAppearEff:setScale(1)
		self._playerAppearEff:setPos(px, py, pz)
	end
end

function SummontowerMainView:_stopPlayerAppearEff()
	if self._playerAppearEff then
		UIEffectManager.instance:stopEffect(self._playerAppearEff)

		self._playerAppearEff = nil
	end
end

function SummontowerMainView:onExit()
	self._currDoorGridId = 0

	self:_stopPlayerAppearEff()
	self._player:onExit()

	self._isTransingNextLevel = nil

	self:_stopGameScreenEff()

	if self._nextLevelEff then
		self._nextLevelEff:clear()

		self._nextLevelEff = nil
	end

	uGuiUtil.clearImage(self._summonMasterIcon)
	MaterialMgr.clearIcon(self._goldBarCoinIcon)
	MaterialMgr.clearIcon(self._goldBarStoneIcon)
	self:_clearMap()

	if self._dragonBallAnims then
		for k, v in pairs(self._dragonBallAnims) do
			v:clear()
		end

		self._dragonBallAnims = nil
	end

	SummontowerMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnSommonSweep, self._onSommonSweep, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnSommonTowerGameInfo, self._onSommonTowerGameInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnSommonTowerDoGrid, self._onSommonTowerDoGrid, self)
end

function SummontowerMainView:_refreshView()
	self._btnSweep.gameObject:SetActive(false)
	self._nextBoss:SetActive(SummontowerModel.instance:isNextBossLevel())
	self:_updateGoldBarNum()
	self:_updateTips()
	self:_updateSummonMasterInfo()
	self:_updateMap()
	self:_handleCurMustHandleGrid()

	self._txtRound.text = string.format(lang("tip_missionnum"), SummontowerModel.instance:getCurLevelId())
end

function SummontowerMainView:_updateTips()
	local levelId = SummontowerModel.instance:getCurLevelId()
	local stageCo = SummontowerConfig.instance:getStageCo(levelId)
	local tips

	if stageCo then
		tips = stageCo.stageTips
	end

	local sTips = tostring(tips)

	if not tips or tips == 0 or tips == "0" or string.nilorempty(sTips) then
		self._tipNode:SetActive(false)

		return
	end

	self._tipNode:SetActive(true)

	self._txtTip.text = tips
end

function SummontowerMainView:_updateDragonBalls()
	if not SummontowerModel.instance:isGameInfoReady() then
		self._btnDragonBall.gameObject:SetActive(false)

		return
	end

	self._btnDragonBall.gameObject:SetActive(true)

	local ballsNum = SummonTowerItemsModel.instance:getDragonBallsNum()

	for i = 1, ballsNum do
		if self._dragonBalls[i] then
			self._dragonBalls[i]:SetActive(false)
		end
	end

	for i = ballsNum + 1, #self._dragonBalls do
		if self._dragonBalls[i] then
			self._dragonBalls[i]:SetActive(true)
		end
	end
end

function SummontowerMainView:_updateSummonMasterInfo()
	if not SummontowerModel.instance:isGameInfoReady() then
		self._infoNode:SetActive(false)

		return
	end

	self._infoNode:SetActive(true)

	local masterId = SummontowerPetsModel.instance:getSummonMasterCreepId()
	local petData = SummontowerConfig.instance:getPetCo(masterId)
	local level = petData.lv
	local curFaceId = checknumber(petData.faceId)

	if curFaceId == 0 then
		curFaceId = petData.raceId
	end

	self._txtName.text = petData.creepsName
	self._txtLevel.text = "Lv:" .. tostring(level)

	local modelCo = CharacterConfig.instance:getModelCo(curFaceId)

	uGuiUtil.setSpriteToImage(self._summonMasterIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))

	local playerLv, currLvExp, lvUpExp = SummontowerModel.instance:getPlayerLevel()

	self._expBar:SetValue(currLvExp / lvUpExp)
end

function SummontowerMainView:_updateMap()
	self:_resetMap()

	local gridsData = SummontowerMapModel.instance:getMapGridsData()

	if not gridsData then
		return
	end

	for i = 1, #gridsData do
		local nodeData = gridsData[i]

		self:_createOneMapNode(nodeData)
	end
end

function SummontowerMainView:_createOneMapNode(nodeData)
	local gridNode = self._gridsList[nodeData.gridId]

	gridNode.gridData = nodeData

	if not nodeData:canShowNode() then
		return
	end

	if nodeData:isGuardBoss() then
		local evtCo = SummontowerConfig.instance:getGuardEventCo(nodeData.gridEventId)

		gridNode.roleLoader = RoleObjectPool.instance:addRoleToParent(gridNode.roleLoader, evtCo.faceId, gridNode.go, evtCo.scale, nil, false, 0, 0)
	else
		local resPath = nodeData:getResPath()

		if not string.nilorempty(resPath) then
			local showNode = self:_getOneShowNode()

			gridNode.showNode = showNode

			showNode.go:SetActive(true)
			showNode.go.transform:SetParent(gridNode.go.transform)
			Framework.TransformUtil.SetLocalPos(showNode.go.transform, 0, 0, 0)
			Framework.TransformUtil.SetLocalScale(showNode.go.transform, 1, 1, 1)

			for k, v in pairs(gridEvtShowNodeName) do
				if showNode[k] then
					showNode[k].go:SetActive(k == nodeData.gridEventType)
				end
			end

			uGuiUtil.setSpriteToImage(showNode[nodeData.gridEventType].image, uGuiUtil.SpriteType.BigBg, resPath)
		end

		if nodeData.gridEventType == SummonGridEvtType.Door then
			gridNode.doorEffect = UIEffectManager.instance:playEffectBrief(self, "20211028/zhaohuanmiyu/fx_ui_zhaohuanmiyu_chuangsongmen.prefab", gridNode.go, true)

			gridNode.doorEffect:setParent(gridNode.go.transform)
			gridNode.doorEffect:setPos(0, 0, 0)
			gridNode.doorEffect:setScale(1)
		end
	end
end

function SummontowerMainView:_resetPlayerPos()
	local posRow, posCol = SummontowerMapModel.instance:getPlayerPos()

	if posRow == 0 and posCol == 0 then
		local gridsData = SummontowerMapModel.instance:getMapGridsData()

		if gridsData then
			for i = 1, #gridsData do
				if gridsData[i].gridEventType == SummonGridEvtType.BirthPoint then
					posRow, posCol = self:_getRowAndCol(gridsData[i].gridId)

					break
				end
			end
		end
	end

	if posRow == 0 and posCol == 0 then
		posRow = 1
		posCol = 1
	end

	local node = self._gridsMap[posRow][posCol]

	self._player:movetoGrid(posRow, posCol, node.go, false)
	self._player:setDirection(posCol > 3)
	self:_playPlayerAppearEff()
	self:_updateMapStatus()
end

function SummontowerMainView:_onPlayerMoveToGrid(row, col)
	SummontowerMapModel.instance:setPlayerPos(row, col)
	self:_updateMapStatus()
end

function SummontowerMainView:_updateMapStatus()
	local row, col = self._player:getGridPos()

	for k, v in pairs(self._gridsMap) do
		for k1, v1 in pairs(v) do
			v1.passable:SetActive(math.abs(row - k) + math.abs(col - k1) <= 1)
		end
	end
end

function SummontowerMainView:_resetMap()
	for i = 1, #self._gridsList do
		self._gridsList[i].passable:SetActive(false)

		if self._gridsList[i].showNode then
			self:_recycleShowNode(self._gridsList[i].showNode)

			self._gridsList[i].showNode = nil
		end

		if self._gridsList[i].roleLoader then
			RoleObjectPool.instance:removeRole(self._gridsList[i].roleLoader)

			self._gridsList[i].roleLoader = nil
		end

		if self._gridsList[i].doorEffect then
			UIEffectManager.instance:stopEffect(self._gridsList[i].doorEffect)

			self._gridsList[i].doorEffect = nil
		end

		self._gridsList[i].gridData = nil
	end
end

function SummontowerMainView:_clearMap()
	for i = 1, #self._gridsList do
		local showNode = self._gridsList[i].showNode

		if showNode then
			for k, v in pairs(gridEvtShowNodeName) do
				if showNode[k] and showNode[k].image then
					uGuiUtil.clearImage(showNode[k].image)
				end
			end

			goutil.destroy(showNode.go)

			self._gridsList[i].showNode = nil
		end

		if self._gridsList[i].roleLoader then
			RoleObjectPool.instance:removeRole(self._gridsList[i].roleLoader)

			self._gridsList[i].roleLoader = nil
		end

		if self._gridsList[i].doorEffect then
			UIEffectManager.instance:stopEffect(self._gridsList[i].doorEffect)

			self._gridsList[i].doorEffect = nil
		end

		self._gridsList[i].gridData = nil
	end

	if self._showNodePool then
		for i = 1, #self._showNodePool do
			goutil.destroy(self._showNodePool[i].go)
		end

		self._showNodePool = nil
	end
end

function SummontowerMainView:_recycleShowNode(node)
	self._showNodePool = self._showNodePool or {}

	node.go:SetActive(false)

	for k, v in pairs(gridEvtShowNodeName) do
		if node[k] then
			node[k].go:SetActive(false)
		end
	end

	table.insert(self._showNodePool, node)
end

function SummontowerMainView:_handleCurMustHandleGrid()
	if SceneMgr.instance.isGogingToEnterBattleScene then
		return
	end

	local gridDataRecord = SummontowerMapModel.instance:getGridRecordData()

	if gridDataRecord then
		if gridDataRecord.isReliveSummonMaster then
			gridDataRecord.isReliveSummonMaster = false

			TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("txt_summontower_summonmasterrevivetips"), function()
				SummontowerController.instance:checkCurMustHandleGrid()
			end, BootstrapLanguage.sure)

			return
		end

		if gridDataRecord.delPets and #gridDataRecord.delPets > 0 and SummonTowerItemsModel.instance:getItemsNum(SummonTowerItemsModel.ItemType.ReviveStone) == 0 then
			ViewMgr.instance:open(ViewName.SummontowDeadPetsView, gridDataRecord.delPets, self._handleCurMustHandleGrid, self)

			gridDataRecord.delPets = nil

			return
		end

		if SummontowerMapModel.instance:getResultScores() >= 0 then
			ViewMgr.instance:open(ViewName.SummontowerResultView)

			return
		end
	end

	if SummontowerController.instance:checkCurMustHandleGrid() then
		return
	end

	self:_checkBoss()
end

function SummontowerMainView:_checkBoss()
	local gridsData = SummontowerMapModel.instance:getMapGridsData()

	if gridsData then
		for i = 1, #gridsData do
			if gridsData[i]:needWarningBoss() then
				for j = 1, #gridsData do
					if gridsData[j]:needWarningBoss() then
						gridsData[j].isWarningBoss = true
					end
				end

				ViewMgr.instance:open(ViewName.SummontowerBossTriggerView)

				return
			end
		end
	end
end

function SummontowerMainView:_getOneShowNode()
	local nodeData

	if self._showNodePool then
		nodeData = self._showNodePool[1]

		if self._showNodePool[1] then
			table.remove(self._showNodePool, 1)
		end
	end

	if not nodeData then
		nodeData = {
			go = goutil.clone(self._gridShowNode)
		}

		for k, v in pairs(gridEvtShowNodeName) do
			nodeData[k] = {}
			nodeData[k].go = goutil.findChild(nodeData.go, v)
			nodeData[k].image = goutil.findChild(nodeData[k].go, "img")
		end
	end

	return nodeData
end

function SummontowerMainView:_onClickGrid(i)
	if self._isTransingNextLevel then
		return
	end

	if SummontowerController.instance:checkCurMustHandleGrid() then
		return
	end

	local posRow, posCol = self:_getRowAndCol(i)
	local curRow, curCol = self._player:getGridPos()

	if math.abs(curRow - posRow) + math.abs(curCol - posCol) ~= 1 then
		return
	end

	local node = self._gridsList[i]

	self._currDoorGridId = SummontowerMapModel.instance:getDoorGridId()

	local gridData = node.gridData

	if gridData and SummontowerController.instance:executeGridEvent(gridData.gridId) then
		return
	end

	self._player:movetoGrid(posRow, posCol, node.go, true)
end

function SummontowerMainView:_onClickClose()
	self:close()
end

function SummontowerMainView:_onClickTips()
	TipsFacade.instance:openRulesView("zhaohuanmicheng")
end

function SummontowerMainView:_onClickDragonBall()
	ViewMgr.instance:open(ViewName.SummontowerWishView)
end

function SummontowerMainView:_onClickProtagonistHalo()
	ViewMgr.instance:open(ViewName.SummontowerProtagonistHaloView)
end

function SummontowerMainView:_onClickMembers()
	ViewMgr.instance:open(ViewName.SummontowerMembersView)
end

function SummontowerMainView:_onClickSweep()
	TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("text_summontower_sweeptips"), 1, SummontowerModel.instance:getSweepScores()), function()
		SummontowerController.instance:requestSweep()
	end, function()
		return
	end, lang("confirm"), lang("mail_cancel"))
end

function SummontowerMainView:_onSommonSweep()
	self._btnSweep.gameObject:SetActive(SummontowerModel.instance:canSpeep())
end

function SummontowerMainView:_onSommonTowerGameInfo()
	self:_refreshView()
	self:_updateDragonBalls()
	self:_resetPlayerPos()
end

function SummontowerMainView:_onSommonTowerDoGrid(opGridId, changeMos, getPets)
	if SummontowerMapModel.instance:getResultScores() >= 0 then
		ViewMgr.instance:open(ViewName.SummontowerResultView)

		return
	end

	local posRow, posCol = self:_getRowAndCol(opGridId)

	self._isTransingNextLevel = false

	if opGridId == self._currDoorGridId then
		self:_startTransNextLevel(opGridId)

		return
	end

	self:_refreshView()

	local node = self._gridsMap[posRow][posCol]

	if node.gridData and node.gridData.isFinished and node.gridData.gridEventType ~= SummonGridEvtType.Shop and node.gridData.gridEventType ~= SummonGridEvtType.Door then
		SummontowerMapModel.instance:setPlayerPos(posRow, posCol)
		self._player:movetoGrid(posRow, posCol, node.go, true)
	end

	self:_updateMapStatus()

	if changeMos then
		local items, dragonBalls = self:_handleGetItemsData(changeMos)

		if items then
			MaterialController.instance:showChangeSetItemMo(items)
		end

		self:_handleGetDragonBalls(opGridId, dragonBalls)
	end
end

function SummontowerMainView:_startTransNextLevel(opGridId)
	self._isTransingNextLevel = true

	local gridNode = self._gridsList[opGridId]

	self._nextLevelEff = SummontowerNextLevelEff.New(self, self._nodeRole, gridNode.go)

	self._nextLevelEff:startTween(self._onTransNextLevelFinish, self)
end

function SummontowerMainView:_onTransNextLevelFinish(opGridId)
	self._isTransingNextLevel = false

	if self._nextLevelEff then
		self._nextLevelEff:clear()
	end

	self._nextLevelEff = nil

	self._player:setScale(0.18)
	self:_refreshView()
	self:_resetPlayerPos()
end

function SummontowerMainView:_handleGetDragonBalls(opGridId, dragonBalls)
	if not dragonBalls then
		self:_updateDragonBalls()

		return
	end

	local ballsNum = SummonTowerItemsModel.instance:getDragonBallsNum()
	local gridNode = self._gridsList[opGridId]

	for i = 1, #dragonBalls do
		local animMo = SummontowerGetDragonBall.New(self, self._dragonBalls[ballsNum], gridNode.go)

		ballsNum = ballsNum - 1
		self._dragonBallAnims = self._dragonBallAnims or {}
		self._dragonBallAnims[animMo] = animMo

		animMo:startTween(self._onDragBallTweenFinish, self)
	end
end

function SummontowerMainView:_onDragBallTweenFinish(animMo)
	self._dragonBallAnims[animMo] = nil

	animMo:clear()
end

function SummontowerMainView:_handleGetItemsData(changeMos)
	if changeMos then
		local items, dragonBalls

		for i = 1, #changeMos do
			if changeMos[i].itemType == SummonTowerItemsModel.ItemType.DragonBall then
				dragonBalls = dragonBalls or {}

				table.insert(dragonBalls, changeMos[i].itemMo)
			else
				items = items or {}

				table.insert(items, changeMos[i].itemMo)
			end
		end

		return items, dragonBalls
	end
end

return SummontowerMainView
