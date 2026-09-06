-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/minigamecollection/view/MinigamecollectionView.lua

module("logic.extensions.minigamecollection.view.MinigamecollectionView", package.seeall)

local MinigamecollectionView = class("MinigamecollectionView", ViewComponent)

function MinigamecollectionView:ctor()
	MinigamecollectionView.super.ctor(self)
end

function MinigamecollectionView:buildUI()
	MinigamecollectionView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnHelp = self:getBtn("btnHelp")
	self._txtTimes = self:getTxt("times/txtNum")
	self._txtCoin = self:getTxt("coin/txtNum")
	self._goAddTimes = self:getGo("times/btn")
	self._btnAddTimes = GameUtil.asBtn(self._goAddTimes)
	self._btnGotoExchange = self:getBtn("btnGotoExchange")
	self._goCell = self:getGo("cell")
	self._goSc = self:getGo("ScrollView")
	self._tableView = ScrollerList.create(self._goSc, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function MinigamecollectionView:bindEvents()
	MinigamecollectionView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnHelp:AddClickListener(self._onClickBtnHelp, self)
	self._btnAddTimes:AddClickListener(self._onClickBtnAddTimes, self)
	self._btnGotoExchange:AddClickListener(self._onClickBtnGotoExchange, self)
end

function MinigamecollectionView:unbindEvents()
	MinigamecollectionView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnHelp:RemoveClickListener()
	self._btnAddTimes:RemoveClickListener()
	self._btnGotoExchange:RemoveClickListener()
end

function MinigamecollectionView:destroyUI()
	MinigamecollectionView.super.destroyUI(self)
end

function MinigamecollectionView:onEnter()
	self._ableToClick = true

	MinigamecollectionView.super.onEnter(self)
	self:_dailyReset()

	local dataList = {}
	local cfgs = MiniGameCollectionConfig.instance:getBaseCfgs()

	for _, v in pairs(cfgs) do
		if not string.nilorempty(v.goToParam) then
			table.insert(dataList, v)
		end
	end

	table.sort(dataList, function(a, b)
		return a.sortId < b.sortId
	end)
	self._tableView:reloadData(dataList)

	self._ableToClick = true
end

function MinigamecollectionView:onEnterFinished()
	MinigamecollectionView.super.onEnterFinished(self)
end

function MinigamecollectionView:onExit()
	MinigamecollectionView.super.onExit(self)
	self._tableView:dispose()
end

function MinigamecollectionView:onExitFinished()
	MinigamecollectionView.super.onExitFinished(self)
end

function MinigamecollectionView:_dailyReset()
	MiniGameCollectionController.instance:sendGetInfo(self._updateUIView, self)
end

function MinigamecollectionView:_updateUIView()
	self._txtTimes.text = MiniGameCollectionModel.instance:getResiduePlayTimes()
	self._txtCoin.text = MaterialMgr.getMatCount(MiniGameCollectionConfig.instance:getParamValueByKey("GAME_PRIZE"))

	goutil.setActive(self._goAddTimes, MiniGameCollectionModel.instance:getResiduePlayTimes() == 0)
end

function MinigamecollectionView:_onClickClose()
	if not self._ableToClick then
		return
	end

	self:close()
end

function MinigamecollectionView:_onClickBtnHelp()
	if not self._ableToClick then
		return
	end

	ViewMgr.instance:open(ViewName.RulesView, "miniGameCollectionView")
end

function MinigamecollectionView:_onClickBtnGotoExchange()
	if not self._ableToClick then
		return
	end

	PayShopController.instance:openView(GameEnum.PayShopEasyJump.ExchangeMiniGame)
end

function MinigamecollectionView:_onClickBtnAddTimes()
	if not self._ableToClick then
		return
	end

	local total = MiniGameCollectionConfig.instance:getMaxBuyTimes()
	local buyTime = MiniGameCollectionModel.instance:getHasBuyTimes()
	local type, id, matNum = MaterialMgr.getMatParams(MiniGameCollectionConfig.instance:getParamValueByKey("BUY_TIMES_COST"))
	local content = langPara("今天所有的挑战次数已经用完，可以购买更多次数继续。确定要花费<color=#ebad32>%s%s</color>购买次数吗？\n每天可以购买%s次，当前剩余购买次数：%s", matNum, MaterialMgr.getMaterialsName(type, id), total, total - buyTime)

	TipsFacade.instance:openPopupCostMatViewNew(type, id, matNum, content, function()
		MiniGameCollectionController.instance:sendBuyTimes(self._updateUIView, self)
	end)
end

function MinigamecollectionView:_clearCell(cell)
	uGuiUtil.clearImage(goutil.findChild(cell, "imgIcon"))
	GameUtil.rmClickHandler(cell)
end

function MinigamecollectionView:_updateCell(view, cell, data)
	if data then
		self:_clearCell(cell)

		local icon = goutil.findChild(cell, "imgIcon")

		GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickEnter, self, data))
		uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getMiniGameBgUrl(data.enterIcon))
	end
end

function MinigamecollectionView:_onClickEnter(data)
	GotoMgr.gotoByString(data.goToParam)
end

return MinigamecollectionView
