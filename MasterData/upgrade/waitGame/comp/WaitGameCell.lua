local var_0_0 = g.core.config.game_eliminate_res_info
local var_0_1 = g.core.const.ConstMgr.WaitGameConst
local WaitGameCell = class("WaitGameCell", require("app.fairyGUI.upgrade.UI_WaitGameCell"))

function WaitGameCell:ctor()
	self._gemColor = 0
	self._selectedEffNode = nil
	self._selected = false
end

function WaitGameCell:updateCell(arg_2_1)
	self:setGemColor(arg_2_1.color)
	self:setSelected(arg_2_1.selected)
end

function WaitGameCell:setGemColor(arg_3_1)
	self._gemColor = arg_3_1

	self.m_gemLoader:setURL((string.format(var_0_1.WAITGAME_GEM_ICON_FORMAT, var_0_0.get(arg_3_1).res)))
end

function WaitGameCell:getGemColor()
	return self._gemColor
end

function WaitGameCell:setSelected(arg_5_1)
	arg_5_1 = checkbool(arg_5_1)

	if arg_5_1 == self._selected then
		return
	end

	self._selected = arg_5_1

	if arg_5_1 then
		if self._selectedEffNode then
			self._selectedEffNode:resume()
			self._selectedEffNode:setVisible(true)
		else
			self._selectedEffNode = self.m_selectedEffDad:addEffectSpine({
				remove = false,
				name = "eff_ui_upgradeGem_checkbox",
				isLoop = true
			})
		end
	elseif self._selectedEffNode then
		self._selectedEffNode:pause()
		self._selectedEffNode:setVisible(false)
	end
end

return WaitGameCell
