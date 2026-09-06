-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/view/TianYanMatchManualView.lua

module("logic.extensions.tianyanmatch.view.TianYanMatchManualView", package.seeall)

local TianYanMatchManualView = class("TianYanMatchManualView", ViewComponent)
local PRIZE_CAN_GAIN_EFFECT_PATH = "fx_ui_tequan/fx_ui_tequan_kuang.prefab"

function TianYanMatchManualView:ctor()
	TianYanMatchManualView.super.ctor(self)
end

function TianYanMatchManualView:unbindEvents()
	TianYanMatchManualView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function TianYanMatchManualView:bindEvents()
	TianYanMatchManualView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TianYanMatchManualView:buildUI()
	TianYanMatchManualView.super.buildUI(self)

	self._manualScrollercell = self:getGo("manualTableCol/manualScrollercell")
	self._manualScrollerview = self:getGo("manualTableCol/manualScrollerview")
	self._viewport = self:getGo("manualTableCol/manualScrollerview/viewport")
	self._manualTableList = ScrollerList.create(self._manualScrollerview, self._manualScrollercell, GameUtil.handler(self._updateManualCell, self), GameUtil.handler(self._clearManualCell, self))
	self._comboCon = self:getGo("manualTableCol/comboCon")
	self._btnClose = self:getGo("btnClose")
	self._itemCell = self:getGo("manualTableCol/itemCell")
end

function TianYanMatchManualView:onExit()
	TianYanMatchManualView.super.onExit(self)
	self._manualTableList:dispose()

	for i, v in pairs(self._manualTableListMap) do
		v:dispose()
	end

	for i, v in pairs(self._itemTableListMap) do
		v:dispose()
	end

	self._manualTableListMap = {}
	self._itemTableListMap = {}
end

function TianYanMatchManualView:onEnter()
	TianYanMatchManualView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.TianYanMatchGetInfo, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._activityCfg = TianYanMatchConfig.instance:getActivityCfg(self._activityId)
	self._scoreMatType, self._scoreMatId, _ = MaterialMgr.getMatParams(self._activityCfg.scoreItem)
	self._manualTableListMap = {}
	self._itemTableListMap = {}

	self:_refreshView()
end

function TianYanMatchManualView:_refreshView()
	local manualTypeCfgs = TianYanMatchConfig.instance:getManualTypeCfgs(self._activityId)

	self._manualTableList:reloadData(manualTypeCfgs)
end

function TianYanMatchManualView:_updateManualCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtType")
	local tableView = goutil.findChild(go, "comboList")

	txtName.text = data.name

	local tableList = self._manualTableListMap[go]

	if not tableList then
		tableList = ScrollerList.create(tableView, self._comboCon, GameUtil.handler(self._updateComboCell, self), GameUtil.handler(self._clearComboCell, self))
		self._manualTableListMap[go] = tableList

		tableList:dragNotifyParent()
	end

	local cfgList = TianYanMatchConfig.instance:getManualByTypeCfgList(self._activityId, data.manualType)

	tableList:reloadData(cfgList)
end

function TianYanMatchManualView:_clearManualCell(cell)
	local go = cell.gameObject

	if self._manualTableListMap[go] then
		self._manualTableListMap[go]:dispose()

		self._manualTableListMap[go] = nil
	end
end

function TianYanMatchManualView:_updateComboCell(view, cell, data, tag)
	local go = cell.gameObject
	local tableView = goutil.findChild(go, "itemTableview")
	local toy1Go = goutil.findChild(go, "toy1")
	local toy2Go = goutil.findChild(go, "toy2")
	local imgToy1 = goutil.findChild(toy1Go, "imgToy1")
	local imgToy2 = goutil.findChild(toy2Go, "imgToy2")
	local name = goutil.findChildTextComponent(go, "name/txtName")
	local btn = goutil.findChild(go, "btn")
	local tableList = self._itemTableListMap[go]

	if not tableList then
		tableList = ScrollerList.create(tableView, self._itemCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
		self._itemTableListMap[go] = tableList

		tableList:setCenterMode(true)
		tableList:dragNotifyParent()
	end

	local prizeArray = string.split(data.prize, "#")

	if checknumber(data.score) > 0 then
		local scoreItemStr = string.format("%d:%d:%d", self._scoreMatType, self._scoreMatId, data.score)

		table.insert(prizeArray, scoreItemStr)
	end

	local isActiveManual = TianYanMatchModel.instance:isActiveManual(self._activityId, data.manualId)
	local isGainPrize = TianYanMatchModel.instance:isGainManualPrize(self._activityId, data.manualId)
	local isCanGet = not isGainPrize and isActiveManual

	if not isGainPrize then
		local prizeList = {}

		for i, v in ipairs(prizeArray) do
			table.insert(prizeList, {
				cfg = v,
				isCanGet = isCanGet
			})
		end

		tableList:reloadData(prizeList)
		uGuiUtil.clearImage(imgToy1)
		uGuiUtil.clearImage(imgToy2)

		name.text = lang("未解锁")
	else
		tableList:dispose()

		local toy1Cfg = TianYanMatchConfig.instance:getToyCfg(self._activityId, data.matchToyIds[1])
		local toy2Cfg = TianYanMatchConfig.instance:getToyCfg(self._activityId, data.matchToyIds[2])

		uGuiUtil.setSpriteToImage(imgToy1, nil, toy1Cfg.res)
		uGuiUtil.setSpriteToImage(imgToy2, nil, toy2Cfg.res)

		name.text = data.name
	end

	GameUtil.SetActive(toy1Go, isGainPrize)
	GameUtil.SetActive(toy2Go, isGainPrize)
	GameUtil.SetActive(tableView, not isGainPrize)
	GameUtil.SetActive(btn, isCanGet)
	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickManual(data.manualId)
	end)
end

function TianYanMatchManualView:_clearComboCell(cell)
	local go = cell.gameObject

	if self._itemTableListMap[go] then
		self._itemTableListMap[go]:dispose()

		self._itemTableListMap[go] = nil
	end
end

function TianYanMatchManualView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local effectCon = goutil.findChild(go, "effectCon")

	if data.isCanGet == true then
		self:playViewEffectUniGo(PRIZE_CAN_GAIN_EFFECT_PATH, effectCon, self._viewport, true)
	else
		self:stopViewEffectUniGo(effectCon)
	end

	MaterialMgr.setCellByCfg(data.cfg, con)
end

function TianYanMatchManualView:_clearItemCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local effectCon = goutil.findChild(go, "effectCon")

	self:stopViewEffectUniGo(effectCon)
	MaterialMgr.resetAll(con)
end

function TianYanMatchManualView:_onClickManual(manualId)
	local isActiveManual = TianYanMatchModel.instance:isActiveManual(self._activityId, manualId)
	local isGainPrize = TianYanMatchModel.instance:isGainManualPrize(self._activityId, manualId)

	if not isGainPrize and isActiveManual then
		TianYanMatchAgent.instance:sendPM_TianYanMatchGainManualPrizeReq(self._activityId, manualId)
	end
end

return TianYanMatchManualView
