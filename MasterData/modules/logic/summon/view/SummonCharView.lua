-- chunkname: @modules/logic/summon/view/SummonCharView.lua

module("modules.logic.summon.view.SummonCharView", package.seeall)

local SummonCharView = class("SummonCharView", BaseView)

function SummonCharView:onInitView()
	self._goresult = gohelper.findChild(self.viewGO, "#go_result")
	self._goresultitem = gohelper.findChild(self.viewGO, "#go_result/resultcontent/#go_resultitem")
	self._btnreturn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_result/#btn_return")
	self._btnopenall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_result/#btn_openall")
	self._godrag = gohelper.findChild(self.viewGO, "#go_drag")
	self._goguide = gohelper.findChild(self.viewGO, "#go_drag/#go_guide")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonCharView:addEvents()
	self._btnreturn:AddClickListener(self._btnreturnOnClick, self)
	self._btnopenall:AddClickListener(self._btnopenallOnClick, self)
end

function SummonCharView:removeEvents()
	self._btnreturn:RemoveClickListener()
	self._btnopenall:RemoveClickListener()
end

function SummonCharView:_btnreturnOnClick()
	self:_summonEnd()
end

function SummonCharView:handleSkip()
	logNormal("SummonCharView handleSkip")

	if not self._isDrawing or not self.summonResult then
		return
	end

	self:_hideGuide()

	if self:checkInitDrawComp() then
		self._drawComp:skip()
	end

	local mvSkinIds = {}

	if self.summonResultCount == 10 then
		mvSkinIds = SummonController.instance:getLimitedHeroSkinIdsByPopupParam()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonTurn)
	SummonController.instance:clearSummonPopupList()

	if not LoginController.instance:isEnteredGame() then
		return
	end

	local poolId = SummonController.instance:getLastPoolId()

	if self.summonResultCount == 1 then
		local summonResultMO, duplicateCount = SummonModel.instance:openSummonResult(1)

		if summonResultMO then
			if summonResultMO.heroId and summonResultMO.heroId ~= 0 then
				SummonLuckyBagController.instance:skipOpenGetChar(summonResultMO.heroId, duplicateCount, poolId)
				SummonController.instance:nextSummonPopupParam()
			elseif summonResultMO:isLuckyBag() then
				if not poolId then
					return
				end

				SummonLuckyBagController.instance:skipOpenGetLuckyBag(summonResultMO.luckyBagId, poolId)
			end
		end
	elseif self.summonResultCount > 1 then
		for i = 1, 10 do
			SummonModel.instance:openSummonResult(i)
		end

		if not poolId then
			return
		end

		local poolCo = SummonConfig.instance:getSummonPool(poolId)

		if not poolCo then
			return
		end

		for _, value in pairs(mvSkinIds) do
			SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.SummonResultView, ViewName.LimitedRoleView, {
				limitedCO = lua_character_limited.configDict[value],
				stopBgm = AudioBgmEnum.Layer.Summon
			})
		end

		local currentResultViewName = SummonController.instance:getResultViewName()

		SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.SummonResultView, currentResultViewName, {
			summonResultList = self.summonResult,
			curPool = poolCo
		})
		SummonController.instance:nextSummonPopupParam()
	end
end

function SummonCharView:_btnopenallOnClick()
	self._isOpeningAll = true

	for i = 1, 10 do
		self:openSummonResult(i, true)
	end

	SummonController.instance:nextSummonPopupParam()
end

function SummonCharView:_editableInitView()
	self:checkInitDrawComp()

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._godrag)

	self._drag:AddDragListener(self.onDrag, self)
	self._drag:AddDragBeginListener(self.onDragBegin, self)
	self._drag:AddDragEndListener(self.onDragEnd, self)

	self._dragClickListener = SLFramework.UGUI.UIClickListener.Get(self._godrag)

	self._dragClickListener:AddClickDownListener(self.onDragClickDown, self)
	self._dragClickListener:AddClickUpListener(self.onDragClickUp, self)
	gohelper.setActive(self._goresultitem, false)

	self._resultitems = {}
	self._summonUIEffects = self:getUserDataTb_()
	self.summonPackagePoolHeroDic = {}
end

function SummonCharView:_initSummonView()
	gohelper.setActive(self._goresult, false)
	gohelper.setActive(self._godrag, false)
end

function SummonCharView:onUpdateParam()
	self:_initSummonView()
end

