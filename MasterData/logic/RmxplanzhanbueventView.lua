-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanzhanbueventView.lua

module("logic.extensions.richmanxplan.view.RmxplanzhanbueventView", package.seeall)

local RmxplanzhanbueventView = class("RmxplanzhanbueventView", ViewComponent)

function RmxplanzhanbueventView:ctor()
	RmxplanzhanbueventView.super.ctor(self)
end

function RmxplanzhanbueventView:unbindEvents()
	RmxplanzhanbueventView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
end

function RmxplanzhanbueventView:bindEvents()
	RmxplanzhanbueventView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
end

function RmxplanzhanbueventView:buildUI()
	RmxplanzhanbueventView.super.buildUI(self)

	self._goldconGo = self:getGo("goldcon")
	self._btnTip = self:getBtn("btnTip")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtMat = self:getTxt("matCell/txtMat")
	self._tablecell1Go = self:getGo("tablecell1")
	self._tableview1Go = self:getGo("tableview1")
	self._scrollerListLeft = ScrollerList.create(self._tableview1Go, self._tablecell1Go, GameUtil.handler(self._updateCellLeft, self), GameUtil.handler(self._clearCellLeft, self))
	self._blockGo = self:getGo("block")
end

function RmxplanzhanbueventView:onExit()
	RmxplanzhanbueventView.super.onExit(self)
	self._scrollerList:dispose()
	self._scrollerListLeft:dispose()

	if self._boomEffectHandler then
		UIEffectManager.instance:stopEffect(self._boomEffectHandler)

		self._boomEffectHandler = nil
	end

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end

	if self._wineffectHandler then
		UIEffectManager.instance:stopEffect(self._wineffectHandler)

		self._wineffectHandler = nil
	end
end

function RmxplanzhanbueventView:onEnter()
	RmxplanzhanbueventView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RichManXPlanEventRes, self._onRichManXPlanEventRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._event = params[2]
	self._score = RichmanxplanModel.instance:getScore(self._activityId)
	self._eventCfg = RichmanxplanConfig.instance:getZhanbuEventCfg(self._activityId, self._event.eventId)
	self._selectItems = {}
	self._openCellIndexs = {}
	self._iconCfgs = RichmanxplanConfig.instance:getZhanbuIconCfg(self._activityId)

	self:_updateUI()
	self:_setEffect()
	goutil.setActive(self._blockGo, false)
end

function RmxplanzhanbueventView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("rmxplanzhanbueventview")
end

function RmxplanzhanbueventView:_updateUI()
	local itemIds = self:_getItemIds()

	itemIds = self:_breakUpItemIds(itemIds)

	self._scrollerList:reloadData(itemIds)
	self:_updateMat()
	self:_updateDesc()
end

function RmxplanzhanbueventView:_getItemIds()
	local itemIds = {}
	local tarotNum = self._eventCfg.tarotNum
	local gridNum = self._eventCfg.gridNum
	local itemCfgs = RichmanxplanConfig.instance:getZhanbuItemCfgs(self._activityId, self._event.eventId)
	local itemTypeIds = {}
	local needAddGridNum = gridNum - self._eventCfg.boomNum
	local addGridNum = 0

	for i, v in ipairs(itemCfgs) do
		table.insert(itemTypeIds, v.itemId)
	end

	itemTypeIds = GameUtil.permuteArray(itemTypeIds)

	for i, v in ipairs(itemTypeIds) do
		for j = 1, tarotNum do
			table.insert(itemIds, v)

			addGridNum = addGridNum + 1

			if needAddGridNum <= addGridNum then
				break
			end
		end

		if needAddGridNum <= addGridNum then
			break
		end
	end

	for i = 1, self._eventCfg.boomNum do
		table.insert(itemIds, -1)
	end

	return itemIds
end

function RmxplanzhanbueventView:_breakUpItemIds(itemIds)
	return GameUtil.permuteArray(itemIds)
end

function RmxplanzhanbueventView:_onRichManXPlanEventRes(msg)
	if msg.isEnd then
		self:close()

		return
	end
end

function RmxplanzhanbueventView:_updateCell(view, cell, itemId, tag)
	local btnBg = Framework.ButtonAdapter.GetFrom(cell.gameObject, "bg")
	local goIcon = goutil.findChild(cell, "icon")
	local goMask = goutil.findChild(cell, "mask")

	goutil.setActive(goMask, not self._openCellIndexs[cell.data])
	uGuiUtil.setSpriteToImage(goIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(self._iconCfgs[itemId].iconRes))
	btnBg:AddClickListener(function()
		if self._openCellIndexs[cell.data] then
			return
		end

		self._openCellIndexs[cell.data] = true

		self._scrollerList:refresh()

		if itemId == -1 then
			self:_playBoomEffect()

			return
		end

		self._selectItems[itemId] = self._selectItems[itemId] or 0
		self._selectItems[itemId] = self._selectItems[itemId] + 1

		self:_checkGameOver()
	end)
