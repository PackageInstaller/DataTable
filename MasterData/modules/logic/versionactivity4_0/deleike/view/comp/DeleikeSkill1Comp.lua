-- chunkname: @modules/logic/versionactivity4_0/deleike/view/comp/DeleikeSkill1Comp.lua

module("modules.logic.versionactivity4_0.deleike.view.comp.DeleikeSkill1Comp", package.seeall)

local DeleikeSkill1Comp = class("DeleikeSkill1Comp", LuaCompBase)

function DeleikeSkill1Comp:init(go)
	self.skillId = 1
	self.go = go
	self.transform = go.transform
	self.childItems = {}

	for _, v in pairs(DeleikeEnum.LineStatus) do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(go, tostring(v))
		item.anim = gohelper.findComponentAnim(item.go)
		self.childItems[v] = item
	end

	self.goLight = gohelper.findChild(go, "light")
	self._releaseLightActive = false
	self.status = nil
end

function DeleikeSkill1Comp:onDestroy()
	TaskDispatcher.cancelTask(self.delayHide, self)
	TaskDispatcher.cancelTask(self._hideReleaseLight, self)
end

function DeleikeSkill1Comp:setLineStatus(status)
	if self.status == status then
		return
	end

	for k, item in pairs(self.childItems) do
		gohelper.setActive(item.go, k == status)
	end

	if self.status then
		self.childItems[status].anim:Play("switch_in", 0, 0)
	end

	self.status = status
end

function DeleikeSkill1Comp:onTrigger(leftQuad, rightQuad, centerX, centerY, dirX, dirY, length)
	if not leftQuad or not rightQuad then
		return
	end

	local toProcess = DeleikeHelper.getSharedTiles()

	for i = 1, #toProcess do
		local comp = toProcess[i]

		if not gohelper.isNil(comp.go) then
			DeleikeClipHelper.ClipTile(comp, leftQuad, rightQuad, true)
		end
	end

	DeleikeGameMgr.instance:addLineTile(centerX, centerY, dirX, dirY)

	local bx = centerX + dirX * length
	local by = centerY + dirY * length

	self:_applyMove(bx, by, dirX, dirY, length)
	self:_eatTriggersInSkillBox(centerX, centerY, dirX, dirY, length)
end

function DeleikeSkill1Comp:_applyMove(bx, by, dirX, dirY, length)
	local unitCoord = DeleikeGameMgr.instance.unitCoord

	if not unitCoord then
		return
	end

	local behindUnits = unitCoord:getUnitsBehindB(bx, by, dirX, dirY)

	unitCoord:moveUnitsAnimated(behindUnits, -dirX * length, -dirY * length)
end

function DeleikeSkill1Comp:_eatTriggersInSkillBox(centerX, centerY, dirX, dirY, length)
	local perpX, perpY = -dirY, dirX
	local hw = DeleikeEnum.SkillWidth * 0.5
	local endX = centerX + dirX * length
	local endY = centerY + dirY * length
	local quad = {
		{
			x = centerX - perpX * hw,
			y = centerY - perpY * hw
		},
		{
			x = endX - perpX * hw,
			y = endY - perpY * hw
		},
		{
			x = endX + perpX * hw,
			y = endY + perpY * hw
		},
		{
			x = centerX + perpX * hw,
			y = centerY + perpY * hw
		}
	}
	local unitCoord = DeleikeGameMgr.instance.unitCoord

	if unitCoord then
		if not unitCoord.triggerList then
			local triggers = {}

			for i = 1, #triggers do
				local comp = triggers[i]

				if comp.tryEat and not gohelper.isNil(comp.go) and not comp.isCollected and DeleikeCollision.pointInConvexPoly(comp.worldPos.x, comp.worldPos.y, quad) then
					comp:tryEat()
				end
			end
		end
	end
end

function DeleikeSkill1Comp:fadeIn()
	TaskDispatcher.cancelTask(self.delayHide, self)
	gohelper.setActive(self.go, true)

	if not self.status then
		return
	end

	local item = self.childItems[self.status]

	if item and item.go.activeInHierarchy then
		item.anim:Play("open", 0, 0)
	end
end

function DeleikeSkill1Comp:fadeOut()
	if self.status then
		local item = self.childItems[self.status]

		if item and item.go.activeInHierarchy then
			item.anim:Play("close", 0, 0)
			TaskDispatcher.runDelay(self.delayHide, self, 0.16)
		else
			self:delayHide()
		end
	else
		self:delayHide()
	end
end

function DeleikeSkill1Comp:delayHide()
	gohelper.setActive(self.go, false)
end

function DeleikeSkill1Comp:isReleaseVisualActive()
	return self._releaseLightActive
end

function DeleikeSkill1Comp:showReleaseLight()
	TaskDispatcher.cancelTask(self._hideReleaseLight, self)

	self._releaseLightActive = true

	gohelper.setActive(self.goLight, true)

	local showGo = self.childItems[DeleikeEnum.LineStatus.CanCut].go

	gohelper.setActive(showGo, false)
	TaskDispatcher.runDelay(self._hideReleaseLight, self, 1)
end

function DeleikeSkill1Comp:_hideReleaseLight()
	self._releaseLightActive = false

	gohelper.setActive(self.goLight, false)
	gohelper.setActive(self.go, false)
end

function DeleikeSkill1Comp:cancelReleaseVisual()
	TaskDispatcher.cancelTask(self._hideReleaseLight, self)

	self._releaseLightActive = false

	gohelper.setActive(self.goLight, false)
	gohelper.setActive(self.go, false)
end

return DeleikeSkill1Comp
