-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityEquipMakeDlg.lua

local ResEquip = require("ClientData/ResEquip")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResEquipSuit = require("ClientData/ResEquipSuit")
local ResEquipCustomize = require("ClientData/ResEquipCustomize")
local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local ResColor = require("ClientData/ResColor")
local EventConst = require("EventConst")
local CHOOSE_STAGE = {
	Finish = 4,
	Attr = 3,
	Suit = 2,
	Pos = 1
}
local strClassName = "PosChooseCell"
local PosChooseCell = Class(strClassName, UIControls.Child)

function PosChooseCell:ctor()
	self.iconPart = UIControls.Image(self, "IconPart")
	self.textPart = UIControls.Label(self, "TextPart")
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)
end

function PosChooseCell:setData(pos, data)
	self.pos = pos

	self.iconPart:setImage("Atlas/CommonAtlas/IconAtlas/EquipAtlas/00", string.format("0%dSel", pos - 1))
	self.textPart:setText(data)
	self.btnSelf:setEnable(not self.mParent.choosePos or self.mParent.choosePos ~= self.pos)
end

function PosChooseCell:onBtnSelfClick()
	self.mParent.choosePos = self.pos

	for i, cell in pairs(self.mParent.posCells or {}) do
		if cell.pos == self.pos then
			cell.btnSelf:setEnable(false)
		else
			cell.btnSelf:setEnable(true)
		end
	end
end

local strClassName = "SuitChooseCell"
local SuitChooseCell = Class(strClassName, UIControls.Child)

function SuitChooseCell:ctor()
	self.iconSuit = UIControls.Image(self, "IconSuit")
	self.textSuit = UIControls.Label(self, "TextSuit")
	self.textAttr = UIControls.Label(self, "TextAttr")
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)
end

function SuitChooseCell:setData(suitId)
	self.suitId = suitId

	self.iconSuit:setImage("Atlas/CommonAtlas/" .. ResEquipSuit[self.suitId].big_icon_path, ResEquipSuit[self.suitId].big_icon)
	self.textSuit:setText(ResEquipSuit[self.suitId].name)
	self.textAttr:setText(ResEquipSuit[self.suitId].des)
	self.btnSelf:setEnable(true)
end

function SuitChooseCell:onBtnSelfClick()
	self.mParent.chooseSuitId = self.suitId

	for i, cell in pairs(self.mParent.suitCells or {}) do
		if cell.suitId == self.suitId then
			cell.btnSelf:setEnable(false)
		else
			cell.btnSelf:setEnable(true)
		end
	end
end

local strClassName = "AttrChooseCell"
local AttrChooseCell = Class(strClassName, UIControls.Child)

function AttrChooseCell:ctor()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.attrList = {}

	for i = 1, 2 do
		local attrPanel = HeroAttrPanel(self, "Attr0" .. i)

		table.insert(self.attrList, attrPanel)
	end
end

function AttrChooseCell:setData(mainProp)
	self.mainProp = mainProp

	local equip = BaseObject.GetObject(self.mParent.equipId, nil, true)
	local mainPropValue = utils.getEquipMainPropValue(equip, 0, self.mainProp)
	local mainPropAttrList = {
		{
			propName = self.mainProp,
			propValue = mainPropValue
		},
		{
			propName = equip.mainProp2,
			propValue = equip.mainProp2Value
		}
	}

	for index, attrPanel in ipairs(self.attrList) do
		local mainPropAttr = mainPropAttrList[index]

		if mainPropAttr.propName and mainPropAttr.propValue then
			attrPanel:setVisible(true)

			local zhName, attrValue = ClientUtils.getRolePropZhNameByType(mainPropAttr.propName, mainPropAttr.propValue)
			local attriconInfo = ClientUtils.getRolePropIconByType(mainPropAttr.propName)

			attrPanel.imgIcon:setImage(attriconInfo[1], attriconInfo[2])
			attrPanel:setData(zhName, attrValue)
		else
			attrPanel:setVisible(false)
		end
	end

	self.btnSelf:setEnable(not self.mParent.chooseAttr or self.mParent.chooseAttr ~= self.mainProp)
end

function AttrChooseCell:onBtnSelfClick()
	self.mParent.chooseAttr = self.mainProp

	for i, cell in pairs(self.mParent.attrCells or {}) do
		if cell.mainProp == self.mainProp then
			cell.btnSelf:setEnable(false)
		else
			cell.btnSelf:setEnable(true)
		end
	end
