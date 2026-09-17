local MonopolyEventHistoryManager = class("MonopolyEventHistoryManager", (require("controller.base_manager")))

MonopolyEventHistoryManager.MULTITON_MSG = "MonopolyEventHistoryManager instancealready constructed!"
MonopolyEventHistoryManager.MAX_EVENT_NUM = 50

function MonopolyEventHistoryManager:ctor()
	MonopolyEventHistoryManager.super.ctor(self)

	self._data = {}
	self._tips = {}
	self._textColor = {
		default = "009BB3",
		aiLose = "ffffff",
		ourWin = "009BB3",
		ourLose = "009BB3",
		aiWin = "ffffff",
		aiNormalMoney = "ffffff"
	}

	self:initTips()
end

function MonopolyEventHistoryManager:requestInfo(arg_2_1)
	return
end

function MonopolyEventHistoryManager:handlerInfo(arg_3_1)
	return
end

function MonopolyEventHistoryManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function MonopolyEventHistoryManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function MonopolyEventHistoryManager:pushEvent(arg_6_1)
	if #self._data > MonopolyEventHistoryManager.MAX_EVENT_NUM then
		table.remove(self._data, 1)
	end

	table.insert(self._data, arg_6_1)
end

function MonopolyEventHistoryManager:clearEventData()
	self._data = {}
end

