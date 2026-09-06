-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wheelfortune/view/WheelFortuneChangePoolTipView.lua

module("logic.extensions.wheelfortune.view.WheelFortuneChangePoolTipView", package.seeall)

local WheelFortuneChangePoolTipView = class("WheelFortuneChangePoolTipView", ViewComponent)

function WheelFortuneChangePoolTipView:ctor()
	WheelFortuneChangePoolTipView.super.ctor(self)
end

function WheelFortuneChangePoolTipView:buildUI()
	WheelFortuneChangePoolTipView.super.buildUI(self)

	self.icon = self:getGo("image")
	self._txtTip = self:getTxt("text")
	self._txtNum = self:getTxt("txtNum")
end

function WheelFortuneChangePoolTipView:bindEvents()
	WheelFortuneChangePoolTipView.super.bindEvents(self)
end

function WheelFortuneChangePoolTipView:unbindEvents()
	WheelFortuneChangePoolTipView.super.unbindEvents(self)
end

function WheelFortuneChangePoolTipView:destroyUI()
	WheelFortuneChangePoolTipView.super.destroyUI(self)
end

function WheelFortuneChangePoolTipView:onEnter()
	WheelFortuneChangePoolTipView.super.onEnter(self)

	local params = self:getOpenParam()
	local count = checknumber(params[1])
	local passOrderId = checknumber(params[2])
	local actId = WheelFortuneModel.instance:getCurrActId()
	local info = WheelFortuneModel.instance:getDrawInfo()

	if actId and info then
		local actCfg = WheelFortuneConfig.instance:getActCfgById(actId)
		local maxOrder = WheelFortuneConfig.instance:getMaxOrder(actId)
		local orderId = passOrderId

		if maxOrder < orderId then
			orderId = maxOrder
		end

		local cfgs = WheelFortuneConfig.instance:getPoolCfg(actCfg.prizePool)
		local list = cfgs[orderId]
		local bigCfg = list[1]

		for k, v in pairs(list) do
			if v.rank == 1 then
				bigCfg = v

				break
			end
		end

		local matType, matId, matNum = MaterialMgr.getMatParams(bigCfg.reward)
		local arr = string.split(bigCfg.reward, ":")

		MaterialMgr.setIcon(self.icon, matType, matId)

		self._txtNum.text = matNum
		self._txtTip.text = langPara("恭喜你花了%d次抽完所有奖励", checknumber(count))
	end

	GameUtil.SetActive(self._txtNum, true)
end

function WheelFortuneChangePoolTipView:onEnterFinished()
	WheelFortuneChangePoolTipView.super.onEnterFinished(self)
end

function WheelFortuneChangePoolTipView:onExit()
	WheelFortuneChangePoolTipView.super.onExit(self)
	MaterialMgr.resetAll(self.icon)
end

function WheelFortuneChangePoolTipView:onExitFinished()
	WheelFortuneChangePoolTipView.super.onExitFinished(self)
end

return WheelFortuneChangePoolTipView
