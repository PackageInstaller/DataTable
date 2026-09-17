local dropcache_manager = require("controller.dropcache_manager")
local component_manager = require("controller.component_manager")
local weapon_manager = require("controller.weapon_manager")
local item_manager = require("controller.item_manager")
local horcrux_manager = require("controller.horcrux_manager")
local lab_manager = require("controller.lab_manager")
local network = require("network.network")
local playermodel = require("model.playermodel")

require("view.Layer.SmeltLayer")

local item_data = require("data.item_data")
local var_0_10 = 705
local var_0_11 = 15
local var_0_13 = {
	"FightLayer/cacheplate1.png",
	"FightLayer/cacheplate2.png",
	"FightLayer/cacheplate3.png",
	"FightLayer/cacheplate4.png",
	"FightLayer/cacheplate5.png"
}
local var_0_14 = "FightLayer/cachelight.png"
local DropCacheSP = class("DropCacheSP", function()
	return cc.Sprite:create()
end)

function DropCacheSP:create(arg_2_1)
	local var_2_0 = DropCacheSP.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function DropCacheSP:init(arg_3_1)
	self.cache = arg_3_1
	self.moving = 0

	self:initBasicUI()
end

local function var_0_16(arg_4_0)
	if item_data[arg_4_0.itemid].bag_item_type == kITEM_COMPONENT then
		local var_4_0 = component_manager:create_component_icon(arg_4_0.itemid, 0, arg_4_0.component_attr)

		var_4_0:setScale(80 / var_4_0:getContentSize().width)

		return var_4_0
	elseif item_data[arg_4_0.itemid].bag_item_type == kITEM_WEAPON then
		local var_4_1 = cc.Sprite:create("weaponIcon/" .. item_data[arg_4_0.itemid].image_id .. ".png")

		var_4_1:setScale(120 / var_4_1:getContentSize().width)

		return var_4_1
	elseif item_data[arg_4_0.itemid].bag_item_type == kITEM_HORCRUX then
		local var_4_2 = cc.Sprite:create("role1/" .. horcrux_manager:getHorcruxRoleImage(arg_4_0.itemid) .. ".png")

		var_4_2:setScale(120 / var_4_2:getContentSize().width)

		return var_4_2
	else
		local var_4_3 = cc.Sprite:create("equipment/" .. item_data[arg_4_0.itemid].image_id .. ".png")

		var_4_3:setScale(80 / var_4_3:getContentSize().width)

		return var_4_3
	end
end

function DropCacheSP:initBasicUI()
	if config._DEBUG then
		self:setTexture(var_0_13[item_data[self.cache.itemid].equip_quality])
	else
		self:setSpriteFrame(var_0_13[item_data[self.cache.itemid].equip_quality])
	end

	self.item = var_0_16(self.cache)

	self.item:setAnchorPoint(cc.p(0.5, 0))
	self.item:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height))
	self.item:setCascadeOpacityEnabled(true)
	self.item:setOpacity(204)
	self:addChild(self.item)

	local var_5_0

	if config._DEBUG then
		var_5_0 = cc.Sprite:create(var_0_14) or cc.Sprite:createWithSpriteFrameName(var_0_14)
	end

	var_5_0:setAnchorPoint(cc.p(0.5, 0))
	var_5_0:setPosition(cc.p(self:getContentSize().width / 2, self:getContentSize().height))
	self:addChild(var_5_0)
end

function DropCacheSP:move(arg_6_1)
	if self.moving > 0 then
		return
	end

	if self:isHit() then
		return
	end

	self.moving = 2

	local function var_6_1()
		if self:isHit() or self.moving < 2 then
			self:stopAllActions()
			self:fixpos()

			self.moving = 0
		else
			self:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(-120, 0)), cc.CallFunc:create(var_6_1)))
		end
	end

	;(nil)()
end

function DropCacheSP:stop()
	if self.moving > 0 then
		self.moving = 1
	end
end

function DropCacheSP:fixpos()
	if self:getPositionX() ~= var_0_10 - 120 * (MAX_POP_SP - self.index) then
		self:setPosition(cc.p(var_0_10 - 120 * (MAX_POP_SP - self.index), var_0_11))
	end
end

function DropCacheSP:isHit()
	return self:getPositionX() <= var_0_10 - 120 * (MAX_POP_SP - self.index)
