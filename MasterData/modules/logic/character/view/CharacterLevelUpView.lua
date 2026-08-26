-- chunkname: @modules/logic/character/view/CharacterLevelUpView.lua

module("modules.logic.character.view.CharacterLevelUpView", package.seeall)

local CharacterLevelUpView = class("CharacterLevelUpView", BaseView)
local COST_ITEM_COUNT = 2
local CLICK_LEVEL_TWEEN_TIME = 0.3
local SELECT_NEAR_LEVEL_TWEEN_TIME = 0.5
local LEVEL_UP_EFF_TIME = 0.05
local NEXT_FRAME_TIME = 0.01

function CharacterLevelUpView:onInitView()
	self._animGO = gohelper.findChild(self.viewGO, "anim")
	self._anim = self._animGO and self._animGO:GetComponent(typeof(UnityEngine.Animator))
	self._waveAnimation = self.viewGO:GetComponent(typeof(UnityEngine.Animation))
	self._lvCtrl = self.viewGO:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	self._goprevieweff = gohelper.findChild(self.viewGO, "anim/lv/#lvimge_ffect")
	self._previewlvCtrl = self._goprevieweff:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	self._golv = gohelper.findChild(self.viewGO, "anim/lv/#go_Lv")
	self._scrolllv = gohelper.findChildScrollRect(self.viewGO, "anim/lv/#go_Lv/#scroll_Num")
	self._scrollrectlv = self._scrolllv:GetComponent(typeof(UnityEngine.UI.ScrollRect))

	local golvcontent = gohelper.findChild(self.viewGO, "anim/lv/#go_Lv/#scroll_Num/Viewport/Content")

	self._translvcontent = golvcontent.transform
	self._gomax = gohelper.findChild(self.viewGO, "anim/lv/#go_Lv/Max")
	self._btnmax = gohelper.findChildButtonWithAudio(self.viewGO, "anim/lv/#go_Lv/Max")
	self._txtmax = gohelper.findChildText(self.viewGO, "anim/lv/#go_Lv/Max/#txt_Num")
	self._gomaxlarrow = gohelper.findChild(self.viewGO, "anim/lv/#go_Lv/Max/image_lArrow")
	self._gomaxrarrow = gohelper.findChild(self.viewGO, "anim/lv/#go_Lv/Max/image_rArrow")
	self._scrolldrag = SLFramework.UGUI.UIDragListener.Get(self._scrolllv.gameObject)
	self._golvfull = gohelper.findChild(self.viewGO, "anim/lv/#go_LvFull")
	self._txtfulllvnum = gohelper.findChildText(self.viewGO, "anim/lv/#go_LvFull/#txt_LvNum")
	self._gotips = gohelper.findChild(self.viewGO, "anim/#go_tips")
	self._gorighttop = gohelper.findChild(self.viewGO, "anim/#go_righttop")
	self._btninsight = gohelper.findChildButtonWithAudio(self.viewGO, "anim/#btn_insight")
	self._goupgrade = gohelper.findChild(self.viewGO, "anim/#go_upgrade")
	self._goupgradetexten = gohelper.findChild(self.viewGO, "anim/#go_upgrade/txten")
	self._btnuplevel = SLFramework.UGUI.UIClickListener.Get(self._goupgrade)
	self._btnuplevellongpress = SLFramework.UGUI.UILongPressListener.Get(self._goupgrade)
	self._golevelupbeffect = gohelper.findChild(self.viewGO, "anim/#go_levelupbeffect")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gocharacterbg = gohelper.findChild(self.viewGO, "anim/bg/#go_characterbg")
	self._goherogroupbg = gohelper.findChild(self.viewGO, "anim/bg/#go_herogroupbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterLevelUpView:addEvents()
	self._scrolldrag:AddDragBeginListener(self._onLevelScrollDragBegin, self)
	self._scrolldrag:AddDragEndListener(self._onLevelScrollDragEnd, self)
	self._scrolllv:AddOnValueChanged(self._onLevelScrollChange, self)
	self._btnmax:AddClickListener(self._onMaxLevelClick, self)

	local timeMatrix = {}

	timeMatrix[1] = 0.5

	for i = 2, 100 do
		local time = 0.9 * timeMatrix[i - 1]
		local value = math.max(time, 0.2)

		table.insert(timeMatrix, value)
	end

	self._btnuplevellongpress:SetLongPressTime(timeMatrix)
	self._btnuplevellongpress:AddLongPressListener(self._onUpLevelLongPress, self)
	self._btnuplevel:AddClickListener(self._onUpLevelClick, self)
	self._btnuplevel:AddClickUpListener(self._onClickUp, self)
	self._btninsight:AddClickListener(self._btninsightOnClick, self)
	self._btnclose:AddClickListener(self.closeThis, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onItemChanged, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, self._onClickHeroEditItem, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.levelUpClickLevel, self._onClickLevel, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.levelUpViewClick, self._localLevelUpConfirmSend, self)
end

function CharacterLevelUpView:removeEvents()
	self._scrolldrag:RemoveDragBeginListener()
	self._scrolldrag:RemoveDragEndListener()
	self._scrolllv:RemoveOnValueChanged()
	self._btnmax:RemoveClickListener()
	self._btnuplevellongpress:RemoveLongPressListener()
	self._btnuplevel:RemoveClickListener()
	self._btnuplevel:RemoveClickUpListener()
	self._btninsight:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onItemChanged, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, self._onClickHeroEditItem, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.levelUpClickLevel, self._onClickLevel, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.levelUpViewClick, self._localLevelUpConfirmSend, self)
