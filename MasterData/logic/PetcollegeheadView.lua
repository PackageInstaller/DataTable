-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/view/PetcollegeheadView.lua

module("logic.extensions.petcollege.view.PetcollegeheadView", package.seeall)

local PetcollegeheadView = class("PetcollegeheadView", ViewComponent)

function PetcollegeheadView:ctor()
	PetcollegeheadView.super.ctor(self)
end

function PetcollegeheadView:buildUI()
	PetcollegeheadView.super.buildUI(self)

	self._text = self:getTxt("board/Img_Bg/Text")
	self._container = self:getGo("board")
	self.headGo = self:getGo("board/Img_Bg/Text/icon")
	self._mcTimeGo = self:getGo("mcTime")
	self._finger = self:getGo("finger")
	self.btnOK = self:getBtn("btnOK")

	goutil.setActive(self._mcTimeGo, false)
	goutil.setActive(self._finger, false)

	local tweenScale = self._finger:GetComponentInChildren(UnityTweensType.TweenScale)

	tweenScale:AddLoopingListener(self._onTweenSoundStarted, self)
end

function PetcollegeheadView:_onTweenSoundStarted()
	if not self._lastPlayTime or UnityEngine.Time.time - self._lastPlayTime >= 2 then
		self._lastPlayTime = UnityEngine.Time.time

		AudioPlayerEx.instance:playEffect(30225)
	end
end

function PetcollegeheadView:bindEvents()
	PetcollegeheadView.super.bindEvents(self)
	self.btnOK:AddClickListener(self.close, self)
end

function PetcollegeheadView:unbindEvents()
	PetcollegeheadView.super.unbindEvents(self)
end

function PetcollegeheadView:destroyUI()
	PetcollegeheadView.super.destroyUI(self)
end

function PetcollegeheadView:onEnter()
	PetcollegeheadView.super.onEnter(self)

	local params = self:getOpenParam()
	local npcIdx = params[2]

	GameUtil.setUIImageSpriteIdx(self.headGo, npcIdx or 0)

	local cid, sid = PetCollegeModel.instance:getCurrChallengeAndStageId()
	local cfg = PetCollegeConfig.instance:getGuideCfg(cid, sid)

	if not cfg.pos then
		GameUtil.setAnchoredPos(self._container, cfg.pos[1], cfg.pos[2])

		self._text.text = params[1] or "无"
	end
end

function PetcollegeheadView:onEnterFinished()
	PetcollegeheadView.super.onEnterFinished(self)
end

function PetcollegeheadView:onExit()
	self._lastPlayTime = nil

	PetcollegeheadView.super.onExit(self)
	BattleFacade.instance:setBattlePause(false)
end

function PetcollegeheadView:onExitFinished()
	PetcollegeheadView.super.onExitFinished(self)
end

return PetcollegeheadView
