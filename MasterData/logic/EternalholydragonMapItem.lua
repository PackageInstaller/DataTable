-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalholydragon/view/EternalholydragonMapItem.lua

module("logic.extensions.eternalholydragon.view.EternalholydragonMapItem", package.seeall)

local EternalholydragonMapItem = class("EternalholydragonMapItem")

EternalholydragonMapItem.Type = {
	River = 1,
	Battle = 2,
	Item = 3,
	Empty = 0
}

function EternalholydragonMapItem:ctor()
	self.rowIndex = 0
	self.colIndex = 0
	self._type = EternalholydragonMapItem.Type.Empty
	self._gridElementParams = ""
end

function EternalholydragonMapItem:buildUI(go)
	self.maskGo = goutil.findChild(go, "mask")
	self._waterChange = goutil.findChild(go, "water"):GetComponent(ComponentType.UIImageSpriteChange)
	self.iconGo = goutil.findChild(go, "icon")
	self.dropGo = goutil.findChild(go, "drop")
	self._landChange = goutil.findChild(go, "land"):GetComponent(ComponentType.UIImageSpriteChange)
	self._kuangGo = goutil.findChild(go, "icon/kuang")
	self._emoGo = goutil.findChild(go, "icon/emo")
	self._btnIcon = Framework.ButtonAdapter.Get(self.iconGo)

	goutil.setActive(self.dropGo, false)
	goutil.setActive(self.maskGo, false)
	goutil.setActive(self.icon, false)
	self._btnIcon:AddClickListener(self._onClick, self)
	self:_random()
end

function EternalholydragonMapItem:setIndex(row, col)
	self.rowIndex = row
	self.colIndex = col
end

function EternalholydragonMapItem:getIndex()
	return self.rowIndex, self.colIndex
end

function EternalholydragonMapItem:setData(gridInfo, mapCfgs, itemPlanId, gameView)
	local mapCfg = mapCfgs[gridInfo.pos.x]
	local gridId = mapCfg["c" .. gridInfo.pos.y]

	self._itemPlanId = itemPlanId
	self._gridInfo = gridInfo
	self._gridCfg = nil
	self._gameView = gameView
	self._oriIconActive = nil
	self.isWater = false

	if gridId > 0 then
		self._gridCfg = EternalholydragonConfig.instance:getGridCfg(mapCfg.mapId, gridId)
		self.isWater = self._gridCfg.gridType == EternalholydragonController.GridType.Water
	end

	goutil.setActive(self._waterChange.gameObject, self.isWater)

	self._gridElementParams = gridInfo.gridElementParams

	self:_setType(gridInfo)
	self:_setIconActive()
	self:_showLand(gridInfo.oriLand)
	self:_setIsMonster()
	self:_setIsBoss(gridInfo.isBoos)
end

function EternalholydragonMapItem:isBlock()
	if self.isWater then
		return true
	end

	if self._gridInfo.gridElementType > 0 then
		return true
	end
end

function EternalholydragonMapItem:isWater()
	return self.isWater
end

function EternalholydragonMapItem:isCanDrop(itemId)
	local isClearId = EternalholydragonController:isClearLandMonsterItemId(self._itemPlanId, itemId)

	if not isClearId and self._gridInfo.gridElementType == 0 and not self.isWater then
		return true
	end

	if isClearId and not self.isWater and self:getType() == EternalholydragonMapItem.Type.Battle then
		return true
	end

	return false
end

function EternalholydragonMapItem:isInitObstacle()
	return
end

function EternalholydragonMapItem:setRangeVisible(visible)
	goutil.setActive(self.maskGo, visible)
end

function EternalholydragonMapItem:setDropObjVisible(visible)
	goutil.setActive(self.dropGo, visible)
end

function EternalholydragonMapItem:replaceIcon(itemId)
	local cfg = EternalholydragonConfig.instance:getItemCfg(self._itemPlanId, itemId)

	uGuiUtil.setSpriteToImage(self.iconGo, nil, cfg.iconName .. ".png")
	goutil.setActive(self.iconGo, true)
end

function EternalholydragonMapItem:resetIcon()
	self:setType(self._type)
	self:_setIconActive()
end

function EternalholydragonMapItem:getType()
	return self._type
end

function EternalholydragonMapItem:_setType(gridInfo)
	if gridInfo.gridElementType == 1 then
		self:setType(EternalholydragonMapItem.Type.Battle)
	elseif gridInfo.gridElementType == 2 then
		self:setType(EternalholydragonMapItem.Type.Item)
	else
		self:setType(EternalholydragonMapItem.Type.Empty)
	end
end

function EternalholydragonMapItem:getGridElementParams()
	return self._gridElementParams
end

function EternalholydragonMapItem:setType(type)
	self._type = type

	local iconName = ""
	local value = checknumber(self._gridElementParams)

	if type == EternalholydragonMapItem.Type.Battle then
		iconName = self._gridCfg.iconName
	elseif type == EternalholydragonMapItem.Type.Item then
		local itemId = value
		local cfg = EternalholydragonConfig.instance:getItemCfg(self._itemPlanId, itemId)

		iconName = cfg.iconName
	end

	if iconName ~= "" then
		uGuiUtil.setSpriteToImage(self.iconGo, nil, iconName .. ".png")
	end
end

function EternalholydragonMapItem:_onClick()
	if self._type == EternalholydragonMapItem.Type.Battle then
		if self.isWater then
			-- block empty
		else
			local creepsMasterId = checknumber(self._gridElementParams)

			EternalholydragonController.instance:enterMission(self.rowIndex, self.colIndex, creepsMasterId, true)
		end
	elseif self._type == EternalholydragonMapItem.Type.Item then
		local itemId = checknumber(self._gridElementParams)
		local cfg = EternalholydragonConfig.instance:getItemCfg(self._itemPlanId, itemId)

		CommonTipsMgr.instance:showTips(cfg.desc, self.iconGo)
		self._gameView:_onClickLandItem(self)
	end
end

function EternalholydragonMapItem:_random()
	local landRandom = math.random(1, 3)

	self._landChange:SetState(landRandom - 1)
end

function EternalholydragonMapItem:_showLand(flag)
	goutil.setActive(self._landChange.gameObject, flag)
end

function EternalholydragonMapItem:onExit()
	uGuiUtil.clearImage(self.iconGo)
end

function EternalholydragonMapItem:destroyUI()
	self._btnIcon:RemoveClickListener()
end

function EternalholydragonMapItem:_setIsMonster()
	local t = self:getType()

	goutil.setActive(self._kuangGo, t == EternalholydragonMapItem.Type.Battle)
end

function EternalholydragonMapItem:_setIsBoss(isBoos)
	goutil.setActive(self._emoGo, isBoos)
end

function EternalholydragonMapItem:_setIconActive()
	local hasItem = self._gridInfo.gridElementType > 0

	goutil.setActive(self.iconGo, hasItem)
end

return EternalholydragonMapItem
