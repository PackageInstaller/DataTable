-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\ItemTips.lua

local ItemGuidePanel = require("UI/Common/Tips/ItemGuidePanel")
local ResPowerMisc = require("ClientData/ResPowerMisc")
local ResColor = require("ClientData/ResColor")
local strClassName = "ItemTips"
local ResRandClient = require("ClientData/ResRandClient")
local ItemTips = Class(strClassName, UIControls.Tips)
local LayoutElementType = typeof(UnityEngine.UI.LayoutElement)
local ResItemConvert = require("ClientData/ResItemConvert")

function ItemTips:ctor()
	self:initUI()
end

function ItemTips:initUI()
	self.gridItem = UIControls.ItemGridChild(self, "BgPanel/GridPanel", "System/Common/Grid/GridMaterialItem")

	self.gridItem:setVisible(true)

	self.gridItem.mEnableTips = false
	self.textName = UIControls.Label(self, "BgPanel/TextName")
	self.textType = UIControls.Label(self, "BgPanel/TextName/TextType")
	self.textDesc = UIControls.Label(self, "BgPanel/TextRule")
	self.textNum = UIControls.Label(self, "BgPanel/TextNum")
	self.textTime = UIControls.Label(self, "BgPanel/TextTime")
	self.textSell = UIControls.Label(self, "BgPanel/TextSell")

	self:initFuncBtn(3)

	self.panelGuide = ItemGuidePanel(self, "BgPanel/TipsWayPanel")
	self.txtRecover = UIControls.Label(self, "BgPanel/TextRecover")
	self.btnGuild = UIControls.Button(self, "BgPanel/BtnWay")

	self.btnGuild:addEventClick(self.onClickGuild)

	self.panelAwardPreview = UIControls.Panel(self, "BgPanel/ShowAwardItemPanel")
	self.layoutAwardPreview = self.panelAwardPreview:getComObj().transform:GetComponent(LayoutElementType)
	self.previewGrids = {}

	if UIControls.checkControlFunc(self, "BgPanel/IconChange") then
		self.panelIconChange = UIControls.Panel(self, "BgPanel/IconChange")
		self.textChange = UIControls.Label(self, "BgPanel/TextChange")
	end
end

function ItemTips:timeDownCallBack(...)
	self.txtRecover:setText(Lang.get(973))
end

