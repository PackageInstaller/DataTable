-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idlegame/view/ItemNuo.lua

module("logic.extensions.idlegame.view.ItemNuo", package.seeall)

local ItemNuo = class("ItemNuo")
local cellSizeX = 140
local cellSizeY = 155

function ItemNuo:ctor(go)
	self.mainGO = go
	self._point = goutil.findChild(self.mainGO, "point")
	self._drag = Framework.UIDragTrigger.Get(self.mainGO)

	self._drag:AddBeginDragListener(self._onBeginDrag, self)
	self._drag:AddEndDragListener(self._onEndDrag, self)
	self._drag:AddDragListener(self._onDragging, self)

	self._txtName = goutil.findChildComponent(self.mainGO, "txtName", "Text")
	self._anim = self.mainGO:GetComponent("Animator")
	self._anim.enabled = false
end

function ItemNuo:setActive(isActive)
	goutil.setActive(self.mainGO, isActive)

	if not isActive and self._nuo ~= nil then
		RoleObjectPool.instance:removeRole(self._nuo)
	end

	self._anim.enabled = false

	Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
end

function ItemNuo:onSetMo(mo)
	self._tickTime = 0
	self._nuo = RoleObjectPool.instance:addRoleToParent(self._nuo, math.min(10270 + mo.level), self._point.transform, 1)
	self._mo = mo
	self._cfg = IdleGameConfig.instance:getXiaoNuoPlaceCfg(self._mo.level)
	self._txtName.text = string.format("%d级小诺", mo.level)
end

function ItemNuo:setRandomPos(x, y, z)
	Framework.TransformUtil.SetLocalPos(self.mainGO.transform, x, y, z)
end

function ItemNuo:getRandomPos()
	return math.random(-UnityEngine.Screen.width / 2 + 100, UnityEngine.Screen.width / 2 - 100), math.random(-260, 260), 0
end

function ItemNuo:onTick(deltaTime)
	if self._mo == nil or self._cfg == nil or not self.mainGO.activeSelf then
		return
	end

	self._tickTime = self._tickTime + deltaTime

	if self._tickTime >= self._cfg.needTime then
		local addMoney = checknumber(self._cfg.addMoePerTimes)

		self._tickTime = self._tickTime - self._cfg.needTime

		IdleGameModel.instance:onAddMoney(addMoney)

		local x, y, z = Framework.TransformUtil.GetPos(self.mainGO.transform, 0, 0, 0)

		self._anim.enabled = true

		self._anim:Play("ani_nuo", 0, 0)
		settimer(0.7, function()
			x, y, z = Framework.TransformUtil.GetPos(self.mainGO.transform, 0, 0, 0)

			IdleGameController.instance:localNotify("onAddMoney", addMoney, x, y, z)
		end, nil, false)
	end
end

function ItemNuo:playPopupAnim()
	self.mainGO.transform:SetAsLastSibling()
	Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 0.8, 0.8, 1)
	self.mainGO.transform:DOScale(Vector3.New(1, 1, 1), 0.2)
end

function ItemNuo:_onBeginDrag()
	self:_checkBorder()

	self._btnBin = goutil.findChildComponent(self.mainGO.transform.parent.parent, "leftbom/btnBin", "Image")

	local point1 = goutil.findChild(self.mainGO.transform.parent.parent, "point1")
	local x, y, z = Framework.TransformUtil.GetPos(self._btnBin.transform, 0, 0, 0)

	Framework.TransformUtil.SetPos(point1.transform, x, y, z)

	self._btnBinPosX, self._btnBinPosY, z = Framework.TransformUtil.GetLocalPos(point1.transform, 0, 0, 0)

	self.mainGO.transform:SetAsLastSibling()
end

