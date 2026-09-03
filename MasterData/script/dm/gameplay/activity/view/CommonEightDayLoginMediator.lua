-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/CommonEightDayLoginMediator.lua

CommonEightDayLoginMediator = class("CommonEightDayLoginMediator", DmPopupViewMediator, _M)

CommonEightDayLoginMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {}
local dayStr = {
	"Common_Text_One",
	"Common_Text_Two",
	"Common_Text_Three",
	"Common_Text_Four",
	"Common_Text_Five",
	"Common_Text_Six",
	"Common_Text_Seven",
	"Common_Text_Eight"
}

function CommonEightDayLoginMediator:initialize()
	super.initialize(self)
end

function CommonEightDayLoginMediator:dispose()
	self:stopTimer()
	super.dispose(self)
end

function CommonEightDayLoginMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function CommonEightDayLoginMediator:loadData()
	self._activityList = self._activity._taskList

	table.sort(self._activityList, function(a, b)
		local aNum = a._config.OrderNum
		local bNum = b._config.OrderNum

		return aNum < bNum
	end)

	local todayNum = #self._activityList

	for i = 1, #self._activityList do
		local taskInfo = self._activityList[i]
		local status = taskInfo:getStatus()

		if status == ActivityTaskStatus.kUnfinish then
			todayNum = i - 1

			break
		end
	end

	for i = 1, #self._activityList do
		local taskInfo = self._activityList[i]

		taskInfo.day = i
	end

	self._loginDays = todayNum
end

function CommonEightDayLoginMediator:enterWithData(data)
	self._activity = data.activity
	self._parentMediator = data.parentMediator

	self:setupView()
	self:setTimer()
end

function CommonEightDayLoginMediator:setupView()
	self:loadData()

	self._main = self:getView():getChildByName("main")
	self._listPanel = self._main:getChildByName("Panel_list")
	self._cellPanel = self._main:getChildByName("Panel_cell")

	self._cellPanel:setVisible(false)

	self._cellPanel8 = self._main:getChildByName("Panel_cell_8")

	self._cellPanel8:setVisible(false)

	self._refreshPanel = self._main:getChildByName("refreshPanel")
	self._refreshTime = self._refreshPanel:getChildByName("times")

	self._main:getChildByFullName("Text_login_day_num"):setString(self._loginDays)

	local config = self._activity:getActivityConfig()
	local heroId = config.showHero
	local titleImageName = config.title[1]
	local bgImageName = config.bg[1]
	local titleImage = self._main:getChildByFullName("titleImage")

	titleImage:ignoreContentAdaptWithSize(true)
	titleImage:loadTexture(titleImageName .. ".png", 1)

	local bgImge = self._main:getChildByFullName("Image_1")

	bgImge:ignoreContentAdaptWithSize(true)
	bgImge:loadTexture("asset/scene/" .. bgImageName .. ".jpg")

	local heroPanel = self._main:getChildByFullName("heroPanel")

	heroPanel:removeAllChildren()

	if heroId then
		local config = ConfigReader:getRecordById("HeroBase", heroId)
		local img = IconFactory:createRoleIconSpriteNew({
			frameId = "bustframe9",
			id = config.RoleModel
		})

		img:setScale(1.2)
		img:addTo(heroPanel):offset(370, 20)
	end

	local day8BgUI = config.Day8BgUI

	if day8BgUI then
		self._cellPanel8:getChildByFullName("image_bg_normal"):loadTexture(day8BgUI[1] .. ".png", 1)
		self._cellPanel8:getChildByFullName("image_bg_get"):loadTexture(day8BgUI[2] .. ".png", 1)

		local text = self._cellPanel8:getChildByFullName("8rewardName")

		text:setTextColor(cc.c3b(255, 255, 255))
		text:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	end

	self:initEightDayCell()
end

