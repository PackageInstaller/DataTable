-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PlotRewind\\PlotRewindStoryCellMixin.lua

local PlotRewindStoryCellMixin = {}
local ResAchieve = require("ClientData/ResAchieve")

function PlotRewindStoryCellMixin:initUI()
	if self.isInited then
		return
	end

	self.titleText = UIControls.Label(self, self.rootPath .. self.partition .. "TitleInfo/TitleText")
	self.slider = UIControls.Slider(self, self.rootPath .. self.partition .. "Slider")
	self.unlockText = UIControls.Label(self, self.rootPath .. self.partition .. "AttrGroup/TextAttr01")
	self.totalTxt = UIControls.Label(self, self.rootPath .. self.partition .. "AttrGroup/TextAttr02")
	self.bgImage = UIControls.RawImage(self, self.rootPath .. self.partition .. "MaskImage/StoryImage")
	self.clickBtn = UIControls.Button(self, self.rootPath)

	self.clickBtn:addEventClick(self.onBtnClick)

	self.isInited = true
end

function PlotRewindStoryCellMixin:_setData(storyInfo, cellRootPath)
	self:initUI()

	self.storyInfo = storyInfo

	if storyInfo.title then
		self.titleText:setText(storyInfo.title)
	end

	if storyInfo.bg_image then
		self.bgImage:setImage(storyInfo.bg_image)
	end

	self:setVisible(true)
end

function PlotRewindStoryCellMixin:onBtnClick()
	if self.isLocked then
		MsgManager.notice(Lang.get(45495))
	else
		local ui = UIManager.getUI("plotRewindDetailDlg", true)

		ui:setData(self.storyInfo)
	end
end

function PlotRewindStoryCellMixin:setLock(isLocked, lockDesc)
	self.isLocked = isLocked

	if self.lockNode then
		self.lockNode:setVisible(isLocked)
	end

	self.bgImage:setObjGray(isLocked)

	if self.lockImage then
		self.lockImage:setVisible(isLocked)
	end

	if lockDesc and isLocked then
		self.titleText:setText(lockDesc)
	else
		self.titleText:setText(self.storyInfo.title)
	end
end

function PlotRewindStoryCellMixin:setProgress(unlocked, total)
	self.unlockText:setText(unlocked)
	self.totalTxt:setText(total)

	local percent = unlocked / total

	self.slider:setValue(percent)
end

return PlotRewindStoryCellMixin
