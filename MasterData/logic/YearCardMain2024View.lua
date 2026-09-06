-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/main/YearCardMain2024View.lua

module("logic.extensions.yearcard.view.yearcard2024.main.YearCardMain2024View", package.seeall)

local YearCardMain2024View = class("YearCardMain2024View", YearCardMain2022View)

function YearCardMain2024View:buildUI()
	YearCardMain2024View.super.buildUI(self)

	self._curActId = 8004
end

function YearCardMain2024View:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "yearcardRule2024")
end

function YearCardMain2024View:_reloadList()
	self._curDataList = {}

	for k, v in ipairs(self._viewCfg) do
		for k1, v1 in ipairs(v) do
			if v1.leaf == 1 then
				if string.nilorempty(v1.startTime) and string.nilorempty(v1.endTime) then
					table.insert(self._curDataList, v1)
				elseif not string.nilorempty(v1.startTime) and string.nilorempty(v1.endTime) then
					if ServerTime.now() > GameUtil.string2time(v1.startTime) then
						table.insert(self._curDataList, v1)
					end
				elseif string.nilorempty(v1.startTime) and not string.nilorempty(v1.endTime) then
					if ServerTime.now() < GameUtil.string2time(v1.endTime) then
						table.insert(self._curDataList, v1)
					end
				elseif ServerTime.now() > GameUtil.string2time(v1.startTime) and ServerTime.now() < GameUtil.string2time(v1.endTime) then
					table.insert(self._curDataList, v1)
				end
			elseif v1.root == self._selectRoot and self._isOpen then
				if string.nilorempty(v1.startTime) and string.nilorempty(v1.endTime) then
					table.insert(self._curDataList, v1)
				elseif not string.nilorempty(v1.startTime) and string.nilorempty(v1.endTime) then
					if ServerTime.now() > GameUtil.string2time(v1.startTime) then
						table.insert(self._curDataList, v1)
					end
				elseif string.nilorempty(v1.startTime) and not string.nilorempty(v1.endTime) then
					if ServerTime.now() < GameUtil.string2time(v1.endTime) then
						table.insert(self._curDataList, v1)
					end
				elseif ServerTime.now() > GameUtil.string2time(v1.startTime) and ServerTime.now() < GameUtil.string2time(v1.endTime) then
					table.insert(self._curDataList, v1)
				end
			end
		end
	end

	self._tableView:reloadData(self._curDataList)
end

return YearCardMain2024View
