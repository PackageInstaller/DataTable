-- chunkname: @modules/logic/dungeon/view/chapter/DungeonChapterLineItem.lua

module("modules.logic.dungeon.view.chapter.DungeonChapterLineItem", package.seeall)

local DungeonChapterLineItem = class("DungeonChapterLineItem", BaseChildView)

function DungeonChapterLineItem:onInitView()
	self._gonumber = gohelper.findChild(self.viewGO, "#go_number")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_number/#image_icon")
	self._txt1 = gohelper.findChildText(self.viewGO, "#go_number/#txt_1")
	self._txt2 = gohelper.findChildText(self.viewGO, "#go_number/#txt_2")
	self._goicon = gohelper.findChild(self.viewGO, "#go_icon")
	self._gochoiceicon = gohelper.findChild(self.viewGO, "#go_icon/#go_choiceicon")
	self._gonormalicon = gohelper.findChild(self.viewGO, "#go_icon/#go_normalicon")
	self._simageicon1 = gohelper.findChildImage(self.viewGO, "#go_icon/#go_choiceicon/#simage_icon1")
	self._simageicon2 = gohelper.findChildImage(self.viewGO, "#go_icon/#go_normalicon/#simage_icon2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonChapterLineItem:addEvents()
	return
end

function DungeonChapterLineItem:removeEvents()
	return
end

function DungeonChapterLineItem:_onClick()
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

function DungeonChapterLineItem:_editableInitView()
	self._click = gohelper.getClickWithAudio(self.viewGO, AudioEnum.UI.UI_checkpoint_detailed_tabs_click)

	self._click:AddClickListener(self._onClick, self)
end

function DungeonChapterLineItem:updateStatus()
	self:onSelect(self._config.id == DungeonModel.instance.curLookChapterId)
end

function DungeonChapterLineItem:onSelect(isSelect)
	gohelper.setActive(self._gochoiceicon, isSelect)
	gohelper.setActive(self._gonormalicon, not isSelect)

	if self._showIcon then
		return
	end

	local roman = GameUtil.getRomanNums(self.viewParam.index)

	self._txt1.gameObject:SetActive(not isSelect)
	self._txt2.gameObject:SetActive(isSelect)

	self._isSelect = isSelect

	if isSelect then
		self._txt2.text = roman

		UISpriteSetMgr.instance:setUiFBSprite(self._imageicon, "qh1", true)
	else
		self._txt1.text = roman

		if self._isLock then
			UISpriteSetMgr.instance:setUiFBSprite(self._imageicon, "qh3", true)
			SLFramework.UGUI.GuiHelper.SetColor(self._txt1, "#B7B6B6")

			return
		end

		UISpriteSetMgr.instance:setUiFBSprite(self._imageicon, "qh2", true)
		SLFramework.UGUI.GuiHelper.SetColor(self._txt1, "#201E1E")
	end
end

function DungeonChapterLineItem:onUpdateParam()
	self._config = self.viewParam.config
	self._isLock, self._lockCode, self._lockToast, self._lockToastParam = DungeonModel.instance:chapterIsLock(self._config.id)
	self._showIcon = LuaUtil.isEmptyStr(self._config.navigationIcon) == false

	gohelper.setActive(self._gonumber, not self._showIcon)
	gohelper.setActive(self._goicon, self._showIcon)

	self._openTimeValid = DungeonModel.instance:getChapterOpenTimeValid(self._config)

	if self._showIcon then
		UISpriteSetMgr.instance:setDungeonNavigationSprite(self._simageicon1, (self._openTimeValid or nil) and (self._config.navigationIcon or self._config.navigationIcon .. "_dis"))
		UISpriteSetMgr.instance:setDungeonNavigationSprite(self._simageicon2, (self._openTimeValid or nil) and (self._config.navigationIcon or self._config.navigationIcon .. "_dis"))
	end
end

function DungeonChapterLineItem:onOpen()
	self:onUpdateParam()
end

function DungeonChapterLineItem:onClose()
	return
end

function DungeonChapterLineItem:onDestroyView()
	self._click:RemoveClickListener()
end

return DungeonChapterLineItem
