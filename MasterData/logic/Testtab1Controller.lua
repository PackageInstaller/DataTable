-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/testtab1/controller/Testtab1Controller.lua

module("logic.extensions.testtab1.controller.Testtab1Controller", package.seeall)

local Testtab1Controller = class("Testtab1Controller", BaseListModel)

function Testtab1Controller:ctor()
	Testtab1Controller.super.ctor(self)
end

function Testtab1Controller:onInit()
	Testtab1Controller.super.onInit(self)
end

function Testtab1Controller:onReset()
	Testtab1Controller.super.onReset(self)
end

Testtab1Controller.instance = Testtab1Controller.New()

return Testtab1Controller
