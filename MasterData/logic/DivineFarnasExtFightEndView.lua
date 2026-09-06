-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefarnas/view/DivineFarnasExtFightEndView.lua

module("logic.extensions.divinefarnas.view.DivineFarnasExtFightEndView", package.seeall)

local DivineFarnasExtFightEndView = class("DivineFarnasExtFightEndView", ViewComponent)
local COLOR_GREEN = "00C119FF"
local COLOR_RED = "FF0000FF"

function DivineFarnasExtFightEndView:ctor()
	DivineFarnasExtFightEndView.super.ctor(self)
end

function DivineFarnasExtFightEndView:unbindEvents()
	DivineFarnasExtFightEndView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function DivineFarnasExtFightEndView:bindEvents()
	DivineFarnasExtFightEndView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function DivineFarnasExtFightEndView:buildUI()
	DivineFarnasExtFightEndView.super.buildUI(self)

	self._btnSure = self:getGo("sure/btnSure")
	self._txtTitle = self:getTxt("txtTitle")
	self._imgDodgePass = self:getGo("target/imgDodgePass")
	self._imgDodgePassChangeComp = self:getGo("target/imgDodgePass"):GetComponent("UIImageSpriteChange")
	self._txtPet = self:getTxt("target/txtPet")
	self._imgPetPassChangeComp = self:getGo("target/imgPetPass"):GetComponent("UIImageSpriteChange")
	self._txtDodge = self:getTxt("target/txtDodge")
	self._raceNum = self:getGo("raceNum")
	self._txtCurStage = self:getTxt("raceNum/txtCurStage")
	self._txtTotal = self:getTxt("raceNum/txtTotal")
	self._buff = self:getGo("buff")
	self._txtBuff = self:getTxt("buff/txtBuff")
end

function DivineFarnasExtFightEndView:onExit()
	DivineFarnasExtFightEndView.super.onExit(self)
end

function DivineFarnasExtFightEndView:onEnter()
	DivineFarnasExtFightEndView.super.onEnter(self)

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
			local activeBuffLevel = DivineFarnasController.instance:getActiveBuffCfgLevel(activityId)
			local buffCfg = DivineFarnasConfig.instance:getBuffCfgByBuffId(activityId, activeBuffLevel)

			if buffCfg then
				if not buffCfg.buffDesc then
					local buffStr = ""
					local info = DivineFarnasModel.instance:getInfo(activityId)
					local addRaceIdNum = DivineFarnasModel.instance:getDiffPetNum(activityId, stageId)

					self._txtTitle.text = passRequest2 and "挑战成功" or "挑战失败"
					self._txtBuff.text = buffStr
					self._txtCurStage.text = string.format("仅在本关存活的精灵：%d", addRaceIdNum)
					self._txtTotal.text = string.format("累计存活：%d", msg.totalActiveRaceCount)

					self._imgPetPassChangeComp:SetState(1)
					self._imgDodgePassChangeComp:SetState(passRequestIdx)
					self._imgDodgePass:GetComponent(goutil.Type_UIImage):SetNativeSize()
					GameUtil.SetActive(self._buff, isHuiMieType)
					GameUtil.SetActive(self._raceNum, isHuiMieType)
				end
			end
		end
	end
end

function DivineFarnasExtFightEndView:onExit()
	return
end

function DivineFarnasExtFightEndView:_onClickBtnSure()
	BattleController.instance:endBattle()
end

return DivineFarnasExtFightEndView
