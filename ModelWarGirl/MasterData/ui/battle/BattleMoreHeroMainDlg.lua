-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleMoreHeroMainDlg.lua

local BattleMainDlg = require("UI/Battle/BattleMainDlg")
local BattleMainBase = require("UI/Battle/BattleMainBase")
local STATE_NORMAL = 0
local STATE_FULL = 1
local STATE_WAIT = 2
local STATE_DEAD = 3
local BattleMoreHeroCell = Class("BattleMoreHeroCell", BattleMainBase.BattleHeroCellBase)

function BattleMoreHeroCell:ctor()
	self.bgBloodBlack = UIControls.Image(self, self.mPath .. "/BgBloodBlack")
end

function BattleMoreHeroCell:refreshState()
	BattleMoreHeroCell.super.refreshState(self)

	if self.state == STATE_FULL then
		self.bgBloodBlack:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BgBossHeroBackSel")
	elseif self.state == STATE_WAIT then
		self.bgBloodBlack:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BgBossHeroBackSel")
	elseif self.state == STATE_DEAD then
		self.bgBloodBlack:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BgBossHeroBackDis")
	else
		self.bgBloodBlack:setImage("Atlas/BattleAtlas/BattleMainAtlas", "BgBossHeroBackNml")
	end
end

local strClassName = "BattleMoreHeroMainDlg"
local BattleMoreHeroMainDlg = Class(strClassName, BattleMainDlg)

function BattleMoreHeroMainDlg:ctor()
	return
end

function BattleMoreHeroMainDlg:setDlgConfig()
	self.heroCellClass = BattleMoreHeroCell
	self.heroNum = 9
end

return BattleMoreHeroMainDlg
