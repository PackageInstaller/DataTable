-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/view/DragonLordEffectView.lua

module("logic.extensions.dragonlords.view.DragonLordEffectView", package.seeall)

local DragonLordEffectView = class("DragonLordEffectView", ViewComponent)

function DragonLordEffectView:buildUI()
	DragonLordEffectView.super.buildUI(self)

	self._camera = self:getGo("Camera")
	self._btnPass = self:getBtn("rightTop/passNode")
end

function DragonLordEffectView:bindEvents()
	self._btnPass:AddClickListener(self._onClickPass, self)
end

function DragonLordEffectView:unbindEvents()
	self._btnPass:RemoveClickListener()
end

function DragonLordEffectView:onEnter()
	self._isEffLoaded = nil
	self._drawTimes = self:getFirstParam()
	self._effConfig = DragonLordsController.drawEffectsConfig
	self._drawEff = UIEffectManager.instance:playEffectBrief(self, self._effConfig.effectPath, self.mainGO, false, self._onDrawEffLoaded, self)

	self._drawEff:setParent(nil)
	self._drawEff:setLocalPos(0, 0, 0)
	self._drawEff:setScale(1)
	self._drawEff:setLayer(SceneLayer.SkillEffects_Value)

	self._drawEff.finishHandler = self._onEffectPlayFinished
	self._drawEff.finishHandlerTarget = self

	self._drawEff:setEffTime(self._effConfig.effectTime)

	self._changeSetId = DrogonLordsModel.instance:getChangeSetId()
	self._itemsData = DrogonLordsModel.instance:getLastDrawItems()
	self._qualities = DrogonLordsModel.instance:getLastDrawQuas()

	self._camera.transform:SetParent(nil)
	Framework.TransformUtil.SetPos(self._camera.transform, 0, 1, -10)
end

function DragonLordEffectView:onExit()
	self._camera.transform:SetParent(self.mainGO.transform)

	if self._qualitiesEff then
		for i = 1, #self._qualitiesEff do
			UIEffectManager.instance:stopEffect(self._qualitiesEff[i])
		end

		self._qualitiesEff = nil
	end

	UIEffectManager.instance:stopEffect(self._drawEff)

	self._drawEff = nil
	self._changeSetId = nil
	self._itemsData = nil
	self._qualities = nil
	self._isEffLoaded = nil
	self._equipNodes = nil
	self._effConfig = nil

	self:_stopDrawSound()
end

function DragonLordEffectView:_onDrawEffLoaded(eff)
	self._isEffLoaded = true

	local effGo = eff.effGo

	self:_playDrawSound()

	if effGo then
		self._equipNodes = {}

		local effNode = goutil.findChild(effGo, self._effConfig.effNodes)

		for i = 1, 10 do
			self._equipNodes[i] = goutil.findChild(effNode, "kapai" .. i)
		end
	end

	if not self._equipNodes or not self._qualities then
		return
	end

	for i = 1, #self._qualities do
		if self._equipNodes[i] then
			local qualityEffPath = DragonLordsController.EquipEffsByQuality[self._qualities[i]]

			if not string.nilorempty(qualityEffPath) then
				local qualityEff = UIEffectManager.instance:playEffectBrief(self, qualityEffPath, self.mainGO, true)

				qualityEff:setParent(self._equipNodes[i].transform)
				qualityEff:setLocalPos(0, 0, 0)
				qualityEff:setScale(1)
				qualityEff:setLayer(SceneLayer.SkillEffects_Value)

				self._qualitiesEff = self._qualitiesEff or {}

				table.insert(self._qualitiesEff, qualityEff)
			end
		end
	end
end

function DragonLordEffectView:_playDrawSound()
	self._fmodEvtInstance = AudioPlayerEx.instance:playEffect(self._effConfig.soundId)

	if AudioPlayerEx.isInitialized then
		AudioVoicePlayer.instance:stopVoice(true, true)

		self._musicVolume = AudioPlayerEx.instance:getMusicVolume()

		AudioPlayerEx.instance:setMusicVolume(0)
	end
end

function DragonLordEffectView:_stopDrawSound()
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

function DragonLordEffectView:_onEffectPlayFinished(eff)
	if not self._isEffLoaded or not self._drawEff then
		return
	end

	local itemData = self._itemsData
	local changeSetId = self._changeSetId

	self:close()

	if itemData and #itemData > 0 then
		UIStateManager.instance:push(ViewName.DragonBallView, function()
			MaterialController.instance:showChangeSetItemMo(itemData, changeSetId)
		end)
	end
end

function DragonLordEffectView:_onClickPass()
	self:_onEffectPlayFinished()
end

return DragonLordEffectView
