-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_TeamRecommendTips.lua

module("modules.logic.rouge2.common.comp.Rouge2_TeamRecommendTips", package.seeall)

local Rouge2_TeamRecommendTips = class("Rouge2_TeamRecommendTips", LuaCompBase)

Rouge2_TeamRecommendTips.Pivot_LeftCenter = Vector2(0, 0.5)
Rouge2_TeamRecommendTips.Pivot_MiddleCenter = Vector2(0.5, 0.5)

function Rouge2_TeamRecommendTips:ctor(loader)
	self._loader = loader
end

function Rouge2_TeamRecommendTips:init(go)
	self.go = go
	self._goRoot = gohelper.findChild(self.go, "#go_Root")
	self._simageTab = self:getUserDataTb_()

	self:_initTypeList()
	self:_initButtons()
end

function Rouge2_TeamRecommendTips:_initTypeList()
	self._goTypeTab = self:getUserDataTb_()

	for i = 1, math.huge do
		local goType = gohelper.findChild(self.go, "#go_Root/#go_Type" .. i)

		if gohelper.isNil(goType) then
			break
		end

		self._goTypeTab[i] = goType

		gohelper.setActive(goType, false)
	end
end

function Rouge2_TeamRecommendTips:_initButtons()
	self._btnDetail1 = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#go_Type1/go_Detail/#btn_Detail", AudioEnum.Rouge2.OpenAttrDetail)
	self._btnDetail2 = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#go_Type2/go_Title/title/#btn_Detail", AudioEnum.Rouge2.OpenAttrDetail)
	self._btnDetail3_1 = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#go_Type3/#go_Unselect/#btn_Detail", AudioEnum.Rouge2.OpenAttrDetail)
	self._btnDetail3_2 = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#go_Type3/#go_Select/#btn_Detail", AudioEnum.Rouge2.OpenAttrDetail)
	self._btnDetail8_1 = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#go_Type8/#go_Unselect/title/#btn_Detail", AudioEnum.Rouge2.OpenAttrDetail)
	self._btnDetail8_2 = gohelper.findChildButtonWithAudio(self.go, "#go_Root/#go_Type8/#go_Select/#btn_Detail", AudioEnum.Rouge2.OpenAttrDetail)
end

function Rouge2_TeamRecommendTips:addEventListeners()
	self._btnDetail1:AddClickListener(self._btnDetailOnClick, self)
	self._btnDetail2:AddClickListener(self._btnDetailOnClick, self)
	self._btnDetail3_1:AddClickListener(self._btnDetailOnClick, self)
	self._btnDetail3_2:AddClickListener(self._btnDetailOnClick, self)
	self._btnDetail8_1:AddClickListener(self._btnDetailOnClick, self)
	self._btnDetail8_2:AddClickListener(self._btnDetailOnClick, self)
	self.addEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, self._onUseStoneReply, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateTeamSystem, self._onUpdateTeamSystem, self)
end

function Rouge2_TeamRecommendTips:removeEventListeners()
	self._btnDetail1:RemoveClickListener()
	self._btnDetail2:RemoveClickListener()
	self._btnDetail3_1:RemoveClickListener()
	self._btnDetail3_2:RemoveClickListener()
	self._btnDetail8_1:RemoveClickListener()
	self._btnDetail8_2:RemoveClickListener()
end

function Rouge2_TeamRecommendTips:_btnDetailOnClick()
	local param = {
		careerId = self._careerId
	}

	ViewMgr.instance:openView(ViewName.Rouge2_SystemSelectView, param)
end

function Rouge2_TeamRecommendTips:updateInfo(showType, careerId, params)
	self._showType = showType
	self._careerId = careerId
	self._params = params

	self:refreshUI()
end

function Rouge2_TeamRecommendTips:refreshUI()
	self._curSystemId = Rouge2_Model.instance:getCurTeamSystemId()
	self._isSelectSystem = self._curSystemId and self._curSystemId ~= 0
	self._selectSystemCo = self._isSelectSystem and Rouge2_CareerConfig.instance:getSystemConfig(self._curSystemId)
	self._selectTagCo = self._isSelectSystem and Rouge2_CareerConfig.instance:getBattleTagConfigBySystemId(self._curSystemId)
	self._recommendSystemIdList = Rouge2_CareerConfig.instance:getCareerRecommendTeamList(self._careerId) or {}

	self:showType2RefreshUI()
end

function Rouge2_TeamRecommendTips:showType2RefreshUI()
	local refreshFunc = self:_showType2RefreshUIFunc(self._showType)

	if self._showType then
		gohelper.setActive(self._showType, true)

		if refreshFunc then
			refreshFunc(self, self._showType)
		end
	end
end

