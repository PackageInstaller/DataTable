-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeEventInfoMediator.lua

MazeEventInfoMediator = class("MazeEventInfoMediator", DmPopupViewMediator, _M)

MazeEventInfoMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")

local kBtnHandlers = {
	entermazebtn = "onClickStarEvent",
	dpBtn = "onDpBtn"
}
local kModel = {
	"NORMAL",
	"ELITE",
	""
}

function MazeEventInfoMediator:initialize()
	super.initialize(self)
end

function MazeEventInfoMediator:dispose()
	super.dispose(self)
end

function MazeEventInfoMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function MazeEventInfoMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_DPBOX_REWARD_GET_SUC, self, self.updateBoxByData)
end

function MazeEventInfoMediator:dispose()
	super.dispose(self)
end

function MazeEventInfoMediator:enterWithData(data)
	self._data = data.info
	self._mazeEvent = self._mazeSystem:getMazeEvent()

	self:initData()
	self:initView()
	self:refeshDifficulty(1)
	self:updateBoxByData()
	self:updateDp()
	self:registModelSelectTouch()
	self:registBoxTouch()
	self:setupClickEnvs()
end

function MazeEventInfoMediator:initData()
	self._eventId = self._data.config.Id
	self._modelIndex = 1
end

function MazeEventInfoMediator:initView()
	self._eventName = self:getView():getChildByFullName("info.eventName")
	self._masterName = self:getView():getChildByFullName("info.byname")

	self._eventName:setString(self._mazeEvent:getEventName())

	self._desc_text = self:getView():getChildByFullName("desc_text")

	self._desc_text:setString("剩余次数:" .. self._mazeSystem._normalTimes)
	self._masterName:setString(self._mazeEvent:getEventMasterName())
	self:createAni()
end

function MazeEventInfoMediator:refeshDifficulty(modeltype)
	for i = 1, 3 do
		local xzk = self:getView():getChildByFullName("info.level." .. "lv_" .. i .. ".xz")

		xzk:setVisible(i == modeltype)
	end
end

function MazeEventInfoMediator:registModelSelectTouch()
	for i = 1, 3 do
		local select = self:getView():getChildByFullName("info.level." .. "lv_" .. i)
		local text = self:getView():getChildByFullName("info.level." .. "lv_" .. i .. ".Text_46")

		text:getVirtualRenderer():enableUnderline(1)
		select:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.began then
				if i == 3 then
					self:dispatch(ShowTipEvent({
						tip = Strings:get("MAZE_RANK_TIPS")
					}))

					return
				elseif i == 1 then
					return
				end

				local unlock, name = self:checkModelUnlock(i)

				if unlock then
					self._modelIndex = i

					self:refeshDifficulty(self._modelIndex)
				else
					self:dispatch(ShowTipEvent({
						tip = name
					}))
				end
			end
		end)
	end
end

function MazeEventInfoMediator:checkModelUnlock(model)
	if model == 2 then
		local result = false
		local suspects = ConfigReader:getDataByNameIdAndKey("PansLabList", self._eventId, "EliteUnlock")

		for k, v in pairs(suspects) do
			if self._mazeSystem._mazeEvent._suspects[v] then
				result = true

				break
			end
		end

		local names = ""

		for i = 1, #suspects do
			local tranid = ConfigReader:getDataByNameIdAndKey("PansLabSuspects", suspects[i], "Name")

			names = Strings:get(tranid) .. names
		end

		names = "需要完成对" .. names .. "的调查"

		return result, names
	end
end

function MazeEventInfoMediator:initAllBox()
	for i = 1, 5 do
		local box = self:getView():getChildByFullName("boxlist.box_" .. i)

		box:setVisible(false)
	end
end

