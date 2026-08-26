-- chunkname: @modules/logic/clickuiswitch/model/ClickUISwitchModel.lua

module("modules.logic.clickuiswitch.model.ClickUISwitchModel", package.seeall)

local ClickUISwitchModel = class("ClickUISwitchModel", BaseModel)

function ClickUISwitchModel:onInit()
	self:reInit()
end

function ClickUISwitchModel:reInit()
	return
end

function ClickUISwitchModel:initConfig()
	self:_defaultUseId()
end

function ClickUISwitchModel:initClickUI()
	local value = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.ClickUISkin)

	if value then
		self._curUseUI = tonumber(value) or self:_getUseUIDefaultId()
	else
		self:_defaultUseId()
	end
end

function ClickUISwitchModel:_defaultUseId()
	self._curUseUI = GameUtil.playerPrefsGetNumberByUserId(ClickUISwitchEnum.SaveClickUIPrefKey, self:_getUseUIDefaultId())
end

function ClickUISwitchModel:setCurUseUI(id)
	self._curUseUI = id

	GameUtil.playerPrefsSetNumberByUserId(ClickUISwitchEnum.SaveClickUIPrefKey, id)
end

function ClickUISwitchModel:getCurUseUI()
	return self._curUseUI or self:_getUseUIDefaultId()
end

function ClickUISwitchModel:getCurUseUICo()
	return self:getClickUICoById(self:getCurUseUI())
end

function ClickUISwitchModel:getCurUseSkinParam()
	local curId = self:getCurUseUI()

	for _, param in pairs(ClickUISwitchEnum.SkinParams) do
		if param.id == curId then
			return param
		end
	end
end

function ClickUISwitchModel:getClickUICoById(id)
	return lua_scene_click.configDict[id]
end

function ClickUISwitchModel:_getUseUIDefaultId()
	if not lua_scene_click.configList then
		return ClickUISwitchEnum.SkinParams[ClickUISwitchEnum.Skin.Normal].id
	end

	for _, co in ipairs(lua_scene_click.configList) do
		if co.defaultUnlock == 1 then
			return co.id
		end
	end
end

function ClickUISwitchModel.getUIStatus(id)
	local config = lua_scene_click.configDict[id]

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

	if ClickUISwitchModel.canJump(config.itemId) then
		return MainSceneSwitchEnum.SceneStutas.LockCanGet
	end

	return MainSceneSwitchEnum.SceneStutas.Lock
end

function ClickUISwitchModel.canJump(itemId)
	local sourceTables = ClickUISwitchConfig.instance:getItemSource(itemId)

	for i, sourceTable in ipairs(sourceTables) do
		local cantJumpTips, toastParamList = MainSceneSwitchModel._getCantJump(sourceTable)

		if not cantJumpTips then
			return true
		end
	end

	return false
end

function ClickUISwitchModel:hasReddot()
	for _, co in ipairs(lua_scene_click.configList) do
		if co.defaultUnlock ~= 1 and ClickUISwitchModel.getUIStatus(co.id) == MainSceneSwitchEnum.SceneStutas.Unlock then
			local key = ClickUISwitchEnum.SaveClickUIPrefKey .. co.id

			if GameUtil.playerPrefsGetNumberByUserId(key, 0) == 0 then
				return true
			end
		end
	end
end

function ClickUISwitchModel:cancelReddot()
	for _, co in ipairs(lua_scene_click.configList) do
		if co.defaultUnlock ~= 1 and ClickUISwitchModel.getUIStatus(co.id) == MainSceneSwitchEnum.SceneStutas.Unlock then
			local key = ClickUISwitchEnum.SaveClickUIPrefKey .. co.id

			GameUtil.playerPrefsSetNumberByUserId(key, 1)
		end
	end
end

ClickUISwitchModel.instance = ClickUISwitchModel.New()

return ClickUISwitchModel
