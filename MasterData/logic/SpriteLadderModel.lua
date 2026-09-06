-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spriteladder/model/SpriteLadderModel.lua

module("logic.extensions.spriteladder.model.SpriteLadderModel", package.seeall)

local SpriteLadderModel = class("SpriteLadderModel", BaseModel)

function SpriteLadderModel:ctor()
	SpriteLadderModel.super.ctor(self)
	self:onReset()
end

function SpriteLadderModel:onReset()
	self._petStairInfo = {}
end

function SpriteLadderModel:setPetStairGetInfoRes(msg)
	self._petStairInfo = {}
	self._petStairInfo = msg
end

function SpriteLadderModel:getPetStairGetInfoRes()
	return self._petStairInfo
end

SpriteLadderModel.instance = SpriteLadderModel.New()

return SpriteLadderModel
