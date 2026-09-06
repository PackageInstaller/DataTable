-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcopen/facade/FuncOpenFacade.lua

module("logic.extensions.funcopen.facade.FuncOpenModel", package.seeall)

local FuncOpenFacade = class("FuncOpenFacade", BaseModel)

function FuncOpenFacade:ctor()
	return
end

function FuncOpenFacade:isFuncUIOpen(viewName, ingoreTips)
	return true
end

FuncOpenFacade.instance = FuncOpenFacade.New()

return FuncOpenFacade
