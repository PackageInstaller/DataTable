-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehalogame/model/DivineHaloGameCellMo.lua

module("logic.extensions.divinehalogame.model.DivineHaloGameCellMo", package.seeall)

local DivineHaloGameCellMo = class("DivineHaloGameCellMo", BaseModel)

function DivineHaloGameCellMo:ctor()
	self.index = 0
	self.width = 0
	self.height = 0
	self.posX = 0
	self.posY = 0
	self.posZ = 0
	self.rotateX = 0
	self.rotateY = 0
	self.rotateZ = 0
	self.cellType = 0
	self.colorType = 0
end

function DivineHaloGameCellMo:setInfo(params)
	self.index = params.index
	self.width = params.width
	self.height = params.height
	self.posX = params.posX
	self.posY = params.posY
	self.posZ = params.posZ
	self.rotateX = params.rotateX
	self.rotateY = params.rotateY
	self.rotateZ = params.rotateZ
	self.cellType = params.cellType
	self.colorType = params.colorType
end

DivineHaloGameCellMo.instance = DivineHaloGameCellMo.New()

return DivineHaloGameCellMo
