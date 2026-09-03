-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityListMediator.lua

ActivityListMediator = class("ActivityListMediator", BaseActivityMediator, _M)

function ActivityListMediator:initialize()
	super.initialize(self)
end

function ActivityListMediator:dispose()
	super.dispose(self)
end

function ActivityListMediator:onRemove()
	super.onRemove(self)
end

function ActivityListMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_REDPOINT_REFRESH, self, self.refreshRedPoint)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_ACTIVITY_MAIL_NEW, self, self.refreshRedPoint)
end

function ActivityListMediator:enterWithData(data)
	self:initData()
	self:initWidget()
	self:initAnim()
	self:setupView()
	self:setupTabBtn()
end

function ActivityListMediator:resumeWithData()
	super.resumeWithData(self)

	self._openList, self._closeList = self._activitySystem:getActivityCalendarList()

	self:setupView()
	self:setupTabBtn()
end

function ActivityListMediator:initData()
	self._openList, self._closeList = self._activitySystem:getActivityCalendarList()
	self._curOpenType = 1
end

function ActivityListMediator:initWidget()
	self._view = self:getView()
	self._main = self._view:getChildByName("main")
	self._anim = self._main:getChildByName("mainAnim")
	self._title = self._main:getChildByFullName("background.title")
	self._tab1 = self._main:getChildByName("tabPanel1")
	self._tab2 = self._main:getChildByName("tabPanel2")

	self._tab1:setOpacity(0)
	self._tab2:setOpacity(0)

	self._emptyPanel = self._main:getChildByName("emptyPanel")
	self._list = self._main:getChildByName("list")

	self._list:setOpacity(0)
	self._list:setScrollBarEnabled(false)

	self._itemCell = self._view:getChildByName("itemCell")
	self._backBtn = self._main:getChildByName("backBtn")

	self._backBtn:setVisible(false)
end

function ActivityListMediator:initAnim()
	local anim = cc.MovieClip:create("zhu_qingdianrili")

	anim:setPosition(cc.p(0, 0))
	anim:addTo(self._anim)
	anim:addCallbackAtFrame(8, function(cid, mc)
		self._list:runAction(cc.FadeIn:create(0.2))
	end)
	anim:addCallbackAtFrame(10, function(cid, mc)
		self._tab1:runAction(cc.FadeIn:create(0.1))
		self._tab2:runAction(cc.FadeIn:create(0.1))
	end)
	anim:addEndCallback(function(cid, mc)
		self._backBtn:setVisible(true)
		mc:stop()
	end)
	self._tab1:getChildByFullName("light.lighting1"):runAction(cc.RepeatForever:create(cc.RotateBy:create(0.25, 8)))
	self._tab2:getChildByFullName("light.lighting1"):runAction(cc.RepeatForever:create(cc.RotateBy:create(0.25, 8)))
end

function ActivityListMediator:setupView()
	self._backBtn:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self:onTouchMaskLayer()
		end
	end)
	self._tab1:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			if self._curOpenType == 1 then
				return
			end

			self._curOpenType = 1

			self:setupTabBtn()
			self:setupList()
		end
	end)
	self._tab2:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			if self._curOpenType == 2 then
				return
			end

			self._curOpenType = 2

			self:setupTabBtn()
			self:setupList()
		end
	end)
	self:setupList()
end

function ActivityListMediator:setupTabBtn()
	if self._curOpenType == 1 then
		self._tab1:getChildByName("light"):setVisible(true)
		self._tab1:getChildByName("dark"):setVisible(false)
		self._tab2:getChildByName("light"):setVisible(false)
		self._tab2:getChildByName("dark"):setVisible(true)
	else
		self._tab1:getChildByName("light"):setVisible(false)
		self._tab1:getChildByName("dark"):setVisible(true)
		self._tab2:getChildByName("light"):setVisible(true)
		self._tab2:getChildByName("dark"):setVisible(false)
	end

	local isRedPoint = false
	local isNewShow = false

	for i = 1, #self._openList do
		if isRedPoint == false then
			local tmpRedPoint = self._activitySystem:isActivityCalendarRedpointShow(self._openList[i])

			if tmpRedPoint then
				isRedPoint = true
			end
		end

		if isNewShow == false then
			local tmpNewShow = self._activitySystem:checkActivityCalNewTagShow("OPEN_" .. self._openList[i].Id)

			if tmpNewShow then
				isNewShow = true
			end
		end
	end

	if isRedPoint then
		self._tab1:getChildByName("redPoint"):setVisible(true)
		self._tab1:getChildByName("new"):setVisible(false)
	elseif isNewShow then
		self._tab1:getChildByName("redPoint"):setVisible(false)
		self._tab1:getChildByName("new"):setVisible(true)
	else
		self._tab1:getChildByName("redPoint"):setVisible(false)
		self._tab1:getChildByName("new"):setVisible(false)
	end

	self._tab2:getChildByName("redPoint"):setVisible(false)
	self._tab2:getChildByName("new"):setVisible(false)

	for i = 1, #self._closeList do
		self._tab2:getChildByName("redPoint"):setVisible(false)

		local isNewShow = self._activitySystem:checkActivityCalNewTagShow("CLOSE_" .. self._closeList[i].Id)

		if isNewShow then
			self._tab2:getChildByName("new"):setVisible(true)
		else
			self._tab2:getChildByName("new"):setVisible(false)
		end
	end
