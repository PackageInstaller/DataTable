-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/model/DivinexjHorizontalPoleItem.lua

module("logic.extensions.divinexingjiangclg.model.DivinexjHorizontalPoleItem", package.seeall)

local DivinexjHorizontalPoleItem = class("DivinexjHorizontalPoleItem")

function DivinexjHorizontalPoleItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._mainGO = go
	self._rectTrans = go:GetComponent(goutil.Type_RectTransform)
	self._btn = Framework.ButtonAdapter.Get(go)

	self._btn:AddClickListener(self._onBtnClick, self)
end

function DivinexjHorizontalPoleItem:init(leftPillarIndex, posX, posY, leftPosX, rightPosX)
	self._dropItemList = {}
	self._leftPillarIndex = leftPillarIndex
	self._posX = posX
	self._posY = posY
	self._leftPosX = leftPosX
	self._rightPosX = rightPosX

	GameUtil.setAnchoredPos(self._rectTrans, posX, posY)
end

function DivinexjHorizontalPoleItem:reset()
	table.clear(self._dropItemList)
end

function DivinexjHorizontalPoleItem:getMainGO()
	return self._mainGO
end

function DivinexjHorizontalPoleItem:getLeftPillarIndex()
	return self._leftPillarIndex
end

function DivinexjHorizontalPoleItem:getPosY()
	return self._posY
end

function DivinexjHorizontalPoleItem:getLeftPosX()
	return self._leftPosX
end

function DivinexjHorizontalPoleItem:getRightPosX()
	return self._rightPosX
end

function DivinexjHorizontalPoleItem:addDropItem(dropItem)
	if not TableUtil.isHad(self._dropItemList, dropItem) then
		table.insert(self._dropItemList, dropItem)
	end
end

function DivinexjHorizontalPoleItem:removeDropItem(dropItem)
	table.removebyvalue(self._dropItemList, dropItem)
end

function DivinexjHorizontalPoleItem:isOverLap(leftPillarIndex, topY, bottomY)
	if self._leftPillarIndex ~= leftPillarIndex then
		return false
	end

	return topY >= self._posY and bottomY <= self._posY
end

function DivinexjHorizontalPoleItem:_onBtnClick()
	if #self._dropItemList == 0 then
		DivineXingJiangClgGameController.instance:localNotify(DivineXingJiangClgGameController.EventRemoveHorizontalPole, self._mainGO:GetInstanceID())
	else
		FloatWordMgr.instance:show("横杆上有星座移动，无法移除")
	end
end

return DivinexjHorizontalPoleItem
