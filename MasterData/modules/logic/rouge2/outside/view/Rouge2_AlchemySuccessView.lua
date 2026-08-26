-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_AlchemySuccessView.lua

module("modules.logic.rouge2.outside.view.Rouge2_AlchemySuccessView", package.seeall)

local Rouge2_AlchemySuccessView = class("Rouge2_AlchemySuccessView", BaseView)
local waitShowTime = 0.5
local UpdatePointMoveDuration = 0.4
local UpdatePointFadeTime = 0.5
local WaitSec2MoveOtherValue = 0.03

function Rouge2_AlchemySuccessView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_fullbg")
	self._btnclose = gohelper.findChildButton(self.viewGO, "bg/#btn_close")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "go_icon/#simage_icon")
	self._imageicon = gohelper.findChildImage(self.viewGO, "go_icon/#simage_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "go_icon/image_nameBG/#txt_name")
	self._gospecialTips = gohelper.findChild(self.viewGO, "Title/#go_specialTips")
	self._txtspecialEventsNum = gohelper.findChildText(self.viewGO, "Title/#go_specialTips/#txt_specialEventsNum")
	self._scrollbase = gohelper.findChildScrollRect(self.viewGO, "base/#scroll_base")
	self._godescContent = gohelper.findChild(self.viewGO, "base/#scroll_base/Viewport/#go_descContent")
	self._scrolladdition = gohelper.findChildScrollRect(self.viewGO, "addition/#scroll_addition")
	self._godescSpecialContent = gohelper.findChild(self.viewGO, "addition/#scroll_addition/Viewport/#go_descSpecialContent")
	self._goempty = gohelper.findChild(self.viewGO, "addition/#go_empty")
	self._goMatrialReturn = gohelper.findChild(self.viewGO, "#go_MatrialReturn")
	self._txtdec = gohelper.findChildText(self.viewGO, "#go_MatrialReturn/#txt_dec")
	self._goicon = gohelper.findChild(self.viewGO, "#go_MatrialReturn/layout/#go_icon")
	self._btnagain = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_again")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_confirm")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")
	self._txttalentNum = gohelper.findChildText(self.viewGO, "#go_topright/#txt_talentNum")
	self._txtclosetips = gohelper.findChildText(self.viewGO, "bottom/#txt_closetips")
	self._txtadd = gohelper.findChildText(self.viewGO, "#go_topright/#txt_add")
	self._govxvitality = gohelper.findChildText(self.viewGO, "#go_topright/#go_vx_vitality")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_AlchemySuccessView:addEvents()
	self._btnagain:AddClickListener(self._btnagainOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btnclose:AddClickListener(self._btnconfirmOnClick, self)
	self.addEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onAlchemyCancel, self.onAlchemyCancel, self)
end

function Rouge2_AlchemySuccessView:removeEvents()
	self._btnagain:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, Rouge2_OutsideController.instance, Rouge2_OutsideEvent.onAlchemyCancel, self.onAlchemyCancel, self)
end

function Rouge2_AlchemySuccessView:_btnagainOnClick()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_click)

	if Rouge2_Model.instance:isFinishedDifficulty() or Rouge2_Model.instance:isStarted() then
		GameFacade.showToast(ToastEnum.Rouge2GameStartFormulaTip)

		return
	end

	Rouge2_OutsideController.instance:tryClearCurFormula()
end

function Rouge2_AlchemySuccessView:_btnconfirmOnClick()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_click)
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_ideadetails)

	if self.state == Rouge2_OutsideEnum.AlchemySuccessViewState.Success then
		Rouge2_OutsideController.instance:openAlchemyView(true)
	end

	self:closeThis()
end

function Rouge2_AlchemySuccessView:_btncloseOnClick()
	self:closeThis()
end

function Rouge2_AlchemySuccessView:_editableInitView()
	self._mainDescItemList = {}
	self._specialDescItemList = {}

	gohelper.setActive(self._godescSpecialContent, true)
	gohelper.setActive(self._godescContent, true)

	self._goTextDesc = gohelper.findChild(self._godescContent, "#txt_desc")
	self._goTextDescSpecial = gohelper.findChild(self._godescSpecialContent, "#txt_desc")

	gohelper.setActive(self._goTextDesc, false)
	gohelper.setActive(self._goTextDescSpecial, false)
	gohelper.setActive(self._goicon, false)
	self:initIcon()

	self._unuseUpdatePointItemList = self:getUserDataTb_()
	self._useUpdatePointItemList = self:getUserDataTb_()
	self._updatePointIcon = gohelper.findChild(self.viewGO, "Title/#go_specialTips/#txt_specialEventsNum/icon/#iconfly")
