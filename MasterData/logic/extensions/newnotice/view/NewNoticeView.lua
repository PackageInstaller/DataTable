-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newnotice/view/NewNoticeView.lua

module("logic.extensions.newnotice.view.NewNoticeView", package.seeall)

local NewNoticeView = class("NewNoticeView", ViewComponent)

function NewNoticeView:ctor()
	NewNoticeView.super.ctor(self)

	self._activityNoticeGoggle = nil
	self._gameNoticeToggle = nil
	self._closeBtn = nil
	self._closeBtn2 = nil
	self._noticeContent = nil
	self._noticeCellTemplete = nil
	self._webViewPanelRT = nil
	self._curNoticeId = 0
	self._noticeData = nil
end

function NewNoticeView:buildUI()
	local goTopTabRoot = self:getGo("universal_tips_tab_top_-1642209997")

	self._activityNoticeGoggle = goutil.findChildComponent(goTopTabRoot, "tab2", UIComponentType.SpaceXToggle)
	self._gameNoticeToggle = goutil.findChildComponent(goTopTabRoot, "tab1", UIComponentType.SpaceXToggle)
	self._closeBtn = self:getBtn("1&middle_tips_common_bg_-1205189576")
	self._closeBtn2 = self:getBtn("1&middle_tips_common_bg_-1572128605")
	self._noticeContent = self:getUIComponent("left_tab_list_-1655680316", UIComponentType.RectTransform)
	self._noticeCellTemplete = self:getGo("left_tab_list_item_-51389005")

	goutil.setActive(self._noticeCellTemplete, false)

	self._webViewPanelRT = self:getRectTransform("notice_tips_1114281295")
end

function NewNoticeView:destroyUI()
	self._activityNoticeGoggle = nil
	self._gameNoticeToggle = nil
	self._closeBtn = nil
	self._closeBtn2 = nil
	self._noticeContent = nil
	self._noticeCellTemplete = nil
	self._webViewPanelRT = nil
	self._noticeData = nil

	self:_clearNoticeViewList()
end

function NewNoticeView:bindEvents()
	self._activityNoticeGoggle:AddListener(self._onSwitchToActivityNoticeList, self)
	self._gameNoticeToggle:AddListener(self._onSwitchToGameNoticeList, self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._closeBtn2:AddClickListener(self._onClickClose, self)
end

function NewNoticeView:unbindEvents()
	self._activityNoticeGoggle:RemoveListener()
	self._gameNoticeToggle:RemoveListener()
	self._closeBtn:RemoveClickListener()
	self._closeBtn2:RemoveClickListener()
end

function NewNoticeView:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.NEWNOTICE_SWITCH_NOTICE, self._onSwitchNotice, self)
		GlobalDispatcher:addEventListener(EventType.FW_VIEW_OPENING_EVENT, self._onOtherViewOpen, self)
		GlobalDispatcher:addEventListener(EventType.DIALOG_SHOWED, self._onOtherViewOpen, self)
	else
		GlobalDispatcher:removeEventListener(EventType.NEWNOTICE_SWITCH_NOTICE, self._onSwitchNotice, self)
		GlobalDispatcher:removeEventListener(EventType.FW_VIEW_OPENING_EVENT, self._onOtherViewOpen, self)
		GlobalDispatcher:removeEventListener(EventType.DIALOG_SHOWED, self._onOtherViewOpen, self)
	end
end

function NewNoticeView:_onOtherViewOpen(sender, viewName, openType)
	if viewName == ViewName.NewNoticeView then
		return
	end

	self:close()
end

function NewNoticeView:onEnter()
	self:_setEvent(true)
	NoticeBoard.setNoticeBackgroundColor(tonumber("FF14171B", 16))

	if not self._webViewRect then
		local rect = Astral.GeometryUtil.GetNativePixelRect(self._webViewPanelRT, CameraTargetMgr.instance:getUICameraTarget():getCamera())

		self._webViewRect = {
			x = math.floor(rect.x),
			y = math.floor(rect.y),
			width = math.floor(rect.width),
			height = math.floor(rect.height)
		}
	end

	local activityNoticeCount = NewNoticeModel.instance:getActivityNoticeCount()
	local gameNoticeCount = NewNoticeModel.instance:getGameNoticeCount()

	goutil.setActive(self._activityNoticeGoggle.gameObject, activityNoticeCount ~= 0)
	goutil.setActive(self._gameNoticeToggle.gameObject, gameNoticeCount ~= 0)

	if gameNoticeCount ~= 0 then
		self._gameNoticeToggle.IsOn = true

		self:_switchNoticeList(NewNoticeModel.instance:getGameNoticeList())
	elseif activityNoticeCount ~= 0 then
		self._activityNoticeGoggle.IsOn = true

		self:_switchNoticeList(NewNoticeModel.instance:getActivityNoticeList())
	end
end

function NewNoticeView:onEnterFinished()
	return
end

function NewNoticeView:onExit()
	self._curNoticeId = 0

	self:_setEvent(false)
end

function NewNoticeView:onExitFinished()
	NewNoticeController.instance:closeWebView()
end

function NewNoticeView:_clearNoticeViewList()
	if self._noticeViewList then
		for i, noticeView in ipairs(self._noticeViewList) do
			noticeView:OnDestroy()
		end

		self._noticeViewList = nil
	end
end

function NewNoticeView:_refreshView(noticeData)
	self._noticeData = noticeData
	self._noticeViewList = self._noticeViewList or {}

	for i = 0, self._noticeContent.transform.childCount - 1 do
		local obj = goutil.findChild(self._noticeContent, "item_" .. i + 1)

		goutil.setActive(obj, false)
	end

	for i, notice in ipairs(noticeData) do
		local itemView = false
		local obj = goutil.findChild(self._noticeContent, "item_" .. i)

		if obj then
			itemView = Astral.SimpleLuaComponentContainer.Get(obj, NoticeSelectCell)
		else
			obj = goutil.clone(self._noticeCellTemplete, "item_" .. i)

			goutil.addChildToParent(obj, self._noticeContent)

			itemView = Astral.SimpleLuaComponentContainer.Add(obj, NoticeSelectCell)

			table.insert(self._noticeViewList, itemView)
		end

		goutil.setActive(obj, true)
		itemView:updateData(notice)
	end
end

function NewNoticeView:_onSwitchNotice(e, id)
	if self._curNoticeId ~= id then
		self._curNoticeId = id

		local noticeMo = NewNoticeModel.instance:getNoticeById(id)

		if noticeMo then
			local x = self._webViewRect.x
			local y = self._webViewRect.y
			local width = self._webViewRect.width
			local height = self._webViewRect.height

			NewNoticeController.instance:openWebView(x, y, width, height, noticeMo)
		else
			NewNoticeController.instance:closeWebView()
			self:close()
		end
	end
end

function NewNoticeView:_onSwitchToActivityNoticeList(go, isOn)
	if isOn then
		self:_switchNoticeList(NewNoticeModel.instance:getActivityNoticeList())
	end
end

function NewNoticeView:_onSwitchToGameNoticeList(go, isOn)
	if isOn then
		self:_switchNoticeList(NewNoticeModel.instance:getGameNoticeList())
	end
end

function NewNoticeView:_switchNoticeList(list)
	self:_refreshView(list)

	local firstNotice = list[1]

	GlobalDispatcher:dispatchEvent(EventType.NEWNOTICE_SWITCH_NOTICE, firstNotice.id)
end

function NewNoticeView:_onClickClose()
	NewNoticeController.instance:closeWebView()
	self:close()
end

return NewNoticeView
