-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/view/DefendcarrotnormalView.lua

module("logic.extensions.defendcarrot.view.DefendcarrotnormalView", package.seeall)

local DefendcarrotnormalView = class("DefendcarrotnormalView", ViewComponent)

function DefendcarrotnormalView:ctor()
	DefendcarrotnormalView.super.ctor(self)
end

function DefendcarrotnormalView:unbindEvents()
	DefendcarrotnormalView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DefendcarrotnormalView:bindEvents()
	DefendcarrotnormalView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
end

function DefendcarrotnormalView:buildUI()
	DefendcarrotnormalView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._itemCell = self:getGo("itemCell")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")

	GameUtil.SetActive(self._itemCell, false)

	self._txtLvl = self:getTxt("lvlGo/txtLvl")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DefendcarrotnormalView:onExit()
	DefendcarrotnormalView.super.onExit(self)
	self._scrollList:dispose()
end

function DefendcarrotnormalView:onEnter()
	DefendcarrotnormalView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = 517001
	end

	self.addGEvent(self, GlobalNotify.DefendCarrotGetInfo, self._refreshUI, self)
	DefendCarrotController.instance:getInfo(self._activityId)
	self:_refreshUI()
	DefendCarrotController.instance:showCI()
end

function DefendcarrotnormalView:_refreshUI()
	local info = DefendCarrotModel.instance:getBaseInfo(self._activityId) or {}

	if not info.stages then
		local stages = {}

		self._maxStage = 0
		self._stageMap = {}

		for i, v in ipairs(stages) do
			self._stageMap[v.stageId] = v
			self._maxStage = math.max(self._maxStage, v.stageId)
		end

		local cfgList = DefendCarrotConfig.instance:getStageCfgs(self._activityId) or {}

		self._scrollList:reloadData(cfgList)

		if self._maxStage == 0 then
			self._scrollList:MoveCellToBegin(0)
		else
			self._scrollList:MoveCellToBegin(self._maxStage - 1)
		end

		self._txtLvl.text = langPara("当前%s/%s关", self._maxStage, #cfgList)
	end
end

function DefendcarrotnormalView:_updateCell(view, cell, data, tag)
	local task = goutil.findChild(cell, "task")
	local txtTask = goutil.findChildTextComponent(cell, "task/txtTask")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local container = goutil.findChild(cell, "container")
	local time = goutil.findChild(cell, "time")
	local txtTime = goutil.findChildTextComponent(cell, "time/txt")
	local waiting = goutil.findChild(cell, "waiting")
	local pass = goutil.findChild(cell, "pass")

	GameUtil.SetActive(pass, false)
	GameUtil.SetActive(waiting, false)
	GameUtil.SetActive(time, false)
	GameUtil.SetActive(task, false)

	txtName.text = data.stageName

	local stagePlanId = data.stagePlanId
	local cfg = DefendCarrotConfig.instance:getStagePlanCfg(stagePlanId) or {}

	if not cfg.typelimit then
		local typelimit = ""
		local arr = string.splitToNumber(typelimit, "#")

		goutil.clearChildren(container)

		for i, v in ipairs(arr) do
			local item = goutil.cloneAndSetParent(self._itemCell, container.transform, "cell_" .. i)

			GameUtil.SetActive(item, true)

			local txt = goutil.findChildTextComponent(item, "txt")

			txt.text = "武器：" .. v

			local icon = goutil.findChildComponent(item, "weaponicon", "UIImageSpriteChange")
			local imageIcon = icon:GetComponent(goutil.Type_UIImage)
			local weaponCfg = DefendCarrotConfig.instance:getWeaponCfg(self._activityId, v)

			if weaponCfg then
				icon:ChangeSprite(weaponCfg.weaponPic)
				imageIcon:SetNativeSize()
			end
		end

		if not self._stageMap[data.stageId] then
			if not self._stageMap[data.stageId].finishedTaskIds then
				local finishedTaskIds = {}
				local list = DefendCarrotConfig.instance:getStageTaskCfgs(self._activityId, data.stageId) or {}
				local total = #list

				txtTask.text = langPara("额外任务完成：%s/%s", #finishedTaskIds, total)

				if data.stageId == self._maxStage + 1 then
					-- block empty
				elseif data.stageId <= self._maxStage then
					GameUtil.SetActive(pass, true)
					GameUtil.SetActive(task, true)
				else
					GameUtil.SetActive(waiting, true)
					GameUtil.SetActive(task, false)
				end

				local dateOpen = GameUtil.string2date(data.openDate)

				txtTime.text = string.format("%d.%d %d:%02d开启", dateOpen.month, dateOpen.day, dateOpen.hour, dateOpen.min)

				if GameUtil.getTimePeriod(data.openDate, "") == GameUtil.inTimePeriod then
					GameUtil.SetActive(time, false)
				else
					GameUtil.SetActive(time, true)
					GameUtil.SetActive(waiting, false)
				end

				GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickCell, self, data))
			end
		end
	end
end

function DefendcarrotnormalView:_clearCell(cell)
	return
end

function DefendcarrotnormalView:_onClickCell(data)
	local dateOpen = GameUtil.string2date(data.openDate)

	if GameUtil.getTimePeriod(data.openDate, "") ~= GameUtil.inTimePeriod then
		TipsFacade.instance:openCommonTips(string.format("%d.%d %d:%02d后开启", dateOpen.month, dateOpen.day, dateOpen.hour, dateOpen.min))

		return
	end

	if data.stageId == self._maxStage + 1 then
		DefendCarrotController.instance:startGame(self._activityId, data.stageId)
	elseif data.stageId <= self._maxStage then
		DefendCarrotController.instance:startGame(self._activityId, data.stageId)
	else
		TipsFacade.instance:openCommonTips("请先通关前面关卡")
	end
end

function DefendcarrotnormalView:_onClickTips()
	TipsFacade.instance:openRulesView("defendcarrotnormalview_rule")
end

return DefendcarrotnormalView
