-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/propertycompare/BattleBloodHintComponent.lua

module("logic.extensions.battle.viewmain.propertycompare.BattleBloodHintComponent", package.seeall)

local M = class("BattleBloodHintComponent", BattleBossBloodHintView)

function M:buildUI()
	self._forecastCureGo = goutil.findChild(self.mainGO, "fillYujia")
	self._forecastDamageGo = goutil.findChild(self.mainGO, "fillYukou")
	self._forecastDoubleDamageGo = goutil.findChild(self.mainGO, "fillYukouDouble")
	self._bloodImg = goutil.findChildComponent(self.mainGO, "fillBlood", typeof(FillAmountImage))
	self._forecastDamagedImg = goutil.findChildComponent(self.mainGO, "fillYukou", typeof(FillAmountImage))
	self._forecastCuredImg = goutil.findChildComponent(self.mainGO, "fillYujia", typeof(FillAmountImage))
	self._forecastDoubleDamagedImg = goutil.findChildComponent(self.mainGO, "fillYukouDouble", typeof(FillAmountImage))
	self._forecastCureAnim = self._forecastCureGo:GetComponent(ComponentType.Animation)
	self._forecastDamageAnim = self._forecastDamageGo:GetComponent(ComponentType.Animation)
	self._forecastDoubleDamageAnim = self._forecastDoubleDamageGo:GetComponent(ComponentType.Animation)
end

function M:_updateHpTxt()
	return
end

function M:setDirection(isLeft)
	self._isLeft = isLeft
end

return M
