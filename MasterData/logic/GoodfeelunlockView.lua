-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelunlockView.lua

module("logic.extensions.goodfeel.view.GoodfeelunlockView", package.seeall)

local GoodfeelunlockView = class("GoodfeelunlockView", ViewComponent)

function GoodfeelunlockView:ctor()
	GoodfeelunlockView.super.ctor(self)
end

function GoodfeelunlockView:buildUI()
	GoodfeelunlockView.super.buildUI(self)

	self._contentText = goutil.findChildTextComponent(self.mainGO, "contentText")
end

function GoodfeelunlockView:bindEvents()
	GoodfeelunlockView.super.bindEvents(self)
end

function GoodfeelunlockView:unbindEvents()
	GoodfeelunlockView.super.unbindEvents(self)
end

function GoodfeelunlockView:destroyUI()
	GoodfeelunlockView.super.destroyUI(self)
end

function GoodfeelunlockView:onEnter()
	GoodfeelunlockView.super.onEnter(self)

	local unlockData = self:getFirstParam()
	local raceId = unlockData.raceId
	local oldLv = unlockData.lv
	local currLv = GoodFeelModel.instance:getPetGoodFeelLv(raceId)
	local cfg = HandbookConfig.instance:getPetDetailsCfgById(raceId)
	local vCfg = GoodFeelConfig.instance:getUnlockVoiceCfgs(raceId)
	local sCfg = GoodFeelConfig.instance:getStroyCfgsByPlantId(cfg.storyPlan)
	local cvCfg = CharacterConfig.instance:getPetCvCfg(raceId)
	local unlockStoryStr = ""
	local unlockVoiceStr = ""

	for k, v in ipairs(vCfg) do
		if oldLv < v.goodfeelUnlockLv and cvCfg[k] and currLv >= v.goodfeelUnlockLv then
			unlockVoiceStr = unlockVoiceStr .. "解锁 语音-" .. cvCfg[k].usageScenarios .. "\n"
		end
	end

	if sCfg then
		for k, v in pairs(sCfg) do
			if oldLv < v.unlockLv and currLv >= v.unlockLv then
				unlockStoryStr = unlockStoryStr .. "解锁 剧情-" .. v.name .. "\n"
			end
		end
	end

	local hasStory = false
	local hasVoic = false
	local finalStr = ""

	unlockVoiceStr = string.trim(unlockVoiceStr)
	unlockStoryStr = string.rtrim(unlockStoryStr)

	if not string.nilorempty(unlockVoiceStr) then
		hasVoic = true
		finalStr = unlockVoiceStr
	end

	if not string.nilorempty(unlockStoryStr) then
		hasStory = true
		finalStr = finalStr .. (hasVoic and "\n" or "") .. unlockStoryStr
	end

	if hasVoic or hasStory then
		self._contentText.text = finalStr
	else
		local cfg = CharacterConfig.instance:getPetCo(raceId)

		self._contentText.text = string.format("你与【%s】的感情羁绊又加深了！继续努力吧！", cfg.name)
	end
end

function GoodfeelunlockView:onEnterFinished()
	GoodfeelunlockView.super.onEnterFinished(self)
end

function GoodfeelunlockView:onExit()
	GoodfeelunlockView.super.onExit(self)
end

function GoodfeelunlockView:onExitFinished()
	GoodfeelunlockView.super.onExitFinished(self)
end

return GoodfeelunlockView
