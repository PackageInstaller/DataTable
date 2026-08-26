-- chunkname: @modules/logic/versionactivity1_2/dreamtail/model/Activity119Model.lua

module("modules.logic.versionactivity1_2.dreamtail.model.Activity119Model", package.seeall)

local Activity119Model = class("Activity119Model", BaseModel)

function Activity119Model:reInit()
	self.data = nil
	self.userData = nil
end

function Activity119Model:getData()
	if not self.data then
		local playerId = tostring(PlayerModel.instance:getMyUserId())
		local str = PlayerPrefsHelper.getString(PlayerPrefsKey.DreamTailKey, "")

		if not string.nilorempty(str) then
			self.data = cjson.decode(str)
			self.userData = self.data[playerId]

			if self.data.activityId ~= VersionActivity1_2Enum.ActivityId.DreamTail then
				self.data = nil
				self.userData = nil
			end
		end

		if not self.data then
			self.data = {}
			self.data.activityId = VersionActivity1_2Enum.ActivityId.DreamTail
		end

		if not self.userData then
			self.userData = {}
			self.userData.unLockDay = 1
			self.userData.lastSelectDay = 1
			self.userData.lastSelectModel = 1
			self.userData.unLockHardList = {}
			self.data[playerId] = self.userData

			self:saveData()
		end
	end

	return self.userData
end

function Activity119Model:saveData()
	if not self.data then
		return
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.DreamTailKey, cjson.encode(self.data))
end

Activity119Model.instance = Activity119Model.New()

return Activity119Model