end

local strClassName = "MakeProcessCell"
local MakeProcessCell = Class(strClassName, UIControls.Child)

function MakeProcessCell:ctor()
	self.aniSelf = UIControls.UIAni(self, "")

	self.aniSelf:addEventFinish(self.onAniFinish)

	self.aniPanel = UIControls.UIAni(self, "EquipServerPanel")

	self.aniPanel:addEventFinish(self.onAniFinish)

	self.equipServerPanel = UIControls.Panel(self, "EquipServerPanel")
	self.lockPanel = UIControls.Panel(self, "EquipServerPanel/LockPanel")
	self.customingPanel = UIControls.Panel(self, "EquipServerPanel/CustomingPanel")
	self.customFinishPanel = UIControls.Panel(self, "EquipServerPanel/CustomFinishPanel")
	self.efxUnlock = UIControls.LazyEffectPlayer(self, "EquipServerPanel/EfxUnlock")
	self.slider = UIControls.Slider(self, "SliderPanel/Slider")
	self.attrPanel = UIControls.Panel(self, "EquipServerPanel/CustomFinishPanel/AttrPanel")
	self.partPanel = UIControls.Panel(self, "EquipServerPanel/CustomFinishPanel/PartPanel")
	self.suitPanel = UIControls.Panel(self, "EquipServerPanel/CustomFinishPanel/SuitPanel")
	self.iconPart = UIControls.Image(self, "EquipServerPanel/CustomFinishPanel/PartPanel/IconPart")
	self.textPart = UIControls.Label(self, "EquipServerPanel/CustomFinishPanel/PartPanel/TextPart")
	self.iconSuit = UIControls.Image(self, "EquipServerPanel/CustomFinishPanel/SuitPanel/IconSuit")
	self.textSuit = UIControls.Label(self, "EquipServerPanel/CustomFinishPanel/SuitPanel/TextSuit")
	self.attrList = {}

	for i = 1, 2 do
		local attrPanel = HeroAttrPanel(self, "EquipServerPanel/CustomFinishPanel/AttrPanel/Attr0" .. i)

		table.insert(self.attrList, attrPanel)
	end

	self.bgDis = UIControls.Panel(self, "SliderPanel/BgDis")
	self.bgNml = UIControls.Panel(self, "SliderPanel/BgNml")
	self.textProcess = UIControls.Label(self, "SliderPanel/BgProcess/TextProcess")
	self.textDisNum = UIControls.Label(self, "SliderPanel/BgDis/TextNum")
	self.textNmlNum = UIControls.Label(self, "SliderPanel/BgNml/TextNum")
end

function MakeProcessCell:setData(stage)
	self.myStage = stage
	self.curStage = self.mParent.curStage

	self.slider:setVisible(self.myStage ~= CHOOSE_STAGE.Pos)
	self.slider:setValue(self.myStage <= self.curStage and 1 or 0)
	self.equipServerPanel:setVisible(self.myStage ~= CHOOSE_STAGE.Finish)
	self.lockPanel:setVisible(self.myStage > self.curStage)
	self.customingPanel:setVisible(self.myStage == self.curStage)
	self.customFinishPanel:setVisible(self.myStage < self.curStage)
	self.bgDis:setVisible(self.myStage >= self.curStage)
	self.bgNml:setVisible(self.myStage < self.curStage)
	self.textDisNum:setText(self.myStage)
	self.textNmlNum:setText(self.myStage)

	local name = {
		Lang.get(89823),
		Lang.get(89824),
		Lang.get(89825),
		Lang.get(89826)
	}

	self.textProcess:setText(name[stage])

	if self.myStage < self.curStage then
		self.partPanel:setVisible(self.myStage == CHOOSE_STAGE.Pos)
		self.suitPanel:setVisible(self.myStage == CHOOSE_STAGE.Suit)
		self.attrPanel:setVisible(self.myStage == CHOOSE_STAGE.Attr)

		if self.mParent.pos then
			self.iconPart:setImage("Atlas/CommonAtlas/IconAtlas/EquipAtlas/00", string.format("0%dSel", self.mParent.pos - 1))
			self.textPart:setText(UIConst.EQUIP_PART_CONFIG2[self.mParent.pos])
		end

		if self.mParent.suitId then
			self.iconSuit:setImage("Atlas/CommonAtlas/" .. ResEquipSuit[self.mParent.suitId].big_icon_path, ResEquipSuit[self.mParent.suitId].big_icon)
			self.textSuit:setText(ResEquipSuit[self.mParent.suitId].name)
		end

		if self.mParent.mainProp then
			local equip = BaseObject.GetObject(self.mParent.equipId, nil, true)
			local mainPropValue = utils.getEquipMainPropValue(equip, 0, self.mParent.mainProp)
			local mainPropAttrList = {
				{
					propName = self.mParent.mainProp,
					propValue = mainPropValue
				},
				{
					propName = equip.mainProp2,
					propValue = equip.mainProp2Value
				}
			}

			for index, attrPanel in ipairs(self.attrList) do
				local mainPropAttr = mainPropAttrList[index]

				if mainPropAttr.propName and mainPropAttr.propValue then
					attrPanel:setVisible(true)

					local zhName, attrValue = ClientUtils.getRolePropZhNameByType(mainPropAttr.propName, mainPropAttr.propValue)
					local attriconInfo = ClientUtils.getRolePropIconByType(mainPropAttr.propName)

					attrPanel.imgIcon:setImage(attriconInfo[1], attriconInfo[2])
					attrPanel:setData(zhName, attrValue)
				else
					attrPanel:setVisible(false)
				end
			end
		end
	end
