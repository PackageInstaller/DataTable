-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroShowRoomVideoDlg.lua

local strClassName = "HeroShowRoomVideoDlg"
local HeroShowRoomVideoDlg = Class(strClassName, UIControls.Window)

function HeroShowRoomVideoDlg:ctor()
	self:initUI()
end

function HeroShowRoomVideoDlg:initUI()
	self.uiAni = UIControls.UIAni(self, "")

	self.uiAni:addEventFinish(self._onAniFinish)

	self.bgVideoCoverLeft = UIControls.Image(self, "MainInfoPanel/BgVideoLeft/BgVideoCover")
	self.videoContentCellLeft = UIControls.UIAni(self, "MainInfoPanel/BgVideoLeft/VideoContentCell")
	self.btnVideoLeft = UIControls.Button(self, "MainInfoPanel/BgVideoLeft/VideoContentCell/BtnVideo")

	self.btnVideoLeft:addEventClick(Functor(self.onBtnVideoClick, self, 1))

	self.textTitleLeft = UIControls.Label(self, "MainInfoPanel/BgVideoLeft/VideoContentCell/BtnVideo/TextTitle")
	self.videoLockPanelLeft = UIControls.Panel(self, "MainInfoPanel/BgVideoLeft/VideoContentCell/BtnVideo/VideoLockPanel")

	self.videoLockPanelLeft:setVisible(true)

	self.bgVideoCoverRight1 = UIControls.Image(self, "MainInfoPanel/BgVideoRight/BgVideoCover1")
	self.bgVideoCoverRight2 = UIControls.Image(self, "MainInfoPanel/BgVideoRight/BgVideoCover2")
	self.videoContentCellRight = UIControls.UIAni(self, "MainInfoPanel/BgVideoRight/VideoContentCell")
	self.btnVideoRight = UIControls.Button(self, "MainInfoPanel/BgVideoRight/VideoContentCell/BtnVideo")

	self.btnVideoRight:addEventClick(Functor(self.onBtnVideoClick, self, 2))

	self.textTitleRight = UIControls.Label(self, "MainInfoPanel/BgVideoRight/VideoContentCell/BtnVideo/TextTitle")
	self.videoLockPanelRight = UIControls.Panel(self, "MainInfoPanel/BgVideoRight/VideoContentCell/BtnVideo/VideoLockPanel")

	self.videoLockPanelRight:setVisible(true)

	self.bgTitle = UIControls.Label(self, "MainInfoPanel/BgTitle/TextTitle")
	self.btnClose = UIControls.Button(self, "MainInfoPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.frontBgCd2 = UIControls.Image(self, "MainInfoPanel/FrontPanel/BgCd2")
	self.frontBgCd4 = UIControls.Image(self, "MainInfoPanel/FrontPanel/BgCd4")
end

function HeroShowRoomVideoDlg:onBtnVideoClick(type)
	if type == 1 then
		if self.leftUnLocked then
			UIManager.playAVG(self.leftAvgId)
			self:setVisible(false)
		else
			MsgManager.notice(Lang.get(63943))
		end
	elseif self.rightUnLocked then
		UIManager.playAVG(self.rightAvgId)
		self:setVisible(false)
	else
		MsgManager.notice(Lang.get(63944))
	end
end

function HeroShowRoomVideoDlg:setVideoData(relationLv, maxLevel, colorData, plotData, titleDesc)
	self.bgTitle:setText(titleDesc)
	self.bgVideoCoverLeft:setColorByRGBA(colorData[1], colorData[2], colorData[3])
	self.bgVideoCoverRight1:setColorByRGBA(colorData[1], colorData[2], colorData[3])
	self.bgVideoCoverRight2:setColorByRGBA(colorData[1], colorData[2], colorData[3])
	self.frontBgCd2:setColorByRGBA(colorData[1], colorData[2], colorData[3])
	self.frontBgCd4:setColorByRGBA(colorData[1], colorData[2], colorData[3])

	if relationLv >= 5 then
		self.leftUnLocked = true

		if not self.notPlayedLeft then
			self.videoLockPanelLeft:setVisible(false)
		end

		if maxLevel <= relationLv then
			self.rightUnLocked = true

			if not self.notPlayedRight then
				self.videoLockPanelRight:setVisible(false)
			end
		end
	end

	local avgTitles = plotData.avg_title
	local avgIds = plotData.avg_id

	self.textTitleLeft:setText(avgTitles[1])
	self.textTitleRight:setText(avgTitles[2])

	self.leftAvgId = avgIds[1]
	self.rightAvgId = avgIds[2]
end

function HeroShowRoomVideoDlg:setAcquireIconPath(itemIconPath)
	if not itemIconPath then
		self.notPlayedLeft = true
	else
		self.itemIconPath = itemIconPath
		self.notPlayedRight = true
	end
end

function HeroShowRoomVideoDlg:setCallBack(func)
	self.callbackFunc = func
end

function HeroShowRoomVideoDlg:onBtnCloseClick()
	if not self.isPlaying then
		self:setVisible(false)
	end
end

function HeroShowRoomVideoDlg:_onAniFinish(aniCom, aniName)
	if aniName == "InHeroShowRoomVideoCanvas" and self.leftUnLocked then
		if self.notPlayedLeft then
			self.isPlaying = true

			if self.callbackFunc then
				self.callbackFunc()
			end

			self.videoContentCellLeft:startAni("ShowVideoUnLock", true)
			self.videoContentCellLeft:addEventFinish(function()
				self.isPlaying = false

				UIManager.playAVG(self.leftAvgId)
			end)
		else
			self.videoLockPanelLeft:setVisible(false)
		end

		if self.rightUnLocked then
			if self.notPlayedRight then
				self.isPlaying = true

				if self.callbackFunc then
					self.callbackFunc()
				end

				self.videoContentCellRight:startAni("ShowVideoUnLock", true)
				self.videoContentCellRight:addEventFinish(function()
					self.isPlaying = false

					UIManager.playAVG(self.rightAvgId, nil, function()
						local heroShowRoomAcquireDlg = UIManager.getUI("heroShowRoomAcquireDlg", true)

						heroShowRoomAcquireDlg:setAcquireData(true, self.itemIconPath)
					end)
					self:setVisible(false)
				end)
			else
				self.videoLockPanelRight:setVisible(false)
			end
		end
	end
end

return HeroShowRoomVideoDlg
