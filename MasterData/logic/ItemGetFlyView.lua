-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itemget/view/ItemGetFlyView.lua

module("logic.extensions.itemget.view.ItemGetFlyView", package.seeall)

local ItemGetFlyView = class("ItemGetFlyView", ViewComponent)

ItemGetFlyView.OffsetY = 200

function ItemGetFlyView:ctor()
	ItemGetFlyView.super.ctor(self)
end

function ItemGetFlyView:buildUI()
	self.itemtipflyClone = self:getGo("itemtipfly")

	GameUtil.SetActive(self.itemtipflyClone, false)

	self._cloneCell = self:getGo("itemtipfly")

	goutil.setActive(self._cloneCell, false)

	self._cells = {}
	self._maxCellCount = 5
	self._parentGo = self.mainGO
end

function ItemGetFlyView:onEnter()
	self:_tryPopItem()
end

function ItemGetFlyView:onExit()
	local gameObjectComp = AnimatorPlayCall.Instance

	if not goutil.isNil(gameObjectComp) then
		UnityEngine.GameObject.DestroyImmediate(gameObjectComp.gameObject)
	end

	for _, v in ipairs(self._cells) do
		goutil.setActive(v, false)
	end

	removetimer(self._popItem, self)
end

function ItemGetFlyView:_tryPopItem()
	self:_popItem()
	settimer(0.25, self._popItem, self, true)
end

function ItemGetFlyView:_popItem()
	local data = ItemGetController.instance:popUpItemFly()

	if data then
		local cell = self:_getFreeCell()

		self:_updateCell(cell, data)
		self:_startTweenPos()
	end
end

function ItemGetFlyView:_startTweenPos()
	local len = #self._cells
	local space = 52

	for i = 1, len do
		local cell = self._cells[i]
		local targetPosY = space * (i - 1) + ItemGetFlyView.OffsetY
		local _, y, _ = Framework.TransformUtil.GetLocalPos(cell.transform, 0, 0, 0)

		if math.abs(targetPosY - y) > 0.1 then
			cell.transform:DOLocalMoveY(targetPosY, math.abs(targetPosY - y) / space * 0.15, false)
		end
	end
end

function ItemGetFlyView:_updateCell(go, obj)
	cell = goutil.findChild(go, "container")

	local icon = goutil.findChild(cell, "icon")
	local name = goutil.findChildTextComponent(cell, "name")
	local mo = obj.mo

	name.text = GameUtil.HtmlColorTxt(obj.name, obj.color) .. " x" .. mo.num

	local proxy = MaterialMgr.setCellByGId(mo.materialType, mo.id, icon)

	if proxy and proxy.view then
		proxy:setAutoTips(false)
		proxy.binder:setNum(0)
		Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.36, 0.36, 0.36)
	end

	goutil.setActive(go, false)
	goutil.setActive(go, true)

	local animator = go:GetComponent("Animator")

	AnimatorPlayCall.Instance:Play(animator, "itemtipfly", GameUtil.handler(self._onFinish, self, icon), nil)
end

function ItemGetFlyView:_onFinish(icon)
	MaterialMgr.resetAll(icon)
end

function ItemGetFlyView:_getFreeCell()
	local cell
	local len = #self._cells
	local maxCellCount = self._maxCellCount

	if len < maxCellCount then
		cell = goutil.cloneAndSetParent(self._cloneCell, self._parentGo.transform, "itemtipfly")
	else
		cell = self._cells[len]

		table.remove(self._cells, len)
	end

	table.insert(self._cells, 1, cell)
	Framework.TransformUtil.SetLocalPos(cell.transform, 0, ItemGetFlyView.OffsetY, 0)
	cell.transform:SetAsLastSibling()

	return cell
end

return ItemGetFlyView