function Rouge2_TeamRecommendTips:_showType2RefreshUIFunc(showType)
	if not self._showTypeFunc then
		self._showTypeFunc = {}
		self._showTypeFunc[Rouge2_Enum.TeamRecommendTipType.Default] = self._refresh_Default
		self._showTypeFunc[Rouge2_Enum.TeamRecommendTipType.Default_Layout] = self._refresh_Default_Layout
		self._showTypeFunc[Rouge2_Enum.TeamRecommendTipType.Single] = self._refresh_Single
		self._showTypeFunc[Rouge2_Enum.TeamRecommendTipType.System] = self._refresh_System
		self._showTypeFunc[Rouge2_Enum.TeamRecommendTipType.ItemRecommend] = self._refresh_ItemRecommend
		self._showTypeFunc[Rouge2_Enum.TeamRecommendTipType.AttrBuffDrop] = self._refresh_AttrBuffDrop
		self._showTypeFunc[Rouge2_Enum.TeamRecommendTipType.HeroCard] = self._refresh_HeroCard
		self._showTypeFunc[Rouge2_Enum.TeamRecommendTipType.HeroGroupEdit] = self._refresh_HeroGroupEdit
		self._showTypeFunc[Rouge2_Enum.TeamRecommendTipType.MultiItemSystemTag] = self._refresh_MultiItemSystemTag
	end

	return self._showTypeFunc[showType]
end

function Rouge2_TeamRecommendTips:_refresh_Default(goType)
	goType.transform.pivot = self:getParam(Rouge2_Enum.TeamRecommendParam.Pivot) or Rouge2_TeamRecommendTips.Pivot_LeftCenter

	local goSelect = gohelper.findChild(goType, "go_Select")
	local goUnselect = gohelper.findChild(goType, "go_Unselect")
	local goLight = gohelper.findChild(goType, "go_Detail/#btn_Detail/icon/#light")

	gohelper.setActive(goSelect, self._isSelectSystem)
	gohelper.setActive(goUnselect, not self._isSelectSystem)
	gohelper.setActive(goLight, not self._isSelectSystem)

	if self._isSelectSystem then
		local txtName = gohelper.findChildText(goType, "go_Select/go_Tag/txt_Name")

		txtName.text = self._selectTagCo and self._selectTagCo.tagName
	end
end

function Rouge2_TeamRecommendTips:_refreshTeamTypeItem(obj, systemId, index)
	local goSelect = gohelper.findChild(obj, "go_Select")
	local txtSelectName = gohelper.findChildText(obj, "go_Select/txt_Name")
	local goUnselect = gohelper.findChild(obj, "go_Unselect")
	local txtUnselectName = gohelper.findChildText(obj, "go_Unselect/txt_Name")
	local goLine = gohelper.findChild(obj, "go_Line")
	local isSelect = systemId == self._curSystemId

	gohelper.setActive(goSelect, isSelect)
	gohelper.setActive(goUnselect, not isSelect)
	gohelper.setActive(goLine, index > 1)

	local tagCo = Rouge2_CareerConfig.instance:getBattleTagConfigBySystemId(systemId)

	txtSelectName.text = tagCo and tagCo.tagName
	txtUnselectName.text = tagCo and tagCo.tagName
end

function Rouge2_TeamRecommendTips:_refresh_Default_Layout(goType)
	local goSelect = gohelper.findChild(goType, "go_Select")
	local goUnselect = gohelper.findChild(goType, "go_Unselect")

	gohelper.setActive(goSelect, self._isSelectSystem)
	gohelper.setActive(goUnselect, not self._isSelectSystem)

	if self._isSelectSystem then
		local txtName = gohelper.findChildText(goType, "go_Select/txt_Name")

		txtName.text = self._selectTagCo and self._selectTagCo.tagName
	end
end

function Rouge2_TeamRecommendTips:_refresh_Single(goType)
	local goSelect = gohelper.findChild(goType, "#go_Select")
	local goUnselect = gohelper.findChild(goType, "#go_Unselect")

	gohelper.setActive(goSelect, self._isSelectSystem)
	gohelper.setActive(goUnselect, not self._isSelectSystem)

	if self._isSelectSystem then
		local txtSelectName = gohelper.findChildText(goType, "#go_Select/#txt_Name")

		txtSelectName.text = self._selectTagCo and self._selectTagCo.tagName
	end
end

function Rouge2_TeamRecommendTips:_refresh_System(goType)
	local goTypeList = gohelper.findChild(goType, "#go_TypeList")
	local goTypeItem = gohelper.findChild(goType, "#go_TypeList/#go_TypeItem")

	gohelper.CreateObjList(self, self._refreshTeamTypeItem, self._recommendSystemIdList, goTypeList, goTypeItem)
end

function Rouge2_TeamRecommendTips:_refresh_ItemRecommend(goType)
	local itemId = self:getParam(Rouge2_Enum.TeamRecommendParam.ItemId)
	local tagMap = Rouge2_CollectionConfig.instance:getItemBattleTagMap(itemId)
	local isSelectSystem = tagMap and tagMap[self._curSystemId] == true

	gohelper.setActive(goType, isSelectSystem)
end

