-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityMonopolyMainDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRandClient = require("ClientData/ResRandClient")
local ResActivityDetailMonopolyEvent = require("ClientData/ResActivityDetailMonopolyEvent")
local BaseObject = require("Common/Object/BaseObject")
local ResItem = require("ClientData/ResItem")
local UserData = require("Helper/UserData")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local ActivityMonopolyBonusRecordPanel = Class("ActivityMonopolyBonusRecordPanel", UIControls.Panel)

function ActivityMonopolyBonusRecordPanel:ctor()
	self:initUI()
end

function ActivityMonopolyBonusRecordPanel:initUI()
	self.imgRecord1 = UIControls.Image(self, self.mPath .. "/GetPanel1/Icon")
	self.textRecord1 = UIControls.Label(self, self.mPath .. "/GetPanel1/TextNum")
	self.imgRecord2 = UIControls.Image(self, self.mPath .. "/GetPanel2/Icon")
	self.textRecord2 = UIControls.Label(self, self.mPath .. "/GetPanel2/TextNum")
end

function ActivityMonopolyBonusRecordPanel:setData(recordInfo)
	if recordInfo[1] then
		local item1Path = BaseObject.getItemIconPath(recordInfo[1][1])

		if item1Path then
			self.imgRecord1:setImage(item1Path[1], item1Path[2])
		end

		self.textRecord1:setText(recordInfo[1][2])
	end

	if recordInfo[2] then
		local item2Path = BaseObject.getItemIconPath(recordInfo[2][1])

		if item2Path then
			self.imgRecord2:setImage(item2Path[1], item2Path[2])
		end

		self.textRecord2:setText(recordInfo[2][2])
	end
end

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

				self.bonusId = ids[1]

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

	if self.bonusId then
		self.mParent:onCheckBonus(self.bonusId)
	end
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
	self.effLevelUp:setVisible(false)
	self.effLevelUp:setVisible(true)
	self.mParent:playGetStarFlyEffect(self, bonus[1].id, bonus[1].num)
end

function ActivityMonopolyStarGrid:onCheckDelay(bonus)
	self.effLevelUp:setVisible(false)
	self.effLevelUp:setVisible(true)
	self.mParent:playGetStarFlyEffect(self, bonus[1].id, bonus[1].num)
end

local GRID_TYPE_NML = 1
local GRID_TYPE_EVENT = 2
local GRID_TYPE_PASS = 3
local MAX_GRID_NUM = 20
local DOTweenComponent = typeof(Framework.EffectSystem.DOTweenComponent)
local strClassName = "ActivityMonopolyMainDlg"
local ActivityMonopolyMainDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityMonopolyMainDlg, ActivityPanelMixin)

