-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liyangking/view/LiYangKingMainView.lua

module("logic.extensions.liyangking.view.LiYangKingMainView", package.seeall)

local LiYangKingMainView = class("LiYangKingMainView", ViewComponent)
local shengji_eff_scale_list = {
	1.2,
	1.5,
	2,
	2,
	2
}

function LiYangKingMainView:ctor()
	LiYangKingMainView.super.ctor(self)
end

function LiYangKingMainView:unbindEvents()
	LiYangKingMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSaveBottle)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnReward)
	GameUtil.rmClickHandler(self._btnFight)
	GameUtil.rmClickHandler(self._goldBar)
end

function LiYangKingMainView:bindEvents()
	LiYangKingMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._goldBar, self._onClickBtnGoldBar, self)
	GameUtil.addClickHandler(self._bottle, self._onClickBtnSaveBottle, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnReward, self._onClickBtnReward, self)
	GameUtil.addClickHandler(self._btnFight, self._onClickBtnFight, self)
end

function LiYangKingMainView:buildUI()
	LiYangKingMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnFight = self:getGo("fight/btnFight")
	self._fightBubble = self:getGo("fight/bubble")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._maomao = self:getGo("saveBottle/bottle/maomao")
	self._fenWeiEffRoot = self:getGo("fenWeiEffRoot")
	self._houses = self:getGo("houses")
	self._house = self:getGo("house")
	self._txtSaveBottleDesc = self:getTxt("saveBottle/bubble/txtDesc")
	self._txtNumSaveBottle = self:getTxt("saveBottle/money/txtNum")
	self._imgSaveBottle = self:getGo("saveBottle/money/img")
	self._bottle = self:getGo("saveBottle/bottle")
	self._btnShop = self:getGo("btnShop")
	self._btnRank = self:getGo("btnRank")
	self._btnReward = self:getGo("btnReward")
	self._redPointReward = self:getGo("btnReward/redPoint")
	self._txtShopDesc = self:getTxt("btnShop/bubble/txtDesc")
	self._txtRankDesc = self:getTxt("btnRank/bubble/txtDesc")
	self._kingLevelGo = self:getGo("attr/attrs/kingAttr/level")
	self._txtLevelKingAttr = self:getTxt("attr/attrs/kingAttr/level/txtLevel")
	self._txtProgressKingAttr = self:getTxt("attr/attrs/kingAttr/txtProgress")
	self._txtMaxKingAttr = self:getTxt("attr/attrs/kingAttr/txtMax")
	self._sliderKingAttr = self:getGo("attr/attrs/kingAttr/slider"):GetComponent("Slider")
	self._goldBarItem = self:getGo("goldBar/item")
	self._goldBar = self:getGo("goldBar")
	self._txtNumGoldBar = self:getTxt("goldBar/txtNum")
	self._attrGoList = {}

	for i = 1, 3 do
		local attr = self:getGo("attr/attrs/attr" .. i)

		table.insert(self._attrGoList, attr)
	end
end

function LiYangKingMainView:onExit()
	LiYangKingMainView.super.onExit(self)
	MaterialMgr.clearIcon(self._imgSaveBottle)
	MaterialMgr.clearIcon(self._goldBarItem)
	self:stopViewEffectUniGo(self._fenWeiEffRoot)
	self:_clearHouse()
	self:_unloadSpine()
	self:_onDestorySpine()
	removetimer(self._tickTime, self)
	RedPointController.instance:unregRedPoint(self._redPointReward)
	LiYangKingModel.instance:clearLevelUpEffBuildId()

	for k, eff in pairs(self._levelUpEffMap) do
		self:stopViewEffectUniGo(eff)

		self._levelUpEffMap[k] = nil
	end
end

