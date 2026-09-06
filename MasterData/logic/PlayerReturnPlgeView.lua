-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/PlayerReturnPlgeView.lua

module("logic.extensions.playerreturn.view.PlayerReturnPlgeView", package.seeall)

local PlayerReturnPlgeView = class("PlayerReturnPlgeView", TableViewComponent)

function PlayerReturnPlgeView:ctor()
	PlayerReturnPlgeView.super.ctor(self)
end

function PlayerReturnPlgeView:onExit()
	PlayerReturnPlgeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PR_UpdataPlgeInfo, self._updataAllItemShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataBackGoldCard, self._updataBackGoldCard, self)
end

function PlayerReturnPlgeView:destroyUI()
	PlayerReturnPlgeView.super.destroyUI(self)

	self._isReceiveGoldCard = nil
	self._goldCardSupCount = nil
	self._goldCardInfoReady = nil
end

function PlayerReturnPlgeView:buildUI()
	PlayerReturnPlgeView.super.buildUI(self)

	self._dayTxt = goutil.findChildTextComponent(self.mainGO, "dayShowGo/dayTxt")
	self._dayTxt.text = ""
end

function PlayerReturnPlgeView:onEnter()
	PlayerReturnPlgeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PR_UpdataPlgeInfo, self._updataAllItemShow, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataBackGoldCard, self._updataBackGoldCard, self)

	self._actiInfo = PlayerReturnModel.instance:getOpenActivityInfo()
	self._mainCfg = self:getFirstParam()

	if self._mainCfg == nil then
		self._mainCfg = PlayerReturnConfig.instance:getReturnMainViewCfgs(self._actiInfo.actId, 2)
	end

	self._isReceiveGoldCard = false
	self._goldCardSupCount = 0
	self._goldCardInfoReady = false

	self:_updataAllItemShow()
	RegressAgent.instance:sendPM_RegressGetPrivilegeInfoReq()
end

function PlayerReturnPlgeView:_updataAllItemShow()
	local value = GameUtil.getUserDayData("PR_PlayerReturnPlgeRed")

	if checknumber(value) ~= 1 then
		GameUtil.saveUserDayData("PR_PlayerReturnPlgeRed", 1)
	end

	local openDays = GameUtil.getDaysByTimestamp(self._actiInfo.startTime, ServerTime.now())

	self._dayTxt.text = "第" .. openDays .. "天"
	self._curViewDatas = PlayerReturnConfig.instance:getReturnPlgeCfgs(self._mainCfg.planId)

	self._tableview:ReloadData()
	GlobalDispatcher:dispatch(GlobalNotify.PR_UpdataPlayerReturnRed, 2)
end

function PlayerReturnPlgeView:_updataBackGoldCard(msg, isInfo)
	if msg then
		self._isReceiveGoldCard = msg.isGainGoldenDiamondCard or false
	end

	self._goldCardSupCount = msg and checknumber(msg.goldenDiamondCardDays) or 0
	self._goldCardInfoReady = true
end

function PlayerReturnPlgeView:_getPath()
	return {
		cellPath = "btnItem",
		viewPath = "btnListSR"
	}
end

function PlayerReturnPlgeView:_cellSize()
	return 190, 316
end

function PlayerReturnPlgeView:_updateCell(view, cell, data)
	local iconImaGo = goutil.findChild(cell, "iconIma")
	local redpointGo = goutil.findChild(cell, "redpointGo")
	local countTxt = goutil.findChildTextComponent(cell, "countImaGo/countTxt")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")

	GameUtil.asBtn(cell):RemoveClickListener()
	MaterialMgr.resetAll(iconImaGo)
	GameUtil.SetActive(redpointGo, (data.type == 4 or nil) and RedPointModel.instance:isActiveByServer(RedPointModel.ID_PLAYERRETURN_CARD))
	uGuiUtil.setSpriteToImage(iconImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(data.icon))

	countTxt.text = data.countDesc
	nameTxt.text = data.itemName
	descTxt.text = data.itemDesc

	GameUtil.asBtn(cell):AddClickListener(function()
		if data.type == 4 and self._goldCardInfoReady and not self._isReceiveGoldCard then
			UIStateManager.instance:push(ViewName.NewhandprivilegeView, {
				source = NewhandwelfareEnum.PrivilegeViewSource_Regress,
				isReceive = self._isReceiveGoldCard,
				supCount = self._goldCardSupCount
			})
		else
			GotoMgr.gotoByString(data.jumpTo)
		end
	end, self)
end

return PlayerReturnPlgeView
