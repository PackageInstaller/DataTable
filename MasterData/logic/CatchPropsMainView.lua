-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/catchprops/view/CatchPropsMainView.lua

module("logic.extensions.catchprops.view.CatchPropsMainView", package.seeall)

local CatchPropsMainView = class("CatchPropsMainView", ViewComponent)
local unlockZonePos = {
	0,
	-113,
	-224,
	-335,
	-447
}

function CatchPropsMainView:buildUI()
	CatchPropsMainView.super.buildUI(self)

	self._bgImage = self:getGo("bg")
	self._btnTips = self:getBtn("btnTips")
	self._txtTitle = self:getTxt("txtTitle")
	self._btnClose = self:getBtn("btnClose")
	self._txtItemNum = self:getTxt("txtItemNum")
	self._thrower = self:getGo("thrower")
	self._catcher = self:getGo("catcher")
	self._screenEffNode = self:getGo("screenEff")
	self._itemsNode = self:getGo("itemsNode")
	self._awardsView = self:getGo("itemsNode/awardsView"):GetComponent(ComponentType.ScrollRect)
	self._awardsViewContent = self:getGo("itemsNode/awardsView/Viewport/Content").transform
	self._awardsVPSize = self:getGo("itemsNode/awardsView/Viewport").transform.rect.width

	local itemNode = self:getGo("itemsNode/awardsView/Viewport/Content/ItemNode")

	self._itemNodeLayout = itemNode:GetComponent(ComponentType.UILayoutSingleLine)
	self._btnStartGame = self:getBtn("btnStartGame")
	self._btnBuyTimes = self:getBtn("btnBuyTimes")
	self._txtPlayTimes = self:getTxt("txtPlayTimes")
	self._propIcon = self:getGo("txtItemNum/icon")
	self._btnPreviewRewards = self:getBtn("itemsNode/btnPreviewRewards")
	self._effStartGame = self:getGo("effStartGame")

	self:_initUnlockZone()

	local txtRefreshTime = self:getTxt("txtRefreshTime")
	local txtHasNum = self:getTxt("txtItemNum/txtHasNum")
	local txtItems = self:getTxt("itemsNode/btnPreviewRewards/txtItems")
	local txtStartGame = self:getTxt("btnStartGame/Text")

	txtHasNum.text = lang("text_curr_hasnum")
	txtItems.text = lang("catch_props_timely_rewards")
	txtStartGame.text = lang("text_startgame")
	txtRefreshTime.text = lang("text_refresh_all_hours")
end