function CommonEightDayLoginMediator:initEightDayCell()
	self._eightDayCells = {}

	local start_x = 0

	self._listPanel:removeAllChildren()

	for i = 1, #self._activityList do
		local activityData = self._activityList[i]
		local day = activityData.day
		local cellClone

		if day == 8 then
			cellClone = self._cellPanel8:clone()

			if self._activity:getId() == "ActivityBlock_Login" then
				cellClone:getChildByFullName("Image_2"):setVisible(false)
			end
		else
			cellClone = self._cellPanel:clone()
		end

		cellClone:setVisible(true)

		local posY

		if i > 5 then
			start_x = 0
			posY = 7
			i = i - 5
		else
			start_x = 0
			posY = 187
		end

		if day == 8 then
			start_x = 18
			posY = 10
		end

		cellClone:setPosition(cc.p(start_x + (i - 1) * 140, posY))
		cellClone:addTo(self._listPanel)

		local iconPanel = cellClone:getChildByName("Panel_reward")
		local rewardId = activityData._config.Reward
		local rewards = ConfigReader:getRecordById("Reward", rewardId)

		if rewards then
			local reward = rewards.Content[1]

			if reward then
				if not reward.amount then
					local amount = 1

					if reward.type == RewardType.kHero or reward.type == RewardType.kSurface then
						amount = ""
					end

					iconPanel:removeAllChildren()

					if day == 8 then
						if reward.type == 7 then
							local config = ConfigReader:getRecordById("Surface", reward.code)
							local model = ConfigReader:requireRecordById("RoleModel", config.Model).Model
							local node = RoleFactory:createRoleAnimation(model)

							node:addTo(iconPanel):offset(65, 5):setName("rewardInstance")
							node:setScale(0.5)
						end

						if reward.type == 3 then
							local config = ConfigReader:getRecordById("HeroBase", reward.code)
							local model = ConfigReader:requireRecordById("RoleModel", config.RoleModel).Model
							local node = RoleFactory:createRoleAnimation(model)

							node:addTo(iconPanel):offset(77, 8):setName("rewardInstance")
							node:setScale(-0.77, 0.77)
						end
					else
						local rewardIcon = IconFactory:createRewardIcon(reward, {
							showAmount = false,
							notShowQulity = true,
							isWidget = true
						})

						iconPanel:addChild(rewardIcon)
						rewardIcon:setScale(0.6)
						rewardIcon:center(iconPanel:getContentSize())
						rewardIcon:setName("rewardInstance")

						if self._parentMediator then
							IconFactory:bindClickHander(iconPanel, IconTouchHandler:new(self._parentMediator), reward, {
								touchDisappear = true
							})
						else
							IconFactory:bindClickHander(iconPanel, IconTouchHandler:new(self), reward, {
								touchDisappear = true
							})
						end
					end

					if cellClone:getChildByFullName("reward_name_num") then
						local nameStr = RewardSystem:getName(reward)
						local nameText = cellClone:getChildByFullName("reward_name_num")

						nameText:setString(nameStr)
						cellClone:getChildByFullName("rewardCount"):setString(amount)

						if utf8.len(nameStr) > 5 then
							nameText:setFontSize(16)
						end
					end

					if cellClone:getChildByName("8rewardName") then
						local nameStr = RewardSystem:getName(reward)

						cellClone:getChildByName("8rewardName"):setString(nameStr)
					end
				end
			end
		end

		cellClone:getChildByFullName("image_bg_get"):setVisible(false)
		cellClone:getChildByFullName("dayNum"):setString("")
		cellClone:getChildByFullName("dayNum_get"):setVisible(false)
		cellClone:getChildByFullName("Image_day_bg"):setVisible(true)

		local state

		if day > self._loginDays then
			state = 3

			cellClone:getChildByFullName("dayNum"):setString(Strings:get("Activity_Day", {
				num = Strings:get(dayStr[day])
			}))
		elseif activityData:getStatus() == ActivityTaskStatus.kGet then
			state = 1

			cellClone:getChildByFullName("dayNum"):setString(Strings:get("Activity_Received"))

			local col = cc.c3b(125, 125, 125)

			cellClone:getChildByFullName("image_bg_normal"):setColor(col)

			local rewardInstance = iconPanel:getChildByName("rewardInstance")

			if rewardInstance then
				rewardInstance:setColor(col)
			end

			if day == 8 then
				if rewardInstance then
					rewardInstance:stopAnimation()
				end

				cellClone:getChildByFullName("Image_2"):setColor(col)
			end

			if cellClone:getChildByFullName("reward_name_num") then
				cellClone:getChildByFullName("reward_name_num"):setColor(col)
				cellClone:getChildByFullName("rewardCount"):setColor(col)
			end

			if cellClone:getChildByName("8rewardName") then
				cellClone:getChildByFullName("8rewardName"):setColor(col)
			end
		else
			state = 2

			cellClone:getChildByFullName("image_bg_get"):setVisible(true)
			cellClone:getChildByFullName("dayNum_get"):setVisible(true)
			cellClone:getChildByFullName("Image_day_bg"):setVisible(false)

			local kelingqu = cc.MovieClip:create("kelingqu_kelingqu")

			kelingqu:setScale(0.95)
			kelingqu:addTo(cellClone:getChildByFullName("image_bg_get")):center(cellClone:getChildByFullName("image_bg_get"):getContentSize()):offset(1, 1)

			if day == 8 then
				kelingqu:setScaleX(3.25)
				kelingqu:offset(2, -10)
			end
		end

		local getBtn = cellClone:getChildByName("PanelTouch")

		local function callFunc(sender, eventType)
			if self._loginDays < day then
				self:onClickTips(day)
			else
				self:onClickGet(activityData:getId(), day)
			end

			if cellClone.effect then
				cellClone.effect:stop()
				cellClone.effect:removeFromParent(true)

				cellClone.effect = nil
			end
		end

		mapButtonHandlerClick(nil, getBtn, {
			func = callFunc
		})
		getBtn:setVisible(state == 2)
		cellClone:getChildByName("GetedIcon"):setVisible(state == 1)

		self._eightDayCells[#self._eightDayCells + 1] = cellClone
	end
end

function CommonEightDayLoginMediator:refreshView()
	self:loadData()
	self:initEightDayCell()
end

function CommonEightDayLoginMediator:onGetRewardCallback(response)
	local response = response.data.reward
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = response
	}))
