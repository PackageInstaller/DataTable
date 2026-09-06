-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/springredpack/view/SpringRedPackInfoView.lua

module("logic.extensions.springredpack.view.SpringRedPackInfoView", package.seeall)

local SpringRedPackInfoView = class("SpringRedPackInfoView", TableViewComponent)

function SpringRedPackInfoView:buildUI()
	SpringRedPackInfoView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._closeBg = self:getGo("closebg")
	self._txtTitle = self:getGo("txtTitle")
	self._btnTip = self:getBtn("btnTip")
	self._btnRedPack = self:getBtn("btnRedPack")
	self._role = self:getGo("role")
	self._txtRemain = self:getTxt("txtRemain")
	self._extension = self:getGo("extension")
	self._txtTime = self:getTxt("time/txt")
	self._time = self:getGo("time")

	goutil.setActive(self._time, true)
end

function SpringRedPackInfoView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function SpringRedPackInfoView:bindEvents()
	SpringRedPackInfoView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnRedPack:AddClickListener(self._onClickRedPack, self)
end

function SpringRedPackInfoView:unbindEvents()
	SpringRedPackInfoView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnRedPack:RemoveClickListener()
end

function SpringRedPackInfoView:_setBtnCloseState(isShow)
	goutil.setActive(self._btnClose.gameObject, isShow)
	goutil.setActive(self._closeBg, isShow)
	goutil.setActive(self._txtTitle, isShow)
end

function SpringRedPackInfoView:onEnter()
	SpringRedPackInfoView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GainSpringRedPackRes, self._onGainSpringRedPackRes, self)
	self:_setBtnCloseState(false)

	local firstParam = self:getFirstParam()
	local firstParamType = type(firstParam)

	if firstParamType == "table" then
		-- block empty
	elseif firstParamType == "boolean" and firstParam then
		self:_setBtnCloseState(true)
	elseif firstParamType == "string" and not string.nilorempty(firstParam) then
		self:_setBtnCloseState(checknumber(firstParam) == 1)
	end

	local activityId = SpringRedPackModel.instance:getCurActivityId()
	local cfg = SpringRedPackConfig.instance:getActivityCfg(activityId)

	if not cfg then
		return
	end

	self._activityId = activityId
	self._cfg = cfg
	self._isFirstEnter = true
	self._unfoldIndex = 1

	self:_showRoleModel(self._role, cfg.raceId)
	self:_setTxtRemain()
	self:_initInfoList()
	self:_showGetRedPackSubView()
	self:_onSecond()
	settimer(1, self._onSecond, self)
end

function SpringRedPackInfoView:onExit()
	SpringRedPackInfoView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GainSpringRedPackRes, self._onGainSpringRedPackRes, self)
	self:_resetRoleModel()
	removetimer(self._onSecond, self)
end

function SpringRedPackInfoView:_onClickClose()
	self:close()
end

function SpringRedPackInfoView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "springredpocket_rule")
end

function SpringRedPackInfoView:_onClickRedPack()
	UIStateManager.instance:push(ViewName.SpringRedPackMineView)
end

function SpringRedPackInfoView:_showRoleModel(parent, curFaceId)
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, parent, scale, nil, true, x, y)
end

function SpringRedPackInfoView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function SpringRedPackInfoView:_getIsUnfold(timeDescribe)
	local year, month, day = string.match(timeDescribe, "(%d+)%.(%d+)%.(%d+)")

	if year and month and day then
		year = checknumber(year)
		month = checknumber(month)
		day = checknumber(day)

		local date = GameUtil.time2date(ServerTime.now())

		if date.year == year and date.month == month and date.day == day then
			return true
		else
			return false
		end
	else
		return false
	end
end

function SpringRedPackInfoView:_initInfoList()
	local cfgs = SpringRedPackConfig.instance:getPlanList(self._activityId)
	local list = {}

	for i, v in ipairs(cfgs) do
		local element = {}

		element.cfg = v
		element.isUnfold = self:_getIsUnfold(v.timeDescribe)

		if element.isUnfold then
			self._unfoldIndex = i
		end

		table.insert(list, element)
	end

	self:updateListData(list)
