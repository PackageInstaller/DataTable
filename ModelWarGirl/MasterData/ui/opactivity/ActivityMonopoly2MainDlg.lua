-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityMonopoly2MainDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRandClient = require("ClientData/ResRandClient")
local ResActivityDetailMonopolyEvent = require("ClientData/ResActivityDetailMonopolyEvent")
local BaseObject = require("Common/Object/BaseObject")
local ResItem = require("ClientData/ResItem")
local UserData = require("Helper/UserData")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local ResOpActivityMonopolyAwardLibMisc = require("ClientData/ResOpActivityMonopolyAwardLibMisc")
local ActivityMonopolyGridInfoPanel = Class("ActivityMonopolyGridInfoPanel", UIControls.Panel)

function ActivityMonopolyGridInfoPanel:ctor()
	self:initUI()
end

function ActivityMonopolyGridInfoPanel:initUI()
	self.btnConfirm = UIControls.Button(self, self.mPath .. "/BtnConfirm")

	self.btnConfirm:addEventClick(self.onClickConfirm)

	self.textTitle = UIControls.Label(self, self.mPath .. "/TextTitle")
	self.textDesc = UIControls.Label(self, self.mPath .. "/TextContent")
end

function ActivityMonopolyGridInfoPanel:onClickConfirm()
	self.mParent:onClickSensor()
end

function ActivityMonopolyGridInfoPanel:setData(stepData)
	self.textTitle:setText(stepData.title)
	self.textDesc:setText(stepData.desc)
end

local ActivityMonopolyNormalGrid = Class("ActivityMonopolyNormalGrid", UIControls.Child)

function ActivityMonopolyNormalGrid:ctor()
	self:initUI()
end

function ActivityMonopolyNormalGrid:initUI()
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onClickSensor)

	self.imgBg = UIControls.Image(self, "Icon")
	self.textNum = UIControls.Label(self, "TextNum")
	self.textLevel = UIControls.Label(self, "TextLv")
	self.effLevelUp = UIControls.Panel(self, "Efx")
end

function ActivityMonopolyNormalGrid:initData(gridData)
	self.gridData = gridData
end

function ActivityMonopolyNormalGrid:onClickSensor()
	self.mParent:onGridClick(self.gridData)
end

function ActivityMonopolyNormalGrid:setData(gridLevel)
	self.gridLevel = gridLevel

	if self.gridData.icon_path then
		self.imgBg:setImage("Atlas/" .. self.gridData.icon_path, self.gridData.icon)
		self.textNum:setText(self.gridData.show_num or "")
	elseif self.gridData.level_bonus then
		local bonus = self.gridData.level_bonus[self.gridLevel]

		if bonus then
			local rand = ResRandClient[bonus.rand_id]

			if rand then
				local ids = rand.show_ids or {}
				local nums = rand.show_nums or {}
				local itemIcon = BaseObject.getItemIconPath(ids[1])

				if itemIcon then
					self.imgBg:setImage(itemIcon[1], itemIcon[2])
				end

				if nums[1] and nums[1] > 1 then
					self.textNum:setText(ClientUtils.getNumShortStr(nums[1]))
				else
					self.textNum:setText("")
				end
			end
		end
	end

	if self.gridData.max_level and self.gridData.max_level > 1 then
		if Const.REVIEW_VERSION then
			self.textLevel:setText(Lang.get(1203) .. gridLevel)
		else
			self.textLevel:setText("Lv." .. gridLevel)
		end
	else
		self.textLevel:setText("")
	end
end

function ActivityMonopolyNormalGrid:onCheckDelay()
	self.effLevelUp:setVisible(false)
	self.effLevelUp:setVisible(true)
end

local ActivityMonopolyChooseGrid = Class("ActivityMonopolyChooseGrid", UIControls.Child)

function ActivityMonopolyChooseGrid:ctor()
	self:initUI()
end

function ActivityMonopolyChooseGrid:initUI()
	self.bgImg = UIControls.Image(self, "Bg")
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onClickSensor)

	self.panelChooseBefore = UIControls.Panel(self, "Bg/BeforePanel")
	self.imgBeforeAdd = UIControls.Image(self, "Bg/BeforePanel/ImgAdd")
	self.imgBeforeDesc = UIControls.Image(self, "Bg/BeforePanel/ImgDec")
	self.panelChooseAfter = UIControls.Panel(self, "Bg/AfterPanel")
	self.imgBg = UIControls.Image(self, "Bg/AfterPanel/Icon")
	self.textNum = UIControls.Label(self, "Bg/AfterPanel/TextNum")
	self.textLimit = UIControls.Label(self, "Bg/AfterPanel/TextLimit")
	self.effLevelUp = UIControls.Panel(self, "Bg/AfterPanel/Efx")
	self.imgAfterBg = UIControls.Image(self, "Bg/AfterPanel/BgLimit")
	self.imgAfterChange = UIControls.Image(self, "Bg/AfterPanel/ImgChange")