function SummonCharView:onOpen()
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.startDraw, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonAnimShowGuide, self._showGuide, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonAnimEnterDraw, self.handleAnimStartDraw, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonDraw, self.onDragComplete, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonAnimRareEffect, self.handleSummonAnimRareEffect, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonAnimEnd, self.onSummonAnimEnd, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonResultClose, self._summonEnd, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonSkip, self.handleSkip, self)
	self:_initSummonView()
end

function SummonCharView:onClose()
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.startDraw, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonAnimShowGuide, self._showGuide, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonDraw, self.onDragComplete, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonAnimEnterDraw, self.handleAnimStartDraw, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonAnimRareEffect, self.handleSummonAnimRareEffect, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonAnimEnd, self.onSummonAnimEnd, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonResultClose, self._summonEnd, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonSkip, self.handleSkip, self)
	SummonModel.instance:setIsDrawing(false)
end

function SummonCharView:onDragClickDown()
	self._lastDragAngle = nil
	self._lastDragTime = nil

	if self:checkInitDrawComp() then
		self._drawComp:startTurn()
	end
end

function SummonCharView:onDragClickUp()
	if self:checkInitDrawComp() then
		self._drawComp:endTurn()
	end

	self:_updateDragArea()
end

function SummonCharView:onDragBegin(param, eventData)
	self._lastDragAngle = nil
	self._lastDragTime = nil

	if self:checkInitDrawComp() then
		self._drawComp:startTurn()
	end

	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_begin)
end

function SummonCharView:onDragEnd(param, eventData)
	if self:checkInitDrawComp() then
		self._drawComp:endTurn()
	end

	self:_updateDragArea()
	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_waterwheelstop)
end

SummonCharView.TouchCenter = 0.1
SummonCharView.TouchOuter = 3

function SummonCharView:onDrag(param, eventData)
	if not self._dragAreaInitialized or not self:checkInitDrawComp() then
		return
	end

	local localPosition = recthelper.screenPosToAnchorPos(eventData.position, self._godrag.transform)
	local x = localPosition.x
	local y = localPosition.y
	local width = self._dragWidth
	local height = self._dragHeight
	local center = SummonCharView.TouchCenter
	local outer = SummonCharView.TouchOuter

	if x * x + y * y < (width + height) * (width + height) / 16 * center * center then
		self._lastDragAngle = nil

		return
	end

	if x * x + y * y > (width + height) * (width + height) / 16 * outer * outer then
		self._lastDragAngle = nil

		return
	end

	local angle = 0
	local minus = 1e-06

	angle = math.abs(x) < width * minus and (y > 0 and 90 or 270) or math.abs(y) < height * minus and (x > 0 and 0 or 180) or math.deg(math.atan(y / x)) + (x * y > 0 and 0 or 180) + (y > 0 and 0 or 180)

	local currentTime = Time.unscaledTime

	if self._lastDragAngle and self._lastDragTime then
		local deltaAngle = angle - self._lastDragAngle

		if self._lastDragAngle > 270 and angle < 90 then
			deltaAngle = 360 - self._lastDragAngle + angle
		end

		self._drawComp:updateAngle((self._lastDragAngle < 90 and angle > 270 or nil) and -360 - self._lastDragAngle + angle)
	end

	self._lastDragAngle = angle
	self._lastDragTime = currentTime

	self:_hideGuide()
	TaskDispatcher.runDelay(self._showGuide, self, 3)
	self:_updateDragArea()
end

function SummonCharView:onDragComplete()
	GuideController.instance:dispatchEvent(GuideEvent.SpecialEventDone, GuideEnum.SpecialEventEnum.SummonTurn)
	self:_summonStart()
	self:_hideGuide()
end

function SummonCharView:_showGuide()
	TaskDispatcher.cancelTask(self._showGuide, self)
	gohelper.setActive(self._goguide, true)
end

function SummonCharView:_hideGuide()
	TaskDispatcher.cancelTask(self._showGuide, self)
	gohelper.setActive(self._goguide, false)
end

