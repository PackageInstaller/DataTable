-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeEnterMediator.lua

MazeEnterMediator = class("MazeEnterMediator", DmAreaViewMediator, _M)

MazeEnterMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")
MazeEnterMediator:has("_shopSystem", {
	is = "rw"
}):injectWith("ShopSystem")
MazeEnterMediator:has("_systemKeeper", {
	is = "rw"
}):injectWith("SystemKeeper")

local kBtnHandlers = {
	["menupanel.btn_ph"] = "onClickRank",
	["menupanel.btn_fy"] = "onClickSeal",
	["menupanel.btn_sd"] = "onClickStore"
}
local kTabBtnsNames = {
	[1] = "switchpanel.switchbtn_normal",
	[2] = "switchpanel.switchbtn_endless"
}

function MazeEnterMediator:initialize()
	super.initialize(self)
end

function MazeEnterMediator:dispose()
	super.dispose(self)
end

function MazeEnterMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function MazeEnterMediator:mapEventListeners()
	return
end

function MazeEnterMediator:onRemove()
	super.onRemove(self)
end

function MazeEnterMediator:enterWithData(data)
	self:initData()
	self:initViews()
	self:initTabBtns()
	self:registNormalTouch()
	self:registEndlessTouch()
end

function MazeEnterMediator:initData(data)
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
	self._isFirstEnter = true
end

function MazeEnterMediator:initViews()
	self._havePassChapter = self:getView():getChildByFullName("normalpanel.normalCount_1")
	self._allTimes = self:getView():getChildByFullName("normalpanel.normalCount_2")

	self._havePassChapter:setString(self._mazeSystem:getNormalChallengeCount())
	self._allTimes:setString(self._mazeSystem:getNormalAllTimes())
	self:setupTopInfoWidget()
end

function MazeEnterMediator:resumeWithData()
	self._havePassChapter:setString(self._mazeSystem:getNormalChallengeCount())
end

function MazeEnterMediator:checkFullTimes()
	if self._mazeSystem:getNormalChallengeCount() == self._mazeSystem:getNormalAllTimes() then
		return true
	else
		return false
	end
end

function MazeEnterMediator:initTabBtns()
	self._tabBtns = {}

	for i, name in ipairs(kTabBtnsNames) do
		local btn = self:getView():getChildByFullName(name)

		if btn then
			btn:setTag(i)

			local unlock, tips = self:checkTabUnlock(i)

			btn.unlock = unlock
			btn.tips = tips
			self._tabBtns[#self._tabBtns + 1] = btn
		end
	end

	self._tabController = TabController:new(self._tabBtns, function(name, tag)
		self:onClickTab(name, tag)
	end)

	self._tabController:selectTabByTag(self._tabType)
end

function MazeEnterMediator:checkTabUnlock(tab)
	local result, tip
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")

	if tab == 1 then
		result, tip = systemKeeper:isUnlock("PansLabNormal")
	end

	return result, tip
end

function MazeEnterMediator:onClickTab(name, tag)
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

function MazeEnterMediator:onClickExit(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:dismiss()
	end
end

function MazeEnterMediator:onClickSeal(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local view = self:getInjector():getInstance("MazeSealView")
		local data = {}

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
	end
end

function MazeEnterMediator:onClickStore(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self._shopSystem:tryEnter({
			shopId = "Shop4"
		})
	end
end

function MazeEnterMediator:onClickRank(sender, eventType)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self:dispatch(ShowTipEvent({
		duration = 0.2,
		tip = Strings:find("MAZE_RANK_TIPS")
	}))
end

function MazeEnterMediator:enterMazeMain()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local view = self:getInjector():getInstance("MazeMainView")
	local data = {}

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, data))
end

function MazeEnterMediator:enterMatsterSelect()
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

function MazeEnterMediator:setupTopInfoWidget()
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

function MazeEnterMediator:registNormalTouch()
	local touchmask = self:getView():getChildByFullName("Panel_6")

	touchmask:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._tabType = 1

			self:onClickTab("", 1)
		end
	end)
end

function MazeEnterMediator:registEndlessTouch()
	local touchmask = self:getView():getChildByFullName("Panel_7")

	touchmask:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:find("MAZE_ENDLESS_TIPS")
			}))
		end
	end)
end
