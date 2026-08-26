-- chunkname: @modules/logic/pcInput/model/PCInputModel.lua

module("modules.logic.pcInput.model.PCInputModel", package.seeall)

local PCInputModel = class("PCInputModel", BaseModel)

PCInputModel.Activity = {
	CommonDialog = 11,
	storyDialog = 10,
	room = 4,
	thrityDoor = 2,
	MainActivity = 1,
	battle = 3
}
PCInputModel.Configfield = {
	description = 3,
	key = 4,
	hud = 1,
	editable = 5,
	id = 2
}
PCInputModel.blockField = {
	mlstring = 2,
	hud = 1,
	blockkey = 3
}
PCInputModel.ReplaceField = {
	replace = 2,
	keyName = 1
}
PCInputModel.MainActivityFun = {
	curActivity = 10,
	Room = 13,
	hide = 9,
	activityCenter = 11,
	Role = 14,
	Enter = 12,
	Summon = 15
}
PCInputModel.RoomActivityFun = {
	buy = 9,
	layout = 10,
	hide = 6,
	edit = 12,
	guting = 7,
	place = 11
}
PCInputModel.battleActivityFun = {
	skillUp = 21,
	skillDown = 22,
	showSkill = 20
}
PCInputModel.thrityDoorFun = {
	map = 5,
	Item1 = 7,
	bag = 6
}

function PCInputModel:onInit()
	return
end

function PCInputModel:checkKeyBinding()
	if self.keyBinding == nil then
		self.keyBinding = self:load()
	end
end

function PCInputModel:Save(keymap)
	self.keyBinding = keymap

	local keystr = cjson.encode(self.keyBinding)

	PlayerPrefsHelper.setString("keyBinding", keystr)
end

function PCInputModel:load()
	local keystr = PlayerPrefsHelper.getString("keyBinding")
	local config = self:loadFromConfig()

	if keystr and keystr ~= "null" then
		local saveData = cjson.decode(keystr)

		GameUtil.removeJsonNull(saveData)

		return self:CheckConfigUpdate(saveData, config)
	end

	return config
end

function PCInputModel:CheckConfigUpdate(old, new)
	local clone = LuaUtil.deepCopy(new)

	for _, v in pairs(clone) do
		for _, v1 in pairs(v) do
			if old[v1.hud] and old[v1.hud][v1.id] then
				local metatable = getmetatable(v1)

				metatable.__newindex = nil
				v1[PCInputModel.Configfield.key] = old[v1.hud][v1.id][PCInputModel.Configfield.key]
			end
		end
	end

	return clone
end

function PCInputModel:loadFromConfig()
	return pcInputConfig.instance:getKeyBinding()
end

function PCInputModel:findActivityById(activityId)
	for k, v in pairs(PCInputModel.Activity) do
		if v == activityId then
			return k
		end
	end

	return nil
end

function PCInputModel:getActivityKeys(activityid)
	self:checkKeyBinding()

	local activity = self:findActivityById(activityid)

	if not activity then
		logError("activity not exist in PCInputModel.Activity")

		return nil
	end

	local keyIds = self.keyBinding[PCInputModel.Activity[activity]]

	if not keyIds then
		logError("activity not exist in keyBinding")

		return nil
	end

	return keyIds
end

function PCInputModel:getkeyidBykeyName(activityid, keyName)
	local config = self:getkeyconfigBykeyName(activityid, keyName)

	if config then
		return config[2]
	end
end

function PCInputModel:getkeyconfigBykeyName(activityid, keyName)
	local keyids = self:getActivityKeys(activityid)

	for k, v in pairs(keyids) do
		if v[4] == keyName then
			return v
		end
	end
end

function PCInputModel:getThirdDoorMoveKey()
	local keyids = self:getActivityKeys(PCInputModel.Activity.thrityDoor)

	return keyids[1][PCInputModel.Configfield.key], keyids[2][PCInputModel.Configfield.key], keyids[3][PCInputModel.Configfield.key], keyids[4][PCInputModel.Configfield.key]
end

function PCInputModel:getKeyBinding()
	self:checkKeyBinding()

	return self.keyBinding
end

function PCInputModel:checkKeyCanModify(activityId, key)
	local keys = self.keyBinding[activityId]

	if keys then
		local keyBlock = pcInputConfig.instance:getKeyBlock()
		local blockkeys = keyBlock[activityId]

		if blockkeys then
			for _, v in pairs(blockkeys[PCInputModel.blockField.blockkey]) do
				if v == key then
					return false
				end
			end
		end
	end

	return true
end

function PCInputModel:getKey(activityId, keyid)
	self:checkKeyBinding()

	local keys = self.keyBinding[activityId]

	if keys then
		local key = keys[keyid]

		if key then
			return key[PCInputModel.Configfield.key]
		end
	end

	return ""
end

function PCInputModel:Reset(index)
	local config = self:loadFromConfig()

	self.keyBinding[index] = config[index]

	self:Save(self.keyBinding)
end

function PCInputModel:ReplaceKeyName(keyName)
	local keyNameReplace = pcInputConfig.instance:getKeyNameReplace()

	if keyNameReplace then
		for _, v in pairs(keyNameReplace) do
			if v[PCInputModel.ReplaceField.keyName] == keyName then
				return v[PCInputModel.ReplaceField.replace]
			end
		end
	end

	return keyName
end

PCInputModel.instance = PCInputModel.New()

return PCInputModel