end

function DropCacheSP:harvest()
	self:stopAllActions()
	self:runAction(cc.Sequence:create(cc.Spawn:create(cc.MoveBy:create(0.2, cc.p(-120, 0)), cc.FadeOut:create(0.2)), cc.RemoveSelf:create()))

	return self.cache
end

function DropCacheSP:updateIndex(arg_12_1)
	self.index = arg_12_1
end

function DropCacheSP:getCurIndex()
	return self.index
end

local var_0_17 = {
	insert = function(self, ...)
		local var_14_0 = {
			...
		}

		if #var_14_0 == 1 then
			table.insert(self, var_14_0[1])
			self[#self]:updateIndex(#self)
		elseif #var_14_0 == 2 then
			table.insert(self, var_14_0[1], var_14_0[2])

			for iter_14_0 = var_14_0[1], #self do
				self[iter_14_0]:updateIndex(iter_14_0)
			end
		end
	end,
	remove = function(self, arg_15_1)
		for iter_15_0 = arg_15_1, #self do
			self[iter_15_0]:updateIndex(iter_15_0)
		end

		return (table.remove(self, arg_15_1))
	end
}
local var_0_18 = "FightLayer/cachebg.png"
local var_0_22 = 1
local var_0_23 = 2
local var_0_25 = 2

DropCacheLayer = class("DropCacheLayer", function()
	return cc.Layer:create()
end)

local var_0_27

function DropCacheLayer.create(arg_17_0)
	local var_17_0 = DropCacheLayer.new()

	var_17_0:init()

	return var_17_0
end

function DropCacheLayer.getInstance()
	return var_0_27
end

function DropCacheLayer:init()
	var_0_27 = self
	self.cacheSPs = setmetatable({}, {
		__index = var_0_17
	})
	self.harvesting = false
	self.full = false

	self:initBG()
	self:initAni()
	self:initSpList()
	self:registerScriptHandler(function(arg_20_0)
		if arg_20_0 == "exit" then
			if self.scheduler then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)
			end

			var_0_27 = nil
		end
	end)
end

function DropCacheLayer.pauseScheduler(arg_21_0)
	arg_21_0.pausing = true
end

function DropCacheLayer.resumeScheduler(arg_22_0)
	arg_22_0.pausing = false
end

function DropCacheLayer:initBG()
	local var_23_0

	if config._DEBUG then
		var_23_0 = cc.Sprite:create(var_0_18) or cc.Sprite:createWithSpriteFrameName(var_0_18)
	end

	var_23_0:setPosition(cc.p(var_23_0:getContentSize().width / 2, var_23_0:getContentSize().height / 2))
	self:addChild(var_23_0)
end

local var_0_28 = "bag"
local var_0_29 = cc.p(40, 5)
local var_0_30 = "open"
local var_0_31 = "begin1"
local var_0_32 = "begin"
local var_0_33 = "close"
local var_0_34 = "end"
local var_0_35 = "attack"

function DropCacheLayer:initAni()
	self.ani = sp.SkeletonAnimation:create(UI_SPINE_PATH .. var_0_28 .. ".json", UI_SPINE_PATH .. var_0_28 .. ".atlas", 1)

	self.ani:setPosition(var_0_29)

	self.ani.status = 2

	self:addChild(self.ani, var_0_22)
	self:registerAniEventListerner()

	local var_24_0 = ccui.Layout:create()

	var_24_0:setContentSize(cc.size(80, 100))
	var_24_0:setPosition(cc.p(0, 5))
	var_24_0:setTouchEnabled(true)
	var_24_0:setName("switchListener")
	self:addChild(var_24_0, var_0_22)
	var_24_0:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_25_0 = cc.EventCustom:new("switchShowLayer")

		var_25_0.layerName = "WareHouseLayer"

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_25_0)
	end)

	function self.ani:open()
		if self.status == 1 then
			return
		end

		self:setAnimation(0, var_0_30, false)

		self.status = 1
	end

	function self.ani:close()
		if self.status == 2 then
			return
		end

		self:setAnimation(0, var_0_33, false)

		if self.full then
			self:setAnimation(1, "full", true)
		else
			self:setAnimation(1, "idle", true)
		end

		self.status = 2
	end

	self.ani:setAnimation(1, "idle", true)