end

function CharacterLevelUpView:_onLevelScrollDragBegin()
	self:killTween()

	self._isDrag = true
end

function CharacterLevelUpView:_onLevelScrollDragEnd()
	self._isDrag = false

	if self._scrollrectlv then
		local isStop = self:checkScrollMove(true)

		if isStop then
			self:_selectToNearLevel(true)
		end
	end
end

function CharacterLevelUpView:_onLevelScrollChange(value)
	self:dispatchLevelScrollChange()

	if not self._isDrag and not self._tweenId then
		local isSlow = self:checkScrollMove()

		if isSlow or value <= 0 or value >= 1 then
			self:_selectToNearLevel(true)
		end
	end

	local tmpLevel = self:calScrollLevel()

	if self.previewLevel and self.previewLevel == tmpLevel then
		return
	end

	self.previewLevel = tmpLevel

	local curLevel = self:getHeroLevel()
	local isCurLevel = self.previewLevel == curLevel

	gohelper.setActive(self._goupgrade, not isCurLevel)
	gohelper.setActive(self._tips[3], isCurLevel)
	self:_refreshConsume(self.previewLevel)
	self:_refreshMaxBtnStatus(self.previewLevel)
	self:_refreshPreviewLevelHorizontal(self.previewLevel)

	if not self._skipScrollAudio then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_role_upgrade_lv_item_scroll)
	end

	self._skipScrollAudio = nil

	CharacterController.instance:dispatchEvent(CharacterEvent.levelUpChangePreviewLevel, self.previewLevel)
end

function CharacterLevelUpView:checkScrollMove(checkStop)
	local result = false

	if self._scrollrectlv then
		local curVelocity = math.abs(self._scrollrectlv.velocity.x or 0)

		if checkStop then
			local stopVelocity = 10

			if self._scrollrectlv then
				if not self._scrollrectlv.horizontalNormalizedPosition then
					local horNormalizedPosition = 0

					result = curVelocity <= stopVelocity or horNormalizedPosition <= 0.01 or horNormalizedPosition >= 0.99
				end
			end
		else
			local slowlyVelocity = 50

			result = curVelocity <= slowlyVelocity
		end

		return result
	end
end

