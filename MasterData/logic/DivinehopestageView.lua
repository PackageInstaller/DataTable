-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehope/view/DivinehopestageView.lua

module("logic.extensions.divinehope.view.DivinehopestageView", package.seeall)

local DivinehopestageView = class("DivinehopestageView", ViewComponent)

function DivinehopestageView:ctor()
	DivinehopestageView.super.ctor(self)
end

function DivinehopestageView:unbindEvents()
	DivinehopestageView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnHope:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnReset:RemoveClickListener()
end

function DivinehopestageView:bindEvents()
	DivinehopestageView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnHope:AddClickListener(self._onClickbtnHope, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnReset:AddClickListener(self._onClickbtnReset, self)
end

function DivinehopestageView:buildUI()
	DivinehopestageView.super.buildUI(self)

	self._prizeTips = self:getGo("tips/prize")
	self._itemGo = self:getGo("item")
	self._itemsGo = self:getGo("items")
	self._slider = self:getSlider("slider")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnHope = self:getBtn("btnHope")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnReset = self:getBtn("items/btnReset")
	self._txtXiwang = self:getTxt("txtXiwang")
	self._txtYuwang = self:getTxt("txtYuwang")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	goutil.setActive(self._itemGo, false)

	self._items = {}
end

function DivinehopestageView:onExit()
	DivinehopestageView.super.onExit(self)
	self._scrollerList:dispose()
	MaterialMgr.resetAll(self._prizeTips)
end

function DivinehopestageView:onEnter()
	DivinehopestageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineHopeResetFloorRes, self._updateUI, self)

	self._activityId = self:getFirstParam()
	self._selectFloorId = -1

	self:_updateUI()
end

function DivinehopestageView:_updateUI()
	local cfgs = DivinehopeConfig.instance:getFloorCfgs(self._activityId)

	self:_autoSelectFloorOne()
	self._scrollerList:reloadData(cfgs)
	self:_onClickTab(self._selectFloorId)

	local data = DivinehopeConfig.instance:getFloorCfg(self._activityId, self._selectFloorId)

	MaterialMgr.setCellByCfg(data.prize, self._prizeTips)

	local hopeValue = data.passNeedHope
	local desireValue = data.passNeedDesire
	local totalValue = hopeValue + desireValue
	local rateDesire = desireValue / totalValue

	self._slider:SetValue(rateDesire)
end