function ItemNuo:_onEndDrag(eventData)
	self:_checkBorder()

	local isHoverBin = self:isIntersect(self._btnBinPosX, self._btnBinPosY, 70, 70)

	if isHoverBin then
		goutil.setActive(self._btnBin.gameObject, false)
		TipsFacade.instance:openPopupWindow("提示", string.format("确定要出售%s吗？出售后可获得%s萌值。", self._cfg.name, StringUtil.numberToString(self._cfg.sellPrice)), function()
			XiaoNuoPlaceAgent.instance:sendPM_XiaoNuoDiscardReq(self._mo.position, function(msg)
				IdleGameModel.instance:handlePM_XiaoNuoDiscardRes(self._mo.position, msg)
				IdleGameController.instance:localNotify("DiscardNuo", {
					level = 0,
					position = self._mo.position
				})
			end)
			goutil.setActive(self._btnBin.gameObject, true)
			Game.ImageUtil.SetColorRGBA(self._btnBin, 1, 1, 1, 1)
		end, function()
			goutil.setActive(self._btnBin.gameObject, true)
			Game.ImageUtil.SetColorRGBA(self._btnBin, 1, 1, 1, 1)
		end, "确定", "取消")
	else
		local x, y, z = Framework.TransformUtil.GetLocalPos(self.mainGO.transform, 0, 0, 0)

		IdleGameController.instance:localNotify("DragNuoEnd", self._mo, x, y)
	end

	local ratio = UnityEngine.Screen.height / 720
	local screenWidth = UnityEngine.Screen.width / ratio
	local x, y, z = Framework.TransformUtil.GetLocalPos(self.mainGO.transform, 0, 0, 0)

	x = math.max(x, -screenWidth / 2 + 160)

	Framework.TransformUtil.SetLocalPos(self.mainGO.transform, x, y, 0)
end

function ItemNuo:_checkBorder()
	local ratio = UnityEngine.Screen.height / 720
	local screenWidth = UnityEngine.Screen.width / ratio

	self.mainGO.transform.position = uGuiUtil.GetTouchWorldPosition()

	local x, y, z = Framework.TransformUtil.GetLocalPos(self.mainGO.transform, 0, 0, 0)

	x = math.max(x, -screenWidth / 2 + 80)
	x = math.min(x, screenWidth / 2 - 50)
	y = math.max(y, -210)
	y = math.min(y, 210)

	Framework.TransformUtil.SetLocalPos(self.mainGO.transform, x, y, 0)
end

function ItemNuo:_onDragging(eventData)
	self:_checkBorder()

	local isHoverBin = self:isIntersect(self._btnBinPosX, self._btnBinPosY, 70, 70)

	if isHoverBin then
		Game.ImageUtil.SetColorRGBA(self._btnBin, 1, 0.5, 0.5, 1)
	else
		Game.ImageUtil.SetColorRGBA(self._btnBin, 1, 1, 1, 1)
	end
end

function ItemNuo:getIsActive()
	return self.mainGO.gameObject.activeSelf
end

function ItemNuo:isContain(x, y)
	local selfX, selfY = Framework.TransformUtil.GetLocalPos(self.mainGO.transform, selfX, selfY, 0)

	return x <= selfX + cellSizeX * 0.5 and x >= selfX - cellSizeX * 0.5 and y <= selfY + cellSizeY * 0.5 and y >= selfY - cellSizeY * 0.5
end

function ItemNuo:isIntersect(x, y, rectSizeX, rectSizeY)
	if rectSizeX == nil or rectSizeY == nil then
		rectSizeX = cellSizeX
		rectSizeY = cellSizeY
	end

	local selfX, selfY = Framework.TransformUtil.GetLocalPos(self.mainGO.transform, selfX, selfY, 0)

	return self:isContain(x - rectSizeX * 0.5, y - rectSizeY * 0.5) or self:isContain(x - rectSizeX * 0.5, y + rectSizeY * 0.5) or self:isContain(x + rectSizeX * 0.5, y - rectSizeY * 0.5) or self:isContain(x + rectSizeX * 0.5, y + rectSizeY * 0.5)
end

function ItemNuo:getCenterDistance(x, y)
	local selfX, selfY = Framework.TransformUtil.GetLocalPos(self.mainGO.transform, selfX, selfY, 0)
	local offsetX, offsetY = selfX - x, selfY - y

	return math.sqrt(offsetX * offsetX, offsetY * offsetY)
end

return ItemNuo