function CatchPropsMainView:_initUnlockZone()
	self._unlockImage = self:getGo("unlockImage")
	self._prizeCol = self:getGo("prizeCol")

	local prizeScrollerview = self:getGo("prizeCol/prizeScrollerview")
	local prizeScrollercell = self:getGo("prizeCol/prizeScrollercell")

	self._itemScrollercell = self:getGo("prizeCol/itemScrollercell")
	self._prizeScrollList = ScrollerList.create(prizeScrollerview, prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._itemScrollListDic = {}
end

function CatchPropsMainView:bindEvents()
	CatchPropsMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTips:AddClickListener(self._onClickTips, self)
	self._btnBuyTimes:AddClickListener(self._onClickBuyTimes, self)
	self._btnStartGame:AddClickListener(self._onClickStartGame, self)
	self._btnPreviewRewards:AddClickListener(self._onClickPreviewRewards, self)
end

function CatchPropsMainView:unbindEvents()
	CatchPropsMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTips:RemoveClickListener()
	self._btnBuyTimes:RemoveClickListener()
	self._btnStartGame:RemoveClickListener()
	self._btnPreviewRewards:RemoveClickListener()
end

function CatchPropsMainView:onEnter()
	CatchPropsMainView.super.onEnter(self)
	CatchPropsController.instance:requestActivityInfo()
	self:_refreshUnockZone()
	self:_refreshViewData()
	self:_refreshGameNameAndRules()
	self:_playScreenEff()
	self:_playStartGameEff()
	self:_createSpineObjects()
	self:_updateAwards()
	GlobalDispatcher:addListener(GlobalNotify.OnCatchPropsDailyReset, self._onCatchPropsDailyReset, self)
	GlobalDispatcher:addListener(GlobalNotify.OnCatchPropsBuyGameTimes, self._onCatchPropsBuyGameTimes, self)
	GlobalDispatcher:addListener(GlobalNotify.OnCatchPropsInfo, self._onCatchPropsInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.OnCatchPropsUnlockZone, self._onCatchPropsUnlockZone, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._onMatChange, self)
end

function CatchPropsMainView:_refreshGameNameAndRules()
	local activityId = CatchPropsModel.instance:getActivityId()
	local activityCo = CatchPropsConfig.instance:getActivityCo(activityId)

	self._txtTitle.text = activityCo.gameName
	self._tipsRuleKey = activityCo.rulesKey

	local tx, ty, tz = Framework.TransformUtil.GetLocalPos(self._txtTitle.transform, nil, nil, nil)
	local width = self._txtTitle.preferredWidth
	local tipX = tx + width - 70

	Framework.TransformUtil.SetLocalPos(self._btnTips.transform, tipX, ty, tz)
end

function CatchPropsMainView:_refreshViewData()
	local props = CatchPropsModel.instance:getPropType()
	local maxBuyTimes = CatchPropsConfig.instance:getDailyBuyTimes()

	if not string.nilorempty(props) then
		local mats = string.split(props, ":")
		local matType = checknumber(mats[1])
		local matId = checknumber(mats[2])

		self._txtItemNum.text = tostring(MaterialModel.instance:getMaterialsNumber(matType, matId))

		MaterialMgr.setIcon(self._propIcon, matType, matId)
	else
		self._txtItemNum.text = "0"
	end

	self._txtPlayTimes.text = string.format(lang("text_remain_times"), CatchPropsModel.instance:getRemainPlayTimes())

	goutil.setActive(self._btnBuyTimes.gameObject, maxBuyTimes > 0)
end

function CatchPropsMainView:_playScreenEff()
	if self._screenEff then
		return
	end

	local effPath = CatchPropsModel.instance:getEffPath()

	self._screenEff = UIEffectManager.instance:playEffectBrief(self, effPath, self._screenEffNode, true)

	self._screenEff:setParent(self._screenEffNode.transform)
	self._screenEff:setLocalPos(0, 0, 0)
	self._screenEff:setScale(1)
end

function CatchPropsMainView:_stopScreenEff()
	if not self._screenEff then
		return
	end

	UIEffectManager.instance:stopEffect(self._screenEff)

	self._screenEff = nil
end

function CatchPropsMainView:_playStartGameEff()
	if self._startGameEff then
		return
	end

	local effPath = CatchPropsModel.instance:getStartGameEffPath()

	self._startGameEff = UIEffectManager.instance:playEffectBrief(self, effPath, self._effStartGame, true)

	self._startGameEff:setParent(self._effStartGame.transform)
	self._startGameEff:setLocalPos(0, 0, 0)
	self._startGameEff:setScale(1)
end

function CatchPropsMainView:_stopStartGameEff()
	if not self._startGameEff then
		return
	end

	UIEffectManager.instance:stopEffect(self._startGameEff)

	self._startGameEff = nil
end

function CatchPropsMainView:_playUnlockEffect(go)
	self:_stopUnlockEffect()

	local effPath = CatchPropsModel.instance:getUnlockZoneEffPath()

	self._unlockZoneEff = UIEffectManager.instance:playEffectBrief(self, effPath, go, false)

	self._unlockZoneEff:setParent(go.transform)
	self._unlockZoneEff:setLocalPos(0, 0, 0)
	self._unlockZoneEff:setScale(1)
end

function CatchPropsMainView:_stopUnlockEffect()
	if not self._unlockZoneEff then
		return
	end

	UIEffectManager.instance:stopEffect(self._unlockZoneEff)

	self._unlockZoneEff = nil
end

function CatchPropsMainView:_createSpineObjects()
	local resThrower = rescache:GetResourceNoLoadIfNotExists(CatchPropsModel.instance:getThrowerImage())
	local resCatcher = rescache:GetResourceNoLoadIfNotExists(CatchPropsModel.instance:getCatcherImage())

	self._goThrower = self:_instantiateRes(resThrower)
	self._goCatcher = self:_instantiateRes(resCatcher)

	self:_setPrefabParent(self._goThrower, self._thrower.transform)
	self:_setPrefabParent(self._goCatcher, self._catcher.transform)
end

function CatchPropsMainView:_destroySpineObjects()
	if self._goThrower then
		goutil.destroy(self._goThrower)

		self._goThrower = nil
	end

	if self._goCatcher then
		goutil.destroy(self._goCatcher)

		self._goCatcher = nil
	end
end

function CatchPropsMainView:_instantiateRes(res)
	if not res then
		return
	end

	local mainAsset = res:GetMainAsset()

	if not mainAsset then
		return
	end

	return goutil.clone(mainAsset)
end

function CatchPropsMainView:_setPrefabParent(prefab, parent)
	if not prefab then
		return
	end

	prefab.transform:SetParent(parent)
	Framework.TransformUtil.SetLocalPos(prefab.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(prefab.transform, 1, 1, 1)
end

function CatchPropsMainView:onExit()
	self:_stopScreenEff()
	self:_stopStartGameEff()
	self:_stopUnlockEffect()
	self:_destroySpineObjects()
	GlobalDispatcher:removeListener(GlobalNotify.OnCatchPropsDailyReset, self._onCatchPropsDailyReset, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnCatchPropsBuyGameTimes, self._onCatchPropsBuyGameTimes, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._onMatChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnCatchPropsUnlockZone, self._onCatchPropsUnlockZone, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnCatchPropsInfo, self._onCatchPropsInfo, self)
	CatchPropsMainView.super.onExit(self)
end

function CatchPropsMainView:onExitFinished()
	self._tipsRuleKey = nil

	MaterialMgr.clearIcon(self._propIcon)

	local nodeCnt = self._itemNodeLayout.transform.childCount

	for i = 1, nodeCnt do
		local go = self._itemNodeLayout.transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)
	end

	self._prizeScrollList:dispose()
	uGuiUtil.clearImage(self._unlockImage)
	uGuiUtil.clearImage(self._bgImage)
	CatchPropsMainView.super.onExitFinished(self)
end

function CatchPropsMainView:_updateAwards()
	if not CatchPropsModel.instance:isActivityDataReady() then
		self._itemsNode:SetActive(false)

		return
	end

	local prize = CatchPropsModel.instance:getPrize()

	if not prize then
		self._itemsNode:SetActive(false)

		return
	end

	self._itemsNode:SetActive(true)

	local awards = string.split(prize, "#")
	local childCount = self._itemNodeLayout.transform.childCount
	local itemNum = #awards

	while childCount < itemNum do
		local go = goutil.create("prize" .. childCount + 1)

		go.transform:SetParent(self._itemNodeLayout.transform)
		Framework.TransformUtil.SetLocalPos(go.transform, childCount * 115, 0, 0)
		Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)

		childCount = childCount + 1
	end

	for i = 1, itemNum do
		local data = awards[i]
		local go = self._itemNodeLayout.transform:GetChild(i - 1).gameObject

		go:SetActive(true)
		MaterialMgr.resetAll(go)

		local proxy = MaterialMgr.setCellByCfg(data, go)

		proxy.binder:setNum(0)
	end

	for i = itemNum + 1, childCount do
		local go = self._itemNodeLayout.transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	self._itemNodeLayout:Layout()

	local contentSize = itemNum * 115
	local sizeDelta = self._awardsViewContent.sizeDelta

	sizeDelta.x = contentSize
	self._awardsViewContent.sizeDelta = sizeDelta
	self._awardsView.enabled = contentSize > self._awardsVPSize

	local posX, posY, posZ = Framework.TransformUtil.GetLocalPos(self._itemNodeLayout.transform, nil, nil, nil)

	if contentSize > self._awardsVPSize then
		Framework.TransformUtil.SetLocalPos(self._itemNodeLayout.transform, (contentSize - self._awardsVPSize) * 0.5, posY, posZ)
	else
		Framework.TransformUtil.SetLocalPos(self._itemNodeLayout.transform, 0, posY, posZ)
	end
