-- chunkname: @modules/logic/versionactivity3_6/warmup/view/V3a6_WarmUp_DialogueViewContainer.lua

module("modules.logic.versionactivity3_6.warmup.view.V3a6_WarmUp_DialogueViewContainer", package.seeall)

local V3a6_WarmUp_DialogueViewContainer = class("V3a6_WarmUp_DialogueViewContainer", Activity125ViewBaseContainer)
local kTabContainerId_NavigateButtonsView = 1
local ti = table.insert
local sf = string.format

function V3a6_WarmUp_DialogueViewContainer:actId()
	return V3a6_WarmUpConfig.instance:actId()
end

function V3a6_WarmUp_DialogueViewContainer:getCutsceneResUrlPrePost()
	local episodeId = self._level
	local resNamePre = string.format("v3a6_warmup_day%s_1", episodeId)
	local resNamePost = string.format("v3a6_warmup_day%s_2", episodeId)
	local resUrlPre = ResUrl.getV3a6WarmUpSingleBg(resNamePre)
	local resUrlPost = ResUrl.getV3a6WarmUpSingleBg(resNamePost)

	return resUrlPre, resUrlPost
end

function V3a6_WarmUp_DialogueViewContainer:buildViews()
	self:resetData(self.viewParam.level)

	self._mainView = V3a6_WarmUp_DialogueView.New()

	return {
		self._mainView,
		TabViewGroup.New(kTabContainerId_NavigateButtonsView, "#go_topleft")
	}
end

function V3a6_WarmUp_DialogueViewContainer:onContainerClose()
	self:_saveAuto(self._bAuto)
	V3a6_WarmUp_DialogueViewContainer.super.onContainerClose(self)
end

function V3a6_WarmUp_DialogueViewContainer:onContainerCloseFinish()
	V3a6_WarmUp_DialogueViewContainer.super.onContainerCloseFinish(self)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_feichi_yure_caption_20200115)

	local episodeId = self._level

	if self._willSetLocalIsPlayed then
		if not self:checkLocalIsPlay(episodeId) then
			self:setLocalIsPlay(episodeId)
		end

		local bPassed, bClaimable, isRecevied = self:getbPassedAndbClaimable()

		if bClaimable then
			Activity125Controller.instance:dispatchEvent(Activity125Event.OnGameFinished, self._level)
		end
	end
end

function V3a6_WarmUp_DialogueViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == kTabContainerId_NavigateButtonsView then
		self._navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigationView
		}
	end
end

function V3a6_WarmUp_DialogueViewContainer:resetData(level)
	self._level = assert(level)
	self._dialogCOList = V3a6_WarmUpConfig.instance:dialogCOList(level)
	self._count = V3a6_WarmUpConfig.instance:getDialogCount(level)
	self._index = 1
	self._bAuto = self:_getSavedAuto()
	self._bFastForwarding = false
	self._willSetLocalIsPlayed = false
end

function V3a6_WarmUp_DialogueViewContainer:curIndex()
	return self._index - 1
end

function V3a6_WarmUp_DialogueViewContainer:count()
	return self._count or 0
end

function V3a6_WarmUp_DialogueViewContainer:curDialogCO()
	return self._dialogCOList[self:curIndex()]
end

function V3a6_WarmUp_DialogueViewContainer:peak()
	return self._dialogCOList[self._index]
end

function V3a6_WarmUp_DialogueViewContainer:pop()
	if self._index > self._count or self._count <= 0 then
		return
	end

	self._index = self._index + 1

	return self._dialogCOList[self._index]
end

function V3a6_WarmUp_DialogueViewContainer:doSkip()
	self._bFastForwarding = true

	local tmpSave = self._bAuto

	self._bAuto = false

	self._mainView:fastForwardToEnd()

	self._bAuto = tmpSave
end

function V3a6_WarmUp_DialogueViewContainer:bFastForwarding()
	return self._bFastForwarding
end

function V3a6_WarmUp_DialogueViewContainer:isAuto()
	if self._bFastForwarding then
		return false
	end

	return self._bAuto
end

function V3a6_WarmUp_DialogueViewContainer:isManually()
	if self._bFastForwarding then
		return false
	end

	return not self:isAuto()
end

function V3a6_WarmUp_DialogueViewContainer:startAuto()
	self._bAuto = true

	self._mainView:onChangedAuto(self._bAuto)
end

function V3a6_WarmUp_DialogueViewContainer:stopAuto()
	self._bAuto = false

	self._mainView:onChangedAuto(self._bAuto)
end

function V3a6_WarmUp_DialogueViewContainer:getbPassedAndbClaimable()
	local episodeId = self._level
	local isRecevied, localIsPlay, isOld, bClaimable = self:getRLOC(episodeId)
	local bPassed = localIsPlay or isRecevied

	return bPassed, bClaimable, isRecevied
end

function V3a6_WarmUp_DialogueViewContainer:markDoneSlient()
	local bPassed, bClaimable, isRecevied = self:getbPassedAndbClaimable()

	if isRecevied then
		return
	end

	self._willSetLocalIsPlayed = true
end

local kEpisode = "V3a6_WarmUp_Dialogue|"

function V3a6_WarmUp_DialogueViewContainer:_getPrefsKey()
	return self:getPrefsKeyPrefix() .. kEpisode
end

function V3a6_WarmUp_DialogueViewContainer:_saveAuto(bAuto)
	if self:_getSavedAuto() == bAuto then
		return
	end

	local key = self:_getPrefsKey()

	self:saveInt(key, bAuto and 1 or 0)
end

function V3a6_WarmUp_DialogueViewContainer:_getSavedAuto()
	local key = self:_getPrefsKey()
	local value = self:getInt(key, 0)

	return value ~= 0
end

function V3a6_WarmUp_DialogueViewContainer:getTipsStr()
	local episodeId = self._level

	return luaLang(string.format("v3a6_warmup_dialogueview_txt_tips%s", episodeId))
end

function V3a6_WarmUp_DialogueViewContainer:getUserClickAudioId()
	local episodeId = self._level

	if episodeId == 1 then
		return AudioEnum.VersionActivity2_1ChessGame.play_ui_molu_monster_awake
	elseif episodeId == 2 then
		return AudioEnum.Role2ChessGame1_3.FireHurt
	elseif episodeId == 3 then
		return AudioEnum.UI.play_ui_role_pieces_open
	elseif episodeId == 4 then
		return AudioEnum.UI.Play_UI_Tipsclose
	elseif episodeId == 5 then
		return AudioEnum.UI.play_ui_youyu_yure_horn_20220218
	else
		return AudioEnum.UI.UI_Common_Click
	end
end

function V3a6_WarmUp_DialogueViewContainer:dump(refStrBuf, depth)
	depth = depth or 0

	local tab = string.rep("\t", depth)
	local episodeId = self._level

	ti(refStrBuf, tab .. sf("episodeId = %s", tostring(episodeId)))
	ti(refStrBuf, tab .. sf("bAuto? = %s", self._bAuto and "true" or "false"))

	local curDialogCO = self:curDialogCO()

	if curDialogCO then
		ti(refStrBuf, tab .. sf("%s(%s/%s): %s", curDialogCO.id, self._index, self._count, curDialogCO.desc))
	else
		ti(refStrBuf, tab .. sf("None DialogCO (%s/%s)", self._index, self._count))
	end
end

return V3a6_WarmUp_DialogueViewContainer
