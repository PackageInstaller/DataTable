-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/component/PetRaceTeamCellForSchedule.lua

PetRaceTeamCellForSchedule = class("PetRaceTeamCellForSchedule", DmBaseUI)

PetRaceTeamCellForSchedule:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")

local kBtnHandlers = {}

function PetRaceTeamCellForSchedule:initialize(data)
	super.initialize(self)
	self:setView(data.view)
	self:intiView()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function PetRaceTeamCellForSchedule:update(data, index)
	self._text_num:setString(index)

	self._isWin = data.isWin

	if not data.embattleInfo then
		local embattleInfo = {}

		if not embattleInfo.embattle then
			local embattle = {}

			self._petRaceSystem:refreshIconEmbattle(embattle, self._node_role, true)
			self._image_win:setVisible(false)

			if self._isWin then
				self._image_win:setVisible(true)
			end

			if self._isWin == nil then
				self._view:setGray(false)
			else
				self._view:setGray(true)
			end

			self._text_power:setString(embattleInfo.combat or 0)

			local limit = self._petRaceSystem:getMaxCost()

			self._text_cost:setString(string.format("%d/%d", self._petRaceSystem:getTeamCostByEmbattle(embattle), limit))
			self._text_speed:setString(self._petRaceSystem:getTeamSpeedByEmbattle(embattle))
		end
	end
end

function PetRaceTeamCellForSchedule:isWin()
	return self._isWin
end

function PetRaceTeamCellForSchedule:getBasePanel()
	return self._basePanel
end

function PetRaceTeamCellForSchedule:intiView()
	self._basePanel = self._view:getChildByFullName("Panel_base")
	self._text_num = self._view:getChildByFullName("Panel_base.Text_num")
	self._text_power = self._view:getChildByFullName("Panel_base.Text_power")
	self._text_cost = self._view:getChildByFullName("Panel_base.Text_cost")
	self._bg = self._view:getChildByFullName("Panel_base.Image_bg")

	self._bg:setSwallowTouches(false)

	self._bg_frame = self._view:getChildByFullName("Panel_base.Image_bg_frame")
	self._image_win = self._view:getChildByFullName("Panel_base.Node_win")
	self._text_speed = self._view:getChildByFullName("Panel_base.Text_speed")
	self._node_role = self._view:getChildByFullName("Panel_base.Node_role")
end
