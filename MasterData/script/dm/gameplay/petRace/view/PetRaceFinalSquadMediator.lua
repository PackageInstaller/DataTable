-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/PetRaceFinalSquadMediator.lua

PetRaceFinalSquadMediator = class("PetRaceFinalSquadMediator", DmPopupViewMediator)

PetRaceFinalSquadMediator:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")

local kBtnHandlers = {
	["Panel_base.Button_r"] = "onRightClicked",
	["Panel_base.Button_l"] = "onLeftClicked",
	["Panel_base.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onBackClicked"
	}
}

function PetRaceFinalSquadMediator:initialize()
	super.initialize(self)
end

function PetRaceFinalSquadMediator:dispose()
	if self._schedule_cd then
		LuaScheduler:getInstance():unschedule(self._schedule_cd)

		self._schedule_cd = nil
	end

	super.dispose(self)
end

function PetRaceFinalSquadMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function PetRaceFinalSquadMediator:enterWithData(data)
	self._raceData = data
	self._index = data.clickIndex

	self:setupView()
	self:initWigetInfo()

	self._schedule_cd = LuaScheduler:getInstance():schedule(function()
		self:updateCD()
	end, 1, false)

	self:updateCD()
end

function PetRaceFinalSquadMediator:setupView()
	self._mainPanel = self:getView():getChildByFullName("Panel_base")
	self._node_time = self._mainPanel:getChildByFullName("Node_time")

	local node_name = self._mainPanel:getChildByFullName("title_node")

	bindWidget(self, node_name, PopupNormalTitle, {
		title = Strings:get("Petrace_Text_88"),
		title1 = Strings:get("UITitle_EN_Wanjiazhenrong")
	})
end

function PetRaceFinalSquadMediator:refreshView()
	local button_l = self:getView():getChildByFullName("Panel_base.Button_l")
	local button_r = self:getView():getChildByFullName("Panel_base.Button_r")
	local text_cost_l = self:getView():getChildByFullName("Panel_base.Node_info_l.Text_cost")
	local text_first_l = self:getView():getChildByFullName("Panel_base.Node_info_l.Text_first")
	local text_cost_r = self:getView():getChildByFullName("Panel_base.Node_info_r.Text_cost")
	local text_first_r = self:getView():getChildByFullName("Panel_base.Node_info_r.Text_first")
	local text_power_l = self:getView():getChildByFullName("Panel_base.Node_info_l.Text_power")
	local text_power_r = self:getView():getChildByFullName("Panel_base.Node_info_r.Text_power")

	button_r:setVisible(true)
	button_l:setVisible(true)

	if self._index == 1 then
		button_l:setVisible(false)
	end

	local myEmbattleInfo = self._raceData.myEmbattleInfo
	local enemyEmbattleInfo = self._raceData.enemyEmbattleInfo

	if self._index >= #myEmbattleInfo and self._index >= #enemyEmbattleInfo then
		button_r:setVisible(false)
	end

	if not myEmbattleInfo[self._index] then
		local battleInfoL = {}

		if not enemyEmbattleInfo[self._index] then
			local battleInfoR = {}

			self._petRaceSystem:refreshNineEmbattle(battleInfoL.embattle, self._node_9frame_l)
			self._petRaceSystem:refreshNineEmbattle(battleInfoR.embattle, self._node_9frame_r)

			local costl = self._petRaceSystem:getTeamCostByEmbattle(battleInfoL.embattle or {})
			local costr = self._petRaceSystem:getTeamCostByEmbattle(battleInfoR.embattle or {})
			local speedl = self._petRaceSystem:getTeamSpeedByEmbattle(battleInfoL.embattle or {})
			local speedr = self._petRaceSystem:getTeamSpeedByEmbattle(battleInfoR.embattle or {})

			text_cost_l:setString(tostring(costl))
			text_cost_r:setString(tostring(costr))
			text_first_l:setString(tostring(speedl))
			text_first_r:setString(tostring(speedr))
			text_power_l:setString(battleInfoL.combat or 0)
			text_power_r:setString(battleInfoR.combat or 0)
		end
	end
end

function PetRaceFinalSquadMediator:initWigetInfo()
	local text_name_l = self:getView():getChildByFullName("Panel_base.Text_name_l")
	local text_name_r = self:getView():getChildByFullName("Panel_base.Text_name_r")

	self._node_9frame_l = self:getView():getChildByFullName("Panel_base.Node_frame9_l")
	self._node_9frame_r = self:getView():getChildByFullName("Panel_base.Node_frame9_r")

	local text_level_l = self:getView():getChildByFullName("Panel_base.Text_lv_l")
	local text_level_r = self:getView():getChildByFullName("Panel_base.Text_lv_r")

	text_name_r:setString(self._raceData.nameR or "")
	text_name_l:setString(self._raceData.nameL or "")
	text_level_l:setString("Lv." .. self._raceData.laveL or "")
	text_level_r:setString("Lv." .. self._raceData.levelR or "")
	self:refreshView()
end

function PetRaceFinalSquadMediator:onBackClicked(sender, eventType)
	self:close()
end

function PetRaceFinalSquadMediator:onLeftClicked(sender, eventType)
	self._index = self._index - 1

	self:refreshView()
end

function PetRaceFinalSquadMediator:onRightClicked(sender, eventType)
	self._index = self._index + 1

	self:refreshView()
end

function PetRaceFinalSquadMediator:updateCD()
	self._petRaceSystem:updateTimeDes(self._node_time, self._raceData.round, self._raceData.state, self._raceData.endTime)
end
