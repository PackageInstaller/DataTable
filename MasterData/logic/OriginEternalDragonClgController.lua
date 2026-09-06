-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origineternaldragonclg/controller/OriginEternalDragonClgController.lua

module("logic.extensions.origineternaldragonclg.controller.OriginEternalDragonClgController", package.seeall)

local OriginEternalDragonClgController = class("OriginEternalDragonClgController", BaseController)

OriginEternalDragonClgController.SeasonIdx = {
	summer = 2,
	winter = 4,
	autumn = 3,
	spring = 1
}
OriginEternalDragonClgController.SeasonText = {
	"春",
	"夏",
	"秋",
	"冬"
}
OriginEternalDragonClgController.SeasonGradientColor = {
	{
		"f3e1a8",
		"fdf9ed"
	},
	{
		"c6ffbc",
		"f0ffed"
	},
	{
		"f3e1a9",
		"fcf7ea"
	},
	{
		"92d3ff",
		"ffffff"
	}
}

function OriginEternalDragonClgController:ctor()
	return
end

function OriginEternalDragonClgController:onInit()
	self:onReset()
end

function OriginEternalDragonClgController:onReset()
	self._comboStampMap = {}
end

function OriginEternalDragonClgController:sendPM_OriginEternalDragonClgGetInfoReq(activityId)
	OriginEternalDragonClgAgent.instance:sendPM_OriginEternalDragonClgGetInfoReq(activityId)
end

function OriginEternalDragonClgController:handlePM_OriginEternalDragonClgGetInfoRes(msg)
	OriginEternalDragonClgModel.instance:handlePM_OriginEternalDragonClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginEternalDragonClgGetInfoRes)
end

function OriginEternalDragonClgController:sendPM_OriginEternalDragonClgUnlockComboReq(activityId, comboId)
	OriginEternalDragonClgAgent.instance:sendPM_OriginEternalDragonClgUnlockComboReq(activityId, comboId)
end

function OriginEternalDragonClgController:handlePM_OriginEternalDragonClgUnlockComboRes(msg)
	OriginEternalDragonClgModel.instance:handlePM_OriginEternalDragonClgUnlockComboRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginEternalDragonClgUnlockComboRes)
end

function OriginEternalDragonClgController:sendPM_OriginEternalDragonClgResetReq(activityId)
	OriginEternalDragonClgAgent.instance:sendPM_OriginEternalDragonClgResetReq(activityId)
end

function OriginEternalDragonClgController:handlePM_OriginEternalDragonClgResetRes(msg)
	OriginEternalDragonClgModel.instance:handlePM_OriginEternalDragonClgResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginEternalDragonClgResetRes)
end

function OriginEternalDragonClgController:sendPM_OriginEternalDragonClgFightReq(activityId, type, stageId, form)
	OriginEternalDragonClgAgent.instance:sendPM_OriginEternalDragonClgFightReq(activityId, type, stageId, form)
end

function OriginEternalDragonClgController:handlePM_OriginEternalDragonClgFightNotifyRes(msg)
	if msg.isWin then
		OriginEternalDragonClgModel.instance:handlePM_OriginEternalDragonClgFightNotifyRes(msg)
	end
end

function OriginEternalDragonClgController:enterBattleClg(activityId, type, stageId)
	local customFmtMo = OriginEternalDragonClgModel.instance:getFmtMo(activityId)

	customFmtMo:updateCfg(activityId, type, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function OriginEternalDragonClgController:getLeftStampNum(activityId, type)
	local typeInfoMap = OriginEternalDragonClgModel.instance:getTypeInfoMap(activityId)
	local typeInfo = typeInfoMap[type]

	if typeInfo then
		if not typeInfo.curStageId then
			local hasCount = 0
			local info = OriginEternalDragonClgModel.instance:getInfo(activityId)

			if info then
				if not info.effectComboIds then
					local effectComboIds = {}
					local hasUseCount = 0

					for _, comboId in ipairs(effectComboIds) do
						local comboCfg = OriginEternalDragonClgConfig.instance:getComboCfgById(activityId, comboId)

						if comboCfg then
							if not comboCfg.typeIds then
								local typeIds = {}

								for _, typeId in ipairs(typeIds) do
									if typeId == type then
										hasUseCount = hasUseCount + 1
									end
								end
							end
						end
					end

					return hasCount - hasUseCount
				end
			end
		end
	end
end

function OriginEternalDragonClgController:getHasUseStampNum(activityId, type)
	local typeInfoMap = OriginEternalDragonClgModel.instance:getTypeInfoMap(activityId)
	local info = OriginEternalDragonClgModel.instance:getInfo(activityId)

	if info then
		if not info.effectComboIds then
			local effectComboIds = {}
			local hasUseCount = 0

			for _, comboId in ipairs(effectComboIds) do
				local comboCfg = OriginEternalDragonClgConfig.instance:getComboCfgById(activityId, comboId)

				if comboCfg then
					if not comboCfg.typeIds then
						local typeIds = {}

						for _, typeId in ipairs(typeIds) do
							if typeId == type then
								hasUseCount = hasUseCount + 1
							end
						end
					end
				end
			end

			return hasUseCount
		end
	end
end

function OriginEternalDragonClgController:getCurBuffDesc(activityId)
	local typeInfoMap = OriginEternalDragonClgModel.instance:getTypeInfoMap(activityId)
	local descStrList = {}
	local desc = ""

	for type = 1, 4 do
		local stageCfgs = OriginEternalDragonClgConfig.instance:getStageCfgsByType(activityId, type)
		local leftNum = self:getLeftStampNum(activityId, type)

		if leftNum > 0 then
			local buffCfg = OriginEternalDragonClgConfig.instance:getBuffCfgsByCount(activityId, type, leftNum)

			if not buffCfg.desc then
				table.insert(descStrList, buffCfg.desc)
			end
		end
	end

	for i, descStr in ipairs(descStrList) do
		desc = i == #descStrList and desc .. descStr or desc .. descStr .. "，"
	end

	return desc
end

OriginEternalDragonClgController.instance = OriginEternalDragonClgController.New()

return OriginEternalDragonClgController
