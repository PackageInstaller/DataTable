-- chunkname: @modules/logic/versionactivity2_4/pinball/controller/PinballHelper.lua

module("modules.logic.versionactivity2_4.pinball.controller.PinballHelper", package.seeall)

local PinballHelper = class("PinballHelper")

function PinballHelper.getHitInfo(colliderEntityA, colliderEntityB)
	if colliderEntityA.shape == PinballEnum.Shape.Rect and colliderEntityB.shape == PinballEnum.Shape.Rect then
		return PinballHelper.getHitRectRect(colliderEntityA, colliderEntityB)
	elseif colliderEntityA.shape == PinballEnum.Shape.Circle and colliderEntityB.shape == PinballEnum.Shape.Circle then
		return PinballHelper.getHitCirCleCirCle(colliderEntityA, colliderEntityB)
	elseif colliderEntityA.shape == PinballEnum.Shape.Rect and colliderEntityB.shape == PinballEnum.Shape.Circle then
		return PinballHelper.getHitRectCircle(colliderEntityA, colliderEntityB)
	elseif colliderEntityA.shape == PinballEnum.Shape.Circle and colliderEntityB.shape == PinballEnum.Shape.Rect then
		local hitX, hitY, hitDir = PinballHelper.getHitRectCircle(colliderEntityB, colliderEntityA)

		hitDir = hitDir and -hitDir

		return hitX, hitY, hitDir
	end
end

local tempData1 = {
	width = 0,
	height = 0,
	angle = 0,
	y = 0,
	x = 0
}
local tempData2 = {
	width = 0,
	height = 0,
	angle = 0,
	y = 0,
	x = 0
}
local tempV2 = Vector2()

function PinballHelper.getHitRectCircle(rect, circle)
	if rect.angle ~= 0 then
		tempV2.x = circle.x - rect.x
		tempV2.y = circle.y - rect.y
		tempData1.x = rect.x + tempV2.x * math.cos(-rect.angle * Mathf.Deg2Rad) - tempV2.y * math.sin(-rect.angle * Mathf.Deg2Rad)
		tempData1.y = rect.y + tempV2.x * math.sin(-rect.angle * Mathf.Deg2Rad) + tempV2.y * math.cos(-rect.angle * Mathf.Deg2Rad)
		tempData1.width = circle.width
		tempData1.height = circle.height
		tempData2.x = rect.x
		tempData2.y = rect.y
		tempData2.width = rect.width
		tempData2.height = rect.height

		local hitX, hitY = PinballHelper.getHitRectCircle(tempData2, tempData1)

		if hitX then
			tempV2.x = hitX - rect.x
			tempV2.y = hitY - rect.y
			hitX = rect.x + tempV2.x * math.cos(rect.angle * Mathf.Deg2Rad) - tempV2.y * math.sin(rect.angle * Mathf.Deg2Rad)
			hitY = rect.y + tempV2.x * math.sin(rect.angle * Mathf.Deg2Rad) + tempV2.y * math.cos(rect.angle * Mathf.Deg2Rad)
		end

		return hitX, hitY, PinballEnum.Dir.None
	end

	local disX = math.abs(rect.x - circle.x)
	local disY = math.abs(rect.y - circle.y)

	if disX > rect.width + circle.width or disY > rect.height + circle.width then
		return
	end

	local hitX, hitY, hitDir

	if disX <= rect.width and disY <= rect.height then
		if rect.width - disX > rect.height - disY then
			hitX = circle.x
			hitY = circle.y > rect.y and rect.y + rect.height or rect.y - rect.height
			hitDir = circle.y > rect.y and PinballEnum.Dir.Up or PinballEnum.Dir.Down
		else
			hitX = circle.x > rect.x and rect.x + rect.width or rect.x - rect.width
			hitY = circle.y
			hitDir = circle.x < rect.x and PinballEnum.Dir.Left or PinballEnum.Dir.Right
		end
	elseif disX <= rect.width then
		hitX = circle.x
		hitY = circle.y > rect.y and rect.y + rect.height or rect.y - rect.height
		hitDir = circle.y > rect.y and PinballEnum.Dir.Up or PinballEnum.Dir.Down
	elseif disY <= rect.height then
		hitX = circle.x > rect.x and rect.x + rect.width or rect.x - rect.width
		hitY = circle.y
		hitDir = circle.x < rect.x and PinballEnum.Dir.Left or PinballEnum.Dir.Right
	else
		for i = -1, 1, 2 do
			for j = -1, 1, 2 do
				local x = rect.x + i * rect.width
				local y = rect.y + j * rect.height

				if (x - circle.x)^2 + (y - circle.y)^2 <= circle.width^2 then
					hitX = x
					hitY = y
					hitDir = circle.y > rect.y and PinballEnum.Dir.Up or PinballEnum.Dir.Down

					break
				end
			end

			if hitX then
				break
			end
		end
	end

	return hitX, hitY, hitDir
