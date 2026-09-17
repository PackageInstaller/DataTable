local stack = class("stack")

function stack:ctor()
	self._stackTable = {}
	self._stackInitParam = {}
	self._activeLayer = nil
	self._activeLayerInitParam = nil
end

function stack:push(arg_2_1, arg_2_2)
	local var_2_0 = self:getSize()

	self._stackTable[var_2_0 + 1] = self._activeLayer
	self._stackInitParam[var_2_0 + 1] = self._activeLayerInitParam
	self._activeLayer = arg_2_1
	self._activeLayerInitParam = arg_2_2 or {}
end

function stack:pop()
	local var_3_0 = self:getSize()

	if self:isEmpty() then
		self._activeLayer = nil
		self._activeLayerInitParam = nil

		return
	end

	self._activeLayer = table.remove(self._stackTable, var_3_0)
	self._activeLayerInitParam = table.remove(self._stackInitParam, var_3_0)

	return self._activeLayer, self._activeLayerInitParam
end

function stack:getSize()
	return #self._stackTable
end

function stack:isEmpty()
	return self:getSize() == 0
end

function stack:clear()
	self._stackTable = nil
	self._stackTable = {}
	self._activeLayer = nil
	self._stackInitParam = {}
	self._activeLayerInitParam = nil
end

function stack:getActivityLayer()
	return self._activeLayer
end

function stack:setActivityLayer(arg_8_1)
	self._activeLayer = arg_8_1
end

function stack:getTopLayer()
	return self._stackTable[self:getSize()]
end

function stack:getTopLayerInitParam()
	return self._stackInitParam[#self._stackInitParam]
end

local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = "MainLayer"

var_0_1.UILayerStack = stack.new()
var_0_1.popLayerStack = stack.new()

function var_0_1:initWithScene(arg_11_1)
	local var_11_0 = cc.EventListenerKeyboard:create()

	var_11_0:registerScriptHandler(function(arg_12_0, arg_12_1)
		print("on key code :", arg_12_0)

		if arg_12_0 == cc.KeyCode.KEY_F2 then
			if config.packagechannel ~= "palmpi" then
				return
			end

			LayerManager:pushInLayer("PopGMLayer")
		elseif arg_12_0 == cc.KeyCode.KEY_F12 then
			self:updateCurFile()
		elseif arg_12_0 == cc.KeyCode.KEY_F6 then
			package.loaded.localReload = nil

			require("localReload"):reset()
		elseif arg_12_0 == cc.KeyCode.KEY_F7 then
			global_basic_scene:removeChildByName("ToolLayer")

			local var_12_0 = require("view.Layer.ToolLayer"):create()

			var_12_0:setName("ToolLayer")
			global_basic_scene:addChild(var_12_0, 9999)
		elseif arg_12_0 == cc.KeyCode.KEY_VOLUME_UP then
			global_update_music_volume(1)
		elseif arg_12_0 == cc.KeyCode.KEY_VOLUME_DOWN then
			global_update_music_volume(-1)
		end

		if self._keyCodeEventlock > 0 then
			return
		end

		if arg_12_0 ~= cc.KeyCode.KEY_BACKSPACE and arg_12_0 ~= cc.KeyCode.KEY_BACK then
			return
		end

		if arg_11_1:getChildByName("BACK_LAYER") then
			return
		end

		if self._talklayer then
			self:skipTalkLayer()

			return
		end

		self:onKeyReleasedCallFunc(arg_11_1)
	end, cc.Handler.EVENT_KEYBOARD_RELEASED)
	arg_11_1:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_11_0, arg_11_1)
	self.UILayerStack:push(var_0_3)
	self:initLock()

	return var_0_1
end

