-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/view/formation/HalloweenMissionFmtView.lua

module("logic.extensions.halloweenguest.view.formation.HalloweenMissionFmtView", package.seeall)

local HalloweenMissionFmtView = class("HalloweenMissionFmtView", MissionFmtView)

function HalloweenMissionFmtView:_getMonsterCo()
	local params = self._viewPresentor:getFirstParam()

	if params then
		if params.isBoss then
			return HalloweenGuestConfig.instance:getBossTeamCfg(params.planId, params.baseId)
		else
			return HalloweenGuestConfig.instance:getMasterTeamCfg(params.baseId)
		end
	end

	return nil
end

function HalloweenMissionFmtView:_getCreepCos()
	local params = self._viewPresentor:getFirstParam()

	if params then
		if params.isBoss then
			local cfg = self:_getMonsterCo()

			if cfg and checknumber(cfg.creepsMasterId) > 0 then
				return HalloweenGuestConfig.instance:getBossCreepsCfg(cfg.creepsMasterId)
			end
		else
			return HalloweenGuestConfig.instance:getMasterCreepsCfg(params.baseId)
		end
	end

	return nil
end

function HalloweenMissionFmtView:_setRightSpeedAndPower(speed, power)
	HalloweenMissionFmtView.super._setRightSpeedAndPower(self, speed, power)

	self._speed.text = "？？？"
	self._powerTxt.text = "？？？"
end

function HalloweenMissionFmtView:_onClickPower()
	FloatWordMgr.instance:show("全员战斗力：？？？")
end

function HalloweenMissionFmtView:_onClickSpeed()
	FloatWordMgr.instance:show("全员速度：？？？")
end

function HalloweenMissionFmtView:_selectItem(index)
	if self._infoSeats[index] then
		local param = clone(self._infoSeats[index])

		param.hideZdl = true

		CommonTipsMgr.instance:showPetTips(param)
	end
end

function HalloweenMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

return HalloweenMissionFmtView
