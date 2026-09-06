-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerlottery/view/SummerLotteryEffectView.lua

module("logic.extensions.summerlottery.view.SummerLotteryEffectView", package.seeall)

local SummerLotteryEffectView = class("SummerLotteryEffectView", ViewComponent)

function SummerLotteryEffectView:buildUI()
	SummerLotteryEffectView.super.buildUI(self)

	self._btnPass = self:getBtn("pass")
	self._bg = self:getGo("bg")
	self._container = self:getGo("container")
end

function SummerLotteryEffectView:bindEvents()
	self._btnPass:AddClickListener(self._onClickPass, self)
end

function SummerLotteryEffectView:unbindEvents()
	self._btnPass:RemoveClickListener()
end

function SummerLotteryEffectView:onEnter()
	WaitingView.instance:show()

	self._hudRoot = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)

	if self._hudRoot then
		self._hudRoot.gameObject:SetActive(false)
	end

	self._isEffLoaded = nil
	self._params = self:getFirstParam() or {}
	self._drawTimes = self:_getParam("drawTimes", 0)
	self._qualities = self:_getParam("qualities", {})

	self:_playFirstEffect()
end

function SummerLotteryEffectView:_playFirstEffect()
	local _tongyongEffectPath = SummerLotteryConfig.ChouKaFirstEffect

	self._tongyongEffect = UIEffectManager.instance:playEffect(self, _tongyongEffectPath, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
		WaitingView.instance:hide()
	end, function(finishHandlerTarget, eff)
		WaitingView.instance:hide()
		self._tongyongEffect:setLayer(SceneLayer.SkillEffects_Value)
		settimer(0.6, self._waitFirstEffect, self, false)
	end)
end

function SummerLotteryEffectView:_waitFirstEffect()
	removetimer(self._waitFirstEffect, self)

	local effectPath = self:_getParam("effectPath", SummerLotteryConfig.DefaultLuoXuanEffect)
	local effectTime = self:_getParam("effectTime", 4.6)

	self._drawEff = UIEffectManager.instance:playEffect(self, effectPath, nil, 0, 0, false, nil, self._onEffectPlayFinished, self._onDrawEffLoaded, self)

	self._drawEff:setParent(nil)
	self._drawEff:setLocalPos(0, 0, 0)
	self._drawEff:setScale(1)
	self._drawEff:setLayer(SceneLayer.SkillEffects_II_Value)
	self._drawEff:setEffTime(effectTime)
end

function SummerLotteryEffectView:onExit()
	removetimer(self._waitFirstEffect, self)
	self:_destroyTongYongEffectTimer()

	if self._hudRoot then
		self._hudRoot.gameObject:SetActive(true)

		self._hudRoot = nil
	end

	if self._qualitiesEff then
		for i = 1, #self._qualitiesEff do
			goutil.destroy(self._qualitiesEff[i].gameObject)
		end

		self._qualitiesEff = nil
	end

	if self._tuoweisEff then
		for i = 1, #self._tuoweisEff do
			goutil.destroy(self._tuoweisEff[i].gameObject)
		end

		self._tuoweisEff = nil
	end

	UIEffectManager.instance:stopEffect(self._drawEff)

	self._drawEff = nil
	self._qualities = nil
	self._isEffLoaded = nil
	self._equipNodes = nil

	self:_stopDrawSound()
end

function SummerLotteryEffectView:_destroyTongYongEffectTimer()
	self:_destroyTongYongEffect()
	removetimer(self._destroyTongYongEffectTimer, self)
end

function SummerLotteryEffectView:_destroyTongYongEffect()
	if self._tongyongEffect then
		UIEffectManager.instance:stopEffect(self._tongyongEffect)

		self._tongyongEffect = nil
	end
end

function SummerLotteryEffectView:_getParam(key, defaultValue)
	if self._params[key] ~= nil then
		return self._params[key]
	end

	return defaultValue
end

