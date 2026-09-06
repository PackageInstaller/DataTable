-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idlegame/view/IdleGameView.lua

module("logic.extensions.idlegame.view.IdleGameView", package.seeall)

local IdleGameView = class("IdleGameView", ViewComponent)

function IdleGameView:ctor()
	IdleGameView.super.ctor(self)
end

function IdleGameView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
	self._btnOneKey:AddClickListener(self._onOneKeyCP, self)
	self._btnWarehouse:AddClickListener(self._onClickWarehouse, self)
	self._btnPrize:AddClickListener(self._onClickPrize, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function IdleGameView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnOneKey:RemoveClickListener()
	self._btnWarehouse:RemoveClickListener()
	self._btnPrize:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function IdleGameView:buildUI()
	self._closeButton = self:getBtn("lefttop/title/btnClose")
	self._btnTip = self:getBtn("lefttop/title/btnTip")
	self._txtPrizeAllReceived = goutil.findChildComponent(self.mainGO, "lefttop/prize/txtPrizeAllReceived", "Text")
	self._txtPrizeProgress = goutil.findChildComponent(self.mainGO, "lefttop/prize/txtPrizeProgress", "Text")
	self._btnPrize = self:getBtn("lefttop/prize/btnPrize")
	self._prizeRedPoint = goutil.findChild(self._btnPrize, "redpoint")
	self._txtCurMoney = goutil.findChildComponent(self.mainGO, "righttop/btnTotalMoney/txtTotalMoney", "Text")
	self._txtSpeed = goutil.findChildComponent(self.mainGO, "righttop/btnSpeed/txtSpeed", "Text")
	self._txtCapacity = goutil.findChildComponent(self.mainGO, "righttop/btnCapacity/txtCapacity", "Text")
	self._btnWarehouse = self:getBtn("leftbom/btnWarehouse")
	self._btnBuy = self:getBtn("rightbom/btnBuy")
	self._btnOneKey = self:getBtn("rightbom/btnOneKey")
	self._txtBuyPrice = goutil.findChildComponent(self._btnBuy.gameObject, "txtPrice", "Text")
	self._btnExchange = self:getBtn("leftbom/btnExchange")
	self._btnRank = self:getBtn("leftbom/btnRank")
	self._container = self:getGo("container")
	self._cloneNuo = goutil.findChild(self._container, "nuo")

	goutil.setActive(self._cloneNuo, false)

	self._nuos = {}

	for i = 0, IdleGameModel.instance:getCapacity() - 1 do
		local go = goutil.cloneAndSetParent(self._cloneNuo, self._container.transform, tostring(i))

		self._nuos[i] = ItemNuo.New(go)
	end

	self._tipsContainer = self:getGo("tipsContainer")
	self._cloneTips = goutil.findChild(self._tipsContainer, "tipcell")

	goutil.setActive(self._cloneTips, false)

	self._tips = {}
	self._guideTips = self:getGo("guideTips")

	goutil.setActive(self._guideTips, false)

	self._txtGuideTips = goutil.findChildComponent(self.mainGO, "guideTips/txtTips", "Text")
	self._txtGuideTips.text = "1，使用萌值可<color=#ffa428>购买小诺。</color>\n2，长按可拖动小诺，将<color=#ffa428>2只相同</color>的小诺<color=#ffa428>放在一起</color>，可<color=#ffa428>合成</color>更高等级的小诺。"
end

function IdleGameView:destroyUI()
	return
end

function IdleGameView:onEnter()
	IdleGameController.instance:registerLocalNotify("AddNewNuo", self._onAddNewNuo, self)
	IdleGameController.instance:registerLocalNotify("DragNuoEnd", self._checkCanCompose, self)
	IdleGameController.instance:registerLocalNotify("ComposeNuo", self._onComposeNuo, self)
	IdleGameController.instance:registerLocalNotify("DiscardNuo", self._onDiscardNuo, self)
	IdleGameController.instance:registerLocalNotify("onAddMoney", self._playAddMoney, self)
	IdleGameController.instance:registerLocalNotify("ReceiveProgressPrize", self._onReceiveProgressPrize, self)
	IdleGameController.instance:registerLocalNotify("refreshMoneyInfo", self._updateUI, self)
	XiaoNuoPlaceAgent.instance:sendPM_XiaoNuoPlaceInfoReq(function(msg)
		IdleGameModel.instance:handlePM_XiaoNuoPlaceInfoRes(msg)
		self:_refreshView()
	end)
end

function IdleGameView:onEnterFinished()
	return
end

function IdleGameView:onExit()
	IdleGameController.instance:unregisterLocalNotify("AddNewNuo", self._onAddNewNuo, self)
	IdleGameController.instance:unregisterLocalNotify("DragNuoEnd", self._checkCanCompose, self)
	IdleGameController.instance:unregisterLocalNotify("ComposeNuo", self._onComposeNuo, self)
	IdleGameController.instance:unregisterLocalNotify("DiscardNuo", self._onDiscardNuo, self)
	IdleGameController.instance:unregisterLocalNotify("onAddMoney", self._playAddMoney, self)
	IdleGameController.instance:unregisterLocalNotify("ReceiveProgressPrize", self._onReceiveProgressPrize, self)
	IdleGameController.instance:unregisterLocalNotify("refreshMoneyInfo", self._updateUI, self)
	removetimer(self._onTick, self)

	for _, v in pairs(self._nuos) do
		v:setActive(false)
	end

	IdleGameController.instance.doingOnekey = false
	self._isReqing = false
end

function IdleGameView:onExitFinished()
	return
end

function IdleGameView:_updateUI()
	self:_updatePrizeProgress()

	self._txtCurMoney.text = StringUtil.numberToString(IdleGameModel.instance:getCurMoney())
	self._txtCapacity.text = string.format("%d/%d", IdleGameModel.instance:getMemberCount(), IdleGameModel.instance:getCapacity())
	self._txtSpeed.text = StringUtil.numberToString(IdleGameModel.instance:getMoneyAddPerSec())
	self._txtBuyPrice.text = StringUtil.numberToString(IdleGameModel.instance:getMaxBuyPrice())

	self:_updateRedPoints()
end

function IdleGameView:_refreshView()
	goutil.setActive(self._guideTips, false)
	self:_updateUI()
	self:_createNuos()
	settimer(0, self._onTick, self, true)
	self:_updateRedPoints()
end

function IdleGameView:_updatePrizeProgress()
	local nextNeedMoney = IdleGameModel.instance:getNextProgressNeedMoney()

	goutil.setActive(self._txtPrizeProgress.gameObject, nextNeedMoney > 0)
	goutil.setActive(self._txtPrizeAllReceived.gameObject, nextNeedMoney <= 0)

	self._txtPrizeProgress.text = StringUtil.numberToString(nextNeedMoney - IdleGameModel.instance:getTotalMoney())
end

function IdleGameView:_createNuos()
	local t = IdleGameModel.instance:getMembers()

	for _, v in ipairs(t) do
		self:_updateNuo(v)
	end
end

function IdleGameView:_onClickBuy()
	IdleGameController.instance:buyNuo(IdleGameModel.instance:getMaxBuyLevel())
end

function IdleGameView:_onOneKeyCP()
	if not self:_checkHasSame() then
		FloatWordMgr.instance:show("当前没有2只可以合成的小诺")
	else
		IdleGameController.instance:oneKeyCp(function(msg)
			self:_onOneKeySuccess(msg)
		end)
	end
end

function IdleGameView:_onOneKeySuccess(msg)
	local preMaxLv = IdleGameModel.instance:getMaxNuoLevel()
	local t = IdleGameModel.instance:getMembers()
	local nuosMap = {}

	for _, v in ipairs(t) do
		nuosMap[v.position] = v
	end

	IdleGameModel.instance:handlePM_XiaoNuoOneKeyComposeRes(msg)

	t = IdleGameModel.instance:getMembers()

	local curMaxLv = IdleGameModel.instance:getMaxNuoLevel()
	local newNuosMap = {}

	for _, v in ipairs(t) do
		if v.level > 0 then
			newNuosMap[v.position] = v
		end
	end

	for _, v in pairs(nuosMap) do
		local newNuo = newNuosMap[v.position]

		if newNuo == nil then
			self:_updateNuo({
				level = 0,
				position = v.position
			})
		elseif newNuo.level > v.level then
			self:_updateNuo(newNuo, true, true)
		end
	end

	if preMaxLv < curMaxLv then
		UIStateManager.instance:open(ViewName.UnlockNewNuo, preMaxLv + 1, curMaxLv - preMaxLv - 1)
	end

	self:_updateUI()

	self._isReqing = false
end

function IdleGameView:_localOneKeyCompose(oldMembers, preMaxLv)
	return
end

function IdleGameView:_checkHasSame()
	local t = IdleGameModel.instance:getMembers()

	table.sort(t, function(a, b)
		return a.level < b.level
	end)

	for i = 2, #t do
		if t[i].level == t[i - 1].level and t[i].level >= 1 and t[i].level < 20 then
			return true
		end
	end

	return false
end

function IdleGameView:_onAddNewNuo(member)
	goutil.setActive(self._guideTips, false)
	self:_updateUI()
	self:_updateNuo(member, true)
	self:_sortNuos()
end

function IdleGameView:_checkCanCompose(source, x, y)
	self:_sortNuos()

	local minDistance = 99999
	local targetPos = -1

	for pos, v in pairs(self._nuos) do
		if v:getIsActive() and source.position ~= pos and v._mo.level == source.level and v:isIntersect(x, y) and minDistance > v:getCenterDistance(x, y) then
			minDistance = v:getCenterDistance(x, y)
			targetPos = pos
		end
	end

	if targetPos >= 0 then
		IdleGameController.instance:sendCompose(source.position, targetPos)
	end
end

function IdleGameView:_sortNuos()
	local t = {}

	for _, nuo in pairs(self._nuos) do
		local go = nuo.mainGO

		if go and go.activeSelf then
			table.insert(t, go)
		end
	end

	table.sort(t, function(a, b)
		local x1, y1, z1 = Framework.TransformUtil.GetLocalPos(a.transform, 0, 0, 0)
		local x2, y2, z2 = Framework.TransformUtil.GetLocalPos(b.transform, 0, 0, 0)

		return y2 < y1
	end)

	for i, go in ipairs(t) do
		go.transform:SetSiblingIndex(i)
	end
end

function IdleGameView:_onComposeNuo(oldMember, newMember)
	goutil.setActive(self._guideTips, false)
	self:_updateUI()
	self:_updateNuo(oldMember)
	self:_updateNuo(newMember, true, true)
	self:_sortNuos()
end

function IdleGameView:_onDiscardNuo(discardNuo)
	self:_updateUI()
	print("discardNuo = " .. discardNuo.level)
	self:_updateNuo(discardNuo)
end

function IdleGameView:_onClickClose()
	XiaoNuoPlaceAgent.instance:sendPM_XiaoNuoCloseReq()
	UIStateManager.instance:pop()
end

function IdleGameView:_updateNuo(data, isNew, isKeepPos)
	local nuo = self._nuos[data.position]

	nuo:onSetMo(data)
	nuo:setActive(checknumber(data.level) > 0)

	if isNew then
		local effect = UIEffectManager.instance:playEffect(self, "fx_ui_mofangmianban/fx_ui_xiaonuo_bianshen.prefab", nuo.mainGO, false)

		effect.hideEffWhileNotOnTop = false

		nuo:playPopupAnim()
	end

	if not isKeepPos then
		nuo:setRandomPos(self:getRandomPos())
	end

	if checknumber(data.level) > 0 and IdleGameModel.instance:getIsNeedGuide() and not self._guideTips.activeSelf then
		nuo:setRandomPos(0, 0, 0)
		goutil.setActive(self._guideTips, true)
		goutil.addChildToParent(self._guideTips, nuo.mainGO.transform)
		nuo.mainGO.transform:SetSiblingIndex(99)
		Framework.TransformUtil.SetLocalPos(self._guideTips.transform, -51, 102, 0)
	end
end

function IdleGameView:getRandomPos()
	local quadMap = {
		0,
		0,
		0,
		0
	}

	for _, nuo in pairs(self._nuos) do
		if nuo:getIsActive() then
			local x, y = Framework.TransformUtil.GetLocalPos(nuo.mainGO.transform, x, y, 0)

			if x > 0 and y > 0 then
				quadMap[1] = checknumber(quadMap[1]) + 1
			elseif x > 0 and y < 0 then
				quadMap[2] = checknumber(quadMap[2]) + 1
			elseif x < 0 and y < 0 then
				quadMap[3] = checknumber(quadMap[3]) + 1
			elseif x < 0 and y > 0 then
				quadMap[4] = checknumber(quadMap[4]) + 1
			end
		end
	end

	local min = 1

	for i = 2, 4 do
		if quadMap[i] < quadMap[min] then
			min = i
		end
	end

	local ratio = UnityEngine.Screen.height / 720
	local screenWidth = UnityEngine.Screen.width / ratio
	local sizeX, sizeY = screenWidth / 2 - 250, 210
	local xMin, yMin

	xMin = min <= 2 and 0 or -sizeX
	yMin = (min == 2 or min == 3) and -sizeY or 0

	return math.random(xMin, xMin + sizeX), math.random(yMin, yMin + sizeY), 0
end

function IdleGameView:_onTick()
	local deltaTime = UnityEngine.Time.deltaTime

	for _, v in pairs(self._nuos) do
		v:onTick(deltaTime)
	end

	if not IdleGameModel.instance:getIsGameOpen() then
		self:_onClickClose()
	end
end

function IdleGameView:_playAddMoney(addNum, x, y, z)
	local go

	for _, v in ipairs(self._tips) do
		if not v.activeSelf then
			go = v

			break
		end
	end

	if go == nil then
		go = goutil.cloneAndSetParent(self._cloneTips, self._tipsContainer.transform)

		table.insert(self._tips, go)
	end

	local txtAddNum = goutil.findChildComponent(go, "txtAddNum", "Text")
	local icon = goutil.findChildComponent(txtAddNum.gameObject, "icon", "Image")

	txtAddNum.text = string.format("+%s", StringUtil.numberToString(addNum))

	Framework.TransformUtil.SetPos(go.transform, x, y, z)

	local localX, localY, localZ = Framework.TransformUtil.GetLocalPos(go.transform, 0, 0, 0)

	goutil.setActive(go, true)
	settimer(1, function()
		goutil.setActive(go, false)
	end, nil, false)
	TweenUtil.ValueTo(0, 1, 0.5, function(val)
		Game.ImageUtil.SetImageAlpha(icon, val)
		Game.TextUtil.SetColorRGBA(txtAddNum, 1, 1, 1, val)
		Framework.TransformUtil.SetLocalPos(go.transform, localX, localY - (1 - val) * 100, localZ)
	end, nil, self)
	self:_updateUI()
end

function IdleGameView:_updateRedPoints()
	goutil.setActive(self._prizeRedPoint, IdleGameModel.instance:getHasPrizeNotReceive())
end

function IdleGameView:_onClickWarehouse()
	UIStateManager.instance:open(ViewName.IdleWarehouse)
end

function IdleGameView:_onClickPrize()
	UIStateManager.instance:open(ViewName.IdlePrize)
end

function IdleGameView:_onClickRank()
	UIStateManager.instance:push(ViewName.XiaonuoRankview)
end

function IdleGameView:_onReceiveProgressPrize()
	self:_updateRedPoints()
end

function IdleGameView:_onClickTip()
	UIStateManager.instance:open(ViewName.PanelGuide, GameEnum.PanelGuideType.XiaoNuoBian)
end

return IdleGameView
