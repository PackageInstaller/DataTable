-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/hud/BattleHudMovingMgr.lua

module("logicscene.scene.unit.component.battle.hud.BattleHudMovingMgr", package.seeall)

local defaultFadeParams = {
	delay = 1,
	ease = 13,
	fadeTime = 0.5
}
local defaultScaleParams = {
	delay = -1,
	scaleTo = 0,
	backTime = 0,
	scaleTime = 0,
	ease = 0,
	backEase = 0
}
local MovingStyleUp = {
	yParams = {
		delay = 0,
		yAcc = 2,
		ySpd = 60,
		yAccScaler = -1
	},
	scaleParams = {
		delay = 0,
		scaleTo = 1.3,
		backTime = 0.1,
		scaleTime = 0.1,
		ease = 27,
		backEase = 21
	}
}
local MovingStyleUpCritical = {
	yParams = {
		delay = 0,
		yAcc = 2,
		ySpd = 30,
		yAccScaler = -1
	},
	scaleParams = {
		delay = 0,
		scaleTo = 1.3,
		backTime = 0.1,
		scaleTime = 0.1,
		ease = 27,
		backEase = 21
	}
}
local MovingStyleBezier = {
	{
		delay = 0,
		moveTime = 1.4,
		id = 1,
		ease = 12,
		fadeParams = {
			delay = 0.8,
			ease = 13,
			fadeTime = 0.4
		}
	},
	{
		delay = 0,
		moveTime = 1.4,
		id = 2,
		ease = 12,
		fadeParams = {
			delay = 0.8,
			ease = 13,
			fadeTime = 0.4
		}
	},
	{
		delay = 0,
		moveTime = 1.4,
		id = 3,
		ease = 12,
		scaleParams = {
			delay = 0,
			scaleTo = 1.3,
			backTime = 0.1,
			scaleTime = 0.2,
			ease = 27,
			backEase = 21
		}
	},
	{
		delay = 0,
		moveTime = 1.4,
		id = 4,
		ease = 12,
		scaleParams = {
			delay = 0,
			scaleTo = 1.3,
			backTime = 0.1,
			scaleTime = 0.2,
			ease = 27,
			backEase = 21
		}
	}
}

function BattleHudMovingMgr.initBaziers()
	HUDText.AddBeziers(1, {
		0,
		0,
		0,
		-10,
		60,
		0,
		-20,
		-100,
		0,
		-30,
		-500,
		0
	})
	HUDText.AddBeziers(2, {
		0,
		0,
		0,
		10,
		60,
		0,
		20,
		-100,
		0,
		30,
		-500,
		0
	})
	HUDText.AddBeziers(3, {
		0,
		0,
		0,
		-10,
		60,
		0,
		-20,
		-50,
		0,
		-60,
		-400,
		0
	})
	HUDText.AddBeziers(4, {
		0,
		0,
		0,
		10,
		60,
		0,
		20,
		-50,
		0,
		60,
		-400,
		0
	})
	math.randomseed(os.time())
end

function BattleHudMovingMgr.setScale(hudText, scaleParams)
	scaleParams = scaleParams or defaultScaleParams

	local delay = scaleParams.delay
	local scaleTo = scaleParams.scaleTo
	local scaleTime = scaleParams.scaleTime
	local backTime = scaleParams.backTime
	local ease = scaleParams.ease
	local backEase = scaleParams.backEase

	HUDText.SetScaleParams(hudText, delay, scaleTo, scaleTime, backTime, ease, backEase)
end

function BattleHudMovingMgr.setFade(hudText, fadeParams)
	fadeParams = fadeParams or defaultFadeParams

	local delay = fadeParams.delay
	local fadeTime = fadeParams.fadeTime
	local ease = fadeParams.ease

	HUDText.SetFadeParams(hudText, delay, fadeTime, ease)
end

function BattleHudMovingMgr.movingUp(hudText, style)
	style = style or MovingStyleUp

	local yParams = style.yParams

	if yParams then
		local delay = yParams.delay
		local ySpd = yParams.ySpd
		local yAcc = yParams.yAcc
		local yAccScaler = yParams.yAccScaler

		HUDText.BeginMovingUp(hudText, delay, ySpd, yAcc, yAccScaler)
	end

	BattleHudMovingMgr.setFade(hudText, style.fadeParams)
	BattleHudMovingMgr.setScale(hudText, style.scaleParams)
end

function BattleHudMovingMgr.movingUpCritical(hudText)
	BattleHudMovingMgr.movingUp(hudText, MovingStyleUpCritical)
end

function BattleHudMovingMgr.movingDown(hudText, style)
	local yParams = style.yParams

	if yParams then
		local delay = yParams.delay
		local ySpd = yParams.ySpd
		local yAcc = yParams.yAcc
		local yAccScaler = yParams.yAccScaler

		HUDText.BeginMovingDown(hudText, delay, ySpd, yAcc, yAccScaler)
	end

	BattleHudMovingMgr.setFade(hudText, style.fadeParams)
	BattleHudMovingMgr.setScale(hudText, style.scaleParams)
end

function BattleHudMovingMgr.movingBezier(hudText, style)
	if not style.id then
		if not style.delay then
			local delay = 0

			if not style.ease then
				local ease = 12

				if not style.moveTime then
					local moveTime = 1.4

					HUDText.BeginMovingBezier(hudText, style.id, ease, delay, moveTime)
					BattleHudMovingMgr.setFade(hudText, style.fadeParams)
					BattleHudMovingMgr.setScale(hudText, style.scaleParams)
				end
			end
		end
	end
end

function BattleHudMovingMgr.randomBezier(hudText)
	local id = math.random(1, 3)

	BattleHudMovingMgr.movingBezier(hudText, MovingStyleBezier[id])
end

return BattleHudMovingMgr
