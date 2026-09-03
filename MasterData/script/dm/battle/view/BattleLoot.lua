-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/BattleLoot.lua

local random = math.random
local sqrt = math.sqrt
local kHPixelsPerMeter = 180
local kGravity = 9.8 * kHPixelsPerMeter
local kCollectDelay = {
	0,
	0.4
}
local kCollectDuration = {
	0.5,
	0.0004
}
local __ItemActionConfigs__ = {
	gold = {
		minZ = 16,
		mc = "jinbi_ziyuandiaoluo",
		sound = "Se_Effect_Drop_Coin",
		scale = 0.6,
		evz = {
			2 * kHPixelsPerMeter,
			4 * kHPixelsPerMeter
		},
		bounce = {
			0.6,
			0.6
		}
	},
	crystal = {
		minZ = 16,
		mc = "yuanshi_ziyuandiaoluo",
		sound = "Se_Effect_Drop_Coin",
		scale = 0.6,
		evz = {
			2 * kHPixelsPerMeter,
			4 * kHPixelsPerMeter
		},
		bounce = {
			0.6,
			0.6
		}
	},
	exp = {
		minZ = 18,
		mc = "exp_ziyuandiaoluo",
		sound = "Se_Effect_Drop_Box",
		scale = 0.6,
		evz = {
			1 * kHPixelsPerMeter,
			2 * kHPixelsPerMeter
		},
		bounce = {}
	},
	box = {
		minZ = 18,
		mc = "box_jbdl",
		sound = "Se_Effect_Drop_Box",
		evz = {
			1 * kHPixelsPerMeter,
			2 * kHPixelsPerMeter
		},
		bounce = {}
	},
	IM_ExpUp1 = {
		minZ = 10,
		mc = "exp_jbdl",
		sound = "Se_Effect_Drop_Box",
		placeholders = {
			icon = "asset/items/item_200021.png"
		},
		evz = {
			1 * kHPixelsPerMeter,
			3 * kHPixelsPerMeter
		},
		bounce = {}
	},
	IM_ExpUp2 = {
		minZ = 10,
		mc = "exp_jbdl",
		sound = "Se_Effect_Drop_Box",
		placeholders = {
			icon = "asset/items/item_200022.png"
		},
		evz = {
			1 * kHPixelsPerMeter,
			3 * kHPixelsPerMeter
		},
		bounce = {}
	},
	IM_ExpUp3 = {
		minZ = 10,
		mc = "exp_jbdl",
		sound = "Se_Effect_Drop_Box",
		placeholders = {
			icon = "asset/items/item_200023.png"
		},
		evz = {
			1 * kHPixelsPerMeter,
			3 * kHPixelsPerMeter
		},
		bounce = {}
	},
	IM_ExpUp4 = {
		minZ = 10,
		mc = "exp_jbdl",
		sound = "Se_Effect_Drop_Box",
		placeholders = {
			icon = "asset/items/item_200024.png"
		},
		evz = {
			1 * kHPixelsPerMeter,
			3 * kHPixelsPerMeter
		},
		bounce = {}
	},
	IM_ExpUp5 = {
		minZ = 10,
		mc = "exp_jbdl",
		sound = "Se_Effect_Drop_Box",
		placeholders = {
			icon = "asset/items/item_200025.png"
		},
		evz = {
			1 * kHPixelsPerMeter,
			3 * kHPixelsPerMeter
		},
		bounce = {}
	},
	IM_ExpUp6 = {
		minZ = 10,
		mc = "exp_jbdl",
		sound = "Se_Effect_Drop_Box",
		placeholders = {
			icon = "asset/items/item_200026.png"
		},
		evz = {
			1 * kHPixelsPerMeter,
			3 * kHPixelsPerMeter
		},
		bounce = {}
	},
	IM_ExpUp7 = {
		minZ = 10,
		mc = "exp_jbdl",
		sound = "Se_Effect_Drop_Box",
		placeholders = {
			icon = {
				flipx = true,
				name = "asset/items/item_200026.png"
			}
		},
		evz = {
			1 * kHPixelsPerMeter,
			3 * kHPixelsPerMeter
		},
		bounce = {}
	},
	IM_ExpUp8 = {
		minZ = 10,
		mc = "exp_jbdl",
		sound = "Se_Effect_Drop_Box",
		placeholders = {
			icon = {
				flipx = true,
				name = "asset/items/item_200026.png"
			}
		},
		evz = {
			1 * kHPixelsPerMeter,
			3 * kHPixelsPerMeter
		},
		bounce = {}
	}
}

