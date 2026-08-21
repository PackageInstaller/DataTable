-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/player/controller/PlayerCreateController.lua

module("logic.extensions.player.controller.PlayerCreateController", package.seeall)

local M = class("PlayerCreateController", BaseController)
local NameState = CommEnum.PlayerNameCreateState
local maxCount = 14

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self._isCreated = false
	self._waiteForRes = false
end

function M:onReset()
	self._isCreated = false
	self._waiteForRes = false
end

function M:onLateInit()
	local storyIds = ConstConfig.instance:getNumValuesByKey("CreatePlayerStoryFlag")

	self._createPlayerPreStoryId = storyIds[1]
	self._createPlayerNextStoryId = storyIds[2]
end

function M:handleToCreatePlayer(storyId)
	if storyId == self._createPlayerPreStoryId then
		if PlayerModel.instance:isCreatedPlayer() then
			GlobalDispatcher:dispatchEvent(EventType.PLAYER_CREATED_UI_CLOSED, self._createPlayerNextStoryId)
		else
			ViewMgr.instance:open(ViewName.PlayerCreateMain)
		end
	end
end

function M:isCreatePlayerPlot(storyId)
	return storyId == self._createPlayerPreStoryId
end

function M:handleCreatedPlayer(msg)
	self._isCreated = true

	PlayerModel.instance:setNickName(msg.nickname)
	PlayerCreateModel.instance:recordSetName()
	PlayerModel.instance:setIsCreatedPlayer(true)
	GlobalDispatcher:dispatchEvent(EventType.PLAYER_CREATED)
	PlayerCreateModel.instance:sendCreateRoleInfo()
end

function M:dispatchCreateClosedEvent()
	GlobalDispatcher:dispatchEvent(EventType.PLAYER_CREATED_UI_CLOSED, self._createPlayerNextStoryId)
end

function M:getNameCountLimit(msg)
	return maxCount
end

function M:checkNameState(editName)
	local state = NameState.Normal
	local defaultName = PlayerCreateModel.instance:getDefaultName()

	if string.nilorempty(editName) then
		editName = defaultName
		state = NameState.Default
	elseif StringUtil.filterSpecialStr(editName) then
		FloatWordMgr.instance:show(lang("tip_name_error_1"))

		state = NameState.Special
	elseif editName == "" or string.gsub(editName, "^%s*(.-)%s*$", "%1") == "" then
		FloatWordMgr.instance:show(lang("tip_name_error"))

		state = NameState.Space
	elseif StringUtil.getStringLength(editName) > maxCount then
		FloatWordMgr.instance:show(lang("tip_name_too_long"))

		state = NameState.Long
	end

	return editName, state
end

function M:resetSendState()
	self._waiteForRes = false
end

function M:tryCreatePlayer()
	if self._isCreated then
		printWarn("已经创角了")

		return
	end

	if not self._waiteForRes and PlayerCreateModel.instance:isAllCompleteTrue() then
		self._waiteForRes = true

		PlayerCreateModel.instance:requestToCreatePlayer()
		PlayerAgent.instance:sendGetPlayerCardInfoRequest(PlayerModel.instance:getId(), true)
	end
end

M.instance = M.New()

return M
