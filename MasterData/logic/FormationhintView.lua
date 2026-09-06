-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/FormationhintView.lua

module("logic.extensions.nineplace.view.FormationhintView", package.seeall)

local FormationhintView = class("FormationhintView", ViewComponent)

function FormationhintView:ctor()
	FormationhintView.super.ctor(self)
end

function FormationhintView:buildUI()
	FormationhintView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._conUnlock = self:getGo("conUnlock")
	self._icon = goutil.findChild(self._conUnlock, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
	self._gotoNpc = goutil.findChild(self._conUnlock, "btnGotoNpc")
	self._btnGotoNpc = GameUtil.asBtn(self._gotoNpc)
	self._txtName = goutil.findChildTextComponent(self._conUnlock, "txtName")
	self._txtUnlockTip = goutil.findChildTextComponent(self._conUnlock, "txtUnlockTip")
	self._conChange = self:getGo("conChange")
	self._btnSure = GameUtil.asBtn(goutil.findChild(self._conChange, "btnSure"))
	self._btnCancel = GameUtil.asBtn(goutil.findChild(self._conChange, "btnCancel"))
	self._txtTips = goutil.findChildTextComponent(self._conChange, "txtTips")
	self._formationCur = self:buildUIAboutFormation("formationCur")
	self._formationAfter = self:buildUIAboutFormation("formationAfter")
	self._tipNotActive = goutil.findChild(self._conChange, "tipNotActive")
end

function FormationhintView:buildUIAboutFormation(name)
	local formation = {}
	local go = goutil.findChild(self._conChange, name)

	formation.icon = goutil.findChild(go, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
	formation.txtName = goutil.findChildTextComponent(go, "txtName")
	formation.txtDes = goutil.findChildTextComponent(go, "txtDes")
	formation.go = go

	return formation
end

function FormationhintView:bindEvents()
	FormationhintView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnCancel:AddClickListener(self.close, self)
	self._btnGotoNpc:AddClickListener(self._onClickBtnGotoNpc, self)
	self._btnSure:AddClickListener(self._onClickBtnSure, self)
end

function FormationhintView:unbindEvents()
	FormationhintView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnGotoNpc:RemoveClickListener()
end

function FormationhintView:destroyUI()
	FormationhintView.super.destroyUI(self)
end

function FormationhintView:onEnter()
	FormationhintView.super.onEnter(self)

	local param = self:getOpenParam()

	self._stateId = param[1]
	self._activeId = param[2]
	self._allOpenForRankRace = param[4]
	self._curCfg = NinePlaceConfig.instance:getStageCfgById(self._stateId)

	local info = FormationNewModel.instance:getFormStrengthInfo(self._stateId)

	if info or self._allOpenForRankRace then
		goutil.setActive(self._conChange, true)
		goutil.setActive(self._conUnlock, false)

		local lv

		if self._activeId then
			goutil.setActive(self._formationCur.go, true)
			goutil.setActive(self._tipNotActive, false)
			self._formationAfter.icon:SetState(self._activeId - 1)

			local curInfo = FormationNewModel.instance:getFormStrengthInfo(self._activeId)
			local actCfg = NinePlaceConfig.instance:getStageCfgById(self._activeId)

			lv = self._allOpenForRankRace and BattleConfig.instance:getFormStrengthMaxLv(actCfg.stageId) or curInfo and curInfo.formStrengthLv

			local stageCfg = BattleConfig.instance:getFormStrengthLvCfg(self._activeId, lv)

			if not stageCfg.properties then
				local attrsStr = ""
				local attrList = FightingPowerFormula.instance:parseAttrValues(attrsStr) or {}
				local showStr = {}

				for k, v in pairs(attrList) do
					local name, value = GameUtil.getPropertyInfo(k, v)
					local addstr = string.format("%s+%s", name, value)

					table.insert(showStr, addstr)
				end

				table.insert(showStr, 1, lv .. "级")

				self._formationCur.txtDes.text = table.concat(showStr, "\n")

				self._formationCur.icon:SetState(self._activeId - 1)

				self._formationCur.txtName.text = langPara("阵法：%s", actCfg.name)
			end
		else
			goutil.setActive(self._formationCur.go, false)
			goutil.setActive(self._tipNotActive, true)
		end

		self._formationAfter.icon:SetState(self._stateId - 1)

		self._formationAfter.txtName.text = langPara("阵法：%s", self._curCfg.name)
		lv = self._allOpenForRankRace and BattleConfig.instance:getFormStrengthMaxLv(self._curCfg.stageId) or info and info.formStrengthLv

		local stageCfg = BattleConfig.instance:getFormStrengthLvCfg(self._stateId, lv)

		if not stageCfg.properties then
			local attrsStr = ""
			local attrList = FightingPowerFormula.instance:parseAttrValues(attrsStr) or {}
			local showStr = {}

			for k, v in pairs(attrList) do
				local name, value = GameUtil.getPropertyInfo(k, v)
				local addstr = string.format("%s+%s", name, value)

				table.insert(showStr, addstr)
			end

			table.insert(showStr, 1, lv .. "级")

			self._formationAfter.txtDes.text = table.concat(showStr, "\n")
			self._txtTips.text = lang(string.format("是否确认将上阵精灵的站位调整为【%s】？", self._curCfg.name))
		end
	else
		goutil.setActive(self._conChange, false)
		goutil.setActive(self._conUnlock, true)

		local str = string.split(self._curCfg.lockTip, "\n")

		self._txtName.text = langPara("阵法：%s", self._curCfg.name)

		local reach = FuncOpenController.instance:getConditionReached(self._curCfg.openCondition)

		goutil.setActive(self._gotoNpc, reach and param[3])

		self._txtUnlockTip.text = lang((reach or nil) and (str[2] or str[1]))

		self._icon:SetState(self._curCfg.stageId - 1)
	end
end

function FormationhintView:onEnterFinished()
	FormationhintView.super.onEnterFinished(self)
end

function FormationhintView:onExit()
	FormationhintView.super.onExit(self)
end

function FormationhintView:onExitFinished()
	FormationhintView.super.onExitFinished(self)
end

function FormationhintView:_onClickBtnGotoNpc()
	TaskController.instance:foreceClearState()
	UIStateManager.instance:clear(true)
	TaskController.instance:gotoNpc(self._curCfg.NpcId)
end

function FormationhintView:_onClickBtnSure()
	self:close()
	UIStateManager.instance:popByName(ViewName.FormationactivetipView)

	local posCfg = BattleConfig.instance:getFormStrengthTriggerCfgByStateId(self._stateId)

	if posCfg then
		GlobalDispatcher:dispatch(GlobalNotify.FormationChangeToSpecialPos, posCfg)
	end
end

return FormationhintView
