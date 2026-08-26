-- chunkname: @modules/logic/explore/view/ExploreMapItem.lua

module("modules.logic.explore.view.ExploreMapItem", package.seeall)

local ExploreMapItem = class("ExploreMapItem", LuaCompBase)
local type_mask = typeof(UnityEngine.UI.Mask)
local maskIcon = {
	"explore_map_img_mask7",
	"explore_map_img_mask6",
	"explore_map_img_mask8",
	"explore_map_img_mask5",
	"explore_map_img_mask3",
	"explore_map_img_mask1",
	"explore_map_img_mask4",
	"explore_map_img_mask2"
}

function ExploreMapItem:ctor(mo)
	self._mo = mo
	self._nowIconRotate = 0
	self._isShowIcon = false
end

function ExploreMapItem:init(go)
	self.go = go
	go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false

	local left = gohelper.findChild(go, "image_left")
	local right = gohelper.findChild(go, "image_right")
	local top = gohelper.findChild(go, "image_top")
	local bottom = gohelper.findChild(go, "image_bottom")
	local maskGo = gohelper.findChild(go, "typemask")

	if maskGo then
		self._maskComp = maskGo:GetComponent(type_mask)
		self._maskImageComp = maskGo:GetComponent(gohelper.Type_Image)
	end

	self._type = gohelper.findChildImage(go, "type") or gohelper.findChildImage(go, "typemask/type")
	self._icon = gohelper.findChildImage(go, "icon")
	self._leftTrans = left.transform
	self._rightTrans = right.transform
	self._topTrans = top.transform
	self._bottomTrans = bottom.transform

	self:updateMo(self._mo)
end

function ExploreMapItem:updateMo(mo)
	gohelper.setActive(self.go, true)

	self._mo = mo

	gohelper.setActive(self._leftTrans, self._mo.left)
	gohelper.setActive(self._rightTrans, self._mo.right)
	gohelper.setActive(self._topTrans, self._mo.top)
	gohelper.setActive(self._bottomTrans, self._mo.bottom)

	if self._maskComp then
		if self._mo.bound then
			self._maskComp.enabled = true
			self._maskImageComp.enabled = true

			local icon = maskIcon[self._mo.bound]

			UISpriteSetMgr.instance:setExploreSprite(self._maskImageComp, icon)
		else
			self._maskComp.enabled = false
			self._maskImageComp.enabled = false
		end
	end

	transformhelper.setLocalPosXY(self.go.transform, self._mo.posX, self._mo.posY)

	local node = ExploreMapModel.instance:getNode(self._mo.key)

	if node then
		UISpriteSetMgr.instance:setExploreSprite(self._type, "dungeon_secretroom_landbg_" .. node.nodeType)
	end

	self:updateOutLineIcon()

	if self._mo.rotate then
		self:updateRotate()
	end
end

function ExploreMapItem:updateRotate()
	if not self._isShowIcon or not self._mo.rotate or self._nowIconRotate == ExploreMapModel.instance.nowMapRotate then
		return
	end

	self._nowIconRotate = ExploreMapModel.instance.nowMapRotate

	transformhelper.setLocalRotation(self._icon.transform, 0, 0, -ExploreMapModel.instance.nowMapRotate)
end

local clear = Color.clear
local white = Color.white

function ExploreMapItem:updateOutLineIcon()
	local icon = not self._mo.bound and ExploreMapModel.instance:getSmallMapIcon(self._mo.key)

	if icon then
		UISpriteSetMgr.instance:setExploreSprite(self._icon, icon)

		self._icon.color = white
		self._isShowIcon = true
	else
		self._icon.color = clear
		self._isShowIcon = false
	end
end

function ExploreMapItem:setActive(isActive)
	gohelper.setActive(self.go, isActive)
end

function ExploreMapItem:markUse(isUse)
	self._isUse = isUse
end

function ExploreMapItem:getIsUse()
	return self._isUse
end

function ExploreMapItem:setScale(scale)
	if self._mo.left then
		transformhelper.setLocalScale(self._leftTrans, scale, 1, 1)
	end

	if self._mo.right then
		transformhelper.setLocalScale(self._rightTrans, scale, 1, 1)
	end

	if self._mo.top then
		transformhelper.setLocalScale(self._topTrans, scale, 1, 1)
	end

	if self._mo.bottom then
		transformhelper.setLocalScale(self._bottomTrans, scale, 1, 1)
	end
end

return ExploreMapItem