end

function MakeProcessCell:playCellAni()
	self.aniSelf:startAni("UnlockActivityEquipServer")
end

function MakeProcessCell:playFinishAni()
	self.aniPanel:startAni("FinishEquipServer")
end

function MakeProcessCell:onAniFinish(aniCom, aniName)
	if aniName == "FinishEquipServer" then
		if self.myStage < CHOOSE_STAGE.Finish then
			self.mParent:refreshPanel()

			for i, cell in pairs(self.mParent.processCells or {}) do
				if cell.myStage == self.mParent.curStage then
					cell:playCellAni()
				end
			end
		end
	elseif aniName == "UnlockActivityEquipServer" and self.myStage == CHOOSE_STAGE.Finish then
		UIManager.getUI("activityEquipMakeFinishDlg", true):setData(self.mParent.actObj.opId)
	end
end

local strClassName = "ActivityEquipMakeDlg"
local ActivityEquipMakeDlg = Class(strClassName, UIControls.Window)

function ActivityEquipMakeDlg:ctor()
	self:initUI()
end

function ActivityEquipMakeDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.textServeTimes = UIControls.Label(self, "MainInfoPanel/BgServeTimes/TextServeTimes")
	self.textTime = UIControls.Label(self, "MainInfoPanel/BgTime/TextTime")
	self.chooseSuitPanel = UIControls.Panel(self, "MainInfoPanel/CustomChoosePanel/ChooseSuitPanel")
	self.choosePartPanel = UIControls.Panel(self, "MainInfoPanel/CustomChoosePanel/ChoosePartPanel")
	self.chooseAttrPanel = UIControls.Panel(self, "MainInfoPanel/CustomChoosePanel/ChooseAttrPanel")
	self.textTitle = UIControls.Label(self, "MainInfoPanel/CustomChoosePanel/BgTitle/TextTitle")
	self.textRule = UIControls.Label(self, "MainInfoPanel/CustomChoosePanel/BgRule/TextRule")
	self.suitAni = UIControls.UIAni(self, "MainInfoPanel/CustomChoosePanel/ChooseSuitPanel")
	self.attrAni = UIControls.UIAni(self, "MainInfoPanel/CustomChoosePanel/ChooseAttrPanel")
	self.iconAgain = UIControls.Image(self, "MainInfoPanel/CustomChoosePanel/FuncPanel/BtnAgain/Icon")
	self.textAgainNum = UIControls.Label(self, "MainInfoPanel/CustomChoosePanel/FuncPanel/BtnAgain/TextNum")
	self.btnAgain = UIControls.Button(self, "MainInfoPanel/CustomChoosePanel/FuncPanel/BtnAgain")

	self.btnAgain:addEventClick(self.onBtnAgainClick)

	self.iconStart = UIControls.Image(self, "MainInfoPanel/CustomChoosePanel/FuncPanel/BtnStart/Icon")
	self.textStartNum = UIControls.Label(self, "MainInfoPanel/CustomChoosePanel/FuncPanel/BtnStart/TextNum")
	self.btnStart = UIControls.Button(self, "MainInfoPanel/CustomChoosePanel/FuncPanel/BtnStart")

	self.btnStart:addEventClick(self.onBtnStartClick)

	self.btnConfirm = UIControls.Button(self, "MainInfoPanel/CustomChoosePanel/FuncPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnGuide = UIControls.Button(self, "MainInfoPanel/CustomChoosePanel/BtnGuide")

	self.btnGuide:addEventClick(self.onBtnGuideClick)

	self.btnPreview = UIControls.Button(self, "MainInfoPanel/ProcessPanel/BtnPreview")

	self.btnPreview:addEventClick(self.onBtnPreviewClick)

	self.processCells = {}
	self.posCells = {}
	self.suitCells = {}
	self.attrCells = {}
	self.slot4RefreshPanel = Slot(self.refreshItem, self)

	EventCenter.addEventListener(EventConst.ITEM_UPDATE, self.slot4RefreshPanel)
end

function ActivityEquipMakeDlg:setData(actObj)
	self.actObj = actObj
	self.actData = self.actObj.actData

	ClientTimerManager.AddSecondFormatTickUI(self.textTime, self.actObj:getRemainOpenTime(), false, Lang.get(48655), Slot(self._timerOver, self))

	self.makeCostId = self.actData.miscData.make_item_id
	self.makeCostNum = self.actData.miscData.make_item_num or 1
	self.refreshCostNum = self.actData.miscData.make_refresh_item_num or 1

	local itemIcon = BaseObject.getItemIconPath(self.makeCostId)

	if itemIcon then
		self.iconStart:setImage(itemIcon[1], itemIcon[2])
		self.iconAgain:setImage(itemIcon[1], itemIcon[2])
	end

	self.textAgainNum:setText(self.refreshCostNum)
	self.textStartNum:setText(self.makeCostNum)
	self:refreshPanel()

	if self.actData.equipMakeData.main_prop ~= 0 then
		self:playSpecShow(Const.MAKE_EQUIP_CHOOSE_TYPE.Prop)
	end
end

function ActivityEquipMakeDlg:refreshItem()
	local haveItemNum = CurAvatar:getItemNumById(self.makeCostId)

	if haveItemNum >= self.makeCostNum then
		self.textStartNum:setFontColor(ResColor.BLACK)
	else
		self.textStartNum:setFontColor(ResColor.RED)
	end

	if haveItemNum >= self.refreshCostNum then
		self.textAgainNum:setFontColor(ResColor.WHITE)
	else
		self.textAgainNum:setFontColor(ResColor.RED)
	end
end

function ActivityEquipMakeDlg:refreshPanel()
	self.actData = self.actObj.actData

	self.textServeTimes:setText(string.format(Lang.get(89827), self.actData.remainCount))
	self:refreshItem()

	self.curStage = CHOOSE_STAGE.Pos

	if self.actData.equipMakeData.resid ~= 0 then
		self.equipId = self.actData.equipMakeData.resid
		self.pos = ResEquip[self.equipId].position

		if self.actData.equipMakeData.suit ~= 0 then
			self:refreshAttrPanel()
		else
			self:refreshSuitPanel()
		end
	else
		self:refreshPosPanel()
	end

	for stage = 1, 4 do
		local processCell = self.processCells[stage]

		processCell = processCell or MakeProcessCell(self, "MainInfoPanel/ProcessPanel/ProcessInfoPanel", "System/Activity/ActivityEquipWash/ActivityEquipServerCell", 0, 0, true)

		processCell:setData(stage)

		self.processCells[stage] = processCell
	end

	self.btnPreview:setVisible(self.curStage > CHOOSE_STAGE.Pos)
	self.btnGuide:setVisible(self.curStage > CHOOSE_STAGE.Pos)
end

function ActivityEquipMakeDlg:refreshPosPanel()
	self.curStage = CHOOSE_STAGE.Pos
	self.choosePos = nil

	for i, v in ipairs(UIConst.EQUIP_PART_CONFIG2) do
		local posCell = self.posCells[i]

		if posCell == nil then
			posCell = PosChooseCell(self, "MainInfoPanel/CustomChoosePanel/ChoosePartPanel", "System/Activity/ActivityEquipWash/BtnCustomPart", 0, 0, true)
		end

		posCell:setData(i, v)

		self.posCells[i] = posCell
	end

	self.btnConfirm:setVisible(false)
	self.btnAgain:setVisible(false)
	self.textTitle:setText(Lang.get(90266))
	self.textRule:setText(Lang.get(90420))
	self.btnStart:setVisible(true)
	self.chooseSuitPanel:setVisible(false)
	self.choosePartPanel:setVisible(true)
	self.chooseAttrPanel:setVisible(false)
end

function ActivityEquipMakeDlg:refreshSuitPanel()
	self.curStage = CHOOSE_STAGE.Suit

	self.btnConfirm:setVisible(true)
	self.btnAgain:setVisible(true)
	self.btnStart:setVisible(false)
	self.chooseSuitPanel:setVisible(true)
	self.choosePartPanel:setVisible(false)
	self.chooseAttrPanel:setVisible(false)
	self.textTitle:setText(Lang.get(90267))
	self.textRule:setText(Lang.get(89831))

	local randSuits = {}

	for i, v in pairs(self.actData.equipMakeData.rand_suit or {}) do
		if v.state == Const.MAKE_EQUIP_RAND_TYPE.UnSelect then
			table.insert(randSuits, v.suit)
		end
	end

	if ResEquipCustomize[self.equipId] and ResEquipCustomize[self.equipId].suit_num <= 2 then
		self.btnAgain:setVisible(false)
	end

	self.chooseSuitId = nil

	for i = 1, 2 do
		if randSuits[i] then
			local suitCell = self.suitCells[i]

			if suitCell == nil then
				suitCell = SuitChooseCell(self, "MainInfoPanel/CustomChoosePanel/ChooseSuitPanel", "System/Activity/ActivityEquipWash/BtnCustomSuit")
			end

			suitCell:setData(randSuits[i])
			suitCell:setVisible(true)

			self.suitCells[i] = suitCell
		elseif self.suitCells[i] then
			self.suitCells[i]:setVisible(false)
		end
	end
end

function ActivityEquipMakeDlg:refreshAttrPanel()
	self.curStage = CHOOSE_STAGE.Attr

	self.btnConfirm:setVisible(true)
	self.btnAgain:setVisible(true)
	self.btnStart:setVisible(false)
	self.chooseSuitPanel:setVisible(false)
	self.choosePartPanel:setVisible(false)
	self.chooseAttrPanel:setVisible(true)
	self.textTitle:setText(Lang.get(90268))
	self.textRule:setText(Lang.get(89833))

	self.suitId = self.actData.equipMakeData.suit

	local randMainProps = {}

	for i, v in pairs(self.actData.equipMakeData.rand_prop or {}) do
		if v.state == Const.MAKE_EQUIP_RAND_TYPE.UnSelect then
			table.insert(randMainProps, v.main_prop)
		end
	end

	if self.actData.equipMakeData.main_prop ~= 0 then
		self.curStage = CHOOSE_STAGE.Finish
		self.mainProp = self.actData.equipMakeData.main_prop

		self.btnConfirm:setVisible(false)
		self.btnAgain:setVisible(false)
	end

	self.chooseAttr = nil

	if ResEquipCustomize[self.equipId] and ResEquipCustomize[self.equipId].prop_num <= 2 then
		self.textRule:setText(Lang.get(89834))
		self.btnAgain:setVisible(false)

		if ResEquipCustomize[self.equipId].prop_num == 1 then
			self.chooseAttr = ResEquipCustomize[self.equipId].prop_range[1]
		end
	end

	for i = 1, 2 do
		if randMainProps[i] then
			local attrCell = self.attrCells[i]

			if attrCell == nil then
				attrCell = AttrChooseCell(self, "MainInfoPanel/CustomChoosePanel/ChooseAttrPanel", "System/Activity/ActivityEquipWash/BtnCustomAttr")
			end

			attrCell:setData(randMainProps[i])

			self.attrCells[i] = attrCell
		elseif self.attrCells[i] then
			self.attrCells[i]:destroy()

			self.attrCells[i] = nil
		end
	end

	for i, cell in pairs(self.attrCells) do
		cell:setVisible(true)
	end
end

function ActivityEquipMakeDlg:_timerOver()
	if self.textTime and self.textTime:isAlive() then
		self.textTime:setText(Lang.get(32785))
	end
end

function ActivityEquipMakeDlg:checkItemEnough(itemId, num)
	local costItemNum = CurAvatar:getItemNumById(itemId)

	if costItemNum < num then
		local fakeItem = BaseObject.GetObject(itemId)

		UIManager.getUI("itemTips"):showObj(self, fakeItem, {
			AutoOpenGuide = 1
		})
		MsgManager.notice(string.format(ResClientNotice[675].notice, fakeItem.name))

		return false
	end

	return true
end

function ActivityEquipMakeDlg:playSpecShow(type, equipInfo)
	local stage = Const.MAKE_EQUIP_CHOOSE_TYPE_INDEX[type]

	if stage < CHOOSE_STAGE.Finish then
		for i, cell in pairs(self.processCells) do
			if cell.myStage == stage then
				cell:playFinishAni()
			end
		end
	else
		local activityEquipMakeFinishDlg = UIManager.tryGetUI("activityEquipMakeFinishDlg")

		if activityEquipMakeFinishDlg then
			activityEquipMakeFinishDlg:onFinishResp(equipInfo)
		end
	end
end

function ActivityEquipMakeDlg:playRefreshShow()
	self.suitAni:startAni("RefreshCustomChoose")
	self.attrAni:startAni("RefreshCustomChoose")
	self:refreshPanel()
end

function ActivityEquipMakeDlg:onBtnAgainClick()
	if self:checkItemEnough(self.makeCostId, self.refreshCostNum) then
		local function yesFunc()
			local chooseType

			for type, index in pairs(Const.MAKE_EQUIP_CHOOSE_TYPE_INDEX) do
				if index == self.curStage then
					chooseType = type
				end
			end

			RPC.opActEquipMakeRand(self.actObj.opId, chooseType)
		end

		UIManager.showConfirmWithId(1096, yesFunc)
	end
end

function ActivityEquipMakeDlg:onBtnStartClick()
	if self.choosePos == nil then
		MsgManager.notice(ClientUtils.getClientNotice(728))

		return
	end

	if self:checkItemEnough(self.makeCostId, self.makeCostNum) then
		local function yesFunc()
			local resId

			for i, v in pairs(ResEquipCustomize) do
				if v.pos == self.choosePos then
					resId = v.resid

					break
				end
			end

			RPC.opActEquipMakeChoose(self.actObj.opId, Const.MAKE_EQUIP_CHOOSE_TYPE.Pos, resId)
		end

		UIManager.showConfirmWithId(1095, yesFunc)
	end
end

function ActivityEquipMakeDlg:onBtnConfirmClick()
	if self.curStage == CHOOSE_STAGE.Suit then
		if self.chooseSuitId == nil then
			MsgManager.notice(ClientUtils.getClientNotice(733))

			return
		end

		local function yesFunc()
			RPC.opActEquipMakeChoose(self.actObj.opId, Const.MAKE_EQUIP_CHOOSE_TYPE.Suit, self.chooseSuitId)
		end

		local msgContent = string.format(ClientUtils.getClientNotice(731), ResEquipSuit[self.chooseSuitId].name)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc, nil, -1)
	else
		if self.chooseAttr == nil then
			MsgManager.notice(ClientUtils.getClientNotice(732))

			return
		end

		local function yesFunc()
			RPC.opActEquipMakeChoose(self.actObj.opId, Const.MAKE_EQUIP_CHOOSE_TYPE.Prop, self.chooseAttr)
			self.btnConfirm:setEnable(false)
			self.btnAgain:setVisible(false)
		end

		UIManager.showConfirmWithId(1098, yesFunc)
	end
end

function ActivityEquipMakeDlg:onBtnGuideClick()
	UIManager.getUI("activityEquipMakeRangeDlg", true):setData(self.actData)
end

function ActivityEquipMakeDlg:onBtnPreviewClick()
	local equip = BaseObject.GetObject(self.equipId, nil, true)
	local params = {}

	params.suitId = self.suitId
	params.mainProp = self.mainProp

	UIManager.getUI("equipMakeTempleteTips"):showObj(self, equip, nil, nil, nil, params)
end

function ActivityEquipMakeDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_EQUIP_MAKE)
end

function ActivityEquipMakeDlg:onBtnCloseClick()
	if self.actData.equipMakeData.resid ~= 0 then
		local refineDlg = UIManager.tryGetUI("activityEquipRefineDlg")

		if refineDlg then
			refineDlg:setVisible(false)
		end
	end

	self:setVisible(false)
end

function ActivityEquipMakeDlg:onDestroy()
	EventCenter.removeEventListener(EventConst.ITEM_UPDATE, self.slot4RefreshPanel)
	ActivityEquipMakeDlg.super.onClose(self)
end

return ActivityEquipMakeDlg
