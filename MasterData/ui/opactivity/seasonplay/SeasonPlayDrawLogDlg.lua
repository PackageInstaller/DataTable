-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonPlay\\SeasonPlayDrawLogDlg.lua

local PoolDrawLogCell = require("UI/Pet/PoolDrawLogCell")
local SeasonPlayDrawLogCell = Class("SeasonPlayDrawLogCell", PoolDrawLogCell)
local ResDrawFakeRandRule = require("ClientData/ResDrawFakeRandRule")

function SeasonPlayDrawLogCell:ctor(...)
	return
end

function SeasonPlayDrawLogCell:setData(data)
	self.data = data

	self.textGrade:setText(utils.format("x%1s", self.data[3]))

	local time = self.data[2]

	self.textTime:setText(ClientUtils.getServerTimeData(time, "%Y-%m-%d %H:%M:%S"))

	local itemId = self.data[1]
	local item = BaseObject.GetObject(itemId)
	local iconData = BaseObject.getItemIconPath(itemId)

	if iconData then
		self.bgGashapon:setImage(iconData[1], iconData[2])
	end

	local showData = CurAvatar:getItemSeasonDrawShowData(itemId)
	local bgName = "BgEntry01"
	local bgPath = "Atlas/SeasonPlayCommon/SeasonPlayCommonAtlas05"

	bgName = showData and (showData.quality == Const.SEASON_DRAW_ITEM_QUALITY_YELLOW and "BgEntry02" or showData.quality == Const.SEASON_DRAW_ITEM_QUALITY_RED and "BgEntry03") or bgName

	self.imgSelf:setImage(bgPath, bgName)
	self.textName:setText(item.name)
end

local PetPoolDrawLogDlg = require("UI/Pet/PetPoolDrawLogDlg")
local PAGE_NUM = 5
local SeasonPlayDrawLogDlg = Class("SeasonPlayDrawLogDlg", PetPoolDrawLogDlg)
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")

function SeasonPlayDrawLogDlg:ctor(...)
	self.textNumTitle = UIControls.Label(self, "BgPanel/TextNumTitle")
end

function SeasonPlayDrawLogDlg:setData(actObject)
	self.actObj = actObject or self.actObj
	self.page = 1

	if self.actObj then
		DrawCardUtils.syncDrawRecord(nil, self.actObj.opId)

		local record = DrawCardUtils.getDrawRecord(nil, self.actObj.opId)

		self:setRecordData(record)
		self:setRemainText()
	end
end

function SeasonPlayDrawLogDlg:setRemainText(...)
	local actData = self.actObj.actData

	if actData then
		local detailData = actData:getResDetailData()

		if detailData and detailData.draw_pool_id then
			local count

			for i, v in pairs(ResDrawFakeRandRule) do
				if v.lib_id == detailData.draw_pool_id then
					count = v.super_limit_count

					break
				end
			end

			local superLimitCount = count or 120
			local nowCount = actData.superRoundCount or 0

			self.textNumTitle:setText(utils.format(Lang.get(111407), superLimitCount - nowCount))
		end
	end
end

function SeasonPlayDrawLogDlg:onCellChanged(sender, targetCell, newIdx)
	targetCell = targetCell or SeasonPlayDrawLogCell(sender, "System/SeasonPlayCommon/SeasonPlayDrawLogCell", newIdx)

	if not self.nowRecordList or #self.nowRecordList == 0 then
		return
	end

	if self.nowRecordList[newIdx] ~= nil then
		targetCell:setData(self.nowRecordList[newIdx])
	end

	self.cells[newIdx] = targetCell
end

return SeasonPlayDrawLogDlg
