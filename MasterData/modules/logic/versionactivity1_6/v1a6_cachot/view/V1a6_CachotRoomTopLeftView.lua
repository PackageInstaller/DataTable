-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRoomTopLeftView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoomTopLeftView", package.seeall)

local V1a6_CachotRoomTopLeftView = class("V1a6_CachotRoomTopLeftView", BaseView)

function V1a6_CachotRoomTopLeftView:onInitView()
	self._btnexit = gohelper.findChildButtonWithAudio(self.viewGO, "top/#btn_exit")
	self._btntips = gohelper.findChildButtonWithAudio(self.viewGO, "top/#btn_tips")
	self._txtroomIndex = gohelper.findChildTextMesh(self.viewGO, "top/#go_level/#txt_level")
	self._golayerTips = gohelper.findChild(self.viewGO, "top/#go_level/#go_layertips")
	self._txtlayertitle = gohelper.findChildTextMesh(self.viewGO, "top/#go_level/#go_layertips/#txt_title")
	self._golayereventitem = gohelper.findChild(self.viewGO, "top/#go_level/#go_layertips/events/#go_tipsitem")
	self._golayereventitemParent = self._golayereventitem.transform.parent.gameObject
	self._btnshowlayertips = gohelper.findChildButtonWithAudio(self.viewGO, "top/#go_level/#btn_showlayertips")
	self._eventItem = gohelper.findChild(self.viewGO, "top/#go_level/layout/buff1")
	self._eventParent = self._eventItem.transform.parent.gameObject
end

function V1a6_CachotRoomTopLeftView:addEvents()
	NavigateMgr.instance:addEscape(ViewName.V1a6_CachotRoomView, self._btnexitOnClick, self)
	self._btnexit:AddClickListener(self._btnexitOnClick, self)
	self._btntips:AddClickListener(self._btntipsOnClick, self)
	self._btnshowlayertips:AddClickListener(self._btnshowlayertipsOnClick, self)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateRogueInfo, self._refreshRoomInfo, self)
end

function V1a6_CachotRoomTopLeftView:removeEvents()
	NavigateMgr.instance:removeEscape(ViewName.ExploreView)
	self._btnexit:RemoveClickListener()
	self._btntips:RemoveClickListener()
	self._btnshowlayertips:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateRogueInfo, self._refreshRoomInfo, self)
end

function V1a6_CachotRoomTopLeftView:_btnshowlayertipsOnClick()
	if not self._eventParent.activeSelf then
		return
	end

	local isShow = not self._golayerTips.activeSelf

	gohelper.setActive(self._golayerTips, isShow)
end

function V1a6_CachotRoomTopLeftView:_onTouchScreen()
	if gohelper.isMouseOverGo(self._btnshowlayertips) then
		return
	end

	gohelper.setActive(self._golayerTips, false)
end

function V1a6_CachotRoomTopLeftView:_btntipsOnClick()
	HelpController.instance:showHelp(HelpEnum.HelpId.Cachot1_6TotalHelp)
end

function V1a6_CachotRoomTopLeftView:_btnexitOnClick()
	if self:isOpenView() then
		return
	end

	V1a6_CachotStatController.instance:bakeRogueInfoMo()
	V1a6_CachotStatController.instance:statAbort()
	V1a6_CachotRoomModel.instance:clearRoomChangeStatus()
	MainController.instance:enterMainScene()
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6EnterView)
		VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, V1a6_CachotEnum.ActivityId)
	end)
end

function V1a6_CachotRoomTopLeftView:isOpenView()
	local haveOpenView = not ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView, {
		ViewName.GuideStepEditor
	})

	return (PopupController.instance:getPopupCount() > 0 or nil) and true
end

function V1a6_CachotRoomTopLeftView:onOpen()
	gohelper.setActive(self._golayerTips, false)
	self:_refreshRoomInfo()
end

function V1a6_CachotRoomTopLeftView:_refreshRoomInfo()
	self._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not self._rogueInfo then
		return
	end

	self._txtroomIndex.text = self._rogueInfo.layer

	if #self._rogueInfo.nextEvents == 0 then
		gohelper.setActive(self._eventParent, false)
	else
		gohelper.setActive(self._eventParent, true)

		local datas = {}

		datas[1] = 1

		for i = 1, #self._rogueInfo.nextEvents do
			datas[i + 1] = self._rogueInfo.nextEvents[i]
		end

		gohelper.CreateObjList(self, self._createEventItem, datas, self._eventParent, self._eventItem, nil, 2)
		gohelper.CreateObjList(self, self._createEventItemInfo, self._rogueInfo.nextEvents, self._golayereventitemParent, self._golayereventitem)
	end

	local layer, totalLayer = V1a6_CachotRoomConfig.instance:getLayerIndexAndTotal(self._rogueInfo.room)

	self._txtlayertitle.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a6_cachot_room_event_title"), {
		layer,
		totalLayer
	})
end

function V1a6_CachotRoomTopLeftView:_createEventItem(obj, data, index)
	local eventCo = lua_rogue_event.configDict[data.eventId]
	local image = obj:GetComponent(gohelper.Type_Image)

	UISpriteSetMgr.instance:setV1a6CachotSprite(image, "v1a6_cachot_room_eventicon_small" .. eventCo.icon)
end

function V1a6_CachotRoomTopLeftView:_createEventItemInfo(obj, data, index)
	local eventCo = lua_rogue_event.configDict[data.eventId]
	local desc = gohelper.findChildTextMesh(obj, "desc")
	local icon = gohelper.findChildImage(obj, "desc/icon")

	desc.text = eventCo.title

	UISpriteSetMgr.instance:setV1a6CachotSprite(icon, "v1a6_cachot_room_eventicon_small" .. eventCo.icon)
end

return V1a6_CachotRoomTopLeftView
