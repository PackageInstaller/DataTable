-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\WorldBoss\\WorldBossAnnounceDlg.lua

local WorldBossCommon = require("Logic/WorldBoss/WorldBossCommon")
local strClassName = "WorldBossAnnounceDlg"
local WorldBossAnnounceDlg = Class(strClassName, UIControls.Window)

function WorldBossAnnounceDlg:ctor(...)
	self:initUI()
end

function WorldBossAnnounceDlg:initUI(...)
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.txtDesc = UIControls.Label(self, "BgPanel/BossInfo/TextDes")
	self.txtTime = UIControls.Label(self, "BgPanel/TextTime")
	self.imgIconLv = UIControls.Image(self, "BgPanel/BossInfo/IconLv")
	self.imgName = UIControls.Image(self, "BgPanel/BossInfo/ImgName")
	self.skillCells = {}

	for i = 1, 4 do
		local skillGrid = UIControls.HeroSkillGridChild(self, "BgPanel/BossInfo/SkillPanel", "System/Hero/GridHeroSkill", 0, 0, true)

		table.insert(self.skillCells, skillGrid)
	end

	self.loadLive2D = nil
end

function WorldBossAnnounceDlg:show(...)
	self:refreshUI()
end

function WorldBossAnnounceDlg:refreshUI(...)
	self:refreshTime()
	self:initData()
end

function WorldBossAnnounceDlg:initData(...)
	self.bossInfo = WorldBossCommon.getNextBossInfo()

	if self.loadLive2D ~= nil then
		self.loadLive2D:destroy()
	end

	self.loadLive2D = UIControls.Child(self, "BgPanel/Live2DPanel", "System/WorldBoss/WorldBossCell" .. self.bossInfo.type .. "S", 0, 0, true)

	local battleInfo = WorldBossCommon.getNextBossBattleInfo()

	for i, cell in ipairs(self.skillCells) do
		if battleInfo[Const.SKILL_FIELD_LIST[i]] then
			cell:setObj(battleInfo[Const.SKILL_FIELD_LIST[i]], battleInfo)

			cell.gridPanel = UIConst.SKILL_PANEL_WORLD_BOSS_NEXT

			cell:setVisible(true)
		else
			cell:setVisible(false)
		end
	end

	self.imgName:setImage("Atlas/WorldBossAtlas/WorldBossAtlas", "TxtWorldBoss" .. self.bossInfo.type)
	self.txtDesc:setText(self.bossInfo.desc)

	local iconPath = WorldBossCommon.getDifficultIconPath(self.bossInfo.hard)

	self.imgIconLv:setImage(iconPath[1], iconPath[2])
end

function WorldBossAnnounceDlg:refreshTime(...)
	local leftTime = WorldBossCommon.getNextBossLeftTime()

	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, nil, Lang.get(48702), nil, nil)
end

function WorldBossAnnounceDlg:onBtnConfirmClick(...)
	self:setVisible(false)
end

return WorldBossAnnounceDlg
