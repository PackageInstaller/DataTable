-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/directpurchase/view/StarGodSelectCell.lua

module("logic.extensions.directpurchase.view.StarGodSelectCell", package.seeall)

local StarGodSelectCell = class("StarGodSelectCell", LongNvLevelCell)

function StarGodSelectCell:buildUI(go)
	StarGodSelectCell.super.buildUI(self, go)

	self._goodsGo = goutil.findChild(go, "goods")
	self.btnAdd = goutil.findChild(go, "btnAdd")

	GameUtil.SetActive(self.btnAdd, false)

	self._tableview = goutil.findChild(go, "tableview"):GetComponent("UITableview")
	self._tableCell = goutil.findChild(go, "tableview/item")

	self._tableCell:SetActive(false)
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	self._btnSelect = Framework.ButtonAdapter.GetFrom(go, "btnSelect")
end

function StarGodSelectCell:bindEvents()
	StarGodSelectCell.super.bindEvents(self)
	self._btnSelect:AddClickListener(self._onClickSelect, self)
end

function StarGodSelectCell:unbindEvents()
	StarGodSelectCell.super.unbindEvents(self)
	self._btnSelect:RemoveClickListener()
end

function StarGodSelectCell:init(id, activityId, actType)
	StarGodSelectCell.super.init(self, id, activityId, actType)
	self:_setItemsList()
end

function StarGodSelectCell:onExit()
	StarGodSelectCell.super.onExit(self)
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = {}
end

function StarGodSelectCell:_onClickSelect()
	printInfo("test 选择4个星神")

	local bagPetMo = BagModel.instance:getPet(self._petId)

	UIStateManager.instance:push(ViewName.PayStrengthenSelectView, bagPetMo)
end

function StarGodSelectCell:_setItemsList()
	GameUtil.SetActive(self._mainGo, true)
	self:_initItems()

	local bagPetMo = BagModel.instance:getPet(self._petId)

	if not bagPetMo then
		goutil.setActive(self._goodsGo, true)
		goutil.setActive(self._tableview.gameObject, false)
		goutil.setActive(self._btnSelect.gameObject, false)
		GameUtil.SetActive(self.btnAdd, false)
	else
		local cfg = PayStrengthenConfig.instance:getRacePCfg(bagPetMo.raceId)

		if cfg then
			local priceCfg = PayStrengthenConfig.instance:getPriceCfgByPlanId(cfg.pricePlanId) or {}

			if not priceCfg.cost then
				self._payGoodsId = ""

				self:_setGameGoodsItem()
				goutil.setActive(self._goodsGo, false)
				goutil.setActive(self._tableview.gameObject, true)
				goutil.setActive(self._btnSelect.gameObject, true)
				GameUtil.SetActive(self.btnAdd, #self._curViewDatas == 0)
			end
		else
			GameUtil.SetActive(self._mainGo, false)
		end
	end
end

function StarGodSelectCell:_initItems()
	self._curViewDatas = {}

	self._tableview:ReloadData()
end

function StarGodSelectCell:updateItemList(list)
	GameUtil.SetActive(self.btnAdd, list == nil or #list == 0)

	if not list or #list ~= 4 then
		FloatWordMgr.instance:show("请选择4个星神")

		return
	end

	goutil.setActive(self._goodsGo, false)
	goutil.setActive(self._tableview.gameObject, true)

	self._curViewDatas = list

	self._tableview:ReloadData()
	GameUtil.SetActive(self.btnAdd, #self._curViewDatas == 0)
end

function StarGodSelectCell:setPetInfo(petId)
	StarGodSelectCell.super.setPetInfo(self, petId)
	self:_setItemsList()
end

function StarGodSelectCell:_numInView()
	return #self._curViewDatas
end

function StarGodSelectCell:_cellSize(view, idx)
	return 60, 60
end

function StarGodSelectCell:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function StarGodSelectCell:_updateCell(view, cell, data)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	Framework.TransformUtil.SetLocalScale(parentGo.transform, 0.6, 0.6, 0.6)

	local cfg = PayStrengthenConfig.instance:getStarGodCfg(data)

	if cfg then
		local proxy = MaterialMgr.setCellByCfg(cfg.prize, parentGo)

		if proxy then
			local bagPetMo = BagModel.instance:getPet(self._petId)

			if bagPetMo and PetSkinConfig.instance:checkHasJob(bagPetMo.raceId, GameEnum.CareerType.SourceTrace) then
				proxy.binder:setRaceHead(bagPetMo.raceId)
			end
		end
	end
end

function StarGodSelectCell:_clearTableview(cell)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	MaterialMgr.resetAll(parentGo)
end

function StarGodSelectCell:_getStringByList()
	local str = self._petId .. ","

	for i, v in ipairs(self._curViewDatas) do
		str = i == 1 and str .. v or str .. "," .. v
	end

	return str
end

function StarGodSelectCell:_getGameGoodsParam()
	return self:_getStringByList()
end

function StarGodSelectCell:_getRMBParams()
	local str = self:_getStringByList()

	return {
		param = str
	}
end

function StarGodSelectCell:_isMatchCondition()
	if not self._curViewDatas or #self._curViewDatas ~= 4 then
		FloatWordMgr.instance:show("请选择4个星神")

		return false
	end

	return true
end

return StarGodSelectCell
