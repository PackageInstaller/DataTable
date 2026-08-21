-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/component/EquipTipsDetailInfoComponent.lua

module("logic.extensions.charactersystem.view.equip.component.EquipTipsDetailInfoComponent", package.seeall)

local M = class("EquipTipsDetailInfoComponent", EquipDetailInfoComponent)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)

	self._typeName = nil
	self._imgQuality = nil
end

function M:_initNodeExtra()
	self._typeName = self._registry:getTextByPath("node/top/txtTab")
	self._imgQuality = self._registry:getImageByPath("node/scroll/view/content/content1/imgQuailty")
end

function M:refreshStatus()
	M.super.refreshStatus(self)

	local isVisible = not self._lockRootGo.activeSelf and not self._headGo.activeSelf

	goutil.setActive(self._typeName.gameObject, isVisible)

	if isVisible then
		self._typeName.text = BackpackOtherConfig.instance:getTypeNameByTS(self._equipMo:getType(), self._equipMo:getSubType())
	end

	local quality = self._equipMo:getQuality()

	IconLoader.setSprite(self._imgQuality, IconType.Skinlib, CommEnum.Quality2TipsWordIcon[quality])
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._typeName = nil
	self._imgQuality = nil
end

return M
