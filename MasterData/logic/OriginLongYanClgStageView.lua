-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongyanclg/view/OriginLongYanClgStageView.lua

module("logic.extensions.originlongyanclg.view.OriginLongYanClgStageView", package.seeall)

local OriginLongYanClgStageView = class("OriginLongYanClgStageView", ViewComponent)

function OriginLongYanClgStageView:ctor()
	OriginLongYanClgStageView.super.ctor(self)
end

function OriginLongYanClgStageView:unbindEvents()
	OriginLongYanClgStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnFight)
end

function OriginLongYanClgStageView:bindEvents()
	OriginLongYanClgStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnFight, self._onClickBtnFight, self)
end

function OriginLongYanClgStageView:buildUI()
	OriginLongYanClgStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnFight = self:getGo("info/btnFight")

	local goTab = self:getGo("stage/tableview")
	local gocell = self:getGo("stage/cell")

	self._tableview = ScrollerList.create(goTab, gocell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtrule = self:getTxt("info/rule/Viewport/txt")
	self._txtPassDesc = self:getTxt("info/txtPassDesc")
	self._pirzeIcon = self:getGo("info/pirzeIcon")
end

function OriginLongYanClgStageView:onExit()
	OriginLongYanClgStageView.super.onExit(self)
	self._tableview:dispose()
	self:_setLastSelectId()
	MaterialMgr.resetAll(self._pirzeIcon)
end

function OriginLongYanClgStageView:onEnter()
	OriginLongYanClgStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginLongYanClgGetInfoRes, self._updateUIByInfo, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 563001
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()

	local lastSelectId = self:_getLastSelectId()

	lastSelectId = math.min(lastSelectId, #self._stageCfgs)

	if lastSelectId == 0 then
		lastSelectId = 1
	end

	self:_switchToStage(lastSelectId)
	OriginLongYanClgController.instance:showCI()
	OriginLongYanClgController.instance:getInfo(self._activityId)
end

function OriginLongYanClgStageView:_updateUIByCfg()
	self._stageCfgs = OriginLongYanClgConfig.instance:getStageCfgs(self._activityId) or {}

	local activityType = ActivityDefineController.instance:getActTypeByActId(self._activityId)
	local actCfg = ActivityDefineConfig.instance:getCfgById(activityType, self._activityId)

	self._startTimeStamp = GameUtil.string2time(actCfg.startTime)
end

function OriginLongYanClgStageView:_updateUIByInfo()
	self._maxPassStageId = 0

	local info = OriginLongYanClgModel.instance:getInfoByActId(self._activityId)

	if info then
		if not info.passedStageId then
			self._maxPassStageId = 0
		end
	end

	self._tableview:reloadData(self._stageCfgs)

	local curShowStageId = self._maxPassStageId + 1

	if curShowStageId > #self._stageCfgs then
		curShowStageId = self._maxPassStageId
	end

	local stageCfg = self._stageCfgs[curShowStageId]

	if stageCfg then
		local openTimeStamp = self._startTimeStamp + ((not stageCfg.openDay or nil) and 0) * 60 * 60 * 24
		local isUnlock = openTimeStamp <= ServerTime.now()

		if not isUnlock then
			curShowStageId = self._maxPassStageId
		end
	end

	self._tableview:MoveCellToBegin(curShowStageId - 1)
	self:_switchToStage(curShowStageId)
end

function OriginLongYanClgStageView:_onClickBtnFight()
	local stageCfg = self._stageCfgs[self._curStageId]

	if not stageCfg then
		return
	end

	if self._maxPassStageId >= self._curStageId then
		FloatWordMgr.instance:show("该关卡已通关，请选择其他关卡挑战")

		return
	end

	OriginLongYanClgController.instance:showMissionView(self._activityId, self._curStageId)
end

function OriginLongYanClgStageView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local com = goutil.findChild(go, "com")

	if not data.pos then
		GameUtil.setAnchoredPos(com, data.pos[1], data.pos[2])

		local txtName = goutil.findChildTextComponent(com, "name/txt")

		if not data.passSignId then
			local signId = 0
			local signCfg = OriginLongYanClgConfig.instance:getSignCfgById(self._activityId, signId)

			if signCfg then
				txtName.text = signCfg.signName or ""
			end

			local goSelect = goutil.findChild(com, "select")

			goutil.setActive(goSelect, data.stageId == self._curStageId)

			local goShowPic = goutil.findChild(com, "showPic")

			GameUtil.addClickHandler(goShowPic, GameUtil.handler(self._onClickStage, self, data))

			local changeShowPic = goShowPic:GetComponent("UIImageSpriteChange")

			changeShowPic:ChangeSprite(data.showPic or "")

			local isPass = self._maxPassStageId >= data.stageId
			local goPass = goutil.findChild(com, "pass")

			goutil.setActive(goPass, isPass)

			local goLock = goutil.findChild(com, "lock")
			local isUnlock = ServerTime.now() >= self._startTimeStamp + (data.openDay or 0) * 60 * 60 * 24

			goutil.setActive(goLock, not isUnlock or data.stageId > self._maxPassStageId + 1)
		end
	end
end

function OriginLongYanClgStageView:_clearCell(cell)
	local go = cell.gameObject
	local com = goutil.findChild(go, "com")
	local goShowPic = goutil.findChild(com, "showPic")

	GameUtil.rmClickHandler(goShowPic)
end

function OriginLongYanClgStageView:_onClickStage(stageCfg)
	if self._curStageId ~= stageCfg.stageId then
		local openTimeStamp = self._startTimeStamp + ((not stageCfg.openDay or nil) and 0) * 60 * 60 * 24
		local isUnlock = openTimeStamp <= ServerTime.now()

		if isUnlock then
			if self._maxPassStageId + 1 < stageCfg.stageId then
				FloatWordMgr.instance:show("请先通关前一关卡后再挑战该关卡")

				return
			end

			self:_switchToStage(stageCfg.stageId)
		else
			local dateOpen = GameUtil.time2date(openTimeStamp)
			local openTips = string.format("该关卡将%s月%s日%s时后开启，敬请期待！", tostring(dateOpen.month), tostring(dateOpen.day), tostring(dateOpen.hour))

			FloatWordMgr.instance:show(openTips)
		end
	end
end

function OriginLongYanClgStageView:_switchToStage(stageId)
	self._curStageId = stageId

	self._tableview:reloadData(self._stageCfgs)

	local stageCfg = self._stageCfgs[stageId]

	if stageCfg then
		self._txtrule.text = stageCfg.ruleDesc or ""
		self._txtPassDesc.text = stageCfg.passDesc or ""

		MaterialMgr.resetAll(self._pirzeIcon)
		MaterialMgr.setCellByCfg(stageCfg.prize, self._pirzeIcon)
	end
end

function OriginLongYanClgStageView:_getLastSelectId()
	local saveKey = string.format("OriginLongYanClgStageView_LastSelectId_%d", self._activityId)

	return checknumber(GameUtil.getUserData(saveKey))
end

function OriginLongYanClgStageView:_setLastSelectId()
	local saveKey = string.format("OriginLongYanClgStageView_LastSelectId_%d", self._activityId)

	GameUtil.saveUserData(saveKey, tostring(self._curStageId))
end

return OriginLongYanClgStageView