end

function RmxplanzhanbueventView:_clearCell(cell)
	local goIcon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(goIcon)
end

function RmxplanzhanbueventView:_playBoomEffect()
	goutil.setActive(self._blockGo, true)

	local effName = "fx_ui_sanxiao/fx_ui_sanxiao_zhadan.prefab"

	self._boomEffectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false, nil, function()
		self:_boomFinish()
	end)

	self._boomEffectHandler:setParent(self.mainGO.transform)
	self._boomEffectHandler:setScale(1)
	self._boomEffectHandler:setLocalPos(0, 0, 0)
end

function RmxplanzhanbueventView:_boomFinish()
	local rateValue = RichmanxplanModel.instance:getBuffRate(self._activityId)
	local value = self._eventCfg.prize * (1 + rateValue)

	TipsFacade.instance:openTipWindowNoX("提示", string.format("不小心点到了炸弹,获得资金x%s", value), function()
		local t = {
			itemId = -1
		}

		RichManXPlanAgent.instance:sendPM_RichManXPlanEventReq(self._activityId, false, GameUtil.jsonToString(t))
	end)
end

function RmxplanzhanbueventView:_checkGameOver()
	for k, num in pairs(self._selectItems) do
		if num >= self._eventCfg.tarotNum then
			self._winItemId = k

			self:_playWinEffect()

			return
		end
	end
end

function RmxplanzhanbueventView:_updateMat()
	self._txtMat.text = self._score
end

function RmxplanzhanbueventView:_updateDesc()
	local cfgs = RichmanxplanConfig.instance:getZhanbuItemCfgs(self._activityId, self._event.eventId)

	self._scrollerListLeft:reloadData(cfgs)
end

function RmxplanzhanbueventView:_updateCellLeft(view, cell, cfg, tag)
	local goItem = goutil.findChild(cell.gameObject, "item")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local num = 0

	if cfg.type == RichmanxplanController.ShopItemType.Item then
		local matType, matId, n = MaterialMgr.getMatParams(cfg.param)

		MaterialMgr.setIcon(goItem, matType, matId)

		num = n
	elseif cfg.type == RichmanxplanController.ShopItemType.Buff then
		local buffCfg = RichmanxplanConfig.instance:getBuffCfg(self._activityId, checknumber(cfg.param))

		uGuiUtil.setSpriteToImage(goItem, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(buffCfg.iconRes))

		num = 1
	elseif cfg.type == RichmanxplanController.ShopItemType.Score then
		uGuiUtil.setSpriteToImage(goItem, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl("com_icon_yidiechaopiao"))

		num = checknumber(cfg.param)
	end

	txtDesc.text = string.format("X%s", num)

	for i = 1, 3 do
		local go = goutil.findChild(cell.gameObject, "icon" .. i)

		uGuiUtil.setSpriteToImage(go, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(self._iconCfgs[cfg.itemId].iconRes))
	end
end

function RmxplanzhanbueventView:_clearCellLeft(cell)
	local goItem = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(goItem)
	uGuiUtil.clearImage(goItem)

	for i = 1, 3 do
		local go = goutil.findChild(cell, "icon" .. i)

		uGuiUtil.clearImage(go)
	end
end

function RmxplanzhanbueventView:_setEffect()
	local effName = "20240531/dafuweng/fx_ui_tongyongfenwei_dfw.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self.mainGO.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(0, 0, 0)
end

function RmxplanzhanbueventView:_playWinEffect()
	goutil.setActive(self._blockGo, true)

	local effName = "20240531/dafuweng/fx_ui_chaopiao2_dfw.prefab"

	self._wineffectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false, nil, function()
		self:_playWinEffectFinish()
	end)

	self._wineffectHandler:setEffTime(1.2)
	self._wineffectHandler:setParent(self.mainGO.transform)
	self._wineffectHandler:setScale(1)
	self._wineffectHandler:setLocalPos(0, 0, 0)
end

function RmxplanzhanbueventView:_playWinEffectFinish()
	local itemCfg = RichmanxplanConfig.instance:getZhanbuItemCfg(self._activityId, self._eventCfg.eventId, self._winItemId)
	local rateValue = RichmanxplanModel.instance:getBuffRate(self._activityId)
	local content = string.format("恭喜本次占卜格获得资金x%s", checknumber(itemCfg.param) * (1 + rateValue))

	TipsFacade.instance:openTipWindowNoX("提示", content, function()
		local t = {
			itemId = self._winItemId
		}

		RichManXPlanAgent.instance:sendPM_RichManXPlanEventReq(self._activityId, false, GameUtil.jsonToString(t))
	end)
end

return RmxplanzhanbueventView
