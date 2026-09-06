-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/scroller/PassportScrollerView.lua

module("logic.extensions.passport.view.scroller.PassportScrollerView", package.seeall)

local PassportScrollerView = class("PassportScrollerView", ViewComponent)

function PassportScrollerView:ctor()
	PassportScrollerView.super.ctor(self)
end

function PassportScrollerView:buildUI()
	PassportScrollerView.super.buildUI(self)

	local viewContainer = self:getGo("container")

	self._buyTimeGo = goutil.findChild(viewContainer, "buyTimeGo")
	self._buyTimeTxt = goutil.findChildTextComponent(self._buyTimeGo, "buyTimeTxt")
	self._timeTipsGo = goutil.findChild(self.mainGO, "container/timeTips")
	self._timeTips = goutil.findChildTextComponent(self.mainGO, "container/timeTips/txt")
	self._btnInv = goutil.findChild(self.mainGO, "container/btnInv")
	self._taskScrollerview = goutil.findChild(self.mainGO, "container/mid/taskScrollerview")
	self._taskCol = goutil.findChild(self.mainGO, "container/mid/taskScrollerview/Viewport/taskCol")
	self._taskCell = goutil.findChild(self.mainGO, "container/mid/taskCell")
	self._normalCell = goutil.findChild(self.mainGO, "container/mid/normalCell")
	self._superCell = goutil.findChild(self.mainGO, "container/mid/superCell")
	self._petCol = goutil.findChild(self.mainGO, "container/petCol")
	self._petIcon = goutil.findChild(self.mainGO, "container/petCol/petIcon")
	self._imgRare = goutil.findChild(self.mainGO, "container/petCol/imgRare")
	self._txtName = goutil.findChild(self.mainGO, "container/petCol/txtName")
	self._btnInfo = goutil.findChild(self.mainGO, "container/petCol/btnInfo")
	self._btnSkill = goutil.findChild(self.mainGO, "container/petCol/btnSkill")
	self._role = nil

	GameUtil.SetActive(self._buyTimeGo, false)
	GameUtil.SetActive(self._timeTipsGo, false)
	GameUtil.SetActive(self._taskCell, false)
	GameUtil.SetActive(self._normalCell, false)
	GameUtil.SetActive(self._superCell, false)

	self._normalCellEffs = {}
	self._superCellEffs = {}
end

function PassportScrollerView:bindEvents()
	PassportScrollerView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnInv, self._onClickInv, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickBtnInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
end

function PassportScrollerView:unbindEvents()
	PassportScrollerView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnInv)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function PassportScrollerView:destroyUI()
	PassportScrollerView.super.destroyUI(self)
end

function PassportScrollerView:onEnter()
	PassportScrollerView.super.onEnter(self)

	self._passId = self:_getPassId()
	self._passPortFuncId = self._passId
	self._passportBaseData = PassportConfig.instance:getPassportBaseCfgById(self._passId)

	if self._passportBaseData == nil then
		printError("配置为nil, id = " .. self._passId)
		self:close()

		return
	end

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.PassportStateUpdate, self._onUpdate, self)
	PassportController.instance:sendGetInfoReq(self._passId, self._onUpdate, self)
end

function PassportScrollerView:onExit()
	PassportScrollerView.super.onExit(self)
	removetimer(self._updateTimer, self)
	GlobalDispatcher:removeListener(GlobalNotify.PassportStateUpdate, self._onUpdate, self)
	self:_clearTaskCol()

	self._role = RoleObjectPool.instance:removeRole(self._role)
end

function PassportScrollerView:_getPassId()
	return 5
end

function PassportScrollerView:_onSetUI()
	return
end

function PassportScrollerView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function PassportScrollerView:_onUpdateData()
	self:_onUpdateDataMo()
end

function PassportScrollerView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateTaskCol()
end

function PassportScrollerView:_onUpdateDataMo()
	self._actInfo = PassportModel.instance:getInfo(self._passPortFuncId)
	self._funcCfg = self._actInfo.funcCfg

	if self._actInfo == nil or self._funcCfg == nil then
		self:close()

		return
	end
end

function PassportScrollerView:_onUpdatePlaneUI()
	self:_setActivityTime()
	GameUtil.SetGray(self._btnInv, self._actInfo.hasPay)

	local skinId = self._passportBaseData.skinId
	local isNeedRole = skinId ~= 0 and false

	self._role = isNeedRole and RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._petIcon, scale, nil, true, x, y) or RoleObjectPool.instance:removeRole(self._role)
end

function PassportScrollerView:_onUpdateTaskCol()
	self:_updateCol(self._actInfo.prizeCfgs, self._taskCol, self._taskCell, GameUtil.handler(self._updateTaskCell, self))
end

function PassportScrollerView:_clearTaskCol()
	self:_clearCol(self._taskCol, GameUtil.handler(self._clearTaskCell, self))
end