end

function PinballHelper.rotateAngle(x, y, angle)
	local newX = x * math.cos(angle * Mathf.Deg2Rad) - y * math.sin(angle * Mathf.Deg2Rad)
	local newY = x * math.sin(angle * Mathf.Deg2Rad) + y * math.cos(angle * Mathf.Deg2Rad)

	return newX, newY
end

function PinballHelper.getHitRectRect(rect, rect2)
	local disX = math.abs(rect.x - rect2.x)
	local disY = math.abs(rect.y - rect2.y)

	if disX > rect.width + rect2.width or disY > rect.height + rect2.height then
		return
	end

	local hitX, hitY, hitDir

	hitY = (rect2.y + rect.y) / 2

	if disX <= rect.width then
		hitDir = rect2.y > rect.y and PinballEnum.Dir.Up or PinballEnum.Dir.Down
	elseif disY <= rect.height then
		hitDir = rect2.x < rect.x and PinballEnum.Dir.Left or PinballEnum.Dir.Right
	end

	return (rect2.x + rect.x) / 2, hitY, hitDir
end

function PinballHelper.getHitCirCleCirCle(circle, circle2)
	local disX = math.abs(circle.x - circle2.x)
	local disY = math.abs(circle.y - circle2.y)

	if disX > circle.width + circle2.width or disY > circle.height + circle2.height then
		return
	end

	local realDis = disX^2 + disY^2

	if realDis > (circle.width + circle2.width)^2 then
		return
	end

	local hitX, hitY, hitDir

	hitY = (circle2.y + circle.y) / 2
	hitDir = disY < disX and (circle2.x < circle.x and PinballEnum.Dir.Left or PinballEnum.Dir.Right) or circle2.y > circle.y and PinballEnum.Dir.Up or PinballEnum.Dir.Down

	return (circle2.x + circle.x) / 2, hitY, hitDir
end

function PinballHelper.isResType(unitType)
	return unitType == PinballEnum.UnitType.ResSmallFood or unitType == PinballEnum.UnitType.ResFood or unitType == PinballEnum.UnitType.ResMine or unitType == PinballEnum.UnitType.ResStone or unitType == PinballEnum.UnitType.ResWood
end

function PinballHelper.isMarblesType(unitType)
	return unitType == PinballEnum.UnitType.MarblesNormal or unitType == PinballEnum.UnitType.MarblesDivision or unitType == PinballEnum.UnitType.MarblesElasticity or unitType == PinballEnum.UnitType.MarblesExplosion or unitType == PinballEnum.UnitType.MarblesGlass
end

function PinballHelper.isOtherType(unitType)
	return not PinballHelper.isResType(unitType) and not PinballHelper.isMarblesType(unitType)
end

function PinballHelper.getLimitTimeStr()
	local actInfoMo = ActivityModel.instance:getActMO(VersionActivity2_4Enum.ActivityId.Pinball)

	if not actInfoMo then
		return ""
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		return TimeUtil.SecondToActivityTimeFormat(offsetSecond)
	end

	return ""
end

function PinballHelper.isBanOper()
	return GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.PinballBanOper)
end

return PinballHelper
