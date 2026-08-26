-- chunkname: @modules/logic/summon/view/SummonEquipFloatView.lua

module("modules.logic.summon.view.SummonEquipFloatView", package.seeall)

local SummonEquipFloatView = class("SummonEquipFloatView", BaseView)

function SummonEquipFloatView:onInitView()
	self._goresult = gohelper.findChild(self.viewGO, "#go_result")
	self._goresultitem = gohelper.findChild(self.viewGO, "#go_result/resultcontent/#go_resultitem")
	self._btnopenall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_result/#btn_openall")
	self._btnreturn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_result/#btn_return")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonEquipFloatView:addEvents()
	self._btnopenall:AddClickListener(self._btnopenallOnClick, self)
end

function SummonEquipFloatView:removeEvents()
	self._btnopenall:RemoveClickListener()
end

function SummonEquipFloatView:_btnopenallOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_click)

	for i = 1, 10 do
		self:openSummonResult(i, true)
	end

	SummonController.instance:nextSummonPopupParam()
end

function SummonEquipFloatView:handleSkip()
	if not self._isDrawing or not self.summonResult then
		return
	end

	SummonController.instance:clearSummonPopupList()

	local resultCount = #self.summonResult

	if resultCount == 1 then
		local summonResultMO, isNew = SummonModel.instance:openSummonEquipResult(1)

		if summonResultMO then
			local equipId = summonResultMO.equipId

			ViewMgr.instance:openView(ViewName.SummonEquipGainView, {
				skipVideo = true,
				equipId = equipId,
				summonResultMo = summonResultMO
			})
		end
	elseif resultCount >= 10 then
		for i = 1, 10 do
			SummonModel.instance:openSummonResult(i)
		end

		local poolId = SummonController.instance:getLastPoolId()

		if not poolId then
			return
		end

		local poolCo = SummonConfig.instance:getSummonPool(poolId)

		if not poolCo then
			return
		end

		ViewMgr.instance:openView(ViewName.SummonResultView, {
			summonResultList = self.summonResult,
			curPool = poolCo
		})
	end
end

function SummonEquipFloatView:_editableInitView()
	gohelper.setActive(self._goresultitem, false)

	self._resultitems = {}
	self._summonUIEffects = self:getUserDataTb_()
end

function SummonEquipFloatView:onOpen()
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.startDraw, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonAnimRareEffect, self.handleSummonAnimRareEffect, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonAnimEnd, self.handleSummonAnimEnd, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonEquipEnd, self.handleSummonEnd, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonSkip, self.handleSkip, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.handleCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.handleOpenView, self)
end

function SummonEquipFloatView:onClose()
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.startDraw, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonAnimRareEffect, self.handleSummonAnimRareEffect, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonAnimEnd, self.handleSummonAnimEnd, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonEquipEnd, self.handleSummonEnd, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonSkip, self.handleSkip, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.handleCloseView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.handleOpenView, self)
end

function SummonEquipFloatView:startDraw()
	SummonController.instance:clearSummonPopupList()

	self.summonResult = SummonModel.instance:getSummonResult(true)

	self:recycleEffect()

	self._isDrawing = true
end

function SummonEquipFloatView:handleSummonAnimEnd()
	self:initSummonResult()
end

function SummonEquipFloatView:handleSummonEnd()
	self:recycleEffect()
end

function SummonEquipFloatView:handleSummonAnimRareEffect()
	local uiNodes = #self.summonResult > 1 and SummonController.instance:getUINodes() or SummonController.instance:getOnlyUINode()

	for i = 1, #self.summonResult do
		local result = self.summonResult[i]
		local equipCo = EquipConfig.instance:getEquipCo(result.equipId)
		local effectUrl = ""
		local animationName = ""

		effectUrl = equipCo.rare <= 2 and SummonEnum.SummonPreloadPath.EquipUIN or equipCo.rare == 3 and SummonEnum.SummonPreloadPath.EquipUIR or equipCo.rare == 4 and SummonEnum.SummonPreloadPath.EquipUISR or SummonEnum.SummonPreloadPath.EquipUISSR
		animationName = SummonEnum.AnimationName[effectUrl]

		local effectWrap = SummonEffectPool.getEffect(effectUrl, uiNodes[i])

		effectWrap:setAnimationName(animationName)
		effectWrap:play()
		effectWrap:loadEquipWaitingClick()
		effectWrap:setEquipFrame(false)
		table.insert(self._summonUIEffects, effectWrap)
	end
