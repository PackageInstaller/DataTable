-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/component/BuildingMapBuildArrow.lua

local arrowImage1 = "cj_bg_jt_2.png"
local arrowImage2 = "cj_bg_jt_2.png"
local arrowImage3 = "cj_bg_jt_1.png"
local arrowImage4 = "cj_bg_jt_1.png"

BuildingMapBuildArrow = BuildingMapBuildArrow or {}

function BuildingMapBuildArrow:create(w, h)
	local node = cc.Node:create()
	local pos = cc.p(0, 0)
	local spr1 = ccui.ImageView:create(arrowImage1, ccui.TextureResType.plistType)

	node:addChild(spr1)
	spr1:setScaleX(-1)
	spr1:setAnchorPoint(cc.p(0, 0))

	pos.x = 0 - (KBUILDING_Tiled_CELL_SIZE.width / 2 * h - KBUILDING_Tiled_CELL_SIZE.width / 4) + KBUILDING_Tiled_CELL_SIZE.width / 4 * (w - 1)
	pos.y = KBUILDING_Tiled_CELL_SIZE.height / 2 * h + KBUILDING_Tiled_CELL_SIZE.height / 4 + KBUILDING_Tiled_CELL_SIZE.height / 4 * (w - 1)

	spr1:setPosition(cc.p(pos.x, pos.y))

	local spr2 = ccui.ImageView:create(arrowImage2, ccui.TextureResType.plistType)

	node:addChild(spr2)
	spr2:setAnchorPoint(cc.p(0, 0))

	pos.x = KBUILDING_Tiled_CELL_SIZE.width / 2 * w - KBUILDING_Tiled_CELL_SIZE.width / 4 - KBUILDING_Tiled_CELL_SIZE.width / 4 * (h - 1)
	pos.y = KBUILDING_Tiled_CELL_SIZE.height / 2 * w + KBUILDING_Tiled_CELL_SIZE.height / 4 + KBUILDING_Tiled_CELL_SIZE.height / 4 * (h - 1)

	spr2:setPosition(cc.p(pos.x, pos.y))

	local spr3 = ccui.ImageView:create(arrowImage3, ccui.TextureResType.plistType)

	node:addChild(spr3)
	spr3:setScaleX(-1)
	spr3:setAnchorPoint(cc.p(0, 1))

	pos.x = 0 - KBUILDING_Tiled_CELL_SIZE.width / 4 * h
	pos.y = KBUILDING_Tiled_CELL_SIZE.height / 4 * h

	spr3:setPosition(cc.p(pos.x, pos.y))

	local spr4 = ccui.ImageView:create(arrowImage4, ccui.TextureResType.plistType)

	node:addChild(spr4)
	spr4:setAnchorPoint(cc.p(0, 1))

	pos.x = KBUILDING_Tiled_CELL_SIZE.width / 4 * w
	pos.y = KBUILDING_Tiled_CELL_SIZE.height / 4 * h

	spr4:setPosition(cc.p(pos.x, pos.y))

	return node
end

local underImage2_1 = "pic_gezi_green_smc.png"
local underImage2_2 = "pic_gezi_red_smc.png"

BuildingMapBuildUnder = BuildingMapBuildUnder or {}

function BuildingMapBuildUnder:createGreen(w, h, cellSize)
	local node = cc.Node:create()

	for y = 1, h do
		for x = 1, w do
			local spr = ccui.ImageView:create(underImage2_1, ccui.TextureResType.plistType)

			spr:setAnchorPoint(cc.p(0.5, 0))

			local xPos = (x - 1) * cellSize.width / 2 - (y - 1) * cellSize.width / 2
			local yPos = (y - 1) * cellSize.height / 2 + (x - 1) * cellSize.height / 2

			spr:setPosition(cc.p(xPos, yPos))
			node:addChild(spr)
		end
	end

	local time = 0.7
	local fo = cc.FadeOut:create(time)
	local fi = cc.FadeIn:create(time)

	node:runAction(cc.RepeatForever:create(cc.Sequence:create(fi, fo)))

	return node
end

function BuildingMapBuildUnder:createRed(w, h, cellSize)
	local node = cc.Node:create()

	for y = 1, h do
		for x = 1, w do
			local spr = ccui.ImageView:create(underImage2_2, ccui.TextureResType.plistType)

			spr:setAnchorPoint(cc.p(0.5, 0))

			local xPos = (x - 1) * cellSize.width / 2 - (y - 1) * cellSize.width / 2
			local yPos = (y - 1) * cellSize.height / 2 + (x - 1) * cellSize.height / 2

			spr:setPosition(cc.p(xPos, yPos))
			node:addChild(spr)
		end
	end

	local time = 0.7
	local fo = cc.FadeOut:create(time)
	local fi = cc.FadeIn:create(time)

	node:runAction(cc.RepeatForever:create(cc.Sequence:create(fi, fo)))

	return node
end
