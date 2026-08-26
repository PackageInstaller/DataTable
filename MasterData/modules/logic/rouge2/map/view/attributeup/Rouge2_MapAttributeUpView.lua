-- chunkname: @modules/logic/rouge2/map/view/attributeup/Rouge2_MapAttributeUpView.lua

module("modules.logic.rouge2.map.view.attributeup.Rouge2_MapAttributeUpView", package.seeall)

local Rouge2_MapAttributeUpView = class("Rouge2_MapAttributeUpView", BaseView)
local DefalutSelectIndex = 1
local AddAttributeDuration = 1
local SpecialAddAttrDuration = 3
local DelayPlayAttrUpAnim = 0.1
local PercentColor = "#FFA854"
local BracketColor = "#8CA7FF"

function Rouge2_MapAttributeUpView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._goAttributeMapPos = gohelper.findChild(self.viewGO, "#go_Root/#go_AttributeMapPos")
	self._goContainer = gohelper.findChild(self.viewGO, "#go_Root/#go_Container")
	self._goBase = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/Base")
	self._imageAttributeIcon = gohelper.findChildImage(self.viewGO, "#go_Root/#go_Container/Base/#image_AttributeIcon")
	self._txtAttributeName = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#txt_AttributeName")
	self._txtCurAttribute = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#txt_CurAttribute")
	self._goArrow = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/Base/#go_Arrow")
	self._txtNextAttribute = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#txt_NextAttribute")
	self._goToast = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/Base/#go_Toast")
	self._txtCurAttribute2 = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#go_Toast/#txt_CurAttribute")
	self._txtNextAttribute2 = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#go_Toast/#txt_NextAttribute")
	self._goSkillDescList = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/#scroll_Preview/Viewport/Content/#go_SkillDescList")
	self._goSkillDescItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/#scroll_Preview/Viewport/Content/#go_SkillDescList/#go_SkillDescItem")
	self._goEmptySkillDesc = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/#scroll_Preview/Viewport/Content/#go_EmptySkillDesc")
	self._txtRemainAttribute = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Remain/#txt_RemainAttribute")
	self._goRemain = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/Remain")
	self._btnAdd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#go_Container/Remain/#btn_Add", AudioEnum.Rouge2.AddAttr)
	self._imageAttributeIcon2 = gohelper.findChildImage(self.viewGO, "#go_Root/#go_Container/Remain/#btn_Add/#image_AttributeIcon")
	self._txtUp = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Remain/#btn_Add/#txt_Up")
	self._goPassiveSkill = gohelper.findChild(self.viewGO, "#go_Root/#go_PassiveSkill")
	self._txtPassiveDesc = gohelper.findChildText(self.viewGO, "#go_Root/#go_PassiveSkill/#txt_PassiveDesc")
	self._goToastContainer = gohelper.findChild(self.viewGO, "#go_Root/#go_ToastContainer")
	self._goBigToast = gohelper.findChild(self.viewGO, "#go_Root/#go_ToastContainer/#go_BigToast")
	self._txtBigToast = gohelper.findChildText(self.viewGO, "#go_Root/#go_ToastContainer/#go_BigToast/root/#txt_BigToast")
	self._goToastList = gohelper.findChild(self.viewGO, "#go_Root/#go_ToastContainer/#go_ToastList")
	self._goToastItem = gohelper.findChild(self.viewGO, "#go_Root/#go_ToastContainer/#go_ToastList/#go_ToastItem")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Close")
	self._goBlock = gohelper.findChild(self.viewGO, "#go_Root/#go_Block")
	self._goEffectTips = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/Base/#go_effectTips")
	self._txtEffect = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/Base/#go_effectTips/#txt_effect")
	self._scrollRelics = gohelper.findChildScrollRect(self.viewGO, "#go_Root/#go_Container/#scroll_Preview/Viewport/Content/#scroll_Relics")
	self._goRelicsList = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/#scroll_Preview/Viewport/Content/#scroll_Relics/Viewport/Content")
	self._goRelicsItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/#scroll_Preview/Viewport/Content/#scroll_Relics/Viewport/Content/#go_RelicsItem")
	self._btnRelicsTips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#go_Container/#scroll_Preview/Viewport/Content/#scroll_Relics/Viewport")
	self._btnSkip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#go_PassiveSkill/#btn_Skip")
	self._txtSpLevel = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/#scroll_Preview/Viewport/Content/txt_SpLevel")
	self._goToolbar = gohelper.findChild(self.viewGO, "#go_Root/#go_Toolbar")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapAttributeUpView:addEvents()
	self._btnAdd:AddClickListener(self._btnAddOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnSkip:AddClickListener(self._btnSkipOnClick, self)
	self._btnRelicsTips:AddClickListener(self._btnRelicsTipsOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateMapInfo, self._onUpdateAttrInfo, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateAttrInfo, self._onUpdateAttrInfo, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnSelectCareerAttribute, self._onSelectCareerAttribute, self)
end

function Rouge2_MapAttributeUpView:removeEvents()
	self._btnAdd:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnSkip:RemoveClickListener()
	self._btnRelicsTips:RemoveClickListener()
end

function Rouge2_MapAttributeUpView:_btnAddOnClick()
	if not self._addAttrPoint or self._addAttrPoint <= 0 or not self._selectAttrId then
		return
	end

	if self._isMax then
		GameFacade.showToast(ToastEnum.Rouge2MaxAttr)

		return
	end

	self._isPlayingLightAnim = true

	self._remainAnimator:Play("light", self._onLightAnimDone, self)

	self._waitRpc = true

	Rouge2_Rpc.instance:sendRouge2AddCareerAttrPointRequest(self._selectAttrId, Rouge2_MapEnum.AddAttrStep, function(__, resultCode)
		if resultCode ~= 0 then
			self:closeThis()

			return
		end

		self._waitRpc = false

		self:_onUpdateAttributeInfo()
	end)
end

function Rouge2_MapAttributeUpView:_onLightAnimDone()
	self._isPlayingLightAnim = false

	self:refreshFreeUI()
end

function Rouge2_MapAttributeUpView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_MapAttributeUpView:_btnSkipOnClick()
	self:_skipPassiveSkill(false)
	self._skillAnimator:Play("close", self._onPassiveSkillCloseAnimDone, self)
end

function Rouge2_MapAttributeUpView:_btnRelicsTipsOnClick()
	if not self._hasRelicsIdList or #self._hasRelicsIdList <= 0 then
		return
	end

	Rouge2_ViewHelper.openItemTipsView(Rouge2_Enum.ItemDataType.Config, self._hasRelicsIdList)
end

function Rouge2_MapAttributeUpView:_onPassiveSkillCloseAnimDone()
	gohelper.setActive(self._goPassiveSkill, false)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSkilPassiveSkillTips)
