-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleHomePagePanel.lua

local GridMemberDaily = require("UI/Circle/GridMemberDaily")
local strClassName = "CircleHomePagePanel"
local CircleHomePagePanel = Class(strClassName, UIControls.Panel)

function CircleHomePagePanel:ctor()
	self:initUI()
end

function CircleHomePagePanel:initUI()
	self.cells = {}
	self.scrollCircle = UIControls.ScrollViewLoopV(self, self.mPath, 0, self._initItem)
end

function CircleHomePagePanel:setCircle(circle)
	self.circle = circle
	self.logDataList = self.circle:getCircleLogList()

	self.scrollCircle:setTotalCount(#self.logDataList)
end

function CircleHomePagePanel:_initItem(sender, targetCell, newIdx)
	targetCell = targetCell or GridMemberDaily(sender, "System/Circle/GridMemberDaily", newIdx)

	if not self.logDataList or #self.logDataList == 0 then
		return
	end

	if self.logDataList[newIdx] ~= nil then
		targetCell:setDailyData(self.logDataList[newIdx])
	end

	self.cells[newIdx] = targetCell
end

return CircleHomePagePanel