end

function Rouge2_AlchemySuccessView:initIcon()
	self.imageUpdatePoint = gohelper.findChildImage(self.viewGO, "#go_topright/#txt_talentNum/icon")

	local constConfig = Rouge2_OutSideConfig.instance:getConstConfigById(Rouge2_Enum.OutSideConstId.TalentPointId)
	local itemId = tonumber(constConfig.value)
	local itemConfig = CurrencyConfig.instance:getCurrencyCo(itemId)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self.imageUpdatePoint, tostring(itemConfig.id) .. "_1")
end

function Rouge2_AlchemySuccessView:onUpdateParam()
	return
end

function Rouge2_AlchemySuccessView:onOpen()
	local viewParam = self.viewParam

	if viewParam then
		self.state = viewParam.state or Rouge2_OutsideEnum.AlchemySuccessViewState.Detail
	end

	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnAlchemySuccessOpenFinish, self.state)

	self.mainUpdatePosDic = {}
	self.extraUpdatePosDic = {}
	self.alchemyInfo = Rouge2_AlchemyModel.instance:getHaveAlchemyInfo()
	self.subEffect = {}

	for pos, effect in ipairs(self.alchemyInfo.subEffect) do
		self.subEffect[pos] = effect
	end

	if self.state == Rouge2_OutsideEnum.AlchemySuccessViewState.Success then
		AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_alchemyideasuc)

		self.spEventNum = viewParam.spEventNum
		self.returnMaterial = viewParam.returnMaterial
		self.subExtraEffect = viewParam.subExtraEffect
		self.mainUpdateEffect = viewParam.mainUpdateEffect

		if self.mainUpdateEffect and self.mainUpdateEffect == 1 then
			self.mainUpdatePosDic[1] = true
		end

		if self.subExtraEffect then
			for _, pos in ipairs(self.subExtraEffect) do
				self.extraUpdatePosDic[pos] = true
			end
		end
	end

	self:refreshUI()
end

function Rouge2_AlchemySuccessView:refreshUI()
	local isSuccessState = self.state == Rouge2_OutsideEnum.AlchemySuccessViewState.Success

	gohelper.setActive(self._goMatrialReturn, isSuccessState)
	gohelper.setActive(self._gotopright, isSuccessState)
	gohelper.setActive(self._gospecialTips, isSuccessState)
	gohelper.setActive(self._btnagain, isSuccessState)
	gohelper.setActive(self._btnconfirm, isSuccessState)
	gohelper.setActive(self._govxvitality, isSuccessState)
	gohelper.setActive(self._txtclosetips, not isSuccessState)
	gohelper.setActive(self._btnclose, not isSuccessState)
	self:refreshFormulaInfo()
	self:refreshDesc()

	if not isSuccessState then
		return
	end

	self:refreshMaterialReturn()
	self:refreshSpecialEventInfo()
	self:refreshTalentInfo()
	self:playUpdatePointAnim()
end

function Rouge2_AlchemySuccessView:refreshMaterialReturn()
	local haveReturn = self.returnMaterial ~= nil and #self.returnMaterial > 0

	gohelper.setActive(self._goMatrialReturn, haveReturn)

	if not haveReturn then
		return
	end

	local data = {}

	for _, materialId in ipairs(self.returnMaterial) do
		local materialConfig = Rouge2_OutSideConfig.instance:getMaterialConfig(materialId)

		if materialConfig == nil then
			logError("肉鸽2 返还了前端不存在的材料 id:" .. tostring(materialId))
		else
			table.insert(data, materialId)
		end
	end

	gohelper.CreateObjList(self, self.onReturnItemShow, data, self._goicon.transform.parent.gameObject, self._goicon, Rouge2_AlchemySuccessReturnMaterialItem)
end

