-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/new/EchoItemMainSubViewContrast.lua

module("logic.extensions.charactersystem.view.carrier.new.EchoItemMainSubViewContrast", package.seeall)

local M = class("EchoItemMainSubViewContrast")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local registry = self:getRegistry()

	self._go = registry:findUIElement("echo_view_copy_73057696")

	goutil.setActive(self._go, false)

	self._txtName = registry:findUIElement("echo_view_copy_1287456502", UIComponentType.Text)
	self._imgIcon = registry:findUIElement("echo_view_copy_942143623", UIComponentType.Image)
	self._goIconHeroRoot = registry:findUIElement("echo_view_copy_-1832523807")
	self._imgIconHero = registry:findUIElement("echo_view_copy_1810635494", UIComponentType.Image)
	self._btnLock = UIComponentType.ButtonAdapter(registry:findUIElement("echo_view_copy_-449934124"))
	self._goMarkLock = registry:findUIElement("echo_view_copy_-337616635")
	self._goMarkUnLock = registry:findUIElement("echo_view_copy_-126725772")
	self._breakPointView = Astral.LuaComponentContainer.Add(goutil.findChild(self._go, "node/scroll/view/content/content1/break_point").gameObject, EchoItemBreakPointView)
	self._baseAttrLst = {}

	table.insert(self._baseAttrLst, {
		root = registry:findUIElement("echo_view_copy_-1769076506"),
		txtName = registry:findUIElement("echo_view_copy_-1459692321", UIComponentType.Text),
		txtAttr = registry:findUIElement("echo_view_copy_-696768409", UIComponentType.Text)
	})
	table.insert(self._baseAttrLst, {
		root = registry:findUIElement("echo_view_copy_1136197971"),
		txtName = registry:findUIElement("echo_view_copy_-758111461", UIComponentType.Text),
		txtAttr = registry:findUIElement("echo_view_copy_757662792", UIComponentType.Text)
	})

	self._descRootTrs = registry:findUIElement("echo_view_1513067455", UIComponentType.RectTransform)
	self._txtCareerFlag = registry:findUIElement("echo_view_-2125892581", UIComponentType.TextMeshProUGUI)
	self._txtCareer = registry:findUIElement("echo_view_1175886902", UIComponentType.TextMeshProUGUI)
	self._btnDesc = UIComponentType.ButtonAdapter(registry:findUIElement("echo_view_copy_385337456"))
	self._attributeRoot = registry:findUIElement("echo_view_copy_-1647242170", UIComponentType.RectTransform)
	self._attrViewList = {}

	for i = 1, self._attributeRoot.childCount - 1 do
		local view = Astral.SimpleLuaComponentContainer.Add(self._attributeRoot:GetChild(i).gameObject, EchoItemBreakAttrViewNew)

		view:setIndex(i + 1)
		table.insert(self._attrViewList, view)
	end
end

function M:destroyUI()
	self._isEnter = nil
	self.mainGO = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = nil
	end

	self:setHandler(nil)
end

function M:bindEvents()
	self._btnLock:AddClickListener(self._onClickLock, self)
	self._btnDesc:AddClickListener(self._onClickDesc, self)
end

function M:unbindEvents()
	self._btnLock:RemoveClickListener()
	self._btnDesc:RemoveClickListener()
end

function M:onEnter()
	self._isEnter = true

	self:setEvent(true)
end

function M:onExit()
	self._isEnter = false

	self:setEvent(false)

	self._lastEchoItemId = nil
	self._isActive = false
end

function M:setHandler(handler)
	self._handler = handler
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ECHO_ITEM_INFO_REFRESH, self._handleEchoItemInfoRefresh, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ECHO_ITEM_INFO_REFRESH, self._handleEchoItemInfoRefresh, self)
	end
end

function M:_handleEchoItemInfoRefresh(e)
	if not self._isEnter then
		return
	end

	if not self:getIsActive() then
		return
	end

	self:refreshBaseInfo()
end

function M:_onClickLock()
	local echoItemData = EchoItemController.instance:getCurHeroEchoItem()

	if not echoItemData then
		return
	end

	local uuid = echoItemData:getUuid()
	local isLock = echoItemData:getIsLock()
	local seId = CriwareAudioEnum.ui_shoumiren_canxiangsuoding

	CriwareAudioFacade.instance:playOnceSEbyId(seId, nil, nil, nil)

	if not isLock then
		EchoItemAgent.instance:sendLockEchoItemRequest(uuid, true)
	else
		local dialog = Dialog.showMessage(lang("tip_sure_unlock"), lang("tip_ask_unlock"))

		dialog:setConfirmListener(function()
			EchoItemAgent.instance:sendLockEchoItemRequest(uuid, false)
		end, self)
	end
