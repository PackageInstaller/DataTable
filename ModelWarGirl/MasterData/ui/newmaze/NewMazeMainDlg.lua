-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeMainDlg.lua

local NewMazeBaseFunc = require("UI/NewMaze/NewMazeBaseFunc")
local NewMazeRollerInfoPanel = require("UI/NewMaze/NewMazeRollerInfoPanel")
local NewMazeLosderTipsInfoPanel = require("UI/NewMaze/NewMazeLosderTipsInfoPanel")
local NewMazeLosderGrid = require("UI/NewMaze/NewMazeLosderGrid")
local NewMazeLosderMixin = require("UI/NewMaze/NewMazeLosderMixin")
local ResNewMazeNode = require("ClientData/ResNewMazeNode")
local HeroCharacterGrid = require("UI/NewMaze/HeroCharacterGrid")
local CharacterTipsPanel = require("UI/NewMaze/CharacterTipsPanel")
local ResNewMazeDeBuff = require("ClientData/ResNewMazeDeBuff")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local ResNewMazeTreasure = require("ClientData/ResNewMazeTreasure")
local ResColor = require("ClientData/ResColor")
local DOTweenComponent = typeof(Framework.EffectSystem.DOTweenComponent)
local NewMazeMainBuffGrid = Class("NewMazeMainBuffGrid", UIControls.Child)

function NewMazeMainBuffGrid:ctor(...)
	self:initUI()
end

function NewMazeMainBuffGrid:initUI()
	self.iconBuff = UIControls.Image(self, "Icon")
	self.textNum = UIControls.Label(self, "TextNum")
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onBuffGridClick)
end

function NewMazeMainBuffGrid:setData(serverBuffData)
	self.buffId = serverBuffData.id
	self.buffNum = serverBuffData.canUseCount
	self.buffData = ResNewMazeDeBuff[self.buffId]

	self.iconBuff:setImage(self.buffData.icon_path, self.buffData.icon_name)
	self.textNum:setText(self.buffNum .. "/" .. (self.buffData.max_use_count or 1))
end

function NewMazeMainBuffGrid:onBuffGridClick()
	self.mParent:onBuffGridClick(self)
end

function NewMazeMainBuffGrid:setSelected(isSelected)
	if isSelected then
		self:playAni("GridRogueBuffSel")
	else
		self:playAni("GridRogueBuffNml")
	end
end

local strClassName = "EventItem"
local EventItem = Class(strClassName, UIControls.Child)

function EventItem:ctor(...)
	self:initUI()
end

function EventItem:initUI()
	self.btnEvent = UIControls.Button(self, "BtnEvent")

	self.btnEvent:addEventClick(self.onBtnEventClick)

	self.bgEvent = UIControls.Image(self, "BtnEvent/BgEvent")
	self.bgTextEvent = UIControls.Image(self, "BtnEvent/BgTextEvent")
	self.textEvent = UIControls.Image(self, "BtnEvent/BgTextEvent/TextEvent")
	self.iconEvent = UIControls.RawImage(self, "BtnEvent/Mask/IconEvent")
	self.bgDis = UIControls.Image(self, "BtnEvent/BgDis")
	self.deBuffPanel = UIControls.Panel(self, "BtnEvent/DeBuffPanel")
	self.iconDeBuff = UIControls.Image(self, "BtnEvent/DeBuffPanel/IconDeBuff")
	self.btnEvent1 = UIControls.Button(self, "BtnEvent1")

	self.btnEvent1:addEventClick(self.onBtnEvent1Click)

	self.panelCareerEvent = UIControls.Panel(self, "BtnEvent/CareerPanel")
	self.imgCareerEvent = UIControls.Image(self, "BtnEvent/CareerPanel/Icon")
end

