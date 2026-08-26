-- chunkname: @modules/logic/autochess/main/view/AutoChessCardpackView.lua

module("modules.logic.autochess.main.view.AutoChessCardpackView", package.seeall)

local AutoChessCardpackView = class("AutoChessCardpackView", BaseView)

function AutoChessCardpackView:onInitView()
	self._btnCloseTip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_CloseTip")
	self._scrollLeader = gohelper.findChildScrollRect(self.viewGO, "#btn_CloseTip/#scroll_Leader")
	self._goLeaderItem = gohelper.findChild(self.viewGO, "#btn_CloseTip/#scroll_Leader/viewport/content/#go_LeaderItem")
	self._scrollCollection = gohelper.findChildScrollRect(self.viewGO, "#btn_CloseTip/#scroll_Collection")
	self._goCollectionItem = gohelper.findChild(self.viewGO, "#btn_CloseTip/#scroll_Collection/viewport/content/#go_CollectionItem")
	self._scrollChess = gohelper.findChildScrollRect(self.viewGO, "#btn_CloseTip/#scroll_Chess")
	self._goChessItem = gohelper.findChild(self.viewGO, "#btn_CloseTip/#scroll_Chess/viewport/content/#go_ChessItem")
	self._goMode1 = gohelper.findChild(self.viewGO, "#btn_CloseTip/bottom/#go_Mode1")
	self._scrollBottom1 = gohelper.findChildScrollRect(self.viewGO, "#btn_CloseTip/bottom/#go_Mode1/#scroll_Bottom1")
	self._goTabItem1 = gohelper.findChild(self.viewGO, "#btn_CloseTip/bottom/#go_Mode1/#scroll_Bottom1/Viewport/Content/#go_TabItem1")
	self._goMode2 = gohelper.findChild(self.viewGO, "#btn_CloseTip/bottom/#go_Mode2")
	self._scrollBottom2 = gohelper.findChildScrollRect(self.viewGO, "#btn_CloseTip/bottom/#go_Mode2/#scroll_Bottom2")
	self._imageProgress = gohelper.findChildImage(self.viewGO, "#btn_CloseTip/bottom/#go_Mode2/#scroll_Bottom2/Viewport/Content/progressbg/#image_Progress")
	self._goWarningContent = gohelper.findChild(self.viewGO, "#btn_CloseTip/bottom/#go_Mode2/#scroll_Bottom2/Viewport/Content/#go_WarningContent")
	self._goTab1 = gohelper.findChild(self.viewGO, "#btn_CloseTip/bottom/#go_Mode2/#scroll_Bottom2/Viewport/Content/#go_Tab1")
	self._goTab2 = gohelper.findChild(self.viewGO, "#btn_CloseTip/bottom/#go_Mode2/#scroll_Bottom2/Viewport/Content/#go_Tab2")
	self._goCardPackContent = gohelper.findChild(self.viewGO, "#go_CardPackContent")
	self._goTipViews = gohelper.findChild(self.viewGO, "#go_TipViews")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessCardpackView:addEvents()
	self._btnCloseTip:AddClickListener(self._btnCloseTipOnClick, self)
end

function AutoChessCardpackView:removeEvents()
	self._btnCloseTip:RemoveClickListener()
end

function AutoChessCardpackView:_btnCloseTipOnClick()
	if not self.tipIndex then
		return
	end

	self.tipType = nil
	self.tipIndex = nil

	self:refreshSelect()
	self:closeTipsView()
end

AutoChessCardpackView.OpenType = {
	Book = 2,
	Own = 1
}

function AutoChessCardpackView:_editableInitView()
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.actMo = Activity182Model.instance:getActMo()
	self.actId = self.actMo.activityId

	local goPack = self:getResInst(AutoChessStrEnum.ResPath.CardPackItem, self._goCardPackContent)

	self.cardpackItem = MonoHelper.addNoUpdateLuaComOnceToGo(goPack, AutoChessCardpackItem)
	self.cardpackCfgs = {}
	self.tabItemList = {}
	self.leaderItemList = {}
	self.collectionItemList = {}
	self.chessItemList = {}
	self.progressImages = {}
	self.progressImages[1] = self._imageProgress

	local goLeader = self:getResInst(AutoChessStrEnum.ResPath.LeaderCard, self._goTipViews)

	self.leaderCard = MonoHelper.addNoUpdateLuaComOnceToGo(goLeader, AutoChessLeaderCard)

	self.leaderCard.meshComp:setIndependentMaterial()

	local goCollection = self:getResInst(AutoChessStrEnum.ResPath.CollectionItem, self._goTipViews)

	self.collectionCard = MonoHelper.addNoUpdateLuaComOnceToGo(goCollection, AutoChessCollectionItem)

	self:closeTipsView()

	self.unlockCardpackIdList = {}