end

function CatchPropsMainView:_onClickClose()
	self:close()
end

function CatchPropsMainView:_onClickTips()
	UIStateManager.instance:open(ViewName.RulesView, self._tipsRuleKey)
end

function CatchPropsMainView:_onClickBuyTimes()
	if not CatchPropsModel.instance:isActivityDataReady() then
		FloatWordMgr.instance:show(lang("text_requesting_svr_data"))

		return
	end

	local maxBuyTimes = CatchPropsConfig.instance:getDailyBuyTimes()
	local currBuyTimes = CatchPropsModel.instance:getBuyGameTimes()

	if maxBuyTimes <= currBuyTimes then
		FloatWordMgr.instance:show(lang("text_buytimes_max_tips"))

		return
	end

	local cost = CatchPropsConfig.instance:getBuyTimesCost()
	local mats = string.split(cost, ":")
	local matType = checknumber(mats[1])
	local matId = checknumber(mats[2])
	local matNum = checknumber(mats[3])
	local matName = MaterialMgr.getMaterialsName(matType, matId)

	TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("text_buytimes_tips"), matNum, matName, maxBuyTimes, maxBuyTimes - currBuyTimes), function()
		if matNum > MaterialModel.instance:getMaterialsNumber(matType, matId) then
			FloatWordMgr.instance:show(string.format(lang("text_buytimes_item_noenough"), matName))

			return
		end

		MoYanPreheatAgent.instance:sendPM_MoYanPreheatBuyTimesReq(CatchPropsModel.instance:getActivityId())
	end, function()
		return
	end, lang("confirm"), lang("mail_cancel"))
