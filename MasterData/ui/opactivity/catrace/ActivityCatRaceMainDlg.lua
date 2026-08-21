-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\CatRace\\ActivityCatRaceMainDlg.lua

local UserData = require("Helper/UserData")
local UIUtils = require("Framework.UI.UIUtils")
local CatRaceConfig = require("UI/OpActivity/CatRace/CatRaceConfig")
local CircularScenePanel = require("UI/OpActivity/CatRace/CircularScenePanel")
local ActivityCatRaceAwardPointCell = require("UI/OpActivity/CatRace/ActivityCatRaceAwardPointCell")
local ActivityCatRaceCatComp = require("UI/OpActivity/CatRace/ActivityCatRaceCatComp")
local ActivityDataCatRace = require("Avatar/AvatarMixins/OpActivity/ActivityDataCatRace")
local ResOpActivityCatRaceMisc = require("ClientData/ResOpActivityCatRaceMisc")
local ResClientNotice = require("ClientData/ResClientNotice")
local AnimatorType = typeof(UnityEngine.Animator)
local mainDlgName = "activityCatRaceMainDlg"
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ActivityCatRaceMainDlg = Class(mainDlgName, UIControls.Window)

MixinClass(ActivityCatRaceMainDlg, ActivityPanelMixin)

function ActivityCatRaceMainDlg:ctor()
	self.subDlgNames = {
		"activityCatRaceMileAwardDlg",
		"activityCatRaceTaskDlg",
		"activityCatRaceFriendDlg",
		"activityCatRaceUseItemDlg"
	}
end

