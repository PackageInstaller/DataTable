-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/relationship/HandbookRelationshipView.lua

module("logic.extensions.playerinfo.view.handbook.relationship.HandbookRelationshipView", package.seeall)

local M = class("HandbookRelationshipView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnReturn = self:getBtn("title_view_-878360263")
	self._btnCloseTips = self:getBtn("handbook_relationship_view_603577340")
	self._rectTips = self:getUIComponent("handbook_relationship_view_1996717675", UIComponentType.RectTransform)
	self._txtTipsHeroName = self:getText("handbook_relationship_view_-1091519677")
	self._txtTipsRelationDesc = self:getText("handbook_relationship_view_-1264560627")
	self._btnTipsGoDetail = self:getBtn("handbook_relationship_view_219659490")
	self._selfCell = self:getGo("handbook_relationship_view_1225855100")
	self._targetCell = self:getImage("2&handbook_relationship_hero_item_-2105884891")
	self._targetCell2 = self:getImage("4&handbook_relationship_hero_item_-2105884891")
	self._relation = self:getGo("3&relationship_feeling_365581973")
	self._relationEffect = self:getGo("5&relationship_feeling_effect_524233828")

	local uiPatternRoot = self:getUIComponent("handbook_relationship_view_-2112082082", UIComponentType.RectTransform)

	self._patternRoot = {}

	for i = 0, uiPatternRoot.childCount - 1 do
		local tmpTr = uiPatternRoot:GetChild(i)

		self._patternRoot[tmpTr.gameObject.name] = tmpTr

		goutil.setActive(tmpTr.gameObject, false)
	end

	self._fallBackUiPattern = "10"
	self._cellCollect_Hero = LocalReusableCollection.New(HandbookRelationHeroComp, 10)
	self._tipsCollect_Hero = LocalReusableCollection.New(HandbookRelationHeroComp, 10)
end

function M:destroyUI()
	self._btnReturn = nil
	self._btnCloseTips = nil
	self._rectTips = nil
	self._txtTipsHeroName = nil
	self._txtTipsRelationDesc = nil
	self._btnTipsGoDetail = nil
	self._rectCenterRoot = nil
	self._patternRoot = nil
	self._cellCollect_Hero = nil
	self._tipsCollect_Hero = nil
	self._prefabHero = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnCloseTips:AddClickListener(self._onClickCloseTips, self)
	self._btnTipsGoDetail:AddClickListener(self._onClickTipsGoDetail, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnCloseTips:RemoveClickListener()
	self._btnTipsGoDetail:RemoveClickListener()
end

function M:onEnter()
	local info = self:getFirstParam()

	self:_setEvent(true)
	self:showHeroRelationship(info.heroId)
end

function M:onExit()
	self:_setEvent(false)
	self._cellCollect_Hero:clearAllInstance()
	self._tipsCollect_Hero:clearAllInstance()
	GlobalDispatcher:dispatchEvent(EventType.HANDBOOK_RELATION_VIEW_CLOSE, self._heroId)
end

function M:showHeroRelationship(heroId)
	self._heroId = heroId
	self._lastSelectHero = nil
	self._cellHero = {}

	self._cellCollect_Hero:clearAllInstance()
	self:showTips(false)
	self:refreshView()
	self:refreshCellTag()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self.handleHandbookUnreadInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self.handleHandbookUnreadInfoChange, self)
	end
end

function M:handleHandbookUnreadInfoChange(e)
	self:refreshCellTag()
end

function M:_onClickReturn()
	if self._rectTips.gameObject.activeSelf then
		self:_onClickCloseTips()
	else
		self:close()
	end
end

function M:_onClickCloseTips()
	if self._rectTips.gameObject.activeSelf then
		self:showTips(false)

		self._lastSelectHero = nil
	end
end

function M:onClickHeroItem(heroCell)
	local heroId = heroCell:getHeroId()

	if heroId == self:getHeroId() then
		self:showTips(false)

		self._lastSelectHero = nil

		print(string.format("自己点自己，弹出角色信息"))

		if heroId ~= PlayerModel.instance:getPlayerRoleCode() then
			local info = {
				heroId = heroId,
				isLock = heroCell:getIsLock()
			}

			ViewMgr.instance:open(ViewName.HandbookHeroInfoView, info)
		end
	else
		local targetHeroId = heroCell:getHeroId()
		local isNew = heroCell:getIsNew()
		local isLock = heroCell:getIsLock()
		local relationId = heroCell:getRelationId()

		if self._lastSelectHero and self._lastSelectHero == targetHeroId then
			self:showTips(false)

			self._lastSelectHero = nil

			return
		end

		self._lastSelectHero = targetHeroId

		local typ = GameEnum.UnlockTypeEnum
		local HeroRelationCO = HandbookConfig.instance:getHeroRelation(self:getHeroId())
		local relationIds = HeroRelationCO:getTargetHeroRelationCfgIdsLst(targetHeroId)

		if GalleryModel.instance:getIsIdsUnRead(typ.HeroRelation, relationIds) then
			HandbookController.instance:setHandbookTypIdsRead(typ.HeroRelation, relationIds, true)
		end

		self._tipsCollect_Hero:clearAllInstance()
		self:showTips(true, targetHeroId, heroCell:getData())
	end
end

function M:_onClickTipsGoDetail()
	print(string.format("跳转角色[%s]的关系网", self._lastSelectHero))
	self:clearAllCellRelationNewSign()
	self:showHeroRelationship(self._lastSelectHero)
end

function M:getHeroId()
	return self._heroId or 0
end

function M:createCellHero(heroId)
	if not self._prefabHero then
		self._prefabHero = self:getPrefab(ResName.Handbook_handbook_relationship_hero_item)
	end

	local cell = self._cellCollect_Hero:createInstance(self._prefabHero)

	cell:setHandler(self)
	cell:setJobTxtVisible(false)
	cell:setIsHeroMask(false)
	cell:updateHeroShow(heroId)
	cell:setSmallHeadIcon()

	if not self._cellHero[heroId] then
		self._cellHero[heroId] = {}
	end

	table.insert(self._cellHero[heroId], cell)

	return cell
end

function M:createTipsHero(prefab, heroId)
	local cellGo = goutil.clone(prefab.transform:GetChild(0).gameObject)

	goutil.setActive(cellGo, true)

	local cell = self._tipsCollect_Hero:createInstance(cellGo)

	cell:setHandler(self)
	cell:setIsHeroMask(false)
	cell:updateHeroShow(heroId)
	cell:setName()

	return cell
end

function M:refreshCellTag()
	local typ = GameEnum.UnlockTypeEnum

	for heroId, cellLst in pairs(self._cellHero or {}) do
		local isNew = GalleryModel.instance:getIsIdUnRead(typ.Hero, heroId)
		local isLock = not GalleryModel.instance:getIsUnLock(typ.Hero, heroId)

		for _, cell in ipairs(cellLst) do
			if not cell:getIsCenter() then
				isNew = isNew or GalleryModel.instance:getIsIdUnRead(typ.HeroRelation, cell:getRelationId())
			end

			cell:setIsNew(isNew)
			cell:setIsLock(isLock)
		end
	end
end

function M:clearAllCellRelationNewSign()
	local typ = GameEnum.UnlockTypeEnum.HeroRelation
	local t = {}

	for heroId, cellLst in pairs(self._cellHero or {}) do
		for _, cell in ipairs(cellLst) do
			local relationId = cell:getRelationId()

			if GalleryModel.instance:getIsIdUnRead(typ, relationId) then
				table.insert(t, relationId)
			end
		end
	end

	if #t > 0 then
		HandbookController.instance:setHandbookTypIdsRead(typ, t, true)
	end
end

function M:refreshView()
	local heroId = self:getHeroId()

	if heroId == 0 then
		printWarn(string.format("角色[%s]", heroId))

		return
	end

	local realationCO = HandbookConfig.instance:getHeroRelation(heroId)
	local relationTyp = HandbookConfig.instance:getHeroRelationTyp()
	local realtionCount = realationCO:getRelationsCount()

	printWarn(string.format("角色[%s]当前激活的关系数量为[%s]", heroId, realtionCount))

	local uiPattern = string.format("%s", realtionCount)
	local root = self._patternRoot[uiPattern]

	if not root then
		printError("无法找到[%s]的uiPattern节点，将使用[%s]", uiPattern, self._fallBackUiPattern)

		uiPattern = self._fallBackUiPattern
		root = self._patternRoot[uiPattern]
	end

	for key, _rootTransform in pairs(self._patternRoot) do
		local show = key == uiPattern

		goutil.setActive(_rootTransform.gameObject, show)
	end

	local cellHero = self:createCellHero(heroId)

	cellHero:setRelationShow(false)
	cellHero:setIsCenter(true)
	cellHero:setName()

	self._rectCenterRoot = goutil.findChild(self.mainGO, "cellGroup/" .. uiPattern .. "/centerCell")

	goutil.addChildToParent(cellHero:getMainGO(), self._rectCenterRoot)

	local uiCellCount = root.transform.childCount - 1
	local realtionsLst = {}

	for targetHeroId, cfg in pairs(realationCO:getHeroRelations()) do
		table.insert(realtionsLst, cfg)
	end

	if #realtionsLst > 0 then
		table.sort(realtionsLst, function(cfgA, cfgB)
			if relationTyp[cfgA.typ] ~= relationTyp[cfgB.typ] then
				return relationTyp[cfgA.typ] < relationTyp[cfgB.typ]
			end

			return cfgA.id < cfgB.id
		end)
	end

	for index, cfg in ipairs(realtionsLst) do
		if index <= uiCellCount then
			local cellRoot = root:GetChild(index - 1)
			local cellTargetHero = self:createCellHero(cfg.targetId)

			cellTargetHero:setRelationShow(true, cfg.typ)
			cellTargetHero:setData(cellRoot.anchoredPosition)
			cellTargetHero:setIsCenter(false)
			cellTargetHero:setRelationId(cfg.id)
			goutil.addChildToParent(cellTargetHero:getMainGO(), cellRoot)
		else
			printError(string.format("关系[%s] 无法展示，ui布局不足", cfg.id))
		end
	end
end

function M:showTips(show, targetHeroId, anchoredPos)
	if show then
		local realationCO = HandbookConfig.instance:getHeroRelation(self:getHeroId())
		local cfgTargetHeroActiveRelation = realationCO:getHeroRelation(targetHeroId)

		if cfgTargetHeroActiveRelation then
			local selfHero = self:createTipsHero(self._selfCell, self:getHeroId())

			goutil.addChildToParent(selfHero:getMainGO(), self._selfCell)

			if targetHeroId == PlayerModel.instance:getPlayerRoleCode() then
				local portrait = PlayerModel.instance:getDefaultPortrait()
				local portraitCO = BackpackConfig.instance:getItemInfoByItemId(portrait)

				IconLoader.setSprite(self._targetCell, IconType.HeadIcon, portraitCO.icon)
				IconLoader.setSprite(self._targetCell2, IconType.HeadIcon, portraitCO.icon)
			else
				local cfgCharacter = CharacterConfig.instance:getCharacterItemInfo(targetHeroId)

				if cfgCharacter then
					IconLoader.setSprite(self._targetCell, IconType.HeadIcon, CharacterCOUtil.getIcon(cfgCharacter))
					IconLoader.setSprite(self._targetCell2, IconType.HeadIcon, CharacterCOUtil.getIcon(cfgCharacter))
				end
			end

			for i = 0, self._relation.transform.childCount - 1 do
				goutil.setActive(self._relation.transform:GetChild(i).gameObject, i == cfgTargetHeroActiveRelation.typ - 1)
				goutil.setActive(self._relationEffect.transform:GetChild(i).gameObject, i == cfgTargetHeroActiveRelation.typ - 1)
			end

			self._txtTipsHeroName.text = ContainmentUtil.getHeroName(targetHeroId)
			self._txtTipsRelationDesc.text = cfgTargetHeroActiveRelation.desc
		else
			printError(string.format("角色[%s]与[%s]没有激活的关系，请检查", self:getHeroId(), targetHeroId))

			show = false
		end
	end

	goutil.setActive(self._rectTips.gameObject, show)
end

return M
