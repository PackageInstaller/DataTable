-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/view/DivineFarnasExtFightSecondEndView.lua

module("logic.extensions.divinefarnas.view.DivineFarnasExtFightSecondEndView", package.seeall)

local DivineFarnasExtFightSecondEndView = class("DivineFarnasExtFightSecondEndView", ViewComponent)
local COLOR_GREEN = "00C119FF"
local COLOR_RED = "FF0000FF"

function DivineFarnasExtFightSecondEndView:ctor()
	DivineFarnasExtFightSecondEndView.super.ctor(self)
end

function DivineFarnasExtFightSecondEndView:unbindEvents()
	DivineFarnasExtFightSecondEndView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function DivineFarnasExtFightSecondEndView:bindEvents()
	DivineFarnasExtFightSecondEndView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function DivineFarnasExtFightSecondEndView:buildUI()
	DivineFarnasExtFightSecondEndView.super.buildUI(self)

	self._btnSure = self:getGo("sure/btnSure")
	self._txtTitle = self:getTxt("txtTitle")
	self._imgDodgePass = self:getGo("target/imgDodgePass")
	self._imgDodgePassChangeComp = self:getGo("target/imgDodgePass"):GetComponent("UIImageSpriteChange")
	self._txtPet = self:getTxt("target/txtPet")
	self._imgPetPassChangeComp = self:getGo("target/imgPetPass"):GetComponent("UIImageSpriteChange")
	self._txtDodge = self:getTxt("target/txtDodge")
end

function DivineFarnasExtFightSecondEndView:onExit()
	DivineFarnasExtFightSecondEndView.super.onExit(self)
end

function DivineFarnasExtFightSecondEndView:onEnter()
	DivineFarnasExtFightSecondEndView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local msg = GameUtil.pbToTable(params[1])
	local activityId = msg.activityId
	local stageId = msg.stageId
	local stageCfg = DivineFarnasConfig.instance:getExtStageCfgByStageId(activityId, stageId)
	local extType = stageCfg.type
	local isHuiMieType = extType == DivineFarnasController.EXT_TYPE_HUIMIE

	if msg.isPass then
		if not COLOR_GREEN then
			local curColor = COLOR_RED
			local passRequest2 = msg.isPass

			self._txtDodge.text = isHuiMieType and string.format("闪避次数：%d", msg.dodgeTimes) or string.format("闪避次数≥%d (<color=#%s>%d</color>/%d)", stageCfg.buffNeedCount, curColor, msg.dodgeTimes, stageCfg.buffNeedCount)

			local passRequestIdx = passRequest2 and 1 or 0
			local info = DivineFarnasModel.instance:getInfo(activityId)

			self._txtTitle.text = passRequest2 and "挑战成功" or "挑战失败"

			self._imgPetPassChangeComp:SetState(1)
			self._imgDodgePassChangeComp:SetState(passRequestIdx)
			self._imgDodgePass:GetComponent(goutil.Type_UIImage):SetNativeSize()
		end
	end
end

function DivineFarnasExtFightSecondEndView:onExit()
	return
end

function DivineFarnasExtFightSecondEndView:_onClickBtnSure()
	BattleController.instance:endBattle()
end

return DivineFarnasExtFightSecondEndView
