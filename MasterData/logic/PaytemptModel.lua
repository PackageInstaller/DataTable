-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/paytempt/model/PaytemptModel.lua

module("logic.extensions.paytempt.model.PaytemptModel", package.seeall)

local PaytemptModel = class("PaytemptModel", BaseModel)

PaytemptModel.TYPE_SERVER = 0
PaytemptModel.TYPE_CLIENT = 1

function PaytemptModel:ctor()
	PaytemptModel.super.ctor(self)
end

function PaytemptModel:onInit()
	self:onReset()
end

function PaytemptModel:onReset()
	self.dataList = {}
end

function PaytemptModel:setData(infos)
	for k, v in ipairs(infos) do
		local tb = GameUtil.pbToTable(v)

		tb.type = PaytemptModel.TYPE_SERVER

		self:addData(tb)
	end
end

function PaytemptModel:addData(infoMsg)
	table.insert(self.dataList, infoMsg)
	ArraySort.sortOn(self.dataList, {
		"type",
		"endTimeMillis"
	}, {
		ArraySort.DESCENDING,
		ArraySort.NUMERIC
	})
	self:showOrCloseHud()
end

function PaytemptModel:showOrCloseHud()
	local now = ServerTime.now() * 1000

	self.curData = nil

	for i, v in ipairs(self.dataList) do
		if v.type == PaytemptModel.TYPE_CLIENT then
			if GameUtil.checkIsInTimePeriod(v.timeStart, v.timeEnd) then
				self.curData = v

				break
			end
		elseif v.endTimeMillis and now < checknumber(v.endTimeMillis) then
			self.curData = v

			break
		end
	end

	if self.curData ~= nil then
		MainUIController.instance:openBottomLeftView(ViewName.GifthudView, self.curData)
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_PAYTEMPT, true)
	else
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_PAYTEMPT, false)
		MainUIController.instance:closeBottomLeftView(ViewName.GifthudView)
	end
end

function PaytemptModel:delDataById(id, type)
	local idx
	local boo = false

	for i, v in ipairs(self.dataList) do
		if type == PaytemptModel.TYPE_CLIENT then
			if v.shopId == id then
				idx = i

				break
			end
		elseif v.id == id then
			idx = i

			break
		end
	end

	if idx then
		table.remove(self.dataList, idx)

		boo = true
	end

	self:showOrCloseHud()

	return boo
end

function PaytemptModel:getCurrShowList()
	local now = ServerTime.now() * 1000
	local list = {}

	for i, v in ipairs(self.dataList) do
		if v.type == PaytemptModel.TYPE_CLIENT then
			if GameUtil.checkIsInTimePeriod(v.timeStart, v.timeEnd) then
				table.insert(list, v)
			end
		elseif v.endTimeMillis and now < checknumber(v.endTimeMillis) then
			table.insert(list, v)
		end
	end

	return list
end

PaytemptModel.instance = PaytemptModel.New()

return PaytemptModel
