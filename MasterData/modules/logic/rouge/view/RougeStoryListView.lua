-- chunkname: @modules/logic/rouge/view/RougeStoryListView.lua

module("modules.logic.rouge.view.RougeStoryListView", package.seeall)

local RougeStoryListView = class("RougeStoryListView", BaseView)

function RougeStoryListView:onInitView()
	self._scrollstorylist = gohelper.findChildScrollRect(self.viewGO, "#scroll_storylist")
	self._goline = gohelper.findChild(self.viewGO, "#scroll_storylist/viewport/content/linelayout/#go_line")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeStoryListView:addEvents()
	return
end

function RougeStoryListView:removeEvents()
	return
end

function RougeStoryListView:_editableInitView()
	self._goStoryListContent = gohelper.findChild(self.viewGO, "#scroll_storylist/viewport/content")
	self._storyItemList = self:getUserDataTb_()
end

function RougeStoryListView:_cloneStoryItem()
	self:_stopStoryItemEnterAnim()

	local storyItemMoList = RougeFavoriteConfig.instance:getStoryList()

	self.storyItemMoList = storyItemMoList

	local path = self.viewContainer:getSetting().otherRes[1]

	for k, v in ipairs(storyItemMoList) do
		local storyItemGO = self._storyItemList[k]

		if not storyItemGO then
			storyItemGO = {
				go = self:getResInst(path, self._goStoryListContent, "item" .. k)
			}
			storyItemGO.anim = storyItemGO.go:GetComponent(typeof(UnityEngine.Animator))
			storyItemGO.item = MonoHelper.addNoUpdateLuaComOnceToGo(storyItemGO.go, RougeStoryListItem)
			storyItemGO.anim.enabled = false

			table.insert(self._storyItemList, storyItemGO)
		end

		gohelper.setActive(storyItemGO.go, false)
		storyItemGO.item:onUpdateMO(v)
	end

	self.playedAnimIndex = 0

	self:_showStoryItemEnterAnim()
end

function RougeStoryListView:_stopStoryItemEnterAnim()
	TaskDispatcher.cancelTask(self._showStoryItemEnterAnim, self)

	for _, storyItem in ipairs(self._storyItemList) do
		storyItem.anim.enabled = false

		gohelper.setActive(storyItem.go, false)
	end
end

function RougeStoryListView:_showStoryItemEnterAnim()
	if self.playedAnimIndex >= #self.storyItemMoList then
		return
	end

	self.playedAnimIndex = self.playedAnimIndex + 1

	gohelper.setActive(self._storyItemList[self.playedAnimIndex].go, true)

	self._storyItemList[self.playedAnimIndex].anim.enabled = true

	TaskDispatcher.runDelay(self._showStoryItemEnterAnim, self, 0.03)
end

function RougeStoryListView:onClose()
	TaskDispatcher.cancelTask(self._showStoryItemEnterAnim, self)
end

function RougeStoryListView:onOpen()
	self:_cloneStoryItem()
end

function RougeStoryListView:onDestroyView()
	return
end

return RougeStoryListView
