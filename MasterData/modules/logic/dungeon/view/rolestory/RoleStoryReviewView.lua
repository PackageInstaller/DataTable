-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryReviewView.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryReviewView", package.seeall)

local RoleStoryReviewView = class("RoleStoryReviewView", BaseView)

function RoleStoryReviewView:onInitView()
	self.storyItems = {}
	self.goStorytItem = gohelper.findChild(self.viewGO, "left/#go_herocontainer/#scroll_hero/Viewport/Content/#go_heroitem")
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "right/#txt_title")
	self.goLayout = gohelper.findChild(self.viewGO, "right/layout")
	self.txtEnd = gohelper.findChildTextMesh(self.viewGO, "right/#txt_end")
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_close")
	self.goTalk = gohelper.findChild(self.goLayout, "#go_Talk")
	self.goArrow = gohelper.findChild(self.goLayout, "#go_Talk/Scroll DecView/Viewport/Content/arrow")
	self.goChatItem = gohelper.findChild(self.goLayout, "#go_Talk/Scroll DecView/Viewport/Content/#go_chatitem")

	gohelper.setActive(self.goChatItem, false)

	self.scroll = gohelper.findChildScrollRect(self.goLayout, "#go_Talk/Scroll DecView")
	self.talkList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryReviewView:addEvents()
	self.addClickCb(self, self.btnClose, self.onClickBtnClose, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.ClickReviewItem, self._onClickReviewItem, self)
end

function RoleStoryReviewView:removeEvents()
	return
end

function RoleStoryReviewView:_editableInitView()
	return
end

function RoleStoryReviewView:onClickBtnClose()
	self:closeThis()
end

function RoleStoryReviewView:_onClickReviewItem(dispatchId)
	self:refreshDispatchView(dispatchId)
end

function RoleStoryReviewView:onOpen()
	self.storyId = self.viewParam.storyId

	self:refreshDispatchList()

	local defaultIndex = 1
	local item = self.storyItems[defaultIndex]

	if item then
		item:onClickBtnClick()
	end
end

function RoleStoryReviewView:refreshDispatchList()
	local list = RoleStoryConfig.instance:getDispatchList(self.storyId, RoleStoryEnum.DispatchType.Story) or {}

	for i = 1, math.max(#list, #self.storyItems) do
		self:refreshDispatchItem(self.storyItems[i], list[i], i)
	end
end

function RoleStoryReviewView:refreshDispatchView(dispatchId)
	local config = RoleStoryConfig.instance:getDispatchConfig(dispatchId)

	self.txtTitle.text = config.name
	self.txtEnd.text = config.completeDesc

	self:refreshTalk(config)

	for i, v in ipairs(self.storyItems) do
		v:updateSelect(dispatchId)
	end

	self:layoutView()
end

function RoleStoryReviewView:refreshDispatchItem(item, data, index)
	item = item or self:createItem(index)

	item:onUpdateMO(data, index)
end

function RoleStoryReviewView:createItem(index)
	local go = gohelper.cloneInPlace(self.goStorytItem)
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoleStoryReviewItem)

	self.storyItems[index] = item

	return item
end

function RoleStoryReviewView:refreshTalk(config)
	local talkIds = string.splitToNumber(config.talkIds, "#")

	self:refreshTalkList(talkIds)
end

function RoleStoryReviewView:refreshTalkList(talkIds)
	local list = {}

	for i, v in ipairs(talkIds) do
		local talkCfg = RoleStoryConfig.instance:getTalkConfig(v)

		table.insert(list, talkCfg)
	end

	for i = 1, math.max(#list, #self.talkList) do
		self:refreshTalkItem(self.talkList[i], list[i], i)
	end
end

function RoleStoryReviewView:refreshTalkItem(item, data, index)
	item = item or self:createTalkItem(index)

	item:onUpdateMO(data, index)
end

function RoleStoryReviewView:createTalkItem(index)
	local go = gohelper.cloneInPlace(self.goChatItem, string.format("go%s", index))
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoleStoryDispatchTalkItem)

	self.talkList[index] = item

	return item
end

function RoleStoryReviewView:layoutView()
	local talkHeight = recthelper.getHeight(self.goLayout.transform)

	recthelper.setHeight(self.goTalk.transform, talkHeight)
end

function RoleStoryReviewView:onClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	self:closeThis()
end

function RoleStoryReviewView:onClose()
	return
end

function RoleStoryReviewView:onDestroyView()
	return
end

return RoleStoryReviewView
