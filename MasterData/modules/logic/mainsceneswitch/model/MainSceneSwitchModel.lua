-- chunkname: @modules/logic/mainsceneswitch/model/MainSceneSwitchModel.lua

module("modules.logic.mainsceneswitch.model.MainSceneSwitchModel", package.seeall)

local MainSceneSwitchModel = class("MainSceneSwitchModel", BaseModel)

function MainSceneSwitchModel:onInit()
	self:reInit()
end

function MainSceneSwitchModel:reInit()
	self._sceneId = nil
	self._sceneConfig = nil
end

function MainSceneSwitchModel:initSceneId()
	if self._sceneId then
		return
	end

	local value = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.MainSceneSkin)
	local itemId = tonumber(value) or 0

	self:updateSceneIdByItemId(itemId)

	if self._sceneId then
		MainSceneSwitchController.closeSceneReddot(self._sceneId)
	end
end

function MainSceneSwitchModel:updateSceneIdByItemId(itemId)
	local sceneConfig = MainSceneSwitchConfig.instance:getConfigByItemId(itemId)

	if sceneConfig then
		if not sceneConfig.id then
			local sceneId = MainSceneSwitchConfig.instance:getDefaultSceneId()

			self:setCurSceneId(sceneId)
		end
	end
end

function MainSceneSwitchModel:getCurSceneId()
	return self._sceneId
end

function MainSceneSwitchModel:setCurSceneId(sceneId)
	self._sceneId = sceneId
	self._sceneConfig = lua_scene_switch.configDict[self._sceneId]

	if not self._sceneConfig then
		self._sceneId = MainSceneSwitchConfig.instance:getDefaultSceneId()
		self._sceneConfig = lua_scene_switch.configDict[self._sceneId]
	end
end

function MainSceneSwitchModel:getCurSceneResName()
	return self._sceneConfig and self._sceneConfig.resName
end

function MainSceneSwitchModel.getSceneStatus(id)
	local config = lua_scene_switch.configDict[id]

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

	if MainSceneSwitchModel.canJump(config.itemId) then
		return MainSceneSwitchEnum.SceneStutas.LockCanGet
	end

	return MainSceneSwitchEnum.SceneStutas.Lock
end

function MainSceneSwitchModel.canJump(itemId)
	local sourceTables = MainSceneSwitchConfig.instance:getItemSource(itemId)

	for i, sourceTable in ipairs(sourceTables) do
		local cantJumpTips, toastParamList = MainSceneSwitchModel._getCantJump(sourceTable)

		if not cantJumpTips then
			return true
		end
	end

	return false
end

function MainSceneSwitchModel._getCantJump(sourceTable)
	local open = JumpController.instance:isJumpOpen(sourceTable.sourceId)
	local cantJumpTips, toastParamList
	local jumpConfig = JumpConfig.instance:getJumpConfig(sourceTable.sourceId)

	if not open then
		cantJumpTips, toastParamList = OpenHelper.getToastIdAndParam(jumpConfig.openId)
	else
		cantJumpTips, toastParamList = JumpController.instance:cantJump(jumpConfig.param)
	end

	return cantJumpTips, toastParamList
end

MainSceneSwitchModel.instance = MainSceneSwitchModel.New()

return MainSceneSwitchModel
