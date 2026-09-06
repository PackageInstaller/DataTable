-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tarolottery/view/TarolotteryView.lua

module("logic.extensions.tarolottery.view.TarolotteryView", package.seeall)

local TarolotteryView = class("TarolotteryView", ViewComponent)
local bgEffPath = {
	[1] = "20230120/caiqinglinghaoli/fx_ui_caiqinglinghaoli.prefab",
	[2] = "20231222/shikongxiuer/fx_shikongxiuer_camera.prefab"
}

function TarolotteryView:ctor()
	TarolotteryView.super.ctor(self)
end

function TarolotteryView:unbindEvents()
	TarolotteryView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self.btnPreview)
	GameUtil.rmClickHandler(self._btnAnim)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnTenLottery)
end

function TarolotteryView:bindEvents()
	TarolotteryView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self.btnPreview, self._onClickPreview, self)
	GameUtil.addClickHandler(self._btnAnim, self._onClickAnim, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickLottery, self)
	GameUtil.addClickHandler(self._btnTenLottery, self._onClickTenLottery, self)
end

function TarolotteryView:buildUI()
	TarolotteryView.super.buildUI(self)

	self._costIcon = self:getImg("txtCost/icon")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtlotteryNum = self:getTxt("lotteryNum/txtNum")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnLottery = self:getBtn("btnLottery")
	self._btnTask = self:getBtn("btnTask")
	self.btnPreview = self:getBtn("btnPreview")
	self._btnAnim = self:getBtn("btnAnim")
	self._btnTenLottery = self:getBtn("btnTenLottery")
	self._roleView_role1 = self:getGo("roleView/role1")
	self._roleView_role2 = self:getGo("roleView/role2")
	self._rdTenLottery = self:getGo("btnLottery/redpoint")
	self._rdTask = self:getGo("btnTask/redpoint")
	self._animSelect = self:getGo("btnAnim/imgSelect")
	self._tenSelect = self:getGo("btnTenLottery/imgSelect")
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtCost = MaterialMgr.findGraphicText(self.mainGO, "txtCost")
	self._con = self:getGo("topEffect/con")
	self._progressBar = self:getSlider("lotteryList/tableview/Viewport/Content/progressBar")
	self._tableview = self:getGo("lotteryList/tableview")
	self._cell = self:getGo("lotteryList/cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	local scrollviewGo = self:getGo("scrollview")
	local cellGo = self:getGo("cell")

	self._cardScrollList = ScrollerList.create(scrollviewGo, cellGo, GameUtil.handler(self._updateCardCell, self), GameUtil.handler(self._clearCardCell, self))
end

function TarolotteryView:onExit()
	TarolotteryView.super.onExit(self)
	self._scrollList:dispose()
	self._cardScrollList:dispose()

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self:_clearAllSpine()
	RedPointController.instance:unregRedPoint(self._rdTask)
	UIEffectManager.instance:stopEffect(self._effectHandler)

	if self._tween then
		self._tween:RemoveListener()
	end

	UnityTweens.TweenBezier.StopTween(self._con)
end

function TarolotteryView:onEnter()
	TarolotteryView.super.onEnter(self)
	self:_initAnimPre()
	self:_setTimeUI()
	self:_playEffect()
	self:_lotteryCost()
	self:_animTenSelectState()
	self:_refreshView()
	self:addGEvent(GlobalNotify.TaroLotteryInfoUpdate, self._refreshView)
	TaroLotteryController.instance:sendGetInfo(self._activityId)
end

function TarolotteryView:_initAnimPre()
	self._tarotIds = nil
	self._activityId = 345001
	self._activityCfg = TaroLotteryConfig.instance:getActivityCfgById(self._activityId) or {}
	self._animationPreKey = self.__cname

	local cfg = EventTaskSummaryConfig.instance:getPlanCfg(self._activityId)

	RedPointController.instance:regRedPoint(self._rdTask, cfg.redPointId)
end

function TarolotteryView:_initView(msg)
	self._info = TaroLotteryModel.instance:getInfo(self._activityId) or {}
	self._tarotTimesMap = {}

	if not self._info.tarotTimes then
		local tarotTimes = {}

		for i, v in ipairs(tarotTimes) do
			self._tarotTimesMap[v.left] = v.right
		end

		local list = self:_sortPrizeCfg()

		self._scrollList:reloadData(list)

		self._txtlotteryNum.text = #tarotTimes

		local scoreList = {}

		for i, v in ipairs(list) do
			table.insert(scoreList, v.number)
		end

		if not self._info.tarotTimes then
			self._scrollList:updateUnderSlider(self._progressBar, #self._info.tarotTimes, scoreList)

			local list = TaroLotteryConfig.instance:getPrizeCfg(self._activityId) or {}

			self._cardScrollList:reloadData(list)

			local isRed = self:_canLottery(true)

			GameUtil.SetActive(self._rdTenLottery, isRed)
		end
	end
end

function TarolotteryView:_refreshView()
	self:_initView()

	local ids = TaroLotteryController.instance:tryPopupBigPrize()

	if ids and #ids > 0 then
		self._tarotIds = ids

		self:_showPopupPrize()
	end
end

function TarolotteryView:_onTweenEnd(view, cell, data)
	if self._tween then
		self._tween:RemoveListener()
	end

	UnityTweens.TweenBezier.StopTween(self._con)
	GameUtil.setAnchoredPos(self._con, 0, 0)
	UIEffectManager.instance:stopEffect(self._effectHandler)
	self:_showPopupPrize()
end

function TarolotteryView:_showPopupPrize()
	local isAdd = false
	local list = {}

	for i, tarotId in ipairs(self._tarotIds) do
		local cfg = TaroLotteryConfig.instance:getPrizeCfgById(self._activityId, tarotId)

		if cfg then
			local item = cfg.item
			local type, id, num = MaterialMgr.getMatParams(item)

			if type == MatType.Item_Fake then
				local mo = MaterialModel.instance:UpdateMaterial(MatType.Item_Fake, id, num)

				table.insert(list, mo)

				isAdd = true
			end
		end
	end

	if isAdd then
		local obj = {}

		obj.items = list
		obj.ci = 0

		MaterialController.instance:addInList(MaterialController.TYPE_ITEMSET, obj)
		MaterialController.instance:checkAndOpenDisplay()
	end
end

function TarolotteryView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effect = goutil.findChild(cell, "effect")
	local hasGet = false

	if not self._info.tarotTimes then
		local tarotTimes = {}
		local isCanGet = #tarotTimes >= data.number

		if not self._info.progressPrizeIds then
			local progressPrizeIds = {}

			hasGet = table.indexof(progressPrizeIds, data.prizeId) ~= false
			txtNum.text = data.number

			MaterialMgr.setCellByCfg(data.prize, item)
			GameUtil.SetActive(geted, hasGet)
			self:_clearCellEffect(effect)

			if isCanGet and not hasGet then
				self:_playCellEffect(effect)
			end

			GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
		end
	end
end

local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

function TarolotteryView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("lotteryList/tableview/Viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function TarolotteryView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function TarolotteryView:_onClickGetPrize(data)
	if not self._info.progressPrizeIds then
		local progressPrizeIds = {}
		local hasGet = table.indexof(progressPrizeIds, data.prizeId) ~= false

		if not hasGet then
			if not self._info.tarotTimes then
				local tarotTimes = {}
				local isCanGet = #tarotTimes >= data.number

				if isCanGet then
					TaroLotteryController.instance:sendGetPrize(self._activityId, data.prizeId)
				else
					TipsFacade.instance:openCommonTips("还没达到条件哦~")
				end
			end
		end
	end
end

function TarolotteryView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.resetAll(item)
	self:_clearCellEffect(effect)
end

function TarolotteryView:_updateCardCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local count = checknumber(self._tarotTimesMap[data.tarotId])

	GameUtil.SetActive(icon, count > 0)
	GameUtil.setUIImageSpriteIdx(icon, data.tarotId - 1)

	txtNum.text = ""

	if count > 0 then
		txtNum.text = "x" .. count
	end
end

function TarolotteryView:_clearCardCell(cell)
	local icon = goutil.findChild(cell, "icon")
end

function TarolotteryView:_sortPrizeCfg()
	return (TaroLotteryConfig.instance:getProgressCfg(self._activityId))
end

function TarolotteryView:_setTimeUI()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function TarolotteryView:_playEffect()
	local effPath = bgEffPath[2]

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setScale(1)
	self._pmEff:setLocalPos(0, 0, 0)
end

function TarolotteryView:_lotteryCost()
	local costStr = self._activityCfg.cost
	local content = "消耗："
	local objList = {}
	local arr = string.split(costStr, "#")

	for i, cfgStr in ipairs(arr) do
		local obj = {
			showAdd = false,
			id = cfgStr
		}

		table.insert(objList, obj)

		local matType, matId, num = MaterialMgr.getMatParams(cfgStr)

		content = content .. MaterialMgr.getContentMatStr(cfgStr, 26, -5, MaterialMgr.ICON_TYPE_ICON) .. "x" .. num

		if i ~= #arr then
			content = content .. "、"
		end
	end

	self._txtCost.text = content

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function TarolotteryView:_animTenSelectState()
	local isPass = GameUtil.getUserDayData(self._animationPreKey .. "PassAnim")
	local isTen = GameUtil.getUserData(self._animationPreKey .. "Ten")

	GameUtil.SetActive(self._animSelect, isPass)
	GameUtil.SetActive(self._tenSelect, isTen)
end

function TarolotteryView:_loadSpine(mainGo, spinePath, pos)
	if self._spineCtrlPool == nil then
		self._spineCtrlPool = {}
	end

	if not self._spineCtrlPool[mainGo] then
		local ctrl = CaiqingdrawSpineCtrl.New()

		self._spineCtrlPool[mainGo] = ctrl

		ctrl:onInit(mainGo, self._view, spinePath)

		pos = pos or {}

		if not pos[3] then
			local x, y, scale = checknumber(pos[1]), checknumber(pos[2]), 1

			if not pos[4] then
				local scaleX = scale

				GameUtil.setLocalPos(mainGo, x, y)
				GameUtil.setLocalScale(mainGo, scaleX, scale, scale)
			end
		end
	end
end

function TarolotteryView:_clearSpine(mainGo)
	if self._spineCtrlPool then
		local ctrl = self._spineCtrlPool[mainGo]

		if ctrl then
			ctrl:onClear()
		end
	end
end

function TarolotteryView:_clearAllSpine()
	if self._spineCtrlPool then
		for mainGo, ctrl in pairs(self._spineCtrlPool) do
			self:_clearSpine(mainGo)
		end
	end
end

function TarolotteryView:_onClickTip()
	TipsFacade.instance:openRulesView("tarolotteryview_rule")
end

function TarolotteryView:_onClickTask()
	GotoMgr.gotoByString(self._activityCfg.jumpTo)
end

function TarolotteryView:_onClickPreview()
	return
end

function TarolotteryView:_onClickAnim()
	if not GameUtil.getUserDayData(self._animationPreKey .. "FristAnim") then
		FloatWordMgr.instance:show("首次动画不可跳过哦~")
	else
		local isPass = GameUtil.getUserDayData(self._animationPreKey .. "PassAnim")

		GameUtil.saveUserDayData(self._animationPreKey .. "PassAnim", not isPass)
		GameUtil.SetActive(self._animSelect, not isPass)
	end
end

function TarolotteryView:_onClickTenLottery()
	local isTen = GameUtil.getUserData(self._animationPreKey .. "Ten")

	GameUtil.saveUserData(self._animationPreKey .. "Ten", not isTen)
	GameUtil.SetActive(self._tenSelect, not isTen)
end

function TarolotteryView:_onClickLottery()
	local isTen = GameUtil.getUserData(self._animationPreKey .. "Ten")
	local isCanLottery, curState = self:_canLottery(isTen)

	if not isCanLottery then
		FloatWordMgr.instance:show("请去获得足够的抽奖道具后再来抽吧~")

		return
	end

	local isPass = GameUtil.getUserDayData(self._animationPreKey .. "PassAnim")

	if not isPass then
		local animPath = self:_getDrawAnimPath()

		local function onAnimPlashFinish()
			ViewBlockMgr.instance:blockClick(false, self._animationPreKey)
			self:_sendDrawMsg()
		end

		local function onAnimPlashStart()
			ViewBlockMgr.instance:blockClick(true, self._animationPreKey)
		end

		AnimationPlayer.play(animPath, onAnimPlashFinish, onAnimPlashStart, self)
	else
		self:_sendDrawMsg()
	end
end

function TarolotteryView:_getDrawAnimPath()
	return "storyconfig/animations/story_taluopai.txt"
end

function TarolotteryView:_sendDrawMsg()
	if not GameUtil.getUserDayData(self._animationPreKey .. "FristAnim") then
		GameUtil.saveUserDayData(self._animationPreKey .. "FristAnim", true)
	end

	local isTen = checkbool(GameUtil.getUserData(self._animationPreKey .. "Ten"))

	TaroLotteryController.instance:sendGetDraw(self._activityId, isTen and 10 or 1)
end

function TarolotteryView:_canLottery(isTen)
	local costStr = self._activityCfg.cost
	local arr = string.split(costStr, "#")

	for i, cfgStr in ipairs(arr) do
		local matType, matId, matNum = MaterialMgr.getMatParams(cfgStr)
		local haveNum = MaterialModel.instance:getMaterialsNumber(matType, matId) or 0

		if isTen then
			if not (matNum * 10) then
				local needCostNum = matNum

				if haveNum < needCostNum then
					return false
				end
			end
		end
	end

	return true
end

return TarolotteryView
