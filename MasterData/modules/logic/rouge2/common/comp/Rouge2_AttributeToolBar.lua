-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttributeToolBar.lua

module("modules.logic.rouge2.common.comp.Rouge2_AttributeToolBar", package.seeall)

local Rouge2_AttributeToolBar = class("Rouge2_AttributeToolBar", LuaCompBase)

function Rouge2_AttributeToolBar.Load(go, showType)
	showType = showType or Rouge2_Enum.AttributeToolType.Default

	if gohelper.isNil(go) then
		logError("Rouge2_AttributeToolBar.Load error !!! go is nil")

		return
	end

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_AttributeToolBar, showType)
end

function Rouge2_AttributeToolBar:ctor(showType)
	self._showType = showType
	self._paramMap = {}
	self._isInitDone = false
end

function Rouge2_AttributeToolBar:init(go)
	self._loader = PrefabInstantiate.Create(go)

	self._loader:startLoad(Rouge2_Enum.ResPath.AttrToolBar, self._onLoadToolBarDone, self)
end

function Rouge2_AttributeToolBar:_onLoadToolBarDone(loader)
	self._isInitDone = true

	self:initAttrToolbar(loader:getInstGO())
	self:addToolbarEventListeners()
end

function Rouge2_AttributeToolBar:removeEventListeners()
	if self._isInitDone then
		self:removeToolbarEventListeners()
	end
end

function Rouge2_AttributeToolBar:initAttrToolbar(go)
	self.go = go
	self._goRoot = gohelper.findChild(self.go, "#go_Root")
	self._goBackpack = gohelper.findChild(self.go, "#go_Root/#go_Backpack")
	self._btnBackpack = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#go_Backpack/#btn_Backpack", AudioEnum.Rouge2.OpenBag)
	self._imageBackpack = gohelper.findChildImage(self.go, "#go_Root/#go_Backpack/#btn_Backpack")
	self._txtBackpack = gohelper.findChildText(self.go, "#go_Root/#go_Backpack/#btn_Backpack/#txt_name")
	self._goRecommend = gohelper.findChild(self.go, "#go_Root/#go_Backpack/#btn_Backpack/#txt_name/#go_recommend")
	self._goRecommendAttr = gohelper.findChild(self.go, "#go_Root/#go_Backpack/#btn_Backpack/#go_RecommendAttr")
	self._goAttrItem = gohelper.findChild(self.go, "#go_Root/#go_Backpack/#btn_Backpack/#go_RecommendAttr/#go_AttrItem")
	self._goBackpackReddot = gohelper.findChild(self.go, "#go_Root/#go_Backpack/#go_Reddot")
	self._goBackpackTips = gohelper.findChild(self.go, "#go_Root/#go_Backpack/tips")
	self._goTalentTips = gohelper.findChild(self.go, "#go_Root/#go_Backpack/tips/bubble/#go_TalentTips")
	self._btnBackpackTips = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#go_Backpack/tips/bubble/#btn_Tips")
	self._goAttributeContainer = gohelper.findChild(self.go, "#go_Root/#go_AttributeContainer")
	self._goAttributeList = gohelper.findChild(self.go, "#go_Root/#go_AttributeContainer/#go_AttributeList")
	self._goAttributeItem = gohelper.findChild(self.go, "#go_Root/#go_AttributeContainer/#go_AttributeList/#go_AttributeItem")
	self._goSearch = gohelper.findChild(self.go, "#go_Root/#go_Search")
	self._btnSearch = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#go_Search/#btn_Search", AudioEnum.Rouge2.OpenAttrDetail)
	self._goSkillContainer = gohelper.findChild(self.go, "#go_Root/#go_SkillContainer")
	self._goSkillList = gohelper.findChild(self.go, "#go_Root/#go_SkillContainer/#go_SkillList")
	self._goSkillItem = gohelper.findChild(self.go, "#go_Root/#go_SkillContainer/#go_SkillList/#go_SkillItem")

	local reddotList = {}

	for _, reddotId in pairs(Rouge2_Enum.BagTabType2Reddot) do
		table.insert(reddotList, {
			id = reddotId
		})
	end

	RedDotController.instance:addMultiRedDot(self._goBackpackReddot, reddotList)
	self:refreshUI()
end

function Rouge2_AttributeToolBar:reset()
	gohelper.setActive(self._goBackpack, false)
	gohelper.setActive(self._goAttributeContainer, false)
	gohelper.setActive(self._goSkillContainer, false)
	gohelper.setActive(self._goSearch, false)
end

