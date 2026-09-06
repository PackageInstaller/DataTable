-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingYaoShiView.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingYaoShiView", package.seeall)

local LightKingYaoShiView = class("LightKingYaoShiView", LightKingBaseView)

function LightKingYaoShiView:ctor()
	LightKingYaoShiView.super.ctor(self)

	self._dontCheckLeftTimes = true
end

function LightKingYaoShiView:onExit()
	LightKingYaoShiView.super.onExit(self)
end

function LightKingYaoShiView:_updateCell(view, cell, data)
	LightKingYaoShiView.super._updateCell(self, view, cell, data)

	local creepCfgs = LightKingConfig.instance:getCreepsCfg(data.creepsMasterId)
	local dict = {}

	for _, v in ipairs(creepCfgs) do
		dict[v.posId] = v
	end

	local formation = goutil.findChild(cell.gameObject, "btn/formation")

	GameUtil.updateCellsWithLen(formation, 9, function(go, idx)
		local creepCfg = dict[idx]
		local pointPet = goutil.findChild(go, "con")

		if creepCfg then
			MaterialMgr.setCell(MatType.Pet, creepCfg.raceId, pointPet)
		else
			MaterialMgr.resetAll(pointPet)
		end
	end)
end

return LightKingYaoShiView