local function createMCReplacement(info)
	if type(info) == "string" then
		return cc.Sprite:create(info)
	else
		local sprite = cc.Sprite:create(info.name)

		if info.flipx then
			sprite:setScaleX(-1)
		end

		return sprite
	end
end

BattleLoot = class("BattleLoot")

BattleLoot:has("_itemType", {
	is = "r"
})

function BattleLoot:initialize(itemType)
	super.initialize(self)

	local actionConfig = __ItemActionConfigs__[itemType]

	assert(actionConfig ~= nil, string.format("Invalid item type: %s", tostring(itemType)))

	self._actionConfig = actionConfig
	self._itemType = itemType
	self._itemList = {}
end

function BattleLoot:splashItems(scheduler, groundLayer, dropPoint, amount, unit, landCallback)
	local actionConfig = self._actionConfig
	local itemList = self._itemList
	local total = amount or 1

	for i = 1, total do
		local index = #itemList + 1
		local anim = self:_createItemAnimation(actionConfig)
		local path = self:_calcSplashPath(actionConfig, dropPoint)
		local item = {
			unit = unit,
			index = index,
			anim = anim,
			path = path
		}

		itemList[index] = item

		groundLayer:getGroundLayer():addChild(anim)
		self:_splashAlongPath(scheduler, groundLayer, item, landCallback)
	end

	if self._itemType == "gold" then
		AudioEngine:getInstance():playEffect("Se_Effect_Drop_Coin")
	elseif self._itemType == "crystal" then
		AudioEngine:getInstance():playEffect("Se_Effect_Drop_Jingsha")
	else
		AudioEngine:getInstance():playEffect("Se_Effect_Drop_Bottle")
	end
end

function BattleLoot:beCollected(scheduler, destIconGeom, delayTime, callback)
	local itemList = self._itemList
	local delay1, delay2 = kCollectDelay[1], kCollectDelay[2]

	for idx, item in pairs(itemList) do
		local delay = random() * (delay2 - delay1) + delay1 + (delayTime or 0)

		scheduler:schedule(function(task, interval)
			if delay > 0 then
				delay = delay - interval
			end

			if delay <= 0 and item.splashTask == nil then
				task:stop()
				self:collectItem(scheduler, item, destIconGeom, callback)
			end
		end)
	end

	AudioEngine:getInstance():playEffect("Se_Effect_Pickup")
end

function BattleLoot:beCollectedOne(scheduler, item, destIconGeom, delayTime, callback)
	local delay1, delay2 = kCollectDelay[1], kCollectDelay[2]
	local delay = random() * (delay2 - delay1) + delay1 + (delayTime or 0)

	scheduler:schedule(function(task, interval)
		if delay > 0 then
			delay = delay - interval
		end

		if delay <= 0 and item.splashTask == nil then
			task:stop()
			self:collectItem(scheduler, item, destIconGeom, callback)
		end
	end)
	AudioEngine:getInstance():playEffect("Se_Effect_Pickup")
end

function BattleLoot:_createItemAnimation(actionConfig)
	local anim = cc.MovieClip:create(actionConfig.mc, "BattleMCGroup")
	local placeholders = actionConfig.placeholders

	if placeholders ~= nil then
		for name, info in pairs(placeholders) do
			local node = anim:getChildByName(name)

			if node ~= nil then
				local image = createMCReplacement(info)

				node:addChild(image)
			end
		end
	end

	if actionConfig.scale then
		anim:setScale(actionConfig.scale)
	end

	local node = cc.Node:create()

	anim:addTo(node)

	local function backToStart(cid, mc, label)
		local _, _, tag = label:find("^:(.*)%]$")
		local startLabel = "[" .. tag .. ":"

		mc:gotoAndPlay(startLabel)
	end

	function node:switchToSplashing()
		anim:clearCallbacks()
		anim:addCallbackByLabel(":splashing]", backToStart)
		anim:gotoAndPlay("[splashing:")
	end

	function node:landOnGround(endCallback)
		anim:clearCallbacks()
		anim:addCallbackByLabel(":land]", function(cid, mc, label)
			if endCallback ~= nil then
				mc:stop()
				endCallback(self)
			else
				backToStart(cid, mc, label)
			end
		end)
		anim:gotoAndPlay("[land:")

		if actionConfig.sound then
			-- block empty
		end
	end

	function node:switchToFlying()
		anim:clearCallbacks()
		anim:addCallbackByLabel(":flying]", backToStart)
		anim:gotoAndPlay("[flying:")
	end

	function node:rebound()
		if actionConfig.sound then
			-- block empty
		end
	end

	return node