end

function AutoChessCardpackView:onOpen()
	self.openType = self.viewParam

	if self.openType then
		self:refreshUI()
	end
end

function AutoChessCardpackView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshCardpackInfo, self)
	TaskDispatcher.cancelTask(self.delayUnlock, self)
	TaskDispatcher.cancelTask(self.unlockFinish, self)

	if #self.unlockCardpackIdList > 0 then
		for _, id in ipairs(self.unlockCardpackIdList) do
			AutoChessHelper.setUnlockReddot(AutoChessStrEnum.ClientReddotKey.Cardpack, id)
		end

		AutoChessController.instance:dispatchEvent(AutoChessEvent.updateCultivateReddot)
	end
end

function AutoChessCardpackView:refreshUI()
	local cardpackCfgs = {}

	for _, config in pairs(lua_auto_chess_cardpack.configDict[self.actId]) do
		cardpackCfgs[#cardpackCfgs + 1] = config
	end

	table.sort(cardpackCfgs, function(a, b)
		return a.sequence < b.sequence
	end)
	gohelper.setActive(self._goMode1, self.openType == AutoChessCardpackView.OpenType.Own)
	gohelper.setActive(self._goMode2, self.openType == AutoChessCardpackView.OpenType.Book)

	if self.openType == AutoChessCardpackView.OpenType.Own then
		local index = 0

		for _, config in ipairs(cardpackCfgs) do
			local unlockLvl = AutoChessConfig.instance:getCardpackUnlockLevel(config.id)

			if unlockLvl <= self.actMo.warnLevel then
				index = index + 1
				self.cardpackCfgs[index] = config

				self:addTabItem1(index)
			end
		end

		gohelper.setActive(self._goTabItem1, false)

		self._scrollBottom1.horizontalNormalizedPosition = 0
	elseif self.openType == AutoChessCardpackView.OpenType.Book then
		TaskDispatcher.runDelay(self.delayUnlock, self, 0.5)

		self.cardpackCfgs = cardpackCfgs

		for index, config in pairs(self.cardpackCfgs) do
			local unlockLvl = AutoChessConfig.instance:getCardpackUnlockLevel(config.id)

			self:addTabItem2(index, unlockLvl)
		end

		if self.lockIndex then
			if not (self.lockIndex - 1) then
				local curIndex = #self.cardpackCfgs

				for k, image in ipairs(self.progressImages) do
					image.fillAmount = k <= curIndex and 1 or 0
				end

				gohelper.setActive(self._goTab1, false)
				gohelper.setActive(self._goTab2, false)

				local goWarning = self:getResInst(AutoChessStrEnum.ResPath.WarningItem, self._goWarningContent)

				self.warningItem = MonoHelper.addNoUpdateLuaComOnceToGo(goWarning, AutoChessWarningItem)

				self.warningItem:refresh()

				self._scrollBottom2.horizontalNormalizedPosition = 0
			end
		end
	end

	self:_btnTabItemOnClick(1, true)
end

function AutoChessCardpackView:addTabItem1(index)
	local tabItem = self:getUserDataTb_()
	local go = gohelper.cloneInPlace(self._goTabItem1)
	local simageCardpack = gohelper.findChildSingleImage(go, "simage_cardpack")

	simageCardpack:LoadImage(ResUrl.getMovingChessIcon(self.cardpackCfgs[index].icon, "handbook"))

	tabItem.goSelect = gohelper.findChild(go, "go_select")

	local btnClick = gohelper.findChildButtonWithAudio(go, "btn_click")

	self.addClickCb(self, btnClick, self._btnTabItemOnClick, self, index)

	self.tabItemList[index] = tabItem
end

function AutoChessCardpackView:addTabItem2(index, unlockLvl)
	local goTab = index % 2 == 0 and self._goTab2 or self._goTab1
	local tabItem = self:getUserDataTb_()

	tabItem.isLock = unlockLvl > self.actMo.warnLevel

	local go = gohelper.cloneInPlace(goTab)

	tabItem.anim = go:GetComponent(gohelper.Type_Animator)
	tabItem.goArrow = gohelper.findChild(go, "arrow")

	local simageCardpack = gohelper.findChildSingleImage(go, "cardpack/simage_cardpack")

	simageCardpack:LoadImage(ResUrl.getMovingChessIcon(self.cardpackCfgs[index].icon, "handbook"))

	tabItem.goSelect = gohelper.findChild(go, "cardpack/go_select")
	tabItem.goLock = gohelper.findChild(go, "cardpack/go_lock")
	tabItem.goNew = gohelper.findChild(go, "go_New")

	local btnClick = gohelper.findChildButtonWithAudio(go, "cardpack/btn_click")

	self.addClickCb(self, btnClick, self._btnTabItemOnClick, self, index)

	local txtLevel = gohelper.findChildText(go, "level/txt_level")
	local isNew = false

	if tabItem.isLock then
		txtLevel.text = string.format("<color=#7B7B7B>%s</color>", unlockLvl)
	else
		do
			local id = self.cardpackCfgs[index].id

			isNew = AutoChessHelper.getUnlockReddot(AutoChessStrEnum.ClientReddotKey.Cardpack, id)

			if isNew then
				self.unlockCardpackIdList[#self.unlockCardpackIdList + 1] = id
			end

			txtLevel.text = unlockLvl
		end
	end

	gohelper.setActive(tabItem.goLock, tabItem.isLock or isNew)

	if index == #self.cardpackCfgs then
		local goBg = gohelper.findChildImage(go, "progressbg")

		gohelper.setActive(goBg, false)
	else
		self.progressImages[index + 1] = gohelper.findChildImage(go, "progressbg/image_Progress")
	end

	if not self.lockIndex and tabItem.isLock then
		self.lockIndex = index
	end

	self.tabItemList[index] = tabItem
end

function AutoChessCardpackView:_btnTabItemOnClick(index, manually)
	if self.cardpackConfig == self.cardpackCfgs[index] then
		return
	end

	self.tipType = nil
	self.tipIndex = nil

	self:closeTipsView()
	self:refreshSelect()

	self.cardpackConfig = self.cardpackCfgs[index]

	for k, tabItem in ipairs(self.tabItemList) do
		gohelper.setActive(tabItem.goSelect, k == index)

		if tabItem.goArrow then
			gohelper.setActive(tabItem.goArrow, k == index)
		end
	end

	if manually then
		self:refreshCardpackInfo()
	else
		self.anim:Play("switch", 0, 0)
		TaskDispatcher.runDelay(self.refreshCardpackInfo, self, 0.16)
	end
end

function AutoChessCardpackView:refreshCardpackInfo()
	self.cardpackItem:setData(self.cardpackConfig)
	self:refreshLeader()
	self:refreshCollection()
	self:refreshChess()
end

function AutoChessCardpackView:refreshLeader()
	local leaderIdMap = lua_auto_chess_master_library.configDict[self.cardpackConfig.masterLibraryId]

	self.leaderIds = {}

	for id, _ in pairs(leaderIdMap) do
		self.leaderIds[#self.leaderIds + 1] = id
	end

	for index, id in pairs(self.leaderIds) do
		local item = self.leaderItemList[index]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self._goLeaderItem)
			item.goSelect = gohelper.findChild(item.go, "go_select")

			local goMesh = gohelper.findChild(item.go, "Mesh")

			item.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(goMesh, AutoChessMeshComp)
			item.txtName = gohelper.findChildText(item.go, "txt_name")

			local btnClick = gohelper.findChildButtonWithAudio(item.go, "btn_click")

			self.addClickCb(self, btnClick, self._btnLeaderOnClick, self, index)

			self.leaderItemList[index] = item
		end

		local config = AutoChessConfig.instance:getLeaderCfg(id)

		item.txtName.text = config.name

		item.meshComp:setData(config.image, false, true)

		local isGray = false

		if config.isSpMaster then
			local unlockLvl = AutoChessConfig.instance:getLeaderUnlockLevel(id)

			if unlockLvl > self.actMo.warnLevel then
				isGray = true
			end
		end

		item.meshComp:setGray(isGray)
		gohelper.setActive(item.go, true)
	end

	for i = #self.leaderIds + 1, #self.leaderItemList do
		local item = self.leaderItemList[i]

		gohelper.setActive(item.go, false)
	end

	self._scrollLeader.verticalNormalizedPosition = 1
end

function AutoChessCardpackView:refreshCollection()
	self.collectionIds = string.splitToNumber(self.cardpackConfig.collectionPool, "#")

	for index, id in ipairs(self.collectionIds) do
		local config = AutoChessConfig.instance:getCollectionCfg(id)
		local item = self.collectionItemList[index]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self._goCollectionItem)
			item.goSelect = gohelper.findChild(item.go, "go_select")
			item.simageCollection = gohelper.findChildSingleImage(item.go, "simage_collection")

			local btnClick = gohelper.findChildButtonWithAudio(item.go, "btn_click")

			self.addClickCb(self, btnClick, self._btnCollectionOnClick, self, index)

			self.collectionItemList[index] = item
		end

		if config then
			item.simageCollection:LoadImage(ResUrl.getAutoChessIcon(config.image, "collection"))
			gohelper.setActive(item.go, true)
		end
	end

	for i = #self.collectionIds + 1, #self.collectionItemList do
		local item = self.collectionItemList[i]

		gohelper.setActive(item.go, false)
	end

	self._scrollCollection.verticalNormalizedPosition = 1
end

function AutoChessCardpackView:refreshChess()
	self.chessIds = string.splitToNumber(self.cardpackConfig.chessPool, "#")

	table.sort(self.chessIds, function(a, b)
		local configA = AutoChessConfig.instance:getChessCfg(a)
		local configB = AutoChessConfig.instance:getChessCfg(b)

		return configA.levelFromMall < configB.levelFromMall
	end)

	for index, id in ipairs(self.chessIds) do
		local config = AutoChessConfig.instance:getChessCfg(id)

		if config then
			local item = self.chessItemList[index]

			if not item then
				item = self:getUserDataTb_()
				item.go = gohelper.cloneInPlace(self._goChessItem)
				item.goSelect = gohelper.findChild(item.go, "go_select")
				item.imageQuality = gohelper.findChildImage(item.go, "image_quality")

				local goMesh = gohelper.findChild(item.go, "Mesh")

				item.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(goMesh, AutoChessMeshComp)

				local btnClick = gohelper.findChildButtonWithAudio(item.go, "btn_click")

				self.addClickCb(self, btnClick, self._btnChessOnClick, self, index)

				self.chessItemList[index] = item
			end

			local imageName = AutoChessHelper.getChessQualityBg(config.type, config.levelFromMall)

			UISpriteSetMgr.instance:setAutoChessSprite(item.imageQuality, imageName)
			item.meshComp:setData(config.image)
			gohelper.setActive(item.go, true)
		end
	end

	for i = #self.chessIds + 1, #self.chessItemList do
		local item = self.chessItemList[i]

		gohelper.setActive(item.go, false)
	end

	self._scrollChess.verticalNormalizedPosition = 1
end

function AutoChessCardpackView:_btnLeaderOnClick(index)
	if self.tipType == 1 and self.tipIndex == index then
		self.tipType = nil
		self.tipIndex = nil
	else
		self.tipType = 1
		self.tipIndex = index

		local data = {
			freshLock = true,
			leaderId = self.leaderIds[index],
			tipPos = Vector2(20, 20)
		}

		self.leaderCard:setData(data)
	end

	self:refreshSelect()
	self:closeTipsView()
end

function AutoChessCardpackView:_btnCollectionOnClick(index)
	if self.tipType == 2 and self.tipIndex == index then
		self.tipType = nil
		self.tipIndex = nil
	else
		self.tipType = 2
		self.tipIndex = index

		self.collectionCard:setData(self.collectionIds[index])
	end

	self:refreshSelect()
	self:closeTipsView()
end

function AutoChessCardpackView:_btnChessOnClick(index)
	self.tipType = 3
	self.tipIndex = index

	local id = self.chessIds[index]

	AutoChessController.instance:openAutoChessHandbookPreviewView({
		chessId = id
	})
	self:refreshSelect()
	self:closeTipsView()
end

function AutoChessCardpackView:closeTipsView()
	self.leaderCard:setActive(false)
	self.collectionCard:setActive(false)
	self.leaderCard:setActive(self.tipType == 1)
	self.collectionCard:setActive(self.tipType == 2)
end

function AutoChessCardpackView:refreshSelect()
	for k, item in ipairs(self.leaderItemList) do
		gohelper.setActive(item.goSelect, self.tipType == 1 and self.tipIndex == k)
	end

	for k, item in ipairs(self.collectionItemList) do
		gohelper.setActive(item.goSelect, self.tipType == 2 and self.tipIndex == k)
	end
end

function AutoChessCardpackView:delayUnlock()
	for k, item in ipairs(self.tabItemList) do
		local id = self.cardpackCfgs[k].id

		if tabletool.indexOf(self.unlockCardpackIdList, id) then
			item.anim:Play("unlock", 0, 0)

			local key = AutoChessStrEnum.ClientReddotKey.Cardpack

			AutoChessHelper.setUnlockReddot(key, self.cardpackCfgs[k].id)
		end
	end

	TaskDispatcher.runDelay(self.unlockFinish, self, 1)
end

function AutoChessCardpackView:unlockFinish()
	for k, item in ipairs(self.tabItemList) do
		local id = self.cardpackCfgs[k].id

		if tabletool.indexOf(self.unlockCardpackIdList, id) then
			gohelper.setActive(item.goLock, false)
			gohelper.setActive(item.goNew, true)
		end
	end
end

return AutoChessCardpackView