end

function Rouge2_MapAttributeUpView:_skipPassiveSkill(isSkip)
	gohelper.setActive(self._btnSkip.gameObject, isSkip)
end

function Rouge2_MapAttributeUpView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.blockEsc)
	Rouge2_AttributeToolBar.Load(self._goToolbar, Rouge2_Enum.AttributeToolType.Skill_Detail)

	local goAttributeMap = self:getResInst(Rouge2_Enum.ResPath.AttributeMap, self._goAttributeMapPos)

	self._comAttrMap = Rouge2_CareerAttributeMap.Get(goAttributeMap, Rouge2_Enum.AttrMapUsage.MapAttributeUpView)

	self._comAttrMap:setCanClickDetail(false)

	self._remainAnimator = SLFramework.AnimatorPlayer.Get(self._goRemain)
	self._skillAnimator = SLFramework.AnimatorPlayer.Get(self._goPassiveSkill)
	self._lvAnimator = gohelper.onceAddComponent(self._goBase, gohelper.Type_Animator)
	self._addAttrPoint = 0
	self._first = true
	self._relicsIconTab = self:getUserDataTb_()

	gohelper.setActive(self._goBlock, false)
	gohelper.setActive(self._goPassiveSkill, false)
	gohelper.setActive(self._goToastContainer, false)
	gohelper.setActive(self._btnClose.gameObject, false)
	SkillHelper.addHyperLinkClick(self._txtEffect)
	NavigateMgr.instance:removeEscape(self.viewName)
	self:initCustomAttrList()