end

function ActivityMonopolyChooseGrid:initData(gridData)
	self.gridData = gridData
end

function ActivityMonopolyChooseGrid:onClickSensor()
	self.mParent:onGridClick(self.gridData)
end

function ActivityMonopolyChooseGrid:setData(gridLevel)
	self.gridLevel = gridLevel

	self:refreshGrid()
end

function ActivityMonopolyChooseGrid:showNeedChooseAnim()
	self.bgImg:playStateAnimator("LackAward")
end

function ActivityMonopolyChooseGrid:refreshGrid()
	local actData = self.mParent.actObj.actData
	local chooseAward, nowCount, maxCount = actData:getChooseAwardInfo(self.gridData.lib_id)
	local libData = ResOpActivityMonopolyAwardLibMisc[self.gridData.lib_id] or ""

	self.pathStr = libData.icon_str or ""

	self.bgImg:setImage(self.mParent.eventAtlas, "BgChessboardAward" .. self.pathStr)

	if chooseAward then
		self.bgImg:playStateAnimator("DefaultAward")
		self.panelChooseBefore:setVisible(false)
		self.panelChooseAfter:setVisible(true)
		self.imgAfterBg:setImage(self.mParent.eventAtlas, "BgNumber" .. self.pathStr)
		self.imgAfterChange:setImage(self.mParent.eventAtlas, "BtnReplace" .. self.pathStr)

		local rand = ResRandClient[chooseAward]

		if rand then
			local ids = rand.show_ids or {}
			local nums = rand.show_nums or {}
			local itemIcon = BaseObject.getItemIconPath(ids[1])

			if itemIcon then
				self.imgBg:setImage(itemIcon[1], itemIcon[2])
			end

			self.textNum:setText(nums[1] or "")
		end

		self.textLimit:setText(string.format(Lang.get(32784), maxCount - nowCount))

		if maxCount <= nowCount then
			self.textLimit:setFontColor(ResColor.RED)
		else
			self.textLimit:setFontColor(ResColor.WHITE)
		end
	else
		self.bgImg:playStateAnimator("LoopAward")
		self.imgBeforeAdd:setImage(self.mParent.eventAtlas, "BtnAward" .. self.pathStr)
		self.imgBeforeDesc:setImage(self.mParent.eventAtlas, "ImgDecAward" .. self.pathStr)
		self.panelChooseBefore:setVisible(true)
		self.panelChooseAfter:setVisible(false)
	end
end

function ActivityMonopolyChooseGrid:onCheckDelay()
	self.effLevelUp:setVisible(false)
	self.effLevelUp:setVisible(true)
end

local ActivityMonopolyEventGrid = Class("ActivityMonopolyEventGrid", UIControls.Child)

function ActivityMonopolyEventGrid:ctor()
	self:initUI()
end

function ActivityMonopolyEventGrid:initUI()
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onClickSensor)

	self.imgBg = UIControls.Image(self, "Icon")
end

function ActivityMonopolyEventGrid:initData(gridData)
	self.gridData = gridData

	if self.gridData.icon_path then
		self.imgBg:setImage("Atlas/" .. self.gridData.icon_path, self.gridData.icon)
	elseif self.gridData.level_bonus then
		local bonus = self.gridData.level_bonus[1]

		if bonus then
			local rand = ResRandClient[bonus.rand_id]

			if rand then
				local ids = rand.show_ids or {}
				local nums = rand.show_nums or {}
				local itemIcon = BaseObject.getItemIconPath(ids[1])

				if itemIcon then
					self.imgBg:setImage(itemIcon[1], itemIcon[2])
				end
			end
		end
	end
end

function ActivityMonopolyEventGrid:onClickSensor()
	self.mParent:onGridClick(self.gridData)
end

function ActivityMonopolyEventGrid:onCheckDelay()
	return
end

local ActivityMonopolyStarGrid = Class("ActivityMonopolyStarGrid", UIControls.Child)

function ActivityMonopolyStarGrid:ctor()
	self:initUI()
end

function ActivityMonopolyStarGrid:initUI()
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onClickSensor)

	self.imgBg = UIControls.Image(self, "Icon")
	self.textNum = UIControls.Label(self, "TextNum")
	self.textLevel = UIControls.Label(self, "TextLv")
	self.effLevelUp = UIControls.Panel(self, "Efx")
	self.panelDoubleBonus = UIControls.Panel(self, "SpPanel")
end

function ActivityMonopolyStarGrid:initData(gridData)
	self.gridData = gridData
end

function ActivityMonopolyStarGrid:onClickSensor()
	self.mParent:onGridClick(self.gridData)