function ActivityCatRaceMainDlg:initUI()
	self.actData = self.actObj.actData
	self.miscData = self.actData.miscData
	self.closeBtn = UIControls.Button(self, "BtnClose")

	self.closeBtn:addEventClick(self._onBtnClose)

	self.farShotScene = CircularScenePanel(self, "ScenePanel/EnvironmentPanel/LongShotScene")
	self.nearShotScene = CircularScenePanel(self, "ScenePanel/EnvironmentPanel/ShortShotScene")
	self.allyeScene = CircularScenePanel(self, "ScenePanel/EnvironmentPanel/AlleyScene")
	self.catLive2D = UIControls.LazyLivePlayer(self, "ScenePanel/CatPanel/CatMine/CatLive2DPanel")
	self.playerNameTxt = UIControls.Label(self, "ScenePanel/CatPanel/CatMine/BgTextName/Text")
	self.setCatBtn = UIControls.Button(self, "ScenePanel/CatPanel/CatMine/FuncPanel/BtnSet")

	self.setCatBtn:addEventClick(self._onBtnSetCat)

	self.catFuncAni = UIControls.UIAni(self, "ScenePanel/CatPanel/CatMine/FuncPanel")
	self.catEmptyClickpanel = UIControls.Panel(self, "ScenePanel/CatPanel/CatMine/CatLive2DPanel/EmptyClick")
	self.catTouchBtn = UIControls.Button(self, "ScenePanel/CatPanel/CatMine/CatLive2DPanel")

	self.catTouchBtn:addEventClick(self._onBtnCatTouch)

	self.catCloseBtn = UIControls.Button(self, "ScenePanel/CatPanel/CatMine/BtnClose")

	self.catCloseBtn:addEventClick(self._onBtnCatClose)
	self.catCloseBtn:setVisible(false)

	self.compCat = ActivityCatRaceCatComp(self, "ScenePanel/CatPanel/CatComp")
	self.randomCat = ActivityCatRaceCatComp(self, "ScenePanel/CatPanel/CatRandom")

	self:refreshCompCat(false)

	self.bgCatAnim = UIControls.UIAni(self, "ScenePanel/CatPanel")
	self.taskBtn = UIControls.Button(self, "BtnFuncPanel/BtnTask")

	self.taskBtn:addEventClick(self._onBtnTask)

	self.taskIconNewImg = UIControls.Image(self, "BtnFuncPanel/BtnTask/IconNew")
	self.friendBtn = UIControls.Button(self, "BtnFuncPanel/BtnFriend")

	self.friendBtn:addEventClick(self._onBtnFriend)

	self.friendIconNewImg = UIControls.Image(self, "BtnFuncPanel/BtnFriend/IconNew")
	self.rankBtn = UIControls.Button(self, "BtnFuncPanel/BtnRank")

	self.rankBtn:addEventClick(self._onBtnRank)

	self.storeBtn = UIControls.Button(self, "BtnFuncPanel/BtnStore")

	self.storeBtn:addEventClick(self._onBtnStore)

	self.jumpTipAnim = UIControls.UIAni(self, "BgJumpWordPanel")
	self.jumpTipTxt = UIControls.Label(self, "BgJumpWordPanel/BgJumpWord/TextJumpWord")

	local itemPathPrefix = "MileAxisPanel/MileItemUsePanel/BtnMileItem"

	self.itemList = {}
	self.itemNumList = {}
	self.itemNewImgs = {}

	local itemPath, item, itemNumPath, itemNumTxt

	for i = 1, CatRaceConfig.ITEM_MAX_NUM do
		itemPath = itemPathPrefix .. tostring(i)
		itemNumPath = itemPath .. "/TextNum"
		item = UIControls.Button(self, itemPath)
		itemNumTxt = UIControls.Label(self, itemNumPath)

		item:addEventClick(self._onBtnUseItem)
		table.insert(self.itemList, item)
		table.insert(self.itemNumList, itemNumTxt)

		local newImg = UIControls.Panel(self, itemPath .. "/IconNew")

		table.insert(self.itemNewImgs, newImg)
	end

	self.baseLive2D = UIControls.LazyLivePlayer(self, "ScenePanel/CatPanel/CatMine/GrassLive2DPanel")
	self.itemLive2DList = {}

	local itemLive2DPath, itemLive2D

	for i = 1, CatRaceConfig.ITEM_LIVE2D_MAX_NUM do
		itemLive2DPath = "ScenePanel/CatPanel/CatMine/ItemLive2DPanel" .. i
		itemLive2D = UIControls.LazyLivePlayer(self, itemLive2DPath)

		table.insert(self.itemLive2DList, itemLive2D)
	end

	self:hideItemLive2D()

	local path

	for i = 1, CatRaceConfig.ITEM_LIVE2D_MAX_NUM do
		path = self.miscData.item_live2D_path[i]

		self.itemLive2DList[i]:playLive2DByPath(path)
	end

	self.baseLive2D:playLive2DByPath(CatRaceConfig.BASE_LIVE2D_PATH)
	self.baseLive2D:setPlaySpeed(CatRaceConfig.CAT_RUN_NORMAl_SPEED)
	self.catLive2D:setPlaySpeed(CatRaceConfig.CAT_RUN_NORMAl_SPEED)
	self:resetLive2Ds()

	self.mileAwardAniPanel = UIControls.Panel(self, "MileAxisPanel/BgMileAxis/AxisAniMask/CatRaceAwardPointCellLoop")
	self.mileAwardAni = self.mileAwardAniPanel:getAnimator()
	self.mileAwardAni.speed = CatRaceConfig.MAX_MILE_SPEED * CatRaceConfig.DEFAULT_MILE_RATIO
	self.fuliAni = UIControls.Panel(self, "MileAxisPanel/BgMileAxis/BgFuli")
	self.mileDescTxt = UIControls.Label(self, "ScenePanel/EnvironmentPanel/BgSpeed/BgMile/TextMile")
	self.speedDescTxt = UIControls.Label(self, "ScenePanel/EnvironmentPanel/BgSpeed/BgSpeed/TextSpeed")
	self.showAwardBtn = UIControls.Button(self, "BtnShowAward")

	self.showAwardBtn:addEventClick(self._onBtnShowAward)

	self.specialAwardTipTxt = UIControls.Label(self, "BtnShowAward/TextNote")
	self.nextSpecialGridPath = "BtnShowAward/BgAward/GridAward"
	self.specialAwardPanel = UIControls.Panel(self, "BtnShowAward/BgAward/GridAward")
	self.showAwardIconNewImg = UIControls.Image(self, "MileAxisPanel/FrameImgCatRun/IconNew")
	self.depositInterval = self.miscData.deposit_interval
	self.depositIntervalMin = self.depositInterval / 60
	self.depositIntervalHour = 3600 / self.depositInterval
