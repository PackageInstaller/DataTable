-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/EightDayLoginMediator.lua

EightDayLoginMediator = class("EightDayLoginMediator", DmPopupViewMediator, _M)

EightDayLoginMediator:has("_activitySystem", {
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

function EightDayLoginMediator:initialize()
	super.initialize(self)
end

function EightDayLoginMediator:dispose()
	super.dispose(self)
end

function EightDayLoginMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function EightDayLoginMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshView)
end

function EightDayLoginMediator:loadData()
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

function EightDayLoginMediator:enterWithData(data)
	self._activity = data.activity
	self._parentMediator = data.parentMediator

	self:setupView()
	self:setupClickEnvs()
end

function EightDayLoginMediator:setupView()
	self:loadData()

	self._main = self:getView():getChildByName("main")
	self._listPanel = self._main:getChildByName("Panel_list")
	self._cellPanel = self._main:getChildByName("Panel_cell")

	self._cellPanel:setVisible(false)

	self._cellPanel8 = self._main:getChildByName("Panel_cell_8")

	self._cellPanel8:setVisible(false)

	self._cellPanel4 = self._main:getChildByName("Panel_cell_4")

	self._cellPanel4:setVisible(false)
	self._main:getChildByFullName("Text_login_day_num"):setString(self._loginDays)
	self:initEightDayCell()
	self:checkDay4State()
	self:mapEventListeners()
end

function EightDayLoginMediator:checkDay4State()
	local heroPanel = self._main:getChildByFullName("heroPanel")
	local activityData = self._activityList[4]
	local state = activityData:getStatus()

	if state == ActivityTaskStatus.kGet then
		local titleImage = self._main:getChildByName("titleImage")
		local actConfig = self._activity:getActivityConfig()
		local imageName = actConfig.title[2]

		titleImage:loadTexture(imageName .. ".png", ccui.TextureResType.plistType)

		local imageBg = self._main:getChildByName("Image_1")
		local bgName = actConfig.bg[2]

		imageBg:loadTexture("asset/scene/" .. bgName .. ".jpg", ccui.TextureResType.localType)
		heroPanel:getChildByName("hero1"):setVisible(false)
		heroPanel:getChildByName("hero2"):setVisible(true)
	else
		heroPanel:getChildByName("hero1"):setVisible(true)
		heroPanel:getChildByName("hero2"):setVisible(false)
	end
end

function EightDayLoginMediator:initEightDayCell()
	self._eightDayCells = {}

	local start_x = 0

	self._listPanel:removeAllChildren()

	for i = 1, #self._activityList do
		local activityData = self._activityList[i]
		local day = activityData.day
		local cellClone = day == 8 and self._cellPanel8:clone() or day == 4 and self._cellPanel4:clone() or self._cellPanel:clone()

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

					if day == 4 or day == 8 then
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

			rewardInstance:setColor(col)

			if day == 4 or day == 8 then
				rewardInstance:stopAnimation()

				if day == 8 then
					cellClone:getChildByFullName("Image_2"):setColor(col)
				end
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
		local text_state = cellClone:getChildByName("Text_state")

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

function EightDayLoginMediator:refreshView()
	self:loadData()
	self:initEightDayCell()
end

function EightDayLoginMediator:onGetRewardCallback(response)
	local response = response.data.reward
	local this = self
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		needClick = false,
		rewards = response,
		callback = function()
			local sequence = cc.Sequence:create(cc.CallFunc:create(function()
				local storyDirector = this:getInjector():getInstance(story.StoryDirector)

				storyDirector:notifyWaiting("exit_GetRewardView_suc")
			end))

			this:getView():runAction(sequence)
		end
	}))
end

function EightDayLoginMediator:onClickGet(taskId, day)
	local activityId = self._activity:getId()
	local param = {
		doActivityType = 101,
		taskId = taskId
	}

	self._activitySystem:requestDoActivity(activityId, param, function(response)
		if checkDependInstance(self) then
			self:onGetRewardCallback(response)
			self:refreshView()

			if day == 4 then
				self:checkDay4State()
			end
		end
	end)
end

function EightDayLoginMediator:onClickTips(str)
	self:dispatch(ShowTipEvent({
		tip = Strings:get("EightDaysTips3", {
			factor1 = str
		})
	}))
end

function EightDayLoginMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local cell1 = self._eightDayCells[1]

		if cell1 then
			storyDirector:setClickEnv("eightDayLoginView.cell1", cell1, function(sender, eventType)
				self:onClickGet(1)
			end)
		end

		storyDirector:notifyWaiting("enter_eightDayLogin_view")
	end))

	self:getView():runAction(sequence)
end