end

function ActivityMonopolyStarGrid:setData(gridLevel)
	self.gridLevel = gridLevel

	if self.gridData.icon_path then
		self.imgBg:setImage("Atlas/" .. self.gridData.icon_path, self.gridData.icon)
		self.textNum:setText(self.gridData.show_num or "")
	elseif self.gridData.level_bonus then
		local bonus = self.gridData.level_bonus[self.gridLevel]

		if bonus then
			local rand = ResRandClient[bonus.rand_id]

			if rand then
				local ids = rand.show_ids or {}
				local nums = rand.show_nums or {}
				local itemIcon = BaseObject.getItemIconPath(ids[1])

				if itemIcon then
					self.imgBg:setImage(itemIcon[1], itemIcon[2])
				end

				if nums[1] and nums[1] > 1 then
					self.textNum:setText(ClientUtils.getNumShortStr(nums[1]))
				else
					self.textNum:setText("")
				end
			end
		end
	end

	if self.gridData.max_level and self.gridData.max_level > 1 then
		if Const.REVIEW_VERSION then
			self.textLevel:setText(Lang.get(1203) .. gridLevel)
		else
			self.textLevel:setText("Lv." .. gridLevel)
		end
	else
		self.textLevel:setText("")
	end
end

function ActivityMonopolyStarGrid:onBonusDouble(double)
	self.panelDoubleBonus:setVisible(double)
end

function ActivityMonopolyStarGrid:onPassAwards(bonus)
	return
end

function ActivityMonopolyStarGrid:onCheckDelay(bonus)
	return
end

local GRID_TYPE_NML = 1
local GRID_TYPE_EVENT = 2
local GRID_TYPE_PASS = 3
local MAX_GRID_NUM = 20
local DOTweenComponent = typeof(Framework.EffectSystem.DOTweenComponent)
local strClassName = "ActivityMonopoly2MainDlg"
local ActivityMonopoly2MainDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityMonopoly2MainDlg, ActivityPanelMixin)