end

function DropCacheLayer:enableSwitchListener(arg_28_1)
	self:getChildByName("switchListener"):setTouchEnabled(arg_28_1)
end

function DropCacheLayer:registerAniEventListerner()
	self.ani:registerSpineEventHandler(function(arg_30_0)
		if arg_30_0.animation == var_0_31 then
			self:showHarvestItem()
		end
	end, SP_ANIMATION_COMPLETE)
end

function DropCacheLayer:initSpList()
	self.list = ccui.Layout:create()

	self.list:setContentSize(cc.size(600, 500))
	self.list:setClippingEnabled(true)
	self.list:setPosition(cc.p(60, 0))
	self:addChild(self.list, var_0_23)
	self:startAutoScheduler()
end

function DropCacheLayer.startAutoScheduler(arg_32_0)
	arg_32_0.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_33_0)
		if arg_32_0.pausing then
			return
		end

		if dropcache_manager:isLock() then
			return
		end

		if arg_32_0.harvesting then
			return
		end

		if dropcache_manager:canCachePop() then
			arg_32_0:popCacheSP()
		end

		if item_manager:is_full() then
			arg_32_0.ani:close()
			arg_32_0:switchBagFull(true)

			return
		else
			arg_32_0:switchBagFull(false)
		end

		if arg_32_0:isFirstSPValid() then
			arg_32_0:onHarvestCache()
		end

		if dropcache_manager:isDropCacheEmpty() then
			arg_32_0.ani:close()
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(arg_32_0.scheduler)

			arg_32_0.scheduler = nil
		end
	end, 0.2, false)
end

function DropCacheLayer:isFirstSPValid()
	if not self.cacheSPs[1] then
		return false
	end

	return self.cacheSPs[1]:getPositionX() <= var_0_10 - 120 * (MAX_POP_SP - 1)
end

function DropCacheLayer:popCacheSP()
	if not dropcache_manager:canCachePop() then
		return
	end

	local var_35_0 = DropCacheSP:create(dropcache_manager:dequenceCacheSP())

	var_35_0:setPosition(cc.p(var_0_10, var_0_11))
	self.list:addChild(var_35_0)
	self.cacheSPs:insert(var_35_0)
	var_35_0:move()
end

function DropCacheLayer.onHarvestCache(arg_36_0)
	arg_36_0.harvesting = true

	local function var_36_0(arg_37_0, arg_37_1)
		local var_37_0 = arg_36_0.cacheSPs:remove(1)

		if var_37_0 then
			var_37_0:harvest()
		end

		if item_data[item_manager:findItem(arg_37_0).itemid].equip_quality >= 4 or arg_37_1 then
			arg_36_0.harvestitem = {
				entityid = arg_37_0,
				autoset = arg_37_1
			}

			arg_36_0.ani:open()
			arg_36_0.ani:setAnimation(1, var_0_32, false)
			arg_36_0.ani:setAnimation(2, var_0_31, false)
			arg_36_0.ani:addAnimation(2, var_0_35, true)
		else
			arg_36_0.ani:open()
			arg_36_0.ani:setAnimation(1, var_0_32, false)
			arg_36_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
				arg_36_0.harvesting = false
			end)))
		end

		for iter_37_0 = 1, #arg_36_0.cacheSPs do
			arg_36_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
				if not arg_36_0.cacheSPs[iter_37_0] then
					return
				end

				arg_36_0.cacheSPs[iter_37_0]:move()
			end)))
		end
	end

	local function var_36_1()
		arg_36_0:switchBagFull(true)
	end

	dropcache_manager:harvestCache(function(arg_41_0, arg_41_1, arg_41_2)
		if arg_41_0 == 1 then
			var_36_0(arg_41_1, arg_41_2)
		elseif arg_41_0 == 2 then
			var_36_1()
		end
	end)
end

local var_0_36 = cc.size(80, 200)

