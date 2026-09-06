-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkageintroduction/controller/LinkageController.lua

module("logic.extensions.linkageintroduction.controller.LinkageController", package.seeall)

local LinkageController = class("LinkageController", BaseController)

function LinkageController:onInit()
	self:onReset()
end

function LinkageController:onReset()
	return
end

function LinkageController:isOfficalAndUrl(id)
	local cfg = LinkageConfig.instance:getCfgByTab(1, id)
	local isHaveLink = string.nilorempty(cfg.url)

	return self:isOffical() and not isHaveLink
end

function LinkageController:isOffical()
	return (SDKManager.isOfficial())
end

function LinkageController:lightRedPoint(id, redPointId)
	if self:isOfficalAndUrl(id) then
		RedPointController.instance:regUserOnceRedPoint(redPointId)
	end
end

LinkageController.instance = LinkageController.New()

return LinkageController