function MazeEventInfoMediator:registBoxTouch()
	local dpconfigrewards = self._mazeEvent:getEventConfigDpReward()

	for i = 1, #dpconfigrewards do
		local box = self:getView():getChildByFullName("boxlist.box_" .. i)

		box:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.began then
				local state = self:getBoxState(box)
				local reward = self._mazeEvent:getEventDpTaskRewardByIndex(i)
				local info = {
					rewardId = "exp_small",
					descId = "Dp值达到" .. reward .. "可领取"
				}
				local view = self:getInjector():getInstance("TaskBoxView")

				if state == 1 then
					info.hasGet = false

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
						transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
					}, info))
				elseif state == 2 then
					info.hasGet = true

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
						transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
					}, info))

					local reward = self._mazeEvent:getEventDpTaskRewardByIndex(i)

					self._mazeSystem:requestGetDpReward(self._eventId, reward)
				elseif state == 3 then
					-- block empty
				end
			end
		end)
	end
end

function MazeEventInfoMediator:createAni()
	local masterid = ConfigReader:getDataByNameIdAndKey("PansLabList", self._mazeSystem._mazeEvent._configId, "Master")

	id = ConfigReader:getDataByNameIdAndKey("EnemyMaster", masterid, "RoleModel")

	local ani = self._mazeSystem:createOneMasterAni(masterid)

	ani:playAnimation(0, "stand", true)
	ani:setGray(false)
	self:getView():getChildByFullName("bg.Panel_2"):addChild(ani)
end

function MazeEventInfoMediator:updateDp()
	local curDp = self._mazeEvent:getDp()
	local maxDp = self._mazeEvent:getEventMaxDp()
	local loadingBar = self:getView():getChildByFullName("loadingBar")

	loadingBar:setPercent(100 * (curDp / maxDp))
end

function MazeEventInfoMediator:updateBoxByData()
	self:initAllBox()

	local dpconfigrewards = self._mazeEvent:getEventConfigDpReward()
	local dpSRewards = self._mazeEvent:getDpGotRewards()

	dump(dpconfigrewards, "dpconfigrewards")
	dump(dpSRewards, "dpSRewards")

	local box_1 = self:getView():getChildByFullName("boxlist.box_1")

	for i = 1, #dpconfigrewards do
		local box = self:getView():getChildByFullName("boxlist.box_" .. i)

		box:setPosition(box_1:getPositionX() + (i - 1) * (525 / #dpconfigrewards + 10), box_1:getPositionY())
		box:setVisible(i <= #dpconfigrewards)

		local canValue = self._mazeEvent:getBoxCanGetDp(i)
		local can = canValue <= self._mazeEvent:getDp()
		local state = 1

		if can then
			state = 2

			if self._mazeEvent:haveGetRewards(canValue) then
				state = 3
			end
		end

		self:setBoxState(box, state)
	end
end

function MazeEventInfoMediator:setBoxState(box, state)
	box:getChildByFullName("normal"):setVisible(state == 1)
	box:getChildByFullName("canReceive"):setVisible(state == 2)
	box:getChildByFullName("hasReceive"):setVisible(state == 3)
end

function MazeEventInfoMediator:getBoxState(box)
	if box:getChildByFullName("normal"):isVisible() then
		return 1
	elseif box:getChildByFullName("canReceive"):isVisible() then
		return 2
	elseif box:getChildByFullName("hasReceive"):isVisible() then
		return 3
	end
end

function MazeEventInfoMediator:onClickExit(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:close()
	end
end

function MazeEventInfoMediator:onDpBtn(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local view = self:getInjector():getInstance("MazeDpView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, nil))
	end
end

function MazeEventInfoMediator:onClickStarEvent(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		if self._mazeSystem._normalTimes == 0 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("MAZE_TIMES")
			}))

			return
		end

		self._mazeSystem:requestFirstEnterMaze(self._eventId, kModel[self._modelIndex], function(response)
			dump(response, "首次进入迷宫")
			self._mazeSystem:setMazeState(0)

			local view = self:getInjector():getInstance("MazeMainView")
			local data = {}

			self:dispatch(ViewEvent:new(EVT_SWITCH_VIEW, view, nil, data))
		end)
	end
end

function MazeEventInfoMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		storyDirector:notifyWaiting("enter_MazeEventInfoMediator")
	end))

	self:getView():runAction(sequence)
end
