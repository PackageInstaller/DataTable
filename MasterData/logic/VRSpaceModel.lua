-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vrspace/model/VRSpaceModel.lua

module("logic.extensions.vrspace.model.VRSpaceModel", package.seeall)

local VRSpaceModel = class("VRSpaceModel", BaseModel)

function VRSpaceModel:onInit()
	self:onReset()
end

function VRSpaceModel:onReset()
	self._msgPool = {}
	self._rankInfoPool = {}
end

function VRSpaceModel:onGetInfo(msg)
	local pb = GameUtil.pbToTable(msg)

	self._msgPool[pb.activityId] = pb
end

function VRSpaceModel:onGetRankInfo(msg)
	local pb = GameUtil.pbToTable(msg)

	self._rankInfoPool[pb.activityId] = pb
end

function VRSpaceModel:getRankInfo(activityId)
	return self._rankInfoPool[activityId]
end

function VRSpaceModel:onGetSelectBuff(msg)
	local activityId = msg.activityId
	local buffLv = msg.buffLv
	local info = self._msgPool[activityId]

	if info then
		info.selectBuffLv = buffLv
	end
end

function VRSpaceModel:onGetResetInfo(msg)
	local pb = GameUtil.pbToTable(msg)
	local activityId = pb.activityId
	local mode = pb.mode
	local info = self._msgPool[activityId]

	if not info.modeInfos then
		for i, v in ipairs(info.modeInfos) do
			if v.mode == mode then
				v.passedRealityStageId = 0
				v.deadPetIds = {}

				break
			end
		end
	end
end

function VRSpaceModel:onGetVConfirm(msg, willResetReality)
	local confirm = msg.confirm

	if confirm then
		local pb = GameUtil.pbToTable(msg)
		local activityId = pb.activityId
		local mode = pb.mode
		local stageId = pb.stageId
		local virtualPetIds = pb.virtualPetIds
		local info = self._msgPool[activityId]

		if not info.modeInfos then
			for i, v in ipairs(info.modeInfos) do
				if v.mode == mode then
					v.virtualStageInfos = v.virtualStageInfos or {}

					local found = false

					for j, vs in ipairs(v.virtualStageInfos) do
						if vs.stageId == stageId then
							vs.virtualPetIds = virtualPetIds
							found = true

							break
						end
					end

					if not found then
						local tem = {}

						tem.stageId = stageId
						tem.virtualPetIds = virtualPetIds

						table.insert(v.virtualStageInfos, tem)
					end

					if willResetReality then
						v.passedRealityStageId = 0
						v.deadPetIds = {}
					end

					break
				end
			end
		end
	end
end

function VRSpaceModel:getInfo(activityId)
	return self._msgPool[activityId]
end

VRSpaceModel.instance = VRSpaceModel.New()

return VRSpaceModel