function EventItem:setData(eventType, nodeData, index)
	self.eventType = eventType

	if self.eventType == Const.NEW_MAZE_EVENT_ITEM_TYPE_NORMAL then
		self.btnEvent:setVisible(true)
		self.btnEvent1:setVisible(false)

		self.nodeData = nodeData
		self.index = index

		local node = self.mParent.nodeTableData[nodeData.node_id]
		local typeNum = Const.NEW_MAZE_NODE_EVENT_NAME[self.nodeData.node_type][2] or 1

		self.textEvent:setImage("Atlas/RogueAtlas/RougeMainAtlas01", "TxtEvent0" .. typeNum)

		if self.mParent.levelType == 2 and utils.tableIsContainsElement(Const.NEW_MAZE_BATTLE_EVENT, self.nodeData.node_type) then
			self.iconEvent:setImage("NoAlpha/Rogue/BgPoltCard0" .. typeNum)
		elseif self.nodeData.node_type == Const.NEW_MAZE_NODE_EVENT_TYPE.Award then
			self.eventId = nodeData.spec_id

			local quality = ResNewMazeTreasure[self.eventId].quality
			local num = quality - 1 + typeNum

			self.iconEvent:setImage("NoAlpha/Rogue/BgPoltCard" .. num)
		else
			self.iconEvent:setImage("NoAlpha/Rogue/BgPoltCard" .. typeNum)
		end

		if self.mParent.alreadyChooseNode and self.mParent.curSelectNodeIndex ~= index then
			self.bgDis:setVisible(true)
			self.btnEvent:setEnable(false)
		else
			self.bgDis:setVisible(false)
			self.btnEvent:setEnable(true)
		end

		if nodeData.tag_id and nodeData.tag_id > 0 then
			self.panelCareerEvent:setVisible(true)
			self.imgCareerEvent:setImage("Atlas/RogueAtlas/RougeMainAtlas03", "IconCareer0" .. nodeData.tag_id)
		else
			self.panelCareerEvent:setVisible(false)
		end

		if self.mParent.newMazeData.nextFightBuff and utils.tableIsContainsElement(Const.NEW_MAZE_BATTLE_EVENT, self.nodeData.node_type) then
			self.deBuffPanel:setVisible(true)

			local buffId = self.mParent.newMazeData.nextFightBuff

			if ResNewMazeDeBuff[buffId] then
				self.iconDeBuff:setImage(ResNewMazeDeBuff[buffId].icon_path, ResNewMazeDeBuff[buffId].icon_name)
			end
		else
			self.deBuffPanel:setVisible(false)
		end
	else
		self.btnEvent:setVisible(false)
		self.btnEvent1:setVisible(true)
	end
end

function EventItem:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function EventItem:onBtnEventClick()
	if self.selectCallback then
		self.selectCallback(self)
	end
end

function EventItem:onBtnEvent1Click()
	MsgManager.notice(ResNewMazeDisplay[13060052].desc)
end

local strClassName = "NewMazeMainDlg"
local NewMazeMainDlg = Class(strClassName, NewMazeBaseFunc)

MixinClass(NewMazeMainDlg, NewMazeLosderMixin)

local FORWARD_TIME = 1.67
local REVERSAL_TIME = 1.67
local IDLE_TO_TURN_TIME = 0.3

function NewMazeMainDlg:ctor(...)
	self:ctorMixin()
	self:initUI()
end

