-- chunkname: @modules/logic/versionactivity3_3/marsha/controller/MarshaHelper.lua

module("modules.logic.versionactivity3_3.marsha.controller.MarshaHelper", package.seeall)

local MarshaHelper = class("MarshaHelper")

function MarshaHelper.getHitInfo(colliderEntityA, colliderEntityB)
	if colliderEntityA.shape == MarshaEnum.Shape.Rect and colliderEntityB.shape == MarshaEnum.Shape.Rect then
		return MarshaHelper.getHitRectRect(colliderEntityA, colliderEntityB)
	elseif colliderEntityA.shape == MarshaEnum.Shape.Circle and colliderEntityB.shape == MarshaEnum.Shape.Circle then
		return MarshaHelper.getHitCirCleCirCle(colliderEntityA, colliderEntityB)
	elseif colliderEntityA.shape == MarshaEnum.Shape.Rect and colliderEntityB.shape == MarshaEnum.Shape.Circle then
		return MarshaHelper.getHitRectCircle(colliderEntityA, colliderEntityB)
	elseif colliderEntityA.shape == MarshaEnum.Shape.Circle and colliderEntityB.shape == MarshaEnum.Shape.Rect then
		local hitX, hitY, hitDir = MarshaHelper.getHitRectCircle(colliderEntityB, colliderEntityA)

		hitDir = hitDir and -hitDir

		return hitX, hitY, hitDir
	end
end

function MarshaHelper.getHitRectCircle(rect, circle)
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
			hitDir = circle.y > rect.y and MarshaEnum.Dir.Up or MarshaEnum.Dir.Down
		else
			hitX = circle.x > rect.x and rect.x + rect.width or rect.x - rect.width
			hitY = circle.y
			hitDir = circle.x < rect.x and MarshaEnum.Dir.Left or MarshaEnum.Dir.Right
		end
	elseif disX <= rect.width then
		hitX = circle.x
		hitY = circle.y > rect.y and rect.y + rect.height or rect.y - rect.height
		hitDir = circle.y > rect.y and MarshaEnum.Dir.Up or MarshaEnum.Dir.Down
	elseif disY <= rect.height then
		hitX = circle.x > rect.x and rect.x + rect.width or rect.x - rect.width
		hitY = circle.y
		hitDir = circle.x < rect.x and MarshaEnum.Dir.Left or MarshaEnum.Dir.Right
	else
		for i = -1, 1, 2 do
			for j = -1, 1, 2 do
				local x = rect.x + i * rect.width
				local y = rect.y + j * rect.height

				if (x - circle.x)^2 + (y - circle.y)^2 <= circle.width^2 then
					hitX = x
					hitY = y
					hitDir = circle.y > rect.y and MarshaEnum.Dir.Up or MarshaEnum.Dir.Down

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

function MarshaHelper.getHitRectRect(rect, rect2)
	local disX = math.abs(rect.x - rect2.x)
	local disY = math.abs(rect.y - rect2.y)

	if disX > rect.width + rect2.width or disY > rect.height + rect2.height then
		return
	end

	local hitX, hitY, hitDir

	hitY = (rect2.y + rect.y) / 2

	if disX <= rect.width then
		hitDir = rect2.y > rect.y and MarshaEnum.Dir.Up or MarshaEnum.Dir.Down
	elseif disY <= rect.height then
		hitDir = rect2.x < rect.x and MarshaEnum.Dir.Left or MarshaEnum.Dir.Right
	end

	return (rect2.x + rect.x) / 2, hitY, hitDir
end

function MarshaHelper.getHitCirCleCirCle(circle, circle2)
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
	hitDir = disY < disX and (circle2.x < circle.x and MarshaEnum.Dir.Left or MarshaEnum.Dir.Right) or circle2.y > circle.y and MarshaEnum.Dir.Up or MarshaEnum.Dir.Down

	return (circle2.x + circle.x) / 2, hitY, hitDir
end

function MarshaHelper.fitBounds(entity, xDis, yDis)
	local anchorPos = entity:getAnchorPos()

	if anchorPos.x + xDis > entity.width and anchorPos.x + xDis < MarshaEnum.MapSize.x - entity.width then
		anchorPos.x = anchorPos.x + xDis
	end

	if anchorPos.y + yDis > entity.height and anchorPos.y + yDis < MarshaEnum.MapSize.y - entity.height then
		anchorPos.y = anchorPos.y + yDis
	end

	return anchorPos.x, anchorPos.y
end

function MarshaHelper.checkValueCondition(targetValue, value)
	if targetValue > 0 then
		if targetValue <= value then
			return true
		end
	elseif value <= math.abs(targetValue) then
		return true
	end

	return false
end

function MarshaHelper.SignedAngle(from, to)
	local angle = Vector2.Angle(from, to)

	if Mathf.Round(angle) ~= 180 then
		angle = angle * Mathf.Sign(from.x * to.y - from.y * to.x)
	end

	return angle
end

return MarshaHelper
