-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/consumelottery/view/ConsumelotterydrawView.lua

module("logic.extensions.consumelottery.view.ConsumelotterydrawView", package.seeall)

local ConsumelotterydrawView = class("ConsumelotterydrawView", ViewComponent)

function ConsumelotterydrawView:ctor()
	ConsumelotterydrawView.super.ctor(self)
end

function ConsumelotterydrawView:buildUI()
	ConsumelotterydrawView.super.buildUI(self)

	self._scrollcellGo = self:getGo("scrollcell")
	self._scrolldrawconGo = self:getGo("scrolldrawcon")
	self._scrollDrawCom = GameUtil.AddLuaOnce(self._scrolldrawconGo, ScrollDrawComponent)

	self._scrollDrawCom:initComponent(self._scrollcellGo, self._updateScrollDrawCell, self._drawFinishFunc, self._disposeCallFunc, self)

	self._blurBg = goutil.findChild(self.mainGO, "img"):GetComponent(typeof(StaticBluredScreen))
	self._blurBg.blur = 0.2
end

function ConsumelotterydrawView:bindEvents()
	ConsumelotterydrawView.super.bindEvents(self)
end

function ConsumelotterydrawView:unbindEvents()
	ConsumelotterydrawView.super.unbindEvents(self)
end

function ConsumelotterydrawView:destroyUI()
	ConsumelotterydrawView.super.destroyUI(self)
end

function ConsumelotterydrawView:onEnter()
	ConsumelotterydrawView.super.onEnter(self)

	self._dataList = {}

	local params = self:getOpenParam()

	self._actId = params[1]
	self._useFree = params[2]
	self._currRound = ConsumelotteryModel.instance:getCurrRound(self._actId)

	GlobalDispatcher:addListener(ConsumelotteryController.PM_ConsumeLotteryDrawRes, self._PM_ConsumeLotteryDrawRes, self)
	self:_initLotteryItems()
	ConsumelotteryModel.instance:setUseMonthDailyTicket(self._useFree)
	ConsumeLotteryAgent.instance:sendPM_ConsumeLotteryDrawReq(self._actId, self._currRound, checkbool(self._useFree))
	self:_setBlurBg()
end

function ConsumelotterydrawView:onEnterFinished()
	ConsumelotterydrawView.super.onEnterFinished(self)
end

function ConsumelotterydrawView:onExit()
	ConsumelotterydrawView.super.onExit(self)
	GlobalDispatcher:removeListener(ConsumelotteryController.PM_ConsumeLotteryDrawRes, self._PM_ConsumeLotteryDrawRes, self)
	self._scrollDrawCom:dispose()
	removetimer(self.close, self)
	self._blurBg:Release()
end

function ConsumelotterydrawView:onExitFinished()
	ConsumelotterydrawView.super.onExitFinished(self)
end

function ConsumelotterydrawView:_PM_ConsumeLotteryDrawRes(status, msg)
	if status == 0 then
		self:_startLottery(msg.prizeId)
	else
		TipsFacade.instance:openTipWindowNoX("提示", "出现意外情况，请重新抽奖", function()
			self:close()
		end)
	end
end

function ConsumelotterydrawView:_initLotteryItems()
	local cfg = ConsumelotteryConfig.instance:getActCfg(self._actId)
	local planCfgs = ConsumelotteryConfig.instance:getLotteryPrizeCfg(cfg.prizePlanId)
	local round = ConsumelotteryModel.instance:getCurrRound(self._actId)
	local list = planCfgs[round]

	if not list then
		return
	end

	self._dataList = {}

	for i, v in ipairs(list) do
		local isget = ConsumelotteryModel.instance:checkRewardIsGet(v.id)

		if not isget then
			table.insert(self._dataList, v)
		end
	end

	self._scrollDrawCom:updateItems(self._dataList, 190)
end

function ConsumelotterydrawView:_startLottery(prizeId)
	for i, v in ipairs(self._dataList) do
		if v.id == prizeId then
			self._scrollDrawCom:start(i)

			break
		end
	end
end

function ConsumelotterydrawView:_drawFinishFunc(index)
	ConsumelotteryController.instance:showLotteryResault()
	settimer(0.3, self.close, self, false)
end

function ConsumelotterydrawView:_updateScrollDrawCell(cell, data)
	local imgChange = cell.gameObject:GetComponent(ComponentType.UIImageSpriteChange)
	local icon = goutil.findChild(cell.gameObject, "icon")
	local cfg = MaterialMgr.getMatCfgByStr(data.prize)
	local arr = string.split(data.prize, ":")
	local matType, matId = checknumber(arr[1]), checknumber(arr[2])

	MaterialMgr.setIcon(icon, matType, matId)

	local quality = MaterialMgr.getGoodsQuality(matType, matId)

	imgChange:SetState(quality)
end

function ConsumelotterydrawView:_disposeCallFunc(cell)
	local icon = goutil.findChild(cell.gameObject, "icon")

	MaterialMgr.resetAll(icon)
end

function ConsumelotterydrawView:_setBlurBg()
	goutil.setActive(self.mainGO, false)
	self._blurBg:Release()
	self._blurBg:AddCaptureFinishListener(self._onCaptureScreenFinish, self)
	self._blurBg:Capture()
end

function ConsumelotterydrawView:_onCaptureScreenFinish()
	goutil.setActive(self.mainGO, true)
end

return ConsumelotterydrawView