function NewMazeMainDlg:initUI()
	NewMazeMainDlg.super.initUI(self)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnPreviewBoss = UIControls.Button(self, "MainInfoPanel/RoguePanel/BtnBossPreview")

	self.btnPreviewBoss:addEventClick(self.onBtnBossPreview)
	self.btnPreviewBoss:setVisible(Const.NEW_MAZE_ITERATION_OPEN == true)

	self.textHallowNum = UIControls.Label(self, "MainInfoPanel/FuncPanel/BtnHallow/TextNum")
	self.textHeroNum = UIControls.Label(self, "MainInfoPanel/FuncPanel/BtnHero/TextNum")
	self.textHaloNum = UIControls.Label(self, "MainInfoPanel/FuncPanel/BtnHalo/TextNum")
	self.btnHallow = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnHallow")

	self.btnHallow:addEventClick(self.onBtnHallowClick)

	self.btnHero = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnHero")

	self.btnHero:addEventClick(self.onBtnHeroClick)

	self.iconHeroNew = UIControls.RedDot(self, "MainInfoPanel/FuncPanel/BtnHero/IconNew")

	self.iconHeroNew:addHint({
		UIConst.RD_HINT_NEW_MAZE_HERO_PREVIEW
	})

	self.imgTheme = UIControls.Image(self, "MainInfoPanel/RoguePanel/ImgTheme")
	self.btnReset = UIControls.Button(self, "MainInfoPanel/RoguePanel/BtnReset")

	self.btnReset:addEventClick(self.onBtnResetClick)

	self.btnStoreLv = UIControls.Button(self, "MainInfoPanel/RoguePanel/BtnStoreLv")

	self.btnStoreLv:addEventClick(self.onBtnStoreLvClick)

	self.expSlider = UIControls.Slider(self, "MainInfoPanel/RoguePanel/BtnStoreLv/Slider")
	self.textProgress = UIControls.Label(self, "MainInfoPanel/RoguePanel/BtnStoreLv/Slider/TextProgress")
	self.textShopLv = UIControls.Label(self, "MainInfoPanel/RoguePanel/BtnStoreLv/TextTltile/TextLv")
	self.imageReset = UIControls.Image(self, "MainInfoPanel/RoguePanel/BtnReset")
	self.textLayerNum = UIControls.Label(self, "MainInfoPanel/RoguePanel/BgTopLayer/TextLayerNum")
	self.bgTopLayer = UIControls.Image(self, "MainInfoPanel/RoguePanel/BgTopLayer")
	self.bgTopLayer1 = UIControls.Image(self, "MainInfoPanel/RoguePanel/BgTopLayer/BgTopLayer1")
	self.eventInfoPanel = UIControls.UIAni(self, "MainInfoPanel/RoguePanel/NodePanel/EventInfoPanel")
	self.btnNext = UIControls.Button(self, "MainInfoPanel/RoguePanel/BtnNext")

	self.btnNext:addEventClick(self.onBtnNextClick)

	self.imgNext = UIControls.Image(self, "MainInfoPanel/RoguePanel/BtnNext")
	self.imgHeroFrame = UIControls.Image(self, "MainInfoPanel/RoguePanel/NodePanel/HeroPuppetPanel/ImgHeroFrame")
	self.tweenComFlag = self.imgHeroFrame:getGameObject():GetComponent(DOTweenComponent)

	if self.tweenComFlag == nil then
		self.tweenComFlag = self.imgHeroFrame:getGameObject():AddComponent(DOTweenComponent)
	end

	self.textHint = UIControls.Label(self, "MainInfoPanel/RoguePanel/BgNowLayer/TextHint")
	self.textGold = UIControls.Label(self, "MainInfoPanel/RoguePanel/BtnGold/TextNum")
	self.btnGold = UIControls.Button(self, "MainInfoPanel/RoguePanel/BtnGold")

	self.btnGold:addEventClick(self.onBtnGoldClick)

	self.textTicketNum = UIControls.Label(self, "MainInfoPanel/RoguePanel/BtnReset/TextNum")
	self.textLayer = UIControls.Label(self, "MainInfoPanel/RoguePanel/BgNowLayer/TextLayer")
	self.textLayer1 = UIControls.Label(self, "MainInfoPanel/RoguePanel/BgNowLayer/TextLayer/TextLayer1")
	self.imgLayer = UIControls.Image(self, "MainInfoPanel/RoguePanel/BgNowLayer/ImgLayer")
	self.textBlood = UIControls.Label(self, "MainInfoPanel/RoguePanel/BtnBlood/TextNum")
	self.btnBlood = UIControls.Button(self, "MainInfoPanel/RoguePanel/BtnBlood")

	self.btnBlood:addEventClick(self.onBtnBloodClick)

	self.btnHalo = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnHalo")

	self.btnHalo:addEventClick(self.onBtnHaloClick)

	self.iconHaloNew = UIControls.RedDot(self, "MainInfoPanel/FuncPanel/BtnHalo/IconNew")

	self.iconHaloNew:addHint({
		UIConst.RD_HINT_NEW_MAZE_HALO_PREVIEW
	})
	RedDotManager.setKeyState(UIConst.RD_HINT_NEW_MAZE_HALO_PREVIEW, false)

	self.characterTipsPanel = CharacterTipsPanel(self, "MainInfoPanel/RoguePanel/BgCharacter/CharacterTipsPanel", "System/Rogue/CharacterTipsInfoPanel")
	self.characterPanel = UIControls.Panel(self, "MainInfoPanel/RoguePanel/BgCharacter/CharacterTipsPanel")
	self.characterClickThrough = UIControls.Button(self, "MainInfoPanel/RoguePanel/BgCharacter/CharacterTipsPanel/UIClickThrough")

	self.characterClickThrough:addEventClick(self.onCharacterClickThroughClick)

	self.emptyPanel = UIControls.Panel(self, "EmptyPanel")
	self.eventItemList = {}
	self.eventPanelList = {}
	self.efxSelList = {}

	for i = 1, 3 do
		local eventPanel = UIControls.Panel(self, "MainInfoPanel/RoguePanel/NodePanel/EventInfoPanel/EventPanel" .. i)
		local efxSel = UIControls.Panel(self, "MainInfoPanel/RoguePanel/EfxSel" .. i)

		table.insert(self.eventPanelList, eventPanel)
		table.insert(self.efxSelList, efxSel)
	end

	self.characterCellList = {}
	self.curSelectNodeIndex = 2
	self.panelBuff = UIControls.Panel(self, "MainInfoPanel/RoguePanel/BuffPanel")
	self.buffGrids = {}
	self.panelBuffDetail = UIControls.Panel(self, "MainInfoPanel/RoguePanel/BuffDetailPanel")
	self.textBuffDetail = UIControls.Label(self, "MainInfoPanel/RoguePanel/BuffDetailPanel/TextBuff")
	self.textBuffDetailNum = UIControls.Label(self, "MainInfoPanel/RoguePanel/BuffDetailPanel/TextNum")
	self.btnBuffDetail = UIControls.Button(self, "MainInfoPanel/RoguePanel/BuffDetailPanel/UIClickThrough")

	self.btnBuffDetail:addEventClick(self.onBuffDetailClick)
end