function ActivityMonopolyMainDlg:initUI()
	self.textRule = UIControls.Label(self, "MainInfoPanel/TextRule")
	self.textTime = UIControls.Label(self, "MainInfoPanel/TextTime")
	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onClickTips)

	self.panelStart = UIControls.Panel(self, "MainInfoPanel/GridPanel/GridStart")
	self.aniChess = UIControls.UIAni(self, "MainInfoPanel/GridPanel/ImgChess")
	self.tweenComFlag = self.aniChess:getGameObject():GetComponent(DOTweenComponent)
	self.btnAchieve = UIControls.Button(self, "MainInfoPanel/BtnAchi")

	self.btnAchieve:addEventClick(self.onClickAchieve)

	self.imgAchieveItem = UIControls.Image(self, "MainInfoPanel/BtnAchi/Slider/Fill/Icon")
	self.sliderAchieve = UIControls.Slider(self, "MainInfoPanel/BtnAchi/Slider")
	self.textAchieve = UIControls.Label(self, "MainInfoPanel/BtnAchi/TextNum")
	self.gridsAchieve = {}
	self.btnStore = UIControls.Button(self, "MainInfoPanel/BtnStore")

	self.btnStore:addEventClick(self.onClickStore)

	self.btnNumDice = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnDiceNml", "TextName")

	self.btnNumDice:addEventClick(self.onClickNmlDice)

	self.textNmlDiceNum = UIControls.Label(self, "MainInfoPanel/FuncPanel/BtnDiceNml/TextNum")
	self.btnBuyNmlDice = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnDiceNml/BtnBuy")

	self.btnBuyNmlDice:addEventClick(self.onClickBuyNmlDice)

	self.imgNmlDiceBuff = UIControls.Image(self, "MainInfoPanel/FuncPanel/BtnDiceNml/SpPanel")
	self.btnChoosenDice = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnDiceSpe", "TextName")

	self.btnChoosenDice:addEventClick(self.onClickChooseDice)

	self.textChooseDiceNum = UIControls.Label(self, "MainInfoPanel/FuncPanel/BtnDiceSpe/TextNum")
	self.imgChooseDiceBuff = UIControls.Image(self, "MainInfoPanel/FuncPanel/BtnDiceSpe/SpPanel")
	self.btnBuyChooseDice = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnDiceSpe/BtnBuy")

	self.btnBuyChooseDice:addEventClick(self.onClickBuyChooseDice)

	self.aniGet = UIControls.UIAni(self, "MainInfoPanel/GetPanel")
	self.imgGet = UIControls.Image(self, "MainInfoPanel/GetPanel/Icon")
	self.textGetNum = UIControls.Label(self, "MainInfoPanel/GetPanel/TextNum")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnClose)

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
					self.grids[index] = ActivityMonopolyNormalGrid(self, "MainInfoPanel/GridPanel/Grid" .. index, GridPath .. "/GridMonopolyNml")
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

	if self.replaceableCellPath and self.replaceableCellPath[2] then
		self.eventAtlas = "Atlas/ActivityAtlas/" .. self.replaceableCellPath[2]
	end

	self.panelSpecialBonus = UIControls.Panel(self, "MainInfoPanel/SpeAwardPanel")
	self.titleSpecialBonus = UIControls.Label(self, "MainInfoPanel/SpeAwardPanel/TextTitle")
	self.descSpecialBonus = UIControls.Label(self, "MainInfoPanel/SpeAwardPanel/TextDes")
	self.gridsSpecialBonus = {}
	self.btnRecord = UIControls.Button(self, "MainInfoPanel/BtnRecord")

	self.btnRecord:addEventClick(self.onRecordClick)

	self.aniRecord = UIControls.UIAni(self, "MainInfoPanel/BtnRecord/DecPanel")

	if self.actObj.actData.miscData and self.actObj.actData.miscData.record_items then
		self.btnRecord:setVisible(true)
	else
		self.btnRecord:setVisible(false)
	end

	self.panelRecord = ActivityMonopolyBonusRecordPanel(self, "MainInfoPanel/RecordInfoPanel")

	if UIControls.checkControlFunc(self, "MainInfoPanel/GiftPushPanel") then
		self.panelPushGift = UIControls.Panel(self, "MainInfoPanel/GiftPushPanel")
		self.btnPushGift = UIControls.Button(self, "MainInfoPanel/GiftPushPanel/BgTalk/BtnGift")

		self.btnPushGift:addEventClick(self.onPushGiftClick)

		self.rdPushGift = UIControls.RedDot(self, "MainInfoPanel/GiftPushPanel/BgTalk/BtnGift/IconNew")
	end
end

function ActivityMonopolyMainDlg:onOpen()
	ActivityMonopolyMainDlg.super.onOpen(self)

	if self.miscData then
		self:_refreshDiceNum()
	end
end

function ActivityMonopolyMainDlg:_setData()
	for index, grid in ipairs(self.grids) do
		if grid.gridData.max_level and grid.gridData.max_level > 1 then
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
	self:refreshAchieveState()
	self:checkAchieveBigBonus()
end

function ActivityMonopolyMainDlg:_refreshDiceNum()
	self.textNmlDiceNum:setText(ClientUtils.getMoney(self.miscData.normal_id))
	self.textChooseDiceNum:setText(ClientUtils.getMoney(self.miscData.luck_id))
end

function ActivityMonopolyMainDlg:_refreshBuff()
	self.eventData = self.actObj.actData:getNowEventData()

	local starDouble = self.eventData and self.eventData.event_type == 2

	for _, grid in ipairs(self.grids) do
		if grid.onBonusDouble then
			grid:onBonusDouble(starDouble)
		end
	end

	self.rollDouble = false
	self.rollHalf = false

	if self.eventData and self.eventData.event_type == 5 then
		if self.eventData.param1 < 10000 then
			self.rollHalf = true
		else
			self.rollDouble = true
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
end

function ActivityMonopolyMainDlg:refreshRealPanel()
	return
end

function ActivityMonopolyMainDlg:onBtnClose()
	self:setVisible(false)
	self:recoverManualReject()
end

function ActivityMonopolyMainDlg:onClickAchieve()
	local clientTemplateData = self.actObj.clientTemplateData
	local args = clientTemplateData.template_args

	if args and tonumber(args[1]) then
		local achieveActObj = CurAvatar:getActivityObj(tonumber(args[1]))

		if achieveActObj and achieveActObj.actData and achieveActObj.actData.clientFakeRound then
			UIManager.getUI("activityMonopolyAchievePageDlg", true):onInitActObj(self.actObj, {
				achieveActObj.clientTemplateData,
				achieveActObj
			})
		elseif achieveActObj then
			UIManager.getUI("activityMonopolyAchieveDlg", true):onShowActivity({
				achieveActObj.clientTemplateData,
				achieveActObj
			})
		end
	end