function ActivityMonopoly2MainDlg:initUI()
	self.textRule = UIControls.Label(self, "MainInfoPanel/TextRule")
	self.textTime = UIControls.Label(self, "MainInfoPanel/TextTime")
	self.panelStart = UIControls.Panel(self, "MainInfoPanel/GridPanel/GridStart")
	self.aniChess = UIControls.UIAni(self, "MainInfoPanel/GridPanel/ImgChess")
	self.tweenComFlag = self.aniChess:getGameObject():GetComponent(DOTweenComponent)
	self.btnUseTurtle = UIControls.Button(self, "MainInfoPanel/ToolPanel/BtnUse", "Text")

	self.btnUseTurtle:addEventClick(self.onUseTurtleItem)

	self.btnNumDice = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnDiceNml", "TextName")

	self.btnNumDice:addEventClick(self.onClickNmlDice)

	self.imgNmlDice = UIControls.Image(self, "MainInfoPanel/FuncPanel/BtnDiceNml/Icon")
	self.textNmlDiceNum = UIControls.Label(self, "MainInfoPanel/FuncPanel/BtnDiceNml/TextNum")
	self.btnBuyNmlDice = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnDiceNml/BtnBuy")

	self.btnBuyNmlDice:addEventClick(self.onClickBuyNmlDice)

	self.imgNmlDiceBuff = UIControls.Image(self, "MainInfoPanel/FuncPanel/BtnDiceNml/SpPanel")
	self.panelNumDiceTurtle = UIControls.Panel(self, "MainInfoPanel/FuncPanel/BtnDiceNml/SpNumPanel")
	self.textNumDiceTurtle = UIControls.Label(self, "MainInfoPanel/FuncPanel/BtnDiceNml/SpNumPanel/TextNum")
	self.btnChoosenDice = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnDiceSpe", "TextName")

	self.btnChoosenDice:addEventClick(self.onClickChooseDice)

	self.imgSpeDice = UIControls.Image(self, "MainInfoPanel/FuncPanel/BtnDiceSpe/Icon")
	self.textChooseDiceNum = UIControls.Label(self, "MainInfoPanel/FuncPanel/BtnDiceSpe/TextNum")
	self.imgChooseDiceBuff = UIControls.Image(self, "MainInfoPanel/FuncPanel/BtnDiceSpe/SpPanel")
	self.btnBuyChooseDice = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnDiceSpe/BtnBuy")

	self.btnBuyChooseDice:addEventClick(self.onClickBuyChooseDice)

	self.panelSpeDiceTurtle = UIControls.Panel(self, "MainInfoPanel/FuncPanel/BtnDiceSpe/SpNumPanel")
	self.textSpeDiceTurtle = UIControls.Label(self, "MainInfoPanel/FuncPanel/BtnDiceSpe/SpNumPanel/TextNum")
	self.aniGet = UIControls.UIAni(self, "MainInfoPanel/GetPanel")
	self.imgGet = UIControls.Image(self, "MainInfoPanel/GetPanel/Icon")
	self.textGetNum = UIControls.Label(self, "MainInfoPanel/GetPanel/TextNum")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnClose)

	if self.actObj.actData.itemEventData then
		for itemId, info in pairs(self.actObj.actData.itemEventData) do
			self.eventItemId = itemId

			local fakeItem = BaseObject.GetObject(itemId, 1)

			self.itemEventGrid = UIControls.getGridChild(fakeItem, self, "MainInfoPanel/ToolPanel/GridPanel")

			self.itemEventGrid:setVisible(true)

			self.itemEventGrid.mDisableWays = true

			break
		end

		self.btnUseTurtle:setText(Lang.get(588))
	end

	self.panelGridInfo = ActivityMonopolyGridInfoPanel(self, "MainInfoPanel/GridInfoPanel")
	self.btnSensor = UIControls.Button(self, "MainInfoPanel/BtnSensor")

	self.btnSensor:addEventClick(self.onClickSensor)

	self.modelViewport = UIControls.RawImage(self, "MainInfoPanel/ModelViewport")
	self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/MonopolyRollStage")
	self.toggleSkipAni = UIControls.Toggle(self, "MainInfoPanel/SkipSwitch")
	self.grids = {}
	self.gridPos = {}
	self.gridPos[0] = self.panelStart:getPosition()
	self.gridPos[0].x = self.gridPos[0].x + 90

	local GridPath = "System/Activity/ActivityMonopoly"

	if self.replaceableCellPath and self.replaceableCellPath[1] then
		GridPath = "System/Activity/" .. self.replaceableCellPath[1]
	end

	local actId = self.actObj.actId
	local monopolyData = self.actObj.actData.clientData

	for index = 1, MAX_GRID_NUM do
		local panel = UIControls.Panel(self, "MainInfoPanel/GridPanel/Grid" .. index)

		self.gridPos[index] = panel:getPosition()

		local gridData = monopolyData[index]

		if gridData then
			if not self.grids[index] then
				if gridData.step_type == GRID_TYPE_EVENT then
					self.grids[index] = ActivityMonopolyEventGrid(self, "MainInfoPanel/GridPanel/Grid" .. index, GridPath .. "/GridMonopolySpe")
				elseif gridData.step_type == GRID_TYPE_NML then
					if gridData.lib_id then
						self.grids[index] = ActivityMonopolyChooseGrid(self, "MainInfoPanel/GridPanel/Grid" .. index, GridPath .. "/GridMonopolyAward")
					else
						self.grids[index] = ActivityMonopolyNormalGrid(self, "MainInfoPanel/GridPanel/Grid" .. index, GridPath .. "/GridMonopolyNml")
					end
				else
					self.grids[index] = ActivityMonopolyStarGrid(self, "MainInfoPanel/GridPanel/Grid" .. index, GridPath .. "/GridMonopolyStar")
				end
			end

			self.grids[index]:initData(gridData)
			self.grids[index]:setVisible(true)
		end
	end

	self._slot4DiceModelReady = Slot(self.onDiceModelReady, self)
	self._slot4DestAction = Slot(self.onDstAction, self)
	self.bonusCache = {}
	self.timerBonus = Timer.New(Slot(self._onShowBonus, self), 2, 1)
	self.userDataKey = "Activity" .. actId

	local modeStr = UserData.loadCommonData(self.userDataKey)

	if modeStr == "1" then
		self.toggleSkipAni:setOn(true)

		self.skipAni = true
	end

	self.slotForRefreshDice = Slot(self._refreshDiceNum, self)

	if self.actObj.actData.miscData and self.actObj.actData.miscData.normal_id then
		CurAvatar:registerItemChangedCallBack(self.actObj.actData.miscData.normal_id, self.slotForRefreshDice)
	end

	if self.actObj.actData.miscData and self.actObj.actData.miscData.luck_id then
		CurAvatar:registerItemChangedCallBack(self.actObj.actData.miscData.luck_id, self.slotForRefreshDice)
	end

	self.aniGetAchieve = UIControls.UIAni(self, "MainInfoPanel/BtnAchi/ImgFlash")
	self.eventAtlas = "Atlas/ActivityAtlas/ActivityMonopolyAtlas"
	self.speAtlas = "Atlas/ActivityAtlas/ActivityMonopolyAtlas05"

	if self.replaceableCellPath and self.replaceableCellPath[2] then
		self.eventAtlas = "Atlas/ActivityAtlas/" .. self.replaceableCellPath[2]
	elseif self.replaceableCellPath and self.replaceableCellPath[3] then
		self.eventAtlas = "Atlas/ActivityAtlas/" .. self.replaceableCellPath[3] .. "ActivityMonopolyAtlas"
		self.speAtlas = "Atlas/ActivityAtlas/" .. self.replaceableCellPath[3] .. "ActivityMonopolyAtlas05"
	end