function DropCacheLayer:showHarvestItem()
	if not self.harvestitem then
		return
	end

	local var_42_0 = self.harvestitem.entityid

	self.harvestitem = nil

	local var_42_2 = item_manager:findItem(var_42_0)

	if not var_42_2 then
		return
	end

	local var_42_3 = ccui.Layout:create()

	var_42_3:setContentSize(var_0_36)
	var_42_3:setTouchEnabled(true)
	var_42_3:setPosition(cc.p(90, 150))
	var_42_3:setName("itempanel")
	self:addChild(var_42_3, var_0_25)

	local var_42_4 = var_0_16(var_42_2)

	var_42_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_42_4:setCascadeOpacityEnabled(true)
	var_42_4:setOpacity(178.5)

	local var_42_5 = var_42_4:getScaleX()

	var_42_4:setScaleX(var_42_5 * 1.2)
	var_42_4:setScaleY(0.1)
	var_42_4:setPosition(cc.p(40, 55))
	var_42_3:addChild(var_42_4)

	local var_42_6 = cc.Label:createWithTTF(item_data[var_42_2.itemid].name, FONT_NAME, 18)

	var_42_6:setAnchorPoint(cc.p(0.5, 0.5))
	var_42_6:setPosition(cc.p(var_42_4:getContentSize().width / 2, -25))
	var_42_6:setScale(1 / var_42_5)
	var_42_4:addChild(var_42_6)
	var_42_4:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, var_42_5 * 1.2), cc.CallFunc:create(function()
		if LayerManager:getCurrentLayerName() ~= "FightLayer" then
			return
		end
	end)))
	var_42_3:runAction(cc.Sequence:create(cc.DelayTime:create(2), cc.CallFunc:create(function()
		self.harvesting = false

		self.ani:setAnimation(2, var_0_34, false)
	end), cc.RemoveSelf:create()))
	var_42_3:addTouchEventListener(function(arg_45_0, arg_45_1)
		if arg_45_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_45_0:stopAllActions()
		self:showItemInfo(var_42_0)
	end)
end

