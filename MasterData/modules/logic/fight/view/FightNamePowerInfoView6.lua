-- chunkname: @modules/logic/fight/view/FightNamePowerInfoView6.lua

module("modules.logic.fight.view.FightNamePowerInfoView6", package.seeall)

local FightNamePowerInfoView6 = class("FightNamePowerInfoView6", FightBaseView)

function FightNamePowerInfoView6:onInitView()
	self.objList = {}

	for i = 0, 3 do
		self.objList[i] = gohelper.findChild(self.viewGO, i)
	end

	recthelper.setAnchor(self.viewGO.transform, -106, 6)

	self.click = gohelper.findChildClick(self.viewGO, "click")
	self.tips = gohelper.findChild(self.viewGO, "tips")
	self.tipsText = gohelper.findChildText(self.viewGO, "tips/desc")
end

function FightNamePowerInfoView6:addEvents()
	self:com_registClick(self.click, self.onClick)
	self:com_registFightEvent(FightEvent.PowerChange, self.onPowerChange)
	self:com_registFightEvent(FightEvent.TouchFightViewScreen, self.onTouchFightViewScreen)
end

function FightNamePowerInfoView6:removeEvents()
	return
end

function FightNamePowerInfoView6:onTouchFightViewScreen()
	gohelper.setActive(self.tips, false)
end

function FightNamePowerInfoView6:onClick()
	gohelper.setActive(self.tips, true)

	local curNum = self.powerInfo.num
	local str = ""

	if curNum == 0 or curNum == 1 then
		str = luaLang("p_v2a9_alert_help_1_txt_5")
	elseif curNum == 2 then
		str = luaLang("p_v2a9_alert_help_1_txt_6")
	elseif curNum == 3 then
		str = luaLang("p_v2a9_alert_help_1_txt_7")
	end

	self.tipsText.text = str
end

function FightNamePowerInfoView6:onConstructor(entityId, powerInfo, isFocusView)
	self.entityId = entityId
	self.powerInfo = powerInfo
	self.isFocusView = isFocusView
end

function FightNamePowerInfoView6:refreshData(entityId, powerInfo)
	self.entityId = entityId
	self.powerInfo = powerInfo

	if self.viewGO then
		self:refreshUI()
	end
end

function FightNamePowerInfoView6:onOpen()
	self:refreshUI()
end

function FightNamePowerInfoView6:refreshUI()
	local curNum = self.powerInfo.num

	for num, obj in pairs(self.objList) do
		gohelper.setActive(obj, num == curNum)
	end

	if curNum > 3 then
		gohelper.setActive(self.objList[3], true)
	end

	if self.isFocusView then
		recthelper.setAnchorX(self.tips.transform, -414)
	end
end

function FightNamePowerInfoView6:onPowerChange(entityId, powerId)
	if self.entityId == entityId and self.powerInfo.powerId == powerId then
		self:refreshUI()
	end
end

function FightNamePowerInfoView6:onClose()
	return
end

function FightNamePowerInfoView6:onDestroyView()
	return
end

return FightNamePowerInfoView6
