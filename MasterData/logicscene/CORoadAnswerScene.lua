-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/impl/CORoadAnswerScene.lua

module("logicscene.scene.impl.CORoadAnswerScene", package.seeall)

local CORoadAnswerScene = class("CORoadAnswerScene", AnswerScene)

function CORoadAnswerScene:getDefaultView()
	return ViewName.CORoadAnswerSceneView
end

function CORoadAnswerScene:onExit()
	CORoadAnswerScene.super.onExit(self)
	UIStateManager.instance:popByName(self:getDefaultView())
	UIJumper.instance:pushOneStack(ViewName.CORoadMainView, true)
	UIJumper.instance:pushOneStack(ViewName.CORoadAnswerMainView, true)
	UIJumper.instance:pushOneStack(ViewName.CORoadAnswerResultView, true)
end

return CORoadAnswerScene
