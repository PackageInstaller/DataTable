TvTRankSprite = class("TvTRankSprite", function()
	return cc.Node:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local arenatft_rank_data = require("data.arenatft.arenatft_rank_data")
local var_0_2 = "TvtLevet/"

function TvTRankSprite.create(arg_2_0, arg_2_1)
	local var_2_0 = TvTRankSprite.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function TvTRankSprite:init(arg_3_1)
	self:initRank(arg_3_1)
	self:draw()
end

function TvTRankSprite.initRank(arg_4_0, arg_4_1)
	arg_4_1 = arg_4_1 or 0

	local var_4_0 = 1

	while arenatft_rank_data[var_4_0] do
		if arg_4_1 < arenatft_rank_data[var_4_0].score then
			arg_4_0._rank = var_4_0 - 1

			return
		end

		var_4_0 = var_4_0 + 1
	end

	arg_4_0._rank = var_4_0 - 1
end

function TvTRankSprite:update(arg_5_1)
	self:removeAllChildren()
	self:initRank(arg_5_1)
	self:draw()
end

function TvTRankSprite:draw()
	local var_6_0 = string_split((arenatft_rank_data[self._rank] or nil) and (arenatft_rank_data[self._rank].image or "E"), ",")

	for iter_6_0 = 1, #var_6_0 do
		local var_6_1 = ccui.ImageView:create(var_0_2 .. var_6_0[iter_6_0] .. ".png", var_0_0)

		var_6_1:setAnchorPoint(cc.p(0, 0.5))
		var_6_1:setPosition(cc.p(0, 0))
		self:addChild(var_6_1)

		local var_6_2 = 0 + var_6_1:getContentSize().width + 5
	end
end

function TvTRankSprite:getCurRank()
	local var_7_0 = string_split((arenatft_rank_data[self._rank] or nil) and (arenatft_rank_data[self._rank].image or "E"), ",")

	return var_7_0[1] .. ((var_7_0[2] or nil) and string.sub(var_7_0[2], -1))
end

function TvTRankSprite:getNextRank()
	if not arenatft_rank_data[self._rank + 1] then
		return ""
	end

	local var_8_0 = string_split(arenatft_rank_data[self._rank + 1].image, ",")

	return var_8_0[1] .. ((var_8_0[2] or nil) and string.sub(var_8_0[2], -1))
end

function TvTRankSprite:getPlayerRankPercent(arg_9_1)
	local var_9_0 = arenatft_rank_data[self._rank] or {
		score = 0
	}
	local var_9_1 = 100

	if arenatft_rank_data[self._rank + 1] then
		var_9_1 = arenatft_rank_data[self._rank + 1].score - var_9_0.score
	end

	return (arg_9_1 - var_9_0.score) / var_9_1 * 100, arg_9_1 - var_9_0.score .. "/" .. var_9_1
end
