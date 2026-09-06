-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameWeaponUpgradeDescTipsView.lua

module("logic.extensions.orimatgame.view.OriMatGameWeaponUpgradeDescTipsView", package.seeall)

local OriMatGameWeaponUpgradeDescTipsView = class("OriMatGameWeaponUpgradeDescTipsView", ViewComponent)

function OriMatGameWeaponUpgradeDescTipsView:buildUI()
	OriMatGameWeaponUpgradeDescTipsView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._content = self:getGo("content")
	self._adjustPosition = self._content:GetComponent(ComponentType.UIAdjustPosition)
	self._levelScrCell = self:getGo("content/levelCol/scrCell")
	self._levelScrView = self:getGo("content/levelCol/scrView")
	self._levelScrollerList = ScrollerList.create(self._levelScrView, self._levelScrCell, GameUtil.handler(self._updateLevelCell, self), GameUtil.handler(self._clearLevelCell, self))

	self._levelScrollerList:regGetCellSize(GameUtil.handler(self._getCellSize, self))
end

function OriMatGameWeaponUpgradeDescTipsView:bindEvents()
	OriMatGameWeaponUpgradeDescTipsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function OriMatGameWeaponUpgradeDescTipsView:unbindEvents()
	OriMatGameWeaponUpgradeDescTipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function OriMatGameWeaponUpgradeDescTipsView:onEnter()
	OriMatGameWeaponUpgradeDescTipsView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._weaponId = checknumber(params[1])

	local pos = params[2]
	local sizeDelta = params[3]

	self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
	self:_onUpdate()
end

function OriMatGameWeaponUpgradeDescTipsView:onExit()
	OriMatGameWeaponUpgradeDescTipsView.super.onExit(self)
	self._levelScrollerList:dispose()
end

function OriMatGameWeaponUpgradeDescTipsView:_onUpdate()
	self._weaponDataList = {}

	local levelCfgs = OriMatGameConfig.instance:getWeaponLevelCfgs(self._weaponId)

	for _, data in ipairs(levelCfgs) do
		table.insert(self._weaponDataList, data)
	end

	self._levelScrollerList:reloadData(self._weaponDataList)
end

function OriMatGameWeaponUpgradeDescTipsView:_updateLevelCell(view, cell, data, tag)
	local weapDescPlanId = data.weapDescPlanId
	local descCfg = OriMatGameConfig.instance:getWeaponShowCfgs(weapDescPlanId)
	local mainGo = cell.gameObject
	local txtTitle = goutil.findChildTextComponent(mainGo, "title/txt")
	local descCell = goutil.findChild(mainGo, "descCell")
	local cloneName = descCell.name .. "_clone"

	txtTitle.text = data.level .. "级"

	GameUtil.SetActive(descCell, false)

	local descCellList = {}

	for idx = 1, mainGo.transform.childCount do
		local childGo = mainGo.transform:GetChild(idx - 1).gameObject

		if childGo.name == cloneName then
			table.insert(descCellList, childGo)
			GameUtil.SetActive(childGo, false)
		end
	end

	for idx, descData in ipairs(descCfg) do
		local go = descCellList[idx]

		if goutil.isNil(go) then
			go = goutil.cloneAndSetParent(descCell, mainGo.transform, cloneName)
		end

		local bg = goutil.findChild(go, "bg")
		local txtName = goutil.findChildTextComponent(go, "txtName")
		local txtValue = goutil.findChildTextComponent(go, "txtValue")

		txtName.text = descData.showDesc

		GameUtil.setUIImageSpriteIdx(bg, (idx + 1) % 2)

		txtValue.text = not string.nilorempty(descData.overwriteType) and data[descData.overwriteType] or descData.showValue

		GameUtil.SetActive(go, true)
	end
end

function OriMatGameWeaponUpgradeDescTipsView:_clearLevelCell(cell)
	return
end

function OriMatGameWeaponUpgradeDescTipsView:_getCellSize(view, idx)
	local data = self._weaponDataList[idx + 1]
	local descCfg = OriMatGameConfig.instance:getWeaponShowCfgs(data.weapDescPlanId)
	local n = #descCfg
	local height = 36 + 36 * n

	return GameUtil.getWidth(self._levelScrCell), height
end

return OriMatGameWeaponUpgradeDescTipsView
