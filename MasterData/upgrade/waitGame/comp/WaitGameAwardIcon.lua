local WaitGameAwardIcon = class("WaitGameAwardIcon", require("app.fairyGUI.upgrade.UI_WaitGameAwardIcon"))

function WaitGameAwardIcon:ctor()
	self._curProgress = 0
end

function WaitGameAwardIcon:updateAwardIcon(arg_2_1, arg_2_2)
	self._curProgress = arg_2_1.progress / 10

	self.m_numTxt:setText("x" .. arg_2_1.reward_size)
	self:upadteAwardState(arg_2_2)
end

function WaitGameAwardIcon:upadteAwardState(arg_3_1)
	if g.core.model.User.waitGameData:isGetNewDownLoadAward() then
		self.m_stateController:setSelectedIndex(2)
	elseif arg_3_1 >= self._curProgress then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

return WaitGameAwardIcon