end

function CatchPropsMainView:_onClickStartGame()
	local remainTimes = CatchPropsModel.instance:getRemainPlayTimes()

	if remainTimes <= 0 then
		local maxBuyTimes = CatchPropsConfig.instance:getDailyBuyTimes()
		local currBuyTimes = CatchPropsModel.instance:getBuyGameTimes()

		if maxBuyTimes <= currBuyTimes then
			FloatWordMgr.instance:show(lang("catch_props_gametimes_over"))

			return
		end

		self:_onClickBuyTimes()

		return
	end

	CatchPropsController.instance:startCatchPropsGame()
end

function CatchPropsMainView:_onClickPreviewRewards()
	ViewMgr.instance:open(ViewName.CatchPropRewardsPreview)
end

function CatchPropsMainView:_refreshUnockZone()
	local unlockFragments = CatchPropsModel.instance:getUnlockFragments()

	self._prizeScrollList:reloadData(unlockFragments or {})
end

function CatchPropsMainView:_fillUnlockFragment(data, go, cellHeight, i)
	Framework.TransformUtil.SetLocalPos(go.transform, 0, unlockZonePos[i], 0)
	UnityTweens.UITweenFadeOut.StopTween(go)

	local canvasGroup = go:GetComponent(ComponentType.CanvasGroup)
	local btnUnlock = Framework.ButtonAdapter.GetFrom(go, "btnUnlock")
	local unlockBg = goutil.findChild(go, "btnUnlock/unlockBg")
	local unlockTips = goutil.findChildTextComponent(go, "btnUnlock/unlockTips")
	local costTips = goutil.findChildTextComponent(go, "btnUnlock/costTips")
	local spriteChange = unlockBg:GetComponent(ComponentType.UIImageSpriteChange)
	local itemIcon = goutil.findChild(go, "btnUnlock/itemIcon")

	spriteChange:SetState(i - 1)

	canvasGroup.alpha = 1

	local mats = string.split(data.unlockProps, ":")
	local matType = checknumber(mats[1])
	local matId = checknumber(mats[2])
	local matNum = checknumber(mats[3])

	unlockTips.text = string.format(lang("catch_props_unlockcost"), matNum)
	costTips.text = lang("text_cost_tips")

	MaterialMgr.setIcon(itemIcon, matType, matId)
	btnUnlock:RemoveClickListener()
	btnUnlock:AddClickListener(function()
		if data.isUnlock then
			return
		end

		if not CatchPropsModel.instance:isActivityDataReady() then
			FloatWordMgr.instance:show(lang("text_requesting_svr_data"))

			return
		end

		local matName = MaterialModel.instance:getMaterialsName(matType, matId)

		TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("catch_props_unlocktips"), matNum, matName), function()
			local hasNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

			if hasNum < matNum then
				FloatWordMgr.instance:show(string.format(lang("catch_props_unlockcost_noenough"), matName, matNum))

				return
			end

			CatchPropsController.instance:sendPM_MoYanPreheatUnlockReq(CatchPropsModel.instance:getActivityId(), data.id)
		end, function()
			return
		end, lang("confirm"), lang("mail_cancel"))
	end)

	if data.isNewUnLock then
		data.isNewUnLock = false

		UnityTweens.UITweenFadeOut.StartTween(go, 0.5)
	end
