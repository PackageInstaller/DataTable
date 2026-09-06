-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flowergoddess/view/FlowerGoddessMainView.lua

module("logic.extensions.flowergoddess.view.FlowerGoddessMainView", package.seeall)

local FlowerGoddessMainView = class("FlowerGoddessMainView", ViewComponent)

function FlowerGoddessMainView:ctor()
	FlowerGoddessMainView.super.ctor(self)
end

function FlowerGoddessMainView:buildUI()
	FlowerGoddessMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._mask = goutil.findChild(self.mainGO, "mask")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
	self._petCon = goutil.findChild(self.mainGO, "petCol/petCon")
	self._petBubble = goutil.findChild(self.mainGO, "petCol/petBubble")
	self._txtBubble = goutil.findChildTextComponent(self.mainGO, "petCol/petBubble/txtBubble")
	self._btnFlower = goutil.findChild(self.mainGO, "btnFlower")
	self._btnGain = goutil.findChild(self.mainGO, "btnGain")
	self._btnFlowerRed = goutil.findChild(self.mainGO, "btnFlower/imgRed")
	self._btnGainRed = goutil.findChild(self.mainGO, "btnGain/imgRed")
	self._goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._proScrollerViewGo = goutil.findChild(self.mainGO, "scoreprogressview/scrollerview")
	self._proScrollerCellGo = goutil.findChild(self.mainGO, "scoreprogressview/scrollercell")
	self._btnbubTip = goutil.findChild(self.mainGO, "scoreprogressview/total/btnTip")
	self._progressNum = goutil.findChildTextComponent(self.mainGO, "scoreprogressview/total/txtNum")
	self._bubble = goutil.findChild(self.mainGO, "scoreprogressview/bubble")
	self._closeBub = goutil.findChild(self.mainGO, "scoreprogressview/bubble/btnClose")
	self._txtBub = goutil.findChildTextComponent(self.mainGO, "scoreprogressview/bubble/txtDesc")
	self._goddessScrollerview = goutil.findChild(self.mainGO, "goddessCol/goddessScrollerview")
	self._goddessScrollercell = goutil.findChild(self.mainGO, "goddessCol/goddessScrollercell")
	self._progressList = ProgressList.create(self._proScrollerViewGo, self._proScrollerCellGo, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
	self._goddessScrollList = ScrollerList.create(self._goddessScrollerview, self._goddessScrollercell, GameUtil.handler(self._updateGoddessCell, self), GameUtil.handler(self._clearGoddessCell, self))
	self._bgEff = nil
	self._proEffList = {}
end

function FlowerGoddessMainView:bindEvents()
	FlowerGoddessMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnFlower, self._onClickFlower, self)
	GameUtil.addClickHandler(self._btnGain, self._onClickGain, self)
end

function FlowerGoddessMainView:unbindEvents()
	FlowerGoddessMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnFlower)
	GameUtil.rmClickHandler(self._btnGain)
end

function FlowerGoddessMainView:destroyUI()
	FlowerGoddessMainView.super.destroyUI(self)
end

function FlowerGoddessMainView:onEnter()
	FlowerGoddessMainView.super.onEnter(self)

	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.FlowerGoddess)

	if actCfg then
		self._activityId = actCfg.activityId
	else
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._gfCfg = FlowerGoddessConfig.instance:getGfCfg(self._activityId)
	self._gfGoddessCfg = FlowerGoddessConfig.instance:getGfGoddessCfg(self._activityId)
	self._gfPlanCfg = FlowerGoddessConfig.instance:getGfPlanCfg(self._activityId)
	self._gfProCfg = FlowerGoddessConfig.instance:getGfProCfg(self._activityId)
	self._selectGoddessId = self._selectGoddessId or 1

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.FlowerGoddessGetInfo, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.FlowerGoddessHandleSendFlower, self._handleSendFlower, self)
	GlobalDispatcher:addListener(GlobalNotify.FlowerGoddessSendFlower, self._sendFlower, self)
	GlobalDispatcher:addListener(GlobalNotify.FlowerGoddessGainProPrize, self._handleProPrizeRes, self)
	FlowerGoddessController.instance:onSendPM_SendGoddessFlowerGetInfoReq(self._activityId)
end

