-- chunkname: @modules/logic/fight/view/FightFocusAiJiAoExPointSliderView.lua

module("modules.logic.fight.view.FightFocusAiJiAoExPointSliderView", package.seeall)

local FightFocusAiJiAoExPointSliderView = class("FightFocusAiJiAoExPointSliderView", FightBaseView)

function FightFocusAiJiAoExPointSliderView:onInitView()
	self.preImg = gohelper.findChildImage(self.viewGO, "root/go_pre")
	self.preImg.fillAmount = 0
	self.energyImg = gohelper.findChildImage(self.viewGO, "root/go_energy")
	self.text = gohelper.findChildText(self.viewGO, "root/#txt_energy")
	self.btnTips = gohelper.findChildClickWithDefaultAudio(self.viewGO, "root/#btn_tips/clickarea")
	self.tips = gohelper.findChild(self.viewGO, "root/tips")
	self.descText = gohelper.findChildText(self.viewGO, "root/tips/#txt_skilldesc")

	gohelper.setActive(self.tips, false)
end

function FightFocusAiJiAoExPointSliderView:addEvents()
	self:com_registFightEvent(FightEvent.TouchFightViewScreen, self.onTouchFightViewScreen)
	self:com_registClick(self.btnTips, self.onBtnTips)
end

function FightFocusAiJiAoExPointSliderView:onBtnTips()
	gohelper.setActive(self.tips, true)
end

function FightFocusAiJiAoExPointSliderView:onTouchFightViewScreen()
	gohelper.setActive(self.tips, false)
end

function FightFocusAiJiAoExPointSliderView:onConstructor(entityMO)
	self.entityMO = entityMO
end

function FightFocusAiJiAoExPointSliderView:refreshEntityMO(entityMO)
	self.entityMO = entityMO

	if self.viewGO then
		self:refreshData()
	end
end

function FightFocusAiJiAoExPointSliderView:onOpen()
	self:refreshData()

	self.descText.text = luaLang("aijiao_expoint_desc")
end

function FightFocusAiJiAoExPointSliderView:refreshData()
	local max = self.entityMO:getMaxExPoint()
	local exPoint = self.entityMO.exPoint

	self.energyImg.fillAmount = exPoint / max
	self.text.text = string.format("%d/%d", exPoint, max)
end

return FightFocusAiJiAoExPointSliderView