function Rouge2_AttributeToolBar:addToolbarEventListeners()
	self._btnBackpack:AddClickListener(self._btnBackpackOnClick, self)
	self._btnSearch:AddClickListener(self._btnSearchOnClick, self)
	self._btnBackpackTips:AddClickListener(self._btnBackpackTipsOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateBagInfo, self._onUpdateBagInfo, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateActiveSkillInfo, self._onUpdateActiveSkillInfo, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateAttrInfo, self._onUpdateAttrInfo, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateRougeInfo, self._onUpdateAttrInfo, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateMapInfo, self._onUpdateAttrInfo, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateTeamSystem, self._onUpdateTeamSystem, self)
end

function Rouge2_AttributeToolBar:removeToolbarEventListeners()
	self._btnBackpack:RemoveClickListener()
	self._btnSearch:RemoveClickListener()
	self._btnBackpackTips:RemoveClickListener()
end

function Rouge2_AttributeToolBar:_btnBackpackOnClick()
	Rouge2_ViewHelper.openBackpackTabView(Rouge2_Enum.BagTabType.Career)
end

function Rouge2_AttributeToolBar:_btnSearchOnClick()
	Rouge2_ViewHelper.openAttributeDetailView()
end

function Rouge2_AttributeToolBar:_btnBackpackTipsOnClick()
	Rouge2_ViewHelper.openBackpackTabView(Rouge2_Enum.BagTabType.ActiveSkill)
end

function Rouge2_AttributeToolBar:refreshAttrList()
	gohelper.setActive(self._goAttributeContainer, true)

	local attributeList = Rouge2_Model.instance:getHeroAttrInfoList() or {}

	gohelper.CreateObjList(self, self._refreshSingleAttribute, attributeList, self._goAttributeList, self._goAttributeItem, Rouge2_AttributeToolBarItem)
end

function Rouge2_AttributeToolBar:_refreshSingleAttribute(toolBarItem, attributeMo, index)
	local careerId = Rouge2_Model.instance:getCareerId()

	toolBarItem:refresh(index, careerId, attributeMo)
end

function Rouge2_AttributeToolBar:refreshUI()
	if not self._isInitDone or not Rouge2_Model.instance:getRougeInfo() then
		return
	end

	self:reset()

	local refreshFunc = self:_getRefreshUIFunc(self._showType)

	if refreshFunc then
		refreshFunc(self)
	end
end

function Rouge2_AttributeToolBar:_getRefreshUIFunc(showType)
	if not self._showTypeFunc then
		self._showTypeFunc = {}
		self._showTypeFunc[Rouge2_Enum.AttributeToolType.Default] = self._refresh_Default
		self._showTypeFunc[Rouge2_Enum.AttributeToolType.Enter_Attr] = self._refresh_Enter_Attr
		self._showTypeFunc[Rouge2_Enum.AttributeToolType.Enter_Attr_Detail] = self._refresh_Enter_Attr_Detail
		self._showTypeFunc[Rouge2_Enum.AttributeToolType.Attr_Detail] = self._refresh_Attr_Detail
		self._showTypeFunc[Rouge2_Enum.AttributeToolType.Enter] = self._refresh_Enter
		self._showTypeFunc[Rouge2_Enum.AttributeToolType.Enter_Skill_Detail] = self._refresh_Enter_Skill_Detail
		self._showTypeFunc[Rouge2_Enum.AttributeToolType.Skill_Detail] = self._refresh_Skill_Detail
	end

	return self._showTypeFunc[showType]
end

function Rouge2_AttributeToolBar:_refresh_Default()
	self:refreshAttrList()
end

function Rouge2_AttributeToolBar:_refresh_Enter_Attr()
	self:refreshAttrList()
	self:refreshBagEntranceIcon()
end

function Rouge2_AttributeToolBar:_refresh_Enter_Attr_Detail()
	gohelper.setActive(self._goSearch, true)
	self:refreshAttrList()
	self:refreshBagEntranceIcon()
end

function Rouge2_AttributeToolBar:_refresh_Attr_Detail()
	gohelper.setActive(self._goSearch, true)
	self:refreshAttrList()
end

function Rouge2_AttributeToolBar:_refresh_Enter()
	self:refreshBagEntranceIcon()
end

function Rouge2_AttributeToolBar:_refresh_Enter_Skill_Detail()
	self:refreshBagEntranceIcon()

	local isShowBar = self:refreshActiveSkillList()

	gohelper.setActive(self._goSearch, isShowBar)
end

function Rouge2_AttributeToolBar:_refresh_Skill_Detail()
	local isShowBar = self:refreshActiveSkillList()

	gohelper.setActive(self._goSearch, isShowBar)
end

