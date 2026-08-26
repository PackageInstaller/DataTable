-- chunkname: @modules/logic/necrologiststory/game/v3a4/V3A4_RoleStoryLevelView.lua

module("modules.logic.necrologiststory.game.v3a4.V3A4_RoleStoryLevelView", package.seeall)

local V3A4_RoleStoryLevelView = class("V3A4_RoleStoryLevelView", BaseView)

function V3A4_RoleStoryLevelView:onInitView()
	self.goFinish = gohelper.findChild(self.viewGO, "#go_finish")
	self.animFinish = self.goFinish:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A4_RoleStoryLevelView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V3A4_RoleStoryLevelView:removeEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V3A4_RoleStoryLevelView:_editableInitView()
	return
end

function V3A4_RoleStoryLevelView:_onCloseViewFinish(viewName)
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName)

	if not isTop then
		return
	end

	self:refreshView()
end

function V3A4_RoleStoryLevelView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_gt_yishi_open1)
	self:refreshParam()
	self:refreshView()
end

function V3A4_RoleStoryLevelView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function V3A4_RoleStoryLevelView:refreshParam()
	local storyId = self.viewParam.roleStoryId

	self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(storyId)
end

function V3A4_RoleStoryLevelView:refreshView()
	self:initItemList()
	self:refreshFinish()
end

function V3A4_RoleStoryLevelView:initItemList()
	if self.itemList then
		for _, item in ipairs(self.itemList) do
			item:refreshView()
		end

		return
	end

	local list = NecrologistStoryV3A4Config.instance:getBaseList()

	self.itemList = {}

	for i, v in ipairs(list) do
		local go = gohelper.findChild(self.viewGO, string.format("Map/Content/go_item%s/go_mapitem", i))
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, V3A4_RoleStoryLevelItem)

		item.index = i

		item:setData(v, self.gameBaseMO)
		table.insert(self.itemList, item)
	end
end

function V3A4_RoleStoryLevelView:refreshFinish()
	local isFinish = self.gameBaseMO:isAllBaseFinish()

	gohelper.setActive(self.goFinish, isFinish)

	if isFinish then
		if self.isFinish == false then
			AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_gt_yishi_complet)
		else
			self.animFinish:Play("rolestorylevelview_finish", 0, 1)
		end
	end

	self.isFinish = isFinish
end

function V3A4_RoleStoryLevelView:onDestroyView()
	return
end

return V3A4_RoleStoryLevelView