function LiYangKingMainView:onEnter()
	LiYangKingMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_PrinceLiyangInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_PrinceLiyangClgInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_PrinceLiyangGainHangingRes, self._onGainHangingRes, self)
	self.addGEvent(self, GlobalNotify.PM_NotifyPrinceLiyangChangeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_PrinceLiyangUnlockBuildingRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_PrinceLiyangUpgradeBuildingRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_PrinceLiyangHandleEventRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.OnViewClose, self._onOnViewClose, self)
	self.addGEvent(self, GlobalNotify.OnViewOpen, self._onOnViewOpen, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 509001
	end

	self._actCfg = LiYangKingConfig.instance:getActCfg(self._activityId)
	self._buildCfgs = LiYangKingConfig.instance:getBuildingCfgs(self._activityId)
	self._kingLevelCfgs = LiYangKingConfig.instance:getLevelCfgs(self._activityId)
	self._attrCfgs = LiYangKingConfig.instance:getAttributeCfgs(self._activityId)
	self._attrLevelCfgs = LiYangKingConfig.instance:getAttributeLevelCfgs(self._activityId)
	self._matMo = MaterialMo.New()
	self._canSendGainHaningRequest = true
	self._buildGoList = {}
	self._levelUpEffMap = {}

	self:_onSetUI()
	settimer(1, self._tickTime, self)
	LiYangKingController.instance:sendPM_PrinceLiyangInfoReq(self._activityId)
	LiYangKingController.instance:sendPM_PrinceLiyangClgInfoReq(self._activityId)

	local storyId = self._actCfg.storyId

	if checknumber(storyId) > 0 then
		local key = string.format("LiYangKingMainView%s", self._activityId)

		local function firstCallback()
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end

		GameUtil.doCallbackWhenFirst(key, firstCallback)
	end

	self:_loadSpine()
	RedPointController.instance:regRedPoint(self._redPointReward, 725)
end

local fenwei_eff_path = "20250822/liyangguojun/fx_ui_fenwei_liyangguojun.prefab"

function LiYangKingMainView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	self:_initHouses()
	MaterialMgr.setIcon(self._imgSaveBottle, MatType.ACTIVITY_ITEM, self._actCfg.itemId)
	MaterialMgr.setIcon(self._goldBarItem, MatType.ACTIVITY_ITEM, self._actCfg.itemId)
	self:playViewEffectUniGo(fenwei_eff_path, self._fenWeiEffRoot, self.mainGO, true, nil)
end

function LiYangKingMainView:_onUpdate()
	self._info = LiYangKingModel.instance:getInfo(self._activityId)
	self._buildingsMap = self._info.buildingsMap
	self._hangingInfo = self._info.hanging
	self._lastUpdateTimeStamp = checknumber(self._hangingInfo.lastSettleTimeMillis)
	self._attributesMap = self._info.attributesMap

	local nextCreateEventTimeMillis = checknumber(self._info.nextCreateEventTimeMillis)

	self:_updateHouse()
	self:_updateAttr()

	local kingLevel = LiYangKingController.instance:getCurKingLevel(self._activityId)
	local curKingLevelCfg = LiYangKingConfig.instance:getLevelCfgByLevel(self._activityId, kingLevel)
	local hasScoreNum = checknumber(self._info.curScore)

	self:_updateMoneyUI()

	if self._info.report then
		UIStateManager.instance:push(ViewName.LiYangKingBenefitResultView, self._activityId, self._info.report)
	end
end

function LiYangKingMainView:_updateMoneyUI()
	local totalEfficiency = LiYangKingController.instance:getTotalEfficiency(self._activityId)
	local radio = LiYangKingController.instance:getMoneyTotalRatio(self._activityId)

	totalEfficiency = totalEfficiency * (1 + radio)

	local totalHaningReward = self:_getAllCanGetHaningReward()

	self._txtSaveBottleDesc.text = string.format("当前财务状况是每%d秒产出%d离阳币蒸蒸日上喵!", self._actCfg.cycle, totalEfficiency)
	self._txtNumSaveBottle.text = totalHaningReward
	self._txtNumGoldBar.text = self._info.curScore
end

function LiYangKingMainView:_initHouses()
	GameUtil.SetActive(self._house, true)

	for idx, buildCfg in ipairs(self._buildCfgs) do
		local house = goutil.cloneAndSetParent(self._house, self._houses.transform, "house" .. idx)
		local posAndScale = buildCfg.posAndScale

		GameUtil.setLocalPos(house, posAndScale[1], posAndScale[2], posAndScale[3])
		table.insert(self._buildGoList, house)
	end

	GameUtil.SetActive(self._house, false)
end

function LiYangKingMainView:_updateHouse()
	local isEnough = LiYangKingController.instance:hasEnoughStrenthToReset(self._activityId)

	GameUtil.SetActive(self._fightBubble, isEnough)

	for idx, buildCfg in ipairs(self._buildCfgs) do
		local house = self._buildGoList[idx]
		local btnBubble = goutil.findChild(house, "btnBubble")
		local img = goutil.findChild(house, "img")
		local houseChangeComp = img:GetComponent(ComponentType.UIImageSpriteChange)
		local typeImgChangeComp = goutil.findChild(house, "img/type/img"):GetComponent(ComponentType.UIImageSpriteChange)
		local txtHouse = goutil.findChildTextComponent(house, "name/txtHouse")
		local eff = goutil.findChildTextComponent(house, "eff")
		local buildInfo = self._buildingsMap[buildCfg.buildingId]
		local buildLevel = 1

		if buildInfo then
			buildLevel = buildInfo.level
		end

		local curBuildCfg = LiYangKingConfig.instance:getBuildingLevelCfgBybuildIdlevel(self._activityId, buildCfg.buildingId, buildLevel)

		if buildInfo ~= nil then
			if not curBuildCfg.name then
				local name = "未解锁"
				local hasEvent = LiYangKingController.instance:hasEvent(self._activityId, buildCfg.buildingId)

				txtHouse.text = name

				typeImgChangeComp:SetState(buildCfg.typeIdx)
				GameUtil.SetGray(img, buildInfo == nil)
				GameUtil.addClickHandler(btnBubble, GameUtil.handler(self._onClickBtnBubble, self, buildInfo))
				GameUtil.addClickHandler(img, GameUtil.handler(self._onClickBtnHouse, self, buildInfo, buildCfg, img))
				GameUtil.SetActive(btnBubble, hasEvent)

				if buildCfg.typeIdx ~= 0 then
					houseChangeComp:SetState(buildLevel)
					img:GetComponent(goutil.Type_UIImage):SetNativeSize()

					local posAndScale = buildCfg.posAndScale

					GameUtil.setLocalScale(img, posAndScale[4], posAndScale[4], posAndScale[4])
				else
					houseChangeComp:SetState(0)
				end
			end
		end
	end
end

function LiYangKingMainView:_clearHouse()
	for _, go in ipairs(self._buildGoList) do
		local btnBubble = goutil.findChild(go, "btnBubble")
		local img = goutil.findChild(go, "img")

		GameUtil.rmClickHandler(btnBubble)
		GameUtil.rmClickHandler(img)
		goutil.destroy(go)
	end

	self._buildGoList = nil
end

function LiYangKingMainView:_updateAttr()
	local kingLevel = LiYangKingController.instance:getCurKingLevel(self._activityId)
	local maxKingLevel = #self._kingLevelCfgs

	self._txtProgressKingAttr.text = string.format("等级:%d/%d", kingLevel, maxKingLevel)
	self._txtLevelKingAttr.text = string.format("国君等级:<color=#74FFABFF>%d</color>", kingLevel)
	self._sliderKingAttr.value = kingLevel / maxKingLevel

	GameUtil.SetActive(self._txtMaxKingAttr.gameObject, kingLevel == maxKingLevel)
	GameUtil.SetActive(self._txtProgressKingAttr.gameObject, kingLevel < maxKingLevel)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._kingLevelGo.transform)

	for idx, attrGo in ipairs(self._attrGoList) do
		local level = goutil.findChild(attrGo, "level")
		local imgHead = goutil.findChild(attrGo, "imgHead")
		local txtMaxGo = goutil.findChild(attrGo, "txtMax")
		local slider = goutil.findChild(attrGo, "slider"):GetComponent("Slider")
		local txtLevel = goutil.findChildTextComponent(attrGo, "level/txtLevel")
		local txtProgress = goutil.findChildTextComponent(attrGo, "txtProgress")
		local attrInfo = self._attributesMap[idx]
		local curProgress = 0

		if attrInfo then
			curProgress = attrInfo.progress
		end

		local curHasProgress, needProgress = LiYangKingController.instance:getCurAttrLevelProgressAndNeed(self._activityId, idx, curProgress)
		local isMaxLevel = curHasProgress == -1 and needProgress == -1
		local curLevel = LiYangKingController.instance:getCurLevel(self._activityId, idx, curProgress)
		local curAttrCfg = self._attrCfgs[idx]
		local attrName = curAttrCfg.attrName

		slider.value = curHasProgress / needProgress

		if curHasProgress == -1 and needProgress == -1 then
			txtProgress.text = "已满级"
		else
			curHasProgress = MmUtil.formatNumber(curHasProgress, MmUtil.Units_OnlyW)
			needProgress = MmUtil.formatNumber(needProgress, MmUtil.Units_OnlyW)
			txtProgress.text = string.format("%s/%s", curHasProgress, needProgress)
		end

		txtLevel.text = string.format("%s等级:<color=#74FFABFF>%d</color>", attrName, curLevel)

		GameUtil.SetActive(txtProgress.gameObject, not isMaxLevel)
		GameUtil.SetActive(txtMaxGo, isMaxLevel)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(level.transform)
	end