end

function ActivityMonopolyMainDlg:checkPushGift()
	if self.panelPushGift then
		local relateGiftActId = self.actObj.templateData.relate_act and self.actObj.templateData.relate_act[1]
		local giftObj = CurAvatar:getActivityObj(relateGiftActId)
		local valid = giftObj and giftObj:isValid() and giftObj.actData:hasValidProduct()
		local preState = self.pushGiftState

		if valid then
			self.panelPushGift:setVisible(true)

			self.pushGiftState = true
		else
			self.panelPushGift:setVisible(false)

			self.pushGiftState = false
		end

		if preState == false and self.pushGiftState == true then
			self:onPushGiftClick()
		end

		if giftObj and giftObj.redDotId then
			self.rdPushGift:addHint({
				giftObj.redDotId
			})
		else
			self.rdPushGift:clearHint()
		end
	end
end

function ActivityMonopolyMainDlg:onPushGiftClick()
	local relateGiftActId = self.actObj.templateData.relate_act and self.actObj.templateData.relate_act[1]

	if relateGiftActId then
		CurAvatar:jumpToShowActivity(relateGiftActId)
	end
end

local SUPER_AWARD_DESC = Lang.get(45568)

function ActivityMonopolyMainDlg:checkAchieveBigBonus()
	local showBonus, showRound
	local hasGot = false
	local clientTemplateData = self.actObj.clientTemplateData
	local args = clientTemplateData.template_args

	if args and tonumber(args[1]) then
		local achieveActObj = CurAvatar:getActivityObj(tonumber(args[1]))

		if achieveActObj and achieveActObj.actData and achieveActObj.actData.clientFakeRound then
			local achieveActData = achieveActObj.actData
			local svrData

			for _, sData in pairs(achieveActData.serverData) do
				svrData = sData
			end

			local clientData = {}

			for achieveType, cData in pairs(achieveActData.clientData) do
				clientData = cData

				break
			end

			local pro = svrData and svrData.progress or 0

			for round, roundInfo in ipairs(achieveActData.clientFakeRound) do
				if roundInfo.super_award_flag then
					showRound = round
					showBonus = roundInfo.bonus_id

					local eIndex = roundInfo.detail_index
					local indexData = clientData[eIndex]

					if indexData and indexData.param and pro >= indexData.param then
						hasGot = true
					else
						hasGot = false

						break
					end
				end
			end
		end
	end

	if showBonus then
		self.panelSpecialBonus:setVisible(true)

		local itemId = ResRandClient[showBonus].show_ids[1]
		local item = BaseObject.GetObject(itemId, 1)
		local name = item.name or ""
		local tDesc = string.gsub(SUPER_AWARD_DESC, "$1", showRound)

		tDesc = string.gsub(tDesc, "$2", name)

		self.titleSpecialBonus:setText(name)
		self.descSpecialBonus:setText(tDesc)
		ClientUtils.CreateBonusGrid(self, self.gridsSpecialBonus, "MainInfoPanel/SpeAwardPanel/GridPanel", showBonus, true, 1, true)

		for _, grid in ipairs(self.gridsSpecialBonus) do
			grid:setGet(hasGot)
		end
	else
		self.panelSpecialBonus:setVisible(false)
	end
end

function ActivityMonopolyMainDlg:refreshAchieveState()
	if not self.achieveActObj then
		local clientTemplateData = self.actObj.clientTemplateData
		local args = clientTemplateData.template_args

		if args and tonumber(args[1]) then
			self.achieveActObj = CurAvatar:getActivityObj(tonumber(args[1]))
		end
	end

	if self.achieveActObj then
		local nData, hasProgress, levelRate, preRoundProgress = self.achieveActObj.actData:getNextAchieveInfo()

		if nData then
			local needProgress = nData.param - preRoundProgress

			if self.preNeedProgress and self.preNeedProgress ~= needProgress then
				self:onPlayGetAchieveAnim()
			end

			self.preNeedProgress = needProgress

			if needProgress and needProgress > 0 then
				self.textAchieve:setText(hasProgress .. "/" .. needProgress)
				self.sliderAchieve:setValue(levelRate)
			end

			ClientUtils.CreateBonusGrid(self, self.gridsAchieve, "MainInfoPanel/BtnAchi/GridAward", nData.award, true, 1, true)

			if self.gridsAchieve[1] then
				if levelRate >= 1 then
					self.gridsAchieve[1]:setGet(true)
				else
					self.gridsAchieve[1]:setGet(false)
				end
			end
		end
	end

	self:checkPushGift()
end

function ActivityMonopolyMainDlg:onPlayGetAchieveAnim()
	self.aniGetAchieve:setVisible(true)
	self.aniGetAchieve:startAni("FlashAchiEntry", true)
