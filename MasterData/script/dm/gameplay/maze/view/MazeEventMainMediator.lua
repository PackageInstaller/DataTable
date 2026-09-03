-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeEventMainMediator.lua

MazeEventMainMediator = class("MazeEventMainMediator", DmAreaViewMediator, _M)

MazeEventMainMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")
MazeEventMainMediator:has("_shopSystem", {
	is = "rw"
}):injectWith("ShopSystem")
MazeEventMainMediator:has("_systemKeeper", {
	is = "rw"
}):injectWith("SystemKeeper")
MazeEventMainMediator:has("_developSystem", {
	is = "rw"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	jxBtn = "onClickRank",
	dhBtn = "onClickStore",
	xsBtn = "onClickSeal"
}

function MazeEventMainMediator:initialize()
	super.initialize(self)
end

function MazeEventMainMediator:dispose()
	super.dispose(self)
end

function MazeEventMainMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function MazeEventMainMediator:mapEventListeners()
	return
end

function MazeEventMainMediator:onRemove()
	super.onRemove(self)
end

function MazeEventMainMediator:enterWithData(data)
	self:initData()
	self:initViews()
	self:initEventTouchMask()
	self:initEventsView()
	self:setupClickEnvs()
end

function MazeEventMainMediator:initData(data)
	local var_7_0

	if data then
		if data.tabType then
			var_7_0 = data.tabType

			if not data.tabType then
				var_7_0 = 1

				goto label_7_0
			end
		end
	end

	::label_7_0::

	self._tabType = 1

	local var_7_1

	if data then
		if data.eventIndex then
			var_7_1 = data.eventIndex

			if not data.eventIndex then
				var_7_1 = 1

				goto label_7_1
			end
		end
	end

	::label_7_1::

	self._eventIndex = 1
	self._isFirstEnter = true
end

function MazeEventMainMediator:initEventsView()
	for i = 1, 6 do
		local data = self._mazeSystem:getMazeEventConfigByPos(i)
		local view = self._eventViewList:getChildByFullName("event_" .. i)

		if not self:checkUnlock(i) then
			view:setGray(true)
		end

		local nameview = view:getChildByFullName("bg.name")

		nameview:setString(Strings:get(data.StoryName))
		nameview:setTextAreaSize(cc.size(30, 300))
	end
end

function MazeEventMainMediator:checkUnlock(pos)
	local data = self._mazeSystem:getMazeEventConfigByPos(pos)
	local lv = data.NormalUnlock

	if lv.level == 999 then
		return false
	elseif self._developSystem:getLevel() < lv.level then
		return false
	end

	return true
end

function MazeEventMainMediator:initViews()
	self._eventViewList = self:getView():getChildByFullName("eventList")

	self:setupTopInfoWidget()
end

function MazeEventMainMediator:initEventTouchMask()
	for i = 1, 6 do
		local touchmask = self:getView():getChildByFullName("eventList.event_" .. i .. ".bg.touchmask")

		touchmask:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self:onClickTouchMask(i)
			end
		end)
	end
end

function MazeEventMainMediator:onClickTouchMask(index)
	self._eventIndex = index

	local data = {
		index = self._eventIndex,
		config = self._mazeSystem:getMazeEventConfigByPos(self._eventIndex)
	}

	if self:checkUnlock(self._eventIndex) then
		self:showEventInfo(data)
	else
		self:dispatch(ShowTipEvent({
			tip = Strings:get("MAZE_RANK_TIPS")
		}))
	end
end

function MazeEventMainMediator:showEventInfo(infodata)
	local view = self:getInjector():getInstance("MazeEventInfoView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		info = infodata
	}))
end

function MazeEventMainMediator:resumeWithData()
	return
end

function MazeEventMainMediator:checkFullTimes()
	if self._mazeSystem:getNormalChallengeCount() == self._mazeSystem:getNormalAllTimes() then
		return true
	else
		return false
	end
end

function MazeEventMainMediator:checkTabUnlock(tab)
	local result, tip
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")

	if tab == 1 then
		result, tip = systemKeeper:isUnlock("PansLabNormal")
	end

	return result, tip
end

function MazeEventMainMediator:onClickTab(name, tag)
	local btn = self._tabBtns[tag]

	if btn.unlock == false then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = btn.tips
		}))

		return
	end

	self._tabType = tag

	if self._isFirstEnter then
		self._isFirstEnter = false

		return
	end

	if self._mazeSystem:haveMaster() then
		self:enterMazeMain()
	else
		self:enterMatsterSelect()
	end
end

function MazeEventMainMediator:onClickExit(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:dismiss()
	end
end

function MazeEventMainMediator:onClickSeal(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local view = self:getInjector():getInstance("MazeSealView")
		local data = {}

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
	end
end

function MazeEventMainMediator:onClickStore(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self._shopSystem:tryEnter({
			shopId = "Shop4",
			tabType = 1
		})
	end
end

function MazeEventMainMediator:onClickRank(sender, eventType)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self:dispatch(ShowTipEvent({
		duration = 0.2,
		tip = Strings:find("MAZE_RANK_TIPS")
	}))
end

function MazeEventMainMediator:enterMazeMain()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local view = self:getInjector():getInstance("MazeMainView")
	local data = {}

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
end

function MazeEventMainMediator:enterMatsterSelect()
	if self:checkFullTimes() then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("MAZE_FULL_TIMES")
		}))
	else
		local view = self:getInjector():getInstance("MazeMasterView")
		local data = {
			selectType = self._tabType
		}

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
	end
end

function MazeEventMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("PansLabNormal")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		title = "",
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickExit, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function MazeEventMainMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local view = self._eventViewList:getChildByFullName("event_1")

		if view then
			storyDirector:setClickEnv("MazeEventMainMediator.view1", view, function(sender, eventType)
				self:onClickTouchMask(1)
			end)
		end

		storyDirector:notifyWaiting("enter_MazeEventMainMediator")
	end))

	self:getView():runAction(sequence)
end