function NewMazeMainDlg:refreshUI()
	if self.newMazeData.ratingLevel >= self.newMazeData.seasonBestGradeLevel then
		self.textLayerNum:setText(self.newMazeData.seasonBestGradeLayer)
	else
		self.textLayerNum:setText(Lang.get(724))
	end

	self.curLayer = self.newMazeData.layer

	if self.newMazeData.layer < 10 then
		self.textLayer:setText("0" .. self.newMazeData.layer)
	else
		self.textLayer:setText(self.newMazeData.layer)
	end

	if self.newMazeData.layer > self.bossLayer then
		self.textHint:setText(Lang.get(724))

		if self.newMazeData.ratingLevel < #self.newMazeData.levelMiscData then
			self.btnNext:setVisible(true)
			self.btnReset:setVisible(false)
		else
			self.btnNext:setVisible(false)
			self.btnReset:setVisible(true)
		end
	else
		if self.levelType == 1 then
			self.textHint:setText(string.format(ResNewMazeDisplay[13060008].desc, self.bossLayer - self.newMazeData.layer))
		else
			self.textHint:setText(string.format(ResNewMazeDisplay[13060046].desc, self.bossLayer - self.newMazeData.layer))
		end

		self.btnNext:setVisible(false)
		self.btnReset:setVisible(true)
	end

	self.textGold:setText(self.newMazeData.coin)
	self.textBlood:setText(self.newMazeData.redheart)
	self.textHallowNum:setText(#self.newMazeData.bagRelics)

	local heroNum = 0

	for i, v in pairs(self.newMazeData.allHeroDic) do
		heroNum = heroNum + 1
	end

	self.textHeroNum:setText(heroNum)
	self.textHaloNum:setText(#self.newMazeData.bagHalos)

	if self.newMazeData.tickets < 1 then
		self.textTicketNum:setFontColor(ResColor.RED)
	end

	local preShopExp = 0

	for i, store in pairs(self.newMazeData.shopTableData) do
		if store.shop_level < self.newMazeData.curShopLv then
			preShopExp = preShopExp + store.shop_up_exp
		end

		if store.shop_level == self.newMazeData.curShopLv then
			self.shopData = store
		end
	end

	if self.shopData.shop_up_exp == 999 then
		self.textShopLv:setText(Lang.get(68710))
		self.expSlider:setValue(1)
		self.textProgress:setVisible(false)
	else
		self.textShopLv:setText(string.format(Lang.get(70028), self.shopData.shop_level))
		self.expSlider:setValue((self.newMazeData.curShopExp - preShopExp) / self.shopData.shop_up_exp)
		self.textProgress:setText(string.format("%d/%d", self.newMazeData.curShopExp - preShopExp, self.shopData.shop_up_exp))
		self.textProgress:setVisible(true)
	end

	self.btnPreviewBoss:setVisible(Const.NEW_MAZE_ITERATION_OPEN == true and self.curLayer <= #self.newMazeData.layerAwardData[self.newMazeData.ratingLevel])
end

function NewMazeMainDlg:setData(isInit, isReset)
	self.actObj = CurAvatar:getNewMazeActivity()

	if self.actObj then
		self.newMazeData = self.actObj.actData
	else
		MsgManager.notice(Lang.get(32785))

		return
	end

	NewMazeMainDlg.super.setData(self)

	self.achieveActId = self.newMazeData.miscData.relate_achieve_id

	CurAvatar:addActivityRelated(self.achieveActId, "newMazeMainDlg", self.actObj.actId)

	self.bossLayer = 30
	self.nodeTableData = self.newMazeData.nodeTableData

	for i, data in pairs(self.nodeTableData[self.newMazeData.ratingLevel] or {}) do
		if data.node_type == Const.NEW_MAZE_BOSS_NODE_TYPE then
			self.bossLayer = data.layer

			break
		end
	end

	self:refreshUI()

	self.levelType = self.newMazeData.levelMiscData[self.newMazeData.ratingLevel].level_subject_type

	local iconPath = "Atlas/RogueAtlas/RougeMainAtlas0" .. self.levelType

	self.imgTheme:setImage(iconPath, "BgMachine")
	self.imageReset:setImage(iconPath, "BtnMachine")
	self.imgNext:setImage(iconPath, "BtnMachine")
	self.bgTopLayer:setImage(iconPath, "BgDec02")
	self.bgTopLayer1:setImage(iconPath, "BgDec01")
	self.imgLayer:setImage(iconPath, "BgDec11")

	if not self.actObj:inFreeze() then
		if not self:checkCanKeepGoing() then
			return
		end

		if self.curLayer == 0 or self.newMazeData.lastEventDataStatus[1] then
			RPC.newMazeLayerNextReq(self.actObj.opId)
		end

		if CurAvatar.newMazeBattleMultiAward then
			local chooseThreeDlg = UIManager.getUI("newMazeChooseThreeDlg", true)

			chooseThreeDlg:setData(CurAvatar.newMazeBattleMultiAward)

			CurAvatar.newMazeBattleMultiAward = nil
		end

		if self.newMazeData.lastRandMultiAward and #self.newMazeData.lastRandMultiAward ~= 0 and self.newMazeData.isFeatureMultiAward then
			local chooseThreeDlg = UIManager.getUI("newMazeChooseThreeDlg", true)

			chooseThreeDlg:setData(self.newMazeData.lastRandMultiAward, Const.NEW_MAZE_MULTI_AWARD_NOTIFY_TYPE.Feature)
		end
	end

	if Const.NEW_MAZE_ITERATION_OPEN then
		if self.newMazeData.inheritHeroPoolFlag then
			local settleType

			if self.newMazeData.levelStatus == Const.NEW_MAZE_LEVEL_STATUS.SettleOver then
				settleType = Const.NEW_MAZE_SETTLEMENT_TYPE.Over
			elseif self.newMazeData.levelStatus == Const.NEW_MAZE_LEVEL_STATUS.SettleReset then
				settleType = Const.NEW_MAZE_SETTLEMENT_TYPE.Reset
			elseif self.newMazeData.levelStatus == Const.NEW_MAZE_LEVEL_STATUS.SettleNext then
				settleType = Const.NEW_MAZE_SETTLEMENT_TYPE.Next
			end

			if settleType then
				local newMazeInheritDlg = UIManager.tryGetUI("newMazeInheritDlg")

				newMazeInheritDlg = newMazeInheritDlg or UIManager.getUI("newMazeInheritDlg", true)

				newMazeInheritDlg:setData(Const.PUT_IN_INHERIT_POOL, settleType)
			end
		elseif isReset then
			local newMazeInheritDlg = UIManager.tryGetUI("newMazeInheritDlg")

			if not newMazeInheritDlg then
				newMazeInheritDlg = UIManager.getUI("newMazeInheritDlg", true)

				newMazeInheritDlg:setData(Const.TAKE_FROM_INHERIT_POOL)
			end
		elseif self.newMazeData.inheritSelHerosFlag then
			if self.newMazeData.levelStatus == Const.NEW_MAZE_LEVEL_STATUS.SettleReset then
				RPC.newMazeLevelEnter(self.actObj.opId, Const.NEW_MAZE_LEVEL_ENTER_TYPE.Reset)
			else
				local newMazeInheritDlg = UIManager.tryGetUI("newMazeInheritDlg")

				if not newMazeInheritDlg then
					newMazeInheritDlg = UIManager.getUI("newMazeInheritDlg", true)

					newMazeInheritDlg:setData(Const.TAKE_FROM_INHERIT_POOL)
				end
			end
		elseif self.newMazeData.levelStatus == Const.NEW_MAZE_LEVEL_STATUS.SettleReset then
			RPC.newMazeLevelEnter(self.actObj.opId, Const.NEW_MAZE_LEVEL_ENTER_TYPE.Reset)
		end
	end

	self.themePanelList = {}

	for i = 1, self.levelType do
		local themePanel = UIControls.Panel(self, "MainInfoPanel/RoguePanel/ThemePanel" .. i)

		themePanel:setVisible(i == self.levelType)

		self.themePanelList[i] = themePanel
	end

	if self.rollerInfoPanel == nil then
		local heroId = self.newMazeData.heroId
		local panelPath = "System/Rogue/Roller/RollerPanel"

		self.rollerInfoPanel = NewMazeRollerInfoPanel(self, "MainInfoPanel/RoguePanel/NodePanel/RollerInfoPanel", panelPath, 0, 0, true)
	end

	self.rollerInfoPanel:setData(self.newMazeData.heroId)

	self.eventList = self.newMazeData.lastRandEventList or {}
	self.nodeTableData = self.newMazeData.nodeTableData
	self.alreadyChooseNode = false
	self.lastEventData = self.newMazeData.lastEventData

	if self.lastEventData and self.lastEventData.node_type then
		for i, eventData in ipairs(self.eventList) do
			if self.lastEventData.index == i then
				self.alreadyChooseNode = true
				self.curSelectNodeIndex = i

				break
			end
		end
	end

	if #self.eventList == 1 then
		self.curSelectNodeIndex = 1
	end

	self:createNodeEventItem()

	if self.curSelectNodeIndex then
		local posX = self.eventPanelList[self.curSelectNodeIndex]:getPosition().x
		local pos = self.imgHeroFrame:getPosition()

		self.imgHeroFrame:setPosition(posX, pos.y)
	end

	self:refreshFettersUI()
	self:refreshBuffGrids()
	self:setCharacterUI()
end

function NewMazeMainDlg:playForewardAni()
	self.rollerInfoPanel:playRollerAnimator("ShowHeroUpForeward")
	self.rollerInfoPanel:playMapAni("RollMap")
	self.eventInfoPanel:startAni("ShowEventDown")
	coroutine.wait(1 * FORWARD_TIME)
	self.rollerInfoPanel:stopMapAni("RollMap")
	self.rollerInfoPanel:playRollerAnimator("ShowHeroUpIdle")
	self:createNodeEventItem()
end

function NewMazeMainDlg:checkCanKeepGoing(isGoNextLayer)
	if self.newMazeData.redheart <= 0 then
		local settlementDlg = UIManager.getUI("newMazeSettlementDlg", true)

		if self.newMazeData.layer > self.bossLayer and self.newMazeData.ratingLevel < #self.newMazeData.levelMiscData then
			settlementDlg:setData(Const.NEW_MAZE_SETTLEMENT_TYPE.Next, true)
		else
			settlementDlg:setData(Const.NEW_MAZE_SETTLEMENT_TYPE.Over)
		end

		return false
	end

	if self.newMazeData.ratingLevel == 1 and self.newMazeData.layer > #self.newMazeData.layerAwardData[1] then
		local ratingDlg = UIManager.getUI("newMazeRatingDlg", true)

		ratingDlg:setData(true, nil, true)

		return false
	elseif isGoNextLayer and self.newMazeData.ratingLevel > 1 and self.newMazeData.ratingLevel < #self.newMazeData.levelMiscData and self.newMazeData.layer == self.bossLayer + 1 then
		local ratingDlg = UIManager.getUI("newMazeRatingDlg", true)

		ratingDlg:setData(true)

		return false
	elseif isGoNextLayer and self.newMazeData.ratingLevel == #self.newMazeData.levelMiscData and self.newMazeData.layer == self.bossLayer + 1 then
		if self.newMazeData.isFirstPassCurLevel then
			local ratingDlg = UIManager.getUI("newMazeRatingDlg", true)

			ratingDlg:setData(true, nil, true)

			return false
		end
	elseif self.newMazeData.levelStatus == Const.NEW_MAZE_LEVEL_STATUS.EnterSettle then
		local settlementDlg = UIManager.getUI("newMazeSettlementDlg", true)

		if self.newMazeData.ratingLevel == #self.newMazeData.levelMiscData then
			settlementDlg:setData(Const.NEW_MAZE_SETTLEMENT_TYPE.Over)
		else
			settlementDlg:setData(Const.NEW_MAZE_SETTLEMENT_TYPE.Next, nil, true)
		end

		return false
	elseif self.newMazeData.ratingLevel > 1 and self.newMazeData.layer > #self.newMazeData.layerAwardData[self.newMazeData.ratingLevel] and (not Const.NEW_MAZE_ITERATION_OPEN or self.newMazeData.levelStatus == Const.NEW_MAZE_LEVEL_STATUS.Start) then
		if self.newMazeData.ratingLevel == #self.newMazeData.levelMiscData then
			local settlementDlg = UIManager.getUI("newMazeSettlementDlg", true)

			settlementDlg:setData(Const.NEW_MAZE_SETTLEMENT_TYPE.Over)
		else
			local settlementDlg = UIManager.getUI("newMazeSettlementDlg", true)

			settlementDlg:setData(Const.NEW_MAZE_SETTLEMENT_TYPE.Next, nil, true)
		end

		return false
	end

	return true
end

function NewMazeMainDlg:setCharacterUI()
	self.upHeroCharacterData = self.newMazeData.upHeroCharacterData

	for i, data in ipairs(self.upHeroCharacterData) do
		local cell = self.characterCellList[i]

		if cell == nil then
			cell = HeroCharacterGrid(self, "MainInfoPanel/RoguePanel/BgCharacter/CharacterPanel" .. i, "System/Rogue/GridCharacter", 0, 0, true)
		end

		cell:setData(data, true, i)

		cell.openTipsClick = Slot(self.onOpenCharacterTipsClick, self)
		self.characterCellList[i] = cell
	end
end

function NewMazeMainDlg:onOpenCharacterTipsClick(grid)
	self.characterTipsPanel:setData(grid.data, grid.isInMainDlg)
	self.characterTipsPanel:setVisible(true)
	self.characterPanel:setVisible(true)

	for i, cell in ipairs(self.characterCellList) do
		cell.imgDis:setVisible(i == grid.index)
	end
end

function NewMazeMainDlg:onCharacterClickThroughClick()
	self.characterPanel:setVisible(false)
	self.characterTipsPanel:setVisible(false)

	for i, cell in ipairs(self.characterCellList) do
		cell.imgDis:setVisible(false)
	end
end

function NewMazeMainDlg:createNodeEventItem()
	for i = 1, 3 do
		local path = "MainInfoPanel/RoguePanel/NodePanel/EventInfoPanel/EventPanel" .. i
		local eventItem = self.eventItemList[i]

		if eventItem == nil then
			eventItem = EventItem(self, path, "System/Rogue/EventItem", 0, 0, true)
		end

		if self.eventList[i] then
			eventItem:setData(Const.NEW_MAZE_EVENT_ITEM_TYPE_NORMAL, self.eventList[i], i)
		else
			eventItem:setData(Const.NEW_MAZE_EVENT_ITEM_TYPE_NOTHING)
		end

		eventItem:setSelectCallback(Slot(self.onEventItemClick, self))

		self.eventItemList[i] = eventItem
	end

	self.eventInfoPanel:startAni("ShowEventUp")

	for i, efx in pairs(self.efxSelList) do
		efx:setVisible(self.alreadyChooseNode and i == self.curSelectNodeIndex)
	end
end

function NewMazeMainDlg:onEventItemClick(sender)
	self.curSelectNodeData = sender.nodeData

	for i, efx in pairs(self.efxSelList) do
		efx:setVisible(i == sender.index)
	end

	if self.curSelectNodeIndex ~= sender.index then
		if self.curSelectNodeIndex < sender.index then
			self.imgHeroFrame:playAnimator("ShowHeroRightRun")
		else
			self.imgHeroFrame:playAnimator("ShowHeroLeftRun")
		end

		self.curSelectNodeIndex = sender.index

		local posX = self.eventPanelList[sender.index]:getPosition().x
		local posY = self.imgHeroFrame:getPosition().y

		self.tweenComFlag:UITweenMoveFull(Vector3(posX, posY, 0), 1, Slot(self.openNodeDetail, self), 1, true)
		self.emptyPanel:setVisible(true)
	else
		self:openNodeDetail()
	end
end

function NewMazeMainDlg:openNodeDetail()
	self.emptyPanel:setVisible(false)
	self.imgHeroFrame:playAnimator("ShowHeroIdle")

	local eventDetailDlg = UIManager.tryGetUI("newMazeEventDetailDlg")

	if eventDetailDlg then
		eventDetailDlg:setData(self.curSelectNodeData, self.levelType, self.curSelectNodeIndex)
	else
		eventDetailDlg = UIManager.getUI("newMazeEventDetailDlg", true)

		eventDetailDlg:setData(self.curSelectNodeData, self.levelType, self.curSelectNodeIndex)
	end
end

function NewMazeMainDlg:goNextLayer()
	for i, efx in pairs(self.efxSelList) do
		efx:setVisible(false)
	end

	if self:checkCanKeepGoing(true) then
		self:_realGoNextLayer()
	end
end

function NewMazeMainDlg:_realGoNextLayer()
	self.coForewardAni = coroutine.start(self.coAniForewardFunc, self, 1)
end

function NewMazeMainDlg:coAniForewardFunc(value)
	self.rollerInfoPanel:playRollerAnimator("ShowHeroUpForeward")
	self.rollerInfoPanel:playMapAni("RollMap")
	self.eventInfoPanel:startAni("ShowEventDown")
	self:refreshImgHeroState()
	coroutine.wait(value * FORWARD_TIME)
	self.rollerInfoPanel:stopMapAni("RollMap")
	self.rollerInfoPanel:playRollerAnimator("ShowHeroUpIdle")
	self:setData()

	if self.newMazeData.ratingLevel == 1 then
		BeginnerManager.CheckGoNextLayer({
			self.newMazeData.layer
		})
	end
end

function NewMazeMainDlg:refreshImgHeroState()
	if self.newMazeData.lastRandEventList and not self.newMazeData.lastRandEventList[self.curSelectNodeIndex] then
		if self.newMazeData.lastRandEventList[2] then
			self.curSelectNodeIndex = 2
		else
			self.curSelectNodeIndex = 1
		end

		self.imgHeroFrame:playAnimator("ShowHeroLeftRun")

		local posX = self.eventPanelList[self.curSelectNodeIndex]:getPosition().x
		local posY = self.imgHeroFrame:getPosition().y

		self.tweenComFlag:UITweenMoveFull(Vector3(posX, posY, 0), 1, Slot(self.playHeroIdle, self), 1, true)
	end
end

function NewMazeMainDlg:coAniReversalFunc(value)
	if value and value > 3 then
		value = 3
	end

	self.rollerInfoPanel:playMapAni("RollMap1")
	self.rollerInfoPanel:playRollerAnimator("ShowHeroUpReversal")
	self.eventInfoPanel:startAni("ShowEventDown")
	self:recoverImgHeroState(1)
	coroutine.wait(REVERSAL_TIME)
	self.rollerInfoPanel:stopMapAni("RollMap1")
	self.rollerInfoPanel:playRollerAnimator("ShowHeroUpIdle")

	local isReset = true

	self:setData(nil, isReset)
end

function NewMazeMainDlg:resetLevelData()
	for i, efx in pairs(self.efxSelList) do
		efx:setVisible(false)
	end

	self.coReversalAni = coroutine.start(self.coAniReversalFunc, self, self.oldLayer or 1)
end

function NewMazeMainDlg:recoverImgHeroState(time)
	if self.curSelectNodeIndex ~= 2 then
		if self.curSelectNodeIndex < 2 then
			self.imgHeroFrame:playAnimator("ShowHeroRightRun")
		else
			self.imgHeroFrame:playAnimator("ShowHeroLeftRun")
		end

		self.curSelectNodeIndex = 2

		local posX = self.eventPanelList[2]:getPosition().x
		local posY = self.imgHeroFrame:getPosition().y

		self.tweenComFlag:UITweenMoveFull(Vector3(posX, posY, 0), time, Slot(self.playHeroIdle, self), 1, true)
	end
end

function NewMazeMainDlg:playHeroIdle()
	self.imgHeroFrame:playAnimator("ShowHeroIdle")
end

function NewMazeMainDlg:onBtnHallowClick()
	local hallowPreviewDlg = UIManager.getUI("newMazeHallowPreviewDlg", true)

	hallowPreviewDlg:setData()
end

function NewMazeMainDlg:onBtnHeroClick()
	local heroListDlg = UIManager.getUI("newMazeHeroListDlg", true)

	heroListDlg:setData()
end

function NewMazeMainDlg:onBtnResetClick()
	if self.actObj:inFreeze() then
		MsgManager.notice(Lang.get(32793))

		return
	end

	if self.newMazeData.tickets < 1 then
		MsgManager.notice(ResNewMazeDisplay[13060005].desc)

		return
	end

	self.oldLayer = self.newMazeData.layer

	local settlementDlg = UIManager.getUI("newMazeSettlementDlg", true)

	settlementDlg:setData(Const.NEW_MAZE_SETTLEMENT_TYPE.Reset)
end

function NewMazeMainDlg:onBtnNextClick()
	if self.actObj:inFreeze() then
		MsgManager.notice(Lang.get(32793))

		return
	end

	local settlementDlg = UIManager.getUI("newMazeSettlementDlg", true)

	settlementDlg:setData(Const.NEW_MAZE_SETTLEMENT_TYPE.Next)
end

function NewMazeMainDlg:onBtnHaloClick()
	local haloPreviewDlg = UIManager.getUI("newMazeHaloPreviewDlg", true)

	haloPreviewDlg:setData()
end

function NewMazeMainDlg:onBtnGoldClick()
	local itemId = self.newMazeData.miscData.coin_item_id
	local fakeItem = BaseObject.GetObject(itemId)

	UIManager.getUI("itemTips"):showObj(self, fakeItem)
end

function NewMazeMainDlg:onBtnBloodClick()
	local itemId = self.newMazeData.miscData.redheart_item_id
	local fakeItem = BaseObject.GetObject(itemId)

	UIManager.getUI("itemTips"):showObj(self, fakeItem)
end

function NewMazeMainDlg:onBtnStoreLvClick()
	local storeLvDlg = UIManager.getUI("newMazeStoreLvDlg", true)

	storeLvDlg:setData(self.newMazeData.shopTableData, self.newMazeData.curShopLv)
end

function NewMazeMainDlg:onBtnCloseClick()
	self:setVisible(false)

	local chooseDlg = UIManager.tryGetUI("newMazeChooseDlg", true)

	if chooseDlg then
		chooseDlg:onBtnCloseClick()
	end
end

function NewMazeMainDlg:showResetTips()
	local content = Lang.get(65463)

	UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(65464), content, Slot(self._resetAct, self))
end

function NewMazeMainDlg:_resetAct()
	local closeDisableDlgs = {
		"newMazeMainDlg",
		"newMazeStoreDlg",
		"newMazeStoreLvDlg",
		"newMazeChooseThreeDlg",
		"newMazeRandomDetailDlg",
		"newMazeChangeHeroDlg",
		"newMazeBoxDetailDlg",
		"newMazeEventDetailDlg",
		"newMazeHeroListDlg",
		"newMazeHeroInfoDlg",
		"newMazeHallowPreviewDlg",
		"newMazeAwardDlg",
		"newMazeHaloPreviewDlg",
		"newMazeRandomWinDlg",
		"newMazeRandomLoseDlg",
		"newMazeSettlementDlg"
	}

	for _, name in pairs(closeDisableDlgs) do
		local subUI = UIManager.tryGetUI(name)

		if subUI then
			subUI:setVisible(false)
		end
	end

	RPC.newMazeOpen(self.actObj.opId)
end

function NewMazeMainDlg:onBtnBossPreview()
	local previewBossDlg = UIManager.getUI("newMazePreviewBossDlg", true)

	previewBossDlg:setData()
end

function NewMazeMainDlg:onBuffDetailClick()
	self.panelBuffDetail:setVisible(false)
end

function NewMazeMainDlg:onBuffGridClick(buffGrid)
	for _, grid in ipairs(self.buffGrids) do
		grid:setSelected(grid == buffGrid)
	end

	self.panelBuffDetail:setVisible(true)

	local buffData = buffGrid.buffData

	self.textBuffDetail:setText(buffData.buff_desc)
	self.textBuffDetailNum:setText(buffGrid.buffNum .. "/" .. buffData.max_use_count)
end

function NewMazeMainDlg:refreshBuffGrids()
	local allFightBuffs = self.newMazeData.allFightBuffs

	self.panelBuff:setVisible(#allFightBuffs > 0)

	for index = #self.buffGrids, #allFightBuffs - 1 do
		local newBuffGrid = NewMazeMainBuffGrid(self, "MainInfoPanel/RoguePanel/BuffPanel/Content", "System/Rogue/GridRogueBuff")

		table.insert(self.buffGrids, newBuffGrid)
	end

	for index, grid in ipairs(self.buffGrids) do
		local serverBuffData = allFightBuffs[index]

		if serverBuffData then
			grid:setVisible(true)
			grid:setData(serverBuffData)
		else
			grid:setVisible(false)
		end
	end
end

function NewMazeMainDlg:destroy(...)
	NewMazeMainDlg.super.destroy(self)

	if self.coForewardAni then
		coroutine.stop(self.coForewardAni)

		self.coForewardAni = nil
	end

	if self.coReversalAni then
		coroutine.stop(self.coReversalAni)

		self.coReversalAni = nil
	end
end

return NewMazeMainDlg
