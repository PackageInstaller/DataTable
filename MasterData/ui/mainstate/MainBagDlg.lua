-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\MainBagDlg.lua

local BagCommonPart = require("UI/MainState/BagCommonPart")
local BagFragPart = require("UI/MainState/BagFragPart")
local BagEquipPart = require("UI/MainState/BagEquipPart")
local BagArtifactPart = require("UI/MainState/BagArtifactPart")
local BagWearPart = require("UI/MainState/BagWearPart")
local BagRelicPart = require("UI/MainState/BagRelicPart")
local BagSkinPart = require("UI/MainState/BagSkinPart")
local UserData = require("Helper/UserData")
local ResClientConfirm = require("ClientData/ResClientConfirm")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local UIControls = UIControls
local strClassName = "MainBagDlg"
local MainBagDlg = Class(strClassName, UIControls.Window)

function MainBagDlg:ctor()
	self:initUI()

	self.tipsFuncItem = UIControls.TipsConfig()

	self.tipsFuncItem:addConfig(self, Lang.get(528), self.onSellItem, self.onItemSellCheck, nil, 2)
	self.tipsFuncItem:addConfig(self, Lang.get(588), self.onUseItem, self.onItemUseCheck, nil, 1)
	self.tipsFuncItem:addConfig(self, Lang.get(30472), self.onUseChooseGift, self.onChooseGiftUseCheck, nil, 1)
	self.tipsFuncItem:addConfig(self, Lang.get(126), self.onSpecialJump, self.onSpecialJumpCheck, nil, 2)
	self.tipsFuncItem:addConfig(self, Lang.get(55850), self.onBuildStone, self.onBuildStoneCheck, nil, 1)

	self.tipsFuncFragItem = UIControls.TipsConfig()

	self.tipsFuncFragItem:addConfig(self, Lang.get(983), self.onComposeItem, self.onItemComposeCheck, self.onItemComposeEnableCheck, 1)
end

function MainBagDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.btnItemCommon = UIControls.Button(self, "MainInfoPanel/TabPanel/BtnMaterial")

	local commonRD = UIControls.RedDot(self, "MainInfoPanel/TabPanel/BtnMaterial/IconNew")

	commonRD:addHint({
		UIConst.RD_HINT_BAG_MATERIAL
	})

	self.btnItemEquip = UIControls.Button(self, "MainInfoPanel/TabPanel/BtnEquip")
	self.btnItemBadge = UIControls.Button(self, "MainInfoPanel/TabPanel/BtnBadge")
	self.btnItemFragment = UIControls.Button(self, "MainInfoPanel/TabPanel/BtnShatter")

	local fragRD = UIControls.RedDot(self, "MainInfoPanel/TabPanel/BtnShatter/IconNew")

	fragRD:addHint({
		UIConst.RD_HINT_BAG_SHATTER
	})

	self.btnItemWear = UIControls.Button(self, "MainInfoPanel/TabPanel/BtnWearing")

	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BAGWEAR)

	self.btnItemWear:setVisible(not isLocked)

	self.imgWearIconNew = UIControls.Image(self, "MainInfoPanel/TabPanel/BtnWearing/IconNew")

	self:checkWearTabNew()

	local relicRD = UIControls.RedDot(self, "MainInfoPanel/TabPanel/BtnBadge/IconNew")

	relicRD:addHint({
		UIConst.RD_HINT_BAG_RELIC
	})

	local equipRD = UIControls.RedDot(self, "MainInfoPanel/TabPanel/BtnEquip/IconNew")

	equipRD:addHint({
		UIConst.RD_HINT_BAG_EQUIP
	})

	self.btnItemSkin = UIControls.Button(self, "MainInfoPanel/TabPanel/BtnSkin")

	self.btnItemSkin:setVisible(CurAvatar.skinItems and #CurAvatar.skinItems > 0)
	self.btnItemCommon:addEventClick(self.onClickTab)
	self.btnItemEquip:addEventClick(self.onClickTab)
	self.btnItemBadge:addEventClick(self.onClickTab)
	self.btnItemFragment:addEventClick(self.onClickTab)
	self.btnItemWear:addEventClick(self.onClickTab)
	self.btnItemSkin:addEventClick(self.onClickTab)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.tabConfig = {
		[Const.MODE_COMMON] = {
			self.btnItemCommon
		},
		[Const.MODE_EQUIP] = {
			self.btnItemEquip
		},
		[Const.MODE_GOD] = {
			self.btnItemBadge
		},
		[Const.MODE_FRAG] = {
			self.btnItemFragment
		},
		[Const.MODE_WEAR] = {
			self.btnItemWear
		},
		[Const.MODE_SKIN] = {
			self.btnItemSkin
		}
	}
	self.panels = {}
	self.uiAni = UIControls.UIAni(self, "")

	self.uiAni:addEventFinish(self._onAniFinish)
end

function MainBagDlg:_onAniFinish(aniCom, aniName)
	if aniName == "InBagMainWindow" and self.panelWear and self.panelWear:getVisible() then
		self.panelWear:playPartEfx()
	end
end

function MainBagDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_BAG)
end