end

function CatchPropsMainView:_updatePrizeCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")
	local itemIcon = goutil.findChild(mainGo, "costTips/itemIcon")
	local unlockTips = goutil.findChildTextComponent(mainGo, "unlockTips")
	local txtCostTips = goutil.findChildTextComponent(mainGo, "costTips/txt")

	if not string.nilorempty(data.unlockProps) then
		local matType, matId, matNum = MaterialMgr.getMatParams(data.unlockProps)

		MaterialMgr.setIcon(itemIcon, matType, matId)

		txtCostTips.text = string.format("x%s", matNum)
	end

	if itemScrollerview and self._itemScrollercell then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = itemScrollList

			local dataList = {}

			for _, prizeStr in ipairs(prizeStrArr) do
				local t = {
					prizeStr = prizeStr,
					isUnlock = data.isUnlock
				}

				table.insert(dataList, t)
			end

			itemScrollList:reloadData(dataList)
			itemScrollList:dragNotifyParent()
		end
	end

	if data.id == self._curZoneId then
		self._curZoneId = 0

		self:_playUnlockEffect(mainGo)
	end

	local function handler()
		if data.isUnlock then
			return
		end

		if not CatchPropsModel.instance:isActivityDataReady() then
			FloatWordMgr.instance:show(lang("text_requesting_svr_data"))

			return
		end

		local matType, matId, matNum = 0, 0, 0

		if not string.nilorempty(data.unlockProps) then
			matType, matId, matNum = MaterialMgr.getMatParams(data.unlockProps)
		end

		local matName = MaterialModel.instance:getMaterialsName(matType, matId)

		TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("catch_props_unlocktips"), matNum, matName), function()
			local hasNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

			if hasNum < matNum then
				FloatWordMgr.instance:show(string.format(lang("catch_props_unlockcost_noenough"), matName, matNum))

				return
			end

			CatchPropsController.instance:sendPM_MoYanPreheatUnlockReq(CatchPropsModel.instance:getActivityId(), data.id)
		end, function()
			return
		end, lang("confirm"), lang("mail_cancel"))
	end

	GameUtil.addClickHandler(mainGo, handler)
end

function CatchPropsMainView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local itemIcon = goutil.findChild(mainGo, "costTips/itemIcon")

	MaterialMgr.clearIcon(itemIcon)
	GameUtil.rmClickHandler(mainGo)

	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function CatchPropsMainView:_updateItemCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local receive = goutil.findChild(mainGo, "receive")

	MaterialMgr.setCellByCfg(data.prizeStr, item, urlOrGo, luaCls, isOne)
	GameUtil.SetActive(receive, data.isUnlock)
end

function CatchPropsMainView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function CatchPropsMainView:_onCatchPropsInfo()
	self:_refreshViewData()
	self:_refreshUnockZone()
	self:_refreshGameNameAndRules()
	self:_updateAwards()
end

function CatchPropsMainView:_onCatchPropsUnlockZone(zoneId)
	self._curZoneId = zoneId

	self:_refreshUnockZone()
end

function CatchPropsMainView:_onMatChange()
	self:_refreshViewData()
end

function CatchPropsMainView:_onCatchPropsBuyGameTimes()
	self:_refreshViewData()
end

function CatchPropsMainView:_onCatchPropsDailyReset()
	self:_onCatchPropsInfo()
end

return CatchPropsMainView
