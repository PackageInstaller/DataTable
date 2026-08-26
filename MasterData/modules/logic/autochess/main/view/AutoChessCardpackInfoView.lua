-- chunkname: @modules/logic/autochess/main/view/AutoChessCardpackInfoView.lua

module("modules.logic.autochess.main.view.AutoChessCardpackInfoView", package.seeall)

local AutoChessCardpackInfoView = class("AutoChessCardpackInfoView", BaseView)

function AutoChessCardpackInfoView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._btnCloseTip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_CloseTip")
	self._scrollLeader = gohelper.findChildScrollRect(self.viewGO, "#btn_CloseTip/#scroll_Leader")
	self._goLeaderItem = gohelper.findChild(self.viewGO, "#btn_CloseTip/#scroll_Leader/viewport/content/#go_LeaderItem")
	self._scrollCollection = gohelper.findChildScrollRect(self.viewGO, "#btn_CloseTip/#scroll_Collection")
	self._goCollectionItem = gohelper.findChild(self.viewGO, "#btn_CloseTip/#scroll_Collection/viewport/content/#go_CollectionItem")
	self._scrollChess = gohelper.findChildScrollRect(self.viewGO, "#btn_CloseTip/#scroll_Chess")
	self._goChessItem = gohelper.findChild(self.viewGO, "#btn_CloseTip/#scroll_Chess/viewport/content/#go_ChessItem")
	self._goCardPackContent = gohelper.findChild(self.viewGO, "#go_CardPackContent")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Left")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Right")
	self._goTipViews = gohelper.findChild(self.viewGO, "#go_TipViews")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessCardpackInfoView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnCloseTip:AddClickListener(self._btnCloseTipOnClick, self)
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
end

function AutoChessCardpackInfoView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnCloseTip:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function AutoChessCardpackInfoView:_btnCloseTipOnClick()
	if not self.tipIndex then
		return
	end

	self.tipType = nil
	self.tipIndex = nil

	self:refreshSelect()
	self:closeTipsView()
end

function AutoChessCardpackInfoView:onClickModalMask()
	self:closeThis()
end

function AutoChessCardpackInfoView:_btnCloseOnClick()
	self:closeThis()
end

function AutoChessCardpackInfoView:_btnLeftOnClick()
	if self.selectIndex > 1 then
		self:_btnCloseTipOnClick()

		self.selectIndex = self.selectIndex - 1

		self:refreshUI()
	end
end

function AutoChessCardpackInfoView:_btnRightOnClick()
	if self.selectIndex < self.cardpackCnt then
		self:_btnCloseTipOnClick()

		self.selectIndex = self.selectIndex + 1

		self:refreshUI()
	end
end

function AutoChessCardpackInfoView:_editableInitView()
	self.actMo = Activity182Model.instance:getActMo()
	self.actId = self.actMo.activityId

	local goPack = self:getResInst(AutoChessStrEnum.ResPath.CardPackItem, self._goCardPackContent)

	self.cardpackItem = MonoHelper.addNoUpdateLuaComOnceToGo(goPack, AutoChessCardpackItem)
	self.leaderItemList = {}
	self.collectionItemList = {}
	self.chessItemList = {}

	local goLeader = self:getResInst(AutoChessStrEnum.ResPath.LeaderCard, self._goTipViews)

	self.leaderCard = MonoHelper.addNoUpdateLuaComOnceToGo(goLeader, AutoChessLeaderCard)

	self.leaderCard.meshComp:setIndependentMaterial()

	local goCollection = self:getResInst(AutoChessStrEnum.ResPath.CollectionItem, self._goTipViews)

	self.collectionCard = MonoHelper.addNoUpdateLuaComOnceToGo(goCollection, AutoChessCollectionItem)

	self:closeTipsView()
end

function AutoChessCardpackInfoView:onOpen()
	if self.viewParam then
		self.selectIndex = self.viewParam.index
		self.cardpackCfgs = self.viewParam.configs
		self.cardpackCnt = #self.cardpackCfgs

		self:refreshUI()
	end
end

function AutoChessCardpackInfoView:refreshUI()
	self.cardpackConfig = self.cardpackCfgs[self.selectIndex]

	if self.cardpackConfig then
		self.cardpackItem:setData(self.cardpackConfig)
		self:refreshLeader()
		self:refreshCollection()
		self:refreshChess()
	end

	gohelper.setActive(self._btnLeft, self.selectIndex > 1)
	gohelper.setActive(self._btnRight, self.selectIndex < self.cardpackCnt)
end

function AutoChessCardpackInfoView:refreshLeader()
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

function AutoChessCardpackInfoView:refreshCollection()
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
		end

		gohelper.setActive(item.go, true)
	end

	for i = #self.collectionIds + 1, #self.collectionItemList do
		local item = self.chessItemList[i]

		gohelper.setActive(item.go, false)
	end

	self._scrollCollection.verticalNormalizedPosition = 1
end

function AutoChessCardpackInfoView:refreshChess()
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

function AutoChessCardpackInfoView:_btnLeaderOnClick(index)
	if self.tipType == 1 and self.tipIndex == index then
		self.tipType = nil
		self.tipIndex = nil
	else
		self.tipType = 1
		self.tipIndex = index

		local param = {
			freshLock = true,
			leaderId = self.leaderIds[index],
			tipPos = Vector2(20, 20)
		}

		self.leaderCard:setData(param)
	end

	self:refreshSelect()
	self:closeTipsView()
end

function AutoChessCardpackInfoView:_btnCollectionOnClick(index)
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

function AutoChessCardpackInfoView:_btnChessOnClick(index)
	self.tipType = 3
	self.tipIndex = index

	local id = self.chessIds[index]

	AutoChessController.instance:openAutoChessHandbookPreviewView({
		chessId = id
	})
	self:refreshSelect()
	self:closeTipsView()
end

function AutoChessCardpackInfoView:refreshSelect()
	for k, item in ipairs(self.leaderItemList) do
		gohelper.setActive(item.goSelect, self.tipType == 1 and self.tipIndex == k)
	end

	for k, item in ipairs(self.collectionItemList) do
		gohelper.setActive(item.goSelect, self.tipType == 2 and self.tipIndex == k)
	end
end

function AutoChessCardpackInfoView:closeTipsView()
	self.leaderCard:setActive(false)
	self.collectionCard:setActive(false)
	self.leaderCard:setActive(self.tipType == 1)
	self.collectionCard:setActive(self.tipType == 2)
end

return AutoChessCardpackInfoView
