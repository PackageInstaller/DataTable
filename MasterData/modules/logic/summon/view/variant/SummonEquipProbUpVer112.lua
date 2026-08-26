-- chunkname: @modules/logic/summon/view/variant/SummonEquipProbUpVer112.lua

module("modules.logic.summon.view.variant.SummonEquipProbUpVer112", package.seeall)

local SummonEquipProbUpVer112 = class("SummonEquipProbUpVer112", SummonMainEquipProbUp)

SummonEquipProbUpVer112.preloadList = {
	ResUrl.getSummonCoverBg("equipversion_1_1/full/bg1"),
	ResUrl.getSummonCoverBg("equipversion_1_1/img_equip4"),
	ResUrl.getSummonCoverBg("equipversion_1_1/img_equip5"),
	ResUrl.getSummonCoverBg("equipversion_1_1/img_equip6"),
	ResUrl.getSummonCoverBg("hero/title_img_deco")
}

function SummonEquipProbUpVer112:refreshSingleImage()
	self._simagebg:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/full/bg1"))
	self._simageequip1:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/img_equip4"))
	self._simageequip2:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/img_equip5"))
	self._simageequip3:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/img_equip6"))
	self._simageline:LoadImage(ResUrl.getSummonCoverBg("hero/title_img_deco"))
end

function SummonEquipProbUpVer112:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simageequip1:UnLoadImage()
	self._simageequip2:UnLoadImage()
	self._simageequip3:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonEquipProbUpVer112
