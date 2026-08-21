-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Equip\\RelicWearDlg.lua

local RelicTipsInfoPanel = require("UI/Common/Tips/RelicTipsInfoPanel")
local GridRelicWearItem = require("UI/Equip/GridRelicWearItem")
local ResItem = require("ClientData/ResItem")
local strClassName = "RelicWearDlg"
local RelicWearDlg = Class(strClassName, UIControls.Window)

function RelicWearDlg:ctor()
	self:initUI()
end

function RelicWearDlg:initUI()
	self.cells = {}
	self.panelRelicTip = RelicTipsInfoPanel(self, "MainInfoPanel/RelicInfoPanel")
	self.txtRule = UIControls.Label(self, "MainInfoPanel/RelicInfoPanel/TextRuleList/Content/TextRule")
	self.txtName = UIControls.Label(self, "MainInfoPanel/TextName")
	self.sliderEnhance = UIControls.Slider(self, "MainInfoPanel/Slider")
	self.txtEnhanceNum = UIControls.Label(self, "MainInfoPanel/TextSliderNum")
	self.imgMax = UIControls.Image(self, "MainInfoPanel/ImgMax")
	self.btnWear = UIControls.Button(self, "MainInfoPanel/BtnWear")

	self.btnWear:addEventClick(self.onBtnWearClick)

	self.btnRemove = UIControls.Button(self, "MainInfoPanel/BtnRemove")

	self.btnRemove:addEventClick(self.onBtnRemoveClick)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnUpgrade = UIControls.Button(self, "MainInfoPanel/BtnUpgrade")

	self.btnUpgrade:addEventClick(self.onBtnUpgradeClick)

	self.txtGoldCost = UIControls.Label(self, "MainInfoPanel/BtnUpgrade/TextNum")
	self.imgIconSelectedRelic = UIControls.Image(self, "MainInfoPanel/GridRelicPanel")
	self.txtSelectedLv = UIControls.Label(self, "MainInfoPanel/TextLv")
	self.scrollRelic = UIControls.ScrollViewLoopV(self, "MainInfoPanel/RelicList")

	self.scrollRelic:addEventCellChanged(self.onRelicChanged)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.iconCost = UIControls.Image(self, "MainInfoPanel/BtnUpgrade/Icon")
end

function RelicWearDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_RELIC_WEAR)
end

function RelicWearDlg:onRelicChanged(sender, targetCell, newIdx)
	targetCell = targetCell or GridRelicWearItem(sender, "System/Common/Grid/GridRelicWearItem", newIdx)

	if not self.relicList or #self.relicList == 0 then
		return
	end

	if self.relicList[newIdx] ~= nil then
		targetCell.mEnableTips = false
		targetCell.mEventClick = Slot(self.selectRelic, self)

		targetCell:setObj(self.relicList[newIdx], newIdx)
		targetCell:setBeSelect(self.selectedRelic.id == targetCell.object.id)
	end

	self.cells[newIdx] = targetCell
end