function PassportScrollerView:_updateTaskCell(go, data, idx)
	local mainGo = go
	local taskIndex = idx
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local normalCol = goutil.findChild(mainGo, "normalCol")
	local superCol = goutil.findChild(mainGo, "superCol")
	local isEnoughProgress = taskIndex < self._actInfo.unlockIndex
	local isHasGetNormal = self._actInfo.normalPrizeState[taskIndex]
	local isCanGetNormal = isEnoughProgress and not isHasGetNormal
	local isHasGetSuper = self._actInfo.superPrizeState[taskIndex]
	local isCanGetSuper = isEnoughProgress and not isHasGetSuper and self._actInfo.hasPay
	local titleStr = self:_getTaskTitle(data)

	if txtTitle then
		txtTitle.text = titleStr
	end

	local normalStrList = string.split(data.freePrize, "#")
	local prizeDataList = {}

	for _, prizeStr in ipairs(normalStrList) do
		local t = {}

		t.prizeStr = prizeStr
		t.isEnoughProgress = isEnoughProgress
		t.isHasGet = isHasGetNormal
		t.isCanGet = isCanGetNormal
		t.taskIndex = taskIndex - 1

		table.insert(prizeDataList, t)
	end

	self:_updateCol(prizeDataList, normalCol, self._normalCell, GameUtil.handler(self._updateNormalCell, self))

	local superStrList = string.split(data.payedPrize, "#")

	prizeDataList = {}

	for _, prizeStr in ipairs(superStrList) do
		local t = {}

		t.prizeStr = prizeStr
		t.isEnoughProgress = isEnoughProgress
		t.isHasGet = isHasGetSuper
		t.isCanGet = isCanGetSuper
		t.taskIndex = taskIndex - 1

		table.insert(prizeDataList, t)
	end

	self:_updateCol(prizeDataList, superCol, self._superCell, GameUtil.handler(self._updateSuperCell, self))
end

function PassportScrollerView:_clearTaskCell(go)
	local mainGo = go
	local normalCol = goutil.findChild(mainGo, "normalCol")
	local superCol = goutil.findChild(mainGo, "superCol")

	self:_clearCol(normalCol, GameUtil.handler(self._clearNormalCell, self))
	self:_clearCol(superCol, GameUtil.handler(self._clearSuperCell, self))
end

function PassportScrollerView:_updateCol(dataList, parent, targetGo, handler)
	local childList = GameUtil.getChildren(parent)
	local dataListLen = #dataList

	for i, go in ipairs(childList) do
		if dataListLen < i then
			GameUtil.SetActive(go, false)
		end
	end

	for idx, data in ipairs(dataList) do
		if not childList[idx] then
			local go = goutil.cloneAndSetParent(targetGo, parent.transform)

			handler(childList[idx], data, idx)
			GameUtil.SetActive(childList[idx], true)
		end
	end
end

function PassportScrollerView:_clearCol(parent, handler)
	local childList = GameUtil.getChildren(parent)

	for i, go in ipairs(childList) do
		handler(go)
	end
end

function PassportScrollerView:_getTaskTitle(data)
	local titleStr = ""

	if self._actInfo.funcId == 1 then
		titleStr = data.thresholdParam
	elseif self._actInfo.funcId == 2 then
		titleStr = data.thresholdParam
	elseif self._actInfo.funcId == 3 then
		titleStr = data.thresholdParam
	elseif self._actInfo.funcId == 4 then
		local params = string.split(data.thresholdParam, "-")

		titleStr = string.format("第%s章", checkint(params[1]) - 1000)
	else
		titleStr = (self._actInfo.funcId == 5 or self._actInfo.funcId == PassportModel.ID_TenSeven) and string.format("第%d天", data.thresholdParam) or string.format("%s", data.thresholdParam)
	end

	return titleStr
end

