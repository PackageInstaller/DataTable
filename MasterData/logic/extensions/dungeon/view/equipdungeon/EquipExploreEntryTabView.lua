-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/equipdungeon/EquipExploreEntryTabView.lua

module("logic.extensions.dungeon.view.equipdungeon.EquipExploreEntryTabView", package.seeall)

local M = class("EquipExploreEntryTabView")
local colorNormal = Color.New(1, 1, 1, 1)
local colorLock = Color.New(0.6862, 0.6862, 0.6862, 1)

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
	self:setHandler(nil)
	self:destroyUI()
end

function M:buildUI()
	self._imgIcon = self._registry:findUIElement("equip_explore_pos_entry_-791931215", UIComponentType.Image)
	self._txtName = self._registry:findUIElement("equip_explore_pos_entry_1941058240", UIComponentType.Text)
	self._btnClick = UIComponentType.ButtonAdapter(self._registry:findUIElement("equip_explore_pos_entry_-754262255"))
	self._lockGo = self._registry:findUIElement("equip_explore_pos_entry_-932613970")
end

function M:destroyUI()
	self.mainGO = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = false
	end
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

function M:setHandler(handler)
	self._handler = handler
end

function M:setIsLock(isLock)
	self._isLock = isLock
end

function M:getIsLock()
	return self._isLock
end

function M:getChapterId()
	return self._chapterId
end

function M:getName()
	return self._txtName.text
end

function M:getOpenTimeStr()
	return self._txtOpenTime.text
end

function M:setChapterMo(chapterMo)
	self._chapterId = chapterMo:getChapterId()

	self:updateTitle(chapterMo:getName())
	self:updateIcon()
	goutil.setActive(self._lockGo, self._isLock)
end

function M:updateTitle(str)
	self._txtName.text = str
end

function M:updateOpenTime(chapterMo)
	self._txtOpenTime.text = chapterMo:getWeekDayStr()
end

function M:updateIcon()
	if self._isLock then
		if not self._grayMat then
			self._grayMat = CommonPreloader.instance:getMaterialsCommAsset(CommonResPath.UIGray)
		end

		self._imgIcon.material = self._grayMat
		self._imgIcon.color = colorLock
	else
		self._imgIcon.material = nil
		self._imgIcon.color = colorNormal
	end
end

function M:_onClickSelf()
	if self._handler then
		self._handler:onClickEntry(self:getChapterId())
	end
end

return M
