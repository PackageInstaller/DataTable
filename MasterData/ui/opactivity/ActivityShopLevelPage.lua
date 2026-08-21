-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityShopLevelPage.lua

local ResShopExchg = require("ClientData/ResShopExchg")
local ShopItem = require("UI/MainState/Trade/ShopItem")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local ResOpActivityAchieveMisc = require("ClientData/ResOpActivityAchieveMisc")
local UIControls = UIControls
local classNameStr = "ActivityShopLevelAchievePanel"
local ActivityShopLevelAchievePanel = Class(classNameStr, UIControls.Panel)

function ActivityShopLevelAchievePanel:ctor()
	self:initUI()
end

function ActivityShopLevelAchievePanel:initUI()
	self.textTitle = UIControls.Label(self, self.mPath .. "/TxtTitle")
	self.panelFinish = UIControls.Panel(self, self.mPath .. "/EndPanel")
	self.panelNml = UIControls.Panel(self, self.mPath .. "/GetAwardPanel")
	self.textRule = UIControls.Label(self, self.mPath .. "/GetAwardPanel/RulePanel/TxtNum")
	self.sliderBuy = UIControls.Slider(self, self.mPath .. "/GetAwardPanel/RoyalSlider")
	self.textBuy = UIControls.Label(self, self.mPath .. "/GetAwardPanel/ProgressText")
	self.sliderAchieve = UIControls.Slider(self, self.mPath .. "/GetAwardPanel/AwardSlider")
	self.btnAchieve = UIControls.Button(self, self.mPath .. "/BtnPreview")

	self.btnAchieve:addEventClick(self.onClickAchieve)

	self.imgAchieveItem = UIControls.Button(self, self.mPath .. "/GetAwardPanel/AwardSlider/Fill Area/Fill/GemPanel/Icon")

	self.imgAchieveItem:addEventClick(self.onAchieveItemClick)

	self.labelAchieveItem = UIControls.Label(self, self.mPath .. "/GetAwardPanel/AwardSlider/Fill Area/Fill/GemPanel/TxtNum")
	self.bonusGrids = {}
	self.efxProgress = UIControls.Panel(self, self.mPath .. "/GetAwardPanel/EfxToken")
	self.efxAchieve = UIControls.Panel(self, self.mPath .. "/GetAwardPanel/EfxSlider")
	self.efxAchieveUp = UIControls.Panel(self, self.mPath .. "/GetAwardPanel/EfxAward")
end

function ActivityShopLevelAchievePanel:setData(achieveActObj)
	self.achieveActObj = achieveActObj

	local actData = achieveActObj.actData

	self.miscData = ResOpActivityAchieveMisc[self.achieveActObj.actId]

	for achieveType, typeData in pairs(actData.clientData) do
		self.achieveType = achieveType
		self.typeData = typeData

		break
	end

	if not self.achieveType then
		return
	end

	if self.miscData then
		self.miscData = self.miscData[self.achieveType]

		if self.miscData and self.miscData.item_id then
			self.itemId = self.miscData.item_id
		end
	end

	local coroutineAction = false
	local shopActData = self.mParent.actObj.actData
	local buyProgress = shopActData.shopLevelProgress or 0

	if self.buyProgress ~= buyProgress then
		self.buyProgress = buyProgress

		local miscData = shopActData.miscData

		if miscData and miscData.item_cost_need_num then
			local round = math.floor(buyProgress / miscData.item_cost_need_num)
			local extra = buyProgress % miscData.item_cost_need_num

			if self.round and round > self.round then
				self.coAnim = coroutine.start(self.coBuyProgressAnim, self, round, extra / miscData.item_cost_need_num, extra .. "/" .. miscData.item_cost_need_num)

				return
			else
				self.round = round

				self.sliderBuy:setValue(extra / miscData.item_cost_need_num)
				self.textBuy:setText(extra .. "/" .. miscData.item_cost_need_num)
			end
		end
	end

	self:_showProgress()