function var_0_1:onKeyReleasedCallFunc(arg_13_1)
	if self:isFightNeedLock() then
		return
	end

	if self:isLock() then
		return
	end

	if not require("controller.level_manager"):isPlayerPassLevel(UNLOCK_LIST_SWITCH) then
		if not self.popLayerStack:isEmpty() or self.popLayerStack:getActivityLayer() ~= nil then
			if type(LayerManager:getCurrentLayerObj().exit) == "function" then
				LayerManager:getCurrentLayerObj():exit()
			else
				LayerManager:removePopLayer()
			end
		elseif not self.UILayerStack:isEmpty() then
			LayerManager:switchReturnLayer("FightLayer", {})
		elseif SDKManager.exit then
			SDKManager.registerExitGameHandler(function(arg_14_0)
				if arg_14_0 == 0 then
					cc.Director:getInstance():endToLua()
				end
			end)
			SDKManager.exit()
		end

		return
	end

	if not self.popLayerStack:isEmpty() or self.popLayerStack:getActivityLayer() ~= nil then
		if type(LayerManager:getCurrentLayerObj().exit) == "function" then
			LayerManager:getCurrentLayerObj():exit()
		else
			LayerManager:removePopLayer()
		end
	elseif not self.UILayerStack:isEmpty() then
		if type(LayerManager:getActiveLayerObj().exit) == "function" then
			LayerManager:getActiveLayerObj():exit()
		else
			LayerManager:switchReturnLayer(self.UILayerStack:getTopLayer(), (self.UILayerStack:getTopLayerInitParam()))
		end
	else
		if LayerManager:getCurrentLayerName() ~= var_0_3 then
			LayerManager:switchShowLayer(var_0_3)
		end

		local var_13_0 = DeviceManager.getPackageChannel()

		if config.packagechannel == "palmpi" then
			require("view.Layer.DialogLayer")

			local var_13_1 = DialogLayer:create(L_LOGIN_EXIT_DIALOG.Title, {
				"",
				L_LOGIN_EXIT_DIALOG.Content
			}, 500, 200, function()
				cc.Director:getInstance():endToLua()
			end, nil, true)

			var_13_1:setName("BACK_LAYER")
			var_13_1:setAnchorPoint(cc.p(0.5, 0.5))
			arg_13_1:addChild(var_13_1, 10005)
		elseif var_13_0 == "FY" then
			local function var_13_2()
				FeiyuManager.logout()
				TrackingManager.exit()
				cc.Director:getInstance():endToLua()
			end

			FeiyuManager.registerExitGameHandler(function(arg_17_0)
				if arg_17_0 ~= 0 then
					require("view.Layer.DialogLayer")

					local var_17_0 = DialogLayer:create(L_LOGIN_EXIT_DIALOG.Title, L_LOGIN_EXIT_DIALOG.Content, 500, 200, var_13_2, nil, true)

					var_17_0:setName("BACK_LAYER")
					var_17_0:setAnchorPoint(cc.p(0.5, 0.5))
					arg_13_1:addChild(var_17_0, 10005)
				else
					var_13_2()
				end
			end)
			FeiyuManager.exitgame()
		elseif SDKManager.exit then
			SDKManager.registerExitGameHandler(function(arg_18_0)
				print("do sdk exit code: ", arg_18_0)

				if arg_18_0 == 0 then
					cc.Director:getInstance():endToLua()
				end
			end)
			SDKManager.exit()
		else
			if arg_13_1:getChildByName("BACK_LAYER") then
				return
			end

			require("view.Layer.DialogLayer")

			local var_13_3 = DialogLayer:create(L_LOGIN_EXIT_DIALOG.Title, {
				"",
				L_LOGIN_EXIT_DIALOG.Content
			}, 500, 200, function()
				cc.Director:getInstance():endToLua()
			end, nil, true)

			var_13_3:setName("BACK_LAYER")
			var_13_3:setAnchorPoint(cc.p(0.5, 0.5))
			arg_13_1:addChild(var_13_3, 10005)
		end
	end
end

function var_0_1:registerSwitchShowLayerEvent(arg_20_1, arg_20_2)
	if self._stackEventLock > 0 then
		return
	end

	if arg_20_1 == "FightLayer" and FightManager.getFightType() ~= FIGHTTYPE_NORMAL or arg_20_1 == "ExploreMapLayer" then
		return
	end

	if self.UILayerStack:getActivityLayer() == arg_20_1 then
		self.popLayerStack:clear()

		return
	end

	if self.UILayerStack:getTopLayer() == arg_20_1 then
		self:registerUILayerEixtEvent()

		return
	end

	self.popLayerStack:clear()

	if arg_20_1 == var_0_3 then
		self.UILayerStack:clear()
		self.UILayerStack:push(arg_20_1, arg_20_2)

		return
	end

	if self:isMutex(arg_20_1) then
		return
	end

	self.UILayerStack:push(arg_20_1, arg_20_2)
end

function var_0_1:registerPushInLayerEvent(arg_21_1)
	if self._stackEventLock > 0 then
		return
	end

	self.popLayerStack:push(arg_21_1)
end

function var_0_1:registerUILayerEixtEvent(arg_22_1)
	self.popLayerStack:clear()

	if self._stackEventLock > 0 then
		return
	end

	if arg_22_1 == var_0_3 then
		self.UILayerStack:clear()
		self.UILayerStack:push(var_0_3)

		return
	end

	self.UILayerStack:pop()
end

function var_0_1:registerPopLayerEixtEvent()
	if self._stackEventLock > 0 then
		return
	end

	self.popLayerStack:pop()
end

function var_0_1:setKeyCodeEventlock(arg_24_1)
	self._keyCodeEventlock = arg_24_1 and self._keyCodeEventlock + 1 or self._keyCodeEventlock - 1

	if self._keyCodeEventlock < 0 then
		self._keyCodeEventlock = 0
	end
end

function var_0_1:setStackEventlock(arg_25_1)
	self._stackEventLock = arg_25_1 and self._stackEventLock + 1 or self._stackEventLock - 1

	if self._stackEventLock < 0 then
		self._stackEventLock = 0
	end