function SummonCharView:startDraw()
	if not self:checkInitDrawComp() then
		self:handleSkip()

		return
	end

	SummonController.instance:clearSummonPopupList()

	self._isOpeningAll = false

	AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(AudioEnum.SwitchGroup.Summon), AudioMgr.instance:getIdFromString(AudioEnum.SwitchState.SummonAward))

	self.resultViewIsClose = false
	self.summonResult = SummonModel.instance:getSummonResult(true)
	self.summonResultCount = tabletool.len(self.summonResult)

	for i = 1, self.summonResultCount do
		local resultMo = self.summonResult[i]

		if resultMo and not self.summonPackagePoolHeroDic[resultMo.heroId] then
			self.summonPackagePoolHeroDic[resultMo.heroId] = true
		end
	end

	if self.summonResultCount then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_callfor_ten)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_callfor_once)
	end

	AudioMgr.instance:trigger(AudioEnum.Summon.Trigger_Music)
	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_inscription_amb)
	gohelper.setActive(self._goresult, false)
	SummonController.instance:resetAnim()
	self:recycleEffect()

	if self.summonResult and self.summonResultCount > 0 then
		self._isDrawing = true

		SummonModel.instance:setIsDrawing(true)

		local bestRare = SummonModel.getBestRare(self.summonResult)

		self._drawComp:resetDraw(bestRare, self.summonResultCount > 1)

		if not SummonController.instance:getIsGuideAnim() and not SummonController.instance:isInSummonGuide() then
			SummonController.instance:startPlayAnim()
		else
			self:handleAnimStartDraw()
		end
	end
end

function SummonCharView:checkInitDrawComp()
	if self._drawComp == nil then
		local summonScene = VirtualSummonScene.instance:getSummonScene()

		self._drawComp = summonScene.director:getDrawComp(SummonEnum.ResultType.Char)
	end

	return self._drawComp ~= nil
end

function SummonCharView:handleAnimStartDraw()
	gohelper.setActive(self._godrag.gameObject, true)
	SummonController.instance:forbidAnim()

	local bestRare = SummonModel.getBestRare(self.summonResult)

	self:_initDragArea(bestRare)
	self:_showGuide()
end

function SummonCharView:_initDragArea(rare)
	self:_updateDragArea()

	self._dragAreaInitialized = true
end

function SummonCharView:_updateDragArea()
	local expandWidth = 220
	local expandHeight = 400
	local wheelTopLeft = SummonController.instance:getSceneNode("anim/StandStill/Obj-Plant/s06_Obj_d/top_left")
	local wheelBottomRight = SummonController.instance:getSceneNode("anim/StandStill/Obj-Plant/s06_Obj_d/bottom_right")
	local topLeftPos = recthelper.worldPosToAnchorPos(wheelTopLeft.transform.position, self.viewGO.transform)
	local BottomRightPos = recthelper.worldPosToAnchorPos(wheelBottomRight.transform.position, self.viewGO.transform)

	self._dragPosX = (topLeftPos.x + BottomRightPos.x) / 2
	self._dragPosY = (topLeftPos.y + BottomRightPos.y) / 2

	recthelper.setAnchor(self._godrag.transform, self._dragPosX, self._dragPosY)

	self._dragHeight = math.abs(topLeftPos.y - BottomRightPos.y) + expandHeight

	recthelper.setHeight(self._godrag.transform, self._dragHeight)

	self._dragWidth = math.abs(BottomRightPos.x - topLeftPos.x) + expandWidth

	recthelper.setWidth(self._godrag.transform, self._dragWidth)

	self._dragHeight = math.abs(topLeftPos.y - BottomRightPos.y)
	self._dragWidth = math.abs(BottomRightPos.x - topLeftPos.x)
end

function SummonCharView:_summonStart()
	gohelper.setActive(self._godrag.gameObject, false)

	local bestRare = SummonModel.getBestRare(self.summonResult)

	if self.summonResultCount > 1 then
		SummonController.instance:drawAnim()
		AudioMgr.instance:trigger(AudioEnum.Summon.Play_Summon_TenTimes)
	else
		SummonController.instance:drawOnlyAnim()
		AudioMgr.instance:trigger(AudioEnum.Summon.Play_Summon_Once)
	end

	local rareBoomAudio = AudioEnum.SummonSwitchState[bestRare - 1]

	if not string.nilorempty(rareBoomAudio) then
		AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(AudioEnum.SwitchGroup.SummonResult), AudioMgr.instance:getIdFromString(rareBoomAudio))
	end

	AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_callfor_chestsopen)
	self:_boomAttachEffect()
end