function Rouge2_AlchemySuccessView:onReturnItemShow(item, data, index)
	item:setInfo(data, index)
end

function Rouge2_AlchemySuccessView:refreshSpecialEventInfo()
	if self.spEventNum then
		local haveSpecialEvent = self.spEventNum > 0

		gohelper.setActive(self._gospecialTips, haveSpecialEvent)

		if not haveSpecialEvent then
			return
		end

		self._txtspecialEventsNum.text = tostring(self.spEventNum)
	end
end

function Rouge2_AlchemySuccessView:refreshTalentInfo()
	self._txttalentNum.text = tostring(Rouge2_TalentModel.instance:getTalentPoint())

	local maxtalentpointConfig = Rouge2_OutSideConfig.instance:getConstConfigById(Rouge2_Enum.OutSideConstId.TalentPointMaxCount)
	local maxtalentpoint = tonumber(maxtalentpointConfig.value)
	local getAllPoint = math.min(Rouge2_TalentModel.instance:getHadAllTalentPoint(), maxtalentpoint)

	gohelper.setActive(self._txtadd, getAllPoint < maxtalentpoint)
end

function Rouge2_AlchemySuccessView:refreshFormulaInfo()
	local formulaConfig = Rouge2_OutSideConfig.instance:getFormulaConfig(self.alchemyInfo.formula)

	Rouge2_IconHelper.setFormulaIcon(self.alchemyInfo.formula, self._simageicon)

	self._imageicon.preserveAspect = true

	local rareStr = Rouge2_OutsideEnum.FormulaRareColor[formulaConfig.rare]

	self._txtname.text = string.format("<color=%s>%s</color>", rareStr, formulaConfig.name)
end

function Rouge2_AlchemySuccessView:refreshDesc()
	self:refreshSingleDesc({
		self.alchemyInfo.mainEffect
	}, true, self.mainUpdatePosDic)
	self:refreshSingleDesc(self.subEffect, false, self.extraUpdatePosDic)
end

function Rouge2_AlchemySuccessView:onFlowDone()
	self:destroyFlow()
end

function Rouge2_AlchemySuccessView:buildUpdatePointMoveFlow()
	local moveFlow = FlowParallel.New()
	local eventCount = 0

	for pos, _ in pairs(self.mainUpdatePosDic) do
		eventCount = eventCount + 1

		local targetItem = self._mainDescItemList[pos]
		local pointItem = self:getUpdatePointItem()
		local oneFixFlow = self:buildOneUpdatePointMoveFlow(targetItem, eventCount, pointItem)

		moveFlow:addWork(oneFixFlow)
	end

	for pos, _ in pairs(self.extraUpdatePosDic) do
		eventCount = eventCount + 1

		local targetItem = self._specialDescItemList[pos]
		local pointItem = self:getUpdatePointItem()
		local oneFixFlow = self:buildOneUpdatePointMoveFlow(targetItem, eventCount, pointItem)

		moveFlow:addWork(oneFixFlow)
	end

	return moveFlow
end

function Rouge2_AlchemySuccessView:buildOneUpdatePointMoveFlow(targetItem, eventCount, pointItem)
	local moveFlow = FlowSequence.New()
	local targetPosX, targetPosY = recthelper.rectToRelativeAnchorPos2(targetItem.icon.transform.position, pointItem.go.transform)
	local params = {
		type = "DOAnchorPos",
		ease = "easeOutQuint",
		tr = pointItem.go.transform,
		tox = targetPosX,
		toy = targetPosY,
		t = UpdatePointMoveDuration
	}
	local waitSec = (eventCount - 1) * WaitSec2MoveOtherValue

	moveFlow:addWork(WorkWaitSeconds.New(waitSec + waitShowTime))

	local moveWork = TweenWork.New(params)

	moveFlow:addWork(FunctionWork.New(self.setUpdatePointItemActive, self, {
		pointItem,
		true
	}))
	moveFlow:addWork(moveWork)
	moveFlow:addWork(WorkWaitSeconds.New(UpdatePointFadeTime))
	moveFlow:addWork(TweenWork.New({
		from = 1,
		type = "DOFadeCanvasGroup",
		to = 0,
		t = UpdatePointFadeTime - UpdatePointMoveDuration,
		go = pointItem.go
	}))
	moveFlow:addWork(WorkWaitSeconds.New(UpdatePointFadeTime - UpdatePointMoveDuration))
	moveFlow:addWork(FunctionWork.New(self.returnUpdatePointItem, self, {
		pointItem,
		targetItem
	}))

	return moveFlow
