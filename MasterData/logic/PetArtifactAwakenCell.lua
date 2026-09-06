-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/PetArtifactAwakenCell.lua

module("logic.extensions.recommendfmt.view.PetArtifactAwakenCell", package.seeall)

local PetArtifactAwakenCell = class("PetArtifactAwakenCell")

function PetArtifactAwakenCell:ctor(go)
	self._cellGo = goutil.findChild(go, "artifact/cell")
	self._tableGo = goutil.findChild(go, "artifact/tableview")
	self._tableView = ScrollerList.create(self._tableGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))
	self._txtOldDesc = goutil.findChildTextComponent(go, "suitEffect/left/txtDesc")
	self._txtNewDesc = goutil.findChildTextComponent(go, "suitEffect/right/txtDesc")
end

function PetArtifactAwakenCell:init(data)
	self._tableView:reloadData(data)

	self._txtOldDesc.text = data.cfg.suitDes
	self._txtNewDesc.text = data.cfg.newsuitDes

	self._tableView:reloadData(data.equipList)
end

function PetArtifactAwakenCell:reset()
	self._tableView:dispose()
end

function PetArtifactAwakenCell:_updateCell(view, cell, data)
	local oldItem = goutil.findChild(cell, "left/item")
	local oldTxtName = goutil.findChildTextComponent(cell, "left/txtName")
	local oldTxtPetLimit = goutil.findChildTextComponent(cell, "left/txtPetLimit")
	local oldTxtLvLimit = goutil.findChildTextComponent(cell, "left/txtLvLimit")
	local oldTxtPower = goutil.findChildTextComponent(cell, "left/txtPower")
	local newItem = goutil.findChild(cell, "right/item")
	local newTxtName = goutil.findChildTextComponent(cell, "right/txtName")
	local newTxtPetLimit = goutil.findChildTextComponent(cell, "right/txtPetLimit")
	local newTxtLvLimit = goutil.findChildTextComponent(cell, "right/txtLvLimit")
	local newTxtPower = goutil.findChildTextComponent(cell, "right/txtPower")
	local cfgOld = EquipmentConfig.instance:GetEquipDefineInfoById(data.oldEquipId)
	local cfgNew = EquipmentConfig.instance:GetEquipDefineInfoById(data.newEquipId)

	if cfgOld then
		MaterialMgr.setCell(MatType.Equipment, data.oldEquipId, oldItem)

		oldTxtName.text = cfgOld.name
		oldTxtPetLimit.text = "精灵限制：" .. PetSkinConfig.instance:getPetSkinName(cfgOld.throneRelatedSkinId)
		oldTxtLvLimit.text = "等级限制" .. cfgOld.lvLimit

		local mo = PetEquipModel.instance:GetTemporaryEquip(data.oldEquipId, 0)

		oldTxtPower.text = mo.commPower
	end

	if cfgNew then
		MaterialMgr.setCell(MatType.Equipment, data.newEquipId, newItem)

		newTxtName.text = cfgNew.name
		newTxtPetLimit.text = "精灵限制：" .. PetSkinConfig.instance:getPetSkinName(cfgNew.throneRelatedSkinId)
		newTxtLvLimit.text = "等级限制" .. cfgNew.lvLimit

		local mo = PetEquipModel.instance:GetTemporaryEquip(data.newEquipId, 0)

		newTxtPower.text = mo.commPower
	end
end

function PetArtifactAwakenCell:_clearTableview(cell)
	local oldItem = goutil.findChild(cell, "left/item")
	local newItem = goutil.findChild(cell, "right/item")

	MaterialMgr.resetAll(oldItem)
	MaterialMgr.resetAll(newItem)
end

return PetArtifactAwakenCell
