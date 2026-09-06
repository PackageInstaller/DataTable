-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideHeadView.lua

module("logic.extensions.guide.view.GuideHeadView", package.seeall)

local GuideHeadView = class("GuideHeadView", GuideUIObjectBase)

function GuideHeadView:ctor()
	GuideHeadView.super.ctor(self)
end

function GuideHeadView:onExit()
	GuideHeadView.super.onExit(self)

	self._lastPlayTime = nil
	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	if self._fingerEff then
		UIEffectManager.instance:stopEffect(self._fingerEff)

		self._fingerEff = nil
	end

	removetimer(self._onCountTime, self)
end

function GuideHeadView:onEnterFinished()
	GuideHeadView.super.onEnterFinished(self)

	self._count = 0

	self:_onDelay()

	local params = self._currGuide:getJsonParams()

	GameUtil.setUIImageSpriteIdx(self.headGo, params.npcIdx or 0)
end

function GuideHeadView:addFinger()
	local name = "common/fx_ui_zhiyin_quan_03.prefab"
	local light = UIEffectManager.instance:playEffect(self, name, self._finger, 0, 0, true, nil, function()
		return
	end, function(ta, eff)
		return
	end)

	light:setParent(self.mainGO.transform)
	light:setScale(1)

	self._fingerEff = light
end

function GuideHeadView:_onDelay()
	GameUtil.SetActive(self.mcTime, false)
	GameUtil.SetActive(self.btnOK, false)
	self:_onDisableVerticalLayoutGroup(false)
	self._finger:SetActive(false)

	local center = Vector3.New(100, 100, 0)
	local txt = self._currGuide:getDialogue()

	self._text.text = txt

	GameUtil.SetActive(self._container, true)

	if txt == "" then
		GameUtil.SetActive(self._container, false)
	end

	local _endPos = self._currGuide:getEndpos()

	if not self._currGuide:getIsIcon() then
		GameUtil.setAnchoredPos(self._container, _endPos.x, _endPos.y)
	end

	if self._currGuide:getIsMask() then
		self._mask:SetActive(true)
	else
		self._mask:SetActive(false)
	end

	if self._currGuide:getUIWidget() then
		self:_handleGuideWIdgrt()

		if self._saveWidget then
			goutil.addChildToParent(self._saveWidget, self._attach)
		else
			GameUtil.SetActive(self.btnOK, true)
		end

		if self._currGuide:getIsShow() then
			if self._saveWidget then
				self._finger:SetActive(true)

				local pos = GameUtil.getPos(self._saveWidget)

				GameUtil.setPos(self._finger, pos.x, pos.y, pos.z)

				local rotation = self._currGuide:getRotation()

				if rotation then
					Framework.TransformUtil.SetLocalRotation(self._finger.gameObject.transform, rotation[1], rotation[2], rotation[3])
				else
					Framework.TransformUtil.SetLocalRotation(self._finger.gameObject.transform, 0, 0, 0)
				end

				self:addFinger()
			end
		else
			self._finger:SetActive(false)
		end
	else
		GameUtil.SetActive(self.btnOK, true)
	end

	self._count = 0

	removetimer(self._onCountTime, self)

	if self._currGuide:autoFinishTime() and self._currGuide:autoFinishTime() > 0 then
		self._count = self._currGuide:autoFinishTime()

		settimer(1, self._onCountTime, self)
	end

	self.mainGO:GetComponent("Image").enabled = not not self._currGuide:getRaycast()

	self._Frame.gameObject:SetActive(false)
end

function GuideHeadView:_onCountTime()
	self._count = checknumber(self._count) - 1
	self._count = math.max(self._count, 0)
	self._CountTime.text = self._count .. lang("tip_second")

	if self._count <= 0 then
		removetimer(self._onCountTime, self)
		GameUtil.SetActive(self.mcTime, false)
		GuideController.instance:_onGuideAutoFinish()
	end
end

function GuideHeadView:_onEffectLoaded()
	return
end

function GuideHeadView:buildUI()
	GuideHeadView.super.buildUI(self)

	self._text = self:getTxt("board/Img_Bg/Text")
	self._container = self:getGo("board")
	self.headGo = self:getGo("board/Img_Bg/Text/icon")
	self._mask = self:getGo("mask")
	self._finger = self:getGo("finger")
	self._attach = self:getGo("attach")
	self._Frame = self:getGo("Frame")
	self.mcTime = self:getGo("mcTime")
	self._CountTime = self:getTxt("mcTime/CountTime")
	self.btnOK = self:getBtn("btnOK")

	self.btnOK:AddClickListener(function()
		if self._count <= 0 then
			GameUtil.SetActive(self.btnOK, false)
			GameUtil.SetActive(self._mask, false)
			GuideController.instance:_onGuideAutoFinish()
		else
			self._count = 0

			self:_onCountTime()
		end
	end)

	local tweenScale = self._finger:GetComponentInChildren(UnityTweensType.TweenScale)

	tweenScale:AddLoopingListener(self._onTweenSoundStarted, self)
end

function GuideHeadView:_onTweenSoundStarted()
	if not self._lastPlayTime or UnityEngine.Time.time - self._lastPlayTime >= 2 then
		self._lastPlayTime = UnityEngine.Time.time

		AudioPlayerEx.instance:playEffect(30225)
	end
end

return GuideHeadView
