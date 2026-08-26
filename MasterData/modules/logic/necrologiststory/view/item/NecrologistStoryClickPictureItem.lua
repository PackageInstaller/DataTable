-- chunkname: @modules/logic/necrologiststory/view/item/NecrologistStoryClickPictureItem.lua

module("modules.logic.necrologiststory.view.item.NecrologistStoryClickPictureItem", package.seeall)

local NecrologistStoryClickPictureItem = class("NecrologistStoryClickPictureItem", NecrologistStoryControlItem)

function NecrologistStoryClickPictureItem:onInit()
	self.anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.txtContent = gohelper.findChildTextMesh(self.viewGO, "root/txtContent")
	self.btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "root/go_click")
	self.simageNormal = gohelper.findChildSingleImage(self.viewGO, "root/go_click/normal")
	self.simageFinished = gohelper.findChildSingleImage(self.viewGO, "root/go_click/finished")
	self.goTips = gohelper.findChild(self.viewGO, "root/go_click/tips")
end

function NecrologistStoryClickPictureItem:onAddEvent()
	self.addClickCb(self, self.btnClick, self.onClickClick, self)
end

function NecrologistStoryClickPictureItem:onRemoveEvent()
	self:removeClickCb(self.btnClick)
end

function NecrologistStoryClickPictureItem:onClickClick()
	if self:isDone() then
		return
	end

	self._isFinish = true

	self:refreshState()
	self:onPlayFinish()
end

function NecrologistStoryClickPictureItem:setClickEnabled(isEnabled)
	if self.btnClick then
		self.btnClick.button.interactable = isEnabled
	end
end

function NecrologistStoryClickPictureItem:onPlayStory()
	self._isFinish = false
	self.txtContent.text = NecrologistStoryHelper.getDesc(self._storyId)

	local picResList = string.split(self._controlParam, "#")

	self.simageNormal:LoadImage(ResUrl.getNecrologistStoryPicBg(picResList[1]), self.onSimageNormalLoaded, self)
	self.simageFinished:LoadImage(ResUrl.getNecrologistStoryPicBg(picResList[2]), self.onSimageFinishedLoaded, self)
	self:refreshState()
end

function NecrologistStoryClickPictureItem:refreshState()
	local isDone = self:isDone()

	self:setClickEnabled(not isDone)
	gohelper.setActive(self.simageNormal.gameObject, not isDone)
	gohelper.setActive(self.simageFinished.gameObject, isDone)
	gohelper.setActive(self.goTips, not isDone)

	if isDone then
		self.anim:Play("finish")
	else
		self.anim:Play("open")
	end
end

function NecrologistStoryClickPictureItem:onSimageNormalLoaded()
	ZProj.UGUIHelper.SetImageSize(self.simageNormal.gameObject)
end

function NecrologistStoryClickPictureItem:onSimageFinishedLoaded()
	ZProj.UGUIHelper.SetImageSize(self.simageFinished.gameObject)
end

function NecrologistStoryClickPictureItem:isDone()
	return self._isFinish
end

function NecrologistStoryClickPictureItem:caleHeight()
	return 400
end

function NecrologistStoryClickPictureItem:onDestroy()
	self.simageNormal:UnLoadImage()
	self.simageFinished:UnLoadImage()
end

function NecrologistStoryClickPictureItem.getResPath()
	return "ui/viewres/dungeon/rolestory/item/necrologiststoryclickpictureitem.prefab"
end

return NecrologistStoryClickPictureItem
