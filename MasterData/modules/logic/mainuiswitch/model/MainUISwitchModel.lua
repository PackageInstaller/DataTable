-- chunkname: @modules/logic/mainuiswitch/model/MainUISwitchModel.lua

module("modules.logic.mainuiswitch.model.MainUISwitchModel", package.seeall)

local MainUISwitchModel = class("MainUISwitchModel", BaseModel)

function MainUISwitchModel:onInit()
	self:reInit()
end

function MainUISwitchModel:reInit()
	self._curUseUI = nil
end

function MainUISwitchModel:initMainUI()
	local value = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.MainUISkin)
	local itemId = tonumber(value) or 0
	local co = MainUISwitchConfig.instance:getUISwitchCoByItemId(itemId)

	if co then
		self._curUseUI = co.id or self:_getUseUIDefaultId()
	end
end

function MainUISwitchModel:setCurUseUI(id)
	self._curUseUI = id
end

function MainUISwitchModel:getCurUseUI()
	return self._curUseUI or self:_getUseUIDefaultId()
end

function MainUISwitchModel:_getUseUIDefaultId()
	for _, co in ipairs(lua_scene_ui.configList) do
		if co.defaultUnlock == 1 then
			return co.id
		end
	end
end

function MainUISwitchModel.getUIStatus(id)
	local config = lua_scene_ui.configDict[id]

	if not config then
		return MainSceneSwitchEnum.SceneStutas.Lock
	end

	if config.defaultUnlock == 1 then
		return MainSceneSwitchEnum.SceneStutas.Unlock
	end

	local num = ItemModel.instance:getItemCount(config.itemId)

	if num > 0 then
		return MainSceneSwitchEnum.SceneStutas.Unlock
	end

	if MainUISwitchModel.canJump(config.itemId) then
		return MainSceneSwitchEnum.SceneStutas.LockCanGet
	end

	return MainSceneSwitchEnum.SceneStutas.Lock
end

function MainUISwitchModel.canJump(itemId)
	local sourceTables = MainUISwitchConfig.instance:getItemSource(itemId)

	for i, sourceTable in ipairs(sourceTables) do
		local cantJumpTips, toastParamList = MainSceneSwitchModel._getCantJump(sourceTable)

		if not cantJumpTips then
			return true
		end
	end

	return false
end

function MainUISwitchModel:getUIReddotType(uiId)
	local cos = lua_scene_ui_reddot.configDict[uiId]

	if cos then
		local _, co = next(cos)

		if co then
			return co.style
		end
	end
end

MainUISwitchModel.instance = MainUISwitchModel.New()

return MainUISwitchModel
