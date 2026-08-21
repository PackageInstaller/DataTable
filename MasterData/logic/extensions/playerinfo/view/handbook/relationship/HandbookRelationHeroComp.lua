-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/relationship/HandbookRelationHeroComp.lua

module("logic.extensions.playerinfo.view.handbook.relationship.HandbookRelationHeroComp", package.seeall)

local M = class("HandbookRelationHeroComp", UIReusableLuaBehavior)

function M:buildUI()
	local registry = self:getRegistry()

	self._rectTr = registry:findUIElement("handbook_relationship_hero_item_-513566391", UIComponentType.RectTransform)
	self._goNoneHero = registry:findUIElement("handbook_relationship_hero_item_165873804")
	self._imgHeroIcon = registry:findUIElement("handbook_relationship_hero_item_-2105884891", UIComponentType.Image)
	self._txtJob = registry:findUIElement("handbook_relationship_hero_item_-1405069595", UIComponentType.Text)
	self._txtName = registry:findUIElement("handbook_relationship_hero_item_-1226495921", UIComponentType.Text)
	self._relation = registry:findUIElement("1&relationship_feeling_365581973", UIComponentType.RectTransform)
	self._goLock = registry:findUIElement("handbook_relationship_hero_item_-1597900772")
	self._goNewSign = registry:findUIElement("handbook_relationship_hero_item_-267855842")
	self._headIconBig = registry:findUIElement("handbook_relationship_hero_item_482466291")
	self._headIconSmall = registry:findUIElement("handbook_relationship_hero_item_156116368")
	self._btnClick = UIComponentType.ButtonAdapter(registry:findUIElement("handbook_relationship_hero_item_1891494537"))
end

function M:destroyUI()
	self:setData(nil)
	self:setHandler(nil)
	self:clearRegistry()

	self._rectTr = nil
	self._goNoneHero = nil
	self._imgHeroIcon = nil
	self._txtJob = nil
	self._goLock = nil
	self._goNewSign = nil
	self._btnClick = nil
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickSelf, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	self._txtName.text = ""
end

function M:onExit()
	return
end

function M:getMainGO()
	return self.mainGO
end

function M:getRectTransform()
	return self._rectTr
end

function M:getRegistry()
	if not self._registry then
		self._registry = ViewElementsRegistry.New(self:getMainGO())
	end

	return self._registry
end

function M:clearRegistry()
	if self._registry then
		self._registry:cleanRegistry()
	end

	self._registry = false
end

function M:getHandler()
	return self._handler
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getData()
	return self._data
end

function M:setData(data)
	self._data = data
end

function M:getIsLock()
	return self._isLock
end

function M:setIsLock(lock)
	self._isLock = lock

	goutil.setActive(self._goLock, self._isLock)
end

function M:setIsCenter(isCenter)
	self._isCenter = isCenter
end

function M:getIsCenter()
	return self._isCenter
end

function M:setRelationId(id)
	self._relationId = id
end

function M:getRelationId()
	return self._relationId or 0
end

function M:setIsHeroMask(isMask)
	self._isHeroMask = isMask

	goutil.setActive(self._goNoneHero, isMask)
	goutil.setActive(self._imgHeroIcon.gameObject, not isMask)
end

function M:getIsHeroMask()
	return self._isHeroMask
end

function M:getIsNew()
	return self._isNew
end

function M:setIsNew(new)
	self._isNew = new

	goutil.setActive(self._goNewSign, self._isNew)
end

function M:setJobTxt(jobStr)
	if string.nilorempty(jobStr) then
		local nameStr = ""

		if self._heroId == PlayerModel.instance:getPlayerRoleCode() then
			nameStr = PlayerModel.instance:getNickName()
		else
			local cfgCharacter = PastInfoConfig.instance:getCharacterInfo(self._heroId)

			if cfgCharacter then
				nameStr = cfgCharacter.name
			end
		end

		self._txtJob.text = nameStr
	else
		self._txtJob.text = jobStr
	end
end

function M:setJobTxtVisible(visible)
	goutil.setActive(self._txtJob.gameObject, visible)
end

function M:setRelationShow(show, typ)
	if show then
		for i = 0, self._relation.childCount - 1 do
			goutil.setActive(self._relation:GetChild(i).gameObject, i == typ - 1)
		end
	end

	goutil.setActive(self._relation.gameObject, show)
end

function M:updateHeroShow(heroId)
	self._heroId = heroId

	if heroId > 0 then
		local cfgCharacter = CharacterConfig.instance:getCharacterItemInfo(heroId)

		if heroId == PlayerModel.instance:getPlayerRoleCode() then
			local portrait = PlayerModel.instance:getDefaultPortrait()
			local portraitCO = BackpackConfig.instance:getItemInfoByItemId(portrait)

			IconLoader.setSprite(self._imgHeroIcon, IconType.HeadIcon, portraitCO.icon)
		elseif cfgCharacter then
			IconLoader.setSprite(self._imgHeroIcon, IconType.HeadIcon, CharacterCOUtil.getIcon(cfgCharacter))
		else
			printError(string.format("无法找到角色[%s]的配置", heroId))
		end
	end
end

function M:getHeroId()
	return self._heroId
end

function M:_onClickSelf()
	local handler = self:getHandler()

	if handler then
		handler:onClickHeroItem(self)
	end
end

function M:setName()
	goutil.setActive(self._txtName.gameObject, true)
	goutil.setActive(self._txtJob.gameObject, false)

	local nameStr = ""

	if self._heroId == PlayerModel.instance:getPlayerRoleCode() then
		nameStr = PlayerModel.instance:getNickName()
	else
		local cfgCharacter = PastInfoConfig.instance:getCharacterInfo(self._heroId)

		nameStr = cfgCharacter.name
	end

	self._txtName.text = nameStr
end

function M:setSmallHeadIcon()
	goutil.setActive(self._headIconBig, false)
	goutil.setActive(self._headIconSmall, true)
end

return M
