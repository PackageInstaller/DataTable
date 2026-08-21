-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\GridBuffWithMaster.lua

local GridBuffWithMaster = Class("GridBuffWithMaster", UIControls.BuffGridChild)

function GridBuffWithMaster:ctor()
	self.iconNewGet = UIControls.Panel(self, "IconNew")
	self.panelPlayer = UIControls.Panel(self, "TabPanel/PlayerPanel")
	self.txtName = UIControls.Label(self, "TabPanel/PlayerPanel/TextName")
	self.txtServer = UIControls.Label(self, "TabPanel/PlayerPanel/TextServe")
	self.panelSystem = UIControls.Panel(self, "TabPanel/SystemPanel")
end

function GridBuffWithMaster:initBuffData(buffData, master, newGet)
	self.master = master

	self:setBuff(buffData)

	if master then
		if not self.headGrid then
			self.headGrid = UIControls.PlayerHeadGridChild(self, "TabPanel/PlayerPanel/BgPlayer/GridPlayer", "System/Common/Grid/GridPlayerCommon")
		end

		self.headGrid:setVisible(true)
		self.headGrid:setPlayer(master, true, self)
		self.txtName:setText(master.name)
		self.txtServer:setText(master.serverName)
		self.panelPlayer:setVisible(true)
		self.panelSystem:setVisible(false)
	else
		self.panelPlayer:setVisible(false)
		self.panelSystem:setVisible(true)
	end

	if newGet then
		self.iconNewGet:setVisible(true)
	else
		self.iconNewGet:setVisible(false)
	end
end

function GridBuffWithMaster:_setBG()
	if self.buffData.model_flag then
		self.imgBg:setImage("Atlas/SeasonTowerAtlas/SeasonTowerBuffAtlas01", "BgBuffBack3")
		self.bgDesc:setImage("Atlas/SeasonTowerAtlas/SeasonTowerBuffAtlas01", "BgWordsBack2")
	elseif self.master then
		self.imgBg:setImage("Atlas/SeasonTowerAtlas/SeasonTowerBuffAtlas01", "BgBuffBack1")
		self.bgDesc:setImage("Atlas/SeasonTowerAtlas/SeasonTowerBuffAtlas01", "BgWordsBack")
	else
		self.imgBg:setImage("Atlas/SeasonTowerAtlas/SeasonTowerBuffAtlas01", "BgBuffBack2")
		self.bgDesc:setImage("Atlas/SeasonTowerAtlas/SeasonTowerBuffAtlas01", "BgWordsBack1")
	end
end

return GridBuffWithMaster