function DropCacheLayer.showItemInfo(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = item_manager:findItem(arg_46_1)

	if item_data[var_46_0.itemid].bag_item_type == kITEM_COMPONENT then
		local var_46_1 = component_manager:getStrengthenStatus(arg_46_1)

		local function var_46_2()
			if not var_46_1 then
				return
			end

			local var_49_0, var_49_1, var_49_2 = component_manager:getStrengthenInfo(arg_46_1)
			local var_49_3 = {
				[2] = {
					name = var_49_0[1].name,
					value = var_49_0[1].value,
					newvalue = var_49_0[2].value
				},
				{
					name = L_COMPONENT_TEXT.UpInfo.name[1],
					value = var_49_2,
					newvalue = var_49_2 + 1
				}
			}

			if var_49_2 % 2 == 1 then
				var_49_3[3] = {
					name = L_COMPONENT_TEXT.UpInfo.name[2],
					value = L_COMPONENT_TEXT.UpInfo.value,
					newvalue = "+8~" .. MAX_COMPONENT_SUB_ATTR
				}
			end

			local var_49_4 = {}

			for iter_49_0 = 1, #var_49_1 do
				var_49_4[iter_49_0] = {}

				if type(var_49_1[iter_49_0].dropid) == "string" then
					if var_49_1[iter_49_0].dropid == "gold" then
						var_49_4[iter_49_0].id = "gold"
						var_49_4[iter_49_0].neednum = var_49_1[iter_49_0].dropNum
						var_49_4[iter_49_0].ownnum = playermodel.gold
					elseif var_49_1[iter_49_0].dropid == "diamond" then
						var_49_4[iter_49_0].id = "diamond"
						var_49_4[iter_49_0].neednum = var_49_1[iter_49_0].dropNum
						var_49_4[iter_49_0].ownnum = playermodel.diamond
					end
				else
					var_49_4[iter_49_0].id = var_49_1[iter_49_0].dropid
					var_49_4[iter_49_0].neednum = var_49_1[iter_49_0].dropNum
					var_49_4[iter_49_0].ownnum = item_manager:getItemNumber(var_49_1[iter_49_0].dropid)
				end
			end

			return {
				labels = var_49_3,
				materials = var_49_4,
				gold_cost = var_49_1.gold
			}
		end

		local var_46_3 = component_manager:initComponentIntro(arg_46_1, true)

		local function var_46_4(arg_50_0, arg_50_1, arg_50_2)
			local var_50_0, var_50_1, var_50_2 = component_manager:getStrengthenInfo(arg_46_1, true)
			local var_50_3, var_50_4 = string.find(var_46_3[#var_46_3], L_COMPONENT_TEXT.Suit_Effect)

			var_46_3[#var_46_3] = string.sub(var_46_3[#var_46_3], var_50_3, var_50_4 + 9) .. "\n                " .. string.sub(var_46_3[#var_46_3], var_50_4 + 10)

			local var_50_5 = {
				L_COMPONENT_TEXT.prefix_str[1],
				L_COMPONENT_TEXT.prefix_str[2],
				[#var_46_3] = ""
			}

			component_manager:strengthenComponent(arg_46_1, function(arg_51_0)
				if arg_51_0 == 1 then
					if releasecallback then
						releasecallback()
					end

					local var_51_0 = {}

					table.insert(var_51_0, L_COMPONENT_TEXT.prefix_str[3] .. var_50_0[1].name .. "+" .. FIGHT_ATTR_FORMAT(var_50_0[1].key, var_50_0[2].value - var_50_0[1].value))

					local var_51_1 = {
						{},
						{}
					}

					for iter_51_0, iter_51_1 in pairs(component_manager:getStrengthenInfo(arg_46_1, true)[3]) do
						if iter_51_1.value - var_50_0[3][iter_51_0].value ~= 0 then
							var_51_1[1][2] = iter_51_0
							var_51_1[2][2] = " + " .. iter_51_1.value - var_50_0[3][iter_51_0].value

							table.insert(var_51_0, L_COMPONENT_TEXT.prefix_str[4] .. iter_51_0 .. "+" .. FIGHT_ATTR_FORMAT(iter_51_1.key, iter_51_1.value - var_50_0[3][iter_51_0].value))
						end
					end

					local var_51_3 = {}

					for iter_51_2 = 1, #var_46_3 do
						if iter_51_2 == 1 then
							var_51_3[iter_51_2] = var_50_5[iter_51_2] .. var_50_0[1].name .. "+" .. var_50_0[2].value
						else
							for iter_51_3, iter_51_4 in pairs(var_51_1[1]) do
								local var_51_4, var_51_5 = string.find(var_46_3[iter_51_2], iter_51_4)

								if var_51_4 and var_51_5 then
									if var_50_5[iter_51_2] and var_50_5[iter_51_2] ~= "" then
										var_51_3[iter_51_2] = var_50_5[iter_51_2] .. iter_51_4 .. var_51_1[2][iter_51_3]
									elseif not var_50_5[iter_51_2] then
										var_51_3[iter_51_2] = "                " .. iter_51_4 .. var_51_1[2][iter_51_3]
									end
								end
							end
						end
					end

					global_ShowBlockWords(var_51_0, RISE_WORDS_SUCCESS)

					if arg_50_2 then
						arg_50_2(nil, var_51_3)
					end
				elseif arg_51_0 == 2 then
					global_ShowBlockWords(L_COMPONENT_TEXT.Warning[2])
				elseif arg_51_0 == 3 then
					global_ShowBlockWords(L_COMPONENT_TEXT.Warning[3])
				elseif arg_51_0 == 4 then
					global_ShowBlockWords(L_COMPONENT_TEXT.Warning[4])
				end
			end)
		end

		local var_46_6 = false
		local var_46_7 = false
		local var_46_8 = L_COMPONENT_TEXT.Button_Label[1]
		local var_46_9 = string.sub(item_data[var_46_0.itemid].equip_condition, 6)

		if arg_46_2 then
			var_46_8 = L_COMPONENT_TEXT.Button_Label[2]
			var_46_7 = true
		end

		local var_46_10 = {
			{
				label = var_46_8,
				surecallback = function()
					local var_47_0 = tonumber((string.sub(item_data[var_46_0.itemid].equip_condition, 6)))

					if arg_46_2 then
						global_ShowBlockWords(L_DROPCACHE_LAYER_MSG[5])
					elseif var_47_0 and var_47_0 ~= "" and playermodel.soulContract[var_47_0] and playermodel.soulContract[var_47_0] ~= -1 then
						component_manager:setComponent(var_47_0, item_data[var_46_0.itemid].pos, arg_46_1, function(arg_48_0)
							if arg_48_0 == 1 then
								global_ShowBlockWords(L_DROPCACHE_LAYER_MSG[1])
							elseif arg_48_0 == 2 then
								global_ShowBlockWords(L_DROPCACHE_LAYER_MSG[2])
							elseif arg_48_0 == 0 then
								global_ShowBlockWords(L_DROPCACHE_LAYER_MSG[0])
							elseif arg_48_0 == 3 then
								global_ShowBlockWords(L_DROPCACHE_LAYER_MSG[3])
							elseif arg_48_0 == 4 then
								global_ShowBlockWords(L_DROPCACHE_LAYER_MSG[4])
							elseif arg_48_0 == 5 then
								global_ShowBlockWords(L_DROPCACHE_LAYER_MSG[5])
							end
						end)
					elseif playermodel.soulContract[var_47_0] or playermodel.soulContract[var_47_0] == -1 then
						global_ShowBlockWords(L_DROPCACHE_LAYER_MSG[6])
					else
						global_ShowBlockWords(L_DROPCACHE_LAYER_MSG[7])
					end
				end
			}
		}
		local var_46_11 = {}

		if var_46_1 then
			var_46_11.label = L_COMPONENT_TEXT.Button_Label[3] or L_COMPONENT_TEXT.Button_Label[4]
		end

		var_46_11.surecallback = var_46_4
		var_46_11.surecallback2 = var_46_2
		var_46_10[2] = var_46_11

		local var_46_12 = PopLayer:Item({
			hideGainButton = true,
			entityid = arg_46_1,
			itemid = var_46_0.itemid,
			nextgrade = var_46_2(),
			button = var_46_10,
			tag_exist = var_46_6,
			tag_equip = var_46_7,
			cancelcallback = function()
				arg_46_0.harvesting = false

				arg_46_0.ani:setAnimation(2, var_0_34, false)

				if arg_46_0:getChildByName("itempanel") then
					arg_46_0:removeChildByName("itempanel")
				end
			end
		})
	elseif item_data[var_46_0.itemid].bag_item_type == kITEM_WEAPON then
		local var_46_15 = {}
		local var_46_16 = {}

		var_46_16.label = L_DROPCACHE_LAYER_MSG.Weapon.Button_Label[1] or L_DROPCACHE_LAYER_MSG.Weapon.Button_Label[2]

		function var_46_16.surecallback()
			local var_56_0 = item_data[var_46_0.itemid].major

			weapon_manager:replaceRoleWeapon(item_data[var_46_0.itemid].major, arg_46_1, function(arg_57_0)
				if arg_57_0 == 1 then
					global_ShowBlockWords(L_DROPCACHE_LAYER_MSG.Weapon.Wear_Success)

					if playermodel:isSoulInFight(var_56_0) then
						FightManager.registerPlayerChangeWeapon()
					end
				else
					global_ShowBlockWords(L_DROPCACHE_LAYER_MSG.Weapon.Wear_Fail)
				end
			end)
		end

		var_46_15[1] = var_46_16

		local var_46_17 = PopLayer:Item({
			hideGainButton = true,
			entityid = arg_46_1,
			itemid = var_46_0.itemid,
			button = var_46_15,
			cancelcallback = function()
				arg_46_0.harvesting = false

				arg_46_0.ani:setAnimation(2, var_0_34, false)

				if arg_46_0:getChildByName("itempanel") then
					arg_46_0:removeChildByName("itempanel")
				end
			end
		})
	else
		local var_46_18 = PopLayer:Item({
			dropnum = 1,
			hideGainButton = true,
			entityid = arg_46_1,
			itemid = var_46_0.itemid,
			cancelcallback = function()
				arg_46_0.harvesting = false

				arg_46_0.ani:setAnimation(2, var_0_34, false)

				if arg_46_0:getChildByName("itempanel") then
					arg_46_0:removeChildByName("itempanel")
				end
			end
		})
	end
end

function DropCacheLayer:onGetNewCache()
	if not dropcache_manager:canCachePop() then
		return
	end

	if not self.scheduler then
		self:startAutoScheduler()
	end
end

function DropCacheLayer:switchBagFull(arg_63_1)
	if self.full == arg_63_1 then
		return
	end

	if arg_63_1 then
		self.ani:addAnimation(1, "full", true)

		self.full = arg_63_1
	else
		self.ani:setAnimation(1, "idle", true)

		self.full = arg_63_1
	end
end

function DropCacheLayer.refreshCacheSps(arg_64_0)
	return
end
