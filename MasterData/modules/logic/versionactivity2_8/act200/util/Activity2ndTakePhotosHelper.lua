-- chunkname: @modules/logic/versionactivity2_8/act200/util/Activity2ndTakePhotosHelper.lua

module("modules.logic.versionactivity2_8.act200.util.Activity2ndTakePhotosHelper", package.seeall)

local Activity2ndTakePhotosHelper = class("Activity2ndTakePhotosHelper")

function Activity2ndTakePhotosHelper.ClampPosition(photoRect, frameRect, targetPos)
	local photoWidth = photoRect.rect.width
	local photoHeight = photoRect.rect.height
	local halfW = frameRect.rect.width / 2
	local halfH = frameRect.rect.height / 2
	local minX = -photoWidth / 2 + halfW
	local maxX = photoWidth / 2 - halfW
	local minY = -photoHeight / 2 + halfH
	local maxY = photoHeight / 2 - halfH

	return {
		x = Mathf.Clamp(targetPos.x, minX, maxX),
		y = Mathf.Clamp(targetPos.y, minY, maxY)
	}
end

function Activity2ndTakePhotosHelper.checkPhotoAreaMoreGoal(frameRect, targetPos)
	local halfW = frameRect.rect.width / 2
	local halfH = frameRect.rect.height / 2
	local framePosX, framePosY = recthelper.getAnchor(frameRect)
	local frameLeft = framePosX - halfW
	local frameRight = framePosX + halfW
	local frameTop = framePosY + halfH
	local frameBottom = framePosY - halfH
	local targetLeft = targetPos.x - halfW
	local targetRight = targetPos.x + halfW
	local targetTop = targetPos.y + halfH
	local targetBottom = targetPos.y - halfH
	local overlapX = math.max(0, math.min(frameRight, targetRight) - math.max(frameLeft, targetLeft))
	local overlapY = math.max(0, math.min(frameTop, targetTop) - math.max(frameBottom, targetBottom))
	local overlap = overlapX * overlapY

	return overlap / (frameRect.rect.width * frameRect.rect.height) >= 0.7
end

return Activity2ndTakePhotosHelper
