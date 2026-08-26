-- chunkname: @modules/logic/dungeon/view/DungeonEquipEntryView.lua

module("modules.logic.dungeon.view.DungeonEquipEntryView", package.seeall)

local DungeonEquipEntryView = class("DungeonEquipEntryView", BaseView)

function DungeonEquipEntryView:onInitView()
	self._goscroll = gohelper.findChild(self.viewGO, "#go_scroll")
	self._goslider = gohelper.findChild(self.viewGO, "#go_slider")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_right")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_left")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonEquipEntryView:addEvents()
	self._btnright:AddClickListener(self._btnrightOnClick, self)
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
end

function DungeonEquipEntryView:removeEvents()
	self._btnright:RemoveClickListener()
	self._btnleft:RemoveClickListener()
end

function DungeonEquipEntryView:playBtnLeftOrRightAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
end

function DungeonEquipEntryView:setTargetPageIndex(index)
	self._pageIndex = index
end

function DungeonEquipEntryView:getTargetPageIndex()
	return self._pageIndex
end

function DungeonEquipEntryView:_btnleftOnClick()
	self:setTargetPageIndex(self:getTargetPageIndex() - 1)
	self:selectHelpItem()
end

function DungeonEquipEntryView:_btnrightOnClick()
	self:setTargetPageIndex(self:getTargetPageIndex() + 1)
	self:selectHelpItem()
end

function DungeonEquipEntryView:_editableInitView()
	gohelper.addUIClickAudio(self._btnleft.gameObject, AudioEnum.UI.Play_UI_help_switch)
	gohelper.addUIClickAudio(self._btnright.gameObject, AudioEnum.UI.Play_UI_help_switch)

	self._selectItems = self:getUserDataTb_()
	self._helpItems = self:getUserDataTb_()

	local parentWidth = recthelper.getWidth(self.viewGO.transform)

	self._space = parentWidth + 400
	self._scroll = SLFramework.UGUI.UIDragListener.Get(self._goscroll)

	self._scroll:AddDragBeginListener(self._onScrollDragBegin, self)
	self._scroll:AddDragEndListener(self._onScrollDragEnd, self)
end

function DungeonEquipEntryView:_onScrollDragBegin(param, eventData)
	self._scrollStartPos = eventData.position
end

function DungeonEquipEntryView:_onScrollDragEnd(param, eventData)
	local scrollEndPos = eventData.position
	local deltaX = scrollEndPos.x - self._scrollStartPos.x
	local deltaY = scrollEndPos.y - self._scrollStartPos.y

	if math.abs(deltaX) < math.abs(deltaY) then
		return
	end

	if deltaX > 100 and self._btnleft.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		self:setTargetPageIndex(self:getTargetPageIndex() - 1)
		self:selectHelpItem()
	elseif deltaX < -100 and self._btnright.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		self:setTargetPageIndex(self:getTargetPageIndex() + 1)
		self:selectHelpItem()
	end
end

function DungeonEquipEntryView:onUpdateParam()
	return
end

function DungeonEquipEntryView:onOpen()
	self._chapterId = self.viewParam
	self._pagesCo = {}

	local list = DungeonConfig.instance:getChapterEpisodeCOList(self._chapterId)

	self._episodeCount = #list

	local index = 0

	for i, v in ipairs(list) do
		table.insert(self._pagesCo, v.id)

		local info = DungeonModel.instance:getEpisodeInfo(v.id)

		if DungeonModel.instance:hasPassLevel(v.id) and info.challengeCount == 1 then
			index = index + 1
		else
			self._readyChapterId = v.id

			break
		end
	end

	self:setTargetPageIndex(index + 1)
	self:setSelectItem()
	self:setHelpItem()
	self:setBtnItem()
	self:selectHelpItem(true)
	NavigateMgr.instance:addEscape(ViewName.DungeonEquipEntryView, self.closeThis, self)
end

function DungeonEquipEntryView:setSelectItem()
	local path = self.viewContainer:getSetting().otherRes[1]

	for i = 1, #self._pagesCo do
		local child = self:getResInst(path, self._goslider, "DungeonEquipEntryViewSelectItem")
		local selectItem = DungeonEquipEntryViewSelectItem.New()

		selectItem:init({
			go = child,
			index = i,
			config = self._pagesCo[i],
			pos = 55 * (i - 0.5 * (#self._pagesCo + 1))
		})
		selectItem:updateItem(self:getTargetPageIndex())
		table.insert(self._selectItems, selectItem)
	end
end

function DungeonEquipEntryView:setHelpItem()
	local path = self.viewContainer:getSetting().otherRes[2]

	for i = 1, #self._pagesCo do
		local child = self:getResInst(path, self._gocontent, "DungeonEquipEntryItem")
		local pos = self._space * (i - 1)

		transformhelper.setLocalPos(child.transform, pos, 0, 0)

		local contentItem = MonoHelper.addNoUpdateLuaComOnceToGo(child, DungeonEquipEntryItem, {
			i,
			self._episodeCount,
			self._pagesCo[i],
			#self._pagesCo
		})

		table.insert(self._helpItems, contentItem)
	end
end

function DungeonEquipEntryView:setBtnItem()
	local index = self:getTargetPageIndex()

	gohelper.setActive(self._btnright.gameObject, index < #self._pagesCo)
	gohelper.setActive(self._btnleft.gameObject, index > 1)
end

function DungeonEquipEntryView:selectHelpItem(skipTween)
	for _, v in pairs(self._selectItems) do
		v:updateItem(self:getTargetPageIndex())
	end

	local x = (1 - self:getTargetPageIndex()) * self._space

	if skipTween then
		recthelper.setAnchorX(self._gocontent.transform, x)
	else
		ZProj.TweenHelper.DOAnchorPosX(self._gocontent.transform, x, 0.25)
	end

	self:setBtnItem()
end

function DungeonEquipEntryView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_help_close)
end

function DungeonEquipEntryView:onDestroyView()
	if self._selectItems then
		for _, v in pairs(self._selectItems) do
			v:destroy()
		end

		self._selectItems = nil
	end

	self._scroll:RemoveDragBeginListener()
	self._scroll:RemoveDragEndListener()
end

return DungeonEquipEntryView
