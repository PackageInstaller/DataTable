-- chunkname: @modules/logic/fightuiswitch/model/FightUIStyleMo.lua

module("modules.logic.fightuiswitch.model.FightUIStyleMo", package.seeall)

local FightUIStyleMo = class("FightUIStyleMo")

function FightUIStyleMo:initMo(co, classify)
	self.id = co.id
	self.co = co
	self.classify = classify
	self.itemCo = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, co.itemId)
	self._effectMosList = {}

	local effects = string.splitToNumber(co.banner, "#")

	for _, effect in ipairs(effects) do
		local mo = FightUIEffectMo.New()

		mo:initMo(effect, classify)
		table.insert(self._effectMosList, mo)
	end
end

function FightUIStyleMo:isUse()
	return self.id == FightUISwitchModel.instance:getCurUseStyleIdByClassify(self.classify)
end

function FightUIStyleMo:isUnlock()
	if self:isDefault() then
		return true
	end

	local hasCount = ItemModel.instance:getItemCount(self.co.itemId)

	return hasCount > 0
end

function FightUIStyleMo:getRare()
	return (self.itemCo or nil) and (self.itemCo.rare or 3)
end

function FightUIStyleMo:getAllEffectMos()
	return self._effectMosList
end

function FightUIStyleMo:isDefault()
	return self.co.defaultUnlock == 1
end

function FightUIStyleMo:getConfig()
	return self.co
end

function FightUIStyleMo:getItemConfig()
	return self.itemCo
end

function FightUIStyleMo:getObtainTime()
	if not self:isUnlock() then
		return
	end

	local timestamp

	if self:isDefault() then
		local info = PlayerModel.instance:getPlayinfo()

		timestamp = info and info.registerTime
	else
		local itemMo = ItemModel.instance:getById(self.co.itemId)

		timestamp = itemMo and itemMo.lastUpdateTime
	end

	if string.nilorempty(timestamp) then
		return
	end

	local timeStr = timestamp and TimeUtil.timestampToString3(ServerTime.timeInLocal(timestamp / 1000))

	return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("fightuiswitch_obtaintime"), timeStr)
end

function FightUIStyleMo:canJump()
	local sourceTables = MainSceneSwitchConfig.instance:getItemSource(self.itemCo.id)

	for i, sourceTable in ipairs(sourceTables) do
		local cantJumpTips, toastParamList = MainSceneSwitchModel._getCantJump(sourceTable)

		if not cantJumpTips then
			return true
		end
	end

	return false
end

return FightUIStyleMo
