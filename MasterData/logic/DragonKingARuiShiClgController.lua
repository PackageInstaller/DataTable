-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishiclg/controller/DragonKingARuiShiClgController.lua

module("logic.extensions.dragonkingaruishiclg.controller.DragonKingARuiShiClgController", package.seeall)

local DragonKingARuiShiClgController = class("DragonKingARuiShiClgController", BaseController)

function DragonKingARuiShiClgController:ctor()
	return
end

function DragonKingARuiShiClgController:onInit()
	self:onReset()
end

function DragonKingARuiShiClgController:onReset()
	return
end

function DragonKingARuiShiClgController:handlePM_DragonKingARuiShiClgInfoRes(msg)
	DragonKingARuiShiClgModel.instance:setInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DragonKingARuiShiClgGetInfo)
end

function DragonKingARuiShiClgController:handlePM_NotifyDragonKingARuiShiClgChallengeEndRes(msg)
	DragonKingARuiShiClgModel.instance:setStageInfo(msg)

	local stageCfg = DragonKingARuiShiClgConfig.instance:getStageCfg(msg.activityId, msg.stageId)
	local params = {}

	params.needDamageNum = DragonKingARuiShiClgConfig.instance:getDamage(stageCfg.creepsMasterId)

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.DragonKingARuiShiClg, params)
	GlobalDispatcher:dispatch(GlobalNotify.DragonKingARuiShiClgChallengeEnd)
end

DragonKingARuiShiClgController.instance = DragonKingARuiShiClgController.New()

return DragonKingARuiShiClgController