end

function ActivityMonopoly2MainDlg:onOpen()
	ActivityMonopoly2MainDlg.super.onOpen(self)

	if self.miscData then
		self:_refreshDiceNum()
	end
end

function ActivityMonopoly2MainDlg:onOpenOver()
	ActivityMonopoly2MainDlg.super.onOpenOver(self)
	self:checkChooseGrid()
end

function ActivityMonopoly2MainDlg:checkChooseGrid(msgNotice)
	local noChooseLib, noChooseReason
	local checkedIds = {}

	for index, grid in ipairs(self.grids) do
		if grid.gridData and grid.gridData.lib_id then
			local lib_id = grid.gridData.lib_id

			if not checkedIds[lib_id] then
				local chooseAward, nowCount, maxCount = self.actObj.actData:getChooseAwardInfo(lib_id)

				checkedIds[lib_id] = {
					chooseAward,
					nowCount,
					maxCount
				}

				if not chooseAward or maxCount <= nowCount then
					noChooseLib = lib_id

					if msgNotice then
						if chooseAward then
							MsgManager.clientNotice(401)
						else
							MsgManager.clientNotice(400)
						end
					end
				end
			end
		end
	end

	if noChooseLib then
		for index, grid in ipairs(self.grids) do
			if grid.gridData and grid.gridData.lib_id then
				local libInfo = checkedIds[grid.gridData.lib_id]

				if not libInfo[1] or libInfo[2] >= libInfo[3] then
					grid:showNeedChooseAnim()
				end
			end
		end

		return true
	end

	return false
end

function ActivityMonopoly2MainDlg:_setData()
	for index, grid in ipairs(self.grids) do
		if grid.setData then
			grid:setData(self.actObj.actData:getMonopolyGridLevel(index))
		end
	end

	self:moveTo(self.actObj.actData.curPos, 0)

	self.miscData = self.actObj.actData.miscData

	local normalData = ResItem[self.miscData.normal_id]

	if normalData then
		self.btnNumDice:setText(normalData.name or "")
	end

	local luckData = ResItem[self.miscData.luck_id]

	if luckData then
		self.btnChoosenDice:setText(luckData.name or "")
	end

	self:_refreshDiceNum()
	self:_refreshBuff()
end

function ActivityMonopoly2MainDlg:_refreshDiceNum()
	self.textNmlDiceNum:setText(ClientUtils.getMoney(self.miscData.normal_id))
	self.textChooseDiceNum:setText(ClientUtils.getMoney(self.miscData.luck_id))

	if self.eventItemId then
		local itemNum = ClientUtils.getMoney(self.eventItemId)
		local fakeItem = BaseObject.GetObject(self.eventItemId, itemNum)

		self.itemEventGrid:setObj(fakeItem)
		self.itemEventGrid.textNum:setText(itemNum .. "/1")

		if itemNum > 0 then
			self.itemEventGrid:setObjGray(false)
		else
			self.itemEventGrid:setObjGray(true)
		end
	end
end

function ActivityMonopoly2MainDlg:_refreshBuff()
	local actData = self.actObj.actData

	self.eventData = actData:getNowEventData()

	local starDouble = self.eventData and self.eventData.event_type == 2

	self.rollDouble = false
	self.rollHalf = false
	self.rollOne = false

	if not actData.itemEventId or not (actData.itemEventCount > 0) then
		self.imgNmlDice:setImage(self.eventAtlas, "BgOrdinary")
		self.imgSpeDice:setImage(self.eventAtlas, "BgTelecontrol")
		self.panelNumDiceTurtle:setVisible(false)
		self.panelSpeDiceTurtle:setVisible(false)

		if self.eventData and self.eventData.event_type == 5 then
			if self.eventData.param1 < 10000 then
				self.rollHalf = true
			else
				self.rollDouble = true
			end
		end
	else
		self.imgNmlDice:setImage(self.speAtlas, "BgOrdinaryNew01")
		self.imgSpeDice:setImage(self.speAtlas, "BgTelecontrolNew01")

		self.rollOne = true

		self.panelNumDiceTurtle:setVisible(true)
		self.panelSpeDiceTurtle:setVisible(true)
		self.textNumDiceTurtle:setText(actData.itemEventCount)
		self.textSpeDiceTurtle:setText(actData.itemEventCount)
	end

	for _, grid in ipairs(self.grids) do
		if grid.onBonusDouble then
			grid:onBonusDouble(starDouble)
		end
	end

	if self.rollHalf then
		self.imgNmlDiceBuff:setVisible(true)
		self.imgNmlDiceBuff:setImage(self.eventAtlas, "IconUnlucky")
		self.imgChooseDiceBuff:setVisible(true)
		self.imgChooseDiceBuff:setImage(self.eventAtlas, "IconUnlucky")
	elseif self.rollDouble then
		self.imgNmlDiceBuff:setVisible(true)
		self.imgNmlDiceBuff:setImage(self.eventAtlas, "IconLucky")
		self.imgChooseDiceBuff:setVisible(true)
		self.imgChooseDiceBuff:setImage(self.eventAtlas, "IconLucky")
	else
		self.imgNmlDiceBuff:setVisible(false)
		self.imgChooseDiceBuff:setVisible(false)
	end

	if self.eventItemId then
		local itemNum = ClientUtils.getMoney(self.eventItemId)
		local fakeItem = BaseObject.GetObject(self.eventItemId, itemNum)

		self.itemEventGrid:setObj(fakeItem)
		self.itemEventGrid.textNum:setText(itemNum .. "/1")

		if itemNum > 0 then
			self.itemEventGrid:setObjGray(false)
		else
			self.itemEventGrid:setObjGray(true)
		end
	end
