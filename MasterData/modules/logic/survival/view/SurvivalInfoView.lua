-- chunkname: @modules/logic/survival/view/SurvivalInfoView.lua

module("modules.logic.survival.view.SurvivalInfoView", package.seeall)

local SurvivalInfoView = class("SurvivalInfoView", BaseView)

function SurvivalInfoView:onInitView()
	self.survivalinfoview = gohelper.findChild(self.viewGO, "survivalmapbaginfoview")
	self.infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(self.survivalinfoview, SurvivalBagInfoPart)

	self.infoPanel:setCloseShow(true, self.closeInfoView, self)
	self.infoPanel:updateMo()
end

function SurvivalInfoView:addEvents()
	return
end

function SurvivalInfoView:onOpen()
	self.cfg = self.viewParam.cfg

	local datas = SurvivalHandbookModel.instance:getHandBookDatas(SurvivalEnum.HandBookType.Collection, 0)

	for j, mo in ipairs(datas) do
		if mo.links == self.cfg.id then
			local itemMo = mo:getSurvivalBagItemMo()

			self.infoPanel:updateMo(itemMo)

			break
		end
	end
end

function SurvivalInfoView:onClose()
	return
end

function SurvivalInfoView:onDestroyView()
	return
end

function SurvivalInfoView:closeInfoView()
	self:closeThis()
end

return SurvivalInfoView
