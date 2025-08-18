-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\EquipRecycle\\ActivityBraceletExchangeDlg.lua

local ActivityBraceletExchangeDlg = Class("ActivityBraceletExchangeDlg", UIControls.Window)
local NumControlPanel = require("UI/MainState/Item/NumControlPanel")
local ResHero = require("ClientData/ResHero")

function ActivityBraceletExchangeDlg:ctor(...)
	self:initUI()
end

function ActivityBraceletExchangeDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.txtNumTotal = UIControls.Label(self, "MainInfoPanel/FuncPanel/TextTips/TextNum")
	self.btnConfirm = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.txtNowHeroName = UIControls.Label(self, "MainInfoPanel/HeroNow/TextNow/Text")
	self.nowHeroPortrait = UIControls.Role(self, "MainInfoPanel/HeroNow/HeroPanel/PortraitPanel", 0, 0)
	self.nextHeroPortrait = UIControls.Role(self, "MainInfoPanel/HeroFuture/HeroSketchPanel/PortraitPanel", 0, 0)
	self.panelHeroFuture = UIControls.Panel(self, "MainInfoPanel/HeroFuture")
	self.heroUnknown = UIControls.Image(self, "MainInfoPanel/HeroUnknown")
	self.bgTips = UIControls.Image(self, "MainInfoPanel/BgTips")
	self.btnRecycle = UIControls.Button(self, "MainInfoPanel/BtnRecycle")

	self.btnRecycle:addEventClick(self.onBtnRecycleClick)

	self.txtTime = UIControls.Label(self, "MainInfoPanel/HeroFuture/TextFuture/Text")
	self.numControlPanel = NumControlPanel(self, "MainInfoPanel/FuncPanel/NumPanel")
	self.numControlPanel.mEventNumChanged = Slot(self.onValueChange, self)
end

function ActivityBraceletExchangeDlg:setData(itemId)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	self.itemId = itemId or self.itemId
	self.maxItemNum = CurAvatar:getItemNumById(self.itemId) or 0

	local fakeItem = BaseObject.GetObject(self.itemId, self.maxItemNum)

	if not self.gridItem1 then
		self.gridItem1 = UIControls.ItemGridChild(self, "MainInfoPanel/FuncPanel/GridItem1", "System/Common/Grid/GridMaterialItem", 0, 0, true)
	end

	self.gridItem1:setObj(fakeItem)
	self.txtNumTotal:setText(self.maxItemNum)

	local nowHeroData, nextHeroData = CurAvatar:getEquipRecycleExchangeHeroData()

	self.costNum = nowHeroData.cost or 1

	if self.gridItem1.textNum then
		self.gridItem1.textNum:setText(self.costNum)
	end

	self.maxExchangeNum = math.floor(self.maxItemNum / (nowHeroData.cost or 1))
	self.nowNum = self.nowNum or 0

	if self.nowNum > self.maxExchangeNum then
		self.nowNum = self.maxExchangeNum
	end

	self.numControlPanel:onShow(self.maxExchangeNum, self.nowNum, nil, nil, 0)

	if nowHeroData and nowHeroData.hero_id and ResHero[nowHeroData.hero_id] then
		if not self.gridItem2 then
			self.gridItem2 = UIControls.ItemGridChild(self, "MainInfoPanel/FuncPanel/GridItem2", "System/Common/Grid/GridMaterialItem", 0, 0, true)
		end

		local fakeItem = BaseObject.GetObject(nowHeroData.item_id, 1)

		self.gridItem2:setObj(fakeItem)

		if self.gridItem2.textNum then
			self.gridItem2.textNum:setText(1)
		end

		self.nowHeroPortrait:showRole(nowHeroData.hero_id, UIConst.ROLEIMAGE_SHOWTYPE_DRAW_CARD)
		self.txtNowHeroName:setText(utils.format(Lang.get(101567), ResHero[nowHeroData.hero_id].hero_name))
	end

	if nextHeroData and nextHeroData.hero_id and ResHero[nextHeroData.hero_id] then
		self.heroUnknown:setVisible(false)
		self.nextHeroPortrait:showRole(nextHeroData.hero_id, UIConst.ROLEIMAGE_SHOWTYPE_DRAW_CARD)
		self.nextHeroPortrait:setImageAndEmojiByRGBA(0, 0, 0, 200)

		local leftTime = nextHeroData.beginTime - ClientUtils.getServerTime()

		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, false, Lang.get(102273), Slot(self.setData, self))
	else
		self.heroUnknown:setVisible(true)
		self.panelHeroFuture:setVisible(false)
	end

	self.actData = CurAvatar:getEquipRecycleActivityData()

	if self.actData then
		self.bgTips:setVisible(true)
		self.btnRecycle:setVisible(true)
	else
		self.bgTips:setVisible(false)
		self.btnRecycle:setVisible(false)
	end
end

function ActivityBraceletExchangeDlg:onValueChange(value)
	if self.nowNum == value then
		return
	end

	self.nowNum = value
end

function ActivityBraceletExchangeDlg:onBtnConfirmClick()
	if self.nowNum == 0 then
		MsgManager.notice(Lang.get(101568))
	else
		local data = {}
		local cell = {}

		cell.data = {}
		cell.data.id = self.itemId
		cell.data.num = self.nowNum * self.costNum

		table.insert(data, cell)
		RPC.itemUse(data)
	end
end

function ActivityBraceletExchangeDlg:onBtnTipsClick(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(530)
end

function ActivityBraceletExchangeDlg:onBtnRecycleClick()
	local actData = CurAvatar:getEquipRecycleActivityData()

	if actData then
		UIManager.getUI("activityEquipRecycleDlg", true):setData(actData)
	end
end

function ActivityBraceletExchangeDlg:onBtnCloseClick()
	self:setVisible(false)
end

return ActivityBraceletExchangeDlg
