-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleSkillDlg.lua

local strClassName = "BattleSkillDlg"
local BattleSkillDlg = Class(strClassName, UIControls.Window)

function BattleSkillDlg:ctor()
	return
end

function BattleSkillDlg:setData(heroId, selfCamp)
	if selfCamp then
		if not self.panelSelf then
			self.panelSelf = UIControls.Panel(self, "SelfPanel")
		end

		if self.panelEnemy then
			self.panelEnemy:setVisible(false)
		end

		self.panelSelf:setVisible(true)

		local imgRole = UIControls.Role(self, "SelfPanel/Mask/GridHeroPortrait", 0, 0)

		imgRole:showRole(heroId, UIConst.ROLEIMAGE_SHOWTYPE_BATTLE_SKILL)
	else
		if self.panelSelf then
			self.panelSelf:setVisible(false)
		end

		if not self.panelEnemy then
			self.panelEnemy = UIControls.Panel(self, "EnemyPanel")
		end

		self.panelEnemy:setVisible(true)

		local imgRole = UIControls.Role(self, "EnemyPanel/Mask/GridHeroPortrait", 0, 0)

		imgRole:showRole(heroId, UIConst.ROLEIMAGE_SHOWTYPE_BATTLE_SKILL)
	end
end

function BattleSkillDlg:onOpenOver()
	BattleSkillDlg.super.onOpenOver(self)
	self:setVisible(false)
end

return BattleSkillDlg