function FlowerGoddessMainView:onExit()
	FlowerGoddessMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FlowerGoddessGetInfo, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.FlowerGoddessHandleSendFlower, self._handleSendFlower, self)
	GlobalDispatcher:removeListener(GlobalNotify.FlowerGoddessSendFlower, self._sendFlower, self)
	GlobalDispatcher:removeListener(GlobalNotify.FlowerGoddessGainProPrize, self._handleProPrizeRes, self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	UIEffectManager.instance:stopEffect(self._bgEff)
	UIEffectManager.instance:stopEffect(self._flowerEff)
	self._goddessScrollList:dispose()
	RedPointController.instance:unregRedPoint(self._btnGainRed)
	RedPointController.instance:unregRedPoint(self._btnFlowerRed)
end

function FlowerGoddessMainView:_onSetUI()
	RedPointController.instance:regRedPoint(self._btnGainRed, 228)
	RedPointController.instance:regRedPoint(self._btnFlowerRed, -204)

	if self._goldBarCon then
		local list = {}

		for _, data in ipairs(self._gfPlanCfg) do
			tab = {
				showAdd = false,
				id = data.flowerItem
			}

			table.insert(list, tab)
		end

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	end

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.FlowerGoddess, self._activityId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	if self._txtOpenTime then
		self._txtOpenTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	end

	local effGo = self.mainGO
	local path = "20220318/songhua/fx_ui_songhua_daiji"

	UIEffectManager.instance:stopEffect(self._bgEff)

	if effGo and not string.nilorempty(path) then
		local pathName = path .. ".prefab"

		local function func(_, eff)
			eff:setParent(effGo.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._bgEff = UIEffectManager.instance:playEffect(self, pathName, effGo, 0, 0, true, false, nil, func, nil)
	end
end

function FlowerGoddessMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function FlowerGoddessMainView:_onUpdateData()
	self:_onUpdateDataMo()
end

function FlowerGoddessMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateGoddessScrollerList()
	self:_onUpdateProgressPrize()
end

function FlowerGoddessMainView:_onUpdateDataMo()
	return
end

function FlowerGoddessMainView:_onUpdatePlaneUI()
	local goddessData = self._gfGoddessCfg[self._selectGoddessId]
	local skineId = goddessData.skineId
	local scale = goddessData.scale

	if not goddessData.pos then
		local pos = {}
		local x, y = pos[1], pos[2]

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skineId, self._petCon, scale, nil, true, x, y)

		self:_hideBubu()
	end
end

function FlowerGoddessMainView:_onUpdateGoddessScrollerList()
	self._goddessScrollList:reloadData(self._gfGoddessCfg)

	local idx = math.max(0, self._selectGoddessId - 1)
	local isMotion = true

	self._goddessScrollList:MoveCellInView(idx, isMotion)
end

function FlowerGoddessMainView:_updateGoddessCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local iconGo = goutil.findChild(mainGo, "icon")
	local selectGo = goutil.findChild(mainGo, "select")
	local isSelected = self._selectGoddessId == data.goddessId

	GameUtil.SetActive(selectGo, isSelected)
	MaterialMgr.setIcon(iconGo, MatType.Pet, data.skineId, nil, nil)

	local function handler()
		self._selectGoddessId = data.goddessId

		self:_onUpdatePlaneUI()
		self:_onUpdateGoddessScrollerList()
	end

	GameUtil.addClickHandler(mainGo, handler)
end

function FlowerGoddessMainView:_clearGoddessCell(cell)
	local mainGo = cell.gameObject
	local iconGo = goutil.findChild(mainGo, "icon")

	MaterialMgr:clearIcon(iconGo)
end

function FlowerGoddessMainView:_onUpdateProgressPrize()
	local dataList = {}

	for prizeId, data in ipairs(self._gfProCfg) do
		data.prizeId = prizeId
		data.needIntimacy = data.needIntimacy
		data.prize = MaterialMgr.filterClothsArr(data.prize)[1]
		data.isHasGain = FlowerGoddessController.instance:isHasGainPrize(prizeId)
		data.isCanGet = FlowerGoddessController.instance:isCanGainPrize(prizeId)

		table.insert(dataList, data)
	end

	self._progressList:reloadDataList(dataList)
	self._progressList:updateCell()

	local curProgress = FlowerGoddessModel.instance:getCurInitimacy()
	local proList = {}

	for _, data in ipairs(self._gfProCfg) do
		table.insert(proList, data.needIntimacy)
	end

	self._progressList:updateProgressByList(proList, curProgress)

	local index = 0

	for idx, data in ipairs(dataList) do
		if data.isCanGet then
			index = idx

			break
		end
	end

	if index ~= 0 then
		self._progressList:rollToIdx(index)
	else
		self._progressList:rollToIdxNewest(proList, curProgress)
	end

	if self._progressNum then
		self._progressNum.text = string.format("%d", curProgress)
	end
end

function FlowerGoddessMainView:_updateProgressCell(go, data, idx)
	local mainGo = go
	local item = goutil.findChild(mainGo, "item/itemcell")
	local effGo = goutil.findChild(mainGo, "item/effGo")
	local received = goutil.findChild(mainGo, "item/received")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")

	if not string.nilorempty(data.prize) then
		MaterialMgr.setCellByCfg(data.prize, item, urlOrGo, luaCls, isOne)
	end

	if txtNum then
		txtNum.text = data.needIntimacy
	end

	GameUtil.SetActive(received, data.isHasGain)

	local function handler()
		if data.isCanGet == true then
			local activityId = self._activityId
			local prizeId = data.prizeId

			FlowerGoddessController.instance:onSendPM_SendGoddessFlowerGainProgressPrizeReq(activityId, prizeId)
		end
	end

	GameUtil.SetActive(btnGet, data.isCanGet)
	GameUtil.addClickHandler(btnGet, handler)
	UIEffectManager.instance:stopEffect(self._proEffList[mainGo])

	if data.isCanGet == true then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setScrollRectClipping(self._proScrollerViewGo:GetComponent(ComponentType.ScrollRect))
			eff:setParent(effGo.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._proEffList[mainGo] = UIEffectManager.instance:playEffect(self, effPath, effGo, 0, 0, true, false, nil, func, nil)
	end
end

function FlowerGoddessMainView:_clearProgressCell(go, data, idx)
	local mainGo = go

	MaterialMgr.resetAll(goutil.findChild(mainGo, "item/itemcell"))
	GameUtil.rmClickHandler(goutil.findChild(mainGo, "btnGet"))
	UIEffectManager.instance:stopEffect(self._proEffList[mainGo])
end

function FlowerGoddessMainView:_handleProPrizeRes()
	self:_onUpdateProgressPrize()

	local goddessData = self._gfGoddessCfg[self._selectGoddessId]

	self:_showBubu(goddessData.txtBubByPrize)
end

function FlowerGoddessMainView:_showBubu(txtContent)
	if not string.nilorempty(txtContent) and self._txtBubble then
		self._txtBubble.text = txtContent
	end

	GameUtil.SetActive(self._petBubble, true)
	removetimer(self._hideBubu, self)
	settimer(5, self._hideBubu, self, false)
end

function FlowerGoddessMainView:_hideBubu()
	removetimer(self._hideBubu, self)
	GameUtil.SetActive(self._petBubble, false)
end

function FlowerGoddessMainView:_onClickFlower()
	UIStateManager.instance:push(ViewName.FlowerPopView)
end

function FlowerGoddessMainView:_onClickGain()
	UIStateManager.instance:push(ViewName.GuessBoxMainView)
end

function FlowerGoddessMainView:_sendFlower(activityId, flowerId, flowerNum)
	FlowerGoddessController.instance:onSendPM_SendGoddessFlowerReq(activityId, flowerId, flowerNum)
end

function FlowerGoddessMainView:_handleSendFlower(changeSetId)
	self:_onUpdateProgressPrize()

	local effGo = self.mainGO
	local path = "20220318/songhua/fx_ui_songhua_songhua"

	UIEffectManager.instance:stopEffect(self._flowerEff)

	if effGo and not string.nilorempty(path) then
		local pathName = path .. ".prefab"

		local function func(_, eff)
			eff:setParent(effGo.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		local function finishHandler()
			GameUtil.SetActive(self._mask, false)

			if changeSetId ~= 0 then
				MaterialController.instance:showChangeSetInTemp(changeSetId)
			end

			local goddessData = self._gfGoddessCfg[self._selectGoddessId]

			self:_showBubu(goddessData.txtBubByFlower)
		end

		GameUtil.SetActive(self._mask, true)

		self._flowerEff = UIEffectManager.instance:playEffect(self, pathName, effGo, 0, 0, false, false, finishHandler, func, nil)
	end
end

function FlowerGoddessMainView:_onClickTip()
	TipsFacade.instance:openRulesView("sendGoddessFlower_rule")
end

return FlowerGoddessMainView