end

function CommonEightDayLoginMediator:onClickGet(taskId, day)
	local activityId = self._activity:getId()
	local param = {
		doActivityType = 101,
		taskId = taskId
	}

	self._activitySystem:requestDoActivity(activityId, param, function(response)
		if checkDependInstance(self) then
			self:onGetRewardCallback(response)
			self:refreshView()
		end
	end)
end

function CommonEightDayLoginMediator:onClickTips(str)
	self:dispatch(ShowTipEvent({
		tip = Strings:get("EightDaysTips3", {
			factor1 = str
		})
	}))
end

function CommonEightDayLoginMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	self._refreshPanel:setVisible(false)
end

function CommonEightDayLoginMediator:setTimer()
	self:stopTimer()

	if not self._activity then
		return
	end

	local actConfig = self._activity:getActivityConfig()

	if not actConfig.Time then
		return
	end

	self._refreshPanel:setVisible(true)

	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local endMills = self._activity:getEndTime() / 1000

	if remoteTimestamp < endMills and not self._timer then
		local function checkTimeFunc()
			remoteTimestamp = gameServerAgent:remoteTimestamp()

			local endMills = self._activity:getEndTime() / 1000
			local remainTime = endMills - remoteTimestamp

			if math.floor(remainTime) <= 0 then
				self:stopTimer()

				return
			end

			local fmtStr = "${d}:${H}:${M}:${S}"
			local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
			local parts = string.split(timeStr, ":", nil, true)
			local timeTab = {}

			timeTab.day = tonumber(parts[1])
			timeTab.hour = tonumber(parts[2])
			timeTab.min = tonumber(parts[3])
			timeTab.sec = tonumber(parts[4])

			self._refreshTime:setString((timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec")) .. Strings:get("Activity_Collect_Finish"))
			self._refreshPanel:setVisible(true)
		end

		checkTimeFunc()

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)
	end
end
