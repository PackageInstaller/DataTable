-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasontrainingcourseView.lua

module("logic.extensions.season.view.SeasontrainingcourseView", package.seeall)

local SeasontrainingcourseView = class("SeasontrainingcourseView", ViewComponent)

SeasontrainingcourseView.propertyEffect = "20221028/xunlianchang/fx_ui_xlc_shuaxin_da.prefab"

function SeasontrainingcourseView:ctor()
	SeasontrainingcourseView.super.ctor(self)
end

function SeasontrainingcourseView:unbindEvents()
	SeasontrainingcourseView.super.unbindEvents(self)

	for i, v in ipairs(self.tabList) do
		GameUtil.rmClickHandler(v)
	end

	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnTip)
	GameUtil.rmClickHandler(self.btnGoto)
	GameUtil.rmClickHandler(self.btnLevelUp)
end

function SeasontrainingcourseView:bindEvents()
	SeasontrainingcourseView.super.bindEvents(self)

	for i, v in ipairs(self.tabList) do
		GameUtil.addClickHandler(v, GameUtil.handler(self.onTabClick, self, i))
	end

	GameUtil.addClickHandler(self.btnClose, self.onClickClose, self)
	GameUtil.addClickHandler(self.btnTip, self.onClickHelp, self)
	GameUtil.addClickHandler(self.btnGoto, self.onClickGoto, self)
	GameUtil.addClickHandler(self.btnLevelUp, self.onClickLvlup, self)
end

function SeasontrainingcourseView:buildUI()
	SeasontrainingcourseView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnTip = self:getGo("btnTip")
	self._goldBarCon = self:getGo("goldBarCon")
	self.tabRedList = {}
	self.tabList = {}

	for i = 1, 3 do
		local go = self:getGo("teamBtns/btnTeam_" .. i)

		table.insert(self.tabList, go)

		local red = self:getGo("teamBtns/btnTeam_" .. i .. "/redpoint")

		table.insert(self.tabRedList, red)
	end

	self.txtName = self:getTxt("teamInfo/name/txtName")
	self.formation = self:getGo("teamInfo/formation")
	self.btnGoto = self:getGo("teamInfo/btnGoto")
	self.attrLook = self:getGo("teamAttr/attrLook")
	self.txtNowLevel = self:getTxt("teamAttr/attrLook/txtNowLevel")
	self.txtNextLevel = self:getTxt("teamAttr/attrLook/txtNextLevel")
	self.attrList = {}

	for i = 1, 5 do
		local attr = self:getGo("teamAttr/attrLook/attr_" .. i)

		table.insert(self.attrList, attr)
	end

	self.btnLevelUp = self:getGo("teamAttr/btnLevelUp")
	self.btnLevelUpRed = self:getGo("teamAttr/btnLevelUp/redpoint")
	self.lockTip = self:getGo("teamAttr/lockTip")
	self.txtLockTip = self:getTxt("teamAttr/lockTip/txt")
	self.txtPower = self:getTxt("teamAttr/txtPower")
	self.txtCost = MaterialMgr.findGraphicText(self.mainGO, "teamAttr/txtCost")
	self._effect = self:getGo("teamAttr/attrLook/effect")
end

function SeasontrainingcourseView:onExit()
	SeasontrainingcourseView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtTeamInfo, self.onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonTrainingCoursePropertyEffect, self._onPropertyEffect, self)
end

function SeasontrainingcourseView:onEnter()
	SeasontrainingcourseView.super.onEnter(self)

	local teamId = checknumber(self:getFirstParam())

	if teamId == 0 then
		teamId = SeasonFmtController.instance.curSelectTrainTeamId or 1
	end

	self.curSelectTeamId = -1

	self:onTabClick(teamId)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtTeamInfo, self.onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonTrainingCoursePropertyEffect, self._onPropertyEffect, self)
	SeasonController.instance:sendGetAllTeamInfo()
	GameUtil.SetActive(self.btnGoto, true)
	GameUtil.SetActive(self.txtCost, true)
	GameUtil.SetActive(self.btnTip, true)
	self:_openGoldBarCon()
