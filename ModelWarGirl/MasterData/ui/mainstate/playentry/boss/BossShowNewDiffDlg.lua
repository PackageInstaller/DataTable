-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Boss\\BossShowNewDiffDlg.lua

local strClassName = "BossShowNewDiffDlg"
local BossShowNewDiffDlg = Class(strClassName, UIControls.Window)

function BossShowNewDiffDlg:ctor(...)
	self:initUI()
end

function BossShowNewDiffDlg:initUI(...)
	self.imgPreDiff = UIControls.Image(self, "BgDifficult/ImgCircle/IconDifficult")
	self.imgAfterDiff = UIControls.Image(self, "BgDifficult/ImgCircle/IconDifficult1")

	local uis = {
		"BgDifficult",
		"BgHighest"
	}

	for i, path in ipairs(uis) do
		local btn = UIControls.Button(self, path .. "/BtnBlock")

		btn:addEventClick(self.onBtnBlockClick)
	end

	self.slotAniFinishCB = Slot(self.onAniFinish, self)
end

function BossShowNewDiffDlg:show()
	local func
	local data = CurAvatar.bossExpandLevelTip

	if data.isNewDiff or data.isNewLayer then
		func = self._newDiffAni
		data.isNewDiff = nil
		self.diffAni = true

		if data.isNewLayer then
			local ui = UIManager.tryGetUI("bossExpandMainDlg")

			if ui then
				ui:hideLayerBtnForAni()
			end

			data.isNewLayer = nil
			self.layerAni = true
		end
	elseif data.isHighest then
		func = self._highestDiffAni
		data.isHighest = nil
		self.diffAni = true
	end

	self.imgPreDiff:setImage("Atlas/OtherBattleAtlas/ChallengeBossAtlas4", "IconDifficulty0" .. data.level)
	self.imgAfterDiff:setImage("Atlas/OtherBattleAtlas/ChallengeBossAtlas4", "IconDifficulty0" .. data.level + 1)

	if not data.isNewLayer and not data.isHighest and not data.isNewDiff then
		CurAvatar.bossExpandLevelTip = nil
	end

	if func then
		func(self)
	end
end

function BossShowNewDiffDlg:_newLayerAni(...)
	self:playAni("ShowChallengeBossLevel", self.slotAniFinishCB)

	return 2
end

function BossShowNewDiffDlg:_newDiffAni(...)
	self:playAni("ShowChallengeBossDifficult", self.slotAniFinishCB)

	return 2
end

function BossShowNewDiffDlg:_highestDiffAni(...)
	self:playAni("ShowChallengeBossHighest", self.slotAniFinishCB)

	return 4
end

function BossShowNewDiffDlg:_close(...)
	self:setVisible(false)
end

function BossShowNewDiffDlg:onAniFinish(...)
	self:setVisible(false)
end

function BossShowNewDiffDlg:onBtnBlockClick(...)
	self:setVisible(false)
end

function BossShowNewDiffDlg:destroy(...)
	BossShowNewDiffDlg.super.destroy(self)

	if self.coFunc then
		coroutine.stop(self.coFunc)

		self.coFunc = nil
	end

	local ui = UIManager.tryGetUI("bossExpandMainDlg")

	if ui then
		ui:playShowAni(self.layerAni, self.diffAni)
	end
end

return BossShowNewDiffDlg
