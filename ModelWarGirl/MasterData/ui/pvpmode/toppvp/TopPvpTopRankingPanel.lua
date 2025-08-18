-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpTopRankingPanel.lua

local strClassName = "TopPvpTopRankingPanel"
local TopPvpTopRankingPanel = Class(strClassName, UIControls.Panel)

function TopPvpTopRankingPanel:ctor(...)
	self:initUI()
end

function TopPvpTopRankingPanel:initUI(...)
	self.panelRanking = UIControls.Image(self, self.mPath .. "/RankingPanel")
	self.btnHeads = {}

	for i = 1, 8 do
		self.btnHeads[i] = UIControls.PlayerHeadGridChild(self, self.mPath .. "/RankingPanel/Top" .. i .. "/GridPlayer", "System/Common/Grid/GridPlayerCommon")
		self.btnHeads[i].txtPlayerName = UIControls.Label(self, self.mPath .. "/RankingPanel/Top" .. i .. "/TextPlayerName")
		self.btnHeads[i].txtPower = UIControls.Label(self, self.mPath .. "/RankingPanel/Top" .. i .. "/TextPower")
	end

	self.bgEmpty = UIControls.Image(self, self.mPath .. "/BgEmpty")
	self.bgRanking = UIControls.RawImage(self, self.mPath .. "/BgRanking")
	self.efx = UIControls.LazyEffectPlayer(self, self.mPath .. "/BgRanking/Efx")
end

function TopPvpTopRankingPanel:refreshUI()
	local data = CurAvatar.cachedTopPvpRankData

	if data == nil then
		self.bgEmpty:setVisible(true)
		self.panelRanking:setVisible(false)
		self.bgRanking:setVisible(false)
	else
		self.bgEmpty:setVisible(false)
		self.panelRanking:setVisible(true)
		self.bgRanking:setVisible(true)
		self.efx:setVisible(true)

		for i = 1, 8 do
			self.btnHeads[i]:setCommInfo(data[i].comm, true, self)

			local name = utils.GetPlayerName(data[i].comm.name)

			self.btnHeads[i].txtPlayerName:setText(name)
			self.btnHeads[i].txtPower:setText(data[i].power)
		end
	end
end

return TopPvpTopRankingPanel
