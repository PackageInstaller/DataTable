-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/task/model/AchievementModel.lua

AchievementModel = class("AchievementModel", TaskModel, _M)

local emojiFile = "asset/emotion/"

function AchievementModel:synchronizeModel(data)
	if data == nil then
		return
	end

	self._id = data.taskId

	if data.taskValues then
		self:updateTaskValue(data.taskValues)
	end

	if data.taskStatus then
		self:setStatus(tonumber(data.taskStatus))
	end

	self._config = ConfigReader:requireRecordById("AchievementTask", self._id)

	assert(self._config ~= nil, "error:cannot find config id =_" .. tostring(self._id) .. "_")

	self._sortId = self._config.OrderNum
end

function AchievementModel:getIsHide()
	return self:getConfig().Hide == 1
end

function AchievementModel:getAchievePoint()
	return self:getConfig().AchievePoint
end

function AchievementModel:getLeftPicture()
	return emojiFile .. self:getConfig().LeftPicture .. ".png"
end

function AchievementModel:getLeftWord()
	return Strings:get(self:getConfig().LeftWord)
end

function AchievementModel:getRightPicture()
	return emojiFile .. self:getConfig().RightPicture .. ".png"
end

function AchievementModel:getRightWord()
	return Strings:get(self:getConfig().RightWord)
end
