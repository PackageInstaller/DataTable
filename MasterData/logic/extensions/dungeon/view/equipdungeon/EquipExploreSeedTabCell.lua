-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/equipdungeon/EquipExploreSeedTabCell.lua

module("logic.extensions.dungeon.view.equipdungeon.EquipExploreSeedTabCell", package.seeall)

local M = class("EquipExploreSeedTabCell")

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
	self._btnClick = UIComponentType.ButtonAdapter(self._registry:findUIElement("equip_explore_tab_1677965947"))
	self._imgIcon = self._registry:findUIElement("equip_explore_tab_-1168445025", UIComponentType.Image)
	self._goMarkNormal = self._registry:findUIElement("equip_explore_tab_-1813856249")
	self._goMarkSelect = self._registry:findUIElement("equip_explore_tab_-507459578")
	self._goMarkLock = self._registry:findUIElement("equip_explore_tab_-1038441295")
	self._txtIndex = self._registry:findUIElement("equip_explore_tab_-1837333082", UIComponentType.Text)
	self._txtDifficult = self._registry:findUIElement("equip_explore_tab_-159679757", UIComponentType.Text)
	self._txtName = self._registry:findUIElement("equip_explore_tab_1173612542", UIComponentType.Text)
	self._txtName2 = self._registry:findUIElement("equip_explore_tab_-1924458247", UIComponentType.Text)

	goutil.setActive(self._txtDifficult.gameObject, false)
end

function M:destroyUI()
	self:setHandler(nil)

	self.mainGO = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = false
	end

	self._btnClick = nil
	self._imgIcon = nil
	self._goMarkNormal = nil
	self._goMarkSelect = nil
	self._goMarkLock = nil
	self._txtIndex = nil
	self._txtDifficult = nil
	self._txtName = nil
	self._txtName2 = nil
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickSelf, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:getMainGo()
	return self.mainGO
end

function M:getIndex()
	return self._index
end

function M:setHandler(handler)
	self._handler = handler
end

function M:setIsLock(isLock)
	self._isLock = isLock

	goutil.setActive(self._goMarkLock, isLock)
end

function M:getIsLock()
	return self._isLock
end

function M:getMaterialDungeonId()
	return self._materialDungeonId
end

function M:getCommonDungeonId()
	return self._commonDungeonId
end

function M:setSelected(selected)
	local scale = selected and 1.05 or 1

	goutil.setActive(self._goMarkSelect, selected)
	goutil.setActive(self._goMarkNormal, not selected)
	RectTransformUtils.SetScale(self:getMainGo().transform, scale, scale, 1)
end

function M:setData(index, dungeonData)
	self._materialDungeonId = dungeonData:getMaterialDungeonCode()
	self._commonDungeonId = dungeonData:getCommonDungeonId()
	self._index = index
	self._txtIndex.text = string.format("%02d", index)

	self:updateDifficult(dungeonData)
	self:updateTitle(dungeonData:getName())
	self:updateIcon(dungeonData)
end

function M:setChapterMo(chapterMo)
	return
end

function M:updateTitle(str)
	self._txtName.text = str
	self._txtName2.text = str
end

function M:updateDifficult(dungeonData)
	local diffName = dungeonData and dungeonData:getDifficultyStr() or nil

	self._txtDifficult.text = diffName
end

function M:updateIcon(dungeonData)
	local icon = dungeonData:getBannerRes()

	if not string.nilorempty(icon) then
		IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_EquipExplore, icon)
	end
end

function M:_onClickSelf()
	if self._handler then
		self._handler:cellCallSelectTab(self)
	end
end

return M
