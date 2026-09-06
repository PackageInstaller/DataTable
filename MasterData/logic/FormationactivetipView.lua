-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/FormationactivetipView.lua

module("logic.extensions.nineplace.view.FormationactivetipView", package.seeall)

local FormationactivetipView = class("FormationactivetipView", ViewComponent)

function FormationactivetipView:ctor()
	FormationactivetipView.super.ctor(self)
end

function FormationactivetipView:buildUI()
	FormationactivetipView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._btnLvup = self:getBtn("btnLvup")
	self._cellFormation = self:getGo("cellFormation")
	self._txtName = goutil.findChildTextComponent(self._cellFormation, "txtName")
	self._txtTips = goutil.findChildTextComponent(self._cellFormation, "txtTips")
	self._icon = goutil.findChild(self._cellFormation, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
	self._conShow = self:getGo("conShow")
	self._tipCurActive = self:getGo("tipCurActive")
	self._tipNotActive = self:getGo("tipNotActive")
	self._showFormations = {}

	local cfgs = NinePlaceConfig.instance:getStageCfgs()

	for _, v in pairs(cfgs) do
		if v.stageId then
			local cell = {}
			local go = goutil.clone(self._cellFormation)

			goutil.addChildToParent(go, self._conShow)

			cell.go = go
			cell.cfg = v
			cell.txtName = goutil.findChildTextComponent(go, "txtName")
			cell.txtShowTips = goutil.findChildTextComponent(go, "txtTips")
			cell.markLock = goutil.findChild(go, "markLock")
			cell.markSelect = goutil.findChild(go, "markSelect")
			cell.dot = goutil.findChild(go, "dot")

			local btnGo = goutil.findChild(go, "btn")

			goutil.setActive(btnGo, true)

			cell.btn = GameUtil.asBtn(btnGo)
			cell.icon = goutil.findChild(go, "icon"):GetComponent(ComponentType.UIImageSpriteChange)

			table.insert(self._showFormations, cell)
		end
	end
end

function FormationactivetipView:bindEvents()
	FormationactivetipView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnRule:AddClickListener(self._onClickBtnRule, self)

	for k, v in ipairs(self._showFormations) do
		GameUtil.addClickHandler(v.btn, GameUtil.handler(self._onClickCellBtn, self, v.cfg))
	end

	self._btnLvup:AddClickListener(self._onClickBtnLvup, self)
end

function FormationactivetipView:unbindEvents()
	FormationactivetipView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnRule:RemoveClickListener()

	for k, v in ipairs(self._showFormations) do
		GameUtil.rmClickHandler(v.btn)
	end

	self._btnLvup:RemoveClickListener()
end

function FormationactivetipView:destroyUI()
	FormationactivetipView.super.destroyUI(self)
end

function FormationactivetipView:onEnter()
	FormationactivetipView.super.onEnter(self)

	local params = self:getOpenParam()

	self._curActiveId = params[1]
	self._curPetNumOnFormation = params[2]
	self._unlockBtnStaus = params[3]
	self._allOpenForRankRace = params[4]

	self:_initView()
end

function FormationactivetipView:onEnterFinished()
	FormationactivetipView.super.onEnterFinished(self)
end

function FormationactivetipView:onExit()
	FormationactivetipView.super.onExit(self)

	self._allOpenForRankRace = false
end

function FormationactivetipView:onExitFinished()
	FormationactivetipView.super.onExitFinished(self)
end

function FormationactivetipView:_onClickBtnRule()
	TipsFacade.instance:openRulesView("formationactive")
end

function FormationactivetipView:_onClickBtnLvup()
	self:close()
	UIStateManager.instance:push(ViewName.NineplacelvupView, self._curActiveId)
end

function FormationactivetipView:_initView()
	for _, v in pairs(self._showFormations) do
		local cfg = v.cfg
		local info = FormationNewModel.instance:getFormStrengthInfo(cfg.stageId)

		v.icon:SetState(cfg.stageId - 1)

		v.txtName.text = cfg.name

		if self._allOpenForRankRace then
			goutil.setActive(v.dot, false)
		else
			goutil.setActive(v.dot, NinePlaceModel.instance:checkCanUnlockRedById(v.cfg.stageId))
		end

		goutil.setActive(v.markSelect, cfg.stageId == self._curActiveId)

		if info or self._allOpenForRankRace then
			local lv = self._allOpenForRankRace and BattleConfig.instance:getFormStrengthMaxLv(cfg.stageId) or info and info.formStrengthLv
			local stageCfg = BattleConfig.instance:getFormStrengthLvCfg(cfg.stageId, lv)

			if stageCfg then
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

					v.txtShowTips.text = table.concat(showStr, "\n")
				end
			end
		else
			v.txtShowTips.text = lang("<color=red>未解锁</color>")
		end
	end

	if self._curActiveId and self._curActiveId > 0 then
		goutil.setActive(self._tipNotActive, false)
		goutil.setActive(self._cellFormation, true)
		self._icon:SetState(self._curActiveId - 1)

		local info = FormationNewModel.instance:getFormStrengthInfo(self._curActiveId)
		local lv = 0

		if self._allOpenForRankRace then
			lv = BattleConfig.instance:getFormStrengthMaxLv(self._curActiveId)
		elseif info then
			lv = info.formStrengthLv
		end

		local stageCfg = BattleConfig.instance:getFormStrengthLvCfg(self._curActiveId, lv)

		self._txtName.text = stageCfg.name

		if stageCfg then
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

				self._txtTips.text = table.concat(showStr, "\n")
			end
		end
	else
		goutil.setActive(self._tipNotActive, true)
		goutil.setActive(self._cellFormation, false)

		self._curActiveId = nil
	end

	if self._allOpenForRankRace then
		goutil.setActive(self._tipNotActive, false)
		goutil.setActive(self._tipCurActive, false)
	end

	goutil.setActive(self._btnLvup.gameObject, self._unlockBtnStaus == nil or self._unlockBtnStaus)
end

function FormationactivetipView:_onClickCellBtn(data)
	if self._allOpenForRankRace then
		if not self._curActiveId and self._curPetNumOnFormation < 5 then
			FloatWordMgr.instance:show(lang("需上阵够5只精灵（不包含契约精灵），才可激活阵法效果"))

			return
		end

		UIStateManager.instance:push(ViewName.FormationhintView, data.stageId, self._curActiveId, self._unlockBtnStaus, self._allOpenForRankRace)
	else
		local info = FormationNewModel.instance:getFormStrengthInfo(data.stageId)

		if not info then
			UIStateManager.instance:push(ViewName.FormationhintView, data.stageId, self._curActiveId, self._unlockBtnStaus, self._allOpenForRankRace)

			return
		end

		if not self._curActiveId and self._curPetNumOnFormation < 5 then
			FloatWordMgr.instance:show(lang("需上阵够5只精灵（不包含契约精灵），才可激活阵法效果"))

			return
		end

		if data.stageId == self._curActiveId then
			FloatWordMgr.instance:show(lang("已激活当前阵法"))

			return
		end

		UIStateManager.instance:push(ViewName.FormationhintView, data.stageId, self._curActiveId, self._unlockBtnStaus, self._allOpenForRankRace)
	end
end

return FormationactivetipView