function CharacterLevelUpView:_selectToNearLevel(isTween)
	self:killTween()
	self._scrollrectlv:StopMovement()

	self._targetLevel = self:calScrollLevel()

	self:dispatchLevelScrollChange()

	local scrollPos = self:calScrollPos(self._targetLevel)

	if isTween then
		local isNeedTween = true
		local startPos = self._scrolllv.horizontalNormalizedPosition

		if self._heroMO then
			local curLevel = self:getHeroLevel()
			local curRankMaxLv = CharacterModel.instance:getrankEffects(self._heroMO.heroId, self._heroMO.rank)[1]
			local totalDiffLevel = curRankMaxLv - curLevel
			local deltaPos = 1 / totalDiffLevel
			local diff = math.abs(scrollPos - startPos)

			isNeedTween = diff > deltaPos / 100
		end

		if isNeedTween then
			self._tweenId = ZProj.TweenHelper.DOTweenFloat(startPos, scrollPos, SELECT_NEAR_LEVEL_TWEEN_TIME, self.tweenFrame, self.tweenFinish, self)
		end
	else
		self._scrolllv.horizontalNormalizedPosition = scrollPos
	end
end

function CharacterLevelUpView:_onMaxLevelClick()
	self:_onClickLevel(self._maxCanUpLevel)
end

function CharacterLevelUpView:_onUpLevelLongPress()
	local curLevel = self:getHeroLevel()
	local isOneLevel = self._targetLevel - curLevel == 1

	if isOneLevel then
		self.longPress = true

		self:_onUpLevelClick()
	end
end

function CharacterLevelUpView:_onClickUp()
	if not self._heroMO or not self.longPress then
		return
	end

	self.longPress = false

	self:_localLevelUpConfirmSend()
end

function CharacterLevelUpView:_onUpLevelClick()
	local isBlock = UIBlockMgr.instance:isBlock()
	local isStop = self:checkScrollMove(true)

	if isBlock or not self._heroMO or self._isDrag or self._tweenId or not isStop then
		return
	end

	local curLevel = self:getHeroLevel()
	local isUpLevel = curLevel < self._targetLevel
	local isReachLevelLimit = CharacterModel.instance:isHeroLevelReachCeil(self._heroMO.heroId, curLevel)

	if isUpLevel and not isReachLevelLimit then
		self:_localLevelUp(self._targetLevel)

		if GuideController.instance:isGuiding() and GuideModel.instance:getDoingGuideId() == CharacterEnum.LevelUpGuideId then
			self:_localLevelUpConfirmSend()
		end
	else
		self._btnuplevellongpress:RemoveLongPressListener()
		self._btnuplevel:RemoveClickListener()
		self._btnuplevel:RemoveClickUpListener()
		self:_refreshView()

		if not self.longPress then
			AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		end
	end
end

function CharacterLevelUpView:_localLevelUp(argsNewLevel)
	if not self._heroMO then
		return
	end

	local heroId = self._heroMO.heroId
	local realHeroLevel = self:getHeroLevel(true)
	local curLevel = self:getHeroLevel()
	local newLevel = argsNewLevel or curLevel + 1
	local curRankMaxLv = CharacterModel.instance:getrankEffects(heroId, self._heroMO.rank)[1]
	local isBreakMax = curRankMaxLv < newLevel

	if isBreakMax or newLevel <= curLevel then
		return
	end

	local items = HeroConfig.instance:getLevelUpItems(heroId, realHeroLevel, newLevel)

	if items then
		local notEnoughItemName, enough, icon = ItemModel.instance:hasEnoughItems(items)

		if not enough then
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, icon, notEnoughItemName)
			self:_localLevelUpConfirmSend()

			return
		end
	end

	self._lastHeroLevel = curLevel

	self:playLevelUpEff(newLevel)
	self.viewContainer:setLocalUpLevel(newLevel)
	TaskDispatcher.cancelTask(self._delayRefreshView, self)
	TaskDispatcher.runDelay(self._delayRefreshView, self, LEVEL_UP_EFF_TIME)
	CharacterController.instance:dispatchEvent(CharacterEvent.levelUplocalItem, items)

	local isReachLevelLimit = CharacterModel.instance:isHeroLevelReachCeil(heroId, newLevel)

	if isReachLevelLimit then
		self._btnuplevellongpress:RemoveLongPressListener()
		self._btnuplevel:RemoveClickListener()
		self._btnuplevel:RemoveClickUpListener()
		self:_localLevelUpConfirmSend(true)
	end