end

function ActivityCatRaceMainDlg:onActivityDataRefresh(actObj)
	self.actObj = actObj
	self.actData = actObj.actData

	self:refreshData()
end

function ActivityCatRaceMainDlg:updateActivityData(actObj)
	self.actObj = actObj
	self.actData = actObj.actData

	self:refreshData()
end

function ActivityCatRaceMainDlg:onOpenOver()
	ActivityCatRaceMainDlg.super.onOpenOver(self)
	coroutine.start(self._delayShow, self)
	UserData.saveCommonDataInt(CurAvatar.uid .. CatRaceConfig.ACCESS_TIME_KEY, ClientUtils.getServerTime())
end

function ActivityCatRaceMainDlg:_delayShow()
	coroutine.wait(0.1)

	local needRefreshCat = true

	if self.actObj:inFreeze() then
		needRefreshCat = false
	end

	if ClientUtils.isInBeginner() or self.actObj:inFreeze() then
		local depositDistance = self.actData:getDepositDistance()

		if depositDistance and depositDistance > 0 then
			self:showDepositDis(depositDistance, true)
		end
	else
		local depositDistance = self.actData:getDepositDistance()

		if depositDistance and depositDistance > 0 then
			if depositDistance > CatRaceConfig.MILE_DISTANCE_THRESHOLD then
				self:showDepositDis(depositDistance, true)

				self.depositSpeedUpShow = true

				self:refreshCompCat(false)

				needRefreshCat = false

				self:startSpeedUp(nil, depositDistance, self.depositSpeedUpShow)
			else
				if self.actData:mileAchieveHasNew() then
					self:showMileAwardWindow()
				end

				self:showDepositDis(depositDistance, true)
			end
		elseif self.actData:mileAchieveHasNew() then
			self:showMileAwardWindow()
		end
	end

	self:refreshCompCat(needRefreshCat)
end

function ActivityCatRaceMainDlg:showDepositDis(distance, isOffline)
	if distance > 0 then
		if isOffline then
			MsgManager.notice(utils.format(ResClientNotice[458].notice, distance))
		else
			MsgManager.notice(utils.format(ResClientNotice[451].notice, distance))
		end
	end

	self.actData:clearDepositNotice()
end

function ActivityCatRaceMainDlg:showMileAwardWindow()
	local ui = UIManager.getUI("activityCatRaceMileAwardDlg", true)

	if ui then
		local data = {
			mainActID = self.mainActID
		}

		ui:setData(data)
	end
end

function ActivityCatRaceMainDlg:_setData()
	self:refreshData()
end

function ActivityCatRaceMainDlg:refreshData()
	self.actData = self.actObj.actData
	self.mainActID = self.actData.actID
	self.miscResData = ResOpActivityCatRaceMisc[self.mainActID]
	self.curSelectedCatID = self.actData:getCurSelectedCatID()
	self.curMile = self.actData:getCurMile()

	if not self.friendInited then
		self.actData:getAllFriendCatRaceData()

		self.friendInited = true
	end

	self:refreshCatInfo()

	if self.actObj:inFreeze() then
		self:freezeScene()
	elseif not self.mOpening then
		self:refreshCompCat(true)
	end

	self:refreshRaceData()
	self.mileDescTxt:setText(utils.format(ResClientNotice[443].notice, self.curMile))

	if self.actObj:inFreeze() then
		self.speedDescTxt:setText(utils.format(ResClientNotice[444].notice, 0))
	else
		self.speedDescTxt:setText(utils.format(ResClientNotice[444].notice, self.depositIntervalHour))
	end

	self:refreshItems()
	self:checkNew()

	for _, dlgName in pairs(self.actData.relateDlgNames) do
		local ui = UIManager.tryGetUI(dlgName)

		if ui and ui.refreshData then
			ui:refreshData()
		end
	end
end

function ActivityCatRaceMainDlg:freezeScene()
	self:refreshCompCat(false)
	self.farShotScene:changeSpeed(0)
	self.nearShotScene:changeSpeed(0)
	self.allyeScene:changeSpeed(0)
	self.fuliAni:setVisible(false)

	self.mileAwardAni.speed = 0

	if self.depositTimer then
		self.depositTimer:Stop()

		self.depositTimer = nil
	end

	self:hideItemLive2D()
	self.catLive2D:playState(CatRaceConfig.CAT_IDLE_STATE)
