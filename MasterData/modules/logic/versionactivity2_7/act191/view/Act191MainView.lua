-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191MainView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191MainView", package.seeall)

local Act191MainView = class("Act191MainView", BaseView)

function Act191MainView:onInitView()
	self._simagetitleeff = gohelper.findChildSingleImage(self.viewGO, "simage_title/#simage_titleeff")
	self._btnBadge = gohelper.findChildButtonWithAudio(self.viewGO, "go_achieve/scroll_achieve/#btn_Badge")
	self._btnRule = gohelper.findChildButtonWithAudio(self.viewGO, "rule/#btn_Rule")
	self._btnEndGame = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_EndGame")
	self._btnShop = gohelper.findChildButtonWithAudio(self.viewGO, "layout/#btn_Shop")
	self._txtnum = gohelper.findChildText(self.viewGO, "layout/#btn_Shop/#txt_num")
	self._goProgress = gohelper.findChild(self.viewGO, "layout/#go_Progress")
	self._goHp = gohelper.findChild(self.viewGO, "layout/#go_Progress/#go_Hp")
	self._imageHpPercent = gohelper.findChildImage(self.viewGO, "layout/#go_Progress/#go_Hp/bg/#image_HpPercent")
	self._txtRound = gohelper.findChildText(self.viewGO, "layout/#go_Progress/#txt_Round")
	self._btnEnterGame = gohelper.findChildButtonWithAudio(self.viewGO, "layout/#btn_EnterGame")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191MainView:addEvents()
	self._btnBadge:AddClickListener(self._btnBadgeOnClick, self)
	self._btnRule:AddClickListener(self._btnRuleOnClick, self)
	self._btnEndGame:AddClickListener(self._btnEndGameOnClick, self)
	self._btnShop:AddClickListener(self._btnShopOnClick, self)
	self._btnEnterGame:AddClickListener(self._btnEnterGameOnClick, self)
end

function Act191MainView:removeEvents()
	self._btnBadge:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnEndGame:RemoveClickListener()
	self._btnShop:RemoveClickListener()
	self._btnEnterGame:RemoveClickListener()
end

function Act191MainView:_btnBadgeOnClick()
	ViewMgr.instance:openView(ViewName.Act191BadgeView)
	Act191StatController.instance:statButtonClick(self.viewName, "_btnBadgeOnClick")
end

function Act191MainView:_btnRuleOnClick()
	ViewMgr.instance:openView(ViewName.Act191InfoView)
	Act191StatController.instance:statButtonClick(self.viewName, "_btnRuleOnClick")
end

function Act191MainView:_btnEndGameOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act174EndGameConfirm, MsgBoxEnum.BoxType.Yes_No, self.endGame, nil, nil, self)
	Act191StatController.instance:statButtonClick(self.viewName, "_btnEndGameOnClick")
end

function Act191MainView:endGame()
	Activity191Rpc.instance:sendEndAct191GameRequest(self.actId)
end

function Act191MainView:_btnShopOnClick()
	Activity191Controller.instance:openStoreView()
	Act191StatController.instance:statButtonClick(self.viewName, "_btnShopOnClick")
end

function Act191MainView:_btnEnterGameOnClick()
	Act191StatController.instance:statButtonClick(self.viewName, "_btnEnterGameOnClick")

	local actId = Activity191Model.instance:getCurActId()
	local gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	if gameInfo.state == Activity191Enum.GameState.None then
		if self.starting then
			return
		end

		self.starting = true

		Activity191Rpc.instance:sendStart191GameRequest(actId, self._startGameReply, self)
	else
		Activity191Controller.instance:nextStep()
	end
end

function Act191MainView:_startGameReply(_, resultCode)
	self.starting = false

	if resultCode == 0 then
		Activity191Controller.instance:nextStep()
	end
end

function Act191MainView:_editableInitView()
	self.badgeGoParent = gohelper.findChild(self.viewGO, "go_achieve/scroll_achieve/viewport/content")
	self.badgeGo = gohelper.findChild(self.viewGO, "go_achieve/scroll_achieve/viewport/content/go_achievementicon")
	self.actId = Activity191Model.instance:getCurActId()