end

function CharacterLevelUpView:_delayRefreshView()
	self:_refreshView()

	local heroId = self._heroMO.heroId
	local curLevel = self:getHeroLevel()
	local isAutoSelectNextLevel = true

	if not self.longPress then
		isAutoSelectNextLevel = false

		if self._lastHeroLevel then
			local isOneLevel = curLevel - self._lastHeroLevel == 1
			local isReachLevelLimit = CharacterModel.instance:isHeroLevelReachCeil(heroId, curLevel)

			if isOneLevel and not isReachLevelLimit then
				local realHeroLevel = self:getHeroLevel(true)
				local items = HeroConfig.instance:getLevelUpItems(heroId, realHeroLevel, curLevel + 1)

				if items then
					local _, enough, _ = ItemModel.instance:hasEnoughItems(items)

					isAutoSelectNextLevel = enough
				end
			end
		end
	end

	self._lastHeroLevel = nil

	self:_resetLevelScrollPos(isAutoSelectNextLevel)
	CharacterController.instance:dispatchEvent(CharacterEvent.levelUpAttribute, curLevel, heroId)
end

function CharacterLevelUpView:_localLevelUpConfirmSend(failedRefresh)
	local heroId = self._heroMO.heroId
	local curLevel = self:getHeroLevel()
	local realHeroLevel = self:getHeroLevel(true)
	local isUpLevel = realHeroLevel < curLevel
	local isReachLevelLimit = CharacterModel.instance:isHeroLevelReachCeil(heroId)

	if isUpLevel and not isReachLevelLimit then
		CharacterController.instance:dispatchEvent(CharacterEvent.levelUplocalItem, {}, true)
		HeroRpc.instance:sendHeroLevelUpRequest(heroId, curLevel, self._localLevelUpConfirmSendCallback, self)
		self.viewContainer:setWaitHeroLevelUpRefresh(true)
	elseif failedRefresh then
		CharacterController.instance:dispatchEvent(CharacterEvent.levelUplocalItem)
		self:_refreshView()
	end
end

function CharacterLevelUpView:_localLevelUpConfirmSendCallback(cmd, resultCode, msg)
	self.viewContainer:setWaitHeroLevelUpRefresh(false)
	self.viewContainer:setLocalUpLevel()
	CharacterController.instance:dispatchEvent(CharacterEvent.levelUplocalItem)
end

function CharacterLevelUpView:_btninsightOnClick()
	local function func()
		CharacterController.instance:openCharacterRankUpView(self._heroMO)
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.showCharacterRankUpView, func)
	self:closeThis()
end

function CharacterLevelUpView:_btnitemOnClick(info)
	local type = tonumber(info.type)
	local id = tonumber(info.id)
	local recordItem = {
		type = type,
		id = id,
		quantity = tonumber(info.quantity),
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	}

	MaterialTipController.instance:showMaterialInfo(type, id, false, nil, nil, recordItem)
	self:_localLevelUpConfirmSend()
end

function CharacterLevelUpView:_onItemChanged()
	local waitHeroLevelUpRefresh = self.viewContainer:getWaitHeroLevelUpRefresh()

	if waitHeroLevelUpRefresh then
		return
	end

	self:_refreshConsume()
	self:_refreshMaxCanUpLevel()
end

function CharacterLevelUpView:_onClickHeroEditItem(heroMO)
	if not heroMO or heroMO.heroId ~= self._heroMO.heroId then
		self:closeThis()
	end
end

function CharacterLevelUpView:_onClickLevel(level)
	if not level or not self._heroMO then
		return
	end

	local curRankMaxLv = CharacterModel.instance:getrankEffects(self._heroMO.heroId, self._heroMO.rank)[1]
	local isBreakMax = curRankMaxLv < level
	local curLevel = self:getHeroLevel()
	local isDownLevel = level < curLevel

	if isBreakMax or isDownLevel then
		return
	end

	self._targetLevel = level

	local scrollPos = self:calScrollPos(self._targetLevel)
	local startPos = self._scrolllv.horizontalNormalizedPosition

	self:killTween()

	self._tweenId = ZProj.TweenHelper.DOTweenFloat(startPos, scrollPos, CLICK_LEVEL_TWEEN_TIME, self.tweenFrame, self.tweenFinish, self)