end

function SummonEquipFloatView:initSummonResult()
	self._waitEffectList = {}
	self._waitNormalEffectList = {}

	local uiNodes = #self.summonResult > 1 and SummonController.instance:getUINodes() or SummonController.instance:getOnlyUINode()

	for i = 1, #self.summonResult do
		local resultitem = self._resultitems[i]

		if not resultitem then
			resultitem = self:getUserDataTb_()
			resultitem.go = gohelper.cloneInPlace(self._goresultitem, "item" .. i)
			resultitem.index = i
			resultitem.btnopen = gohelper.findChildButtonWithAudio(resultitem.go, "btn_open")

			resultitem.btnopen:AddClickListener(self.onClickItem, self, resultitem)
			table.insert(self._resultitems, resultitem)
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
	end

	for i = #self.summonResult + 1, #self._resultitems do
		gohelper.setActive(self._resultitems[i].go, false)
	end
end

function SummonEquipFloatView:onClickItem(resultitem)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_click)
	self:openSummonResult(resultitem.index)
	SummonController.instance:nextSummonPopupParam()
end

function SummonEquipFloatView:openSummonResult(index, openall)
	local summonResultMO, isNew = SummonModel.instance:openSummonEquipResult(index)
	local summonResult = self.summonResult
	local isSummonTen = #summonResult >= 10

	if summonResultMO then
		local equipId = summonResultMO.equipId
		local equipCo = EquipConfig.instance:getEquipCo(equipId)

		if not openall then
			logNormal(string.format("获得心相:%s", equipCo.name))
		end

		if self._resultitems[index] then
			gohelper.setActive(self._resultitems[index].btnopen.gameObject, false)
		end

		if not isSummonTen or not openall or equipCo.rare >= 5 then
			table.insert(self._waitEffectList, {
				index = index,
				equipId = equipId
			})
			SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.GainCharacterView, ViewName.SummonEquipGainView, {
				equipId = equipId,
				summonResultMo = summonResultMO,
				isSummonTen = isSummonTen
			})
		elseif not openall then
			local uiEffect = self._summonUIEffects[index]

			uiEffect:setEquipFrame(true)
			uiEffect:loadEquipIcon(equipId)
		else
			table.insert(self._waitNormalEffectList, {
				index = index,
				equipId = equipId
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

				SummonController.instance:insertSummonPopupList(PopupEnum.PriorityType.SummonResultView, ViewName.SummonResultView, {
					summonResultList = summonResult,
					curPool = poolCo
				})
			end
		end
	end
end

function SummonEquipFloatView:_refreshIcons()
	if (not self._waitEffectList or #self._waitEffectList <= 1) and self._waitNormalEffectList and #self._waitNormalEffectList > 0 then
		for _, normalEffectParam in ipairs(self._waitNormalEffectList) do
			local index = normalEffectParam.index
			local equipId = normalEffectParam.equipId
			local uiEffect = self._summonUIEffects[index]

			if uiEffect then
				uiEffect:setEquipFrame(true)
				uiEffect:loadEquipIcon(equipId)
			end
		end
	end

	if not self._waitEffectList or #self._waitEffectList <= 0 then
		return
	end

	local param = self._waitEffectList[1]

	table.remove(self._waitEffectList, 1)

	local index = param.index
	local equipId = param.equipId
	local uiEffect = self._summonUIEffects[index]

	if not uiEffect then
		return
	end

	uiEffect:setEquipFrame(true)
	uiEffect:loadEquipIcon(equipId)
end

function SummonEquipFloatView:handleCloseView(viewName)
	if viewName == ViewName.SummonEquipGainView then
		self:_refreshIcons()
	end
end

function SummonEquipFloatView:handleOpenView(viewName)
	if viewName == ViewName.SummonResultView then
		self:_refreshIcons()
	end
end

function SummonEquipFloatView:recycleEffect()
	if self._summonUIEffects then
		for i = 1, #self._summonUIEffects do
			local effectWrap = self._summonUIEffects[i]

			SummonEffectPool.returnEffect(effectWrap)

			self._summonUIEffects[i] = nil
		end
	end
end

function SummonEquipFloatView:onDestroyView()
	for i = 1, #self._resultitems do
		local resultitem = self._resultitems[i]

		resultitem.btnopen:RemoveClickListener()
	end
end

return SummonEquipFloatView
