-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotStoreView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotStoreView", package.seeall)

local V1a6_CachotStoreView = class("V1a6_CachotStoreView", BaseView)

function V1a6_CachotStoreView:onInitView()
	self._btnexit = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_exit")
end

function V1a6_CachotStoreView:addEvents()
	self._btnexit:AddClickListener(self._onClickExit, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateGoodsInfos, self._refreshView, self)
end

function V1a6_CachotStoreView:removeEvents()
	self._btnexit:RemoveClickListener()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateGoodsInfos, self._refreshView, self)
end

function V1a6_CachotStoreView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_store_open)
	self:_refreshView()
end

function V1a6_CachotStoreView:_refreshView()
	V1a6_CachotStoreListModel.instance:setList(V1a6_CachotModel.instance:getGoodsInfos() or {})
end

function V1a6_CachotStoreView:_onClickExit()
	RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, self.viewParam.eventId, self.closeThis, self)
end

return V1a6_CachotStoreView