function DivinehopestageView:_autoSelectFloorOne()
	if self._selectFloorId < 0 then
		local cfgs = DivinehopeConfig.instance:getFloorCfgs(self._activityId)

		for i = 1, #cfgs do
			local cfg = cfgs[i]
			local prePass = i == 1 or DivinehopeModel.instance:isFloorPass(self._activityId, cfgs[i - 1].floorId)
			local curPass = DivinehopeModel.instance:isFloorPass(self._activityId, cfg.floorId)

			if prePass and not curPass then
				self._selectFloorId = cfg.floorId

				break
			end
		end

		if self._selectFloorId < 0 then
			self._selectFloorId = cfgs[#cfgs].floorId
		end
	end
end

function DivinehopestageView:_onClickbtnClose()
	self:close()
end

function DivinehopestageView:_onClickbtnHope()
	local isPass = DivinehopeModel.instance:isFloorPass(self._activityId, self._selectFloorId)

	if isPass then
		FloatWordMgr.instance:show("您已通关无需再次许愿")

		return
	end

	local stageId = DivinehopeModel.instance:getCurStageId(self._activityId, self._selectFloorId)
	local cfgs = DivinehopeConfig.instance:getStageCfgsByFloor(self._activityId, self._selectFloorId)

	if stageId + 1 > #cfgs then
		FloatWordMgr.instance:show("您未达到本层欲望与希望分数要求，请重置后再试")

		return
	end

	UIStateManager.instance:push(ViewName.DivinehopeselectView, self._activityId, self._selectFloorId)
end

function DivinehopestageView:_onClickbtnTip()
	local challengeCfg = DivinehopeController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function DivinehopestageView:_onClickbtnReset()
	if self._divineHopeFloorInfo then
		if #self._divineHopeFloorInfo.useWishId <= 0 then
			FloatWordMgr.instance:show("无需重置")

			return
		end

		TipsFacade.instance:openPopupWindow("提示", "是否确认重置当前已通关的关", function()
			DivineHopeAgent.instance:sendPM_DivineHopeResetFloorReq(self._activityId, self._selectFloorId)
		end)
	end
end

function DivinehopestageView:_updateCell(view, cell, floorCfg, tag)
	local mainGo = cell.gameObject
	local goLock = goutil.findChild(cell.gameObject, "lock")
	local goPass = goutil.findChild(cell.gameObject, "pass")
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local isPass = DivinehopeModel.instance:isFloorPass(self._activityId, floorCfg.floorId)
	local isLock = floorCfg.floorId > 1 and not DivinehopeModel.instance:isFloorPass(self._activityId, floorCfg.floorId - 1)

	goutil.setActive(goLock, isLock)
	goutil.setActive(goPass, isPass)
	goutil.setActive(goSelect, self._selectFloorId == floorCfg.floorId)

	txtName.text = string.format("第%s层", floorCfg.floorId)

	GameUtil.addClickHandler(mainGo, function()
		if isLock then
			FloatWordMgr.instance:show("需要通关上一层")

			return
		end

		self:_onClickTab(floorCfg.floorId)
	end)
end

function DivinehopestageView:_clearCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function DivinehopestageView:_onClickTab(floorId)
	self._selectFloorId = floorId

	self._scrollerList:refresh()
	self:_updateRightView()
end

function DivinehopestageView:_updateRightView()
	self:_setHopeFloorInfo()
	self:_updateItems()
	self:_updateTxts()
end

function DivinehopestageView:_updateTxts()
	if self._divineHopeFloorInfo then
		local green = "#20b376"
		local red = "#eb4624"
		local floorCfg = DivinehopeConfig.instance:getFloorCfg(self._activityId, self._selectFloorId)
		local curHope = self._divineHopeFloorInfo.hopeScore
		local maxHope = floorCfg.passNeedHope
		local curDesire = self._divineHopeFloorInfo.desireScore
		local maxDesire = floorCfg.passNeedDesire

		self._txtXiwang.text = string.format("<color=#%s>%s</color>/%s", maxHope <= curHope and green or red, curHope, maxHope)
		self._txtYuwang.text = string.format("<color=#%s>%s</color>/%s", maxDesire <= curDesire and green or red, curDesire, maxDesire)
	else
		self._txtXiwang.text = "0/0"
		self._txtYuwang.text = "0/0"
	end
end

function DivinehopestageView:_setHopeFloorInfo()
	self._divineHopeFloorInfo = nil

	local info = DivinehopeModel.instance:getInfo(self._activityId)

	for i, v in ipairs(info.divineHopeFloorInfos) do
		if v.floorId == self._selectFloorId then
			self._divineHopeFloorInfo = v

			break
		end
	end
end

function DivinehopestageView:_hideAllItems()
	for i, v in ipairs(self._items) do
		v.isUse = false

		goutil.setActive(v.go, false)
		MaterialMgr.resetAll(v.conGo)
	end
end

function DivinehopestageView:_updateItems()
	self:_hideAllItems()

	local floorCfg = DivinehopeConfig.instance:getFloorCfg(self._activityId, self._selectFloorId)
	local stageCfg = DivinehopeConfig.instance:getStageCfgs(floorCfg.stagePlanId)

	for i, sCfg in ipairs(stageCfg) do
		local item = self:_getFreeItem()

		self:_updateItem(item, sCfg)
	end
end

function DivinehopestageView:_updateItem(item, stageCfg)
	local curPassSatgeId = #self._divineHopeFloorInfo.useWishId
	local isPass = curPassSatgeId >= stageCfg.stageId
	local isLastItem = not DivinehopeConfig.instance:getStageCfg(stageCfg.stagePlanId, stageCfg.stageId + 1)
	local isCur = curPassSatgeId + 1 == stageCfg.stageId
	local stageWishId = DivinehopeModel.instance:getStageWishType(self._activityId, self._selectFloorId, stageCfg.stageId)
	local nameStr

	if isPass then
		local wishCfg = DivinehopeConfig.instance:getWishCfg(self._activityId, stageWishId)

		nameStr = wishCfg and (wishCfg.wishType == 1 and "希望" or "欲望") or ""
	elseif isCur then
		local wishId = DivinehopeModel.instance:getSelectWishId(self._activityId)
		local wishCfg = DivinehopeConfig.instance:getWishCfg(self._activityId, wishId)

		nameStr = wishCfg and (wishCfg.wishType == 1 and "希望" or "欲望") or ""
	end

	local isEmpty = string.nilorempty(nameStr)

	item.txtName.text = nameStr

	GameUtil.SetActive(item.tagEmpty, isEmpty)
	GameUtil.SetActive(item.txtName.gameObject, not isEmpty)
	goutil.setActive(item.jtGo, not isLastItem)
	goutil.setActive(item.selectGo, isCur)
	goutil.setActive(item.passGo, isPass)
end

function DivinehopestageView:_getFreeItem()
	local item

	for i, v in ipairs(self._items) do
		if not v.isUse then
			item = v

			break
		end
	end

	if not item then
		local go = goutil.cloneAndSetParent(self._itemGo, self._itemsGo.transform)
		local jtGo = goutil.findChild(go, "jt")
		local selectGo = goutil.findChild(go, "select")
		local passGo = goutil.findChild(go, "pass")
		local tagEmpty = goutil.findChild(go, "tagEmpty")
		local txtName = goutil.findChildTextComponent(go, "txtName")

		item = {
			isUse = false,
			go = go,
			jtGo = jtGo,
			selectGo = selectGo,
			passGo = passGo,
			tagEmpty = tagEmpty,
			txtName = txtName
		}

		table.insert(self._items, item)
	end

	goutil.setActive(item.go, true)

	item.isUse = true

	return item
end

return DivinehopestageView