end

function ActivityMonopoly2MainDlg:refreshRealPanel()
	return
end

function ActivityMonopoly2MainDlg:onBtnClose()
	self:setVisible(false)
	self:recoverManualReject()
end

function ActivityMonopoly2MainDlg:onPlayGetAchieveAnim()
	self.aniGetAchieve:setVisible(true)
	self.aniGetAchieve:startAni("FlashAchiEntry", true)
end

function ActivityMonopoly2MainDlg:onUseTurtleItem()
	if self.eventItemId then
		if self.actObj.actData.itemEventId and self.actObj.actData.itemEventCount > 0 then
			MsgManager.clientNotice(405)
		else
			local itemNum = ClientUtils.getMoney(self.eventItemId)

			if itemNum > 0 then
				UIManager.showConfirmWithId(1040, Functor(CurAvatar.activityRPC, CurAvatar, Functor(RPC.opActMonopolyUseItem, self.actObj.opId, self.eventItemId), self.actObj.opId))
			else
				MsgManager.clientNotice(404)
			end
		end
	end
end

function ActivityMonopoly2MainDlg:onClickNmlDice()
	if self:checkChooseGrid(true) then
		return
	end

	if ClientUtils.getMoney(self.miscData.normal_id) > 0 then
		CurAvatar:activityRPC(Functor(RPC.monopolyRoll, self.actObj.opId, "kDiceTypeNormal", 0), self.actObj.opId)
		self.btnNumDice:setVisible(false)
		self.btnChoosenDice:setVisible(false)
		self.toggleSkipAni:setVisible(false)
	else
		local fakeItem = BaseObject.GetObject(self.miscData.normal_id)

		UIManager.getUI("itemTips"):showObj(self.mWindow, fakeItem, {
			AutoOpenGuide = 1
		})
	end
end

function ActivityMonopoly2MainDlg:onClickTips()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_MONOPOLY)
end

function ActivityMonopoly2MainDlg:onClickBuyNmlDice()
	local fakeItem = BaseObject.GetObject(self.miscData.normal_id)

	UIManager.getUI("itemTips"):showObj(self.mWindow, fakeItem, {
		AutoOpenGuide = 1
	})
end

function ActivityMonopoly2MainDlg:onChooseDice(chooseNum)
	self.btnNumDice:setVisible(false)
	self.toggleSkipAni:setVisible(false)
	self.btnChoosenDice:setVisible(false)
	CurAvatar:activityRPC(Functor(RPC.monopolyRoll, self.actObj.opId, "kDiceTypeRemote", chooseNum), self.actObj.opId)
end

function ActivityMonopoly2MainDlg:onClickChooseDice()
	if self:checkChooseGrid(true) then
		return
	end

	if ClientUtils.getMoney(self.miscData.luck_id) > 0 then
		local function ShowChooseDice()
			local activityChooseDiceDlg = UIManager.getUI("activityChooseDiceDlg", true)
			local speEvent

			if self.rollOne then
				speEvent = 3
			elseif self.rollDouble then
				speEvent = 1
			elseif self.rollHalf then
				speEvent = 2
			end

			activityChooseDiceDlg:onShow(speEvent, Slot(self.onChooseDice, self), self)
		end

		if self.rollOne then
			UIManager.showConfirmWithId(1041, ShowChooseDice)
		else
			ShowChooseDice()
		end
	else
		local fakeItem = BaseObject.GetObject(self.miscData.luck_id)

		UIManager.getUI("itemTips"):showObj(self.mWindow, fakeItem, {
			AutoOpenGuide = 1
		})
	end
