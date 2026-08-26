-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionEnterScene.lua

module("modules.logic.guide.controller.action.impl.GuideActionEnterScene", package.seeall)

local GuideActionEnterScene = class("GuideActionEnterScene", BaseGuideAction)

function GuideActionEnterScene:onStart(context)
	GuideActionEnterScene.super.onStart(self, context)

	local temp = string.split(self.actionParam, "#")

	self._sceneType = SceneType[temp[1]]

	if VirtualSummonScene.instance:isOpen() and self._sceneType ~= SceneType.Summon then
		VirtualSummonScene.instance:close(true)
	end

	if self._sceneType == SceneType.Summon then
		SummonController.instance:enterSummonScene()
	else
		self._sceneId = tonumber(temp[2])
		self._sceneLevel = tonumber(temp[3])

		if self._sceneLevel then
			GameSceneMgr.instance:startScene(self._sceneType, self._sceneId, self._sceneLevel)
		else
			GameSceneMgr.instance:startSceneDefaultLevel(self._sceneType, self._sceneId)
		end
	end

	self:onDone(true)
end

return GuideActionEnterScene