end

function LiYangKingMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function LiYangKingMainView:_onClickBtnBubble(buildInfo)
	UIStateManager.instance:push(ViewName.LiYangKingEventView, self._activityId, buildInfo.buildingId)
end

function LiYangKingMainView:_onClickBtnHouse(buildInfo, buildCfg, imgGo)
	local buildId = buildCfg.buildingId

	if buildInfo then
		UIStateManager.instance:push(ViewName.LiYangKingLevelUpView, self._activityId, buildId)
	else
		local curBuildCfg = LiYangKingConfig.instance:getBuildingCfgByBuildingId(self._activityId, buildId)
		local curBuildLevelCfg = LiYangKingConfig.instance:getBuildingLevelCfgBybuildIdlevel(self._activityId, buildId, 1)
		local firstBuildCost = curBuildCfg.cost
		local param = {}

		param.activityId = self._activityId
		param.firstBuildCost = firstBuildCost
		param.matName = MaterialMgr.getMaterialsName(MatType.ACTIVITY_ITEM, self._actCfg.itemId)
		param.buildName = curBuildLevelCfg.name
		param.hasScoreNum = checknumber(self._info.curScore)
		param.buildId = buildId

		UIStateManager.instance:push(ViewName.LiYangKingCostView, param)
	end

	local posAndScale = buildCfg.posAndScale

	GameUtil.setLocalScale(imgGo, posAndScale[4], posAndScale[4], posAndScale[4])
