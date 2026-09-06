-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/battle/BattleEffectOrderCtrl.lua

module("logicscene.scene.component.battle.BattleEffectOrderCtrl", package.seeall)

local BattleEffectOrderCtrl = {}
local settings
local dynPos = Vector2.New(0, 0)

function BattleEffectOrderCtrl.reset()
	local pos1 = BattleConfig.instance:getFormationPos(1, 1)
	local pos2 = BattleConfig.instance:getFormationPos(1, 2)
	local pos3 = BattleConfig.instance:getFormationPos(1, 3)
	local startPos0 = Vector2.New(100, 100)
	local endPos0 = Vector2.New(pos1[2], pos1[3])
	local startPos1 = Vector2.New(pos1[2], pos1[3])
	local endPos1 = Vector2.New(pos2[2], pos2[3])
	local startPos2 = Vector2.New(pos2[2], pos2[3])
	local endPos2 = Vector2.New(pos3[2], pos3[3])
	local startPos3 = Vector2.New(pos3[2], pos3[3])
	local endPos3 = Vector2.New(-100, -100)
	local cfg0 = {
		order = 1000,
		startPos = startPos0,
		endPos = endPos0
	}
	local cfg1 = {
		order = 2500,
		startPos = startPos1,
		endPos = endPos1
	}
	local cfg2 = {
		order = 4000,
		startPos = startPos2,
		endPos = endPos2
	}
	local cfg3 = {
		order = 4500,
		startPos = startPos3,
		endPos = endPos3
	}

	settings = {
		cfg0,
		cfg1,
		cfg2,
		cfg3
	}
end

function BattleEffectOrderCtrl.getOrderByPosZ(y, z)
	if not settings then
		return
	end

	dynPos.x = y
	dynPos.y = z

	local cnt = #settings

	for i = 1, cnt do
		local cfg = settings[i]

		if BattleEffectOrderCtrl.isPointInsideSegment(dynPos, cfg.startPos, cfg.endPos) then
			return cfg.order
		end
	end
end

function BattleEffectOrderCtrl.getOrderByPosIndex(idx)
	if idx == 1 then
		return 2000
	elseif idx == 2 then
		return 3000
	elseif idx == 3 then
		return 4000
	end
end

function BattleEffectOrderCtrl.isPointInsideSegment(pt, startPos, endPos)
	local line0 = endPos - pt
	local line1 = startPos - pt

	if Vector2.Dot(line0, line1) < 0 then
		return false
	end

	local line2 = pt - endPos
	local line3 = startPos - endPos

	if Vector2.Dot(line2, line3) < 0 then
		return false
	end

	local line4 = pt - startPos
	local line5 = endPos - startPos

	if Vector2.Dot(line4, line5) < 0 then
		return false
	end

	return true
end

return BattleEffectOrderCtrl
