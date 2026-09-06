-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qingguhud/model/QingguHudModel.lua

module("logic.extensions.qingguhud.model.QingguHudModel", package.seeall)

local QingguHudModel = class("QingguHudModel", BaseModel)

function QingguHudModel:ctor()
	return
end

function QingguHudModel:onInit()
	self:onReset()
end

function QingguHudModel:onReset()
	self:_regRedPoint()
end

function QingguHudModel:_regRedPoint()
	RedPointController.instance:regUserOnceRedPoint(RedPointModel.ID_QINGGUHUD_ENTER_EXCHENGE)
end

QingguHudModel.instance = QingguHudModel.New()

return QingguHudModel