end

function LiYangKingMainView:_onClickBtnSaveBottle()
	if self._isPlayingAnim or not self._canSendGainHaningRequest then
		return
	end

	local totalHaningReward = self:_getAllCanGetHaningReward()

	if totalHaningReward > 0 then
		self:_playJinBiAnim()
	else
		FloatWordMgr.instance:show("当前没有财务收入噢，等会儿再来吧")
	end
end

function LiYangKingMainView:_onClickBtnShop()
	local btnStr = self._actCfg.shopGotoStr

	GotoMgr.gotoByString(btnStr)
end

function LiYangKingMainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.LiYangKingRankView, self._activityId)
end

function LiYangKingMainView:_onClickBtnReward()
	UIStateManager.instance:push(ViewName.LiYangKingRewardView, self._activityId)
end

function LiYangKingMainView:_onClickBtnFight()
	UIStateManager.instance:push(ViewName.LiYangKingChapter3View, self._activityId)
end

function LiYangKingMainView:_tickTime()
	local nextCreateEventTimeMillis = checknumber(self._info.nextCreateEventTimeMillis)
	local lastUpdateTime = math.floor(self._lastUpdateTimeStamp / 1000)

	if nextCreateEventTimeMillis <= ServerTime.nowMs() and nextCreateEventTimeMillis ~= -1 then
		LiYangKingController.instance:sendPM_PrinceLiyangInfoReq(self._activityId)
	end

	self._txtNumSaveBottle.text = self:_getAllCanGetHaningReward()
end