end

function ActivityMonopoly2MainDlg:onClickBuyChooseDice()
	local fakeItem = BaseObject.GetObject(self.miscData.luck_id)

	UIManager.getUI("itemTips"):showObj(self.mWindow, fakeItem, {
		AutoOpenGuide = 1
	})
end

function ActivityMonopoly2MainDlg:moveTo(dstGridPos, moveTime)
	local dstPos = self.gridPos[dstGridPos]

	if dstPos then
		self.tweenComFlag:UITweenMove(Vector3(dstPos.x, dstPos.y, 0), moveTime, nil)
	end
end

function ActivityMonopoly2MainDlg:updateActivityData(actObj)
	return
end

function ActivityMonopoly2MainDlg:onOpActMonopolySetLibAwardResp()
	for index, grid in ipairs(self.grids) do
		if grid.gridData and grid.gridData.lib_id and grid.setData then
			grid:setData(self.actObj.actData:getMonopolyGridLevel(index))
		end
	end
end

function ActivityMonopoly2MainDlg:onOpActMonopolyUseItemResp()
	self:_refreshBuff()
	self:_refreshDiceNum()
end

function ActivityMonopoly2MainDlg:onMonopolyRollResp(rollType, point, move_to, pass_award, endIndex)
	if self.coOnRollAction then
		coroutine.stop(self.coOnRollAction)

		self.coOnRollAction = nil
	end

	if self.diceModelInst then
		self.modelStage:delModel(self.diceModelInst)

		self.diceModelInst = nil
	end

	self.rollResult = {}
	self.rollResult.startPos = self.actObj.actData.curPos
	self.rollResult.point = point
	self.rollResult.move_to = move_to

	local passAwards = {}

	for _, pInfo in ipairs(pass_award) do
		passAwards[pInfo.index] = pInfo.awards
	end

	self.rollResult.passAwards = passAwards
	self.rollResult.endIndex = endIndex

	self.modelStage:connectImage(self.modelViewport)

	if rollType == "kDiceTypeNormal" then
		self.modelStage:showModelByModelData(self.miscData.normal_model, nil, nil, nil, 1, 1, self._slot4DiceModelReady)
	else
		self.modelStage:showModelByModelData(self.miscData.luck_model, nil, nil, nil, 1, 1, self._slot4DiceModelReady)
	end
end

function ActivityMonopoly2MainDlg:onDiceModelReady(diceModelInst)
	self.diceModelInst = diceModelInst

	local modelAux = self.modelStage:getModel(diceModelInst)

	if modelAux then
		self.modelViewport:setVisible(true)

		self.rollerMgr = modelAux.gameObject:GetComponent(typeof(GamePlay.DiceRoller))
		self.coOnRollAction = coroutine.start(self.coRollAction, self)
	end
end

local RUN_GRID_TIME = 0.5
local HIDE_GRID_TIME = 0.25

function ActivityMonopoly2MainDlg:coRollAction()
	if self.toggleSkipAni:isOn() or self.rollOne then
		if not self.skipAni and self.toggleSkipAni:isOn() then
			self.skipAni = true

			UserData.saveCommonData(self.userDataKey, "1")
		end

		self.rollerMgr:RollDiceImmediate(self.rollResult.point)
		coroutine.wait(0.3)
	else
		if self.skipAni then
			self.skipAni = false

			UserData.saveCommonData(self.userDataKey, "0")
		end

		CueManager.playVocal(1548)
		self.rollerMgr:RollDice(self.rollResult.point)
		coroutine.wait(1.6)
	end

	local nowIndex = self.rollResult.startPos
	local tIndex = self.rollResult.move_to.index

	for index = 1, MAX_GRID_NUM do
		local newIdx = nowIndex + index

		if newIdx > MAX_GRID_NUM then
			newIdx = newIdx - MAX_GRID_NUM
		end

		self.aniChess:startAni("ChessMove", true)
		self:moveTo(newIdx, RUN_GRID_TIME)
		coroutine.wait(RUN_GRID_TIME)

		if newIdx == tIndex then
			break
		elseif self.rollResult.passAwards[newIdx] then
			local grid = self.grids[newIdx]

			if grid and grid.onPassAwards then
				grid:onPassAwards(self.rollResult.passAwards[newIdx])
			end

			self:onShowBonus(self.rollResult.passAwards[newIdx])
		end
	end

	self.coOnRollAction = nil

	self:onCheckEvent()
end

