-- chunkname: @modules/logic/survival/view/SurvivalItemInfoView.lua

module("modules.logic.survival.view.SurvivalItemInfoView", package.seeall)

local SurvivalItemInfoView = class("SurvivalItemInfoView", BaseView)

function SurvivalItemInfoView:onInitView()
	self.infoPart = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, SurvivalBagInfoPart)

	self.infoPart:setCloseShow(true, self.onClickClose, self)
	self.infoPart:setIsShowEmpty(true)
end

function SurvivalItemInfoView:addEvents()
	return
end

function SurvivalItemInfoView:removeEvents()
	return
end

function SurvivalItemInfoView:onClickClose()
	self:closeThis()
end

function SurvivalItemInfoView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function SurvivalItemInfoView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function SurvivalItemInfoView:refreshParam()
	self.itemMo = self.viewParam and self.viewParam.itemMo
	self.goPanel = self.viewParam and self.viewParam.goPanel
end

function SurvivalItemInfoView:refreshView()
	if self.goPanel then
		local x, y, z = transformhelper.getPos(self.goPanel.transform)

		transformhelper.setPos(self.viewGO.transform, x, y, z)
	end

	self.infoPart:updateMo(self.itemMo)
end

return SurvivalItemInfoView
