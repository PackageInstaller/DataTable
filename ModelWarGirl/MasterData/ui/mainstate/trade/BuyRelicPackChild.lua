-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\BuyRelicPackChild.lua

local strClassName = "BuyRelicPackChild"
local BuyRelicPackChild = Class(strClassName, UIControls.Child)

function BuyRelicPackChild:ctor()
	self:initUI()
end

function BuyRelicPackChild:initUI()
	self.panelMaterialMax = UIControls.Panel(self, "BgMax")
	self.panelBgGet = UIControls.Panel(self, "BgGet")
end

function BuyRelicPackChild:setRelic(relic)
	self.relic = relic
	self.gridRelic = UIControls.RelicGridChild(self, "GridPanel", "System/Common/Grid/GridRelicItem", 0, 0, true)
	self.gridRelic.mEnableTips = true

	self.gridRelic:setObj(self.relic)
	self.gridRelic.bgLv:setVisible(false)

	local isHaved = CurAvatar and CurAvatar.bagRelics[self.relic.id] ~= nil
	local isMaxed = CurAvatar and not CurAvatar:relicIsCanGetMaterial(self.relic)

	self.panelBgGet:setVisible(isHaved)
	self.panelMaterialMax:setVisible(isHaved and isMaxed)
	self.gridRelic:setObjGray(isHaved and isMaxed)
end

return BuyRelicPackChild
