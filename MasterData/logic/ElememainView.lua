-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eleme/view/ElememainView.lua

module("logic.extensions.eleme.view.ElememainView", package.seeall)

local ElememainView = class("ElememainView", ViewComponent)

function ElememainView:ctor()
	ElememainView.super.ctor(self)
end

function ElememainView:unbindEvents()
	ElememainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPrize)
end

function ElememainView:bindEvents()
	ElememainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
end

function ElememainView:buildUI()
	ElememainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnPrize = self:getGo("btnPrize")
	self._redPoint = self:getGo("btnPrize/redPoint")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtDesc = self:getTxt("desc/txt")

	local tableView = self:getGo("tableview")
	local cell = self:getGo("cell")

	self._scrollList = ScrollerList.create(tableView, cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self._clippRect = self:getGo("tableview/Viewport"):GetComponent(goutil.Type_RectTransform)
end

function ElememainView:onExit()
	ElememainView.super.onExit(self)
	self._scrollList:dispose()
	RedPointController.instance:unregRedPoint(self._redPoint)
	UIEffectManager.instance:stopEffect(self._effectHandler)
end

function ElememainView:onEnter()
	ElememainView.super.onEnter(self)

	self._activityId = 332001
	self._effMap = {}
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local cfg = ElemeConfig.instance:getActivityCfgById(self._activityId) or {}

	RedPointController.instance:regRedPoint(self._redPoint, checknumber(cfg.redPointId))
	self:_refreshUI()
	self.addGEvent(self, GlobalNotify.ElemeInfoUpdate, self._refreshUI, self)
	ElemeController.instance:sendGetInfo(self._activityId)

	local effName = "20240119/nuandongjisong/fx_ui_nuandongjisong_fw.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self.mainGO.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(0, 0, 0)
end

function ElememainView:_refreshUI()
	local msgInfo = ElemeModel.instance:getMsgInfo(self._activityId) or {}

	if not msgInfo.orders then
		local list = {}

		ArraySort.sortOn(list, {
			function(a)
				if a.state == 2 then
					return 1
				else
					return 0
				end
			end,
			"index"
		}, {
			ArraySort.NUMERIC,
			ArraySort.NUMERIC
		})
		self._scrollList:reloadData(list)

		local cfg = ElemeConfig.instance:getActivityCfgById(self._activityId) or {}

		self._txtDesc.text = math.max(0, checknumber(cfg.refreshNum) - checknumber(msgInfo.refreshTimes))
	end
end

function ElememainView:_onClickTips()
	TipsFacade.instance:openRulesView("elememainview_rules")
end

function ElememainView:_onClickPrize()
	UIStateManager.instance:push(ViewName.ElemeprizeView, self._activityId)
end

function ElememainView:clearCell(cell)
	local btnOK = goutil.findChild(cell, "btnOK")
	local btnRefresh = goutil.findChild(cell, "btnRefresh")

	GameUtil.rmClickHandler(btnOK)
	GameUtil.rmClickHandler(btnRefresh)

	local eff = self._effMap[cell]

	if eff then
		UIEffectManager.instance:stopEffect(eff)

		self._effMap[cell] = nil
	end
end

local path = "20240119/nuandongjisong/fx_ui_wuxingfx_fw.prefab"

function ElememainView:_updateCell(view, cell, data, tag)
	local tag1 = goutil.findChild(cell, "tag1")
	local txtTag1 = goutil.findChildTextComponent(cell, "tag1/txt")
	local tag2 = goutil.findChild(cell, "tag2")
	local btnOK = goutil.findChild(cell, "btnOK")
	local txtOK = goutil.findChildTextComponent(cell, "btnOK/txt")
	local btnRefresh = goutil.findChild(cell, "btnRefresh")
	local txtNo = goutil.findChildTextComponent(cell, "txtNo/txt")
	local txtAddr = goutil.findChildTextComponent(cell, "txtAddr/txt")
	local txtMenu = goutil.findChildTextComponent(cell, "txtMenu/txt")
	local txtUser = goutil.findChildTextComponent(cell, "txtUser/txt")
	local cfg = ElemeConfig.instance:getOrderByActId(self._activityId, data.orderId) or {}
	local likeNum = checknumber(cfg.likeNum)

	for i = 1, 5 do
		local star = goutil.findChild(cell, "txtStar/star_" .. i)

		GameUtil.SetActive(star, i <= likeNum)
	end

	local eff = self._effMap[cell]

	if eff then
		UIEffectManager.instance:stopEffect(eff)

		self._effMap[cell] = nil
	end

	GameUtil.SetActive(tag1, data.state == 0 or data.state == 1)

	if data.state == 0 then
		txtTag1.text = "可\n接\n单"

		if likeNum == 5 then
			self._effMap[cell] = self:_playEffect(path, cell, self._clippRect)
		end
	else
		txtTag1.text = "已\n接\n单"

		if likeNum == 5 then
			self._effMap[cell] = self:_playEffect(path, cell, self._clippRect)
		end
	end

	GameUtil.SetActive(tag2, data.state == 2)
	GameUtil.SetGray(btnOK, data.state == 2)

	txtOK.text = "抢单"

	if data.state == 1 then
		txtOK.text = "前往"
	end

	GameUtil.SetGray(btnRefresh, data.state ~= 0)

	txtNo.text = string.format("%05d", cfg.orderId)

	local npcCfg = ElemeConfig.instance:getNpcById(data.index)

	txtAddr.text = npcCfg.sceneName
	txtUser.text = npcCfg.name
	txtMenu.text = cfg.desc

	GameUtil.addClickHandler(btnOK, GameUtil.handler(self._onClickCellOk, self, data))
	GameUtil.addClickHandler(btnRefresh, GameUtil.handler(self._onClickCellRefresh, self, data))
end

function ElememainView:_stopEffect(eff)
	UIEffectManager.instance:stopEffect(eff)
end

function ElememainView:_playEffect(path, parent, clippRect)
	local effect = UIEffectManager.instance:playEffect(self, path, parent, 0, 0, true, nil, nil, function(target, eff)
		if clippRect then
			eff:setClipping(clippRect)
		end
	end, self)

	effect:setParent(parent.transform)
	effect:setLocalPos(0, 0, 0)
	effect:setScale(1)

	return effect
end

function ElememainView:_onClickCellOk(data)
	if data.state == 2 then
		TipsFacade.instance:openCommonTips("当前订单已完成")
	elseif data.state == 0 then
		ElemeController.instance:sendTakeOrder(self._activityId, data.index)
	else
		local npcCfg = ElemeConfig.instance:getNpcById(data.index)

		SceneNpcsMgr.instance:createNpc(npcCfg.npcId)
		UIStateManager.instance:clear()
		TaskController.instance:foreceClearState()
		TaskController.instance:gotoNpc(npcCfg.npcId)
	end
end

function ElememainView:_onClickCellRefresh(data)
	if data.state == 0 then
		local msgInfo = ElemeModel.instance:getMsgInfo(self._activityId) or {}
		local cfg = ElemeConfig.instance:getActivityCfgById(self._activityId) or {}

		if checknumber(cfg.refreshNum) - checknumber(msgInfo.refreshTimes) > 0 then
			ElemeController.instance:sendRefreshOrder(self._activityId, data.index)
		else
			TipsFacade.instance:openCommonTips("本日刷新次数已用完~")
		end
	else
		TipsFacade.instance:openCommonTips("当前订单不能刷新")
	end
end

return ElememainView
