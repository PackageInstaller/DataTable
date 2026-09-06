-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/directpurchase/view/LongNvItemsCell.lua

module("logic.extensions.directpurchase.view.LongNvItemsCell", package.seeall)

local LongNvItemsCell = class("LongNvItemsCell", LongNvLevelCell)

function LongNvItemsCell:buildUI(go)
	LongNvItemsCell.super.buildUI(self, go)

	self._goodsGo = goutil.findChild(go, "goods")
	self._tableview = goutil.findChild(go, "tableview"):GetComponent("UITableview")
	self._tableCell = goutil.findChild(go, "tableview/item")

	self._tableCell:SetActive(false)
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
end

function LongNvItemsCell:init(id, activityId, actType)
	LongNvItemsCell.super.init(self, id, activityId, actType)
	self:_setItemsList()
end

function LongNvItemsCell:onExit()
	LongNvItemsCell.super.onExit(self)
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = {}
end

function LongNvItemsCell:_setItemsList()
	local bagPetMo = BagModel.instance:getPet(self._petId)

	if not bagPetMo then
		goutil.setActive(self._goodsGo, true)
		goutil.setActive(self._tableview.gameObject, false)
	else
		goutil.setActive(self._goodsGo, false)
		goutil.setActive(self._tableview.gameObject, true)
		self:_showItems(bagPetMo)
	end
end

function LongNvItemsCell:_showItems(bagPetMo)
	local skinId = bagPetMo.curFaceId
	local job = PetSkinConfig.instance:getFirstJobKey(skinId)
	local attrs = PetSkinConfig.instance:getAllElementAttrs(skinId)

	if attrs and #attrs > 0 then
		local cfg = PayStrengthenConfig.instance:getEquipmentCfg(job, attrs[1])

		if cfg then
			self:_loadIcon(cfg.prize)
		end
	end
end

function LongNvItemsCell:setPetInfo(petId)
	LongNvItemsCell.super.setPetInfo(self, petId)
	self:_setItemsList()
end

function LongNvItemsCell:_loadIcon(itemStrs)
	self._curViewDatas = {}

	if not string.nilorempty(itemStrs) then
		local list = string.split(itemStrs, "#") or {}
		local count = #list

		if count > 0 then
			for i, v in ipairs(list) do
				table.insert(self._curViewDatas, v)
			end

			self._tableview:ReloadData()
		end
	end
end

function LongNvItemsCell:_numInView()
	return #self._curViewDatas
end

function LongNvItemsCell:_cellSize(view, idx)
	return 60, 60
end

function LongNvItemsCell:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function LongNvItemsCell:_updateCell(view, cell, data)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	Framework.TransformUtil.SetLocalScale(parentGo.transform, 0.6, 0.6, 0.6)
	MaterialMgr.setCellByCfg(data, parentGo)
end

function LongNvItemsCell:_clearTableview(cell)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	MaterialMgr.resetAll(parentGo)
end

return LongNvItemsCell