end

function Rouge2_MapAttributeUpView:onUpdateParam()
	return
end

function Rouge2_MapAttributeUpView:onOpen()
	self._careerId = Rouge2_Model.instance:getCareerId()

	self:initInfo()
	self:refreshUI()
end

function Rouge2_MapAttributeUpView:onOpenFinish()
	self:buildAttrUpFlow()
end

function Rouge2_MapAttributeUpView:initInfo()
	self:initAddAttrPoint()
	self:initCustomAttrValue()
	self:initAttrMap()
end

function Rouge2_MapAttributeUpView:initAddAttrPoint()
	self._addAttrPoint = Rouge2_MapAttrUpdateController.instance:getAddAttrPoint()
end

function Rouge2_MapAttributeUpView:initCustomAttrList()
	local curAttrList = Rouge2_Model.instance:getHeroAttrInfoList()

	self._customAttrList = {}
	self._customAttrMap = {}

	for _, attributeMo in ipairs(curAttrList) do
		local customAttrMo = tabletool.copy(attributeMo)
		local attrId = customAttrMo.attrId

		self._customAttrMap[attrId] = customAttrMo

		table.insert(self._customAttrList, customAttrMo)
	end
end

function Rouge2_MapAttributeUpView:initCustomAttrValue()
	local updateAttrMap = Rouge2_MapAttrUpdateController.instance:getUpdateAttrMap() or {}

	self._updateAttrMap = tabletool.copy(updateAttrMap)
	self._show = self._addAttrPoint > 0
	self._hasUpdateAttr = false

	for attrId, updateValue in pairs(self._updateAttrMap) do
		if self._customAttrMap[attrId] then
			local customAttrValue = self._customAttrMap[attrId].value

			self._customAttrMap[attrId].value = customAttrValue - updateValue
			self._hasUpdateAttr = self._hasUpdateAttr or updateValue > 0
			self._show = self._show or self._hasUpdateAttr
		end
	end

	Rouge2_MapAttrUpdateController.instance:clearUpdateAttrMap()
end

function Rouge2_MapAttributeUpView:initAttrMap()
	self._comAttrMap:onUpdateMO(self._careerId, Rouge2_Enum.AttributeData.Custom, self._customAttrList)

	if not self._comAttrMap:getCurSelectAttrId() then
		self._comAttrMap:selectAttribute(DefalutSelectIndex)
	end

	for _, attrMo in ipairs(self._customAttrList) do
		if not self._updateAttrMap[attrMo.attrId] then
			if self._updateAttrMap[attrMo.attrId] ~= 0 then
				self._comAttrMap:selectAttributeById(attrMo.attrId)

				break
			end
		end
	end
end

function Rouge2_MapAttributeUpView:buildAttrUpFlow()
	self:_lockScreen(false)

	if not self._show then
		gohelper.setActive(self._btnClose.gameObject, true)
		NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
		self:destroyFlow()

		return
	end

	if not self._hasUpdateAttr then
		return
	end

	self:destroyFlow()
	self:_lockScreen(true)
	gohelper.setActive(self._btnClose.gameObject, false)

	self._flow = FlowSequence.New()

	self._flow:addWork(FunctionWork.New(self._lockScreen, self, true))
	self._flow:addWork(WorkWaitSeconds.New((self._first or nil) and (DelayPlayAttrUpAnim or 0)))

	for _, attrMo in ipairs(self._customAttrList) do
		self:_buildUpAttributeFlow(self._flow, attrMo)
	end

	self._flow:addWork(FunctionWork.New(self._lockScreen, self, false))
	self._flow:registerDoneListener(self._onAttrUpFlowDone, self)
	self._flow:start()

	self._first = false
