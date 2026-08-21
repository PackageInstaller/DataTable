-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Equip\\ShowRelicDlg.lua

local Relic = require("Common/Object/Relic")
local Item = require("Common/Object/Item")
local strClassName = "ShowRelicDlg"
local ShowRelicDlg = Class(strClassName, UIControls.Window)

function ShowRelicDlg:ctor()
	self:initUI()
end

function ShowRelicDlg:initUI()
	self.txtAddExp = UIControls.Label(self, "Bg/TextNum")
	self.imgIconNew = UIControls.Image(self, "Bg/IconNew")
end

function ShowRelicDlg:setRelicPkgResult(material, newRelic)
	self.material = material
	self.newRelic = newRelic
	self.gridRelic = UIControls.RelicGridChild(self, "Bg/RelicPanel", "System/Common/Grid/GridRelicItem", 0, 0, true)

	self.imgIconNew:setVisible(self.newRelic ~= nil)

	if self.material then
		if CurAvatar and CurAvatar.bagRelics then
			local relic = CurAvatar:getRelicByMaterial(self.material)

			if relic then
				self.gridRelic:setObj(relic)

				local lvUpNeedInfo = relic:getLvUpNeed()

				if lvUpNeedInfo then
					local haveNum = CurAvatar:getItemNumById(relic.lvUpMaterialId)
					local needNum = lvUpNeedInfo[relic.lvUpMaterialId]

					self.gridRelic.sliderEnhance:setValue(math.min((CurAvatar:getItemNumById(relic.lvUpMaterialId) - self.material.num) / needNum, 1))
					self.gridRelic.sliderEnhance:setVisible(true)
					self.gridRelic.txtEnhanceNum:setVisible(true)
					self.gridRelic.sliderEnhance:setValue(math.min(haveNum / needNum, 1), 0.4)
					self.gridRelic.txtEnhanceNum:setText(haveNum .. "/" .. needNum)
					self.txtAddExp:setVisible(true)
					self.txtAddExp:setText("+" .. self.material.num)
				end
			end
		end
	elseif self.newRelic then
		self.gridRelic:setObj(self.newRelic)
		self.gridRelic.sliderEnhance:setVisible(false)
		self.gridRelic.txtEnhanceNum:setVisible(false)
		self.txtAddExp:setVisible(false)
	end
end

return ShowRelicDlg
