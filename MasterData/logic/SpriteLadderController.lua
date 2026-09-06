-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spriteladder/controller/SpriteLadderController.lua

module("logic.extensions.spriteladder.controller.SpriteLadderController", package.seeall)

local SpriteLadderController = class("SpriteLadderController", BaseController)

function SpriteLadderController:onInit()
	return
end

SpriteLadderController.instance = SpriteLadderController.New()

return SpriteLadderController
