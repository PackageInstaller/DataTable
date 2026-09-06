-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/testtab1/model/Testtab1Model.lua

module("logic.extensions.testtab1.model.Testtab1model", package.seeall)

local Testtab1model = class("Testtab1model", BaseListModel)

function Testtab1model:ctor()
	Testtab1model.super.ctor(self)
end

function Testtab1model:onInit()
	Testtab1model.super.onInit(self)
end

function Testtab1model:onReset()
	Testtab1model.super.onReset(self)
end

Testtab1model.instance = Testtab1model.New()

return Testtab1model
