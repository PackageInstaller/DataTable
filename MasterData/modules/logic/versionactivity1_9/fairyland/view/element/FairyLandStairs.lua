-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/element/FairyLandStairs.lua

module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandStairs", package.seeall)

local FairyLandStairs = class("FairyLandStairs", BaseView)

function FairyLandStairs:onInitView()
	self.goRoot = gohelper.findChild(self.viewGO, "main/#go_Root")
	self.rootTrs = self.goRoot.transform
	self.goStairs = gohelper.findChild(self.goRoot, "#go_Stairs")
	self.goPool = gohelper.findChild(self.goStairs, "pool")
	self.goStair = gohelper.findChild(self.goStairs, "pool/stair")
	self.stairPool = self:getUserDataTb_()
	self.stairDict = self:getUserDataTb_()
	self.noUseDict = {}
	self.poolCount = 0
	self.startPosX = -90
	self.startPosY = -120
	self.spaceX = 244
	self.spaceY = 73
	self.maxStair = 50

	local width = recthelper.getWidth(self.viewGO.transform)
	local x = self:caleStairPos(3)

	self.offsetX = width * 0.5 - x - 318

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FairyLandStairs:addEvents()
	self.addEventCb(self, FairyLandController.instance, FairyLandEvent.DoStairAnim, self.onDoStairAnim, self)
	self.addEventCb(self, FairyLandController.instance, FairyLandEvent.SetStairPos, self.onSetStairPos, self)
end

function FairyLandStairs:removeEvents()
	return
end

function FairyLandStairs:onOpen()
	return
end

function FairyLandStairs:onDoStairAnim(index)
	if self.stairDict[index] then
		local anim = self.stairDict[index].anim

		anim:Play("open", 0, 0)
	end
end

function FairyLandStairs:moveToPos(pos, tween)
	if self.moveTweenId then
		ZProj.TweenHelper.KillById(self.moveTweenId)

		self.moveTweenId = nil
	end

	pos = math.min(self.maxStair - 6, pos)

	local x, y = self:caleStairRootPos(pos)

	if tween then
		if not self._tweenTime then
			self.moveTweenId = ZProj.TweenHelper.DOAnchorPos(self.rootTrs, x, y, self._tweenTime, self._moveDone, self, nil, EaseType.OutQuad)
		end
	else
		recthelper.setAnchor(self.rootTrs, x, y)
		self:updateStairs()
	end
end

function FairyLandStairs:_moveDone()
	if self.moveTweenId then
		ZProj.TweenHelper.KillById(self.moveTweenId)

		self.moveTweenId = nil
	end

	self:updateStairs()
end

function FairyLandStairs:caleStairRootPos(index)
	local x = -index * self.spaceX + FairyLandEnum.StartCameraPosX + self.offsetX
	local y = index * self.spaceY + FairyLandEnum.StartCameraPosY

	return x, y
end

function FairyLandStairs:onSetStairPos(isMove)
	local curPos = FairyLandModel.instance:getStairPos()

	if isMove then
		self:moveToPos(curPos, true)
	else
		self:moveToPos(curPos)
		self:updateStairs()
	end
end

function FairyLandStairs:updateStairs()
	local curPos = FairyLandModel.instance:getStairPos()

	curPos = math.min(self.maxStair - 6, curPos)

	local endPos = curPos + self:getScreenStairCount()
	local startPos = curPos - 2

	self:setNoUseStairs()

	for i = startPos, endPos do
		self:getStair(i)
	end

	self:recycleStairs()
end

function FairyLandStairs:getScreenStairCount()
	if self.stairCount then
		return self.stairCount
	end

	local popUpTopGO = gohelper.findChild(ViewMgr.instance:getTopUIRoot(), "POPUP_TOP")
	local screenHeight = recthelper.getHeight(popUpTopGO.transform)

	self.stairCount = math.ceil(screenHeight / self.spaceY) + 2

	return self.stairCount
end

function FairyLandStairs:onUpdateParam()
	return
end

function FairyLandStairs:setNoUseStairs()
	for k, v in pairs(self.stairDict) do
		self.noUseDict[k] = true
	end
end

function FairyLandStairs:recycleStairs()
	for k, v in pairs(self.noUseDict) do
		self:recycleStair(self.stairDict[k])

		self.stairDict[k] = nil
	end

	self.noUseDict = {}
end

function FairyLandStairs:getStair(index)
	self.noUseDict[index] = nil

	local item = self.stairDict[index]

	if not item then
		item = self:getOrCreateStair(index)
		self.stairDict[index] = item
	end

	local active = index <= self.maxStair

	gohelper.setActive(item.go, active)

	return item
end

function FairyLandStairs:getOrCreateStair(index)
	local item

	if self.poolCount > 0 then
		item = table.remove(self.stairPool)
		self.poolCount = self.poolCount - 1

		gohelper.addChild(self.goStairs, item.go)
	else
		item = self:getUserDataTb_()
		item.go = gohelper.clone(self.goStair, self.goStairs)
		item.transform = item.go.transform
		item.anim = item.go:GetComponent(typeof(UnityEngine.Animator))
	end

	item.go.name = tostring(index)

	local x, y = self:caleStairPos(index)

	recthelper.setAnchor(item.transform, x, y)

	return item
end

function FairyLandStairs:caleStairPos(index)
	local x = self.startPosX + index * self.spaceX
	local y = self.startPosY - index * self.spaceY

	return x, y
end

function FairyLandStairs:recycleStair(item)
	if not item then
		return
	end

	gohelper.addChild(self.goPool, item.go)
	table.insert(self.stairPool, item)

	self.poolCount = self.poolCount + 1
end

function FairyLandStairs:onDestroyView()
	if self.moveTweenId then
		ZProj.TweenHelper.KillById(self.moveTweenId)

		self.moveTweenId = nil
	end
end

return FairyLandStairs