function MainBagDlg:setInitMode(tabMode)
	self:_realClickTab(self.tabConfig[tabMode][1])
end

function MainBagDlg:onClickTab(sender)
	if not CurAvatar then
		return
	end

	if self.mode == Const.MODE_WEAR and self.panelWear then
		local function func()
			self:_realClickTab(sender)
		end

		self.panelWear:closeDuel(Slot(func, self))
	else
		self:_realClickTab(sender)
	end
end

function MainBagDlg:_realClickTab(sender)
	for mode, btnConfig in pairs(self.tabConfig) do
		local btn = btnConfig[1]

		if sender == btn then
			btn:setEnable(false)

			self.mode = mode
		else
			btn:setEnable(true)
		end
	end

	self:refreshMode()
end

function MainBagDlg:refreshMode()
	local modePanel

	if self.mode == Const.MODE_FRAG then
		modePanel = "panelFrag"

		if not self.panelFrag then
			self.panelFrag = BagFragPart(self, "MainInfoPanel/BagList", "System/Bag/BagShatterPanel")
			self.panels[modePanel] = self.panelFrag
		end
	elseif self.mode == Const.MODE_EQUIP then
		modePanel = "panelEquip"

		if not self.panelEquip then
			self.panelEquip = BagEquipPart(self, "MainInfoPanel/BagList", "System/Bag/BagEquipPanel")
			self.panels[modePanel] = self.panelEquip
		end
	elseif self.mode == Const.MODE_GOD then
		modePanel = "panelArtifact"

		if not self.panelArtifact then
			self.panelArtifact = BagArtifactPart(self, "MainInfoPanel/BagList", "System/Bag/BagBadgePanel")
			self.panels[modePanel] = self.panelArtifact
		end
	elseif self.mode == Const.MODE_WEAR then
		modePanel = "panelWear"

		if not self.panelWear then
			self.panelWear = BagWearPart(self, "MainInfoPanel/BagList", "System/Bag/BagWearingPanel")
			self.panels[modePanel] = self.panelWear
		end
	elseif self.mode == Const.MODE_RELIC then
		modePanel = "panelRelic"

		if not self.panelRelic then
			self.panelRelic = BagRelicPart(self, "MainInfoPanel/BagList", "System/Bag/BagRelicPanel")
			self.panels[modePanel] = self.panelRelic
		end
	elseif self.mode == Const.MODE_SKIN then
		modePanel = "panelSkin"

		if not self.panelSkin then
			self.panelSkin = BagSkinPart(self, "MainInfoPanel/BagList", "System/Bag/BagSkinPanel")
			self.panels[modePanel] = self.panelSkin
		end
	else
		modePanel = "panelCommon"

		if not self.panelCommon then
			self.panelCommon = BagCommonPart(self, "MainInfoPanel/BagList", "System/Bag/BagMaterialPanel")
			self.panels[modePanel] = self.panelCommon
		end
	end

	for panelName, panel in pairs(self.panels) do
		if panelName == modePanel then
			panel:setVisible(true)
			panel:refreshData()
		else
			panel:setVisible(false)

			if panel.onPartClose then
				panel:onPartClose()
			end
		end
	end

	if self.panelWear and self.mode == Const.MODE_WEAR then
		self.panelWear:initPlanList()
		self.panelWear:trySwitchRelicBgm()
		self.panelWear:revertToCurWear()
	end