function SummerLotteryEffectView:_onDrawEffLoaded(eff)
	self._isEffLoaded = true

	local effGo = eff.effGo

	self:_playDrawSound()

	if effGo then
		self._equipNodes = {}

		local effNodeUrl = self:_getParam("effectNodes", "shichou_camera_anim/shichou_ka/ka%02d")

		for i = 1, 11 do
			self._equipNodes[i] = goutil.findChild(effGo, string.format(effNodeUrl, i))
		end
	end

	if not self._equipNodes or not self._qualities then
		return
	end

	local chouKaQualityUrls = self:_getParam("chouKaQualityUrls", SummerLotteryConfig.ChouKaQualityUrls)
	local tuoweiQualityUrls = self:_getParam("tuoweiQualityUrls", SummerLotteryConfig.TuoWeiQualityUrls)

	self._qualitiesEff = {}
	self._tuoweisEff = {}

	local sortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self.mainGO)
	local effectMgr = UIEffectManager.instance

	for i = 1, #self._qualities do
		local quality = self._qualities[i]

		if self._equipNodes[i] then
			local url = chouKaQualityUrls[quality]

			if not string.nilorempty(url) then
				url = effectMgr:getEffectPath(url)

				local parent = goutil.findChild(self._equipNodes[i], tostring(i))
				local qualityEffTemplate = self._viewPresentor._tempResLoader:getResource(url):GetMainAsset()
				local qualityEff = goutil.clone(qualityEffTemplate)

				goutil.setActive(qualityEff, true)
				qualityEff.transform:SetParent(parent.transform)
				Framework.TransformUtil.SetLocalScale(qualityEff.transform, 1, 1, 1)
				Framework.TransformUtil.SetLocalPos(qualityEff.transform, 0, 0, -1)
				Framework.TransformUtil.SetLocalRotation(qualityEff.transform, 0, 0, 0)
				Framework.GameObjectUtil.SetLayerRecursively(qualityEff, SceneLayer.SkillEffects_II_Value)
				GoUtil.SetSortingOrder(qualityEff, sortingOrder - 20)
				table.insert(self._qualitiesEff, qualityEff)
			end

			url = tuoweiQualityUrls[quality]

			if not string.nilorempty(tuoweiQualityUrls[quality]) then
				url = effectMgr:getEffectPath(url)

				local parent = goutil.findChild(self._equipNodes[i], string.format("%d_tuowei", i))
				local tuoweiEffTemplate = self._viewPresentor._tempResLoader:getResource(url):GetMainAsset()
				local tuoweiEff = goutil.clone(tuoweiEffTemplate)

				goutil.setActive(tuoweiEff, true)
				tuoweiEff.transform:SetParent(parent.transform)
				Framework.TransformUtil.SetLocalScale(tuoweiEff.transform, 1, 1, 1)
				Framework.TransformUtil.SetLocalPos(tuoweiEff.transform, 0, 0, 1)
				Framework.TransformUtil.SetLocalRotation(tuoweiEff.transform, 0, 0, 0)
				Framework.GameObjectUtil.SetLayerRecursively(tuoweiEff, SceneLayer.SkillEffects_II_Value)
				GoUtil.SetSortingOrder(tuoweiEff, sortingOrder - 20)
				table.insert(self._tuoweisEff, tuoweiEff)
			end
		end
	end

	WaitingView.instance:hide()
	settimer(1, self._destroyTongYongEffectTimer, self, false)
end

function SummerLotteryEffectView:_playDrawSound()
	local soundId = self:_getParam("soundId", 30229)

	self._fmodEvtInstance = AudioPlayerEx.instance:playEffect(soundId)

	if AudioPlayerEx.isInitialized then
		AudioVoicePlayer.instance:stopVoice(true, true)

		self._musicVolume = AudioPlayerEx.instance:getMusicVolume()

		AudioPlayerEx.instance:setMusicVolume(0)
	end
end

function SummerLotteryEffectView:_stopDrawSound()
	if self._musicVolume then
		if self._musicVolume ~= 0 then
			AudioPlayerEx.instance:setMusicVolume(self._musicVolume)
		end

		self._musicVolume = nil
	end

	if self._fmodEvtInstance then
		AudioPlayerEx.instance:stopEvent(self._fmodEvtInstance)

		self._fmodEvtInstance = nil
	end
end

function SummerLotteryEffectView:_onEffectPlayFinished(eff)
	WaitingView.instance:hide()

	if not self._isEffLoaded or not self._drawEff then
		return
	end

	local onEffectPlayFinishedFunc = self:_getParam("onEffectPlayFinishedFunc")
	local thisArg = self:_getParam("thisArg")

	if onEffectPlayFinishedFunc then
		onEffectPlayFinishedFunc(thisArg)
	end

	self:close()
end

function SummerLotteryEffectView:_onClickPass()
	self:_onEffectPlayFinished()
end

return SummerLotteryEffectView
