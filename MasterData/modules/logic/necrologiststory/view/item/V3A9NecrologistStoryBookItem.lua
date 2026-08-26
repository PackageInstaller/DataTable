-- chunkname: @modules/logic/necrologiststory/view/item/V3A9NecrologistStoryBookItem.lua

module("modules.logic.necrologiststory.view.item.V3A9NecrologistStoryBookItem", package.seeall)

local V3A9NecrologistStoryBookItem = class("V3A9NecrologistStoryBookItem", NecrologistStoryBaseItem)

function V3A9NecrologistStoryBookItem:onInit()
	self.goUnOpen = gohelper.findChild(self.viewGO, "root/node_unopen")
	self.goOpened = gohelper.findChild(self.viewGO, "root/node_open")
	self.btnOpen = gohelper.findChildButtonWithAudio(self.viewGO, "root/node_unopen/#btn_open")
	self.animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self.animPic = gohelper.findChildAnim(self.viewGO, "root/node_photo/node_pic2/pic_2")
	self.goTxTOpen = gohelper.findChild(self.viewGO, "root/txt_open")
end

function V3A9NecrologistStoryBookItem:onAddEvent()
	self.addClickCb(self, self.btnOpen, self.onClickBtn, self)
end

function V3A9NecrologistStoryBookItem:onRemoveEvent()
	self:removeClickCb(self.btnOpen)
end

function V3A9NecrologistStoryBookItem:onClickBtn()
	if self.isClicked then
		return
	end

	self.isClicked = true

	gohelper.setActive(self.goTxTOpen, false)

	local storyConfig = self:getStoryConfig()
	local animType = tonumber(storyConfig.param)

	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_wulu_paiqian_open)

	if animType == 2 then
		self.animatorPlayer:Play("openbook2", self.onPlayOpenBookFinish2, self)
	else
		self.animatorPlayer:Play("openbook1", self.onPlayOpenBookFinish1, self)
	end
end

function V3A9NecrologistStoryBookItem:onPlayOpenBookFinish1()
	self.animPic:Play("click")
	self:onPlayFinish(true)
end

function V3A9NecrologistStoryBookItem:onPlayOpenBookFinish2()
	self:onPlayFinish(true)
end

function V3A9NecrologistStoryBookItem:onPlayStory(isSkip)
	self.isClicked = false

	gohelper.setActive(self.goTxTOpen, true)
	self.animatorPlayer:Play("open", self.onPlayOpenFinish, self)
end

function V3A9NecrologistStoryBookItem:onPlayOpenFinish()
	return
end

function V3A9NecrologistStoryBookItem:caleHeight()
	return 400
end

function V3A9NecrologistStoryBookItem:isDone()
	return self.isRecorded
end

function V3A9NecrologistStoryBookItem:onDestroy()
	return
end

function V3A9NecrologistStoryBookItem.getResPath()
	return "ui/viewres/dungeon/rolestory/item/v3a9_rolestoryinteractitem_2.prefab"
end

return V3A9NecrologistStoryBookItem
