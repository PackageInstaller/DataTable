-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotLoadingView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotLoadingView", package.seeall)

local V1a6_CachotLoadingView = class("V1a6_CachotLoadingView", BaseView)

function V1a6_CachotLoadingView:onInitView()
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon/#simage_icon")
	self._txten = gohelper.findChildText(self.viewGO, "#simage_icon/img_en2/#txt_en")
	self._txtname = gohelper.findChildText(self.viewGO, "#simage_icon/#txt_name")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotLoadingView:addEvents()
	return
end

function V1a6_CachotLoadingView:removeEvents()
	return
end

function V1a6_CachotLoadingView:_editableInitView()
	return
end

function V1a6_CachotLoadingView:onUpdateParam()
	return
end

function V1a6_CachotLoadingView:onOpen()
	self._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not self._rogueInfo then
		return
	end

	local roomCo = lua_rogue_room.configDict[self._rogueInfo.room]

	if not roomCo then
		return
	end

	self._simageicon:LoadImage(ResUrl.getV1a6CachotIcon("v1a6_cachot_img_level_1"))

	self._txten.text = roomCo.nameEn

	local name = roomCo.name
	local len = GameUtil.utf8len(name)

	if len <= 1 then
		self._txtname.text = string.format("<size=42>%s</size>", name)
	else
		local first = GameUtil.utf8sub(name, 1, 1)
		local last = GameUtil.utf8sub(name, 2, len - 1)

		self._txtname.text = string.format("<size=42>%s</size>%s", first, last)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_load_open)
	TaskDispatcher.runDelay(self.checkViewIsOpenFinish, self, 2.5)
end

function V1a6_CachotLoadingView:_onOpenView(viewName)
	if viewName == ViewName.V1a6_CachotMainView or viewName == ViewName.V1a6_CachotRoomView then
		TaskDispatcher.runDelay(self.closeThis, self, 0.2)
	end
end

function V1a6_CachotLoadingView:checkViewIsOpenFinish()
	if ViewMgr.instance:isOpenFinish(ViewName.V1a6_CachotMainView) or ViewMgr.instance:isOpenFinish(ViewName.V1a6_CachotRoomView) then
		self:closeThis()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenView, self)
	end
end

function V1a6_CachotLoadingView:onClose()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenView, self)
	TaskDispatcher.cancelTask(self.closeThis, self)
	TaskDispatcher.cancelTask(self.checkViewIsOpenFinish, self)
	self._simageicon:UnLoadImage()
end

function V1a6_CachotLoadingView:onDestroyView()
	return
end

return V1a6_CachotLoadingView