end

function SeasontrainingcourseView:_onPropertyEffect()
	self:_playCellEff(self._effect)
end

function SeasontrainingcourseView:_openGoldBarCon()
	local seasonId = SeasonModel.instance:getSeasonId()
	local config = SeasonMainCampConfig.instance:getTrainingGroundConfig(seasonId)
	local barList = string.split(config.barList or "", "#")
	local btnList = {}

	for i, v in ipairs(barList) do
		table.insert(btnList, {
			showAdd = false,
			id = v
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)
end

function SeasontrainingcourseView:onClickClose()
	SeasonFmtController.instance.curSelectTrainTeamId = nil

	self:close()
end

function SeasontrainingcourseView:onClickGoto()
	SeasonFmtController.instance:showFormationView(self.curSelectTeamId)
end

function SeasontrainingcourseView:onClickHelp()
	TipsFacade.instance:openRulesView("SeasontrainingcourseView")
end

function SeasontrainingcourseView:showFormation(teamMo)
	for i = 1, 9 do
		local petId = checknumber(((teamMo and teamMo.form and teamMo.form.pos or nil) and teamMo.form.pos)[i])
		local cell = goutil.findChild(self.formation, "cell_" .. i)
		local con = goutil.findChild(self.formation, "cell_" .. i .. "/con")

		GameUtil.SetActive(cell, false)

		if petId > 0 then
			if teamMo then
				local petMo = teamMo:getPetMo(petId)

				GameUtil.SetActive(cell, true)
				MaterialMgr.setCellByMo(petMo, con)
			end
		else
			MaterialMgr.resetAll(con)
		end
	end
end

function SeasontrainingcourseView:onRefreshUI()
	self.curCost = ""
	self.txtCost.text = ""
	self.txtNowLevel.text = ""
	self.txtNextLevel.text = ""
	self.txtPower.text = ""

	GameUtil.SetActive(self.lockTip, false)
	GameUtil.SetActive(self.btnLevelUp, false)
	GameUtil.SetActive(self.btnLevelUpRed, false)

	local seasonId = SeasonModel.instance:getSeasonId()
	local campLv = checknumber(SeasonMainCampModel.instance:getCampLv())
	local tgCfg = SeasonMainCampConfig.instance:getTrainingGroundConfig(seasonId)
	local teamPlanId = tgCfg.teamPlanId
	local teams = SeasonTeamsModel.instance:getTeams() or {}
	local teamCount = #teams

	for i, v in ipairs(self.tabList) do
		GameUtil.SetGray(v, teamCount < i)

		local teamLevelCfg = SeasonMainCampConfig.instance:getTeamConfig(teamPlanId, i)
		local showText = goutil.findChildTextComponent(v, "text")

		showText.text = langPara("队伍%s", i)
	end

	local attrs = {}
	local nextattrs = {}
	local teamMo = SeasonTeamsModel.instance:getTeam(self.curSelectTeamId)
	local teamConfig = SeasonMainCampConfig.instance:getTeamConfig(teamPlanId, self.curSelectTeamId)

	if teamMo then
		local lvl = teamMo.teamLv

		self.txtName.text = teamConfig.teamName
		self.txtNowLevel.text = langPara("当前等级：%s", lvl)
		self.txtNextLevel.text = lang("下一等级")

		local maxLvPlanId = 0
		local teamUpgradePlanId = 0

		if lvl > 0 and tgCfg and campLv >= checknumber(tgCfg.campLv) then
			local teamCfg = SeasonMainCampConfig.instance:getTeamConfig(teamPlanId, self.curSelectTeamId)

			if teamCfg and campLv >= checknumber(teamCfg.campLv) then
				maxLvPlanId = teamCfg.maxLvPlanId
				teamUpgradePlanId = teamCfg.teamUpgradePlanId

				local maxList = SeasonMainCampConfig.instance:getTeamMaxLvlCfgList(teamCfg.maxLvPlanId)
				local lvlCfg = SeasonMainCampConfig.instance:getNearTeamLvlConfig(maxLvPlanId, campLv)

				if lvlCfg and maxList then
					local maxUpLvl = lvlCfg.maxLv

					if lvl < maxUpLvl then
						GameUtil.SetActive(self.btnLevelUp, true)

						local nextCostCfg = SeasonMainCampConfig.instance:getUpgradeConfig(teamUpgradePlanId, lvl + 1)

						if nextCostCfg then
							local isAllEnough = true
							local arr = string.split(nextCostCfg.cost, "#")

							for i, v in ipairs(arr) do
								local type, id, num = MaterialMgr.getMatParams(v)
								local isEnough = MaterialModel.instance:IsEnough(type, id, num)

								isAllEnough = isEnough and isAllEnough
							end

							GameUtil.SetActive(self.btnLevelUpRed, isAllEnough)
						end
					else
						local idx = table.indexof(maxList, lvlCfg)

						idx = math.min(idx + 1, #maxList)

						local nextMaxLvCfg = maxList[idx]

						if nextMaxLvCfg then
							GameUtil.SetActive(self.lockTip, true)

							self.txtLockTip.text = langPara("主营地%s级才能继续升级", nextMaxLvCfg.campLv)
						end
					end
				end

				local curCfg = SeasonMainCampConfig.instance:getUpgradeConfig(teamUpgradePlanId, lvl)

				if curCfg then
					attrs = FightingPowerFormula.instance:parseAttrValues(curCfg.propertyApp) or {}
				end

				local nextCostCfg = SeasonMainCampConfig.instance:getUpgradeConfig(teamUpgradePlanId, lvl + 1)

				if nextCostCfg then
					self.curCost = nextCostCfg.cost

					local content = ""
					local arr = string.split(self.curCost, "#")

					for i, v in ipairs(arr) do
						local type, id, num = MaterialMgr.getMatParams(v)

						content = content .. MaterialMgr.getContentMatStr(v, 35, -10, MaterialMgr.ICON_TYPE_ICON) .. "x"
						content = not MaterialModel.instance:IsEnough(type, id, num) and content .. string.format("<color=#FF0000>%s</color> ", num) or content .. num .. " "
					end

					self.txtCost.text = langPara("消耗：%s", content)
					nextattrs = FightingPowerFormula.instance:parseAttrValues(nextCostCfg.propertyApp) or {}
				else
					GameUtil.SetActive(self.btnLevelUp, false)
				end
			end
		end

		teamUpgradePlanId = teamConfig.teamUpgradePlanId

		local maxLv = SeasonMainCampConfig.instance:getUpgradeConfigList(teamConfig.teamUpgradePlanId)

		if maxLv <= lvl then
			GameUtil.SetActive(self.txtNextLevel, false)
			GameUtil.SetActive(self.lockTip, false)
		end
	end

	self:showFormation(teamMo)
	self:showAttrList(attrs, nextattrs)

	for i, v in ipairs(self.tabList) do
		local teamMo = SeasonTeamsModel.instance:getTeam(i)
		local boo = SeasonMainCampController.instance:checkTrainRed(teamMo)

		GameUtil.SetActive(self.tabRedList[i], boo)
	end
end

function SeasontrainingcourseView:_playCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	self:_removeCellEff(go)

	local resPath = SeasontrainingcourseView.propertyEffect

	local function finishHandler()
		self:_removeCellEff(go)
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, resPath, nil, nil, nil, false, nil, finishHandler, nil, nil)

	self._effs[go]:setParent(go.transform)
	self._effs[go]:setScaleXYZ(1, 1, 1)
	self._effs[go]:setLocalPos(0, 0, 0)
end

function SeasontrainingcourseView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function SeasontrainingcourseView:showAttrList(attrs, nextattrs)
	self.txtPower.text = langPara("当前等级战力：%s", AttrMo.calcFightPowerByAttrs(attrs))

	local showList = self:getCompareAttrList(attrs, nextattrs)

	for i, go in ipairs(self.attrList) do
		local obj = showList[i]

		if obj then
			GameUtil.SetActive(go, true)

			local arrow = goutil.findChild(go, "arrow")
			local txtNow = goutil.findChildTextComponent(go, "txtNow")
			local txtNext = goutil.findChildTextComponent(go, "txtNext")
			local val = checknumber(obj.curCfg)
			local addVal = val

			if val > 0 and val < 1 then
				val = val * 100 .. "%"
			end

			txtNow.text = langPara("%s+%s", ConstString.Attr[obj.key], val)

			GameUtil.SetActive(arrow, false)

			txtNext.text = ""

			if checknumber(obj.nextCfg) > 0 then
				GameUtil.SetActive(arrow, true)

				val = checknumber(obj.nextCfg)
				addVal = val - addVal

				if val > 0 and val < 1 then
					val = val * 100 .. "%"
					addVal = addVal * 100 .. "%"
				end

				txtNext.text = langPara("%s+%s<color=#4ABC87FF>(+%s)</color>", ConstString.Attr[obj.key], val, addVal)
			end
		else
			GameUtil.SetActive(go, false)
		end
	end
end

function SeasontrainingcourseView:getCompareAttrList(attrs, nextattrs)
	local showList = {}

	for k, v in pairs(attrs) do
		local obj = {}

		obj.key = k
		obj.curCfg = v
		obj.nextCfg = checknumber(nextattrs[k])

		table.insert(showList, obj)
	end

	for k, v in pairs(nextattrs) do
		if attrs[k] == nil then
			local obj = {}

			obj.key = k
			obj.curCfg = 0
			obj.nextCfg = v

			table.insert(showList, obj)
		end
	end

	return showList
end

function SeasontrainingcourseView:onTabClick(idx)
	local teams = SeasonTeamsModel.instance:getTeams() or {}
	local teamCount = #teams

	if teamCount < idx then
		local seasonId = SeasonModel.instance:getSeasonId()
		local campLv = checknumber(SeasonMainCampModel.instance:getCampLv())
		local tgCfg = SeasonMainCampConfig.instance:getTrainingGroundConfig(seasonId)
		local teamPlanId = tgCfg.teamPlanId
		local teamLevelCfg = SeasonMainCampConfig.instance:getTeamConfig(teamPlanId, idx)

		TipsFacade.instance:openCommonTips(langPara("主营地升级到Lv.%s后开启", teamLevelCfg.campLv))

		return
	end

	if self.curSelectTeamId == idx then
		return
	end

	SeasonFmtController.instance.curSelectTrainTeamId = idx
	self.curSelectTeamId = idx

	for i, v in ipairs(self.tabList) do
		if i == idx then
			GameUtil.setUIGroupIdx(v, 1)
		else
			GameUtil.setUIGroupIdx(v, 0)
		end

		local teamMo = SeasonTeamsModel.instance:getTeam(i)
		local boo = SeasonMainCampController.instance:checkTrainRed(teamMo)

		GameUtil.SetActive(self.tabRedList[i], boo)
	end

	self:onRefreshUI()
end

function SeasontrainingcourseView:onClickLvlup()
	if not string.nilorempty(self.curCost) then
		local str = ""
		local arr = string.split(self.curCost, "#")

		for i, v in ipairs(arr) do
			local type, id, num = MaterialMgr.getMatParams(v)
			local name = MaterialMgr.getMaterialsName(type, id)

			if not MaterialFacade.instance:checkMatEnough(type, id, num) then
				return
			end

			str = str .. name .. "x" .. num .. " "
		end

		SeasonController.instance:sendTrainingGroupLvlup(self.curSelectTeamId)
	end
end

return SeasontrainingcourseView