end

function ActivityCatRaceMainDlg:refreshCompCat(state)
	if state then
		local curComp = self.actData:getCompPlayer()

		if not self.compPlayer or curComp and curComp.uid ~= self.compPlayer.uid and self.actData:checkFriendIsComp(curComp.uid) then
			self.compPlayer = curComp
		end

		if not self.randomPlayer or curComp and curComp.uid == self.randomPlayer.uid then
			self.randomPlayer = self.actData:getRandomPlayer(self.compPlayer)
		end

		if not self.compPlayer then
			self.compCat:setVisible(false)
		else
			self.compCat:setVisible(true)
			self.compCat:setData(self.compPlayer, self.mainActID)
		end

		if not self.randomPlayer then
			self.randomCat:setVisible(false)
		else
			self.randomCat:setVisible(true)
			self.randomCat:setData(self.randomPlayer, self.mainActID)
		end

		if self.randomPlayer or self.compPlayer then
			self.actData:getOtherPlayerCatRaceData({
				self.compPlayer,
				self.randomPlayer
			}, Functor(self.otherPlayerDataCallback, self))
		end
	else
		self.compCat:setVisible(false)
		self.randomCat:setVisible(false)
	end
end

function ActivityCatRaceMainDlg:checkNew()
	if self.actData:mileAchieveHasNew() then
		self.showAwardIconNewImg:setVisible(true)
	else
		self.showAwardIconNewImg:setVisible(false)
	end

	if self.actObj:inFreeze() then
		self.taskIconNewImg:setVisible(false)
		self.friendIconNewImg:setVisible(false)
	else
		if self.actData:taskAchieveHasNew() or not self.actData:isSelOptionalTask() or self.actData:isOptionalTaskAwardAvaliable() or self.actData:getRemainFriendTaskNum() > 0 and self.actData:isNeedGetFriendTask() and self.actData:hasAvailableFriendTask() or self.actData:getRemainFriendTaskNum() > 0 and self.actData:isNeedGetFriendTask() and not self.actData:hasAvailableFriendTask() and self.actData:isTodayFirst() then
			self.taskIconNewImg:setVisible(true)
		else
			self.taskIconNewImg:setVisible(false)
		end

		if self.actData:hasGiftToReceive() then
			self.friendIconNewImg:setVisible(true)
		else
			self.friendIconNewImg:setVisible(false)
		end
	end
end

function ActivityCatRaceMainDlg:otherPlayerDataCallback(playerData)
	for _, data in pairs(playerData) do
		if self.randomPlayer and data.uid == self.randomPlayer.uid then
			self.randomCat:setVisible(true)
			self.randomCat:setData(data, self.mainActID)
		end

		if self.compPlayer and data.uid == self.compPlayer.uid then
			self.compCat:setVisible(true)
			self.compCat:setData(data, self.mainActID)
		end
	end
end

function ActivityCatRaceMainDlg:refreshItems()
	for index, item in ipairs(self.itemList) do
		local itemID = self.actData:getItemID(index)
		local itemNum = CurAvatar:getItemNumById(itemID)

		self.itemNumList[index]:setText(ClientUtils.getNumShortStr(itemNum))

		if itemNum <= 0 then
			self.itemNumList[index]:setColorByRGBA(1, 0.21568627450980393, 0, 1)
			self.itemNewImgs[index]:setVisible(false)
		else
			self.itemNumList[index]:setColorByRGBA(0.4117647058823529, 0.4117647058823529, 0.4117647058823529, 1)
			self.itemNewImgs[index]:setVisible(true)
		end
	end
end

function ActivityCatRaceMainDlg:_onBtnTask()
	if self.actObj:inFreeze() then
		MsgManager.notice(Lang.get(32793))
	else
		local ui = UIManager.getUI("activityCatRaceTaskDlg", true, true)

		if ui then
			local data = {
				mainActID = self.mainActID
			}

			ui:setData(data)
		end
	end
end

function ActivityCatRaceMainDlg:_onBtnClose()
	self:setVisible(false)
