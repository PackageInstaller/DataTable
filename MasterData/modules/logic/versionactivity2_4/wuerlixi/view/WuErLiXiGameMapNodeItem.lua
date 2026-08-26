-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/view/WuErLiXiGameMapNodeItem.lua

module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameMapNodeItem", package.seeall)

local WuErLiXiGameMapNodeItem = class("WuErLiXiGameMapNodeItem", LuaCompBase)

function WuErLiXiGameMapNodeItem:init(go)
	self.go = go
	self._imageicon = gohelper.findChildImage(go, "icon")
	self._goselected = gohelper.findChild(go, "#go_Selected")
	self._gounplaceable = gohelper.findChild(go, "#go_Unplaceable")
	self._goput = gohelper.findChild(go, "#go_Put")
	self._gohighlight = gohelper.findChild(go, "#go_Highlight")
	self._goconfirm = gohelper.findChild(go, "#go_Confirm")
end

function WuErLiXiGameMapNodeItem:setItem(mo)
	self._nodeMo = mo

	gohelper.setActive(self.go, true)

	self.go.name = mo.x .. "_" .. mo.y

	self:refreshItem()
end

function WuErLiXiGameMapNodeItem:hide()
	gohelper.setActive(self.go, false)
end

function WuErLiXiGameMapNodeItem:showUnplace(show)
	gohelper.setActive(self._gounplaceable, show)
end

function WuErLiXiGameMapNodeItem:showHightLight(show)
	show = show and not self._nodeMo:getNodeUnit()

	gohelper.setActive(self._gohighlight, show)
end

function WuErLiXiGameMapNodeItem:showPlaceable(show)
	gohelper.setActive(self._goconfirm, show)
end

function WuErLiXiGameMapNodeItem:showPut(show)
	gohelper.setActive(self._goput, show)
end

function WuErLiXiGameMapNodeItem:showSelect(show)
	gohelper.setActive(self._goselected, show)
end

function WuErLiXiGameMapNodeItem:refreshItem()
	local curUnit = WuErLiXiMapModel.instance:getCurSelectUnit()

	self._unitMo = self._nodeMo:getNodeUnit()

	if self._unitMo then
		gohelper.setActive(self._goselected, curUnit[1] == self._unitMo.x and curUnit[2] == self._unitMo.y)

		if self._unitMo.unitType == WuErLiXiEnum.UnitType.SignalStart or self._unitMo.unitType == WuErLiXiEnum.UnitType.SignalEnd then
			UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(self._imageicon, "v2a4_wuerlixi_node_icon4")

			return
		end
	else
		gohelper.setActive(self._goselected, false)
	end

	if WuErLiXiMapModel.instance:isNodeHasInitUnit(self._nodeMo) then
		UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(self._imageicon, "v2a4_wuerlixi_node_icon5")

		return
	end

	local hasUnit = WuErLiXiMapModel.instance:isNodeHasUnit(self._nodeMo)

	if hasUnit then
		UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(self._imageicon, "v2a4_wuerlixi_node_icon2")

		return
	end

	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(self._imageicon, "v2a4_wuerlixi_node_icon1")
end

function WuErLiXiGameMapNodeItem:getNodeMo()
	return self._nodeMo
end

function WuErLiXiGameMapNodeItem:destroy()
	return
end

return WuErLiXiGameMapNodeItem