end

function CharacterLevelUpView:tweenFrame(value)
	if not self._scrolllv then
		return
	end

	self._scrolllv.horizontalNormalizedPosition = value
end

function CharacterLevelUpView:tweenFinish()
	self._tweenId = nil

	self:_selectToNearLevel()
end

function CharacterLevelUpView:calScrollLevel()
	local result

	if self._scrolllv and self._heroMO then
		local curLevel = self:getHeroLevel()
		local curRankMaxLv = CharacterModel.instance:getrankEffects(self._heroMO.heroId, self._heroMO.rank)[1]
		local totalDiffLevel = curRankMaxLv - curLevel
		local scrollValue = self._scrolllv.horizontalNormalizedPosition
		local deltaPos = 1 / totalDiffLevel

		result = curLevel

		for deltaLevel = 1, totalDiffLevel do
			local levelPos = (deltaLevel - 0.5) * deltaPos

			if scrollValue < levelPos then
				break
			end

			result = curLevel + deltaLevel
		end

		result = Mathf.Clamp(result, curLevel, curRankMaxLv)
	end

	return result
end

function CharacterLevelUpView:calScrollPos(targetLevel)
	local result = 0

	if targetLevel and self._heroMO then
		local curLevel = self:getHeroLevel()
		local curRankMaxLv = CharacterModel.instance:getrankEffects(self._heroMO.heroId, self._heroMO.rank)[1]
		local diffLevel = targetLevel - curLevel
		local totalDiffLevel = curRankMaxLv - curLevel

		result = diffLevel / totalDiffLevel
		result = Mathf.Clamp(diffLevel / totalDiffLevel, 0, 1)
	end

	return result
end

function CharacterLevelUpView:_editableInitView()
	self._tips = self:getUserDataTb_()

	for i = 1, 3 do
		self._tips[i] = gohelper.findChild(self._gotips, "tips" .. tostring(i))
	end

	self._txtfulllevel = gohelper.findChild(self._tips[1], "full")
	self._tipitems = {}

	for i = 1, COST_ITEM_COUNT do
		local o = self:getUserDataTb_()

		o.go = gohelper.findChild(self._tips[2], "item" .. tostring(i))
		o.icon = gohelper.findChildSingleImage(o.go, "icon")
		o.value = gohelper.findChildText(o.go, "value")
		o.btn = gohelper.findChildButtonWithAudio(o.go, "bg")
		o.type = nil
		o.id = nil
		self._tipitems[i] = o
	end
end

function CharacterLevelUpView:onUpdateParam()
	self:onOpen()
end

function CharacterLevelUpView:onOpen()
	self:clearVar()

	self._heroMO = self.viewParam.heroMO
	self._enterViewName = self.viewParam.enterViewName

	self:_setView()
	self:_refreshView()
	self:_resetLevelScrollPos(true, true)
end

function CharacterLevelUpView:clearVar()
	self:killTween()

	self._targetLevel = nil
	self.previewLevel = nil
	self._isDrag = false
	self.longPress = false
	self._lastHeroLevel = nil
	self._skipScrollAudio = nil
	self._maxCanUpLevel = nil
end

function CharacterLevelUpView:killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function CharacterLevelUpView:_setView()
	local isHeroGroupEditView = self._enterViewName == ViewName.HeroGroupEditView

	if isHeroGroupEditView then
		self._animGO.transform.anchorMin = Vector2(0, 0.5)
		self._animGO.transform.anchorMax = Vector2(0, 0.5)
		self._gorighttop.transform.anchorMin = Vector2(0, 1)
		self._gorighttop.transform.anchorMax = Vector2(0, 1)

		recthelper.setAnchor(self._animGO.transform, 677.22, -50.4)
		recthelper.setAnchor(self._gorighttop.transform, 683, 1)
	else
		self._animGO.transform.anchorMin = Vector2(1, 0.5)
		self._animGO.transform.anchorMax = Vector2(1, 0.5)
		self._gorighttop.transform.anchorMin = Vector2(1, 1)
		self._gorighttop.transform.anchorMax = Vector2(1, 1)

		recthelper.setAnchor(self._animGO.transform, 0, 0)
		recthelper.setAnchor(self._gorighttop.transform, -50, -50)
	end

	gohelper.setActive(self._btnclose.gameObject, not isHeroGroupEditView)
	gohelper.setActive(self._goherogroupbg, isHeroGroupEditView)
	gohelper.setActive(self._gocharacterbg, not isHeroGroupEditView)
