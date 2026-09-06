-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tabbg/model/TabbgModel.lua

module("logic.extensions.tabbg.model.Tabbgmodel", package.seeall)

local Tabbgmodel = class("Tabbgmodel", BaseListModel)

function Tabbgmodel:ctor()
	Tabbgmodel.super.ctor(self)
end

function Tabbgmodel:onInit()
	Tabbgmodel.super.onInit(self)
end

function Tabbgmodel:onReset()
	Tabbgmodel.super.onReset(self)
end

Tabbgmodel.instance = Tabbgmodel.New()

return Tabbgmodel
