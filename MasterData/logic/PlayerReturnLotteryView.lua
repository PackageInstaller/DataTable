-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/PlayerReturnLotteryView.lua

module("logic.extensions.playerreturn.view.PlayerReturnLotteryView", package.seeall)

local PlayerReturnLotteryView = class("PlayerReturnLotteryView", TableViewComponent)

function PlayerReturnLotteryView:ctor()
	PlayerReturnLotteryView.super.ctor(self)
end

function PlayerReturnLotteryView:onExit()
	PlayerReturnLotteryView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PR_UpdataPlgeInfo, self._updataAllItemShow, self)
end

function PlayerReturnLotteryView:destroyUI()
	PlayerReturnLotteryView.super.destroyUI(self)
end

function PlayerReturnLotteryView:buildUI()
	PlayerReturnLotteryView.super.buildUI(self)
end

function PlayerReturnLotteryView:onEnter()
	PlayerReturnLotteryView.super.onEnter(self)

	self._actiInfo = PlayerReturnModel.instance:getOpenActivityInfo()
	self._mainCfg = self:getFirstParam()

	if self._mainCfg == nil then
		self._mainCfg = PlayerReturnConfig.instance:getReturnMainViewCfgs(self._actiInfo.actId, 6)
	end

	self:_updataAllItemShow()
	GlobalDispatcher:addListener(GlobalNotify.PR_UpdataPlgeInfo, self._updataAllItemShow, self)

	local value = GameUtil.getUserData("PR_PlayerReturnLotteryRed")

	if checknumber(value) ~= 1 then
		GameUtil.saveUserData("PR_PlayerReturnLotteryRed", 1)
		GlobalDispatcher:dispatch(GlobalNotify.PR_UpdataPlayerReturnRed, self._mainCfg.tabId)
	end
end

function PlayerReturnLotteryView:_updataAllItemShow()
	self._curViewDatas = PlayerReturnConfig.instance:getReturnLotteryCfgs(self._mainCfg.planId)

	self._tableview:ReloadData()
end

function PlayerReturnLotteryView:_getPath()
	return {
		cellPath = "btnItem",
		viewPath = "btnListSR"
	}
end

function PlayerReturnLotteryView:_cellSize()
	return 214, 316
end

function PlayerReturnLotteryView:_updateCell(view, cell, data)
	local iconImaGo = goutil.findChild(cell, "iconIma")
	local countTxt = goutil.findChildTextComponent(cell, "countImaGo/countTxt")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")

	GameUtil.asBtn(cell):RemoveClickListener()
	MaterialMgr.resetAll(iconImaGo)
	uGuiUtil.setSpriteToImage(iconImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(data.icon))

	countTxt.text = data.countDesc
	nameTxt.text = data.itemName
	descTxt.text = data.itemDesc

	GameUtil.asBtn(cell):AddClickListener(function()
		GotoMgr.gotoByString(data.jumpTo)
	end, self)
end

return PlayerReturnLotteryView