end

function CharacterLevelUpView:_refreshView()
	self:_refreshLevelHorizontal()
	self:_refreshLevelScroll()
	self:_refreshMaxCanUpLevel()
end

function CharacterLevelUpView:_refreshLevelScroll()
	local heroId = self._heroMO.heroId
	local curLevel = self:getHeroLevel()
	local isReachLevelLimit = CharacterModel.instance:isHeroLevelReachCeil(heroId, curLevel)

	if isReachLevelLimit then
		self._txtfulllvnum.text = HeroConfig.instance:getShowLevel(curLevel)

		gohelper.setActive(self._tips[2], false)
		gohelper.setActive(self._tips[3], false)
		gohelper.setActive(self._goupgrade, false)
		gohelper.setActive(self._golevelupbeffect, false)

		local isMaxRank = CharacterModel.instance:isHeroRankReachCeil(heroId)

		gohelper.setActive(self._btninsight.gameObject, not isMaxRank)
		CharacterController.instance:dispatchEvent(CharacterEvent.levelUpChangePreviewLevel, curLevel)
	else
		gohelper.setActive(self._btninsight.gameObject, false)
		CharacterLevelListModel.instance:setCharacterLevelList(self._heroMO, curLevel)
		TaskDispatcher.cancelTask(self.dispatchLevelScrollChange, self)
		TaskDispatcher.runDelay(self.dispatchLevelScrollChange, self, NEXT_FRAME_TIME)
	end

	gohelper.setActive(self._tips[1], isReachLevelLimit)
	gohelper.setActive(self._golv, not isReachLevelLimit)
	gohelper.setActive(self._golvfull, isReachLevelLimit)
end

function CharacterLevelUpView:getContentOffset()
	return transformhelper.getLocalPos(self._translvcontent)
end

function CharacterLevelUpView:dispatchLevelScrollChange()
	local contentOffset = self:getContentOffset()

	CharacterController.instance:dispatchEvent(CharacterEvent.levelScrollChange, contentOffset)
end

function CharacterLevelUpView:_refreshConsume(argsTargetLevel)
	local heroId = self._heroMO.heroId
	local curLevel = self:getHeroLevel()
	local isReachLevelLimit = CharacterModel.instance:isHeroLevelReachCeil(heroId, curLevel)

	if isReachLevelLimit then
		return
	end

	local targetLevel = argsTargetLevel or self._targetLevel
	local isCurLevel = targetLevel == curLevel

	gohelper.setActive(self._tips[2], not isCurLevel)

	if isCurLevel then
		gohelper.setActive(self._golevelupbeffect, false)

		return
	end

	local hasEnough = true
	local costItemList = HeroConfig.instance:getLevelUpItems(heroId, curLevel, targetLevel)
	local localCostItemDict = self:getLocalCost()

	for i, costItem in ipairs(costItemList) do
		local tipItem = self._tipitems[i]

		if tipItem then
			local type = tonumber(costItem.type)
			local id = tonumber(costItem.id)
			local isSameType = tipItem.type == type
			local isSameId = tipItem.id == id

			if not isSameType or not isSameId then
				local _, icon = ItemModel.instance:getItemConfigAndIcon(type, id)

				tipItem.icon:LoadImage(icon)
				tipItem.btn:RemoveClickListener()
				tipItem.btn:AddClickListener(self._btnitemOnClick, self, costItem)

				tipItem.type = type
				tipItem.id = id
			end

			local hasQuantity = ItemModel.instance:getItemQuantity(type, id)

			if localCostItemDict and localCostItemDict[type] and localCostItemDict[type][id] then
				hasQuantity = hasQuantity - localCostItemDict[type][id]
			end

			local costQuantity = tonumber(costItem.quantity)

			if hasQuantity < costQuantity then
				tipItem.value.text = "<color=#cc492f>" .. tostring(GameUtil.numberDisplay(costQuantity)) .. "</color>"
				hasEnough = false
			else
				tipItem.value.text = tostring(GameUtil.numberDisplay(costQuantity))
			end

			gohelper.setActive(tipItem.go, true)
		end
	end

	local costItemCount = #costItemList

	if costItemCount < COST_ITEM_COUNT then
		for i = costItemCount + 1, COST_ITEM_COUNT do
			local item = self._tipitems[i]

			gohelper.setActive(item and item.go, false)
		end
	end

	gohelper.setActive(self._golevelupbeffect, hasEnough)
	ZProj.UGUIHelper.SetGrayscale(self._goupgrade, not hasEnough)
	ZProj.UGUIHelper.SetGrayscale(self._goupgradetexten, not hasEnough)
