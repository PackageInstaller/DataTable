-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/answerscene/SceneCompAnswerSceneTrigger.lua

module("logicscene.scene.component.answerscene.SceneCompAnswerSceneTrigger", package.seeall)

local SceneCompAnswerSceneTrigger = class("SceneCompAnswerSceneTrigger", SceneComponentBase)
local triggerIds = {
	100001,
	100002,
	100003,
	100004
}
local triggersConfigs = {
	default = {
		[100001] = {
			rot = 297,
			y = 9.86,
			scaleX = 2.5,
			x = 11.02,
			scaleY = 3.5
		},
		[100002] = {
			rot = 297,
			y = 7.22,
			scaleX = 2,
			x = 15.29,
			scaleY = 3.5
		},
		[100003] = {
			rot = 64,
			y = 9.57,
			scaleX = 2,
			x = 15.27,
			scaleY = 3.5
		},
		[100004] = {
			rot = 64,
			y = 7.22,
			scaleX = 2,
			x = 11.26,
			scaleY = 3.5
		}
	},
	wanshengjie = {
		[100001] = {
			rot = 26.858,
			y = 6.83,
			scaleX = 3.24,
			x = 7.91,
			scaleY = 1.59
		},
		[100002] = {
			rot = 26.858,
			y = 4.77,
			scaleX = 3.24,
			x = 10.52,
			scaleY = 1.59
		},
		[100003] = {
			rot = 332.53,
			y = 6.83,
			scaleX = 3.24,
			x = 10.61,
			scaleY = 1.59
		},
		[100004] = {
			rot = 332.53,
			y = 4.74,
			scaleX = 3.24,
			x = 8.01,
			scaleY = 1.59
		}
	}
}
local signErrPos = {
	default = {
		{
			x = 11.36,
			y = 9.04
		},
		{
			x = 15.08,
			y = 7.09
		},
		{
			x = 15.14,
			y = 9.05
		},
		{
			x = 11.22,
			y = 7
		}
	},
	wanshengjie = {
		{
			x = 7.86,
			y = 6.23
		},
		{
			x = 10.7,
			y = 4.86
		},
		{
			x = 10.61,
			y = 6.29
		},
		{
			x = 7.87,
			y = 4.91
		}
	}
}
local signErrScale = {
	default = 0.3,
	wanshengjie = 0.2
}
local effElementIds = {
	1001,
	1002,
	1003,
	1004
}
local tileElementIds = {
	10001,
	10002,
	10003,
	10004
}
local airwallElementIds = {
	2001,
	2002,
	2003,
	2004
}

function SceneCompAnswerSceneTrigger:_getCurrFestival()
	return (self._scene:_getCurrFestival())
end

function SceneCompAnswerSceneTrigger:onEnterSceneFinished()
	self:_createTriggers()

	local festival = self:_getCurrFestival()

	if not signErrScale[festival] then
		local helpCo = AnswerSceneConfig.instance:getHelpCo(AnswerSceneMO.HelpType_ExceptError)
		local errSignRes = rescache:GetResourceNoLoadIfNotExists(helpCo.effPath .. ".prefab")

		if errSignRes then
			local signAsset = errSignRes:GetMainAsset()

			if signAsset then
				self._errorSignGo = goutil.clone(signAsset, "errSign")

				self._errorSignGo:SetActive(false)
				GoUtil.SetSortingOrder(self._errorSignGo, -1499)
				Framework.TransformUtil.SetLocalScale(self._errorSignGo.transform, signErrScale[festival], signErrScale[festival], signErrScale[festival])
			end
		end
	end
end

function SceneCompAnswerSceneTrigger:onExitScene()
	if self._triggers then
		for i = 1, #self._triggers do
			self._triggers[i]:clear()
		end
	end

	for i = 1, #triggerIds do
		self._scene.stage.wholeScene:RemoveTrigger(self._scene:getSceneId(), triggerIds[i])
	end

	if self._errorSignGo then
		goutil.destroy(self._errorSignGo)

		self._errorSignGo = nil
	end
end

function SceneCompAnswerSceneTrigger:update()
	if self._triggers then
		for i = 1, #self._triggers do
			self._triggers[i]:update()
		end
	end
end

function SceneCompAnswerSceneTrigger:_createTriggers()
	self._triggers = {}

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()
	local festival = self:_getCurrFestival()

	for i = 1, #triggerIds do
		local triggerCfg = triggersConfigs[festival][triggerIds[i]]
		local trigger = RotateRectTrigger.New(triggerIds[i])
		local rect = UnityEngine.Rect.New()

		rect.size = Vector2.New(triggerCfg.scaleX, triggerCfg.scaleY)
		rect.center = Vector2.New(triggerCfg.x, triggerCfg.y)

		trigger:calculate(rect, triggerCfg.rot)
		trigger:setTransform(mainPlayer.go.transform)
		trigger:setListener(self.onTriggerEnter, self)

		self._triggers[i] = trigger
	end
end

function SceneCompAnswerSceneTrigger:onTriggerEnter(triggerId, enter)
	if not enter then
		GlobalDispatcher:dispatch(GlobalNotify.OnAnswerSelected, 0)
	else
		for i = 1, #triggerIds do
			if triggerIds[i] == triggerId then
				GlobalDispatcher:dispatch(GlobalNotify.OnAnswerSelected, i)

				return
			end
		end

		GlobalDispatcher:dispatch(GlobalNotify.OnAnswerSelected, 0)
	end
end

function SceneCompAnswerSceneTrigger:onAnswerAskForHelp(index)
	if not self._errorSignGo then
		return
	end

	local festival = self:_getCurrFestival()
	local pos = signErrPos[festival][index]

	if not pos then
		return
	end

	self._errorSignGo:SetActive(true)
	Framework.TransformUtil.SetPos(self._errorSignGo.transform, pos.x, pos.y, pos.z or 0)
end

function SceneCompAnswerSceneTrigger:onStartNewQuestion()
	if self._errorSignGo then
		self._errorSignGo:SetActive(false)
	end

	if AnswerSceneModel.instance:isDoingQuestion() then
		local answerSceneMo = AnswerSceneModel.instance:getData()
		local answers = answerSceneMo.questionConfig.answers

		for i = 1, #answers do
			self._scene.stage.wholeScene:ShowElement(effElementIds[i], true)
			self._scene.stage.wholeScene:ShowElement(tileElementIds[i], true)
			self._scene.stage.wholeScene:ShowElement(airwallElementIds[i], false)
		end

		for i = #answers + 1, #effElementIds do
			self._scene.stage.wholeScene:ShowElement(effElementIds[i], false)
			self._scene.stage.wholeScene:ShowElement(tileElementIds[i], false)
			self._scene.stage.wholeScene:ShowElement(airwallElementIds[i], true)
		end
	else
		for i = 1, #effElementIds do
			self._scene.stage.wholeScene:ShowElement(effElementIds[i], false)
			self._scene.stage.wholeScene:ShowElement(tileElementIds[i], false)
			self._scene.stage.wholeScene:ShowElement(airwallElementIds[i], true)
		end
	end

	if self._triggers then
		for i = 1, #self._triggers do
			self._triggers[i]:reserState()
		end
	end
end

function SceneCompAnswerSceneTrigger:onElementCreate(elementId, pos)
	return
end

return SceneCompAnswerSceneTrigger