end

function MainBagDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = MainCell(sender, "MainCell", newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell
end

function MainBagDlg:onReconnect()
	self:refreshItem()
end

function MainBagDlg:refreshItem()
	for panelName, panel in pairs(self.panels) do
		if panel:getVisible() then
			if panelName == "panelWear" then
				panel:refreshNoSort()
				self:checkWearTabNew()
			else
				panel:refreshData()
			end
		end
	end
end

function MainBagDlg:refreshItemAndFragBag()
	if self.panelCommon and self.panelCommon:getVisible() then
		self.panelCommon:refreshData()
	end

	if self.panelFrag and self.panelFrag:getVisible() then
		self.panelFrag:refreshData()
	end
end

function MainBagDlg:checkWearTabNew()
	self.imgWearIconNew:setVisible(false)
end

function MainBagDlg:onCloseClick(sender)
	if self.mode == Const.MODE_WEAR and self.panelWear then
		local function func()
			self:setVisible(false)
		end

		self.panelWear:closeDuel(Slot(func, self))
	else
		self:setVisible(false)
	end
end

function MainBagDlg:onItemSellCheck(grid)
	return grid.object:sellEnable()
end

function MainBagDlg:onSellItem(grid)
	if grid.object.resData.sell_condition then
		local isLocked = ConditionLimitManager.inLimitState(grid.object.resData.sell_condition)

		if isLocked then
			MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(grid.object.resData.sell_condition))

			return
		else
			UIManager.getUI("itemSellDlg", true):onShow(grid.object)
		end
	else
		UIManager.getUI("itemSellDlg", true):onShow(grid.object)
	end
end

function MainBagDlg:onItemComposeCheck(grid)
	return grid.object:isFragmentItem()
end

function MainBagDlg:onItemComposeEnableCheck(grid)
	local itemCount = CurAvatar:getItemNumById(grid.object.id)
	local needCount = grid.object.resData.extend_args1

	if needCount and itemCount then
		return needCount <= itemCount
	else
		return false
	end
end

function MainBagDlg:onComposeItem(grid)
	local bagType = 0

	if grid.object.subType == Const.ITEM_STYPE_RAND_EQUIP_FRAG then
		bagType = Const.BAG_TYPE_EQUIP
	elseif grid.object.subType == Const.ITEM_STYPE_RAND_ARTIFACT_FRAG then
		bagType = Const.BAG_TYPE_ARTIFACT
	elseif grid.object.subType == Const.ITEM_STYPE_RAND_HERO_FRAG or grid.object.subType == Const.ITEM_STYPE_HERO_FRAG then
		bagType = Const.BAG_TYPE_HERO
	end

	if CurAvatar:getBagBlankByBagType(bagType) <= 0 then
		CurAvatar:confirmBagAdd(bagType)

		return
	end

	local heroIdMaxStarDic = CurAvatar:getIdMaxStarDic()
	local noticeId = grid.object:getCantComposeNoticeId(heroIdMaxStarDic)

	if noticeId then
		if type(noticeId) == "string" then
			MsgManager.notice(noticeId)
		else
			MsgManager.clientNotice(noticeId)
		end

		return
	end

	UIManager.getUI("itemSellDlg", true):onShow(grid.object, 1)
end

function MainBagDlg:onBuildStone(grid)
	local heroEquipBuildDlg = UIManager.getUI("heroEquipBuildDlg", true)

	heroEquipBuildDlg:setData(Const.BUILD_PANEL_TYPE_EQUIP, grid.object)
end

function MainBagDlg:onBuildStoneCheck(grid)
	if Const.EQUIP_BUILD_OPEN and grid.object.subType == Const.ITEM_STYPE_BUILD_STONE then
		return grid.object.num > 0
	end
end

function MainBagDlg:onItemUseCheck(grid)
	local overdue = grid.object:isOverdue()

	if grid.object.subType == Const.ITEM_STYPE_HERO_PAINT_MATERIAL then
		return grid.object.resData.extend_args1 ~= nil and grid.object.resData.forbid_use_in_bag == nil
	end

	return Const.BAG_USE_BUTTON_STYPE[grid.object.subType] ~= nil and grid.object.num > 0 and (not overdue or grid.object.subType == Const.ITEM_STYPE_RAND_GIFT_PKG) and grid.object.resData.forbid_use_in_bag == nil