end

function CharacterLevelUpView:_refreshLevelHorizontal()
	if not self._heroMO then
		return
	end

	local heroId = self._heroMO.heroId
	local fillValue = 0
	local curLevel = self:getHeroLevel()
	local isReachLevelLimit = CharacterModel.instance:isHeroLevelReachCeil(heroId, curLevel)

	if isReachLevelLimit then
		fillValue = 1
	else
		local curRank = self._heroMO.rank
		local preRankMaxLv = CharacterModel.instance:getrankEffects(heroId, curRank - 1)[1]
		local curRankMaxLv = CharacterModel.instance:getrankEffects(heroId, curRank)[1]

		fillValue = (curLevel - preRankMaxLv) / (curRankMaxLv - preRankMaxLv)
	end

	if self._lvCtrl then
		self._lvCtrl.float_01 = fillValue

		self._lvCtrl:SetProps()
	end
end

function CharacterLevelUpView:_refreshPreviewLevelHorizontal(argsTargetLevel)
	if not self._heroMO then
		return
	end

	local targetLevel = argsTargetLevel or self._targetLevel
	local heroId = self._heroMO.heroId
	local curLevel = self:getHeroLevel()
	local isReachLevelLimit = CharacterModel.instance:isHeroLevelReachCeil(heroId, curLevel)
	local isCurLevel = argsTargetLevel == curLevel

	if isReachLevelLimit or isCurLevel then
		gohelper.setActive(self._goprevieweff, false)

		return
	end

	local curRank = self._heroMO.rank
	local preRankMaxLv = CharacterModel.instance:getrankEffects(heroId, curRank - 1)[1]
	local curRankMaxLv = CharacterModel.instance:getrankEffects(heroId, curRank)[1]

	if self._previewlvCtrl then
		self._previewlvCtrl.float_01 = (targetLevel - preRankMaxLv) / (curRankMaxLv - preRankMaxLv)

		self._previewlvCtrl:SetProps()
	end

	gohelper.setActive(self._goprevieweff, true)
end

function CharacterLevelUpView:_refreshMaxCanUpLevel()
	self._maxCanUpLevel = nil

	if self._heroMO then
		local heroId = self._heroMO.heroId
		local localCostItemDict = self:getLocalCost()
		local curLevel = self:getHeroLevel()
		local curRankMaxLv = CharacterModel.instance:getrankEffects(heroId, self._heroMO.rank)[1]

		for lv = curLevel + 1, curRankMaxLv do
			local isEnough = true
			local costItemList = HeroConfig.instance:getLevelUpItems(heroId, curLevel, lv)

			for _, costItem in ipairs(costItemList) do
				local type = tonumber(costItem.type)
				local id = tonumber(costItem.id)
				local costQuantity = tonumber(costItem.quantity)
				local hasQuantity = ItemModel.instance:getItemQuantity(type, id)

				if localCostItemDict and localCostItemDict[type] and localCostItemDict[type][id] then
					hasQuantity = hasQuantity - localCostItemDict[type][id]
				end

				if hasQuantity < costQuantity then
					isEnough = false

					break
				end
			end

			if not isEnough then
				break
			end

			self._maxCanUpLevel = lv
		end
	end

	local showMaxLv = self._maxCanUpLevel and HeroConfig.instance:getShowLevel(self._maxCanUpLevel) or ""

	self._txtmax.text = formatLuaLang("v1a5_aizila_level", showMaxLv)

	self:_refreshMaxBtnStatus()
