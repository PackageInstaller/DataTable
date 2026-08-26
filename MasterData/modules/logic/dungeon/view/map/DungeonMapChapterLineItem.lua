-- chunkname: @modules/logic/dungeon/view/map/DungeonMapChapterLineItem.lua

module("modules.logic.dungeon.view.map.DungeonMapChapterLineItem", package.seeall)

local DungeonMapChapterLineItem = class("DungeonMapChapterLineItem", BaseChildView)

function DungeonMapChapterLineItem:onInitView()
	self._gochoiceicon = gohelper.findChild(self.viewGO, "#go_choiceicon")
	self._simageicon1 = gohelper.findChildImage(self.viewGO, "#go_choiceicon/#simage_icon1")
	self._gonormalicon = gohelper.findChild(self.viewGO, "#go_normalicon")
	self._simageicon2 = gohelper.findChildImage(self.viewGO, "#go_normalicon/#simage_icon2")
	self._golockicon = gohelper.findChild(self.viewGO, "#go_lockicon")
	self._simageicon3 = gohelper.findChildImage(self.viewGO, "#go_lockicon/#simage_icon3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMapChapterLineItem:addEvents()
	return
end

function DungeonMapChapterLineItem:removeEvents()
	return
end

function DungeonMapChapterLineItem:_onClick()
	if self._isSelect then
		return
	end

	if DungeonModel.instance.chapterBgTweening then
		return
	end

	if self._isLock then
		if self._lockCode == -1 then
			GameFacade.showToast(ToastEnum.DungeonChapterLine1)
		elseif self._lockCode == -2 then
			-- block empty
		elseif self._lockCode == -3 then
			GameFacade.showToast(ToastEnum.DungeonChapterLine3)
		elseif self._lockCode == -4 and self._lockToast then
			GameFacade.showToast(self._lockToast, self._lockToastParam)
		end

		return
	end

	if not self._openTimeValid then
		GameFacade.showToast(ToastEnum.DungeonResChapter, self._config.name)

		return
	end

	DungeonModel.instance:changeCategory(self._config.type, false)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeChapter, self._config.id)
end

function DungeonMapChapterLineItem:_editableInitView()
	self._click = gohelper.getClickWithAudio(self.viewGO, AudioEnum.UI.UI_checkpoint_detailed_tabs_click)

	self._click:AddClickListener(self._onClick, self)
end

function DungeonMapChapterLineItem:updateStatus()
	self:onSelect(self._config.id == DungeonModel.instance.curLookChapterId)
end

function DungeonMapChapterLineItem:onSelect(isSelect)
	gohelper.setActive(self._gochoiceicon, self._openTimeValid and isSelect)
	gohelper.setActive(self._gonormalicon, self._openTimeValid and not isSelect)
	gohelper.setActive(self._golockicon, not self._openTimeValid)
end

function DungeonMapChapterLineItem:onUpdateParam()
	self._config = self.viewParam.config
	self._isLock, self._lockCode, self._lockToast, self._lockToastParam = DungeonModel.instance:chapterIsLock(self._config.id)
	self._openTimeValid = DungeonModel.instance:getChapterOpenTimeValid(self._config)

	local navigationIcon = "bg_fuben_wenzi_" .. self.viewParam.index

	if self._openTimeValid then
		UISpriteSetMgr.instance:setDungeonNavigationSprite(self._simageicon1, navigationIcon)
		UISpriteSetMgr.instance:setDungeonNavigationSprite(self._simageicon2, navigationIcon)
	else
		UISpriteSetMgr.instance:setDungeonNavigationSprite(self._simageicon3, navigationIcon .. "_dis")
	end
end

function DungeonMapChapterLineItem:onOpen()
	self:onUpdateParam()
end

function DungeonMapChapterLineItem:onClose()
	return
end

function DungeonMapChapterLineItem:onDestroyView()
	self._click:RemoveClickListener()
end

return DungeonMapChapterLineItem