end

function ActivityMonopolyMainDlg:onClickStore()
	UIManager.getUI("activityMallDlg", true)
end

function ActivityMonopolyMainDlg:onClickNmlDice()
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

function ActivityMonopolyMainDlg:onRecordClick()
	self.panelRecord:setData(self.actObj.actData:getRecordInfo())
	self.panelRecord:setVisible(true)
	self.btnSensor:setVisible(true)
end

function ActivityMonopolyMainDlg:onClickTips()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_MONOPOLY)
end

function ActivityMonopolyMainDlg:onClickBuyNmlDice()
	local fakeItem = BaseObject.GetObject(self.miscData.normal_id)

	UIManager.getUI("itemTips"):showObj(self.mWindow, fakeItem, {
		AutoOpenGuide = 1
	})
end

function ActivityMonopolyMainDlg:onChooseDice(chooseNum)
	self.btnNumDice:setVisible(false)
	self.toggleSkipAni:setVisible(false)
	self.btnChoosenDice:setVisible(false)
	CurAvatar:activityRPC(Functor(RPC.monopolyRoll, self.actObj.opId, "kDiceTypeRemote", chooseNum), self.actObj.opId)
end

function ActivityMonopolyMainDlg:onClickChooseDice()
	if ClientUtils.getMoney(self.miscData.luck_id) > 0 then
		local activityChooseDiceDlg = UIManager.getUI("activityChooseDiceDlg", true)
		local speEvent

		if self.rollDouble then
			speEvent = 1
		elseif self.rollHalf then
			speEvent = 2
		end

		activityChooseDiceDlg:onShow(speEvent, Slot(self.onChooseDice, self), self)
	else
		local fakeItem = BaseObject.GetObject(self.miscData.luck_id)

		UIManager.getUI("itemTips"):showObj(self.mWindow, fakeItem, {
			AutoOpenGuide = 1
		})
	end
end

function ActivityMonopolyMainDlg:onClickBuyChooseDice()
	local fakeItem = BaseObject.GetObject(self.miscData.luck_id)

	UIManager.getUI("itemTips"):showObj(self.mWindow, fakeItem, {
		AutoOpenGuide = 1
	})
end

function ActivityMonopolyMainDlg:moveTo(dstGridPos, moveTime)
	local dstPos = self.gridPos[dstGridPos]

	if dstPos then
		self.tweenComFlag:UITweenMove(Vector3(dstPos.x, dstPos.y, 0), moveTime, nil)
	end
end

function ActivityMonopolyMainDlg:updateActivityData(actObj)
	return
end

function ActivityMonopolyMainDlg:onMonopolyRollResp(rollType, point, move_to, pass_award, endIndex)
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

function ActivityMonopolyMainDlg:onDiceModelReady(diceModelInst)
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

function ActivityMonopolyMainDlg:coRollAction()
	if self.toggleSkipAni:isOn() then
		if not self.skipAni then
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

function ActivityMonopolyMainDlg:playGetStarFlyEffect(grid, itId, itNum)
	FlyIconUtils.setFlyUItoUI(grid, self.imgAchieveItem, itId, itNum, 1.5)
end

function ActivityMonopolyMainDlg:onCheckEvent()
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

function ActivityMonopolyMainDlg:onDstAction()
	self.coOnRollAction = coroutine.start(self.coDstAction, self)
end

function ActivityMonopolyMainDlg:coDstAction()
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
	self:refreshAchieveState()
	self:checkAchieveBigBonus()
end

function ActivityMonopolyMainDlg:onShowBonus(bonus)
	table.insert(self.bonusCache, bonus)

	if not self.timerBonus:IsRunning() then
		self:_onShowBonus()
	end
end

function ActivityMonopolyMainDlg:_onShowBonus()
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

function ActivityMonopolyMainDlg:onGridClick(stepData)
	if stepData then
		self.panelGridInfo:setData(stepData)
		self.btnSensor:setVisible(true)
		self.panelGridInfo:setVisible(true)
	end
end

function ActivityMonopolyMainDlg:onCheckBonus(itemId)
	if self.actObj.actData:isRecordItem(itemId) then
		self.aniRecord:startAni("NoticeAwardRecord")
	end
end

function ActivityMonopolyMainDlg:onClickSensor()
	self.btnSensor:setVisible(false)
	self.panelGridInfo:setVisible(false)
	self.panelRecord:setVisible(false)
end

function ActivityMonopolyMainDlg:onMonopolyExchangeResp()
	self:_refreshDiceNum()
end

function ActivityMonopolyMainDlg:destroy()
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
	ActivityMonopolyMainDlg.super.destroy(self)
end

return ActivityMonopolyMainDlg
