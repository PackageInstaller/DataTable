-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcv/controller/PetCvController.lua

module("logic.extensions.petcv.controller.PetCvController", package.seeall)

local PetCvController = class("PetCvController", BaseController)

function PetCvController:ctor()
	self:onReset()

	self._isPlayingCv = false
	self._curRaceId = nil
	self._curIndex = nil
	self._curAudioId = nil
end

function PetCvController:onReset()
	PetCvModel.instance:onReset()
end

function PetCvController:setListener(lsn, obj)
	self._cvPlayFinishedListener = lsn
	self._cvPlayFinishedListenerObj = obj
end

function PetCvController:playPetCv(raceId, petCvType, isPlayBubble, pos, isPlayNow)
	if isPlayNow == nil then
		isPlayNow = true
	end

	local curRaceId = self._curRaceId
	local curIndex = self._curIndex
	local word = ""
	local cfg
	local cfgs = CharacterConfig.instance:getPetCvCfg(raceId)

	if cfgs ~= nil then
		local t = {}

		for _, v in pairs(cfgs) do
			if petCvType == GameEnum.PetCvType.Default and v.isDefault == 1 then
				cfg = v

				break
			end

			if curRaceId == v.petId and curIndex == v.index then
				-- block empty
			elseif not self:_isMatchCvType(v, petCvType) then
				-- block empty
			elseif GoodFeelModel.instance:getPetGoodFeelLv(raceId) < checknumber(v.goodfeelUnlockLv) then
				-- block empty
			else
				table.insert(t, v)
			end
		end

		if petCvType == GameEnum.PetCvType.Default and cfg == nil then
			cfg = cfgs[math.random(#cfgs)]
		elseif #t > 0 then
			cfg = t[math.random(#t)]
		end

		if cfg ~= nil then
			if isPlayNow then
				self:_playPetCvByCfg(cfg, isPlayBubble, pos)
			end

			word = cfg.word
		end
	end

	return word, cfg
end

function PetCvController:getIfCvExist(raceId)
	local cfgs = CharacterConfig.instance:getPetCvCfg(raceId)

	if cfgs ~= nil then
		return true
	else
		return false
	end
end

function PetCvController:_playPetCvByIndex(raceId, index, isPlayBubble, pos)
	local cfgs = CharacterConfig.instance:getPetCvCfg(raceId)

	if cfgs ~= nil then
		local cfg = cfgs[index]

		if cfg ~= nil then
			self:_playPetCvByCfg(cfg, isPlayBubble, pos)
		end
	end
end

function PetCvController:_playPetCvByCfg(cfg, isPlayBubble, pos)
	self._isPlayingCv = true
	self._curRaceId = cfg.petId
	self._curIndex = cfg.index
	word = cfg.word

	if isPlayBubble then
		self:_updateBubbleView(cfg.word, pos)
	end

	local audioId = cfg.audioId

	if audioId > 0 then
		AudioPlayerEx.instance:playVoice(audioId, self._onPlayCvFinished, self)

		self._curAudioId = audioId
	end
end

function PetCvController:_isMatchCvType(cfg, cvType)
	if cvType == nil then
		return true
	elseif cvType == GameEnum.PetCvType.Default and cfg.isDefault == 1 then
		return true
	elseif cvType == GameEnum.PetCvType.PetUp and cfg.isPetUp == 1 then
		return true
	elseif cvType == GameEnum.PetCvType.BattleWin and cfg.isBattleWin == 1 then
		return true
	elseif cvType == GameEnum.PetCvType.BattleLose and cfg.isBattleLose == 1 then
		return true
	elseif cvType == GameEnum.PetCvType.Formation and cfg.isFormation == 1 then
		return true
	elseif cvType == GameEnum.PetCvType.BattlePerfect and cfg.isPerfect == 1 then
		return true
	elseif cvType == GameEnum.PetCvType.UseSkill and cfg.isSkill == 1 then
		return true
	elseif cvType == GameEnum.PetCvType.PetIntrod and cfg.isPetIntrod == 1 then
		return true
	else
		return false
	end
end

function PetCvController:_updateBubbleView(word, pos)
	if ViewMgr.instance:isOpen(ViewName.bubble) then
		GlobalDispatcher:dispatch(GlobalNotify.UpdateBubble, word, pos)
	else
		UIStateManager.instance:open(ViewName.bubble, word, pos)
	end
end

function PetCvController:_tweenMusicVolume(isDown)
	return
end

function PetCvController:_onPlayCvFinished()
	ViewMgr.instance:close(ViewName.bubble)

	self._curIndex = nil
	self._curRaceId = nil
	self._isPlayingCv = false

	if self._cvPlayFinishedListener then
		self._cvPlayFinishedListener(self._cvPlayFinishedListenerObj)
	end
end

function PetCvController:turnOffCurCv(notCloseView, resume)
	self._curIndex = nil
	self._curRaceId = nil
	self._isPlayingCv = false

	ViewMgr.instance:close(ViewName.bubble)
	AudioVoicePlayer.instance:stopVoice()
end

PetCvController.instance = PetCvController.New()

return PetCvController