function SummonCharView:_boomAttachEffect()
	if not self:checkInitDrawComp() then
		self:handleSkip()
	end

	local bestRare = SummonModel.getBestRare(self.summonResult)
	local rareKey = SummonEnum.SummonQualityDefine[bestRare]

	if string.nilorempty(rareKey) then
		return
	end

	local keyName = string.format("Scene%sBoom", rareKey)
	local attachUrl = SummonEnum.SummonPreloadPath[keyName]

	if attachUrl then
		local boomRootGO = self._drawComp:getStepEffectContainer()

		self._sceneBoomEffectWrap = SummonEffectPool.getEffect(attachUrl, boomRootGO)

		if self._sceneBoomEffectWrap then
			self._sceneBoomEffectWrap:play()

			return
		end
	end
end

function SummonCharView:handleSummonAnimRareEffect()
	local uiNodes = {}

	uiNodes = self.summonResultCount > 1 and SummonController.instance:getUINodes() or SummonController.instance:getOnlyUINode()

	local hasLuckyBag = false

	for i, result in pairs(self.summonResult) do
		if result:isLuckyBag() then
			self:createResultLuckyBagEffect(result, uiNodes, i)

			hasLuckyBag = true
		else
			self:createResultCharRareEffect(result, uiNodes, i)
		end
	end

	if hasLuckyBag then
		AudioMgr.instance:trigger(AudioEnum.Summon.play_ui_wulu_lucky_bag_prize)
	end
end

function SummonCharView:createResultCharRareEffect(result, uiNodes, i)
	local heroConfig = HeroConfig.instance:getHeroCO(result.heroId)
	local effectUrl = ""
	local animationName = ""

	effectUrl = heroConfig.rare <= 2 and SummonEnum.SummonPreloadPath.UIN or heroConfig.rare == 3 and SummonEnum.SummonPreloadPath.UIR or heroConfig.rare == 4 and SummonEnum.SummonPreloadPath.UISR or SummonEnum.SummonPreloadPath.UISSR
	animationName = SummonEnum.AnimationName[effectUrl]

	local effectWrap = SummonEffectPool.getEffect(effectUrl, uiNodes[i])

	effectWrap:setAnimationName(animationName)
	effectWrap:play()
	table.insert(self._summonUIEffects, effectWrap)
end

function SummonCharView:createResultLuckyBagEffect(result, uiNodes, i)
	local effectUrl = SummonEnum.SummonLuckyBagPreloadPath.UILuckyBag
	local animationName = ""
	local luckyBagId = result.luckyBagId
	local poolId = SummonController.instance:getLastPoolId()

	if not poolId then
		return
	end

	local luckyBagCo = SummonConfig.instance:getLuckyBag(poolId, luckyBagId)

	if not luckyBagCo then
		return
	end

	animationName = SummonEnum.AnimationName[effectUrl]

	local effectWrap = SummonEffectPool.getEffect(effectUrl, uiNodes[i])

	effectWrap:loadHeadTex(ResUrl.getSummonSceneTexture(luckyBagCo.sceneIcon))
	effectWrap:setAnimationName(animationName)
	effectWrap:play()
	table.insert(self._summonUIEffects, effectWrap)
end

function SummonCharView:onSummonAnimEnd()
	gohelper.setActive(self._goresult, true)
	gohelper.setActive(self._btnreturn.gameObject, false)
	gohelper.setActive(self._btnopenall.gameObject, self.summonResultCount > 1)
	self:initSummonResult()
end

function SummonCharView:initSummonResult()
	self._waitEffectList = {}
	self._waitNormalEffectList = {}
	self._luckyBagIdList = {}

	local uiNodes = {}

	uiNodes = self.summonResultCount > 1 and SummonController.instance:getUINodes() or SummonController.instance:getOnlyUINode()

	local alreadyVisitSet = {}

	for i, result in pairs(self.summonResult) do
		local resultitem = self._resultitems[i]

		if not resultitem then
			resultitem = self:getUserDataTb_()
			resultitem.go = gohelper.cloneInPlace(self._goresultitem, "item" .. i)
			resultitem.index = i
			resultitem.btnopen = gohelper.findChildButtonWithAudio(resultitem.go, "btn_open")

			resultitem.btnopen:AddClickListener(function(resultitem)
				self:openSummonResult(resultitem.index)
				SummonController.instance:nextSummonPopupParam()
			end, resultitem)

			self._resultitems[i] = resultitem
		end

		local uiNode = uiNodes[i]

		if uiNode then
			local btnTopLeft = gohelper.findChild(uiNode, "btn/btnTopLeft")
			local btnBottomRight = gohelper.findChild(uiNode, "btn/btnBottomRight")
			local topLeftPos = recthelper.worldPosToAnchorPos(btnTopLeft.transform.position, self.viewGO.transform)
			local BottomRightPos = recthelper.worldPosToAnchorPos(btnBottomRight.transform.position, self.viewGO.transform)

			recthelper.setAnchor(resultitem.go.transform, (topLeftPos.x + BottomRightPos.x) / 2, (topLeftPos.y + BottomRightPos.y) / 2)
			recthelper.setHeight(resultitem.go.transform, math.abs(topLeftPos.y - BottomRightPos.y))
			recthelper.setWidth(resultitem.go.transform, math.abs(BottomRightPos.x - topLeftPos.x))
		end

		gohelper.setActive(resultitem.btnopen.gameObject, true)
		gohelper.setActive(resultitem.go, true)

		alreadyVisitSet[i] = true
	end

	for i, rsItem in pairs(self._resultitems) do
		if not alreadyVisitSet[i] then
			gohelper.setActive(rsItem.go, false)
		end
	end
