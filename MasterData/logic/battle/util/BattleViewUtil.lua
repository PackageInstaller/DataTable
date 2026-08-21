-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/BattleViewUtil.lua

module("logic.battle.util.BattleViewUtil", package.seeall)

local M = class("BattleViewUtil")
local BattleViewUtil = {}

function BattleViewUtil.tryShowEarlyStageTips(action, ensureFunc, ensureHandler)
	if not PlayerModel.instance:getPrologueFinished() then
		return false
	end

	if DungeonModel.instance:isInGameEarlyStage() then
		return false
	end

	local contentKey = BattleMapEnum.WarningActionContent[action]
	local luaTable = {}

	luaTable.ensureHandler = ensureHandler
	luaTable.title = lang("tip_title")
	luaTable.content = StringUtil.replaceAllRed(lang(contentKey))

	local dialog = Dialog.showDialogDaily(luaTable, string.format("_key_early_stage_warning_%s_", action))

	if dialog then
		dialog:setConfirmListener(ensureFunc, ensureHandler)
	else
		return false
	end

	return true
end

return BattleViewUtil