end

function Rouge2_MapAttributeUpView:_buildUpAttributeFlow(flow, customAttrMo)
	local attrId = customAttrMo.attrId

	if not self._updateAttrMap[attrId] then
		local update = 0

		if update == 0 then
			return
		end

		if not customAttrMo.value then
			local from = 0
			local to = from + update

			for i = from + 1, to do
				local skillCo = Rouge2_AttributeConfig.instance:getCareerPassiveSkill(self._careerId, self._selectAttrId, i)
				local isSpecial = skillCo and skillCo.isSpecial ~= 0
				local var_22_2 = {
					type = "DOTweenFloat",
					from = i - 1,
					to = i
				}

				if isSpecial then
					var_22_2.t = SpecialAddAttrDuration or AddAttributeDuration
				end

				var_22_2.frameCb = self._attrValueFrameCallback
				var_22_2.cbObj = self
				var_22_2.param = attrId

				local params = var_22_2
				local parallel = FlowParallel.New()
				local stepFlow = FlowSequence.New()

				parallel:addWork(stepFlow)
				stepFlow:addWork(FunctionWork.New(self._comAttrMap.selectAttributeById, self._comAttrMap, attrId))
				stepFlow:addWork(TweenWork.New(params))

				if isSpecial then
					parallel:addWork(WaitEventWork.New("Rouge2_MapController;Rouge2_MapEvent;onSkilPassiveSkillTips"))
				end

				stepFlow:addWork(FunctionWork.New(self._hideAllToast, self))
				flow:addWork(parallel)
			end
		end
	end
end

function Rouge2_MapAttributeUpView:_attrValueFrameCallback(value, attrId)
	local resultValue = math.ceil(value)
	local curAttrValue = self._customAttrMap[attrId].value

	if not curAttrValue or curAttrValue == resultValue then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Rouge2.AttrUp)

	self._customAttrMap[attrId].value = resultValue

	self._comAttrMap:onUpdateMO(self._careerId, Rouge2_Enum.AttributeData.Custom, self._customAttrList)
	self:updateSelectInfo()
	self:checkPassiveSkill()
	self:checkLevelupToast()
	self:refreshUI()
end

function Rouge2_MapAttributeUpView:_onAttrUpFlowDone()
	self._hasUpdateAttr = false
	self._updateAttrMap = {}

	gohelper.setActive(self._btnClose.gameObject, self._addAttrPoint <= 0)
	self:_hideAllToast()
	self:_onUpdateAttributeInfo()
end

function Rouge2_MapAttributeUpView:_hideAllToast()
	gohelper.setActive(self._goToastContainer, false)
end

function Rouge2_MapAttributeUpView:destroyFlow()
	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

function Rouge2_MapAttributeUpView:_onSelectCareerAttribute(attrId)
	self._selectAttrId = attrId

	self:updateSelectInfo()
	self:refreshUI()
end

function Rouge2_MapAttributeUpView:refreshUI()
	self:refreshSelectUI()
	self:refreshFreeUI()
end

function Rouge2_MapAttributeUpView:updateSelectInfo()
	if not self._selectAttrId or not self._customAttrMap[self._selectAttrId] then
		return
	end

	self._selectAttrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(self._selectAttrId)
	self._minAttrValue, self._maxAttrValue = Rouge2_BackpackController.instance:getAttrValueRange(nil, self._selectAttrId)

	if self._customAttrMap then
		self._curAttrValue = self._customAttrMap[self._selectAttrId].value or 0
	end

	self._nextAttrValue = self._curAttrValue + Rouge2_MapEnum.AddAttrStep
	self._isMax = self._curAttrValue >= self._maxAttrValue
	self._selectPassiveSkillCo = Rouge2_AttributeConfig.instance:getCareerPassiveSkill(self._careerId, self._selectAttrId, self._curAttrValue)

	if self._selectAttrCo then
		self._selectAttrName = self._selectAttrCo.name or ""
	end
