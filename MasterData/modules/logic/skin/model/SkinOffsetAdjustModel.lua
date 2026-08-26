-- chunkname: @modules/logic/skin/model/SkinOffsetAdjustModel.lua

module("modules.logic.skin.model.SkinOffsetAdjustModel", package.seeall)

local SkinOffsetAdjustModel = class("SkinOffsetAdjustModel", BaseModel)

function SkinOffsetAdjustModel:onInit()
	self._offsetList = {}
	self._saveList = {}
end

function SkinOffsetAdjustModel:getOffset(skinCo, key, parentKey, constId)
	self._offsetList[skinCo.id] = self._offsetList[skinCo.id] or {}

	if self._offsetList[skinCo.id][key] then
		local t = self._offsetList[skinCo.id][key]

		return tonumber(t[1]), tonumber(t[2]), tonumber(t[3])
	end

	if self._saveList[skinCo.id] and self._saveList[skinCo.id][key] then
		local t = self._saveList[skinCo.id][key]

		return tonumber(t[1]), tonumber(t[2]), tonumber(t[3])
	end

	local offset = skinCo[key]

	if not offset then
		logError("skin offset key error:", key)
	end

	local offsetParam, isNull = SkinConfig.instance:getSkinOffset(offset)

	if isNull and not string.nilorempty(parentKey) then
		offset = skinCo[parentKey]

		if not skinCo[parentKey] then
			logError("skin offset key error:", parentKey)
		end

		offsetParam, isNull = SkinConfig.instance:getSkinOffset(offset)

		if constId ~= -1 then
			local diffOffset = SkinConfig.instance:getSkinOffset(CommonConfig.instance:getConstStr(constId))

			offsetParam[1] = offsetParam[1] + diffOffset[1]
			offsetParam[2] = offsetParam[2] + diffOffset[2]
			offsetParam[3] = offsetParam[3] + diffOffset[3]
		end
	end

	local x, y, s = offsetParam[1], offsetParam[2], offsetParam[3]

	self._offsetList[skinCo.id][key] = {
		x,
		y,
		s
	}

	return x, y, s, isNull
end

function SkinOffsetAdjustModel:resetTempOffset(skinCo, key)
	self._offsetList[skinCo.id] = self._offsetList[skinCo.id] or {}
	self._offsetList[skinCo.id][key] = nil
end

function SkinOffsetAdjustModel:setTempOffset(skinCo, key, x, y, s)
	self._offsetList[skinCo.id] = self._offsetList[skinCo.id] or {}
	self._offsetList[skinCo.id][key] = {
		x,
		y,
		s
	}
end

function SkinOffsetAdjustModel:setOffset(skinCo, key, x, y, s)
	x = tonumber(x) == 0 and 0 or tonumber(x)
	y = tonumber(y) == 0 and 0 or tonumber(y)
	s = tonumber(s) == 0 and 0 or tonumber(s)
	self._offsetList[skinCo.id] = self._offsetList[skinCo.id] or {}
	self._offsetList[skinCo.id][key] = {
		x,
		y,
		s
	}
	self._saveList[skinCo.id] = self._saveList[skinCo.id] or {}
	self._saveList[skinCo.id][key] = {
		x,
		y,
		s
	}

	self:saveConfig()
end

function SkinOffsetAdjustModel:saveCameraSize(skinCo, size)
	self._saveList[skinCo.id] = self._saveList[skinCo.id] or {}
	self._saveList[skinCo.id].fullScreenCameraSize = size
end

function SkinOffsetAdjustModel:getCameraSize(skinId)
	return self._saveList[skinId] and self._saveList[skinId].fullScreenCameraSize
end

function SkinOffsetAdjustModel:getTrigger(skinCo, key)
	self._offsetList[skinCo.id] = self._offsetList[skinCo.id] or {}

	if self._offsetList[skinCo.id][key] then
		return self._offsetList[skinCo.id][key]
	end

	local result = {}
	local triggerAreaStr = skinCo[key]
	local triggerAreaList = string.split(triggerAreaStr, "_")

	for i, v in ipairs(triggerAreaList) do
		local paramList = string.split(v, "|")

		if #paramList == 2 then
			local startPos = string.split(paramList[1], "#")
			local endPos = string.split(paramList[2], "#")
			local startX = tonumber(startPos[1])
			local startY = tonumber(startPos[2])
			local endX = tonumber(endPos[1])
			local endY = tonumber(endPos[2])

			table.insert(result, {
				startX,
				startY,
				endX,
				endY
			})
		end
	end

	return result
end

function SkinOffsetAdjustModel:setTrigger(skinCo, key, list)
	self._offsetList[skinCo.id] = self._offsetList[skinCo.id] or {}
	self._offsetList[skinCo.id][key] = list
	self._saveList[skinCo.id] = self._saveList[skinCo.id] or {}
	self._saveList[skinCo.id][key] = list

	self:saveConfig()
end

function SkinOffsetAdjustModel:saveConfig()
	local tempList = {}

	for k, v in pairs(self._saveList) do
		table.insert(tempList, {
			k,
			v
		})
	end

	local jsonStr = cjson.encode(tempList)
	local fullPath = string.format("%s/../skinOffsetAdjust.json", UnityEngine.Application.dataPath)

	SLFramework.FileHelper.WriteTextToPath(fullPath, jsonStr)
	GameFacade.showToast(ToastEnum.SkinOffsetAdjustSaveConfig)
end

SkinOffsetAdjustModel.instance = SkinOffsetAdjustModel.New()

return SkinOffsetAdjustModel