function PassportScrollerView:_updateNormalCell(go, data, idx)
	local mainGo = go
	local item = goutil.findChild(mainGo, "item")
	local imgGet = goutil.findChild(mainGo, "imgGet")
	local red = goutil.findChild(mainGo, "red")
	local btnNormalGet = goutil.findChild(mainGo, "btnNormalGet")

	if item then
		MaterialMgr.setCellByCfg(data.prizeStr, item)
	end

	GameUtil.SetActive(imgGet, data.isHasGet)
	GameUtil.SetActive(red, data.isCanGet)
	UIEffectManager.instance:stopEffect(self._normalCellEffs[mainGo])

	if data.isCanGet then
		local effGo = item
		local path = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(target, eff)
			eff:setScrollRectClipping(self._taskScrollerview:GetComponent(ComponentType.ScrollRect))
			eff:setParent(effGo.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		self._normalCellEffs[mainGo] = UIEffectManager.instance:playEffect(self, path, effGo, 0, 0, true, false, nil, func)
	end

	local function normalHandler()
		PassportController.instance:sendGainPrizeReq(self._actInfo.actId, self._actInfo.funcId, data.taskIndex, false)
	end

	GameUtil.addClickHandler(btnNormalGet, normalHandler)
	GameUtil.SetActive(btnNormalGet, data.isCanGet)
end

function PassportScrollerView:_clearNormalCell(go)
	local mainGo = go
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
	UIEffectManager.instance:stopEffect(self._normalCellEffs[mainGo])
end

function PassportScrollerView:_updateSuperCell(go, data, dix)
	local mainGo = go
	local item = goutil.findChild(mainGo, "item")
	local imgGet = goutil.findChild(mainGo, "imgGet")
	local red = goutil.findChild(mainGo, "red")
	local btnSuperGet = goutil.findChild(mainGo, "btnSuperGet")

	if item then
		MaterialMgr.setCellByCfg(data.prizeStr, item)
	end

	GameUtil.SetActive(imgGet, data.isHasGet)

	if data.isEnoughProgress then
		GameUtil.SetActive(red, data.isEnoughProgress)

		if data.isEnoughProgress then
			UIEffectManager.instance:stopEffect(self._superCellEffs[mainGo])

			if data.isEnoughProgress then
				local effGo = item
				local path = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

				local function func(target, eff)
					eff:setScrollRectClipping(self._taskScrollerview:GetComponent(ComponentType.ScrollRect))
					eff:setParent(effGo.transform)
					eff:setLocalPos(0, 0, 0)
					eff:setScale(1, 1, 1)

					eff.hideEffWhileNotOnTop = true
				end

				self._superCellEffs[mainGo] = UIEffectManager.instance:playEffect(self, path, effGo, 0, 0, true, false, nil, func)
			end

			local function superHandler()
				if data.isCanGet then
					PassportController.instance:sendGainPrizeReq(self._actInfo.actId, self._actInfo.funcId, data.taskIndex, true)
				end
			end

			GameUtil.addClickHandler(btnSuperGet, superHandler)
			GameUtil.SetActive(btnSuperGet, data.isCanGet)
		end
	end
end

function PassportScrollerView:_clearSuperCell(go)
	local mainGo = go
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
	UIEffectManager.instance:stopEffect(self._superCellEffs[mainGo])
end

function PassportScrollerView:_setActivityTime()
	self._buySupTime = math.floor(self._actInfo.endTime / 1000) - ServerTime.nowServerLook()

	if self._actInfo.actCfg and not string.nilorempty(self._actInfo.actCfg.buyEndTime) then
		self._buySupTime = GameUtil.string2time(self._actInfo.actCfg.buyEndTime) - ServerTime.nowServerLook()
	end

	GameUtil.SetActive(self._btnInv, self._buySupTime > 0)
	removetimer(self._updateTimer, self)
	settimer(1, self._updateTimer, self, true)
	self:_updateTimer()
	GameUtil.SetActive(self._buyTimeGo, self._funcCfg.isShowTime)
	GameUtil.SetActive(self._timeTipsGo, self._funcCfg.isShowTime)
end

function PassportScrollerView:_updateTimer()
	if self._buySupTime >= 0 then
		self._buyTimeTxt.text = self:_getSurplusTimerShow(self._buySupTime)
		self._buySupTime = self._buySupTime - 1
	else
		self._buyTimeTxt.text = lang("已结束")

		GameUtil.SetActive(self._btnInv, false)
	end

	local leftTime = self._actInfo.endTime / 1000 - ServerTime.nowServerLook()

	if leftTime > 0 then
		self._timeTips.text = self:_getSurplusTimerShow(leftTime)
	else
		self._timeTips.text = lang("已结束")

		FloatWordMgr.instance:show(lang("text_equip_desc_1"))
		removetimer(self._updateTimer, self)
	end
end

function PassportScrollerView:_getSurplusTimerShow(time)
	if checknumber(time) <= 0 then
		return lang("已结束")
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(time)

	if day > 0 then
		return langPara("%d天", day)
	elseif day <= 0 and hour > 0 then
		return langPara("Fun_LotteryView_Tips_4", hour, min)
	elseif hour <= 0 and min > 0 then
		return langPara("Fun_LotteryView_Tips_5", min, sec)
	elseif min <= 0 and sec > 0 then
		return langPara("Fun_LotteryView_Tips_6", sec)
	end

	return lang("已结束")
end

function PassportScrollerView:_onClickInv()
	if checknumber(self._buySupTime) <= 0 then
		FloatWordMgr.instance:show("已过了可购买时间了噢")

		return
	end

	if self._actInfo.hasPay then
		FloatWordMgr.instance:show("你已投资了噢")

		return
	end

	PassportController.instance:_buyPassportWithDifferentPayType(self._actInfo.actId, false)
end

function PassportScrollerView:_onClickBtnInfo()
	local skinId = self._passportBaseData.skinId

	if skinId == 0 then
		return
	end

	UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_SHOP, skinId)
end

function PassportScrollerView:_onClickBtnSkill()
	local skinId = self._passportBaseData.skinId

	if skinId == 0 then
		return
	end

	local raceId = PetSkinConfig.instance:getPetSkinRaceId(skinId)

	if raceId == 0 then
		return
	end

	PetbookController.instance:previewBattle(raceId, skinId)
end

return PassportScrollerView
