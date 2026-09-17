local var_0_0 = 0

GlobalFightManagerMap = {}

local FightManager = class("FightManager")
local FightExecuteManager = require("fight.FightExecuteManager")

require("view.Sprite.GoldSprite")

local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local fight_ui_manager = require("fight.manager.fight_ui_manager")
local fight_characters_manager = require("fight.manager.fight_characters_manager")
local fight_update_manager = require("fight.manager.fight_update_manager")
local fight_state_manager = require("fight.manager.fight_state_manager")
local fight_halo_manager = require("fight.manager.fight_halo_manager")
local fight_switch_manager = require("fight.manager.fight_switch_manager")
local fight_statistic_manager = require("fight.manager.fight_statistic_manager")
local fight_worldmap_manager = require("fight.manager.fight_worldmap_manager")
local fight_download_manager = require("fight.manager.fight_download_manager")

global_battlefield_timescale = 1
global_gold_drop_timer = 1

function FightManager:create()
	local var_1_0 = FightManager.new()

	var_1_0:init()

	return var_1_0
end

function FightManager:ctor()
	var_0_0 = var_0_0 + 1
	self.__globalid = var_0_0
	GlobalFightManagerMap[self.__globalid] = self
end

function FightManager:getGlobalID()
	return self.__globalid
end

function FightManager:init()
	self.mainloopID = nil

	fight_ui_manager(self)()
	fight_characters_manager(self)()
	fight_update_manager(self)()
	fight_state_manager(self)()
	fight_halo_manager(self)()
	fight_statistic_manager(self)()
	fight_switch_manager(self)()
	fight_worldmap_manager(self)()
	fight_download_manager(self)()

	function self.call(arg_5_0, ...)
		self[arg_5_0](...)
	end

	self.__yieldid = 0

	function self.yield(arg_6_0)
		self.__yieldid = self.__yieldid + 1
		self.yieldfunc = {
			handler = arg_6_0,
			id = self.__yieldid
		}

		return self.__yieldid
	end

	function self.resume(arg_7_0)
		if self.yieldfunc and arg_7_0 == self.yieldfunc.id then
			self.yieldfunc = nil

			self.yieldfunc.handler()
			self.mainloop()

			return true
		else
			return false
		end
	end

	function self.removeyield()
		self.yieldfunc = nil
	end
end

function FightManager:runSkill(arg_9_1)
	FightExecuteManager:runSkill(self, arg_9_1)
end

function FightManager:initFight(arg_10_1)
	if config._DEVELOP_MODE == "FIGHTDEV" then
		self:initGuideFight()

		return
	end

	self:initNormalFight()

	if not playermodel.gameInitGuides[2] then
		require("view.Layer.Guide.GuideInitial"):onStart()
	end
end

function FightManager:initGuideFight()
	self.fighttype = FIGHTTYPE_GUIDE
	self.pvefighting = true

	self.battlefieldRef:updateFightMap({
		"fightbg5_1",
		"fightbg5_2",
		"fightbg5_3"
	})
	self.setFightState(FIGHTSTATE_WAIT)
	self.mainloop()
end

function FightManager:initNormalFight(arg_12_1)
	level_manager.resetCurLevelEnemy(playermodel.curMode, playermodel.curLevel)

	if config._THEATER then
		FightLayer.getInstance():addTheaterLayer(config._THEATER)
	else
		self.fighttype = FIGHTTYPE_NORMAL

		self.updateHangupStatus()
		self.setFightState(FIGHTSTATE_SEARCHING)
		self.resetFightWorldMap()

		local function var_12_0()
			self.initPlayerSync()
			self.mainloop()
		end

		local var_12_1 = self.checkSpineRes()

		if #var_12_1 > 0 then
			FightLayer.getInstance():needDownload(self.yield(var_12_0), var_12_1)
		else
			var_12_0()
		end
	end
end

function FightManager:resetTestFight()
	if config._DEVELOP_MODE ~= "FIGHTDEV" then
		return
	end

	self.refreshAtOnce()
end

return FightManager
