-- chunkname: @modules/logic/summonuiswitch/model/SummonUISwitchModel.lua

module("modules.logic.summonuiswitch.model.SummonUISwitchModel", package.seeall)

local SummonUISwitchModel = class("SummonUISwitchModel", BaseModel)

function SummonUISwitchModel:onInit()
	self:reInit()
end

function SummonUISwitchModel:reInit()
	return
end

function SummonUISwitchModel:initConfig()
	self:_defaultUseId()
end

function SummonUISwitchModel:initSceneUI()
	local value = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.SummonUISkin)

	if value then
		self._curUseUI = tonumber(value) or self:_getUseUIDefaultId()
	else
		self:_defaultUseId()
	end
end

function SummonUISwitchModel:_defaultUseId()
	self._curUseUI = GameUtil.playerPrefsGetNumberByUserId(SummonUISwitchEnum.SaveClickUIPrefKey, self:_getUseUIDefaultId())
end

function SummonUISwitchModel:setCurUseUI(id)
	self._curUseUI = id

	GameUtil.playerPrefsSetNumberByUserId(SummonUISwitchEnum.SaveClickUIPrefKey, id)

	local simpleProperty = PlayerEnum.SimpleProperty.SummonUISkin

	PlayerModel.instance:forceSetSimpleProperty(simpleProperty, tostring(id))
	SummonUISwitchController.instance:dispatchEvent(SummonUISwitchEvent.UseSceneUI, id)
end

function SummonUISwitchModel:getCurUseUI()
	return self._curUseUI or self:_getUseUIDefaultId()
end

function SummonUISwitchModel:_getUseUIDefaultId()
	local configList = SummonUISwitchConfig.instance:getSummonSwitchConfigList()

	for _, co in ipairs(configList) do
		if co.defaultUnlock == 1 then
			return co.id
		end
	end
end

function SummonUISwitchModel.getUIStatus(id)
	local config = SummonUISwitchConfig.instance:getSummonSwitchConfig(id)

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

	if SummonUISwitchModel.canJump(config.itemId) then
		return MainSceneSwitchEnum.SceneStutas.LockCanGet
	end

	return MainSceneSwitchEnum.SceneStutas.Lock
end

function SummonUISwitchModel.canJump(itemId)
	local sourceTables = SummonUISwitchConfig.instance:getItemSource(itemId)

	for i, sourceTable in ipairs(sourceTables) do
		local cantJumpTips, toastParamList = MainSceneSwitchModel._getCantJump(sourceTable)

		if not cantJumpTips then
			return true
		end
	end

	return false
end

function SummonUISwitchModel:hasReddot()
	local configList = SummonUISwitchConfig.instance:getSummonSwitchConfigList()

	for _, co in ipairs(configList) do
		if co.defaultUnlock ~= 1 and SummonUISwitchModel.getUIStatus(co.id) == MainSceneSwitchEnum.SceneStutas.Unlock then
			local key = SummonUISwitchEnum.SaveClickUIPrefKey .. co.id

			if GameUtil.playerPrefsGetNumberByUserId(key, 0) == 0 then
				return true
			end
		end
	end
end

function SummonUISwitchModel:cancelReddot()
	local configList = SummonUISwitchConfig.instance:getSummonSwitchConfigList()

	for _, co in ipairs(configList) do
		if co.defaultUnlock ~= 1 and SummonUISwitchModel.getUIStatus(co.id) == MainSceneSwitchEnum.SceneStutas.Unlock then
			local key = SummonUISwitchEnum.SaveClickUIPrefKey .. co.id

			GameUtil.playerPrefsSetNumberByUserId(key, 1)
		end
	end
end

SummonUISwitchModel.instance = SummonUISwitchModel.New()

return SummonUISwitchModel