end

function ActivityCatRaceMainDlg:_onBtnFriend()
	if self.actObj:inFreeze() then
		MsgManager.notice(Lang.get(32793))
	else
		local ui = UIManager.getUI("activityCatRaceFriendDlg", true, true)

		if ui then
			local data = {
				mainActID = self.mainActID
			}

			ui:setData(data)
		end
	end
end

function ActivityCatRaceMainDlg:_onBtnRank()
	local rankMainDlg = UIManager.getUI("rankMainDlg", true)

	rankMainDlg:initByRankType(Const.RANK_TYPE_CAT_RACE, self.actData)
end

function ActivityCatRaceMainDlg:_onBtnStore()
	if self.actData then
		local actID = self.actData.miscData.store_id

		JumpGuideManager.jump(actID)
	end
end

function ActivityCatRaceMainDlg:_onBtnUseItem(sender)
	if self.forbidItemUse then
		return
	end

	local index

	for i = 1, CatRaceConfig.ITEM_MAX_NUM do
		if self.itemList[i] == sender then
			index = i

			break
		end
	end

	local itemID = self.actData:getItemID(index)
	local itemNum = CurAvatar:getItemNumById(itemID)

	if itemNum > 0 then
		local ui = UIManager.getUI("activityCatRaceUseItemDlg", true)

		ui:setData(itemID, Functor(self.itemUsedCallback, self, index))
	else
		BaseObject.ShowObjectTips(itemID, itemNum, self, {
			AutoOpenGuide = 1
		})
	end
end

function ActivityCatRaceMainDlg:_onBtnSetCat()
	local ui = UIManager.getUI("activityCatRaceCatSetDlg", true)

	if ui then
		local data = {
			actID = self.mainActID,
			curSelected = self.curSelectedCatID,
			selectedCallback = Functor(self.catSetCallback, self)
		}

		ui:setData(data)
	end
end

function ActivityCatRaceMainDlg:_onBtnCatTouch()
	self.catCloseBtn:setVisible(true)
	self.catTouchBtn:setEnable(false)
	self.catFuncAni:startAni("CatRaceShowFunc", true)
	self.catEmptyClickpanel:setVisible(false)
end

function ActivityCatRaceMainDlg:_onBtnCatClose()
	self.catFuncAni:startAni("CatRaceHideFunc", true)
	self.catCloseBtn:setVisible(false)
	self.catTouchBtn:setEnable(true)
	self.catEmptyClickpanel:setVisible(true)
end

function ActivityCatRaceMainDlg:catSetCallback(selectedID)
	if self.curSelectedCatID ~= selectedID then
		self.actData:setCat(selectedID)
	end
end

function ActivityCatRaceMainDlg:itemUsedCallback(index, totalValue)
	self:refreshData()
	self.jumpTipTxt:setText(utils.format("%1sm", totalValue))
	self.jumpTipAnim:setVisible(false)
	self.jumpTipAnim:setVisible(true)
	self.jumpTipAnim:startAni("ShowJumpWord", true)

	if self.actObj:inFreeze() then
		coroutine.start(self._coStartSpeedUp, self, index, totalValue)
	else
		self:startSpeedUp(index, totalValue)
	end
end

function ActivityCatRaceMainDlg:_coStartSpeedUp(index, totalValue)
	coroutine.wait(0.1)

	if tolua.isnull(self.catLive2D:getComObj()) or tolua.isnull(self.baseLive2D:getComObj()) then
		return
	end

	self.catLive2D:playState(CatRaceConfig.CAT_RUN_STATE)
	self:startSpeedUp(index, totalValue)
end