function LiYangKingMainView:_getAllCanGetHaningReward()
	local curTime = ServerTime.now()
	local lastUpdateTime = math.floor(self._lastUpdateTimeStamp / 1000) + 1
	local cycle = self._actCfg.cycle
	local extAccumulate = checknumber(self._hangingInfo.extAccumulate)
	local totalEfficiency = LiYangKingController.instance:getTotalEfficiency(self._activityId)
	local totalHaningReward = 0

	if cycle <= curTime - lastUpdateTime then
		local ratio = LiYangKingController.instance:getMoneyTotalRatio(self._activityId)
		local hasHaningMinute = math.floor((curTime - lastUpdateTime) / cycle)

		totalHaningReward = hasHaningMinute * totalEfficiency * (1 + ratio) + extAccumulate
	else
		totalHaningReward = extAccumulate
	end

	return totalHaningReward
end

function LiYangKingMainView:_onClickBtnGoldBar()
	CommonTipsMgr.instance:openMaterialTips(self._goldBar1, MatType.ACTIVITY_ITEM, self._actCfg.itemId)
end

function LiYangKingMainView:_onGainHangingRes(status)
	self._isPlayingAnim = false
	self._canSendGainHaningRequest = true

	if status <= 0 then
		return
	end

	local list = {}
	local preCanGetMoney = LiYangKingModel.instance:getSaveBottleMoneyMap()

	self._matMo:initData(MatType.ACTIVITY_ITEM, self._actCfg.itemId, preCanGetMoney)
	table.insert(list, self._matMo)

	local obj = {}

	obj.items = list
	obj.ci = 0

	MaterialController.instance:addInList(MaterialController.TYPE_ITEMSET, obj)
	MaterialController.instance:checkAndOpenDisplay()
end

function LiYangKingMainView:_loadSpine()
	local spineRoot = self._maomao
	local view = self
	local spinePath = "character/20020_maomao/20020_maomao-ui_p.prefab"

	self._spineCtrl = LiYangKingMaoMaoSpineCtrl.New()

	self._spineCtrl:onInit(spineRoot, view, spinePath)
end

function LiYangKingMainView:_unloadSpine()
	self._spineCtrl:onClear()
end

function LiYangKingMainView:_onDestorySpine()
	self._spineCtrl:onDestory()

	self._spineCtrl = nil
end

function LiYangKingMainView:_playJinBiAnim()
	self._isPlayingAnim = true
	self._canSendGainHaningRequest = false

	if self._spineCtrl then
		self._spineCtrl:_playAnim("jinbi", false, function(animName)
			self._spineCtrl:playDefaultAnim()

			local totalHaningReward = self:_getAllCanGetHaningReward()

			LiYangKingModel.instance:setSaveBottleMoneyMap(totalHaningReward)
			LiYangKingController.instance:sendPM_PrinceLiyangGainHangingReq(self._activityId)
		end)
	end
end

local shengji_eff_path = "20250822/liyangguojun/fx_ui_shengji_liyangguojun.prefab"

function LiYangKingMainView:_onOnViewClose()
	local playEffBuildId = LiYangKingModel.instance:getLevelUpEffBuildId()

	if playEffBuildId then
		local curBuildGo = self._buildGoList[playEffBuildId]

		if curBuildGo then
			local eff = goutil.findChild(curBuildGo, "img/eff")
			local buildInfo = self._buildingsMap[playEffBuildId]
			local scale = shengji_eff_scale_list[(buildInfo or nil) and buildInfo.level]

			GameUtil.setLocalScale(eff, scale, scale, scale)

			self._levelUpEffMap[curBuildGo] = self:playViewEffectUniGo(shengji_eff_path, eff, self.mainGO, false, GameUtil.handler(self._clearEff, self, curBuildGo))
		end
	end
end

function LiYangKingMainView:_onOnViewOpen()
	local playEffBuildId = LiYangKingModel.instance:getLevelUpEffBuildId()

	if playEffBuildId then
		local curBuildGo = self._buildGoList[playEffBuildId]

		self:_clearEff(curBuildGo)
	end
end

function LiYangKingMainView:_clearEff(curBuildGo)
	local eff = goutil.findChild(curBuildGo, "img/eff")

	if eff then
		self:stopViewEffectUniGo(eff)
	end

	self._levelUpEffMap[curBuildGo] = nil

	LiYangKingModel.instance:clearLevelUpEffBuildId()
end

return LiYangKingMainView
