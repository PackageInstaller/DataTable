-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/limit/LegendLimitView.lua

module("logic.extensions.legend.view.limit.LegendLimitView", package.seeall)

local LegendLimitView = class("LegendLimitView", ViewComponent)

function LegendLimitView:ctor()
	self._availableCfgs = {}
end

function LegendLimitView:buildUI()
	self._tablecellGo = self:getGo("main/rightTop/tablecell")
	self._tableviewGo = self:getGo("main/rightTop/tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function LegendLimitView:bindEvents()
	return
end

function LegendLimitView:unbindEvents()
	return
end

function LegendLimitView:onEnter()
	self._elizabethConfigId = 13
	self._elizabethFirstLoginKey = "elizabethfirstlogin"

	GlobalDispatcher:addListener(GlobalNotify.AfterRedPointUpdate, self._elizabethFirstLogin, self)
	GlobalDispatcher:addListener(GlobalNotify.NianNianChallGetInfo, self._updateBtnChallengeState, self)
	NianNianChallController.instance:getInfo()
	self:_updateBtnChallengeState()
	settimer(10, self._updateBtnChallengeState, self)
	self:_elizabethFirstLogin()
end

function LegendLimitView:_elizabethFirstLogin()
	local hasRecord = GameUtil.getUserDayData(self._elizabethFirstLoginKey)

	if not hasRecord then
		self._scrollerList:refresh()
	end
end

function LegendLimitView:onExit()
	self._scrollerList:dispose()
	removetimer(self._updateBtnChallengeState, self)
	GlobalDispatcher:removeListener(GlobalNotify.AfterRedPointUpdate, self._elizabethFirstLogin, self)
	GlobalDispatcher:removeListener(GlobalNotify.NianNianChallGetInfo, self._updateBtnChallengeState, self)
end

function LegendLimitView:_updateBtnChallengeState()
	self._availableCfgs = self:_getAvailableCfgs()

	self._scrollerList:reloadData(self._availableCfgs)
end

function LegendLimitView:_getAvailableCfgs()
	local cfgs = TimeLimitedConfig.instance:getTimedChallengeCfgs()
	local resultCfgs = {}

	for i, v in ipairs(cfgs) do
		if v.isShowAd and v.challengeId == 23 then
			if not NianNianChallModel.instance:getAllClear() then
				table.insert(resultCfgs, v)
			end
		elseif v.isShowAd and self:_isInTime(v) then
			table.insert(resultCfgs, v)
		end
	end

	return resultCfgs
end

function LegendLimitView:_isFuncOpen(cfg)
	if not cfg then
		return false
	end

	return FuncOpenModel.instance:getFuncIsOpen(cfg.openFuncId)
end

function LegendLimitView:_timePostfixStr()
	return ""
end

function LegendLimitView:_isInTime(cfg)
	return TLChallengeController.instance:isInOpenTimeByCfg(cfg)
end

function LegendLimitView:_isLeftDay(cfg)
	local _, endTime = TLChallengeController.instance:getStartAndEndTime(cfg)

	if endTime ~= nil then
		local leftTime = endTime - ServerTime.now()
		local remainTime = math.ceil(leftTime / 3600)
		local remainType = 0

		if remainTime > 24 then
			remainType = 1
			remainTime = math.ceil(leftTime / 86400)
		end

		return remainType, remainTime
	end

	return -1, 0
end

function LegendLimitView:_isResidentDay(cfg)
	local _, endTime = TLChallengeController.instance:getStartAndEndTime(cfg)

	return endTime >= GameUtil.ForeverActTimeStringStamp
end

function LegendLimitView:_openPetView(viewName, id, viewType)
	local cfg = TimeLimitedConfig.instance:getCfgById(id)

	if not self:_isFuncOpen(cfg) then
		self:_showTip(cfg)

		return
	end

	if viewType == 1 then
		FuncOpenController.instance:openFuncByViewName(viewName)
	elseif viewType == 2 then
		FuncOpenController.instance:openFunc(cfg.openFuncId)
	elseif viewType == 3 and not string.nilorempty(cfg.jumpTo) then
		GotoMgr.gotoByString(cfg.jumpTo)
	else
		UIStateManager.instance:push(ViewName.LimitChallengeMgr, id)
	end
end

function LegendLimitView:_showTip(cfg)
	if cfg then
		local cfgOpen = FuncOpenConfig.instance:getFunctionOpenById(cfg.openFuncId)

		if cfgOpen then
			FloatWordMgr.instance:show(cfgOpen.description)
		end
	end
end

function LegendLimitView:_updateCell(view, cell, cfg, tag)
	local btnChallenge = Framework.ButtonAdapter.Get(cell.gameObject)
	local imageBigBg = Framework.ImageBigBG.Get(cell.gameObject)
	local lock = goutil.findChild(cell.gameObject, "lock")
	local timeGo = goutil.findChild(cell.gameObject, "time")
	local txtTime = goutil.findChild(cell.gameObject, "time/txtDesc"):GetComponent(goutil.Type_UIText)
	local dotCon = goutil.findChild(cell.gameObject, "dotCon")
	local redPoint = goutil.findChild(cell.gameObject, "dotCon/dot")
	local isUnlock = self:_isFuncOpen(cfg)
	local isResident = self:_isResidentDay(cfg)
	local redPointIds = TimeLimitedConfig.instance:getRedPointIds(cfg.challengeId)

	RedPointController.instance:unregRedPoint(redPoint)
	RedPointController.instance:regRedPoint(redPoint, unpack(redPointIds))
	goutil.setActive(lock, not isUnlock)
	goutil.setActive(dotCon, isUnlock)
	goutil.setActive(timeGo, isUnlock and not isResident)

	txtTime.text = ""

	if not isUnlock or isResident or cfg.openTimeType == 3 then
		-- block empty
	else
		local remainType, remainTime = self:_isLeftDay(cfg)

		txtTime.text = remainType == 1 and string.format("剩余：%d天", remainTime) or remainType == 0 and string.format("剩余：%d小时", remainTime) or ""
	end

	if cfg.challengeId == self._elizabethConfigId and isUnlock then
		local hasRecord = GameUtil.getUserDayData(self._elizabethFirstLoginKey)

		if not hasRecord then
			goutil.setActive(redPoint, true)
		end
	end

	local resPath = string.format("ui/bigbg/legend/huodong/%s.png", cfg.iconName)

	if imageBigBg.bgUrl ~= resPath then
		uGuiUtil.setSpriteToImage(cell.gameObject, uGuiUtil.SpriteType.BigBg, resPath)
	end

	btnChallenge:AddClickListener(function()
		printInfo("test >>>名字：reportBehavior = ", cfg.name, checknumber(cfg.reportBehavior))
		SurveyController.instance:reportBehavior(checknumber(cfg.reportBehavior))
		self:_openPetView(cfg.viewName, cfg.challengeId, cfg.viewType)

		if self._elizabethConfigId == cfg.challengeId then
			local isUnlock = self:_isFuncOpen(cfg)

			if isUnlock then
				GameUtil.saveUserDayData(self._elizabethFirstLoginKey, true)
			end
		end
	end)
end

function LegendLimitView:_clearCell(cell)
	local redPoint = goutil.findChild(cell.gameObject, "dotCon/dot")

	RedPointController.instance:unregRedPoint(redPoint)
	uGuiUtil.clearImage(cell.gameObject)
end

return LegendLimitView