function ItemTips:_setObj(grid)
	self.srcGrid = grid
	self.item = grid.object

	if not self.item or not self.item.resData then
		return
	end

	self.gridItem:setObj(BaseObject.GetObject(self.item.id))
	self.textName:setText(self.item.resData.name or "")
	self.textType:setText(self.item.resData.type_name or "")
	self.textDesc:setText(self.item.resData.desc or "")

	local numStr = string.format(Lang.get(30234), ClientUtils.getNumShortStr(CurAvatar:getItemNumById(self.item.id, self.srcGrid.inBag == true)))

	self.textNum:setText(numStr)

	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_ITEM_GUILD) then
		self.btnGuild:setVisible(false)
	elseif not self.srcGrid.mDisableWays and self.item.resData.get_ids and #self.item.resData.get_ids > 0 then
		self.btnGuild:setVisible(true)

		if self.uiConfig and self.uiConfig.AutoOpenGuide then
			self:onClickGuild()
		end
	else
		self.btnGuild:setVisible(false)
	end

	self.txtRecover:setVisible(self.item.id == Const.MONEY_ID_POWER)

	if self.item.id == Const.MONEY_ID_POWER then
		self.textNum:setText(utils.format(Lang.get(30244), CurAvatar.realPowerNum, CurAvatar:getPowerResumeMax()))

		if CurAvatar.realPowerNum < CurAvatar:getPowerResumeMax() then
			local oldValue = CurAvatar:getMoneyByType(Const.MONEY_TYPE_POWER)
			local totalRecoverTime = (CurAvatar:getPowerResumeMax() - oldValue) * CurAvatar:getPowerResumeSeconds()
			local remainTime = CurAvatar.powerResumeTime + totalRecoverTime - ClientUtils.getServerTime()

			ClientTimerManager.AddSecondFormatTickUI(self.txtRecover, remainTime, false, Lang.get(30246), Slot(self.timeDownCallBack, self))
		else
			self:timeDownCallBack()
			ClientTimerManager.RemoveSecondTickUI(self.txtRecover)
		end
	end

	if (self.item.id == Const.MONEY_ID_FAKE_DIAMOND or self.item.id == Const.MONEY_ID_DIAMOND) and RegionUtils.isJP() then
		numStr = numStr .. "\n<color=#696969>※所持数は有償ダイヤと無償ダイヤの合計となります。</color>"

		self.textNum:setText(numStr)
	end

	if Const.ACTIVITY_NO_BAG_ITEM_IDS[self.item.id] then
		self.textNum:setText(utils.format(Lang.get(54585), ClientUtils.getNumShortStr(self.item.num)))
	end

	if Const.HIDE_GRID_NUM_TYPE[self.item.subType] ~= nil then
		self.textNum:setVisible(false)
		self.textSell:setVisible(false)
	end

	local remainSellTime = 0
	local txtTimeVisble = false

	if self.item.resData.related_activity then
		txtTimeVisble = true

		local actObj = self.item:getRelatedActivity()

		if actObj and actObj:isValid() and not actObj:inFreeze() and actObj:getRemainOpenTime() > 0 then
			remainSellTime = actObj:getRemainOpenTime()
		end
	end

	if self.item.resData.overdue_time then
		txtTimeVisble = true

		local overTime = ClientUtils.getServerTimeByTimeStr(self.item.resData.overdue_time)

		if overTime > ClientUtils.getServerTime() then
			remainSellTime = overTime - ClientUtils.getServerTime()
		end
	end

	self.textTime:setVisible(txtTimeVisble)

	if remainSellTime > 0 then
		local preStr = Lang.get(48662)

		ClientTimerManager.AddSecondFormatTickUI(self.textTime, remainSellTime, false, preStr)
	else
		ClientTimerManager.RemoveSecondTickUI(self.textTime)
		self.textTime:setText(string.format(Lang.get(30245), ResColor.RED.ff))
	end

	if self.item.sellEnable and self.item:sellEnable() and self.item.resData.sell_price then
		self.textSell:setText(string.format(Lang.get(30235), self.item:getSellPriceStr() or ""))
	else
		self.textSell:setText(Lang.get(970))
	end

	for index, grid in ipairs(self.previewGrids) do
		grid:destroy()
	end

	self.previewGrids = {}

	if self.item.subType == Const.ITEM_STYPE_RAND_SELECT_GIFT_PKG and self.item.resData.extend_args3 and not self.item.resData.hide_select_items then
		self.panelAwardPreview:setVisible(true)

		local chooseType = self.item.resData.extend_args1

		for i, random_id in ipairs(self.item.resData.extend_args3) do
			if ClientUtils.IsRandomValid(random_id) and ResRandClient[random_id].show_ids and ResRandClient[random_id].show_nums then
				local itemId = ResRandClient[random_id].show_ids[1]
				local itemNum = ResRandClient[random_id].show_nums[1]

				self:createShowPreiviewGrid(chooseType, itemId, itemNum)
			end
		end
	elseif self.item.subType == Const.ITEM_STYPE_RAND_LIMIT_SELECT and not self.item.resData.hide_select_items then
		self.panelAwardPreview:setVisible(true)

		for i, artifactId in ipairs(self.item.resData.extend_args3) do
			local limitNum = self.item.resData.extend_args4[i]
			local num = 1

			if self.item.resData.extend_args5 then
				num = self.item.resData.extend_args5[i] or 1
			end

			local grid = self:createShowPreiviewGrid(nil, artifactId, num)

			if grid.object.itemType == Const.ITEM_TYPE_ARTIFACT then
				if limitNum and limitNum > 0 and CurAvatar:getIsHaveArtifactById(artifactId) then
					grid:setGot(true)
				end
			elseif grid.object.itemType == Const.ITEM_TYPE_SKIN then
				grid:refreshGet()
			end
		end
	elseif self.item.resData.drop_rand_id then
		self.panelAwardPreview:setVisible(true)
		ClientUtils.CreateBonusGrid(self, self.previewGrids, "BgPanel/ShowAwardItemPanel/ItemListScroll/Content", self.item.resData.drop_rand_id)

		for _, grid in ipairs(self.previewGrids) do
			grid:setTipsEnable(false)
		end
	else
		self.panelAwardPreview:setVisible(false)
	end

	if #self.previewGrids <= 4 then
		self.layoutAwardPreview.preferredHeight = 120
	elseif #self.previewGrids <= 8 then
		self.layoutAwardPreview.preferredHeight = 245
	else
		self.layoutAwardPreview.preferredHeight = 320
	end

	if self.panelIconChange then
		local checkConvertObject = self.checkNeedConvertObject and BaseObject.checkConvertObject(self.item)

		self.panelIconChange:setVisible(checkConvertObject)
		self.textChange:setVisible(checkConvertObject)

		if checkConvertObject then
			self.textNum:setVisible(false)

			local resItemConvert = ResItemConvert[self.item.id]

			self.textChange:setText(resItemConvert.des)
		end
	end
end

function ItemTips:createShowPreiviewGrid(chooseType, itemId, itemNum)
	if chooseType == Const.ITEM_CHOOSE_GIFT_EQUIP then
		local suitCell = UIConst.BtnChooseEquipSet(self, "BgPanel/ShowAwardItemPanel/ItemListScroll/Content", "System/Bag/BtnChooseEquipSet", 0, 0, true)

		suitCell:setSuitInfo(itemId)
		table.insert(self.previewGrids, suitCell)

		return suitCell
	else
		local item = BaseObject.GetObject(itemId, itemNum)
		local itemGrid = UIControls.getGridChild(item, self, "BgPanel/ShowAwardItemPanel/ItemListScroll/Content", true)

		itemGrid.mEnableTips = false

		itemGrid:setObj(item)
		itemGrid:setVisible(true)
		table.insert(self.previewGrids, itemGrid)

		return itemGrid
	end
end

function ItemTips:timerRecoverPowerTimerFunc()
	local oldValue = CurAvatar:getMoneyByType(Const.MONEY_TYPE_POWER)
	local totalRecoverTime = (CurAvatar:getPowerResumeMax() - oldValue) * CurAvatar:getPowerResumeSeconds()
	local remainTime = CurAvatar.powerResumeTime + totalRecoverTime - ClientUtils.getServerTime()

	self.txtRecover:setText(string.format(Lang.get(30246), utils.calcTimeTxt(math.max(remainTime, 0))))
end

function ItemTips:destroy()
	ItemTips.super.destroy(self)

	if self.recoverPowerTimer then
		self.recoverPowerTimer:Stop()

		self.recoverPowerTimer = nil
	end
end

function ItemTips:clear()
	ItemTips.super.clear(self)
	self.gridItem:clear()
end

function ItemTips:onClickGuild()
	self.panelGuide:show(self.item.resData.get_ids, self.srcGrid, self.uiConfig)
end

return ItemTips