end

function CharacterLevelUpView:_refreshMaxBtnStatus(argsTargetLevel)
	local targetLevel = argsTargetLevel or self._targetLevel

	if not self._heroMO or not targetLevel or not self._maxCanUpLevel then
		gohelper.setActive(self._gomax, false)

		return
	end

	gohelper.setActive(self._gomax, targetLevel ~= self._maxCanUpLevel)
	gohelper.setActive(self._gomaxlarrow, targetLevel > self._maxCanUpLevel)
	gohelper.setActive(self._gomaxrarrow, targetLevel < self._maxCanUpLevel)
end

function CharacterLevelUpView:_resetLevelScrollPos(isNextLevel, isDelay)
	self:killTween()

	self.previewLevel = nil

	if not self._scrolllv then
		return
	end

	self._skipScrollAudio = true

	local curLevel = self:getHeroLevel()

	if self._heroMO and isNextLevel then
		local heroId = self._heroMO.heroId
		local curRank = self._heroMO.rank
		local curRankMaxLv = CharacterModel.instance:getrankEffects(heroId, curRank)[1]

		self._targetLevel = math.min(curLevel + 1, curRankMaxLv)

		if isDelay then
			TaskDispatcher.cancelTask(self.delaySetScrollPos, self)
			TaskDispatcher.runDelay(self.delaySetScrollPos, self, NEXT_FRAME_TIME)
		else
			self._scrolllv.horizontalNormalizedPosition = self:calScrollPos(self._targetLevel)
		end
	else
		self._scrolllv.horizontalNormalizedPosition = 0
		self._targetLevel = curLevel or 0
	end
end

function CharacterLevelUpView:delaySetScrollPos()
	self._scrolllv.horizontalNormalizedPosition = self:calScrollPos(self._targetLevel)
end

function CharacterLevelUpView:getHeroLevel(isGetReal)
	local result = self.viewContainer:getLocalUpLevel()

	result = (not result or isGetReal) and self._heroMO and self._heroMO.level

	return result
end

function CharacterLevelUpView:getLocalCost()
	local result = {}

	if self._heroMO then
		local realHeroLevel = self:getHeroLevel(true)
		local curLevel = self:getHeroLevel()
		local items = HeroConfig.instance:getLevelUpItems(self._heroMO.heroId, realHeroLevel, curLevel)

		for i = 1, #items do
			local item = items[i]

			result[item.type] = result[item.type] or {}
			result[item.type][item.id] = (result[item.type][item.id] or 0) + item.quantity
		end
	end

	return result
end

function CharacterLevelUpView:playLevelUpEff(level)
	if self._anim then
		self._anim:Play(UIAnimationName.Click, 0, 0)
	end

	if self._waveAnimation then
		self._waveAnimation:Stop()
		self._waveAnimation:Play()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_role_upgrade_2)
	CharacterController.instance:dispatchEvent(CharacterEvent.characterLevelItemPlayEff, level)
end

function CharacterLevelUpView:onClose()
	self:removeEvents()
	self:clearVar()
	TaskDispatcher.cancelTask(self.dispatchLevelScrollChange, self)
	TaskDispatcher.cancelTask(self.delaySetScrollPos, self)
	TaskDispatcher.cancelTask(self._delayRefreshView, self)
	self:_localLevelUpConfirmSend()
end

function CharacterLevelUpView:onDestroyView()
	for i = 1, 2 do
		local tipItem = self._tipitems[i]

		tipItem.icon:UnLoadImage()
		tipItem.btn:RemoveClickListener()

		tipItem.type = nil
		tipItem.id = nil
	end
end

return CharacterLevelUpView