function RelicWearDlg:selectRelic(sender)
	self.selectedRelic = sender.object

	self:refreshRelicInfo()
	self.scrollRelic:setTotalCount(#self.relicList)
end

local function _sortRelic(a, b)
	if a.quality ~= b.quality then
		return a.quality > b.quality
	elseif a.enhanceLevel ~= b.enhanceLevel then
		return a.enhanceLevel > b.enhanceLevel
	elseif a.id ~= b.id then
		return a.id > b.id
	end
end

function RelicWearDlg:setHero(hero, relicList, isFromEditPlan, isFromCircleBattle, isFromBattle, isFromNewMaze, isFromSneakBattle)
	if isFromBattle then
		self.mWindow.panelFund:setVisible(false)
	end

	self.hero = hero
	self.isFromEditPlan = isFromEditPlan
	self.isFromCircleBattle = isFromCircleBattle
	self.isFromBattle = isFromBattle
	self.isFromNewMaze = isFromNewMaze
	self.isFromSneakBattle = isFromSneakBattle
	self.wearRelic = self.hero:getRelic()
	self.relicList = relicList

	if self.wearRelic then
		for _, relic in ipairs(self.relicList) do
			if self.wearRelic.id == relic.id then
				self.selectedRelic = relic
			end
		end
	end

	table.sort(self.relicList, _sortRelic)

	if not self.selectedRelic then
		self.selectedRelic = self.relicList[1]
	end

	self:refreshRelicInfo()
	self.scrollRelic:setTotalCount(#self.relicList)
end

function RelicWearDlg:refreshForNewRelic(relic)
	for i, _relic in ipairs(self.relicList) do
		if _relic.id == relic.id then
			self.relicList[i] = relic
		end
	end

	self:setHero(self.hero, self.relicList)
end

function RelicWearDlg:refreshForNewSelectedRelic(relic, hero)
	for i, _relic in ipairs(self.relicList) do
		if _relic.id == relic.id then
			self.relicList[i] = relic
		end
	end

	self.selectedRelic = relic

	if hero then
		self.hero = hero
		self.wearRelic = self.hero:getRelic()
	end

	self:refreshRelicInfo()
	self.scrollRelic:setTotalCount(#self.relicList)
end

function RelicWearDlg:refreshRelicInfo()
	self.txtName:setText(self.selectedRelic.name)
	self.txtRule:setText(self.selectedRelic.desc)
	self.panelRelicTip:setRelic(self.selectedRelic, self.hero)
	self.btnWear:setVisible(self.wearRelic == nil or self.wearRelic.id ~= self.selectedRelic.id)
	self.btnRemove:setVisible(self.wearRelic ~= nil and self.selectedRelic.id == self.wearRelic.id)

	self.lvUpNeedInfo = self.selectedRelic:getLvUpNeed()

	if self.lvUpNeedInfo then
		self.sliderEnhance:setVisible(true)
		self.txtEnhanceNum:setVisible(true)

		local haveNum = CurAvatar:getItemNumById(self.selectedRelic.lvUpMaterialId)
		local needNum = self.lvUpNeedInfo[self.selectedRelic.lvUpMaterialId]

		self.sliderEnhance:setValue(haveNum / needNum)
		self.txtEnhanceNum:setText(haveNum .. "/" .. needNum)

		if self.isFromEditPlan then
			self.btnUpgrade:setVisible(false)
		else
			self.btnUpgrade:setVisible(true)
			self.btnUpgrade:setObjGray(not CurAvatar:relicCanLvUp(self.selectedRelic))
		end

		local costItemId = self.selectedRelic.resData.level_up_item_id or Const.MONEY_ID_GOLD
		local iconPathTmp = BaseObject.GetObject(costItemId):getIconPath()

		if iconPathTmp then
			self.iconCost:setImage(iconPathTmp[1], iconPathTmp[2])
		end

		self.txtGoldCost:setText(ClientUtils.getNumShortStr(self.lvUpNeedInfo[costItemId]))
	else
		self.sliderEnhance:setVisible(false)
		self.txtEnhanceNum:setVisible(false)
		self.btnUpgrade:setVisible(false)
	end

	self.imgMax:setVisible(self.selectedRelic:isEnhanceLvMax())

	local iconPath = self.selectedRelic:getIconPath()

	if iconPath then
		self.imgIconSelectedRelic:setImage(iconPath[1], iconPath[2])
	end

	self.txtSelectedLv:setVisible(false)

	if not self.selectedRelic:isEnhanceLvMax() and self.selectedRelic.enhanceLevel ~= 0 then
		self.txtSelectedLv:setText(string.format(Lang.get(30171), self.selectedRelic.enhanceLevel))
		self.txtSelectedLv:setVisible(true)
	end
end

function RelicWearDlg:onBtnUpgradeClick()
	if self.lvUpNeedInfo then
		for materialId, needNum in pairs(self.lvUpNeedInfo) do
			if needNum > CurAvatar:getItemNumById(materialId) then
				if ResItem[materialId] then
					MsgManager.notice(string.format(Lang.get(30029), ResItem[materialId].name))
				end

				return
			end
		end
	end

	RPC.relicLevelUp(self.selectedRelic.id, self.selectedRelic.enhanceLevel + 1)
end

function RelicWearDlg:onBtnCloseClick()
	self:setVisible(false)
end

function RelicWearDlg:onBtnWearClick()
	if self.isFromCircleBattle then
		RPC.clanBattleSetRelic(self.hero.id, self.selectedRelic.id)
	elseif self.isFromEditPlan then
		CurAvatar:changeWearPartPlanData(self.hero, nil, nil, self.selectedRelic.id, true)
		self:setVisible(false)
	elseif self.isFromNewMaze then
		local actObj = CurAvatar:getNewMazeActivity()

		if actObj then
			RPC.newMazeSetOutsideRelic(actObj.opId, self.hero.id, self.selectedRelic.id)
		end
	elseif self.isFromSneakBattle then
		local actData = CurAvatar:getSneakBattleActivityData()

		if actData then
			local opId = actData.actObject.opId

			RPC.newPveWearRelic(opId, self.hero.id, self.selectedRelic.id)
		end
	else
		RPC.relicWear(self.hero.gid, self.selectedRelic.id)
	end
end

function RelicWearDlg:onBtnRemoveClick()
	if self.isFromCircleBattle then
		RPC.clanBattleSetRelic(self.hero.id, 0)
	elseif self.isFromEditPlan then
		CurAvatar:changeWearPartPlanData(self.hero, nil, nil, 0, true)
		self:setVisible(false)
	elseif self.isFromNewMaze then
		local actObj = CurAvatar:getNewMazeActivity()

		if actObj then
			RPC.newMazeSetOutsideRelic(actObj.opId, self.hero.id, 0)
		end
	elseif self.isFromSneakBattle then
		local actData = CurAvatar:getSneakBattleActivityData()

		if actData then
			local opId = actData.actObject.opId

			RPC.newPveWearRelic(opId, self.hero.id, 0)
		end
	else
		RPC.relicOff(self.hero.gid)
	end
end

return RelicWearDlg
