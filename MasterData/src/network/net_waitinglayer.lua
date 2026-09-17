local var_0_0 = {}

var_0_0.obj = nil
var_0_0.reference = 0

local function var_0_1()
	local var_1_0 = ccui.Layout:create()

	var_1_0:setContentSize(cc.size(640, 1136))
	var_1_0:setTouchEnabled(true)
	var_1_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		local spinecache_manager = require("controller.spinecache_manager")
		local var_2_1 = "spine/ui/loading.json"
		local var_2_2 = "spine/ui/loading.atlas"
		local var_2_3 = spinecache_manager:addSpineData("spine/ui/loading.json", "spine/ui/loading.atlas")

		var_2_3:retain()

		local var_2_4 = sp.SkeletonAnimation:create(var_2_3:getData())

		var_2_4:setScale(0.6, 0.6)
		var_2_4:setPosition(cc.p(500, 50))
		var_1_0:addChild(var_2_4)
		var_2_4:setAnimation(0, "loading", true)
		var_2_4:registerScriptHandler(function(arg_3_0)
			if arg_3_0 == "exit" then
				var_2_3:release()
				spinecache_manager:removeSpineDataForKey(var_2_1, var_2_2)
			end
		end)
	end)))
	var_1_0:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			var_0_0.obj = nil
			var_0_0.reference = 0
		end
	end)

	return var_1_0
end

local function var_0_2()
	local var_5_0 = ccui.Layout:create()

	var_5_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_5_0:setBackGroundColor(cc.c3b(15, 15, 15))
	var_5_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_5_0:setTouchEnabled(true)
	var_5_0:setCascadeOpacityEnabled(false)
	var_5_0:setBackGroundColorOpacity(200)
	var_5_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("effect/loading_recharge/loading_recharge.ExportJson")

		local var_6_0 = ccs.Armature:create("loading_recharge")

		var_6_0:getAnimation():play("Animation1")
		var_6_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_6_0:setPosition(cc.p(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2))
		var_5_0:addChild(var_6_0)
	end)))
	var_5_0:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			var_0_0.obj = nil
			var_0_0.reference = 0
		end
	end)

	return var_5_0
end

function var_0_0.addWaitingLayer()
	if not var_0_0.obj then
		var_0_0.obj = var_0_1()

		cc.Director:getInstance():getRunningScene():addChild(var_0_0.obj, 10000)
	end

	var_0_0.reference = var_0_0.reference + 1
end

function var_0_0.addPurchaseWaitingLayer()
	if not var_0_0.obj then
		var_0_0.obj = var_0_2()

		cc.Director:getInstance():getRunningScene():addChild(var_0_0.obj, 10000)
	end

	var_0_0.reference = var_0_0.reference + 1
end

function var_0_0.removeWaitingLayer()
	var_0_0.reference = var_0_0.reference - 1

	if var_0_0.reference <= 0 then
		var_0_0.reference = 0

		if var_0_0.obj then
			var_0_0.obj:removeFromParent()

			var_0_0.obj = nil
		end
	end
end

function var_0_0.clearWaitingLayer()
	var_0_0.reference = 0

	if var_0_0.obj then
		var_0_0.obj:removeFromParent()

		var_0_0.obj = nil
	end
end

return var_0_0
