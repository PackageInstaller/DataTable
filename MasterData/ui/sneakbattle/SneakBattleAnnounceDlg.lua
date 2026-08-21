-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\SneakBattle\\SneakBattleAnnounceDlg.lua

local ResNewPveIndex = require("ClientData/ResNewPveIndex")
local ResNewPveBuff = require("ClientData/ResNewPveBuff")
local SneakBattleAnnounceDlg = Class("SneakBattleAnnounceDlg", UIControls.Window)

function SneakBattleAnnounceDlg:ctor(...)
	self:initUI()
end

function SneakBattleAnnounceDlg:initUI(...)
	self.txtTime = UIControls.Label(self, "BgPanel/BgTime/TextTime")
	self.imgName = UIControls.Image(self, "BgPanel/BossInfo/ImgName")
	self.icon = UIControls.Image(self, "BgPanel/BossInfo/BattleBuffInfo/Icon")
	self.txtTitle = UIControls.Label(self, "BgPanel/BossInfo/BattleBuffInfo/TextTitle")
	self.txtDesc = UIControls.Label(self, "BgPanel/BossInfo/BattleBuffInfo/TextDesc")
end

function SneakBattleAnnounceDlg:setData(index)
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	local actData = CurAvatar:getSneakBattleActivityData()

	if actData then
		local remainTime = actData:getCurLeftTime()

		if remainTime then
			ClientTimerManager.AddSecondFormatTickUI(self.txtTime, remainTime, false, Lang.get(48695), nil)
		end
	end

	if not index or not ResNewPveIndex[index] then
		return
	end

	local type = ResNewPveIndex[index].type

	self.imgName:setImage("Atlas/SneakBattleAtlas/SneakBattleBossTitleAtlas", "TxtSneakBattleBoss" .. type)

	local buffID = ResNewPveIndex[index].buff

	if not ResNewPveBuff or not ResNewPveBuff[buffID] then
		return
	end

	local buffData = ResNewPveBuff[buffID]

	if buffData then
		self.icon:setImage(buffData.icon_path, buffData.icon_name)
		self.txtTitle:setText(buffData.name)
		self.txtDesc:setText(buffData.desc)
	end
end

return SneakBattleAnnounceDlg
