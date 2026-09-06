-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jackpot/view/JackpotchangepooltipView.lua

module("logic.extensions.jackpot.view.JackpotchangepooltipView", package.seeall)

local JackpotchangepooltipView = class("JackpotchangepooltipView", ViewComponent)

function JackpotchangepooltipView:ctor()
	JackpotchangepooltipView.super.ctor(self)
end

function JackpotchangepooltipView:buildUI()
	JackpotchangepooltipView.super.buildUI(self)

	self.icon = self:getGo("image")
	self._txtNum = self:getTxt("txtNum")
	self._txtReward = self:getTxt("text")
end

function JackpotchangepooltipView:bindEvents()
	JackpotchangepooltipView.super.bindEvents(self)
end

function JackpotchangepooltipView:unbindEvents()
	JackpotchangepooltipView.super.unbindEvents(self)
end

function JackpotchangepooltipView:destroyUI()
	JackpotchangepooltipView.super.destroyUI(self)
end

function JackpotchangepooltipView:onEnter()
	JackpotchangepooltipView.super.onEnter(self)

	local actId = JackpotModel.instance:getCurrActId()
	local info = JackpotModel.instance:getDrawInfo()
	local setOrderId = self:getFirstParam()

	if actId and info then
		local actCfg = JackpotConfig.instance:getActCfgById(actId)
		local maxOrder = JackpotConfig.instance:getMaxOrder(actId)

		if not setOrderId then
			::label_6_0::

			if not JackpotModel.instance:isNextOrderIdChange() then
				if not info.orderId then
					if info.orderId ~= 1 or not maxOrder then
						::label_6_1::

						local orderId = info.orderId - 1
						local cfgs = JackpotConfig.instance:getPoolCfg(actCfg.jackpot)
						local list = cfgs[orderId]
						local bigCfg = list[1]

						for k, v in pairs(list) do
							if v.type == 1 then
								bigCfg = v

								break
							end
						end

						local arr = string.split(bigCfg.reward, ":")

						MaterialMgr.setIcon(self.icon, checknumber(arr[1]), checknumber(arr[2]))

						self._txtReward.text = langPara("恭喜你成功抽到本轮大奖%s*%d", MaterialMgr.getMaterialsName(checknumber(arr[1]), checknumber(arr[2])), checknumber(arr[#arr]))
					end
				end
			end
		end
	end

	GameUtil.SetActive(self._txtNum, false)
end

function JackpotchangepooltipView:onEnterFinished()
	JackpotchangepooltipView.super.onEnterFinished(self)
end

function JackpotchangepooltipView:onExit()
	JackpotchangepooltipView.super.onExit(self)
	MaterialMgr.resetAll(self.icon)
end

function JackpotchangepooltipView:onExitFinished()
	JackpotchangepooltipView.super.onExitFinished(self)
end

return JackpotchangepooltipView