end

function var_0_1.initLock(arg_26_0)
	arg_26_0._keyCodeEventlock = 0
	arg_26_0._stackEventLock = 0
end

function var_0_1.isFightNeedLock(arg_27_0)
	if FightManager and FightManager:isBigBossFight() then
		return true
	elseif FightManager and not FightManager:isNormalFight() then
		return true
	else
		return false
	end
end

function var_0_1:isLock()
	return self._isLock
end

function var_0_1.setLock(arg_29_0, arg_29_1)
	arg_29_0._isLock = arg_29_1
end

function var_0_1:cleanAllStack()
	self.UILayerStack:clear()
	self.popLayerStack:clear()
end

function var_0_1.setCurTalkLayer(arg_31_0, arg_31_1)
	arg_31_0._talklayer = arg_31_1
end

function var_0_1.clearTalkLayer(arg_32_0)
	arg_32_0._talklayer = nil
end

function var_0_1:skipTalkLayer()
	if self._talklayer then
		self._talklayer:popsurewindow()
	end
end

function var_0_1.saveCurLayerParam(arg_34_0)
	local var_34_0 = LayerManager:getActiveLayerObj()

	if var_34_0.getExitParam then
		var_0_2[LayerManager:getActiveLayerName()] = var_34_0:getExitParam()
	end
end

function var_0_1.getCurLayerParam(arg_35_0, arg_35_1)
	if var_0_2[arg_35_1] then
		return var_0_2[arg_35_1]
	end
end

function var_0_1:UpdateInitParamPool(arg_36_1, arg_36_2)
	self.initParamPool = self.initParamPool or {}
	self.initParamPool[arg_36_1] = arg_36_2
end

function var_0_1:getInitParam(arg_37_1)
	self.initParamPool[arg_37_1] = nil

	return self.initParamPool[arg_37_1]
end

function var_0_1:updateCurFile()
	local lfs = require("lfs")
	local debug_console = require("devtools.debug_console")
	local var_38_2 = self.UILayerStack:getTopLayer()
	local var_38_3 = self.UILayerStack:getTopLayerInitParam()

	local function var_38_4(arg_39_0)
		for iter_39_0 in lfs.dir(arg_39_0) do
			if iter_39_0 ~= "." and iter_39_0 ~= ".." then
				if iter_39_0 ~= "Pops" then
					local var_39_0 = lfs.attributes(arg_39_0 .. "/" .. iter_39_0)

					if var_39_0.mode == "directory" and not (arg_39_0 .. "/" .. iter_39_0):find("ownload") then
						var_38_4(arg_39_0 .. "/" .. iter_39_0)
					elseif var_39_0.mode == "file" and (arg_39_0 .. "/" .. iter_39_0):find(".lua") and not (arg_39_0 .. "/" .. iter_39_0):find("ownload") and not (arg_39_0 .. "/" .. iter_39_0):find("FightLayer") then
						local var_39_1, var_39_2, var_39_3 = string.find(arg_39_0 .. "/" .. iter_39_0, "src/(.+).lua")
						local var_39_4 = string.gsub(var_39_3, "/", ".")

						if package.loaded[var_39_4] then
							debug_console.updateFile(var_39_4)
						end
					end
				end
			end
		end
	end

	var_38_4("src/view/Layer")
	var_38_4("src/view/Layer/Pops")
	var_38_4("src/view/Sprite")
	self:onKeyReleasedCallFunc()
end

function var_0_1:isMutex(arg_40_1)
	local var_40_0 = {
		LevelMapLayer = {
			LevelTalkMapLayer = true,
			LevelMapSingleLayer = true,
			SpecialOperationLayer = true,
			LevelMapLayer = true,
			LevelMapBoxLayer = true
		},
		LevelMapBoxLayer = {
			LevelTalkMapLayer = true,
			LevelMapSingleLayer = true,
			SpecialOperationLayer = true,
			LevelMapLayer = true,
			LevelMapBoxLayer = true
		},
		LevelTalkMapLayer = {
			LevelTalkMapLayer = true,
			LevelMapSingleLayer = true,
			SpecialOperationLayer = true,
			LevelMapLayer = true,
			LevelMapBoxLayer = true
		},
		LevelMapSingleLayer = {
			LevelTalkMapLayer = true,
			LevelMapSingleLayer = true,
			SpecialOperationLayer = true,
			LevelMapLayer = true,
			LevelMapBoxLayer = true
		},
		SpecialOperationLayer = {
			LevelTalkMapLayer = true,
			LevelMapSingleLayer = true,
			SpecialOperationLayer = true,
			LevelMapLayer = true,
			LevelMapBoxLayer = true
		}
	}

	if var_40_0[self.UILayerStack._activeLayer] and var_40_0[self.UILayerStack._activeLayer][arg_40_1] then
		return true
	end
end

return var_0_1
