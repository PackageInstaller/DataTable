-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Equip\\RelicPackOpenDlg.lua

local Relic = require("Common/Object/Relic")
local Item = require("Common/Object/Item")
local strClassName = "RelicPackOpenDlg"
local RelicPackOpenDlg = Class(strClassName, UIControls.Window)

function RelicPackOpenDlg:ctor()
	self:initUI()
end

function RelicPackOpenDlg:initUI()
	self.imgIconRelic = UIControls.Image(self, "BgPanel/IconRelic")
	self.efxRelic = UIControls.LazyEffectPlayer(self, "BgPanel/IconRelic/EfxRelic")
	self.imgBoxBase = UIControls.Image(self, "BgPanel/BoxPanel/ImgBoxBase")
	self.imgBoxLid = UIControls.Image(self, "BgPanel/BoxPanel/ImgBoxLid")
	self.efxBoxOpen = UIControls.LazyEffectPlayer(self, "BgPanel/EfxBoxOpen")
end

function RelicPackOpenDlg:setRelicPkgResult(items, relic, packId)
	self.items = items
	self.relic = relic
	self.packId = packId

	if self.packId and self.packId > 0 then
		local packItem = BaseObject.GetObject(self.packId)

		if packItem.resData and packItem.resData.sourceIconPath then
			local atlasPath = packItem.resData.sourceIconPath

			self.imgBoxBase:setImage(atlasPath, packItem.resData.icon .. "Base")
			self.imgBoxLid:setImage(atlasPath, packItem.resData.icon .. "Lid")

			local efxPath = "Effects/UI/efx_ui_RelicPack_Purple.prefab"

			if packItem.quality and packItem.quality > 4 then
				efxPath = "Effects/UI/efx_ui_RelicPack_Orange.prefab"
			end

			self.efxBoxOpen:playEffectByPath(efxPath)
		end
	end

	if items and #items > 0 then
		self.material = Item(items[1])
	end

	if relic and #relic > 0 then
		self.newRelic = BaseObject.GetObject(relic[1].id)
	end

	if self.material and CurAvatar then
		local relic = CurAvatar:getRelicByMaterial(self.material)

		if relic then
			self:setRelicShow(relic)
		end
	elseif self.newRelic then
		self:setRelicShow(self.newRelic)
	end
end

function RelicPackOpenDlg:setRelicShow(relic)
	local iconPath = relic:getIconPath()

	if iconPath then
		self.imgIconRelic:setImage(iconPath[1], iconPath[2])
	end

	local efxPath = "Effects/UI/efx_ui_RelicPack_Purple_1.prefab"

	if relic.quality and relic.quality > 4 then
		efxPath = "Effects/UI/efx_ui_RelicPack_Orange_1.prefab"
	end

	self.efxRelic:playEffectByPath(efxPath)
end

function RelicPackOpenDlg:onOpenOver()
	RelicPackOpenDlg.super.onOpenOver(self)

	if self.material or self.newRelic then
		local showRelicDlg = UIManager.getUI("showRelicDlg", true)

		showRelicDlg:setRelicPkgResult(self.material, self.newRelic)
	end

	if not self.dontClose then
		self:setVisible(false)
	end
end

return RelicPackOpenDlg
