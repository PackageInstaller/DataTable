-- chunkname: @modules/logic/summon/view/variant/SummonEquipProbUpVer111.lua

module("modules.logic.summon.view.variant.SummonEquipProbUpVer111", package.seeall)

local SummonEquipProbUpVer111 = class("SummonEquipProbUpVer111", SummonMainEquipProbUp)

SummonEquipProbUpVer111.preloadList = {
	ResUrl.getSummonCoverBg("equipversion_1_1/full/bg"),
	ResUrl.getSummonCoverBg("equipversion_1_1/img_equip1"),
	ResUrl.getSummonCoverBg("equipversion_1_1/img_equip2"),
	ResUrl.getSummonCoverBg("equipversion_1_1/img_equip3"),
	ResUrl.getSummonCoverBg("hero/title_img_deco")
}

function SummonEquipProbUpVer111:refreshSingleImage()
	self._simagebg:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/full/bg"))
	self._simageequip1:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/img_equip1"))
	self._simageequip2:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/img_equip2"))
	self._simageequip3:LoadImage(ResUrl.getSummonCoverBg("equipversion_1_1/img_equip3"))
	self._simageline:LoadImage(ResUrl.getSummonCoverBg("hero/title_img_deco"))
end

function SummonEquipProbUpVer111:unloadSingleImage()
	self._simagebg:UnLoadImage()
	self._simageequip1:UnLoadImage()
	self._simageequip2:UnLoadImage()
	self._simageequip3:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
end

return SummonEquipProbUpVer111
