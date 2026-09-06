-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/XiaonuoBirthView.lua

module("logic.extensions.bonus.view.XiaonuoBirthView", package.seeall)

local XiaonuoBirthView = class("XiaonuoBirthView", ViewComponent)
local Event_Name = "xiaonuobirthviewchangetab"

function XiaonuoBirthView:ctor()
	XiaonuoBirthView.super.ctor(self)
end

function XiaonuoBirthView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
end

function XiaonuoBirthView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnHome:RemoveClickListener()
end

function XiaonuoBirthView:buildUI()
	XiaonuoBirthView.super.buildUI(self)

	self._viewBgGo = self:getGo("viewBgGo")
	self._closeButton = self:getBtn("Close")
	self._btnHome = self:getBtn("btn_home")
	self.container = self:getGo("container")
	self.ScrollView = self:getGo("ScrollView")
	self.BtnCell = self:getGo("BtnCell")
	self.TxtTitle = self:getTxt("Title/TxtTitle")
	self._tableview = ScrollerList.create(self.ScrollView, self.BtnCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))
end

function XiaonuoBirthView:destroyUI()
	self._curViewDatas = nil

	BounsModel.instance:clearData(self._activityId)
end

function XiaonuoBirthView:onEnter()
	local params = self:getOpenParam() or {}
	local firstParam = params[1]

	self._activityId = self:_getActivityId()

	BounsModel.instance:setKey(self._activityId)
	self:updateViewList(self._activityId)

	local actCfg = XiaonuoBirthConfig.instance:getActivity(self._activityId)

	if actCfg then
		self.TxtTitle.text = actCfg.name
	end

	local idx = 1
	local data = self._curViewDatas[idx]

	if firstParam ~= nil then
		if type(firstParam) == "string" and not string.nilorempty(firstParam) and not string.nilorempty(firstParam) then
			for i, cfg in ipairs(self._curViewDatas) do
				if cfg and cfg.viewname == firstParam then
					data = cfg
					idx = i
				end
			end
		end
	else
		local bFound = false
		local repPointModel = RedPointModel.instance

		local function findData(targetId)
			for i, cfg in ipairs(self._curViewDatas) do
				if cfg and cfg.id == targetId then
					data = cfg
					idx = i
					bFound = true

					return
				end
			end
		end

		local saveId = BounsModel.instance:getXiaoNuoBirthLastOpenTagIdClear(self._activityId) or 0

		if not bFound and saveId > 0 then
			findData(saveId)
		end

		if not bFound then
			for i, cfg in ipairs(self._curViewDatas) do
				if cfg and cfg.redpointId then
					local redIds = string.split(cfg.redpointId, "#")

					for _, redId in ipairs(redIds or {}) do
						if repPointModel:isActive(redId) then
							data = cfg
							idx = i
							bFound = true

							break
						end
					end

					if bFound then
						break
					end

					redIds = string.split(cfg.dayRedpointId, "#")

					for _, redId in ipairs(redIds or {}) do
						if repPointModel:isActive(redId) then
							data = cfg
							idx = i
							bFound = true

							break
						end
					end

					if bFound then
						break
					end
				end
			end
		end

		saveId = BounsModel.instance:getXiaoNuoBirthLastOpenTagId(self._activityId) or 0

		if not bFound and saveId > 0 then
			findData(saveId)
		end
	end

	self:_onClickView(data)
	self._tableview:refresh()

	if idx > 0 then
		self._tableview:MoveCellInView(idx - 1, false)
	end

	GlobalDispatcher:addListener(Event_Name, self.onViewTabChange, self)
end

function XiaonuoBirthView:_getActivityId()
	return ActivitySummaryController.instance:getActivityId()
end

function XiaonuoBirthView:_startPlayVoice()
	local str = "xbv_lingwenkaiqi" .. LoginModel.instance.userId
	local value = GameUtil.getUserDayData(str)

	if checknumber(value) == 1 then
		return
	end

	ViewBlockMgr.instance:blockClick(true, self)
	AnimationPlayer.play("storyconfig/animations/dh_lingwenkaiqi.txt", function()
		ViewBlockMgr.instance:blockClick(false, self)
	end, nil, self)
	GameUtil.saveUserDayData(str, 1)
end

function XiaonuoBirthView:onViewTabChange(params)
	local viewName

	if params then
		viewName = params[1]
	end

	if not string.nilorempty(viewName) then
		local data
		local idx = 0

		for i, cfg in ipairs(self._curViewDatas) do
			if cfg and cfg.viewname == viewName then
				data = cfg
				idx = i
			end
		end

		if idx > 0 then
			self:_onClickView(data)
			self._tableview:MoveCellInView(idx - 1, false)
		end
	end