end

function ActivityListMediator:setupList()
	if self._curOpenType == 1 then
		if not self._openList then
			local data = self._closeList

			self._list:removeAllChildren()

			local lines = math.ceil(#data / 2)

			self._emptyPanel:setVisible(lines <= 0)

			for i = 1, lines do
				local item = self._itemCell:clone()

				self._list:pushBackCustomItem(item)
				self:setupActivity(item:getChildByName("item1"), data[i * 2 - 1])
				self:setupActivity(item:getChildByName("item2"), data[i * 2])
			end
		end
	end
end

function ActivityListMediator:setupActivity(item, data)
	if data == nil then
		item:setVisible(false)

		return
	end

	local timeText = item:getChildByName("timeLime")
	local tabImg = item:getChildByName("image")
	local tagImage = item:getChildByName("tagImage")
	local redPoint = item:getChildByName("hongdian")

	tabImg:loadTexture("asset/ui/mainScene/" .. data.Img, ccui.TextureResType.localType)

	if not self._activitySystem:isActivityCalendarShow(data) then
		tagImage:setVisible(false)
		redPoint:setVisible(false)

		local timeConfig = ConfigReader:getDataByNameIdAndKey("Activity", data.TypeId, "TimeFactor")
		local timeType = ConfigReader:getDataByNameIdAndKey("Activity", data.TypeId, "Time")
		local _, _, y, m, d, hour, min, sec = string.find(timeConfig.start[1], "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
		local timestamp = TimeUtil:timeByRemoteDate({
			year = y,
			month = m,
			day = d,
			hour = hour,
			min = min,
			sec = sec
		})
		local localDate = TimeUtil:localDate("%Y-%m-%d %H:%M:%S", timestamp)

		timeText:setString(Strings:get("ActivityCalendar_TimeStart_Text", {
			time = localDate
		}))

		local isShow = self._activitySystem:checkActivityCalNewTagShow("CLOSE_" .. data.Id)

		if isShow then
			self._activitySystem:saveActivityCalNewTag("CLOSE_" .. data.Id)
		end

		tagImage:setVisible(isShow)
		item:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self:dispatch(ShowTipEvent({
					tip = Strings:get("ActivityCalendar_EmptyText")
				}))
			end
		end)
	else
		item:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				if data.Link then
					local context = self:getInjector():instantiate(URLContext)
					local entry, params = UrlEntryManage.resolveUrlWithUserData(data.Link)

					if not entry then
						self:dispatch(ShowTipEvent({
							tip = Strings:get("Function_Not_Open")
						}))
					else
						entry:response(context, params)
					end
				else
					self:dispatch(ShowTipEvent({
						tip = "NO URL LINK!!!"
					}))
				end
			end
		end)

		if data.BannerTime and data.BannerTime["end"] then
			timeText:setString(Strings:get("ActivityCalendar_TimeEnd_Text", {
				time = data.BannerTime["end"]
			}))
		else
			local endTime = self._activitySystem:getActivityCalendarEndTime(data)
			local curstamp = TimeUtil:timeByRemoteDate()
			local limitDay = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Clender_LongTime", "content")

			timeText:setVisible(limitDay >= (endTime - curstamp) / 86400)

			local localDate = TimeUtil:localDate("%Y-%m-%d %H:%M:%S", endTime)

			timeText:setString(Strings:get("ActivityCalendar_TimeEnd_Text", {
				time = localDate
			}))
		end

		local isRedPointShow = self._activitySystem:isActivityCalendarRedpointShow(data)

		redPoint:setVisible(isRedPointShow)

		local isShow = self._activitySystem:checkActivityCalNewTagShow("OPEN_" .. data.Id)

		if isShow then
			self._activitySystem:saveActivityCalNewTag("OPEN_" .. data.Id)
		end

		if isRedPointShow then
			tagImage:setVisible(false)
		else
			tagImage:setVisible(isShow)
		end
	end
end

function ActivityListMediator:refreshRedPoint()
	self:refreshView()
end

function ActivityListMediator:refreshView()
	self._openList, self._closeList = self._activitySystem:getActivityCalendarList()

	self:setupTabBtn()
	self:setupList()
end
