-- chunkname: @IQIGame\\UI\\Activity\\WelcomeNew\\WelcomeNewFriendCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	if self.PlayerHead then
		self.playerHead = PlayerHeadUI.New(self.PlayerHead)
	end
end

function m:SetData(index, data)
	self.friendData = data

	if self.friendData then
		local isDouble = index % 2 == 0

		self.BgOdd:SetActive(not isDouble)
		self.BgEven:SetActive(isDouble)
		UGUIUtil.SetText(self.PlayerNameText, self.friendData.pod.pName)

		local str = self:GetMazeChapter()

		UGUIUtil.SetText(self.Value1Text, str)

		if self.playerHead then
			self.playerHead:SetData(self.friendData.pod.headIcon, self.friendData.pod.pLv, self.friendData.pod.avatarFrame)
		end
	end
end

function m:GetMazeChapter()
	local str = ""

	if self.friendData.lastMazeId > 0 then
		local cfg = CfgMazeInstanceTable[self.friendData.lastMazeId]
		local Order1 = CfgChapterTable[cfg.ChapterId].Order

		if cfg then
			str = WelcomeInvitedHistoryUIApi:GetString("Value1Text", Order1, cfg.Order)
		end
	end

	return str
end

function m:Dispose()
	if self.playerHead then
		self.playerHead:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