function ActivityCatRaceMainDlg:startSpeedUp(index, totalValue, depositSpeedUpShow)
	for i, itemLive2D in ipairs(self.itemLive2DList) do
		if i == index then
			itemLive2D:setSortOrder(CatRaceConfig.ITEM_SHOW_SORT_ORDER)
		else
			itemLive2D:setSortOrder(CatRaceConfig.HIDE_SORT_ORDER)
		end

		itemLive2D:setPlaySpeed(CatRaceConfig.CAT_RUN_UP_SPEED)
	end

	self.baseLive2D:setSortOrder(CatRaceConfig.ITEM_SHOW_SORT_ORDER)
	self.baseLive2D:setPlaySpeed(CatRaceConfig.CAT_RUN_UP_SPEED)
	self.catLive2D:setPlaySpeed(CatRaceConfig.CAT_RUN_UP_SPEED)
	self.farShotScene:changeSpeed(CatRaceConfig.SCENE_UP_SPEED)
	self.nearShotScene:changeSpeed(CatRaceConfig.SCENE_UP_SPEED)
	self.allyeScene:changeSpeed(CatRaceConfig.SCENE_UP_SPEED)
	self.fuliAni:setVisible(true)

	local speedRatio = 1

	if totalValue < CatRaceConfig.MAX_SPEED_MILE then
		speedRatio = totalValue / CatRaceConfig.MAX_SPEED_MILE / 1.9 + CatRaceConfig.DEFAULT_MILE_SPEED
	end

	self.mileAwardAni.speed = speedRatio * CatRaceConfig.MAX_MILE_SPEED

	if self.speedUpTimer then
		self.speedUpTimer:Restart()
	else
		self.bgCatAnim:startAni("CatGoBehindMove", true)

		self.speedUpTimer = Timer(Slot(self.stopSpeedUp, self), CatRaceConfig.LIVE2D_DURATION)

		self.speedUpTimer:Start()
	end
end

function ActivityCatRaceMainDlg:disableButtons()
	self.storeBtn:setEnable(false)
	self.rankBtn:setEnable(false)
	self.friendBtn:setEnable(false)
	self.taskBtn:setEnable(false)
end

function ActivityCatRaceMainDlg:enableButtons()
	self.storeBtn:setEnable(true)
	self.rankBtn:setEnable(true)
	self.friendBtn:setEnable(true)
	self.taskBtn:setEnable(true)
end

function ActivityCatRaceMainDlg:stopSpeedUp()
	if self.actObj:inFreeze() then
		self:freezeScene()
	else
		self.farShotScene:changeSpeed(CatRaceConfig.SCENE_NORMAL_SPEED)
		self.nearShotScene:changeSpeed(CatRaceConfig.SCENE_NORMAL_SPEED)
		self.allyeScene:changeSpeed(CatRaceConfig.SCENE_NORMAL_SPEED)
		self.catLive2D:setPlaySpeed(CatRaceConfig.CAT_RUN_NORMAl_SPEED)

		for i, itemLive2D in ipairs(self.itemLive2DList) do
			itemLive2D:setPlaySpeed(CatRaceConfig.CAT_RUN_NORMAl_SPEED)
		end

		self.baseLive2D:setPlaySpeed(CatRaceConfig.CAT_RUN_NORMAl_SPEED)
		self:hideItemLive2D()
		self.jumpTipAnim:setVisible(false)
		self.bgCatAnim:stopAni("CatGoBehindMove")
		self:refreshCompCat(true)

		if self.compPlayer then
			self.compCat:resetPosition(CatRaceConfig.COMP_CAT_POSITION_X)
		end

		if self.randomPlayer then
			self.randomCat:resetPosition(CatRaceConfig.RANDOME_CAT_POSITION_X)
		end

		self.mileAwardAni.speed = CatRaceConfig.MAX_MILE_SPEED * CatRaceConfig.DEFAULT_MILE_RATIO

		if self.isOfflineShow then
			if self.actData:mileAchieveHasNew() then
				self:showMileAwardWindow()
			end

			self.isOfflineShow = false
		end
	end

	if self.speedUpTimer then
		self.speedUpTimer:Stop()

		self.speedUpTimer = nil
	end
end

function ActivityCatRaceMainDlg:hideItemLive2D()
	for i, itemLive2D in ipairs(self.itemLive2DList) do
		itemLive2D:setSortOrder(CatRaceConfig.HIDE_SORT_ORDER)
	end

	self.baseLive2D:setSortOrder(CatRaceConfig.HIDE_SORT_ORDER)
end

function ActivityCatRaceMainDlg:resetLive2Ds()
	coroutine.start(self._coResetLive2D, self)
end