end

function Rouge2_MapAttributeUpView:refreshSelectUI()
	gohelper.setActive(self._goContainer, self._selectAttrId and self._selectAttrId ~= 0)

	if not self._selectAttrId then
		return
	end

	self._txtAttributeName.text = self._selectAttrName
	self._txtCurAttribute.text = self._curAttrValue
	self._txtCurAttribute2.text = self._curAttrValue - 1
	self._txtNextAttribute.text = self._isMax and "MAX" or self._nextAttrValue
	self._txtNextAttribute2.text = self._curAttrValue

	if self._selectPassiveSkillCo then
		local skillName = self._selectPassiveSkillCo.name
		local skillNameResult = Rouge2_ItemExpressionHelper.getDescResult(nil, nil, skillName)

		Rouge2_ItemDescHelper.buildAndSetDesc(self._txtEffect, skillNameResult, PercentColor, BracketColor)
		gohelper.setActive(self._goArrow, not self._isMax and self._addAttrPoint > 0)
		gohelper.setActive(self._txtNextAttribute.gameObject, self._isMax or self._addAttrPoint > 0)
		Rouge2_AttrDropDescHelper.loadAttrDropLevelList(self._careerId, self._selectAttrId, self._txtSpLevel, false)

		self._attrDropList = Rouge2_AttributeConfig.instance:getLimitAttrDropList(self._careerId, self._selectAttrId) or {}

		if self._attrDropList then
			self._attrDropNum = #self._attrDropList or 0
		end

		gohelper.setActive(self._goEmptySkillDesc, self._attrDropNum <= 0)
		gohelper.setActive(self._goSkillDescList, self._attrDropNum > 0)

		if self._attrDropNum > 0 then
			gohelper.CreateObjList(self, self._refreshAttrDropItem, self._attrDropList, self._goSkillDescList, self._goSkillDescItem)
		end

		Rouge2_IconHelper.setAttributeIcon(self._selectAttrId, self._imageAttributeIcon)
		Rouge2_IconHelper.setAttributeIcon(self._selectAttrId, self._imageAttributeIcon2)
		self:refreshRelicsList()
	end
end

function Rouge2_MapAttributeUpView:_refreshAttrDropItem(obj, attrDropCo, index)
	Rouge2_AttrDropDescHelper.LoadAttrDropDesc(attrDropCo.id, obj, PercentColor, BracketColor)
end

function Rouge2_MapAttributeUpView:refreshFreeUI()
	gohelper.setActive(self._goRemain, self._addAttrPoint > 0 or self._isPlayingLightAnim)

	self._txtRemainAttribute.text = self._addAttrPoint
	self._txtUp.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_attributeupview_up"), Rouge2_MapEnum.AddAttrStep)
end

function Rouge2_MapAttributeUpView:refreshRelicsList()
	local relicsList = Rouge2_CollectionConfig.instance:getAttrUpdateRelicsList(self._selectAttrId, self._curAttrValue)

	self._hasRelcisList = {}
	self._hasRelicsIdList = {}

	if relicsList then
		for _, relicsInfo in ipairs(relicsList) do
			local relicsCo = relicsInfo.config
			local relicsId = relicsCo and relicsCo.id
			local itemList = Rouge2_BackpackModel.instance:getItemListByItemId(relicsId)

			if itemList and #itemList > 0 then
				table.insert(self._hasRelcisList, relicsInfo)
				table.insert(self._hasRelicsIdList, relicsId)
			end
		end
	end

	if self._hasRelcisList then
		if not #self._hasRelcisList then
			local relicsNum = 0

			gohelper.setActive(self._scrollRelics.gameObject, relicsNum > 0)

			if relicsNum <= 0 then
				return
			end

			gohelper.CreateObjList(self, self._refreshRelicsItem, self._hasRelcisList, self._goRelicsList, self._goRelicsItem)
		end
	end
end

