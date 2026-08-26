-- chunkname: @modules/logic/versionactivity2_3/newcultivationgift/view/VersionActivity2_3NewCultivationDestinyItem.lua

module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationDestinyItem", package.seeall)

local VersionActivity2_3NewCultivationDestinyItem = class("VersionActivity2_3NewCultivationDestinyItem", RougeSimpleItemBase)

function VersionActivity2_3NewCultivationDestinyItem:onInitView()
	self._simagestone = gohelper.findChildSingleImage(self.viewGO, "#simage_stone")
	self._txttitle = gohelper.findChildText(self.viewGO, "title/#txt_title")
	self._goNewTag = gohelper.findChild(self.viewGO, "title/#go_NewTag")
	self._godecitem1 = gohelper.findChild(self.viewGO, "#go_decitem1")
	self._godecitem2 = gohelper.findChild(self.viewGO, "#go_decitem2")
	self._gosmalltitle1 = gohelper.findChild(self.viewGO, "#go_smalltitle1")
	self._gosmalltitle2 = gohelper.findChild(self.viewGO, "#go_smalltitle2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_3NewCultivationDestinyItem:addEvents()
	return
end

function VersionActivity2_3NewCultivationDestinyItem:removeEvents()
	return
end

local ti = table.insert

function VersionActivity2_3NewCultivationDestinyItem:ctor(ctorParam)
	self:__onInit()
	VersionActivity2_3NewCultivationDestinyItem.super.ctor(self, ctorParam)

	self._desc1ItemList = {}
	self._desc2ItemList = {}
end

function VersionActivity2_3NewCultivationDestinyItem:_editableInitView()
	self._decbg_spGo = gohelper.findChild(self.viewGO, "decbg_sp")
	self._titleGo = gohelper.findChild(self.viewGO, "title")
	self._titleGo_sp = gohelper.findChild(self.viewGO, "title_sp")
	self._txttitle_sp = gohelper.findChildText(self._titleGo_sp, "#txt_title")
	self._goNewTag_sp = gohelper.findChild(self._titleGo_sp, "#go_NewTag")
	self._reshapeGo_sp = gohelper.findChild(self.viewGO, "#reshape_sp")
	self._simagestone2 = gohelper.findChildSingleImage(self._reshapeGo_sp, "#simage_stone")
	self._keywordItem = VersionActivity2_3NewCultivationKeywordItem.New({
		parent = self,
		baseViewContainer = self:baseViewContainer()
	})

	self._keywordItem:init(gohelper.findChild(self.viewGO, "RoleTag"))

	self._gosmalltitle1Tran = self._gosmalltitle1.transform
	self._gosmalltitle2Tran = self._gosmalltitle2.transform

	gohelper.setActive(self._gosmalltitle1, false)
	gohelper.setActive(self._gosmalltitle2, false)
	gohelper.setActive(self._godecitem1, false)
	gohelper.setActive(self._godecitem2, false)
	self:_editableInitView_descList()
end

function VersionActivity2_3NewCultivationDestinyItem:_getDescItemList(refItemList, fromSiblingTran, toSiblingTran, selfFunc)
	local fromIndex = fromSiblingTran:GetSiblingIndex()

	if not fromSiblingTran.parent then
		local parentTran = fromSiblingTran
		local toIndex = parentTran.childCount - 1

		if toSiblingTran then
			toIndex = math.min(toIndex, toSiblingTran:GetSiblingIndex())
		end

		local index = 0

		for i = fromIndex + 1, toIndex - 1 do
			index = index + 1

			local tr = parentTran:GetChild(i)

			ti(refItemList, selfFunc(self, tr.gameObject, index))
		end
	end
end

function VersionActivity2_3NewCultivationDestinyItem:_editableInitView_descList()
	self:_getDescItemList(self._desc1ItemList, self._gosmalltitle1Tran, self._gosmalltitle2Tran, self._create_VersionActivity2_3NewCultivationDestinyItem_DescItem1)
	self:_getDescItemList(self._desc2ItemList, self._gosmalltitle2Tran, nil, self._create_VersionActivity2_3NewCultivationDestinyItem_DescItem1)
end

function VersionActivity2_3NewCultivationDestinyItem:_isSpecialDestiny()
	return self:baseViewContainer():isSpecialDestiny(self._destinyId)
end

function VersionActivity2_3NewCultivationDestinyItem:setData(roleId, destinyId, isNew)
	self._destinyId = destinyId
	self._roleId = roleId

	self:_refreshUI(isNew)
end

local s_TipPosV2 = Vector2(380, 100)

function VersionActivity2_3NewCultivationDestinyItem:_refreshUI(isNew)
	local destinyId = self._destinyId
	local isSp = self:_isSpecialDestiny()
	local consumeConfig = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(destinyId)
	local destinyIconResUrl = ResUrl.getDestinyIcon(consumeConfig.icon)

	self:_isActive_decbg_spGo(isSp)
	self:_refresh_goNewTag(isNew, isSp)
	self:_refresh_title(isSp, consumeConfig.name)
	self:_refresh_simagestone(isSp, destinyIconResUrl)
	self:_refresh_desc1ItemList(isSp)
	self:_refresh_desc2ItemList(isSp)
	self._keywordItem:refreshKeyword(consumeConfig.keyword)
end

function VersionActivity2_3NewCultivationDestinyItem:_refresh_title(isSp, titleStr)
	gohelper.setActive(self._titleGo, not isSp)
	gohelper.setActive(self._titleGo_sp, isSp)

	if isSp then
		self._txttitle_sp.text = titleStr
	else
		self._txttitle.text = titleStr
	end
end

function VersionActivity2_3NewCultivationDestinyItem:_refresh_goNewTag(isNew, isSp)
	gohelper.setActive(self._goNewTag, not isSp and isNew)
	gohelper.setActive(self._goNewTag_sp, isSp and isNew)
end

function VersionActivity2_3NewCultivationDestinyItem:_isActive_decbg_spGo(isActive)
	gohelper.setActive(self._decbg_spGo, isActive)
end

function VersionActivity2_3NewCultivationDestinyItem:_refresh_desc1ItemList(isSp)
	gohelper.setActive(self._gosmalltitle1, isSp)

	local destinyId = self._destinyId
	local roleId = self._roleId
	local descCount = 0
	local lua_character_destiny_facetLvCOs = CharacterDestinyConfig.instance:getDestinyFacetCo(destinyId)

	for _, lua_character_destiny_facet_CO in pairs(lua_character_destiny_facetLvCOs or {}) do
		local desc = lua_character_destiny_facet_CO.desc

		descCount = descCount + 1

		local item = self._desc1ItemList[descCount]

		if not item then
			logError("less prefab desc1 node, still need " .. tostring(descCount))

			break
		end

		item:setActive(true)
		item:updateInfo(desc, roleId)
		item:setTipParam(0, s_TipPosV2)
	end

	for i = descCount + 1, #self._desc1ItemList do
		local item = self._desc1ItemList[i]

		item:setActive(false)
	end
end

function VersionActivity2_3NewCultivationDestinyItem:_refresh_desc2ItemList(isSp)
	gohelper.setActive(self._gosmalltitle2, isSp)

	local destinyId = self._destinyId
	local roleId = self._roleId
	local descCount = 0
	local lua_destiny_facets_ex_levelCOs = CharacterDestinyConfig.instance:getSkillExlevelCos(destinyId)

	for _, lua_destiny_facets_ex_levelCO in pairs(lua_destiny_facets_ex_levelCOs or {}) do
		local desc = lua_destiny_facets_ex_levelCO.desc
		local level = lua_destiny_facets_ex_levelCO.skillLevel

		descCount = descCount + 1

		local prefixStr = string.format(luaLang("VersionActivity2_3NewCultivationDestinyItem_refresh_desc2ItemList_prefix"), level)
		local item = self._desc2ItemList[descCount]

		if not item then
			logError("less prefab desc2 node, still need " .. tostring(descCount))

			break
		end

		item:setActive(true)
		item:updateInfo(prefixStr .. desc, roleId)
		item:setTipParam(0, s_TipPosV2)
	end

	for i = descCount + 1, #self._desc2ItemList do
		local item = self._desc2ItemList[i]

		item:setActive(false)
	end
end

function VersionActivity2_3NewCultivationDestinyItem:_refresh_simagestone(isSp, resUrl)
	gohelper.setActive(self._reshapeGo_sp, isSp)
	self._simagestone:LoadImage(resUrl)

	if isSp then
		self._simagestone2:LoadImage(resUrl)
	end
end

function VersionActivity2_3NewCultivationDestinyItem:_create_VersionActivity2_3NewCultivationDestinyItem_DescItem1(go, index)
	local item = VersionActivity2_3NewCultivationDestinyItem_DescItem1.New({
		parent = self,
		baseViewContainer = self:baseViewContainer()
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function VersionActivity2_3NewCultivationDestinyItem:_create_VersionActivity2_3NewCultivationDestinyItem_DescItem2(go, index)
	local item = VersionActivity2_3NewCultivationDestinyItem_DescItem2.New({
		parent = self,
		baseViewContainer = self:baseViewContainer()
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function VersionActivity2_3NewCultivationDestinyItem:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_keywordItem")
	GameUtil.onDestroyViewMemberList(self, "_desc1ItemList")
	GameUtil.onDestroyViewMemberList(self, "_desc2ItemList")
	VersionActivity2_3NewCultivationDestinyItem.super.onDestroyView(self)
	self:__onDispose()
end

return VersionActivity2_3NewCultivationDestinyItem