end

function ActivityShopLevelAchievePanel:_showProgress(noCoroutine)
	local actData = self.achieveActObj.actData

	self.achieveProgress = actData:getAchieveProgress(self.achieveType)

	local hasProgress, levelRate, preRoundProgress
	local nData, hasProgress, levelRate, preRoundProgress = actData:getNextAchieveInfo()

	if self.nData and self.nData.index < nData.index and not noCoroutine then
		local preIndex = self.nData.index

		self.nData = nData
		self.coAnim = coroutine.start(self.coAchieveProgressAnim, self, levelRate, preIndex)
	else
		self.nData = nData

		if levelRate >= 1 then
			self.panelNml:setVisible(false)
			self.panelFinish:setVisible(true)
		else
			self.panelNml:setVisible(true)
			self.panelFinish:setVisible(false)
			self.textRule:setText(self.nData.desc_name or "")
			self.sliderAchieve:setValue(levelRate, 0.3)
			self.labelAchieveItem:setText("X" .. self.achieveProgress)
			ClientUtils.CreateBonusGrid(self, self.bonusGrids, self.mPath .. "/GetAwardPanel/GridPanel", self.nData.award)
		end
	end
end

function ActivityShopLevelAchievePanel:coAchieveProgressAnim(levelRate, preIndex)
	for index = preIndex, self.nData.index - 1 do
		self.sliderAchieve:setValue(1, 0.5)
		coroutine.wait(0.5)
		self.efxAchieveUp:setVisible(false)
		self.efxAchieveUp:setVisible(true)
		self.sliderAchieve:setValue(0)

		if index ~= self.nData.index - 1 then
			self.panelNml:setVisible(true)
			self.panelFinish:setVisible(false)

			local nData = self.typeData[index + 1]

			self.textRule:setText(nData.desc_name or "")
			self.labelAchieveItem:setText("X" .. self.achieveProgress)
			ClientUtils.CreateBonusGrid(self, self.bonusGrids, self.mPath .. "/GetAwardPanel/GridPanel", nData.award)
		end
	end

	coroutine.wait(0.5)

	if levelRate >= 1 then
		self.panelNml:setVisible(false)
		self.panelFinish:setVisible(true)
	else
		self.panelNml:setVisible(true)
		self.panelFinish:setVisible(false)
		self.textRule:setText(self.nData.desc_name or "")
		self.sliderAchieve:setValue(levelRate, 0.3)
		self.labelAchieveItem:setText("X" .. self.achieveProgress)
		ClientUtils.CreateBonusGrid(self, self.bonusGrids, self.mPath .. "/GetAwardPanel/GridPanel", self.nData.award)
	end
end

function ActivityShopLevelAchievePanel:coBuyProgressAnim(round, newRate, proStr)
	local needRound = round - self.round

	self.round = round

	self.sliderBuy:setValue(1, 0.5)
	coroutine.wait(0.5)
	self.efxProgress:setVisible(false)
	self.efxProgress:setVisible(true)
	self.sliderBuy:setValue(0)
	self.efxAchieve:setVisible(false)
	self.efxAchieve:setVisible(true)
	self.textBuy:setText(proStr)

	if self.itemId then
		FlyIconUtils.setFlyUItoUI(self.sliderBuy, self.imgAchieveItem, self.itemId, needRound, 0.5)
	end

	coroutine.wait(0.5)
	self.sliderBuy:setValue(newRate, 0.5)

	self.coAnim = nil

	self:_showProgress()
end

function ActivityShopLevelAchievePanel:onClickAchieve()
	UIManager.getUI("activityShopAchieveDlg", true):onShowActivity({
		self.achieveActObj.clientTemplateData or {},
		self.achieveActObj
	})
end

function ActivityShopLevelAchievePanel:onAchieveItemClick()
	if self.itemId then
		local fakeItem = BaseObject.GetObject(self.itemId)

		UIManager.getUI("itemTips"):showObj(self.mWindow, fakeItem, {
			AutoOpenGuide = 1
		})
	end
