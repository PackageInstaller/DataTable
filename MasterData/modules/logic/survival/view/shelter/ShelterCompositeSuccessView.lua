-- chunkname: @modules/logic/survival/view/shelter/ShelterCompositeSuccessView.lua

module("modules.logic.survival.view.shelter.ShelterCompositeSuccessView", package.seeall)

local ShelterCompositeSuccessView = class("ShelterCompositeSuccessView", BaseView)

function ShelterCompositeSuccessView:onInitView()
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self.goInfoView = gohelper.findChild(self.viewGO, "#go_infoview")
end

function ShelterCompositeSuccessView:addEvents()
	self.addClickCb(self, self.btnClose, self.onClickCloseBtn, self)
end

function ShelterCompositeSuccessView:removeEvents()
	self:removeClickCb(self.btnClose)
end

function ShelterCompositeSuccessView:onClickCloseBtn()
	self:closeThis()
end

function ShelterCompositeSuccessView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_wangshi_argus_level_finish)

	self.itemMo = self.viewParam and self.viewParam.itemMo

	self:refreshView()
end

function ShelterCompositeSuccessView:refreshView()
	local itemMo = self.itemMo

	if not itemMo then
		gohelper.setActive(self.goInfoView, false)

		return
	end

	gohelper.setActive(self.goInfoView, true)

	if not self._infoPanel then
		local infoViewRes = self.viewContainer:getSetting().otherRes.infoView
		local infoGo = self.viewContainer:getResInst(infoViewRes, self.goInfoView)

		self._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(infoGo, SurvivalBagInfoPart)

		local t = {
			[SurvivalEnum.ItemSource.Map] = SurvivalEnum.ItemSource.Info,
			[SurvivalEnum.ItemSource.Shelter] = SurvivalEnum.ItemSource.Info
		}

		self._infoPanel:setChangeSource(t)
	end

	self._infoPanel:updateMo(itemMo)
end

return ShelterCompositeSuccessView
