-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/TianyanSummaryView.lua

module("logic.extensions.operationsummary.view.TianyanSummaryView", package.seeall)

local TianyanSummaryView = class("TianyanSummaryView", ViewComponent)
local JINGJIU_ACTID = 17001
local TIANYAN_ACTID = 17002

function TianyanSummaryView:ctor()
	TianyanSummaryView.super.ctor(self)
end

function TianyanSummaryView:buildUI()
	TianyanSummaryView.super.buildUI(self)

	self._container = self:getGo("container")
	self._btnTianYan = self:getBtn("btnTianYan")
	self._goTianYanSelect = self:getGo("btnTianYan/select")
	self._goTianYanRedPoint = self:getGo("btnTianYan/redPoint")
	self._btnJingJiu = self:getBtn("btnJingJiu")
	self._goJingJiuSelect = self:getGo("btnJingJiu/select")
	self._goJingJiuRedPoint = self:getGo("btnJingJiu/redPoint")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._jjView = self:getGo("container/jingjiuview")
	self._tianyanView = self:getGo("container/tianyanview")
	self._goJjOpenTime = self:getGo("btnJingJiu/openTime")
	self._goTyOpenTime = self:getGo("btnTianYan/openTime")
	self._txtJjOpenTime = goutil.findChildTextComponent(self.mainGO, "btnJingJiu/openTime/txt")
	self._txtTyOpenTime = goutil.findChildTextComponent(self.mainGO, "btnTianYan/openTime/txt")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
	self._btnTip = self:getBtn("leftTop/btn_tip")
end

function TianyanSummaryView:bindEvents()
	TianyanSummaryView.super.bindEvents(self)
	self._btnTianYan:AddClickListener(function()
		self:_selectTabView(OpSummaryModel.TAB_TIANYAN)
	end, self)
	self._btnJingJiu:AddClickListener(function()
		self:_selectTabView(OpSummaryModel.TAB_JINGJIU)
	end, self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTipRule, self)
end

function TianyanSummaryView:unbindEvents()
	TianyanSummaryView.super.unbindEvents(self)
	self._btnTianYan:RemoveClickListener()
	self._btnJingJiu:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function TianyanSummaryView:destroyUI()
	TianyanSummaryView.super.destroyUI(self)
end

function TianyanSummaryView:onEnter()
	TianyanSummaryView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._refreshRedPoint, self)

	local activityId = self:getFirstParam()

	self._selectTab = checknumber(activityId) > 0 and (activityId == JINGJIU_ACTID and OpSummaryModel.TAB_JINGJIU or OpSummaryModel.TAB_TIANYAN) or OpSummaryModel.instance:getSelectTab()
	self.mainCfg = OperationSummaryConfig.instance:getSummaryCfg()

	local jjActCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.Summary, JINGJIU_ACTID)

	self.jjOpenState = GameUtil.getTimePeriodType(jjActCfg.startTime, jjActCfg.endTime)

	if self.jjOpenState == GameUtil.inTimePeriod then
		goutil.setActive(self._goJjOpenTime, false)
	else
		self._jjStartTime = GameUtil.parseToTimeTable(jjActCfg.startTime)
		self._txtJjOpenTime.text = langPara("%s.%s开启", self._jjStartTime.month, self._jjStartTime.day)

		goutil.setActive(self._goJjOpenTime, true)

		self._selectTab = OpSummaryModel.TAB_TIANYAN
	end

	local tyActCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.Summary, TIANYAN_ACTID)

	self.tyOpenState = GameUtil.getTimePeriodType(tyActCfg.startTime, tyActCfg.endTime)

	if self.tyOpenState == GameUtil.inTimePeriod then
		goutil.setActive(self._goTyOpenTime, false)
	else
		self._tyStartTime = GameUtil.parseToTimeTable(tyActCfg.startTime)
		self._txtTyOpenTime.text = langPara("%s.%s开启", self._tyStartTime.month, self._tyStartTime.day)

		goutil.setActive(self._goTyOpenTime, true)

		self._selectTab = OpSummaryModel.TAB_JINGJIU
	end

	self:_refreshTab()
	self:_refreshRedPoint()
end

function TianyanSummaryView:onEnterFinished()
	TianyanSummaryView.super.onEnterFinished(self)
end

function TianyanSummaryView:onExit()
	TianyanSummaryView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._refreshRedPoint, self)
	GlobalModel.instance:visibleMainCamera(true)