end

function ActivityShopLevelAchievePanel:onClosePanel()
	if self.coAnim then
		coroutine.stop(self.coAnim)
		self.efxAchieve:setVisible(false)
		self.efxProgress:setVisible(false)
		self:_showProgress(true)

		self.coAnim = nil
	end
end

local classNameStr = "ActivityShopLevelPanel"
local ActivityShopLevelPanel = Class(classNameStr, UIControls.Child)

MixinClass(ActivityShopLevelPanel, ActivityPanelMixin)

function ActivityShopLevelPanel:initUI()
	self._slot4CellClick = Slot(self._onShopItemClick, self)
	self.scrollItems = UIControls.ScrollViewLoopV(self, "ContentList", 0, self._onCellChanged)
	self.cells = {}
	self.textHas = UIControls.Label(self, "HavePanel/TextNum")
	self.btnCost = UIControls.Button(self, "BtnIcon")

	self.btnCost:addEventClick(self.onClickCost)

	self.textRule = UIControls.Label(self, "BgDes/TextDes")
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.cells = {}
	self.panelLevel = UIControls.Panel(self, "LevelPanel")
	self.textLevel = UIControls.Label(self, "LevelPanel/TxtNum")
	self.sliderLevel = UIControls.Slider(self, "LevelPanel/TaskSlider")
	self.textLevelProgress = UIControls.Label(self, "LevelPanel/TaskSlider/Fill Area/ProgressPanel/ProgressText")
	self.btnLevelUp = UIControls.Button(self, "LevelPanel/BtnUpdate")

	self.btnLevelUp:addEventClick(self.onLevelUpClick)

	self.btnLevelUpDis = UIControls.Button(self, "LevelPanel/BtnUpdateDis")

	self.btnLevelUpDis:addEventClick(self.onLevelUpDisClick)

	self.panelMax = UIControls.Panel(self, "LevelPanel/IconMax")
	self.btnBonus = UIControls.Button(self, "LevelPanel/BtnItemPreview")

	self.btnBonus:addEventClick(self.onPreviewBonus)

	local clientTemplateData = self.actObj.clientTemplateData
	local args = clientTemplateData.template_args

	if args and tonumber(args[1]) then
		self.achieveActObj = CurAvatar:getActivityObj(tonumber(args[1]))

		if self.achieveActObj then
			self.panelShopAchieve = ActivityShopLevelAchievePanel(self, "AwardPanel")

			self.panelShopAchieve:setVisible(true)
		end
	end
end

function ActivityShopLevelPanel:_setData()
	self:refreshShopItems()
end

function ActivityShopLevelPanel:refreshShopItems(...)
	self._curItems = self.actObj.actData:getCurShopItem()
	self.chgCostId = nil

	for index, shopItem in ipairs(self._curItems) do
		self.chgCostId = shopItem:getCostMoneyInfo()

		break
	end

	if self.chgCostId then
		local moneyPath = ClientUtils.getMoneyIcon(self.chgCostId)

		if moneyPath then
			self.btnCost:setImage(moneyPath[1], moneyPath[2])
		end
	end
end

function ActivityShopLevelPanel:onClickCost()
	local fakeItem = BaseObject.GetObject(self.chgCostId)

	UIManager.getUI("itemTips"):showObj(self.mWindow, fakeItem, {
		AutoOpenGuide = 1
	})
end

