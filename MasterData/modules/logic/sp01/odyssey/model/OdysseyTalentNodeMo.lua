-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyTalentNodeMo.lua

module("modules.logic.sp01.odyssey.model.OdysseyTalentNodeMo", package.seeall)

local OdysseyTalentNodeMo = pureTable("OdysseyTalentNodeMo")

function OdysseyTalentNodeMo:init(id)
	self.id = id
	self.childNodes = {}
end

function OdysseyTalentNodeMo:updateInfo(info)
	self.id = info.id
	self.level = info.level
	self.consume = info.consume
	self.config = OdysseyConfig.instance:getTalentConfig(self.id, self.level)
end

function OdysseyTalentNodeMo:setChildNode(node)
	self.childNodes[node.id] = node
end

function OdysseyTalentNodeMo:isHasChildNode()
	return tabletool.len(self.childNodes) > 0
end

function OdysseyTalentNodeMo:cleanChildNodes()
	self.childNodes = {}
end

return OdysseyTalentNodeMo
