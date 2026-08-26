-- chunkname: @modules/logic/dungeon/view/DungeonResourceView.lua

module("modules.logic.dungeon.view.DungeonResourceView", package.seeall)

local DungeonResourceView = class("DungeonResourceView", BaseView)

function DungeonResourceView:onInitView()
	self._simageresourcebg = gohelper.findChildSingleImage(self.viewGO, "#go_resource/#simage_resourcebg")
	self._simagerebottommaskbg = gohelper.findChildSingleImage(self.viewGO, "#go_resource/#simage_bottommaskbg")
	self._simagedrawbg = gohelper.findChildSingleImage(self.viewGO, "#go_resource/#simage_drawbg")
	self._gorescontent = gohelper.findChild(self.viewGO, "#go_resource/chapterlist/#scroll_chapter_resource/#go_rescontent")
	self._scrollchapterresource = gohelper.findChildScrollRect(self.viewGO, "#go_resource/chapterlist/#scroll_chapter_resource")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonResourceView:addEvents()
	return
end

function DungeonResourceView:removeEvents()
	return
end

function DungeonResourceView:_editableInitView()
	self._itemList = self:getUserDataTb_()
	self._width = 777
	self._space = 35

	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnShowResourceView, self._OnShowResourceView, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._OnActStateChange, self)
end

function DungeonResourceView:onOpen()
	return
end

function DungeonResourceView:_OnActStateChange()
	self._index = 1

	local list = DungeonChapterListModel.instance:getFbList()

	self:addChapterItem(list)

	for i, item in ipairs(self._itemList) do
		if i >= self._index then
			gohelper.setActive(item.viewGO, false)
		end
	end
end

function DungeonResourceView:_OnShowResourceView()
	self._index = 1

	self._simageresourcebg:LoadImage(ResUrl.getDungeonIcon("full/bg123"))
	self._simagerebottommaskbg:LoadImage(ResUrl.getDungeonIcon("bg_down"))
	self._simagedrawbg:LoadImage(ResUrl.getDungeonIcon("qianbihua"))

	local list = DungeonChapterListModel.instance:getFbList()

	self:addChapterItem(list)

	for i, item in ipairs(self._itemList) do
		if i >= self._index then
			gohelper.setActive(item.viewGO, false)
		end
	end
end

function DungeonResourceView:addChapterItem(list)
	if not list then
		return
	end

	for i, v in ipairs(list) do
		local item = self:getChapterItem(self._index)

		item:updateParam(v)

		self._index = self._index + 1
	end

	local count = #list
	local canDrag = count >= 3

	recthelper.setWidth(self._gorescontent.transform, (canDrag and count or 0) * (self._width + self._space))

	self._scrollchapterresource.movementType = canDrag and 1 or 2
end

function DungeonResourceView:getChapterItem(index)
	local item = self._itemList[index]

	if not item then
		local path = self.viewContainer:getSetting().otherRes[2]
		local go = self:getResInst(path, self._gorescontent, "chapteritem" .. index)
		local posX = 391 + (index - 1) * (self._width + self._space)
		local posY = -237.5

		recthelper.setAnchor(go.transform, posX, posY)

		item = DungeonResChapterItem.New()

		item:initView(go)

		self._itemList[index] = item
	end

	gohelper.setActive(item.viewGO, true)

	local animGO = gohelper.findChild(item.viewGO, "anim")
	local anim = animGO and animGO:GetComponent(typeof(UnityEngine.Animation))

	if anim then
		anim:Play()
	end

	return item
end

function DungeonResourceView:onDestroyView()
	for i, v in ipairs(self._itemList) do
		v:destroyView()
	end

	self._simageresourcebg:UnLoadImage()
	self._simagerebottommaskbg:UnLoadImage()
	self._simagedrawbg:UnLoadImage()
end

return DungeonResourceView