function MonopolyEventHistoryManager:getShowInfo()
	local var_8_0 = require("controller.monopoly.monopoly_manager"):getInstance()
	local var_8_1 = handler(self, self.quickGetRichTextStr)
	local var_8_2 = {}

	for iter_8_0 = 1, #self._data do
		var_8_2[#var_8_2 + 1] = {}

		local var_8_3 = self._data[iter_8_0].type
		local var_8_4 = self._data[iter_8_0].data or {}
		local var_8_5 = var_8_4.target

		var_8_2[#var_8_2].type = var_8_3
		var_8_2[#var_8_2].target = var_8_5
		var_8_2[#var_8_2].str = var_8_5 and var_8_3 .. "\t" .. var_8_5 .. "\terror" or var_8_3 .. "\terror"

		if var_8_5 and self._tips[var_8_3] and self._tips[var_8_3][var_8_5] then
			var_8_2[#var_8_2].str = self._tips[var_8_3][var_8_5]
		end

		if var_8_5 == var_8_0.EVENTS_TARGET_TYPE.PLAYER then
			if var_8_3 == var_8_0.EVENTS_TYPE.LEVEL_UP_TILE then
				if var_8_4.cost_gold and var_8_4.cost_gold > 0 then
					var_8_2[#var_8_2].str = string.format(var_8_2[#var_8_2].str, var_8_4.cost_gold, L_MONOPOLY[1], var_8_4.tile_lv)
				elseif var_8_4.cost_diamond and var_8_4.cost_diamond > 0 then
					var_8_2[#var_8_2].str = string.format(var_8_2[#var_8_2].str, var_8_4.cost_diamond, L_MONOPOLY[2], var_8_4.tile_lv)
				end
			elseif var_8_3 == var_8_0.EVENTS_TYPE.TRANSFER_MONEY then
				var_8_2[#var_8_2].str = string.format(var_8_2[#var_8_2].str, var_8_4.money)
			elseif var_8_3 == var_8_0.EVENTS_TYPE.BUILDING_INCOME then
				var_8_2[#var_8_2].str = string.format(var_8_2[#var_8_2].str, var_8_4.money)
			elseif var_8_3 == var_8_0.EVENTS_TYPE.BUILDING_UP then
				-- block empty
			elseif var_8_3 == var_8_0.EVENTS_TYPE.BUILDING_DOWN then
				-- block empty
			elseif var_8_3 == var_8_0.EVENTS_TYPE.GET_BUFF then
				local var_8_6 = require("controller/monopoly/monopoly_buff_manager"):getInstance()
				local var_8_7 = var_8_6:getConfigById(var_8_4.buff)

				if var_8_7.buff_or_debuff == var_8_6.BUFF_TYPE.BUFF then
					var_8_2[#var_8_2].str = string.format(var_8_2[#var_8_2].str, var_8_7.name, L_MONOPOLY[3])
				elseif var_8_7.buff_or_debuff == var_8_6.BUFF_TYPE.DEBUFF then
					var_8_2[#var_8_2].str = string.format(var_8_2[#var_8_2].str, var_8_7.name, L_MONOPOLY[4])
				end
			elseif var_8_3 == var_8_0.EVENTS_TYPE.AWARD then
				-- block empty
			elseif var_8_3 == var_8_0.EVENTS_TYPE.FIGHT then
				if var_8_4.gold > 0 then
					var_8_2[#var_8_2].str = string.format(var_8_2[#var_8_2].str, var_8_1({
						{
							str = L_MONOPOLY[5]
						},
						{
							str = var_8_4.gold,
							color = self._textColor.ourWin
						},
						{
							str = L_MONOPOLY[1]
						}
					}))
				elseif var_8_4.gold < 0 then
					var_8_2[#var_8_2].str = string.format(var_8_2[#var_8_2].str, var_8_1({
						{
							str = L_MONOPOLY[6]
						},
						{
							str = -var_8_4.gold,
							color = self._textColor.ourLose
						},
						{
							str = L_MONOPOLY[1]
						}
					}))
				end
			end
		elseif var_8_5 == var_8_0.EVENTS_TARGET_TYPE.AI then
			if var_8_3 == var_8_0.EVENTS_TYPE.ADD_MONEY then
				var_8_2[#var_8_2].str = string.format(var_8_2[#var_8_2].str, var_8_4.money)
			elseif var_8_3 == var_8_0.EVENTS_TYPE.LOSE_MONEY then
				var_8_2[#var_8_2].str = string.format(var_8_2[#var_8_2].str, var_8_4.money)
			elseif var_8_3 == var_8_0.EVENTS_TYPE.LEVEL_UP_TILE then
				var_8_2[#var_8_2].str = string.format(var_8_2[#var_8_2].str, var_8_4.cost_gold, var_8_4.tile_lv)
			elseif var_8_3 == var_8_0.EVENTS_TYPE.TRANSFER_MONEY then
				var_8_2[#var_8_2].str = string.format(var_8_2[#var_8_2].str, var_8_4.money)
			elseif var_8_3 == var_8_0.EVENTS_TYPE.BUILDING_INCOME then
				var_8_2[#var_8_2].str = string.format(var_8_2[#var_8_2].str, var_8_4.money)
			elseif var_8_3 == var_8_0.EVENTS_TYPE.BUILDING_UP then
				-- block empty
			elseif var_8_3 == var_8_0.EVENTS_TYPE.BUILDING_DOWN then
				-- block empty
			end
		end
	end

	return var_8_2
end

function MonopolyEventHistoryManager:getLastEventStr()
	local var_9_0 = self:getShowInfo()

	if #var_9_0 > 0 then
		return (string.gsub(var_9_0[#var_9_0].str, self._textColor.default, "ffffff"))
	end

	return ""
end

function MonopolyEventHistoryManager:initTips()
	local var_10_0 = require("controller.monopoly.monopoly_manager"):getInstance()
	local var_10_1 = handler(self, self.quickGetRichTextStr)
	local var_10_2 = handler(self, self.getRichTextStr)

	self._tips = {
		[var_10_0.EVENTS_TYPE.ADD_MONEY] = {
			[var_10_0.EVENTS_TARGET_TYPE.AI] = var_10_1({
				{
					str = L_MONOPOLY[7]
				},
				{
					str = "%s",
					color = self._textColor.aiNormalMoney
				},
				{
					str = L_MONOPOLY[1]
				}
			})
		},
		[var_10_0.EVENTS_TYPE.LOSE_MONEY] = {
			[var_10_0.EVENTS_TARGET_TYPE.AI] = var_10_1({
				{
					str = L_MONOPOLY[8]
				},
				{
					str = "%s",
					color = self._textColor.aiNormalMoney
				},
				{
					str = L_MONOPOLY[1]
				}
			})
		},
		[var_10_0.EVENTS_TYPE.LEVEL_UP_TILE] = {
			[var_10_0.EVENTS_TARGET_TYPE.AI] = var_10_2(L_MONOPOLY[9]),
			[var_10_0.EVENTS_TARGET_TYPE.PLAYER] = var_10_2(L_MONOPOLY[10])
		},
		[var_10_0.EVENTS_TYPE.TRANSFER_MONEY] = {
			[var_10_0.EVENTS_TARGET_TYPE.AI] = var_10_1({
				{
					str = L_MONOPOLY[11]
				},
				{
					str = "%s",
					color = self._textColor.ourLose
				},
				{
					str = L_MONOPOLY[1]
				}
			}),
			[var_10_0.EVENTS_TARGET_TYPE.PLAYER] = var_10_1({
				{
					str = L_MONOPOLY[12]
				},
				{
					str = "%s",
					color = self._textColor.ourWin
				},
				{
					str = L_MONOPOLY[1]
				}
			})
		},
		[var_10_0.EVENTS_TYPE.BUILDING_INCOME] = {
			[var_10_0.EVENTS_TARGET_TYPE.AI] = var_10_1({
				{
					str = L_MONOPOLY[13]
				},
				{
					str = "%s",
					color = self._textColor.ourLose
				},
				{
					str = L_MONOPOLY[1]
				}
			}),
			[var_10_0.EVENTS_TARGET_TYPE.PLAYER] = var_10_1({
				{
					str = L_MONOPOLY[14]
				},
				{
					str = "%s",
					color = self._textColor.ourWin
				},
				{
					str = L_MONOPOLY[1]
				}
			})
		},
		[var_10_0.EVENTS_TYPE.BUILDING_UP] = {
			[var_10_0.EVENTS_TARGET_TYPE.AI] = var_10_2(L_MONOPOLY[15]),
			[var_10_0.EVENTS_TARGET_TYPE.PLAYER] = var_10_2(L_MONOPOLY[16])
		},
		[var_10_0.EVENTS_TYPE.BUILDING_DOWN] = {
			[var_10_0.EVENTS_TARGET_TYPE.AI] = var_10_2(L_MONOPOLY[17]),
			[var_10_0.EVENTS_TARGET_TYPE.PLAYER] = var_10_2(L_MONOPOLY[18])
		},
		[var_10_0.EVENTS_TYPE.GET_BUFF] = {
			[var_10_0.EVENTS_TARGET_TYPE.PLAYER] = var_10_2(L_MONOPOLY[19])
		},
		[var_10_0.EVENTS_TYPE.AWARD] = {
			[var_10_0.EVENTS_TARGET_TYPE.PLAYER] = var_10_2(L_MONOPOLY[20])
		},
		[var_10_0.EVENTS_TYPE.FIGHT] = {
			[var_10_0.EVENTS_TARGET_TYPE.AI] = "%s",
			[var_10_0.EVENTS_TARGET_TYPE.PLAYER] = "%s"
		}
	}
end

function MonopolyEventHistoryManager:getRichTextStr(arg_11_1, arg_11_2)
	arg_11_2 = arg_11_2 or self._textColor.default

	return "<div fontcolor=#" .. arg_11_2 .. ">" .. arg_11_1 .. "</div>"
end

function MonopolyEventHistoryManager:quickGetRichTextStr(arg_12_1)
	local var_12_0 = {}

	for iter_12_0 = 1, #arg_12_1 do
		var_12_0[#var_12_0 + 1] = self:getRichTextStr(arg_12_1[iter_12_0].str, arg_12_1[iter_12_0].color)
	end

	return string.gsub(table.concat(var_12_0), "</div>", "") .. "</div>"
end

function MonopolyEventHistoryManager:cleanData()
	self._data = {}
end

return MonopolyEventHistoryManager