end

function SummonCharView:openSummonResult(index, openall)
	local summonResultMO, duplicateCount = SummonModel.instance:openSummonResult(index)
	local summonResult = SummonModel.instance:getSummonResult(false)
	local isSummonTen = #summonResult > 1

	if summonResultMO then
		local heroId = summonResultMO.heroId
		local heroConfig

		if heroId ~= nil and heroId ~= 0 then
			heroConfig = HeroConfig.instance:getHeroCO(heroId)
		end

		if not openall and heroId ~= 0 then
			logNormal(string.format("获得角色:%s", heroConfig.name))
		end

		if self._resultitems[index] then
			gohelper.setActive(self._resultitems[index].btnopen.gameObject, false)
		end

		if not isSummonTen or not openall or duplicateCount <= 0 or heroConfig and heroConfig.rare >= 5 then
			if not summonResultMO:isLuckyBag() then
				table.insert(self._waitEffectList, {
					index = index,
					heroId = heroId,
					luckyBagId = summonResultMO.luckyBagId
				})
				self:insertSingleCharPopup(heroId, duplicateCount, isSummonTen)
			else
				local allLuckyBagIdList = {
					summonResultMO.luckyBagId
				}

				self:insertLuckyBagPopup(allLuckyBagIdList)
			end
		elseif not openall then
			local uiEffect = self._summonUIEffects[index]

			uiEffect:loadHeroIcon(heroId)
		else
			table.insert(self._waitNormalEffectList, {
				index = index,
				heroId = heroId,
				luckyBagId = summonResultMO.luckyBagId
			})
		end

		if SummonModel.instance:isAllOpened() then
			gohelper.setActive(self._btnopenall.gameObject, false)

			if not isSummonTen then
				gohelper.setActive(self._btnreturn.gameObject, true)
			else
				local poolId = SummonController.instance:getLastPoolId()

				if not poolId then
					return
				end

				local poolCo = SummonConfig.instance:getSummonPool(poolId)

				if not poolCo then
					return
				end

				local currentResultViewName = SummonController.instance:getResultViewName()

				SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.SummonResultView, currentResultViewName, {
					summonResultList = summonResult,
					curPool = poolCo
				})
			end
		end
	end
end

function SummonCharView:insertSingleCharPopup(heroId, duplicateCount, isSummonTen)
	local poolId = SummonController.instance:getLastPoolId()

	if not poolId then
		return
	end

	local poolCo = SummonConfig.instance:getSummonPool(poolId)

	if not poolCo then
		return
	end

	local ticketId
	local popupParam = {
		isSummon = true,
		heroId = heroId,
		duplicateCount = duplicateCount,
		isSummonTen = isSummonTen,
		summonTicketId = (poolCo.ticketId ~= 0 or nil) and poolCo.ticketId
	}
	local mvSkinId = SummonController.instance:getMvSkinIdByHeroId(heroId)

	if mvSkinId then
		popupParam.skipVideo = true
		popupParam.mvSkinId = mvSkinId
	end

	SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.GainCharacterView, ViewName.CharacterGetView, popupParam)
end

function SummonCharView:insertLuckyBagPopup(luckyBagIdList)
	local poolId = SummonController.instance:getLastPoolId()

	if not poolId then
		return
	end

	local popupParam = {
		luckyBagIdList = luckyBagIdList,
		poolId = poolId
	}

	SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.GainCharacterView, ViewName.SummonGetLuckyBag, popupParam)
end