function ActivityCatRaceMainDlg:_coResetLive2D()
	coroutine.wait(0.1)

	if tolua.isnull(self.catLive2D:getComObj()) or tolua.isnull(self.baseLive2D:getComObj()) then
		return
	end

	if self.actObj:inFreeze() then
		self.catLive2D:playState(CatRaceConfig.CAT_IDLE_STATE)
	else
		self.catLive2D:playState(CatRaceConfig.CAT_RUN_STATE)
	end

	for i, itemLive2D in ipairs(self.itemLive2DList) do
		itemLive2D:playState(CatRaceConfig.CAT_RUN_STATE)
	end

	self.baseLive2D:playState(CatRaceConfig.CAT_RUN_STATE)
end

function ActivityCatRaceMainDlg:updateRelatedActivityData()
	self:refreshData()
end

function ActivityCatRaceMainDlg:refreshRaceData()
	local nextSpecialPoint, distance = self.actData:getNextSpecialPoint()

	if nextSpecialPoint then
		self.specialAwardTipTxt:setText(utils.format(ResClientNotice[441].notice, distance))

		if not self.prevNextSpecialPoint or self.prevNextSpecialPoint ~= nextSpecialPoint then
			self.showAwardBtn:setVisible(true)

			if self.specialAwardGrid then
				for _, grid in pairs(self.specialAwardGrid) do
					grid:destroy()
				end
			end

			self.specialAwardGrid = {}

			ClientUtils.CreateBonusGrid(self, self.specialAwardGrid, self.nextSpecialGridPath, nextSpecialPoint.award, true, nil, true, CatRaceConfig.GRID_CONFIG)

			self.prevNextSpecialPoint = nextSpecialPoint
		end

		self.specialAwardPanel:setVisible(true)
	elseif not nextSpecialPoint then
		self.specialAwardTipTxt:setText(ResClientNotice[442].notice)
		self.specialAwardPanel:setVisible(false)
	end
end

function ActivityCatRaceMainDlg:refreshCatInfo()
	self.catDetail = self.actData:getCatDetail()

	self.playerNameTxt:setText(utils.format(Lang.get(52478), CurAvatar.name))

	if self.catDetail and self.catDetail.live2D_path and (not self.curCatDetail or self.curCatDetail.cat_id ~= self.catDetail.cat_id) then
		self.catLive2D:playLive2DByPath(self.catDetail.live2D_path)
		self:resetLive2Ds()

		self.curCatDetail = self.catDetail
	end
end

function ActivityCatRaceMainDlg:onClose()
	ActivityCatRaceMainDlg.super.onClose(self)

	if self.speedUpTimer then
		self.speedUpTimer:Stop()

		self.speedUpTimer = nil
	end

	if self.depositTimer then
		self.depositTimer:Stop()

		self.depositTimer = nil
	end

	self.actData:clearCatRaceDataCallback()
	UserData.saveCommonDataInt(CurAvatar.uid .. CatRaceConfig.MILE_RECORD, self.curMile)
end

function ActivityCatRaceMainDlg:_onBtnShowAward()
	self:showMileAwardWindow()
end

function ActivityCatRaceMainDlg:getCatName(name)
	return utils.format(Lang.get(52478), name)
end

function ActivityCatRaceMainDlg:onGetRelatedActivityBonus(actId, relateInfo, callback)
	if callback then
		callback()
	end

	self.actData:refreshData()
end

function ActivityCatRaceMainDlg:forceResetFriend()
	self.actData:forceResetFriendData()
end

function ActivityCatRaceMainDlg:activityStateShow(actObj, extraStateArgs)
	if self.actObj:inFreeze() then
		MsgManager.notice(Lang.get(32793))

		return
	end

	if self.actObj:inCloseState() then
		MsgManager.notice(Lang.get(1870))
	end

	local subUIDlgName = extraStateArgs

	for _, uiName in pairs(self.subDlgNames) do
		UIManager.tryHideUI(uiName)
	end

	local ui = UIManager.getUI(subUIDlgName, true)

	if ui then
		local data = {
			mainActID = self.mainActID
		}

		ui:setData(data)
	end
end

function ActivityCatRaceMainDlg:onVisibleChanged(isSee)
	if not isSee and self.speedUpTimer then
		self:stopSpeedUp()
	end
end

return ActivityCatRaceMainDlg
