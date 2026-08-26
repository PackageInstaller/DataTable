-- chunkname: @modules/logic/help/view/HelpShowView.lua

module("modules.logic.help.view.HelpShowView", package.seeall)

local HelpShowView = class("HelpShowView", BaseView)

function HelpShowView:setHelpId(helpId)
	self._helpId = helpId
end

function HelpShowView:setDelayTime(time)
	self._time = time
end

function HelpShowView:setDelayTimeFromConst(constId)
	self._time = CommonConfig.instance:getConstNum(constId)
end

function HelpShowView:onOpenFinish()
	self:tryShowHelp()
end

function HelpShowView:tryShowHelp()
	if HelpController.instance:canShowFirstHelp(self._helpId) then
		self:_showHelp()
	end
end

function HelpShowView:_showHelp()
	if not self._helpId then
		return
	end

	UIBlockMgr.instance:startBlock("HelpShowView tryShowFirstHelp")
	TaskDispatcher.runDelay(self._tryShowFirstHelp, self, self._time or 0)
end

function HelpShowView:_tryShowFirstHelp()
	UIBlockMgr.instance:endBlock("HelpShowView tryShowFirstHelp")
	HelpController.instance:tryShowFirstHelp(self._helpId)
end

function HelpShowView:onClose()
	UIBlockMgr.instance:endBlock("HelpShowView tryShowFirstHelp")
	TaskDispatcher.cancelTask(self._tryShowFirstHelp, self)
end

return HelpShowView
