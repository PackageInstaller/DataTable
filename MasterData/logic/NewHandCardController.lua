-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandcard/controller/NewHandCardController.lua

module("logic.extensions.newhandcard.controller.NewHandCardController", package.seeall)

local NewHandCardController = class("NewHandCardController", BaseController)

function NewHandCardController:ctor()
	return
end

function NewHandCardController:onInit()
	return
end

function NewHandCardController:onReset()
	return
end

function NewHandCardController:openView(...)
	if NewHandCardModel.instance:isgetServerMsg() then
		UIStateManager.instance:push(ViewName.NewhandcardView)
	else
		FloatWordMgr.instance:show("数据加载中，请稍后再试")
	end
end

NewHandCardController.instance = NewHandCardController.New()

return NewHandCardController
