-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Equip\\RelicUpgradeResultDlg.lua

local Relic = require("Common/Object/Relic")
local RelicTipsInfoPanel = require("UI/Common/Tips/RelicTipsInfoPanel")
local strClassName = "RelicUpgradeResultDlg"
local RelicUpgradeResultDlg = Class(strClassName, UIControls.Window)

function RelicUpgradeResultDlg:ctor()
	self:initUI()
end

function RelicUpgradeResultDlg:initUI()
	self.imgIcon = UIControls.Image(self, "BgPanel/RelicPanel/Icon")
	self.imgMax = UIControls.Image(self, "BgPanel/RelicPanel/ImgMax")
	self.txtName = UIControls.Label(self, "BgPanel/RelicPanel/Text")
	self.oriDes = UIControls.Label(self, "BgPanel/BeforePanel/Text")
	self.afterDes = UIControls.Label(self, "BgPanel/AfterPanel/Text")
	self.sliderEnhance = UIControls.Slider(self, "BgPanel/RelicPanel/SliderAfter")
	self.txtEnhanceNum = UIControls.Label(self, "BgPanel/RelicPanel/TextSliderAfter")
	self.txtBeforeEnhanceNum = UIControls.Label(self, "BgPanel/RelicPanel/TextSliderBefore")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.uiAni = UIControls.UIAni(self, "")

	self.uiAni:addEventAnimateCue(self.showSliderChange)
end

function RelicUpgradeResultDlg:onBtnCloseClick()
	self:setVisible(false)
end

function RelicUpgradeResultDlg:setRelic(relic)
	self.relic = relic

	local oriServerData = utils.deepcopy(self.relic._serverData)

	oriServerData.level = oriServerData.level - 1

	local oriRelic = Relic(oriServerData)
	local iconPath = self.relic:getIconPath()

	if iconPath then
		self.imgIcon:setImage(iconPath[1], iconPath[2])
	end

	self.txtName:setText(self.relic.name)

	local passiveResData = self.relic:getPassiveResData()

	if passiveResData then
		self.afterDes:setText(passiveResData.desc)
	end

	passiveResData = oriRelic:getPassiveResData()

	if passiveResData then
		self.oriDes:setText(passiveResData.desc)
	end

	local oriLvUpNeedInfo = oriRelic:getLvUpNeed()

	if oriLvUpNeedInfo then
		local haveNum = CurAvatar:getItemNumById(self.relic.lvUpMaterialId)
		local needNum = oriLvUpNeedInfo[self.relic.lvUpMaterialId]

		self.txtBeforeEnhanceNum:setText(haveNum + needNum .. "/" .. needNum)
	end
end

function RelicUpgradeResultDlg:showSliderChange(aniCom, eventKey)
	if eventKey == "SliderAfter" then
		local lvUpNeedInfo = self.relic:getLvUpNeed()

		if lvUpNeedInfo then
			local haveNum = CurAvatar:getItemNumById(self.relic.lvUpMaterialId)
			local needNum = lvUpNeedInfo[self.relic.lvUpMaterialId]

			self.txtEnhanceNum:setText(math.min(haveNum, needNum) .. "/" .. needNum)
			self.sliderEnhance:setValue(0)
			self.sliderEnhance:setVisible(true)
			self.txtEnhanceNum:setVisible(true)
			self.sliderEnhance:setValue(math.min(haveNum / needNum, 1), 0.4)
			self.txtEnhanceNum:setText(haveNum .. "/" .. needNum)
		else
			self.sliderEnhance:setVisible(false)
			self.txtEnhanceNum:setVisible(false)
			self.imgMax:setVisible(true)
		end
	end
end

return RelicUpgradeResultDlg
