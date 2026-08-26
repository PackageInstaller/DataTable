-- chunkname: @modules/logic/explore/map/unit/ExploreDoor.lua

module("modules.logic.explore.map.unit.ExploreDoor", package.seeall)

local ExploreDoor = class("ExploreDoor", ExploreBaseDisplayUnit)

ExploreDoor.PairAnim = {
	[ExploreAnimEnum.AnimName.nToA] = ExploreAnimEnum.AnimName.aToN,
	[ExploreAnimEnum.AnimName.count0to1] = ExploreAnimEnum.AnimName.count1to0,
	[ExploreAnimEnum.AnimName.count1to2] = ExploreAnimEnum.AnimName.count2to1,
	[ExploreAnimEnum.AnimName.count2to3] = ExploreAnimEnum.AnimName.count3to2,
	[ExploreAnimEnum.AnimName.count3to4] = ExploreAnimEnum.AnimName.count4to3
}

function ExploreDoor:onInit()
	self._count = 0
	self._totalCount = 0
end

function ExploreDoor:setName(name)
	self.go.name = name
end

function ExploreDoor:setupMO()
	self.mo:updateWalkable()
end

function ExploreDoor:onResLoaded()
	ExploreDoor.super.onResLoaded(self)

	local effect = self._displayTr:Find("effect")

	gohelper.setActive(effect, self.mo.isPreventItem)

	if self.mo.specialDatas[2] == "1" then
		self.hangComp:addHang("effect2", ResUrl.getExploreEffectPath("zj_01_jh_block_glow_red"))
	elseif self.mo.specialDatas[2] == "2" then
		self.hangComp:addHang("effect2", ResUrl.getExploreEffectPath("zj_01_jh_block_glow_blue"))
	elseif self.mo.specialDatas[2] == "3" then
		self.hangComp:addHang("effect2", ResUrl.getExploreEffectPath("zj_01_jh_block_glow_green"))
	end
end

function ExploreDoor:onUpdateCount(count, totalCount)
	if totalCount then
		self._count = count
		self._totalCount = totalCount

		self:playAnim(self:getIdleAnim())
	elseif count < self._count then
		if self._count == self._totalCount then
			self:playAnim(ExploreAnimEnum.AnimName.aToN)
		elseif self:_canChangeCountAnim() then
			self:playAnim(string.format("count%dto%d", self._count, count))
		end

		self._count = count
	elseif count > self._count then
		if count == self._totalCount then
			self:playAnim(ExploreAnimEnum.AnimName.nToA)
		elseif self:_canChangeCountAnim() then
			self:playAnim(string.format("count%dto%d", self._count, count))
		end

		self._count = count
	end
end

function ExploreDoor:_canChangeCountAnim()
	local animName = self.animComp._curAnim

	if animName == ExploreAnimEnum.AnimName.aToN or animName == ExploreAnimEnum.AnimName.nToA then
		return false
	end

	return true
end

function ExploreDoor:getIdleAnim()
	if self._count > 0 and self._count ~= self._totalCount then
		return "count" .. self._count
	else
		return ExploreDoor.super.getIdleAnim(self)
	end
end

function ExploreDoor:onActiveChange(nowActive)
	if not nowActive then
		self.mo:updateWalkable()
		self:checkLight()
	elseif self.animComp:isIdleAnim() then
		self.mo:updateWalkable()
		self:checkLight()
	end

	self:checkShowIcon()

	if self._totalCount == 0 then
		ExploreDoor.super.onActiveChange(self, nowActive)
	end
end

function ExploreDoor:canTrigger()
	if self.mo and self.mo:isInteractActiveState() then
		return false
	end

	return ExploreDoor.super.canTrigger(self)
end

function ExploreDoor:isPassLight()
	return self.mo:isWalkable()
end

function ExploreDoor:onAnimEnd(preAnim, nowAnim)
	self.mo:updateWalkable()
	self:checkLight()

	if not self.animComp:isIdleAnim(nowAnim) then
		return
	end

	local anim = self:getIdleAnim()

	if anim ~= nowAnim then
		self.animComp:playAnim(anim)
	end
end

function ExploreDoor:onEnter(...)
	if self.mo.isPreventItem then
		ExploreMapModel.instance:updateNodeCanPassItem(ExploreHelper.getKey(self.mo.nodePos), false)
	end

	ExploreDoor.super.onEnter(self, ...)
end

function ExploreDoor:onExit(...)
	if self.mo.isPreventItem then
		ExploreMapModel.instance:updateNodeCanPassItem(ExploreHelper.getKey(self.mo.nodePos), true)
	end

	ExploreDoor.super.onExit(self, ...)
end

return ExploreDoor
