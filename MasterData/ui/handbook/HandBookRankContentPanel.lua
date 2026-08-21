-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookRankContentPanel.lua

local strClassName = "HandBookRankContentPanel"
local HandBookRankContentPanel = Class(strClassName, UIControls.Panel)

function HandBookRankContentPanel:ctor()
	self:initUI()
end

function HandBookRankContentPanel:initUI()
	self.imgSelf = UIControls.RawImage(self, self.mPath)
	self.panelPlayerInfo = UIControls.Panel(self, self.mPath .. "/PlayerInfo")
	self.imgIconPlayer = UIControls.Image(self, self.mPath .. "/PlayerInfo/GridPlayer/IconPlayer")
	self.txtPlayerName = UIControls.Label(self, self.mPath .. "/PlayerInfo/TextPlayerName")
	self.txtNumTitle = UIControls.Label(self, self.mPath .. "/PlayerInfo/TextNumTitle")
	self.txtNum = UIControls.Label(self, self.mPath .. "/PlayerInfo/TextNum")
	self.txtNone = UIControls.Label(self, self.mPath .. "/TextNone")
end

function HandBookRankContentPanel:setContentPanel(data)
	self.data = data

	self.txtNone:setVisible(true)
	self.panelPlayerInfo:setVisible(false)
end

function HandBookRankContentPanel:setPlayerInfo(playerInfo)
	if playerInfo.comm.uid == "0" then
		self.playerInfo = nil

		return
	end

	self.playerInfo = playerInfo

	self.txtNone:setVisible(false)
	self.panelPlayerInfo:setVisible(true)
	self.txtNumTitle:setText(UIConst.RANK_UI_INFO[self.data.rankType].title2 .. "：")

	local playerName = utils.GetPlayerName(self.playerInfo.comm.name)

	self.txtPlayerName:setText(playerName)
	self.txtNum:setText(UIConst.getRankScoreStr(self.data.rankType, self.playerInfo.score))

	if not self.playerHead then
		self.playerHead = UIControls.PlayerHeadGridChild(self, self.mPath .. "/PlayerInfo/GridPlayer", "System/Common/Grid/GridPlayerCommon")

		self.playerHead:hideLevel()
		self.playerHead:setEnable(self.playerInfo.comm.uid ~= CurAvatar.uid)
	end

	local commonData = self.playerInfo.comm

	self.playerHead:setCommInfo(commonData, false, self)
end

return HandBookRankContentPanel