function ActivityShopLevelPanel:_onShow()
	local levelInfo = self.actObj.actData:getNextLevelProgress()
	local toTop

	if self.shopLevel and levelInfo.level > self.shopLevel then
		self.newShopLevel = levelInfo.level

		self:refreshShopItems()

		toTop = 1
	end

	self.shopLevel = levelInfo.level

	self.textLevel:setText(levelInfo.level + 1)

	if levelInfo.level == levelInfo.maxLevel then
		self.sliderLevel:setValue(1)
		self.textLevelProgress:setText("9999/9999")
		self.panelMax:setVisible(true)
		self.btnLevelUpDis:setVisible(false)
		self.btnLevelUp:setVisible(false)

		self.canLevelUp = false
	else
		self.panelMax:setVisible(false)

		local nowPro = levelInfo.nowPro - levelInfo.prePro
		local nextPro = levelInfo.nextPro - levelInfo.prePro

		self.textLevelProgress:setText(nowPro .. "/" .. nextPro)
		self.sliderLevel:setValue(nowPro / nextPro)
		self.btnLevelUpDis:setVisible(nowPro < nextPro)
		self.btnLevelUp:setVisible(nextPro <= nowPro)

		self.canLevelUp = nextPro <= nowPro
	end

	if self.chgCostId then
		local num = ClientUtils.getMoney(self.chgCostId)

		self.textHas:setText(ClientUtils.getNumShortStr(num))
	end

	for _, shopItem in ipairs(self._curItems) do
		shopItem:setBoughtNum(self.actObj.actData:getHasBuyNum(shopItem.id))
	end

	for index, targetCell in pairs(self.cells) do
		local item = self._curItems[index]

		targetCell:setData(item)
	end

	self.scrollItems:setTotalCount(#self._curItems, toTop)

	if self.panelShopAchieve then
		self.panelShopAchieve:setData(self.achieveActObj)
	end
end

function ActivityShopLevelPanel:_onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIConst.ActivityShopCellLoop(sender, "System/Common/Grid/GridTokenStoreItem", newIdx)
		targetCell.mEventClick = self._slot4CellClick
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	local item = self._curItems[newIdx]

	targetCell:setData(item)
	targetCell.iconNewGet:setVisible(not item:isSoldOut() and item.shopLevel == self.newShopLevel)
end

function ActivityShopLevelPanel:_onShopItemClick(item)
	if not item:canBuy() then
		local hint = item:getClickHint()

		if hint ~= nil then
			MsgManager.notice(hint)
		end
	else
		if self.canLevelUp and self.actObj.actData.miscData and self.actObj.actData.miscData.upgrade_info then
			UIManager.showConfirmWithId(self.actObj.actData.miscData.upgrade_info, Slot(self.onLevelUpClick, self), Functor(self.openBuyItem, self, item))

			return
		end

		self:openBuyItem(item)
	end
end

function ActivityShopLevelPanel:openBuyItem(item)
	local ui = UIManager.getUI("shopBuyBox")

	ui:showShopItem(item, self, Slot(self.onBuyCB, self), UIConst.ActivityShopCellChild, "System/Common/Grid/GridTokenStoreItem")
	ui:bindWindow(self)
end

function ActivityShopLevelPanel:onClosePanel()
	if self.panelShopAchieve then
		self.panelShopAchieve:onClosePanel()
	end
end

function ActivityShopLevelPanel:onBuyCB(exchgid, count)
	RPC.opActGetAward(self.actObj.opId, exchgid, count)
end

function ActivityShopLevelPanel:onLevelUpClick()
	RPC.opActShopLevelUp(self.actObj.opId, self.shopLevel + 1)
end

function ActivityShopLevelPanel:onPreviewBonus()
	UIManager.getUI("activityShopPreviewBonusDlg", true):onShow(self.actObj.actData)
end

function ActivityShopLevelPanel:onLevelUpDisClick()
	if self.actObj.actData.miscData and self.actObj.actData.miscData.upgrade_notice then
		MsgManager.clientNotice(self.actObj.actData.miscData.upgrade_notice)
	end
end

function ActivityShopLevelPanel:onActivityDataRefresh()
	CurAvatar:onGetBonusNotice("activityMainDlg", "cacheDataRefresh", {
		self,
		{}
	})
end

function ActivityShopLevelPanel:cacheDataRefresh(args)
	self:_onShow()
end

return ActivityShopLevelPanel
