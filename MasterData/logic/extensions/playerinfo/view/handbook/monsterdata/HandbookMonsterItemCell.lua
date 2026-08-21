-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/monsterdata/HandbookMonsterItemCell.lua

module("logic.extensions.playerinfo.view.handbook.monsterdata.HandbookMonsterItemCell", package.seeall)

local M = class("HandbookMonsterItemCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
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

	self._btnClick = UIComponentType.ButtonAdapter(registry:findUIElement("handbook_mosterdata_item_94499098"))
	self._imgIcon = registry:findUIElement("handbook_mosterdata_item_1281165678", UIComponentType.Image)
	self._imgIconLock = registry:findUIElement("handbook_mosterdata_item_1466451990", UIComponentType.Image)
	self._goNormalMark = registry:findUIElement("handbook_mosterdata_item_-1037535976")
	self._goEmptyMark = registry:findUIElement("handbook_mosterdata_item_548072956")
	self._goNewSignMark = registry:findUIElement("handbook_mosterdata_item_1750360174")
	self._txtName = registry:findUIElement("handbook_mosterdata_item_104527634", UIComponentType.Text)
	self._defaultName = self._txtName.text
end

function M:destroyUI()
	self:setHandler(nil)

	self._imgIcon = nil
	self._goEmptyMark = nil
	self._txtName = nil
	self._goNewSignMark = nil
	self._btnClick = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = false
	end
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickSelf, self)
end

function M:unbindEvents()
	self:setHandler(nil)
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:getRegistry()
	return self._registry
end

function M:_onClickSelf()
	local handler = self:getHandler()

	if handler then
		handler:onCellClick(self)
	end

	if self:getIsNew() then
		HandbookController.instance:setHandbookTypIdRead(GameEnum.UnlockTypeEnum.Monster, self._id, true)
		self:setNewMark(false)
	end
end

function M:setData(cfgData)
	local cfgMonster = MonsterConfig.instance:getMonsterCO(cfgData.id)
	local isLock = not GalleryModel.instance:getIsUnLock(GameEnum.UnlockTypeEnum.Monster, cfgData.id)

	if self:getTyp() ~= cfgData.typ or self:getId() ~= cfgData.id then
		if not isLock then
			self:_updateShow(cfgMonster)
		end
	elseif not isLock and self:getIsLock() ~= isLock then
		self:_updateShow(cfgMonster)
	end

	self:setLock(isLock)

	if isLock then
		self:_updateShow(cfgMonster, isLock)

		self._txtName.text = self._defaultName
	else
		self._txtName.text = cfgMonster and cfgMonster.name or self._defaultName
	end

	self._typ = cfgData.typ
	self._id = cfgData.id

	self:setNewMark(GalleryModel.instance:getIsIdUnRead(GameEnum.UnlockTypeEnum.Monster, self._id))
end

function M:_updateShow(cfgMonster, lock)
	if lock then
		-- block empty
	end

	local modelCO = ModelConfig.instance:getModelConfig(cfgMonster.modelId)

	IconLoader.setSprite(self._imgIcon, IconType.RoleCard, modelCO.halfIconName)
	IconLoader.setSprite(self._imgIconLock, IconType.RoleCard, modelCO.halfIconName)
end

function M:setLock(lock)
	self._isLock = lock

	goutil.setActive(self._goEmptyMark, lock)
	goutil.setActive(self._goNormalMark, not lock)
end

function M:getIsLock()
	return self._isLock
end

function M:setNewMark(show)
	self._isNew = show

	goutil.setActive(self._goNewSignMark, show)
end

function M:getIsNew()
	return self._isNew
end

function M:getId()
	return self._id or -1
end

function M:getTyp()
	return self._typ or -1
end

return M