end

function BattleLoot:_calcSplashPath(actionConfig, dropPoint)
	local evzRange = actionConfig.evz
	local evz = random() * (evzRange[2] - evzRange[1]) + evzRange[1]
	local finalX = random() * 1.6 - 0.4
	local finalY = 0
	local finalZ = actionConfig.minZ
	local path = {
		start = {
			x = dropPoint.x,
			y = dropPoint.y,
			z = dropPoint.z
		},
		final = {
			x = finalX,
			y = finalY,
			z = finalZ
		}
	}
	local fvz = sqrt(evz * evz + 2 * kGravity * (dropPoint.z - finalZ))
	local totalTime = 0
	local time = (evz + fvz) / kGravity

	path[1] = {
		time = time,
		vz = evz
	}
	totalTime = totalTime + time

	if actionConfig.bounce ~= nil then
		for i, factor in ipairs(actionConfig.bounce) do
			fvz = factor * fvz
			time = 2 * fvz / kGravity
			path[i + 1] = {
				time = 2 * fvz / kGravity,
				vz = fvz
			}
			totalTime = totalTime + time
		end
	end

	local vx = (finalX - dropPoint.x) / totalTime
	local vy = (finalY - dropPoint.y) / totalTime

	for _, seg in ipairs(path) do
		seg.vx, seg.vy = vx, vy
	end

	return path
end

function BattleLoot:_splashAlongPath(scheduler, groundLayer, item, landCallback)
	local anim, path = item.anim, item.path

	local function setPos(node, p)
		groundLayer:setRelPosition(node, {
			x = p.x,
			y = p.y
		}, 0, p.z)
	end

	local iseg = 1
	local seg = path[iseg]
	local start, final = path.start, path.final
	local p = {
		x = start.x,
		y = start.y,
		z = start.z
	}

	setPos(anim, p)
	anim:switchToSplashing()

	local vx, vy, vz = seg.vx, seg.vy, seg.vz
	local x0, y0, z0 = p.x, p.y, p.z, vz
	local time, totalTime = 0, seg.time

	item.splashTask = scheduler:schedule(function(task, interval)
		time = time + interval

		if time >= totalTime then
			time = totalTime
		end

		p.x = x0 + vx * time
		p.y = y0 + vy * time
		p.z = z0 + (vz - 0.5 * kGravity * time) * time

		setPos(anim, p)

		if time >= totalTime then
			iseg = iseg + 1
			seg = path[iseg]

			if seg ~= nil then
				vx, vy, vz = seg.vx, seg.vy, seg.vz
				x0, y0, z0 = p.x, p.y, p.z
				time, totalTime = 0, seg.time

				anim:rebound()
			else
				setPos(anim, final)
				task:stop()

				item.splashTask = nil

				anim:setLocalZOrder(100)

				local function animCall()
					if landCallback then
						landCallback(item)
					end
				end

				anim:landOnGround(animCall)
			end
		end
	end)
end

function BattleLoot:collectItem(scheduler, item, destIconGeom, callback)
	local anim = item.anim
	local parent = anim:getParent()
	local x0, y0 = anim:getPosition()
	local sx0, sy0 = anim:getScaleX(), anim:getScaleY()
	local trans = parent:getWorldToNodeAffineTransform()
	local x1 = destIconGeom.x * trans.a + destIconGeom.y * trans.c + trans.tx
	local y1 = destIconGeom.x * trans.b + destIconGeom.y * trans.d + trans.ty
	local sx1 = (destIconGeom.sx or 1) * trans.a
	local duration = kCollectDuration[1] + math.abs(x1 - x0) * kCollectDuration[2]
	local step = 1 / duration
	local p = 0

	self._itemList[item.index] = nil

	anim:switchToFlying()
	scheduler:schedule(function(task, interval)
		p = p + interval * step

		local ended = false

		if p >= 1 then
			p = 1

			task:stop()

			ended = true
		end

		local f = p * p * p

		anim:setPosition(x0 + (x1 - x0) * f, y0 + (y1 - y0) * f)
		anim:setScale(sx0 + (sx1 - sx0) * f)

		if ended and callback ~= nil then
			anim:removeFromParent()

			item.anim = nil

			callback(self, item)
		end
	end)
end