end

function XiaonuoBirthView:updateViewList(activityId)
	local list = XiaonuoBirthConfig.instance:getTabList(activityId) or {}

	self._curViewDatas = {}

	for i, cfg in ipairs(list) do
		if not string.nilorempty(cfg.limitTime) then
			local arr = string.split(cfg.limitTime, "#")

			if GameUtil.checkIsInTimePeriod(arr[1], arr[2]) then
				table.insert(self._curViewDatas, cfg)
			end
		elseif checknumber(cfg.funcId) > 0 then
			if FuncOpenModel.instance:getFuncIsOpen(checknumber(cfg.funcId)) then
				table.insert(self._curViewDatas, cfg)
			end
		else
			table.insert(self._curViewDatas, cfg)
		end
	end

	self._tableview:reloadData(self._curViewDatas)
end

function XiaonuoBirthView:onExit()
	self._tableview:dispose()
	GlobalDispatcher:removeListener(Event_Name, self.onViewTabChange, self)
end

function XiaonuoBirthView:_updateCell(view, cell, data)
	local selected = goutil.findChild(cell, "selected")
	local unselect = goutil.findChild(cell, "unselect")
	local txtSel = goutil.findChildTextComponent(selected, "Text")
	local txtUnSel = goutil.findChildTextComponent(unselect, "Text")
	local tag = goutil.findChild(cell, "tag")
	local txtTag = goutil.findChildTextComponent(tag, "Text")
	local imgTagChange = tag:GetComponent("UIImageSpriteChange")
	local redPoint = goutil.findChild(cell, "imgPoint")

	txtSel.text = data.title
	txtUnSel.text = data.title

	local hasTag = not string.nilorempty(data.tagName)

	if self._curSelectData then
		local isSelected = self._curSelectData.id == data.id

		goutil.setActive(tag, hasTag)

		if hasTag then
			imgTagChange:SetState(data.tagColor - 1)

			txtTag.text = data.tagName
		end

		selected:SetActive(isSelected)
		unselect:SetActive(not isSelected)
		GameUtil.SetActive(redPoint, false)
		RedPointController.instance:unregRedPoint(redPoint)

		local arr

		if not string.nilorempty(data.redpointId) then
			arr = string.split(data.redpointId, "#")
		end

		arr = arr or {}

		if not string.nilorempty(data.dayRedpointId) then
			table.insert(arr, data.dayRedpointId)
		end

		if #arr > 0 then
			RedPointController.instance:regRedPoint(redPoint, unpack(arr))
		end

		GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickView, self, data))
	end
end

function XiaonuoBirthView:_clearTableview(cell)
	GameUtil.rmClickHandler(cell)

	local redPoint = goutil.findChild(cell, "imgPoint")

	RedPointController.instance:unregRedPoint(redPoint)
end

function XiaonuoBirthView:_onClickClose()
	BounsModel.instance:setXiaoNuoBirthLastOpenTagIdClear(0)

	self._curSelectData = nil

	self:close()
end

function XiaonuoBirthView:_onClickView(data)
	BounsModel.instance:setXiaoNuoBirthLastOpenTagId(data.id)
	BounsModel.instance:setXiaoNuoBirthLastOpenTagIdClear(data.id)

	self._curSelectData = data

	GameUtil.SetActive(self._viewBgGo, data.viewname ~= "powersurge")

	local cfg = ActivityDefineController.instance:getActivityCfgByType(checknumber(GameEnum.ActivityType.WelfareSummary))

	if cfg and not string.nilorempty(cfg.startTime) then
		local startTime = GameUtil.string2time(cfg.startTime)
		local nowTime = ServerTime.now()
		local index = startTime <= nowTime + 604800 and 1 or 2

		ActivitySummaryController.instance:resetTableRedPoint(data.dayRedpointId, index)
	end

	SurveyController.instance:reportBehavior(data.reportBehavior)
	self:showTabAt(self.container, "")

	if checknumber(data.isDirect) == 1 then
		self:showTabAt(self.container, data.viewname, data.parameter)
	else
		self:showTabAt(self.container, data.viewname, data)
	end

	if string.find(data.redpointId, tostring(RedPointModel.ID_DRAGONTRAIL_DAILY)) then
		GlobalDispatcher:dispatch(GlobalNotify.ClearDragontrialDailyDot)
	end

	self._tableview:refresh()
end

function XiaonuoBirthView:_onClickHome()
	UIStateManager.instance:clear(true)
end

return XiaonuoBirthView
