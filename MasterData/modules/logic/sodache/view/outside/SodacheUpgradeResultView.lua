-- chunkname: @modules/logic/sodache/view/outside/SodacheUpgradeResultView.lua

module("modules.logic.sodache.view.outside.SodacheUpgradeResultView", package.seeall)

local SodacheUpgradeResultView = class("SodacheUpgradeResultView", BaseView)

function SodacheUpgradeResultView:onInitView()
	self._simageBuild = gohelper.findChildSingleImage(self.viewGO, "#simage_Build")
	self._txtName = gohelper.findChildText(self.viewGO, "Name/#txt_Name")
	self._txtLastLevel = gohelper.findChildText(self.viewGO, "Level/#txt_LastLevel")
	self._goArrow = gohelper.findChild(self.viewGO, "Level/#go_Arrow")
	self._txtCurLevel = gohelper.findChildText(self.viewGO, "Level/#txt_CurLevel")
	self._txtDesc = gohelper.findChildText(self.viewGO, "Unlock/#txt_Desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheUpgradeResultView:onClickModalMask()
	self:closeThis()
end

function SodacheUpgradeResultView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_7.Sodache.building_lvup_popup)

	self.data = self.viewParam

	local outsideMo = SodacheModel.instance:getOutsideMo()
	local buildingMo = outsideMo.buildingBox:getBuildingMo(self.data.type)
	local curLvl = buildingMo.level

	self._txtName.text = buildingMo.co.name
	self._txtLastLevel.text = "Lv." .. tostring(curLvl - 1)
	self._txtCurLevel.text = "Lv." .. tostring(curLvl)
	self._txtDesc.text = buildingMo.co.unlockDesc

	gohelper.setActive(self._txtLastLevel, curLvl > 1)
	gohelper.setActive(self._goArrow, curLvl > 1)
	self._simageBuild:LoadImage(ResUrl.getSodacheSingleBg(buildingMo.co.icon, "build"))
end

function SodacheUpgradeResultView:onCloseFinish()
	SodacheController.instance:dispatchEvent(SodacheEvent.PlayBuildingUpEffect, self.data.type)
end

return SodacheUpgradeResultView
