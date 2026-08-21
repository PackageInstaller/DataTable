-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeRollerInfoPanel.lua

local strClassName = "NewMazeRollerInfoPanel"
local NewMazeRollerInfoPanel = Class(strClassName, UIControls.Child)

function NewMazeRollerInfoPanel:ctor(...)
	self:initUI()
end

function NewMazeRollerInfoPanel:initUI()
	self.imgHero = UIControls.Image(self, "BgCalendar/ImgHero")
	self.imgMap = UIControls.Image(self, "RollerMask/MapPanel/ImgMap")
	self.imgMap1 = UIControls.RawImage(self, "RollerMask/MapPanel/ImgMap")
	self.imgMap2 = UIControls.RawImage(self, "RollerMask/MapPanel/ImgMap1")
	self.mapPanel = UIControls.UIAni(self, "RollerMask/MapPanel")
	self.panelSelf = UIControls.Panel(self, "")
end

function NewMazeRollerInfoPanel:setData(heroId)
	if self.mParent.levelType then
		self.imgMap1:setImage("NoAlpha/Rogue/BgRoller0" .. self.mParent.levelType)
		self.imgMap2:setImage("NoAlpha/Rogue/BgRoller0" .. self.mParent.levelType)
	end

	local iconPath = self.mParent.newMazeData.miscData.init_hero_icon_path

	if iconPath then
		self.imgHero:setImage(iconPath, "BgCalendar" .. heroId)
	end
end

function NewMazeRollerInfoPanel:playRollerAnimator(name)
	self.panelSelf:playAnimator(name)
end

function NewMazeRollerInfoPanel:playMapAni(name)
	self.mapPanel:startAni(name)
end

function NewMazeRollerInfoPanel:stopMapAni(name)
	self.mapPanel:stopAni(name)
end

return NewMazeRollerInfoPanel
