-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmoyanclg/model/OrigindarkmoyanclgModel.lua

module("logic.extensions.origindarkmoyanclg.model.OrigindarkmoyanclgModel", package.seeall)

local OrigindarkmoyanclgModel = class("OrigindarkmoyanclgModel", BaseModel)

function OrigindarkmoyanclgModel:ctor()
	return
end

function OrigindarkmoyanclgModel:onInit()
	self:onReset()
end

function OrigindarkmoyanclgModel:onReset()
	self._msgInfos = {}
	self._fmtMo = OrigindarkmoyanclgFmtMo.New()
end

function OrigindarkmoyanclgModel:setInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._msgInfos[activityId] = info
	self._msgInfos[activityId].cells = self._msgInfos[activityId].cells or {}
end

function OrigindarkmoyanclgModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function OrigindarkmoyanclgModel:getStageId(activityId)
	local info = self:getInfo(activityId)

	return (info or nil) and (info.stageId or 0)
end

function OrigindarkmoyanclgModel:onResetStage(activityId, stageId)
	local info = self:getInfo(activityId)

	info.cells = {}
end

function OrigindarkmoyanclgModel:getCellData(activityId, stageId, x, y)
	local curStageId = self:getStageId(activityId)

	if curStageId ~= stageId then
		return
	end

	for i, v in ipairs(self._msgInfos[activityId].cells) do
		if v.x == x and v.y == y then
			return v
		end
	end
end

function OrigindarkmoyanclgModel:getCellDatas(activityId, stageId)
	local curStageId = self:getStageId(activityId)

	if curStageId ~= stageId then
		return {}
	end

	return self._msgInfos[activityId].cells
end

function OrigindarkmoyanclgModel:onSelectBuff(msg)
	local info = self:getInfo(msg.activityId)
	local hit = false

	for i, v in ipairs(info.cells) do
		if v.x == msg.x and v.y == msg.y then
			hit = true

			break
		end
	end

	if not hit then
		table.insert(info.cells, {
			x = msg.x,
			y = msg.y
		})
	end
end

function OrigindarkmoyanclgModel:getFmtMo()
	return self._fmtMo
end

function OrigindarkmoyanclgModel:onChallengeRes(msg)
	return
end

function OrigindarkmoyanclgModel:onConfirmLockPetRes(msg)
	if msg.saved then
		local info = self:getInfo(msg.activityId)
		local hit = false

		for i, v in ipairs(info.cells) do
			if v.x == msg.x and v.y == msg.y then
				v.lockRaceId = msg.raceId
				hit = true

				break
			end
		end

		if not hit then
			table.insert(info.cells, {
				x = msg.x,
				y = msg.y,
				lockRaceId = msg.raceId
			})
		end
	end

	if msg.stagePassed == true then
		local info = self:getInfo(msg.activityId)

		info.stageId = checknumber(info.stageId) + 1
		info.cells = {}
	end
end

OrigindarkmoyanclgModel.instance = OrigindarkmoyanclgModel.New()

return OrigindarkmoyanclgModel