function Rouge2_AttributeToolBar:refreshBagEntranceIcon()
	gohelper.setActive(self._goBackpack, true)

	local careerId = Rouge2_Model.instance:getCareerId()
	local careerCo = Rouge2_CareerConfig.instance:getCareerConfig(careerId)
	local bagEntranceIcon = careerCo and careerCo.bagEntranceIcon

	UISpriteSetMgr.instance:setRouge6Sprite(self._imageBackpack, bagEntranceIcon)
	self:refreshBackpackName()
	self:refreshBackpackTips()
end

function Rouge2_AttributeToolBar:refreshBackpackName()
	local battleTagCo = Rouge2_Model.instance:getCurBattleConfig()

	if battleTagCo then
		if battleTagCo then
			if not battleTagCo.tagName then
				local tagName = ""

				self._txtBackpack.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_attributetoolbar_system"), tagName)
			end
		end
	else
		self._txtBackpack.text = luaLang("p_rouge2_attributetoolbar_txt_name")
	end

	local isRecommend = battleTagCo ~= nil

	gohelper.setActive(self._goRecommend, isRecommend)
	gohelper.setActive(self._goRecommendAttr, isRecommend)

	if not isRecommend then
		return
	end

	local systemId = Rouge2_Model.instance:getCurTeamSystemId()
	local attrIdList = Rouge2_CareerConfig.instance:getSystemRecommendAttrList(systemId) or {}

	gohelper.CreateObjList(self, self._refreshRecommendAttrItem, attrIdList, self._goRecommendAttr, self._goAttrItem)
end

function Rouge2_AttributeToolBar:_refreshRecommendAttrItem(goAttr, attrId, index)
	local imageIcon = gohelper.findChildImage(goAttr, "image_AttrIcon")

	Rouge2_IconHelper.setAttributeIcon(attrId, imageIcon, Rouge2_Enum.AttrIconSuffix.Small)
end

function Rouge2_AttributeToolBar:refreshBackpackTips()
	local hasAnyTalentCanActive = Rouge2_BackpackController.instance:hasAnyCanActiveTalent()

	gohelper.setActive(self._goBackpackTips, hasAnyTalentCanActive)

	if not hasAnyTalentCanActive then
		return
	end

	gohelper.setActive(self._goTalentTips, true)
end

function Rouge2_AttributeToolBar:refreshActiveSkillList()
	self._selectSkillIndex = self:getParam(Rouge2_Enum.AttrToolParam.SelectSkillIndex)
	self._isShowEmptySkill = self:getParam(Rouge2_Enum.AttrToolParam.IsShowEmptySkill)

	local isShowSkillBar = self._isShowEmptySkill

	if not self._isShowEmptySkill then
		self._skillList = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.ActiveSkill)

		if self._skillList then
			local hasAnySkill = #self._skillList > 0

			isShowSkillBar = hasAnySkill
		end
	end

	gohelper.setActive(self._goSkillContainer, isShowSkillBar)

	if isShowSkillBar then
		gohelper.CreateNumObjList(self._goSkillList, self._goSkillItem, Rouge2_Enum.MaxActiveSkillNum, self._refreshSkillItem, self)
	end

	return isShowSkillBar
end

function Rouge2_AttributeToolBar:_refreshSkillItem(goItem, index)
	local skillItem = Rouge2_AttrToolBarSkillItem.Get(goItem)

	if self._skillList then
		local skillMo = self._skillList[index]
		local dataType = Rouge2_Enum.ItemDataType.Server
		local dataId = skillMo and skillMo:getUid()

		skillItem:setShowEmptyUI(self._isShowEmptySkill)
		skillItem:onUpdateMO(index, dataType, dataId)
		skillItem:showLight(index == self._selectSkillIndex)
	end
end

function Rouge2_AttributeToolBar:_onUpdateAttrInfo()
	self:refreshUI()
end

function Rouge2_AttributeToolBar:_onUpdateActiveSkillInfo()
	self:refreshUI()
end

function Rouge2_AttributeToolBar:_onUpdateBagInfo()
	self:refreshUI()
end

function Rouge2_AttributeToolBar:_onUpdateTeamSystem()
	self:refreshUI()
end

function Rouge2_AttributeToolBar:getParam(key)
	return self._paramMap and self._paramMap[key]
end

function Rouge2_AttributeToolBar:setParam(key, value)
	if not key then
		return
	end

	self._paramMap[key] = value

	self:refreshUI()
end

function Rouge2_AttributeToolBar:changeShowType(newShowType)
	if self._showType == newShowType then
		return
	end

	self._showType = newShowType

	self:refreshUI()
end

function Rouge2_AttributeToolBar:onDestroy()
	return
end

return Rouge2_AttributeToolBar