end

function SpringRedPackInfoView:_cellSize(view, index)
	local data = self._curViewDatas[index + 1]

	if data.isUnfold then
		return 660, 200
	else
		return 660, 116
	end
end

function SpringRedPackInfoView:_updateCell(view, cell, data)
	local txtTitle = goutil.findChildTextComponent(cell.gameObject, "txtTitle")
	local txtGo = goutil.findChild(cell, "txt")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local btnArrow = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnArrow")
	local btnAward = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnAward")
	local recttrans = cell.gameObject:GetComponent(goutil.Type_RectTransform)
	local item = goutil.findChild(cell, "item")
	local rectArrow = btnArrow:GetComponent(goutil.Type_RectTransform)

	btnAward:AddClickListener(function()
		UIStateManager.instance:push(ViewName.SpringRedPackAwardView, data.cfg.redPackId)
	end)
	btnArrow:AddClickListener(function()
		if not goutil.isNil(recttrans) then
			data.isUnfold = not data.isUnfold

			self:reloadData()
		end
	end)

	if data.isUnfold then
		goutil.setHeight(recttrans, 200)
		goutil.setActive(txtGo, true)
		goutil.setActive(txtDesc.gameObject, true)
		Framework.TransformUtil.SetEuler(rectArrow, 0, 0, 180)
	else
		goutil.setHeight(recttrans, 116)
		goutil.setActive(txtGo, false)
		goutil.setActive(txtDesc.gameObject, false)
		Framework.TransformUtil.SetEuler(rectArrow, 0, 0, 0)
	end

	txtTitle.text = string.format("%s %s", data.cfg.timeDescribe, data.cfg.planText)
	txtDesc.text = data.cfg.timeText

	local cfgRedPack = SpringRedPackConfig.instance:getRedPackCfg(data.cfg.redPackId)

	if cfgRedPack then
		MaterialMgr.setCellByCfg(cfgRedPack.prize, item)
	end
end

function SpringRedPackInfoView:_clearTableview(cell)
	local btnArrow = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnArrow")
	local btnAward = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnAward")
	local item = goutil.findChild(cell, "item")

	btnAward:RemoveClickListener()
	btnArrow:RemoveClickListener()
	MaterialMgr.resetAll(item)
end

function SpringRedPackInfoView:_onReloadFinish()
	if self._isFirstEnter then
		self._isFirstEnter = false

		self:moveCellToCenter(self._unfoldIndex)
	end
end

function SpringRedPackInfoView:_setTxtRemain()
	if self._cfg then
		local maxCount = self._cfg.dailyRounds
		local curCount = SpringRedPackModel.instance:getDailyGainRound()

		curCount = curCount <= maxCount and curCount or maxCount

		local leftCount = maxCount - curCount

		if leftCount > 0 then
			if not ColorConst.White then
				local colorStr = ColorConst.Red

				self._txtRemain.text = string.format("今日剩余领取次数：<color=#%s>%d</color>/%d", colorStr, leftCount, maxCount)
			end
		end
	end
end

function SpringRedPackInfoView:_showGetRedPackSubView()
	if SpringRedPackController.instance:isInActivityTime() then
		self:showTabAt(self._extension, ViewName.SpringRedPackHudView, SpringRedPackHudView.DailyPack2)
	end
end

function SpringRedPackInfoView:_onGainSpringRedPackRes()
	self:_setTxtRemain()
end

function SpringRedPackInfoView:_onSecond()
	self:_updateTime()
end

function SpringRedPackInfoView:_updateTime()
	local leftTime = 0
	local activityId = SpringRedPackModel.instance:getCurActivityId()

	if activityId and activityId > 0 then
		local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.SpringRedPack, activityId)

		leftTime = endTime - ServerTime.now()
		leftTime = leftTime >= 0 and leftTime or 0
	else
		leftTime = 0
	end

	self._txtTime.text = "剩余时间：" .. GameUtil.FormatTimeSymbol(leftTime)
end

return SpringRedPackInfoView
