-- chunkname: @modules/logic/fight/view/FightGuideView.lua

module("modules.logic.fight.view.FightGuideView", package.seeall)

local FightGuideView = class("FightGuideView", BaseView)

function FightGuideView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goslider = gohelper.findChild(self.viewGO, "#go_slider")
	self._gocontent = gohelper.findChild(self.viewGO, "mask/#go_content")
	self._goscroll = gohelper.findChild(self.viewGO, "#go_scroll")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_left")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_right")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightGuideView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
end

function FightGuideView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
end

function FightGuideView:_btncloseOnClick()
	if self._btnright.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		self:_setSelect(self._index + 1)
	else
		self:closeThis()
	end
end

function FightGuideView:_btnleftOnClick()
	self:_setSelect(self._index - 1)
end

function FightGuideView:_btnrightOnClick()
	self:_setSelect(self._index + 1)
end

function FightGuideView:_editableInitView()
	gohelper.addUIClickAudio(self._btnleft.gameObject, AudioEnum.UI.Play_UI_help_switch)
	gohelper.addUIClickAudio(self._btnright.gameObject, AudioEnum.UI.Play_UI_help_switch)

	self._selectItems = {}
	self._contentItems = {}
	self._space = recthelper.getWidth(self._gocontent.transform)
	self._scroll = SLFramework.UGUI.UIDragListener.Get(self._goscroll)

	self._scroll:AddDragBeginListener(self._onScrollDragBegin, self)
	self._scroll:AddDragEndListener(self._onScrollDragEnd, self)
end

function FightGuideView:onDestroyView()
	self._scroll:RemoveDragBeginListener()
	self._scroll:RemoveDragEndListener()
end

function FightGuideView:_onScrollDragBegin(param, eventData)
	self._scrollStartPos = eventData.position
end

function FightGuideView:_onScrollDragEnd(param, eventData)
	local scrollEndPos = eventData.position
	local deltaX = scrollEndPos.x - self._scrollStartPos.x
	local deltaY = scrollEndPos.y - self._scrollStartPos.y

	if math.abs(deltaX) < math.abs(deltaY) then
		return
	end

	if deltaX > 100 and self._btnleft.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		self:_setSelect(self._index - 1)
	elseif deltaX < -100 and self._btnright.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		self:_setSelect(self._index + 1)
	end
end

function FightGuideView:onUpdateParam()
	if self._contentItems then
		for _, v in pairs(self._contentItems) do
			gohelper.destroy(v.go)
		end
	end

	self._contentItems = {}

	self:_refreshView()
end

function FightGuideView:onOpen()
	self:_refreshView()
end

function FightGuideView:_refreshView()
	self._list = self.viewParam and self.viewParam.viewParam or {
		1,
		2,
		3,
		4,
		5
	}

	self:_setSelectItems()
	self:_setContentItems()
	self:_setSelect(1)
	gohelper.setActive(self._goslider, #self._list > 1)
end

function FightGuideView:_setSelectItems(index)
	local path = self.viewContainer:getSetting().otherRes[1]

	for i = 1, #self._list do
		local selectItemGO = self:getResInst(path, self._goslider, "SelectItem" .. i)
		local selectItem = MonoHelper.addNoUpdateLuaComOnceToGo(selectItemGO, FightTechniqueSelectItem)

		selectItem:updateItem({
			index = i,
			pos = 55 * (i - 0.5 * (#self._list + 1))
		})
		selectItem:setView(self)
		table.insert(self._selectItems, selectItem)
	end
end

function FightGuideView:_setContentItems()
	local path = self.viewContainer:getSetting().otherRes[2]
	local contentLength = #self._list

	for i = contentLength, 1, -1 do
		local contentItemGO = self:getResInst(path, self._gocontent, "ContentItem" .. i)
		local contentItem = MonoHelper.addNoUpdateLuaComOnceToGo(contentItemGO, FightGuideItem)

		contentItem:updateItem({
			index = i,
			maxIndex = contentLength,
			id = self._list[i],
			pos = self._space * (i - 1)
		})

		self._contentItems[i] = contentItem
	end
end

function FightGuideView:_updateBtns()
	gohelper.setActive(self._btnright.gameObject, self._index < #self._list)
	gohelper.setActive(self._btnleft.gameObject, self._index > 1)
end

function FightGuideView:setSelect(index)
	self:_setSelect(index)
end

function FightGuideView:_setSelect(index)
	self._index = index

	for _, selectItem in pairs(self._selectItems) do
		selectItem:setSelect(index)
	end

	for _, contentItem in pairs(self._contentItems) do
		contentItem:setSelect(index)
	end

	local x = (1 - self._index) * self._space

	ZProj.TweenHelper.DOAnchorPosX(self._gocontent.transform, x, 0.25)
	self:_updateBtns()
end

function FightGuideView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_help_close)
end

return FightGuideView