function Rouge2_TeamRecommendTips:_refresh_AttrBuffDrop(goType)
	local heroNum = HeroModel.instance:getCount() or 0
	local itemId = self:getParam(Rouge2_Enum.TeamRecommendParam.ItemId)
	local tagMap = Rouge2_CollectionConfig.instance:getItemBattleTagMap(itemId)
	local isSelectSystem = tagMap and tagMap[self._curSystemId] == true

	gohelper.setActive(goType, heroNum > 0 and isSelectSystem)
end

function Rouge2_TeamRecommendTips:_refresh_HeroCard(goType)
	local heroId = self:getParam(Rouge2_Enum.TeamRecommendParam.HeroId)
	local isRecommend = Rouge2_SystemController.instance:isRecommendHero(heroId)

	gohelper.setActive(goType, isRecommend)
end

function Rouge2_TeamRecommendTips:_refresh_HeroGroupEdit(goType)
	local goSelect = gohelper.findChild(goType, "#go_Select")
	local goUnselect = gohelper.findChild(goType, "#go_Unselect")

	gohelper.setActive(goSelect, self._isSelectSystem)
	gohelper.setActive(goUnselect, not self._isSelectSystem)

	if self._isSelectSystem then
		local txtSelectName = gohelper.findChildText(goType, "#go_Select/#txt_Name")

		if self._selectTagCo then
			if not self._selectTagCo.tagName then
				local tagName = ""

				txtSelectName.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_teamrecommendtips_recommendteam"), tagName)
			end
		end
	end
end

function Rouge2_TeamRecommendTips:_refresh_MultiItemSystemTag(goType)
	local goLayout = gohelper.findChild(goType, "#go_Layout")
	local goItem = gohelper.findChild(goType, "#go_Layout/#go_Item")
	local itemId = self:getParam(Rouge2_Enum.TeamRecommendParam.ItemId)
	local battleTagList = Rouge2_CollectionConfig.instance:getItemBattleTagList(itemId)

	gohelper.CreateObjList(self, self._refreshItemSystemTag, battleTagList, goLayout, goItem)

	local layoutType = self:getParam(Rouge2_Enum.TeamRecommendParam.LayoutType)

	if layoutType ~= nil then
		local layoutGroup = gohelper.onceAddComponent(goLayout, gohelper.Type_HorizontalLayoutGroup)

		layoutGroup.childAlignment = layoutType
	end

	local spacing = self:getParam(Rouge2_Enum.TeamRecommendParam.Spacing)

	if spacing ~= nil then
		local layoutGroup = gohelper.onceAddComponent(goLayout, gohelper.Type_HorizontalLayoutGroup)

		layoutGroup.spacing = spacing
	end

	local scale = self:getParam(Rouge2_Enum.TeamRecommendParam.Scale)

	if scale ~= nil then
		transformhelper.setLocalScale(goLayout.transform, scale.x or 1, scale.y or 1, scale.z or 1)
	end
end

function Rouge2_TeamRecommendTips:_refreshItemSystemTag(goItem, systemId, index)
	local imageBg = gohelper.findChildImage(goItem, "#image_Bg")
	local goIconRoot = gohelper.findChild(goItem, "IconRoot")
	local simageIcon = gohelper.findChildSingleImage(goItem, "IconRoot/#image_Icon")
	local txtName = gohelper.findChildText(goItem, "Name/#txt_Name")
	local tagCo = Rouge2_CareerConfig.instance:getBattleTagConfigBySystemId(systemId)

	self._simageTab[simageIcon] = true
	txtName.text = tagCo and tagCo.tagName

	Rouge2_IconHelper.setTeamSystemIcon(systemId, simageIcon, imageBg, Rouge2_Enum.SystemIconType.White)

	local isShowName = self:getParam(Rouge2_Enum.TeamRecommendParam.IsShowSystemName)

	gohelper.setActive(txtName.gameObject, isShowName == nil or isShowName)

	local isShowIcon = self:getParam(Rouge2_Enum.TeamRecommendParam.IsShowSystemIcon)

	gohelper.setActive(goIconRoot, isShowIcon == nil or isShowIcon)

	local minIconWidth = self:getParam(Rouge2_Enum.TeamRecommendParam.MinIconWidth)

	if minIconWidth ~= nil then
		local layoutElement = gohelper.onceAddComponent(goIconRoot, typeof(UnityEngine.UI.LayoutElement))

		layoutElement.minWidth = minIconWidth
	end
end

function Rouge2_TeamRecommendTips:getParam(key)
	return self._params and self._params[key]
end

function Rouge2_TeamRecommendTips:_onUpdateTeamSystem()
	self:refreshUI()
end

function Rouge2_TeamRecommendTips:_onUseStoneReply()
	self:refreshUI()
end

function Rouge2_TeamRecommendTips:onDestroy()
	if self._simageTab then
		for simageIcon in pairs(self._simageTab) do
			simageIcon:UnLoadImage()
		end
	end
end

return Rouge2_TeamRecommendTips