end

function TianyanSummaryView:onExitFinished()
	TianyanSummaryView.super.onExitFinished(self)
end

function TianyanSummaryView:_refreshTab()
	if self.mainCfg then
		self._txtTitle.text = self._selectTab == OpSummaryModel.TAB_JINGJIU and self.mainCfg[JINGJIU_ACTID].summaryName or self.mainCfg[TIANYAN_ACTID].summaryName
	end

	goutil.setActive(self._goJingJiuSelect, self._selectTab == OpSummaryModel.TAB_JINGJIU)
	goutil.setActive(self._goTianYanSelect, self._selectTab == OpSummaryModel.TAB_TIANYAN)

	if self._selectTab == OpSummaryModel.TAB_JINGJIU then
		if not JINGJIU_ACTID then
			local activityId = TIANYAN_ACTID

			self:showTabAt(self._container, ViewName.OperationSummaryView, activityId)

			local cfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.Summary, activityId)
			local startTime = GameUtil.parseToTimeTable(cfg.startTime)
			local endTime = GameUtil.parseToTimeTable(cfg.endTime)

			self._txtOpenTime.text = langPara("活动时间：%s.%s.%s-%s.%s.%s", startTime.year, startTime.month, startTime.day, endTime.year, endTime.month, endTime.day)
		end
	end
end

function TianyanSummaryView:_selectTabView(selectTab)
	if self._selectTab ~= selectTab then
		OpSummaryModel.instance:setSelectTab(selectTab)

		if selectTab == OpSummaryModel.TAB_JINGJIU then
			if self.jjOpenState == GameUtil.beforeTimePeriod then
				FloatWordMgr.instance:show(langPara("%s主题活动将于%d.%d 开启，敬请期待", self.mainCfg[JINGJIU_ACTID].summaryName, self._jjStartTime.month, self._jjStartTime.day))

				return
			elseif self.jjOpenState == GameUtil.afterTimePeriod then
				FloatWordMgr.instance:show(langPara("%s主题活动已结束", self.mainCfg[JINGJIU_ACTID].summaryName))

				return
			end
		elseif self.tyOpenState == GameUtil.beforeTimePeriod then
			FloatWordMgr.instance:show(langPara("%s主题活动将于%d.%d 开启，敬请期待", self.mainCfg[TIANYAN_ACTID].summaryName, self._tyStartTime.month, self._tyStartTime.day))

			return
		elseif self.tyOpenState == GameUtil.afterTimePeriod then
			FloatWordMgr.instance:show(langPara("%s主题活动已结束", self.mainCfg[TIANYAN_ACTID].summaryName))

			return
		end

		self._selectTab = selectTab

		local params = {}

		params.tab = self._selectTab

		self:_refreshTab()
	end
end

function TianyanSummaryView:_refreshRedPoint()
	local jjRed = false
	local tyRed = false

	self.jjCfgList = OperationSummaryConfig.instance:getItemCfg(JINGJIU_ACTID)
	self.tyCfgList = OperationSummaryConfig.instance:getItemCfg(TIANYAN_ACTID)

	for k, v in pairs(self.jjCfgList) do
		local jjdata = v

		if jjdata and checknumber(jjdata.redpointId) ~= 0 then
			local isRed = RedPointModel.instance:isActive(jjdata.redpointId)

			if isRed then
				jjRed = true
			end
		end
	end

	for k, v in pairs(self.tyCfgList) do
		local tydata = v

		if tydata and checknumber(tydata.redpointId) ~= 0 then
			local isRed = RedPointModel.instance:isActive(tydata.redpointId)

			if isRed then
				tyRed = true
			end
		end
	end

	goutil.setActive(self._goTianYanRedPoint, tyRed and self.tyOpenState == GameUtil.inTimePeriod)
	goutil.setActive(self._goJingJiuRedPoint, jjRed and self.jjOpenState == GameUtil.inTimePeriod)
end

function TianyanSummaryView:_onClickTipRule()
	local ruleCo = RulesConfig.instance:getRuleCo("OpSummaryRule")
	local title = tostring((not ruleCo.title or nil) and 0)

	if not title or title == "0" or #title == 0 then
		title = lang("tip")
	end

	TipsFacade.instance:openTipWindowNoX(title, ruleCo.rules)
end

return TianyanSummaryView
