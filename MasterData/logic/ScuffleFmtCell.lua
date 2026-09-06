-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/buzhen/ScuffleFmtCell.lua

module("logic.extensions.scuffle.view.buzhen.ScuffleFmtCell", package.seeall)

local ScuffleFmtCell = class("ScuffleFmtCell")

function ScuffleFmtCell:buildUI(go)
	self._go = go
	self._itemPet = goutil.findChild(go, "itemPet")
	self._txtName = goutil.findChildTextComponent(go, "txtName")
end

function ScuffleFmtCell:init(index, id)
	self._index = index
	self._id = id

	local bagPetMo = ScuffleModel.instance:createPet(id)
	local proxy = MaterialMgr.setCellByMo(bagPetMo, self._itemPet)

	proxy.binder:setAutoTips(false)
	proxy.binder:setCallBack(function()
		printInfo("test !!!")
		CommonTipsMgr.instance:showPetTips(bagPetMo)
	end)

	self._txtName.text = bagPetMo:getName()
end

function ScuffleFmtCell:onReset()
	MaterialMgr.resetAll(self._itemPet)
end

return ScuffleFmtCell