end

function Act191MainView:onOpen()
	Act191StatController.instance:onViewOpen(self.viewName)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCurrency, self)
	self.addEventCb(self, Activity191Controller.instance, Activity191Event.UpdateGameInfo, self.refreshUI, self)
	self.addEventCb(self, Activity191Controller.instance, Activity191Event.UpdateBadgeMo, self.refreshBadge, self)
	self.addEventCb(self, Activity191Controller.instance, Activity191Event.EndGame, self.checkGameEndInfo, self)
	self:refreshUI()

	if self.viewParam and self.viewParam.exitFromFight then
		local needOpen = Activity191Controller.instance:checkOpenGetView()

		if needOpen then
			ViewMgr.instance:openView(ViewName.Act191GetView)
		else
			self:_btnEnterGameOnClick()
		end
	end
end

function Act191MainView:onClose()
	local manual = self.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(self.viewName, manual)
end

function Act191MainView:refreshUI()
	self.actInfo = Activity191Model.instance:getActInfo()

	gohelper.setActive(self._btnEndGame, self.actInfo:getGameInfo().state ~= Activity191Enum.GameState.None)
	self:initRule()
	self:refreshBadge()
	self:refreshCurrency()
end

function Act191MainView:initRule()
	local heroCoList = Activity191Config.instance:getShowRoleCoList(self.actId)
	local count = #heroCoList
	local showCoList = {}

	for i = 3, 1, -1 do
		showCoList[#showCoList + 1] = heroCoList[count + 1 - i]
	end

	for i, roleCo in ipairs(showCoList) do
		local roleGo = gohelper.findChild(self.viewGO, "rule/role/" .. i)
		local imageRare = gohelper.findChildImage(roleGo, "rare")
		local heroIcon = gohelper.findChildSingleImage(roleGo, "heroicon")
		local imageCareer = gohelper.findChildImage(roleGo, "career")

		heroIcon:LoadImage(Activity191Helper.getHeadIconSmall(roleCo))
		UISpriteSetMgr.instance:setAct174Sprite(imageRare, "act174_roleframe_" .. tostring(roleCo.quality))
		UISpriteSetMgr.instance:setCommonSprite(imageCareer, "lssx_" .. tostring(roleCo.career))
	end
end

function Act191MainView:refreshCurrency()
	local currencyMo = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V3a8DouQuQu)

	self._txtnum.text = currencyMo.quantity
end

function Act191MainView:refreshBadge()
	self.badgeItemDic = {}

	local badgeMoList = self.actInfo:getBadgeMoList()

	gohelper.CreateObjList(self, self._onSetBadgeItem, badgeMoList, self.badgeGoParent, self.badgeGo)
end

function Act191MainView:_onSetBadgeItem(go, badgeMo, index)
	local badgeItem = self:getUserDataTb_()
	local id = badgeMo.id

	badgeItem.simageIcon = gohelper.findChildSingleImage(go, "root/image_icon")
	badgeItem.txtNum = gohelper.findChildText(go, "root/txt_num")
	self.badgeItemDic[id] = badgeItem

	self:refreshBadgeItem(id, badgeMo)
end

function Act191MainView:refreshBadgeItem(badgeId, badgeMo)
	local badgeItem = self.badgeItemDic[badgeId]
	local state = badgeMo:getState()
	local path = ResUrl.getAct174BadgeIcon(badgeMo.config.icon, state)

	badgeItem.simageIcon:LoadImage(path)

	badgeItem.txtNum.text = badgeMo.count
end

function Act191MainView:checkGameEndInfo()
	local gameEndInfo = self.actInfo:getGameEndInfo()

	if gameEndInfo then
		local gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

		if gameInfo.curNode ~= 0 and gameInfo.curStage ~= 0 then
			Activity191Controller.instance:openSettlementView()
		end

		self:refreshUI()

		return true
	end
end

return Act191MainView
