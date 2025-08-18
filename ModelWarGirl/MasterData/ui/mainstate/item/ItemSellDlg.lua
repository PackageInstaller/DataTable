-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Item\\ItemSellDlg.lua

local NumControlPanel = require("UI/MainState/Item/NumControlPanel")
local ResItem = require("ClientData/ResItem")
local UIControls = UIControls
local MODE_SELL = 1
local MODE_COMPOSE = 2
local strClassName = "ItemSellDlg"
local ItemSellDlg = Class(strClassName, UIControls.Window)

function ItemSellDlg:ctor()
	self:initUI()
end

function ItemSellDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnDeny")

	self.btnClose:addEventClick(self.onCloseClick)

	self.textGainTitle = UIControls.Label(self, "BgPanel/NumGain/TextTitleNum")
	self.iconGain = UIControls.Image(self, "BgPanel/NumGain/Icon")
	self.textGain = UIControls.Label(self, "BgPanel/NumGain/TextNum")
	self.textNum = UIControls.Label(self, "BgPanel/TextNum")
	self.btnSell = UIControls.Button(self, "BgPanel/BtnConfirm", "Text")

	self.btnSell:addEventClick(self.onSellClick)

	self.numPanel = NumControlPanel(self, "BgPanel/NumPanel")
	self.numPanel.mEventNumChanged = Slot(self.onNumChanged, self)
end

function ItemSellDlg:onShow(item, isCompose)
	self.item = item
	self.isCompose = isCompose

	local ownNum = CurAvatar:getItemNumById(self.item.id, true)

	if isCompose then
		self.grid = UIControls.FragItemGridChild(self, "BgPanel/ItemPanel", "System/Common/Grid/GridShatterItem")
		self.grid.mEnableTips = false
		self.mode = MODE_COMPOSE

		self.textGainTitle:setText(Lang.get(203))
		self.btnSell:setText(Lang.get(983))

		if self.item.resData.extend_args1 then
			local maxComposeNum = math.floor(self.item.num / self.item.resData.extend_args1)
			local blankNum = 999
			local maxNotice = ""

			if self.item.subType == Const.ITEM_STYPE_RAND_EQUIP_FRAG then
				blankNum = CurAvatar:getEquipRemainBlankNum()
				maxNotice = Lang.get(3614)
			elseif self.item.subType == Const.ITEM_STYPE_RAND_ARTIFACT_FRAG then
				blankNum = CurAvatar:getArtifactRemainBlankNum()
				maxNotice = Lang.get(3615)
			elseif self.item.subType == Const.ITEM_STYPE_RAND_HERO_FRAG or self.item.subType == Const.ITEM_STYPE_HERO_FRAG then
				blankNum = CurAvatar:getHeroRemainBlankNum()
				maxNotice = Lang.get(3616)
			elseif self.item.subType == Const.ITEM_STYPE_SKIN_FRAG then
				maxComposeNum = 1
			end

			if maxComposeNum <= blankNum then
				self.numPanel:onShow(maxComposeNum, maxComposeNum, Lang.get(983))
			else
				self.numPanel:onShow(blankNum, blankNum, Lang.get(983), maxNotice)
			end
		end
	else
		self.grid = UIControls.ItemGridChild(self, "BgPanel/ItemPanel", "System/Common/Grid/GridMaterialItem")
		self.grid.mEnableTips = false
		self.mode = MODE_SELL

		self.textGainTitle:setText(Lang.get(590))
		self.btnSell:setText(Lang.get(528))

		local sellCoin = self.item.resData.sell_coin_id

		if sellCoin and ResItem[sellCoin] then
			self.iconGain:setImage(UIConst.ITEM_ICON_PATH .. ResItem[sellCoin].iconPath, ResItem[sellCoin].icon)
		end

		self.sellPrice = self.item.resData.sell_price or 0

		self.numPanel:onShow(ownNum, 1, Lang.get(528))
	end

	self.grid:setVisible(true)
	self.textNum:setText(string.format(Lang.get(30234), ClientUtils.getNumShortStr(ownNum)))
	self.grid:setObj(BaseObject.GetObject(self.item.id))
end

function ItemSellDlg:onNumChanged(num)
	self.nowNum = num

	if self.isCompose then
		self.textGain:setText(self.item.resData.extend_args1 * self.nowNum)
	else
		self.textGain:setText(num * self.sellPrice)
	end
end

function ItemSellDlg:onSellClick(sender)
	if self.nowNum <= 0 then
		if self.isCompose then
			MsgManager.clientNotice(143)
		else
			MsgManager.clientNotice(144)
		end

		return
	end

	if self.isCompose then
		RPC.itemCompound({
			id = self.item.id,
			num = self.nowNum
		})
		self:setVisible(false)
	else
		local items = {}

		table.insert(items, {
			id = self.item.id,
			num = self.nowNum
		})
		RPC.itemSell(items)
		self:setVisible(false)
	end
end

function ItemSellDlg:onCloseClick()
	self:setVisible(false)
end

return ItemSellDlg