end

function Rouge2_AlchemySuccessView:setUpdatePointItemActive(param)
	local item = param[1]
	local active = param[2]

	gohelper.setActive(item.go, active)
end

function Rouge2_AlchemySuccessView:returnUpdatePointItem(param)
	local item = param[1]
	local targetItem = param[2]

	table.insert(self._unuseUpdatePointItemList, item.go)
	gohelper.setActive(item.go, false)
	gohelper.setActive(targetItem.icon, true)
	targetItem.animator:Play("light", 0, 0)
end

function Rouge2_AlchemySuccessView:getUpdatePointItem()
	local item

	if not self._unuseUpdatePointItemList[1] then
		local itemGo = gohelper.cloneInPlace(self._updatePointIcon)

		item = {
			go = itemGo
		}
	else
		item = table.remove(self._unuseUpdatePointItemList, #self._unuseUpdatePointItemList)
	end

	gohelper.setActive(item.go, false)

	return item
end

function Rouge2_AlchemySuccessView:playUpdatePointAnim()
	if not self.spEventNum or self.spEventNum <= 0 then
		return
	end

	self:destroyFlow()

	self._flow = FlowSequence.New()

	self._flow:addWork(WorkWaitSeconds.New(waitShowTime))
	self._flow:addWork(self:buildUpdatePointMoveFlow())
	self._flow:registerDoneListener(self.onFlowDone, self)
	self._flow:start()
end

function Rouge2_AlchemySuccessView:destroyFlow()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

function Rouge2_AlchemySuccessView:refreshSingleDesc(effectList, isMain, updatePosDic)
	if effectList then
		if not #effectList then
			local effectCount = 0
			local isEmpty = effectCount == 0

			if not isMain then
				gohelper.setActive(self._goempty, isEmpty)
			end

			for index, effect in ipairs(effectList) do
				local item = self:getDescContent(index, isMain)
				local effectConfig = Rouge2_CollectionConfig.instance:getRelicsConfig(effect)

				item.text.text = effectConfig.desc

				item.animator:Play("idle", 0, 0)
			end

			self:hideUnUseDescItem(isMain, effectCount)
		end
	end
end

function Rouge2_AlchemySuccessView:getDescContent(index, isMain)
	if isMain then
		if not self._mainDescItemList then
			local itemList = self._specialDescItemList
			local item = itemList[index]

			if not item then
				item = self:createItem(index, isMain)

				table.insert(itemList, item)
			end

			gohelper.setActive(item.go, true)

			return item
		end
	end
end

function Rouge2_AlchemySuccessView:createItem(index, isMain)
	if isMain then
		if not self._goTextDesc then
			local needCloneGo = self._goTextDescSpecial
			local itemGo = gohelper.cloneInPlace(needCloneGo, tostring(index))
			local item = self:getUserDataTb_()

			item.go = itemGo
			item.text = gohelper.findChildTextMesh(itemGo, "")
			item.icon = gohelper.findChild(itemGo, "icon")
			item.imgEffect = gohelper.findChild(itemGo, "img_eff")
			item.animator = gohelper.findChildComponent(itemGo, "", gohelper.Type_Animator)

			return item
		end
	end
end

function Rouge2_AlchemySuccessView:hideUnUseDescItem(isMain, showCount)
	if isMain then
		if not self._mainDescItemList then
			local itemList = self._specialDescItemList
			local itemCount = #itemList

			if showCount < itemCount then
				for i = showCount + 1, itemCount do
					local item = itemList[i]

					gohelper.setActive(item.go, false)
				end
			end
		end
	end
end

function Rouge2_AlchemySuccessView:onAlchemyCancel()
	self:closeThis()
	Rouge2_OutsideController.instance:openAlchemyView(true)
end

function Rouge2_AlchemySuccessView:onClose()
	return
end

function Rouge2_AlchemySuccessView:onDestroyView()
	return
end

return Rouge2_AlchemySuccessView
