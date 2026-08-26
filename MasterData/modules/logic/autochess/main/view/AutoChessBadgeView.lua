-- chunkname: @modules/logic/autochess/main/view/AutoChessBadgeView.lua

module("modules.logic.autochess.main.view.AutoChessBadgeView", package.seeall)

local AutoChessBadgeView = class("AutoChessBadgeView", BaseView)

function AutoChessBadgeView:onInitView()
	self._scrollBadge = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_Badge")
	self._goBadgeContent = gohelper.findChild(self.viewGO, "root/#scroll_Badge/viewport/#go_BadgeContent")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessBadgeView:_editableInitView()
	self._scrollBadgeGo = self._scrollBadge.gameObject
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrollBadgeGo)

	self._drag:AddDragBeginListener(self._onDragBeginHandler, self)
	self._drag:AddDragEndListener(self._onDragEndHandler, self)

	self._touch = SLFramework.UGUI.UIClickListener.Get(self._scrollBadgeGo)

	self._touch:AddClickDownListener(self._onClickDownHandler, self)

	self._audioScroll = MonoHelper.addLuaComOnceToGo(self._scrollBadgeGo, DungeonMapEpisodeAudio, self._scrollBadge)
end

function AutoChessBadgeView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_page_turn)

	self.actId = Activity182Model.instance:getCurActId()
	self.actMo = Activity182Model.instance:getActMo()
	self.rankCoList = {}

	local list = lua_auto_chess_rank.configDict[self.actId]

	for _, v in ipairs(list) do
		if v.isShow then
			self.rankCoList[#self.rankCoList + 1] = v
		end
	end

	if next(self.rankCoList) then
		self.curIndex = 0

		self:delayInit()
		TaskDispatcher.runRepeat(self.delayInit, self, 0.1)
	end
end

function AutoChessBadgeView:delayInit()
	self.curIndex = self.curIndex + 1

	local co = self.rankCoList[self.curIndex]
	local go = self:getResInst(AutoChessStrEnum.ResPath.BadgeItem, self._goBadgeContent)
	local badgeItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessBadgeItem)

	badgeItem:setData(co.rankId, self.actMo.score, AutoChessBadgeItem.ShowType.BadgeView)

	if self.curIndex >= #self.rankCoList then
		TaskDispatcher.cancelTask(self.delayInit, self)
	end
end

function AutoChessBadgeView:onDestroyView()
	TaskDispatcher.cancelTask(self.delayInit, self)

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end

	if self._touch then
		self._touch:RemoveClickDownListener()

		self._touch = nil
	end
end

function AutoChessBadgeView:_onDragBeginHandler()
	self._audioScroll:onDragBegin()
end

function AutoChessBadgeView:_onDragEndHandler()
	self._audioScroll:onDragEnd()
end

function AutoChessBadgeView:_onClickDownHandler()
	self._audioScroll:onClickDown()
end

return AutoChessBadgeView
