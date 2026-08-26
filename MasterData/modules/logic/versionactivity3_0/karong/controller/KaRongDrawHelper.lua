-- chunkname: @modules/logic/versionactivity3_0/karong/controller/KaRongDrawHelper.lua

module("modules.logic.versionactivity3_0.karong.controller.KaRongDrawHelper", package.seeall)

local KaRongDrawHelper = _M
local LEFT = KaRongDrawEnum.dir.left
local RIGHT = KaRongDrawEnum.dir.right
local DOWN = KaRongDrawEnum.dir.down
local UP = KaRongDrawEnum.dir.up

function KaRongDrawHelper.formatPos(x1, y1, x2, y2)
	if x2 < x1 then
		x2 = x1
		x1 = x2
	end

	if y2 < y1 then
		y2 = y1
		y1 = y2
	end

	return x1, y1, x2, y2
end

function KaRongDrawHelper.getFromToDir(fromX, fromY, toX, toY)
	if fromX ~= toX then
		if fromY ~= toY then
			return nil
		end

		return (fromX < toX or nil) and (RIGHT or LEFT)
	else
		return (fromY < toY or nil) and (UP or DOWN)
	end
end

function KaRongDrawHelper.getPosKey(x, y)
	return string.format("%s_%s", x, y)
end

function KaRongDrawHelper.getLineKey(x1, y1, x2, y2)
	local x1_f, y1_f, x2_f, y2_f = KaRongDrawHelper.formatPos(x1, y1, x2, y2)

	return string.format("%s_%s_%s_%s", x1_f, y1_f, x2_f, y2_f)
end

return KaRongDrawHelper