function Rouge2_MapAttributeUpView:_refreshRelicsItem(obj, relicsInfo, index)
	local imageRare = gohelper.findChildImage(obj, "#image_rare")
	local simageIcon = gohelper.findChildSingleImage(obj, "#simage_icon")
	local txtNum1 = gohelper.findChildText(obj, "#txt_num1")
	local txtNum2 = gohelper.findChildText(obj, "#txt_num2")
	local relicsCo = relicsInfo.config
	local relicsId = relicsCo and relicsCo.id

	txtNum1.text = self._curAttrValue
	txtNum2.text = relicsInfo.attrValue

	Rouge2_IconHelper.setRelicsRareIcon(relicsId, imageRare)
	Rouge2_IconHelper.setRelicsIcon(relicsId, simageIcon)

	self._relicsIconTab[index] = simageIcon
end

function Rouge2_MapAttributeUpView:checkLevelupToast()
	if self._selectPassiveSkillCo then
		local levelUpDesc = self._selectPassiveSkillCo.levelUpDesc
		local hasDesc = not string.nilorempty(levelUpDesc)

		gohelper.setActive(self._goToastContainer, hasDesc)

		if not hasDesc then
			return
		end

		local descList = string.split(levelUpDesc, "|")
		local bigDesc = descList and descList[1]
		local hasBigToast = not string.nilorempty(bigDesc)

		gohelper.setActive(self._goBigToast, hasBigToast)

		if hasBigToast then
			self._txtBigToast.text = bigDesc
		end

		local smallDescList = {}

		for i = 2, descList and #descList do
			table.insert(smallDescList, descList[i])
		end

		gohelper.CreateObjList(self, self._refreshLevelUpDesc, smallDescList, self._goToastList, self._goToastItem)
	end
end

function Rouge2_MapAttributeUpView:_refreshLevelUpDesc(obj, desc, index)
	local txtToast = gohelper.findChildText(obj, "root/txt_Toast")

	txtToast.text = desc
end

function Rouge2_MapAttributeUpView:checkPassiveSkill()
	if self._selectPassiveSkillCo then
		local isSpecial = self._selectPassiveSkillCo.isSpecial ~= 0

		self._lvAnimator:Play("lvup", 0, 0)
		gohelper.setActive(self._goPassiveSkill, isSpecial)

		if not isSpecial then
			return
		end

		self:_skipPassiveSkill(false)
		self._skillAnimator:Play("open", self._onPassiveSkillOpenAnimDone, self)
		AudioMgr.instance:trigger(AudioEnum.Rouge2.FeatureUp)

		local levelUpDesc = Rouge2_AttributeConfig.instance:getPassiveSkillImLevelUpDesc(self._selectPassiveSkillCo.id, self._selectPassiveSkillCo.level)

		self._txtPassiveDesc.text = Rouge2_ItemDescHelper.buildDesc(levelUpDesc, PercentColor, BracketColor)
	end
end

function Rouge2_MapAttributeUpView:_onPassiveSkillOpenAnimDone()
	self:_skipPassiveSkill(true)
end

function Rouge2_MapAttributeUpView:_onUpdateAttrInfo()
	self:_onUpdateAttributeInfo()
end

function Rouge2_MapAttributeUpView:_onUpdateAttributeInfo()
	if self._waitRpc or self._flow and self._flow.status == WorkStatus.Running or self._hasUpdateAttr then
		return
	end

	self:initAddAttrPoint()
	self:initCustomAttrList()
	self:initCustomAttrValue()
	self:buildAttrUpFlow()
	self:updateSelectInfo()
	self:refreshUI()
end

function Rouge2_MapAttributeUpView:_lockScreen(lock)
	gohelper.setActive(self._goBlock, lock)
end

function Rouge2_MapAttributeUpView:onClose()
	self:_lockScreen(false)
	self:destroyFlow()

	if self._relicsIconTab then
		for _, relcisIcon in pairs(self._relicsIconTab) do
			relcisIcon:UnLoadImage()
		end
	end
end

function Rouge2_MapAttributeUpView:onDestroyView()
	return
end

return Rouge2_MapAttributeUpView
