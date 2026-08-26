-- chunkname: @modules/logic/enemyinfo/model/EnemyInfoLayoutMo.lua

module("modules.logic.enemyinfo.model.EnemyInfoLayoutMo", package.seeall)

local EnemyInfoLayoutMo = pureTable("EnemyInfoLayoutMo")

function EnemyInfoLayoutMo:ctor()
	self.showLeftTab = false
	self.viewWidth = 0
	self.tabWidth = 0
	self.leftTabWidth = 0
	self.rightTabWidth = 0
	self.enemyInfoWidth = 0
end

function EnemyInfoLayoutMo:updateLayout(viewWidth, showLeftTab)
	self.showLeftTab = showLeftTab
	self.viewWidth = viewWidth
	self.tabWidth = 0

	if self.showLeftTab then
		self.tabWidth = EnemyInfoEnum.TabWidth
		self.viewWidth = self.viewWidth - self.tabWidth
	end

	local leftRatio = EnemyInfoEnum.LeftTabRatio
	local rightRatio = EnemyInfoEnum.RightTabRatio

	if self.showLeftTab then
		leftRatio = leftRatio + EnemyInfoEnum.WithTabOffset.LeftRatio
		rightRatio = rightRatio + EnemyInfoEnum.WithTabOffset.RightRatio
	end

	self.leftTabWidth = self.viewWidth * leftRatio
	self.rightTabWidth = self.viewWidth * rightRatio
end

function EnemyInfoLayoutMo:setEnemyInfoWidth(width)
	self.enemyInfoWidth = width
end

function EnemyInfoLayoutMo:setScrollEnemyWidth(width)
	self.scrollEnemyWidth = width
end

function EnemyInfoLayoutMo:getScrollEnemyLeftMargin()
	if self.showLeftTab then
		return EnemyInfoEnum.ScrollEnemyMargin.Left + EnemyInfoEnum.WithTabOffset.ScrollEnemyLeftMargin
	end

	return EnemyInfoEnum.ScrollEnemyMargin.Left
end

function EnemyInfoLayoutMo:getEnemyInfoLeftMargin()
	if self.showLeftTab then
		return EnemyInfoEnum.EnemyInfoMargin.Left + EnemyInfoEnum.WithTabOffset.EnemyInfoLeftMargin
	end

	return EnemyInfoEnum.EnemyInfoMargin.Left
end

return EnemyInfoLayoutMo