function ActivityMonopoly2MainDlg:onCheckEvent()
	local gridData = self.actObj.actData.clientData[self.rollResult.move_to.index]
	local eventData = ResActivityDetailMonopolyEvent[self.rollResult.move_to.event_id]

	if gridData and gridData.event and eventData then
		local eventDesc = eventData.desc or ""

		if eventData.event_type == 4 then
			local gridNum = self.rollResult.move_to.index - self.rollResult.endIndex

			if gridNum < 0 then
				gridNum = gridNum + MAX_GRID_NUM
			end

			eventDesc = string.format(eventDesc, gridNum)
		end

		if #gridData.event == 1 then
			if eventData.event_type == 4 then
				UIManager.getUI("activityMonopolyBadLuckDlg", true):onShow(eventData, eventDesc, self._slot4DestAction)
			else
				UIManager.getUI("activityMonopolyGoodLuckDlg", true):onShow(eventData, eventDesc, self._slot4DestAction)
			end
		else
			local eventNum = #ClientUtils.getBitsListFromByteString(self.rollResult.move_to.data.event_status)

			eventNum = #gridData.event - eventNum + 1

			UIManager.getUI("activityMonopolyEventDlg", true):onShow(eventData, eventDesc, eventNum, self._slot4DestAction)
		end
	else
		self:onDstAction()
	end
end

function ActivityMonopoly2MainDlg:onDstAction()
	self.coOnRollAction = coroutine.start(self.coDstAction, self)
end

function ActivityMonopoly2MainDlg:coDstAction()
	local tIndex = self.rollResult.move_to.index
	local grid = self.grids[tIndex]

	if grid then
		if grid.gridLevel and grid.gridLevel ~= self.rollResult.move_to.data.level then
			grid:setData(self.rollResult.move_to.data.level)
		end

		grid:onCheckDelay(self.rollResult.move_to.awards)
	end

	self:onShowBonus(self.rollResult.move_to.awards)

	if self.rollResult.endIndex ~= tIndex then
		self.aniChess:startAni("ChessHide", true)
		coroutine.wait(HIDE_GRID_TIME)
		self:moveTo(self.rollResult.endIndex, 0)
		self.aniChess:startAni("ChessShow", true)
	end

	self.btnNumDice:setVisible(true)
	self.toggleSkipAni:setVisible(true)
	self.btnChoosenDice:setVisible(true)
	self.modelViewport:setVisible(false)
	self:_refreshDiceNum()
	self:_refreshBuff()

	for index, grid in ipairs(self.grids) do
		if grid.gridData and grid.gridData.lib_id and grid.setData then
			grid:setData(self.actObj.actData:getMonopolyGridLevel(index))
		end
	end
end

function ActivityMonopoly2MainDlg:onShowBonus(bonus)
	table.insert(self.bonusCache, bonus)

	if not self.timerBonus:IsRunning() then
		self:_onShowBonus()
	end
end

function ActivityMonopoly2MainDlg:_onShowBonus()
	if self.bonusCache[1] then
		local bonus = table.remove(self.bonusCache, 1)
		local itInfo = bonus[1]

		if itInfo then
			local itIcon = BaseObject.getItemIconPath(itInfo.id)

			if itIcon then
				self.imgGet:setImage(itIcon[1], itIcon[2])
			end

			self.textGetNum:setText(ClientUtils.getNumShortStr(itInfo.num))
			self.aniGet:setVisible(true)
			self.aniGet:startAni("ShowAwardPanel", true)
		end

		self.timerBonus:Restart()
	end
end

function ActivityMonopoly2MainDlg:onGridClick(stepData)
	if stepData.lib_id then
		UIManager.getUI("activityMonopolyAwardChooseDlg", true):onShow(self.actObj, stepData.lib_id, self)

		return
	end

	if stepData then
		self.panelGridInfo:setData(stepData)
		self.btnSensor:setVisible(true)
		self.panelGridInfo:setVisible(true)
	end
end

function ActivityMonopoly2MainDlg:onClickSensor()
	self.btnSensor:setVisible(false)
	self.panelGridInfo:setVisible(false)
end

function ActivityMonopoly2MainDlg:onMonopolyExchangeResp()
	self:_refreshDiceNum()
end

function ActivityMonopoly2MainDlg:destroy()
	if self.coOnRollAction then
		coroutine.stop(self.coOnRollAction)

		self.coOnRollAction = nil
	end

	if self.receiveWaitActId then
		CurAvatar:jumpToShowActivity(self.receiveWaitActId)
	end

	if self.actObj.actData.miscData and self.actObj.actData.miscData.normal_id then
		CurAvatar:unregisterItemChangedCallBack(self.actObj.actData.miscData.normal_id, self.slotForRefreshDice)
	end

	if self.actObj.actData.miscData and self.actObj.actData.miscData.luck_id then
		CurAvatar:unregisterItemChangedCallBack(self.actObj.actData.miscData.luck_id, self.slotForRefreshDice)
	end

	self.timerBonus:Stop()
	ActivityMonopoly2MainDlg.super.destroy(self)
end

return ActivityMonopoly2MainDlg