end

function M:_onClickDesc()
	local echoItemData = EchoItemController.instance:getCurHeroEchoItem()

	if not echoItemData then
		return
	end

	local skillEnhanceMO = echoItemData:getSkillEnhanceMO()
	local bindGo = self._btnDesc.gameObject
	local isPassEvent = true

	ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMO, bindGo, isPassEvent)
end

function M:getIsActive()
	return self._go.activeSelf
end

function M:setIsActive(active)
	goutil.setActive(self._go, active)

	if active then
		self:refreshBaseInfo()
	end
end

function M:onPageTypChange(typ)
	local needShow = typ == EchoItemMainViewNew.SubViewType.Change

	if not needShow and self:getIsActive() then
		self:setIsActive(false)
	end
end

function M:refreshBaseInfo()
	local echoItemData = EchoItemController.instance:getCurHeroEchoItem()

	if not echoItemData then
		return
	end

	local isLock = echoItemData:getIsLock()
	local quality = echoItemData:getQuality()
	local career = echoItemData:getCareer()
	local heroId = echoItemData:getHeroId()
	local echoMaxLv = echoItemData:getMaxLevel()

	self._txtName.text = echoItemData:getName()

	IconLoader.setSprite(self._imgIcon, IconType.EchoItemIcon, echoItemData:getIcon())
	goutil.setActive(self._goMarkLock, isLock)
	goutil.setActive(self._goMarkUnLock, not isLock)

	if heroId > 0 then
		local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)
		local modelCO = heroMO and ModelConfig.instance:getModelConfig(heroMO:getModelId()) or nil

		if modelCO then
			IconLoader.setSprite(self._imgIconHero, IconType.RoleHeadIcon, modelCO.headIconName)
		end
	end

	goutil.setActive(self._goIconHeroRoot, heroId > 0)
	self._breakPointView:setEchoItemLevel(echoItemData:getLevel(), echoMaxLv)

	local attLst = echoItemData:getAttr()
	local attCount = #attLst

	for index, comps in ipairs(self._baseAttrLst) do
		local data = attLst[index]
		local show = data ~= nil

		if show then
			local cfg = AttributeDefineConfig.instance:getAttributePartDefineCO(data.id)

			comps.txtName.text = cfg and cfg.name or ""
			comps.txtAttr.text = data.num
		end

		goutil.setActive(comps.root, show)
	end

	local tagIds = HeroDepotModel.instance:getCurViewPageHeroTags()
	local skillEnhanceMO = echoItemData:getSkillEnhanceMO()
	local descStr = skillEnhanceMO and skillEnhanceMO:getDescriptionTagHighLight(tagIds) or ""
	local campIcon = CommEnum.Career2TmpResName[career] or ""
	local lines = string.split(descStr, "\n")

	self._txtCareerFlag.text = string.format("<size=24>%s</size>", campIcon)
	self._txtCareer.text = string.format("%s", CommEnum.Career2Name[career])

	goutil.setActive(self._txtCareerFlag.gameObject.transform.parent.gameObject, campIcon ~= "")
	goutil.setActive(self._descRootTrs.gameObject, descStr ~= "")

	if #lines > 0 then
		while self._descRootTrs.childCount - 1 < #lines do
			local textGo = goutil.cloneAndSetParent(self._descRootTrs:GetChild(1).gameObject, self._descRootTrs)

			textGo.transform:SetSiblingIndex(1)
		end

		for i = 1, self._descRootTrs.childCount - 1 do
			local go = self._descRootTrs:GetChild(i).gameObject
			local txtDesc = go:GetComponent(UIComponentType.TMPText)

			txtDesc.text = lines[i]

			goutil.setActive(go, i <= #lines)
		end
	end

	for index, attrView in ipairs(self._attrViewList) do
		local showLevel = index + 1
		local isBreak = showLevel <= echoItemData:getLevel()
		local colorAttr = false
		local colorSkill = false
		local descSplit = false
		local data = {
			echoItemId = echoItemData:getId(),
			level = echoItemData:getLevel(),
			descSplit = descSplit,
			desc = EchoItemConfig.instance:getAttrDesc(echoItemData:getId(), showLevel, colorAttr, colorSkill, descSplit, tagIds),
			itemData = echoItemData,
			showLevel = showLevel
		}

		attrView:setData(data, echoMaxLv)
	end
end

return M
