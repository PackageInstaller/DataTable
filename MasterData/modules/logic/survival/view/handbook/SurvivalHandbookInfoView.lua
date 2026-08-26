-- chunkname: @modules/logic/survival/view/handbook/SurvivalHandbookInfoView.lua

module("modules.logic.survival.view.handbook.SurvivalHandbookInfoView", package.seeall)

local SurvivalHandbookInfoView = class("SurvivalHandbookInfoView", BaseView)

function SurvivalHandbookInfoView:onInitView()
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btnClose")
	self.btnLeftArrow = gohelper.findChildButtonWithAudio(self.viewGO, "#btnLeftArrow")
	self.btnRightArrow = gohelper.findChildButtonWithAudio(self.viewGO, "#btnRightArrow")
	self.infoViewNode = gohelper.findChild(self.viewGO, "#infoViewNode")
	self.textIndex = gohelper.findChildTextMesh(self.viewGO, "#textIndex")
	self.refreshFlow = FlowSequence.New()

	self.refreshFlow:addWork(TimerWork.New(0.167))
	self.refreshFlow:addWork(FunctionWork.New(self.refreshInfo, self))
end

function SurvivalHandbookInfoView:addEvents()
	self.addClickCb(self, self.btnClose, self.closeThis, self)
	self.addClickCb(self, self.btnLeftArrow, self.onClickBtnLeftArrow, self)
	self.addClickCb(self, self.btnRightArrow, self.onClickBtnRightArrow, self)
end

function SurvivalHandbookInfoView:onOpen()
	self.handBookType = self.viewParam.handBookType
	self.handBookDatas = self.viewParam.handBookDatas
	self.select = self.viewParam.select

	local res = self.viewContainer._viewSetting.otherRes.infoView
	local infoGo = self:getResInst(res, self.infoViewNode)

	self._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(infoGo, SurvivalBagInfoPart)

	self._infoPanel:setIsShowEmpty(true)
	self:refreshInfo()
end

function SurvivalHandbookInfoView:onClose()
	return
end

function SurvivalHandbookInfoView:onDestroyView()
	self.refreshFlow:clearWork()
end

function SurvivalHandbookInfoView:onClickModalMask()
	self:closeThis()
end

function SurvivalHandbookInfoView:onClickBtnLeftArrow()
	if self.select > 1 then
		self.select = self.select - 1
	end

	self._infoPanel:playAnim("switchleft")
	self.refreshFlow:clearWork()
	self.refreshFlow:start()
end

function SurvivalHandbookInfoView:onClickBtnRightArrow()
	if self.select < #self.handBookDatas then
		self.select = self.select + 1
	end

	self._infoPanel:playAnim("switchright")
	self.refreshFlow:clearWork()
	self.refreshFlow:start()
end

function SurvivalHandbookInfoView:refreshArrow()
	gohelper.setActive(self.btnLeftArrow, self.select > 1)
	gohelper.setActive(self.btnRightArrow, self.select < #self.handBookDatas)

	self.textIndex.text = string.format("%s/%s", self.select, #self.handBookDatas)
end

function SurvivalHandbookInfoView:refreshInfo()
	self:refreshArrow()

	local survivalHandbookMo = self.handBookDatas[self.select]

	self._infoPanel:updateMo(survivalHandbookMo:getSurvivalBagItemMo(), {
		jumpChangeAnim = true
	})
end

return SurvivalHandbookInfoView
