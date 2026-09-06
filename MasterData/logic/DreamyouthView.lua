-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamyouth/view/DreamyouthView.lua

module("logic.extensions.dreamyouth.view.DreamyouthView", package.seeall)

local DreamyouthView = class("DreamyouthView", ViewComponent)

function DreamyouthView:ctor()
	DreamyouthView.super.ctor(self)
end

function DreamyouthView:bindEvents()
	DreamyouthView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i = 1, 3 do
		GameUtil.addClickHandler(self._btnTab[i], GameUtil.handler(self._onClickTab, self, i))
	end

	GameUtil.addClickHandler(self._btnTip, self._onTip, self)
end

function DreamyouthView:unbindEvents()
	GameUtil.rmClickHandler(self._btnClose)

	for i = 1, 3 do
		GameUtil.rmClickHandler(self._btnTab[i])
	end

	GameUtil.rmClickHandler(self._btnTip)
	DreamyouthView.super.unbindEvents(self)
end

function DreamyouthView:buildUI()
	DreamyouthView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._container = self:getGo("container")
	self._txtTime = self:getTxt("time/txt")
	self._goldBarCon = self:getGo("goldBarCon")
	self._btnTip = self:getBtn("btnTip")
	self._selectFlag = {}
	self._btnTab = {}
	self._redPoint = {}

	for i = 1, 3 do
		self._btnTab[i] = self:getBtn("btnTab" .. i)
		self._selectFlag[i] = self:getGo("btnTab" .. i .. "/selected")
		self._redPoint[i] = self:getGo("btnTab" .. i .. "/imgPoint")
	end
end

function DreamyouthView:destroyUI()
	DreamyouthView.super.destroyUI(self)
end

function DreamyouthView:onEnter()
	DreamyouthView.super.onEnter(self)
	self:_initTabCfg()
	self:_initTabIndex()
	self:_initRedPoint()
	self:_onClickTab(self._curSelectTab)

	local btn_list = {
		{
			showAdd = false,
			id = DreamyouthConfig.instance:getCoinItemStr()
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)

	local key = "dreamyouth_movie"

	GameUtil.getUserDayData(key, function(value)
		if checknumber(value) == 0 then
			ViewBlockMgr.instance:blockClick(true, self)
			AnimationPlayer.play("storyconfig/animations/zhengjiuxiaonuo.txt", function()
				ViewBlockMgr.instance:blockClick(false, self)
			end)
			GameUtil.saveUserDayData(key, 1)
		end
	end)
end

function DreamyouthView:onEnterFinished()
	DreamyouthView.super.onEnterFinished(self)
end

function DreamyouthView:onExit()
	self._curTabCfgs = nil

	for i = 1, 3 do
		RedPointController.instance:unregRedPoint(self._redPoint[i])
	end

	DreamyouthView.super.onExit(self)
end

function DreamyouthView:_initTabCfg()
	self._curTabCfgs = DreamyouthConfig.instance:getTabCfg()
end

function DreamyouthView:_initTabIndex()
	local firstParam = self:getFirstParam()

	if firstParam ~= nil then
		if type(firstParam) == "number" and self._curTabCfgs[firstParam] ~= nil then
			self._curSelectTab = checknumber(firstParam)
		end

		if type(firstParam) == "string" and not string.nilorempty(firstParam) and not string.nilorempty(firstParam) then
			for i, cfg in ipairs(self._curTabCfgs) do
				if cfg and cfg.viewname == firstParam then
					self._curSelectTab = i
				end
			end
		end
	end

	self._curSelectTab = self._curSelectTab or 1
end

function DreamyouthView:_initRedPoint()
	for i = 1, 3 do
		local data = self._curTabCfgs[i]

		RedPointController.instance:regRedPoint(self._redPoint[i], unpack(string.splitToNumber(data.redpointId or "", "#")))
	end
end

function DreamyouthView:_getFirstRedActiveData()
	for _idx, v in ipairs(self._curTabCfgs) do
		local redPointIds = string.splitToNumber(v.redpointId or "", "#")

		for _, redPointId in ipairs(redPointIds) do
			if RedPointModel.instance:isActive(redPointId) then
				return _idx
			end
		end
	end

	return 1
end

function DreamyouthView:_updateUI()
	for i = 1, 3 do
		goutil.setActive(self._selectFlag[i], i == self._curSelectTab)
	end

	local cfg = DreamyouthConfig.instance:getActCfg()
	local timeStart = GameUtil.string2date(cfg.startTime, true)
	local timeEnd = GameUtil.string2date(cfg.endTime, true)

	self._txtTime.text = string.format("活动时间：%d.%d %d:%02d-%d.%d %d:%02d", timeStart.month, timeStart.day, timeStart.hour, timeStart.min, timeEnd.month, timeEnd.day, timeEnd.hour, timeEnd.min)
end

function DreamyouthView:_onClickTab(i)
	self._curSelectTab = i

	local data = self._curTabCfgs[i]

	SurveyController.instance:reportBehavior(data.reportBehavior)
	self:showTabAt(self._container, data.viewname, data.parameter)
	self:_updateUI()
end

function DreamyouthView:_onTip()
	UIStateManager.instance:push(ViewName.RulesView, "dreamyouth_rule")
end

return DreamyouthView
