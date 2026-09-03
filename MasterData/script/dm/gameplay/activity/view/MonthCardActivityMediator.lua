-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/MonthCardActivityMediator.lua

MonthCardActivityMediator = class("MonthCardActivityMediator", DmAreaViewMediator, _M)

MonthCardActivityMediator:has("_rechargeAndVipModel", {
	is = "r"
}):injectWith("RechargeAndVipModel")
MonthCardActivityMediator:has("_rechargeAndVipSystem", {
	is = "r"
}):injectWith("RechargeAndVipSystem")
MonthCardActivityMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

function MonthCardActivityMediator:initialize()
	super.initialize(self)
end

function MonthCardActivityMediator:dispose()
	super.dispose(self)
end

function MonthCardActivityMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_MONTHCARD_SUCC, self, self.setupView)
	self.mapEventListener(self, self:getEventDispatcher(), PAY_INIT_SUCCESS, self, self.setupView)
end

function MonthCardActivityMediator:enterWithData(data)
	self._parentMediator = data.parentMediator

	self:setupView()
	self:addShowHero()
end

function MonthCardActivityMediator:addShowHero()
	local SptiteNode = self._main:getChildByName("SptiteNode")

	SptiteNode:removeAllChildren()

	local image = cc.Sprite:create("asset/heros/HLDNan/portraitpic_HLDNan.png")

	image:addTo(SptiteNode)
end

function MonthCardActivityMediator:setupView()
	self._main = self:getView():getChildByName("main")

	local monthCardInfo = ConfigReader:getDataTable("MonthCard")
	local cardMap = self._rechargeAndVipModel:getMonthCardMap()
	local index = 1

	for k, v in pairs(monthCardInfo) do
		if k == "MonthCard_1" then
			local monthCardCell = self._main:getChildByName("monthCardCell" .. index)
			local lineGradiantVec2 = {
				{
					ratio = 0.7,
					color = cc.c4b(255, 255, 255, 255)
				},
				{
					ratio = 1,
					color = cc.c4b(129, 118, 113, 255)
				}
			}
			local TextCardBg = monthCardCell:getChildByName("TextCardBg")

			if TextCardBg then
				local TextCard = TextCardBg:getChildByName("TextCard")

				TextCard:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
					x = 0,
					y = -1
				}))
			end

			local remainDayPanel = monthCardCell:getChildByName("remainDay")

			if monthCardCell and remainDayPanel then
				local monthCardModel = cardMap[k]
				local remainDays = 0

				if monthCardModel then
					local endTimes = monthCardModel:getEndTimes()
					local lastTimes = monthCardModel:getLastRewardTimes()

					remainDays = self:getRemainDays(endTimes, lastTimes, 0)

					monthCardCell:removeChildByTag(32001, true)

					if remainDays > 0 then
						remainDayPanel:setVisible(true)

						local num = remainDayPanel:getChildByName("num")

						num:setString(remainDays)

						local remain = remainDayPanel:getChildByName("remain")
						local day = remainDayPanel:getChildByName("day")

						remain:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
							x = 0,
							y = -1
						}))
						day:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
							x = 0,
							y = -1
						}))
						num:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
							x = 0,
							y = -1
						}))
					else
						remainDayPanel:setVisible(false)
					end
				end

				local _index = index

				local function callFunc(sender, eventType)
					local data = {}

					data.index = _index
					data.moneyInfo = monthCardModel
					data.info = monthCardInfo[k]
					data.remainDays = remainDays

					local view = self:getInjector():getInstance("MCInfoPopView")

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
						transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
					}, data))
				end

				mapButtonHandlerClick(nil, monthCardCell, {
					func = callFunc
				})
			end

			index = index + 1
		end
	end
end

function MonthCardActivityMediator:getRemainDays(endTime, lastTime, maxDay)
	local curTime = self._gameServerAgent:remoteTimeMillis()
	local oneDaySec = 86400000
	local leaveTime = endTime - curTime
	local dayNum = 0

	dayNum = self._rechargeAndVipSystem:hasMCRedPointByLastTime(lastTime) and math.ceil(leaveTime / oneDaySec) or math.floor(leaveTime / oneDaySec)
	dayNum = math.max(dayNum, 0)

	return dayNum
end