end

function MainBagDlg:onUseItem(grid)
	if grid.object.subType == Const.ITEM_STYPE_RENAME_TICKET then
		CurAvatar:canRename()
	elseif grid.object.subType == Const.ITEM_STYPE_RECHARGE_ITEM then
		local use = {}

		use.data = {}
		use.data.id = grid.object.id
		use.data.num = 1

		RPC.itemUse({
			use
		})
	elseif grid.object.subType == Const.ITEM_STYPE_RED_PACKET then
		local ui = UIManager.getUI("openItemConfirmDlg", true)

		ui:onShow(grid.object)

		local uiModel = require("UI/Chat/ChooseRedPacketDlg")

		if uiModel then
			ui:showBlessingPanel(uiModel.randBlessing)
		end

		ui:setNumLimit(Const.MAX_RED_PACKET_USE_NUM, 1)
	elseif grid.object.subType == Const.ITEM_STYPE_HERO_PAINT_MATERIAL then
		local paintHeroId = grid.object.resData.extend_args1

		CurAvatar:_jumpToHero(paintHeroId, self, 12)
	elseif grid.object.subType == Const.ITEM_STYPE_UPGRADE_SKIN then
		local canUse, preSkinData = CurAvatar:checkUseItemByHasSkin(grid.object)

		if canUse then
			local use = {}

			use.data = {}
			use.data.id = grid.object.id
			use.data.num = grid.object.num

			RPC.itemUse({
				use
			})
		elseif preSkinData then
			MsgManager.notice(string.format(Lang.get(117199), preSkinData.name or ""))
			BaseObject.ShowObjectTips(preSkinData.item_id, 1, self, {
				CloseSrcWindow = 1,
				AutoOpenGuide = 1,
				noPreview = 1
			})
		end
	else
		UIManager.getUI("openItemConfirmDlg", true):onShow(grid.object)
	end
end

function MainBagDlg:onChooseGiftUseCheck(grid)
	if grid.object.subType == Const.ITEM_STYPE_RAND_LIMIT_SELECT or grid.object.subType == Const.ITEM_STYPE_RAND_SELECT_GIFT_PKG then
		return grid.object.resData.forbid_use_in_bag == nil and grid.object.num > 0
	end
end

function MainBagDlg:onUseChooseGift(grid)
	local giftType = grid.object.resData.extend_args1

	if (giftType == Const.ITEM_CHOOSE_GIFT_GROUP or giftType == Const.ITEM_CHOOSE_GIFT_HERO) and CurAvatar:getHeroRemainBlankNum() <= 0 then
		CurAvatar:confirmBagAdd(Const.BAG_TYPE_HERO)

		return
	end

	if giftType == Const.ITEM_CHOOSE_GIFT_EQUIP and CurAvatar:getEquipRemainBlankNum() <= 0 then
		CurAvatar:confirmBagAdd(Const.BAG_TYPE_EQUIP)

		return
	end

	if giftType == Const.ITEM_CHOOSE_GIFT_BADGE and CurAvatar:getArtifactRemainBlankNum() <= 0 then
		CurAvatar:confirmBagAdd(Const.BAG_TYPE_ARTIFACT)

		return
	end

	UIManager.getUI("openBoxChooseDlg", true):openChoose(grid.object)
end

function MainBagDlg:onSpecialJumpCheck(grid)
	if grid.object.resData and grid.object.resData.special_jump_id then
		return true
	elseif grid.object.subType == Const.ITEM_STYPE_BRACELET_EXCHANGE then
		return true
	else
		return false
	end
end

function MainBagDlg:onSpecialJump(grid)
	if grid.object.resData and grid.object.resData.special_jump_id then
		JumpGuideManager.jump(grid.object.resData.special_jump_id, self)
	elseif grid.object.subType == Const.ITEM_STYPE_BRACELET_EXCHANGE then
		local ui = UIManager.getUI("activityBraceletExchangeDlg", true)

		ui:setData(grid.object.id)
	end
end

function MainBagDlg:openDefaultPage()
	self:onClickTab(self.btnItemCommon)
end

return MainBagDlg