function SummonCharView:_refreshIcons()
	if (not self._waitEffectList or #self._waitEffectList <= 1) and self._waitNormalEffectList and #self._waitNormalEffectList > 0 then
		for _, normalEffectParam in ipairs(self._waitNormalEffectList) do
			local index = normalEffectParam.index
			local heroId = normalEffectParam.heroId
			local uiEffect = self._summonUIEffects[index]

			if uiEffect and heroId ~= 0 then
				uiEffect:loadHeroIcon(heroId)
			end
		end
	end

	if not self._waitEffectList or #self._waitEffectList <= 0 then
		return
	end

	local param = self._waitEffectList[1]

	table.remove(self._waitEffectList, 1)

	local index = param.index
	local heroId = param.heroId
	local uiEffect = self._summonUIEffects[index]

	if not uiEffect or heroId == 0 then
		return
	end

	uiEffect:loadHeroIcon(heroId)
end

function SummonCharView:_summonEnd()
	if not self._isDrawing then
		return
	end

	self._isDrawing = false

	SummonModel.instance:setIsDrawing(false)
	SummonController.instance:clearSummonPopupList()
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(AudioEnum.SwitchGroup.Summon), AudioMgr.instance:getIdFromString(AudioEnum.SwitchState.SummonNormal))
	AudioMgr.instance:trigger(AudioEnum.Summon.Trigger_Music)
	gohelper.setActive(self._gosummon, true)
	gohelper.setActive(self._goresult, false)
	self:recycleEffect()

	if self._sceneBoomEffectWrap then
		SummonEffectPool.returnEffect(self._sceneBoomEffectWrap)

		self._sceneBoomEffectWrap = nil
	end

	SummonController.instance:resetAnim()

	if not LoginController.instance:isEnteredGame() then
		return
	end

	SummonMainModel.instance:updateLastPoolId()

	local param = {}

	param.jumpPoolId = SummonController.instance:getLastPoolId()

	local heroDic = {}

	for heroId, _ in pairs(self.summonPackagePoolHeroDic) do
		heroDic[heroId] = true
	end

	param.getHeroDic = heroDic

	local summonEndCallback = SummonController.instance:getSummonEndOpenCallBack()

	if summonEndCallback then
		summonEndCallback:invoke()
		SummonController.instance:setSummonEndOpenCallBack(nil, nil)
	else
		SummonMainController.instance:openSummonView(param)
	end

	self:_gc()

	self.summonResult = {}
	self.summonResultCount = 0
	self.summonPackagePoolHeroDic = {}
end

function SummonCharView:_onCloseView(viewName)
	if viewName == ViewName.SummonResultView or viewName == ViewName.SummonSimulationResultView then
		self.resultViewIsClose = true
	end

	if viewName == ViewName.CharacterGetView or viewName == ViewName.SummonGetLuckyBag or viewName == ViewName.LimitedRoleView then
		self:_refreshIcons()

		if self.summonResult then
			if self.summonResultCount == 1 and viewName ~= ViewName.LimitedRoleView then
				self:_summonEnd()
			else
				SummonController.instance:nextSummonPopupParam()
			end
		end
	elseif viewName == ViewName.CommonPropView and self:_isCloseResultView() and self.summonResult and self.summonResultCount > 1 and self.resultViewIsClose then
		self:_summonEnd()
	end
end

function SummonCharView:_onOpenView(viewName)
	local currentResultViewName = SummonController.instance:getResultViewName()

	if viewName == currentResultViewName then
		self:_refreshIcons()
	end
end

function SummonCharView:_isCloseResultView()
	if ViewMgr.instance:isOpen(ViewName.SummonResultView) or ViewMgr.instance:isOpen(ViewName.SummonSimulationResultView) then
		return false
	end

	return true
end

function SummonCharView:recycleEffect()
	if self._summonUIEffects then
		for i = 1, #self._summonUIEffects do
			local effectWrap = self._summonUIEffects[i]

			SummonEffectPool.returnEffect(effectWrap)

			self._summonUIEffects[i] = nil
		end
	end
end

function SummonCharView:onDestroyView()
	for i, resultitem in pairs(self._resultitems) do
		resultitem.btnopen:RemoveClickListener()
	end

	self._drag:RemoveDragListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._dragClickListener:RemoveClickDownListener()
	self._dragClickListener:RemoveClickUpListener()
end

function SummonCharView:_gc()
	self._summonCount = (self._summonCount or 0) + (self.summonResult and self.summonResultCount)

	if self._summonCount > 1 then
		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 1, self)

		self._summonCount = 0
	end
end

return SummonCharView
