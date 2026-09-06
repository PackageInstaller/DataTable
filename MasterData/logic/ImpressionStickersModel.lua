-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/impressionstickers/model/ImpressionStickersModel.lua

module("logic.extensions.impressionstickers.model.ImpressionStickersModel", package.seeall)

local ImpressionStickersModel = class("ImpressionStickersModel", BaseModel)

ImpressionStickersModel.Key_ShowIn = "ImpressionStickersModel.Key_ShowInV_1"

function ImpressionStickersModel:ctor()
	return
end

function ImpressionStickersModel:onInit()
	self:onReset()
end

function ImpressionStickersModel:onReset()
	self._stickers = {}
	self._stickersMap = {}
	self._showInMap = {}
end

function ImpressionStickersModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._stickers = data.stickers or {}

	for idx, sticker in ipairs(self._stickers) do
		self._stickersMap[sticker.id] = idx
	end
end

function ImpressionStickersModel:getStickers()
	return self._stickers
end

function ImpressionStickersModel:loadLocalData()
	self._showInMap = {}

	local list = GameUtil.getUserData(ImpressionStickersModel.Key_ShowIn)

	if list then
		for i, v in ipairs(list) do
			self._showInMap[v.defineId] = v.value
		end
	end
end

function ImpressionStickersModel:isShowIn(defineId)
	if self._showInMap[defineId] ~= false then
		return true
	end

	return false
end

function ImpressionStickersModel:saveShowInMap(map)
	table.merge(self._showInMap, map)

	local list = {}

	for k, v in pairs(self._showInMap) do
		table.insert(list, {
			defineId = k,
			value = v
		})
	end

	GameUtil.saveUserData(ImpressionStickersModel.Key_ShowIn, list)
end

function ImpressionStickersModel:copyShowInMap()
	local map = {}

	for k, v in pairs(self._showInMap) do
		map[k] = v
	end

	return map
end

function ImpressionStickersModel:onPinRes(msg)
	local data = GameUtil.pbToTable(msg)
	local stickers = checktable(data.stickers)

	for i, curSticker in ipairs(stickers) do
		local idx = self._stickersMap[curSticker.id]

		self._stickers[idx] = curSticker
	end
end

ImpressionStickersModel.instance = ImpressionStickersModel.New()

return ImpressionStickersModel
