-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingLevelPresetView.lua

module("logic.extensions.survivalking.view.SurvivalKingLevelPresetView", package.seeall)

local SurvivalKingLevelPresetView = class("SurvivalKingLevelPresetView", ViewComponent)

function SurvivalKingLevelPresetView:ctor()
	SurvivalKingLevelPresetView.super.ctor(self)
end

function SurvivalKingLevelPresetView:unbindEvents()
	SurvivalKingLevelPresetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSignUp)

	for i, cell in ipairs(self._groupCells) do
		GameUtil.rmClickHandler(cell.btnEnter)
	end
end

function SurvivalKingLevelPresetView:bindEvents()
	SurvivalKingLevelPresetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSignUp, self._onClickSignUp, self)

	for i, cell in ipairs(self._groupCells) do
		GameUtil.addClickHandler(cell.btnEnter, GameUtil.handler(self._onClickChangeFmt, self, i))
	end
end

function SurvivalKingLevelPresetView:buildUI()
	SurvivalKingLevelPresetView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")

	local goTabSign = self:getGo("signup/tableview")
	local goCellSign = self:getGo("signup/tableview/tablecell")

	self._tableViewSign = ScrollerList.create(goTabSign, goCellSign, GameUtil.handler(self._updateCellSign, self), GameUtil.handler(self._clearCellSign, self))

	self._tableViewSign:setCenterMode(true)

	self._btnSignUp = self:getGo("signup/btnSignUp")

	local goTabBuff = self:getGo("buff/tableview")
	local goCellBuff = self:getGo("buff/tableview/tablecell")

	self._tableViewBuff = ScrollerList.create(goTabBuff, goCellBuff, GameUtil.handler(self._updateCellBuff, self), GameUtil.handler(self._clearCellBuff, self))
	self._groupCells = {}

	for i = 1, 2 do
		local cell = {}

		cell.go = self:getGo("fmts/group" .. tostring(i))
		cell.fmts = {}

		local fmtView = goutil.findChild(cell.go, "fmt/fmtView")

		for posId = 1, fmtView.transform.childCount do
			local fmtCellGo = fmtView.transform:GetChild(posId - 1)
			local fmtIcon = goutil.findChild(fmtCellGo, "icon")

			table.insert(cell.fmts, fmtIcon)
		end

		cell.btnEnter = goutil.findChild(cell.go, "btnEnter")
		self._groupCells[i] = cell
	end

	self._powerPetMo = FightingPowerPetMo.New()
	self._txtTips = self:getTxt("tips/txt")
	self._txtCurrentLevel = self:getTxt("buff/txtCurrentLevel")
	self._txtTip = self:getGo("signup/tableview/txtTip")
end

function SurvivalKingLevelPresetView:onExit()
	SurvivalKingLevelPresetView.super.onExit(self)
	self._tableViewSign:dispose()
	self._tableViewBuff:dispose()

	for _, cell in ipairs(self._groupCells) do
		for _, icon in ipairs(cell.fmts) do
			MaterialMgr.resetAll(icon)
		end
	end
end

function SurvivalKingLevelPresetView:onEnter()
	SurvivalKingLevelPresetView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SurvivalKingUpdatePresetInfo, self._updatePresetInfo, self)
	self.addGEvent(self, GlobalNotify.SurvivalKingSignUp, self._updateSignUpInfo, self)
	self.addGEvent(self, GlobalNotify.SurvivalKingGetBaseInfo, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._updateBuffInfo, self)

	self._activityId = 529002

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	SurvivalKingController.instance:sendGetPresetInfo(self._activityId)
	SurvivalKingController.instance:getBaseInfo(self._activityId)
end

function SurvivalKingLevelPresetView:_updateUIByCfg()
	self._roundCfgs = {}

	local allRoundCfgs = SurvivalKingConfig.instance:getAllRoundCfgs(self._activityId) or {}

	for _, roundCfg in pairs(allRoundCfgs) do
		if SurvivalKingConfig.instance:canSetLevelBuff(self._activityId, roundCfg.roundId) then
			table.insert(self._roundCfgs, roundCfg)
		end
	end

	table.sort(self._roundCfgs, function(a, b)
		return a.roundId < b.roundId
	end)

	self._actCfg = SurvivalKingConfig.instance:getActivityCfg(self._activityId)
	self._prizeTimeMax = self._actCfg.prizeTimes or 0
end

function SurvivalKingLevelPresetView:_updateUIByInfo()
	self:_updatePresetInfo()
	self:_updateSignUpInfo()
	self:_updateBuffInfo()
end

function SurvivalKingLevelPresetView:_updatePresetInfo()
	self:_updateBuffInfo()

	self._defFormInfoMap = SurvivalKingModel.instance:getDefFormInfos(self._activityId) or {}

	for i, cell in ipairs(self._groupCells) do
		if not self._defFormInfoMap[i] then
			for _, icon in ipairs(cell.fmts) do
				MaterialMgr.resetAll(icon)
			end

			if not self._defFormInfoMap[i].pos then
				for posId, petId in ipairs(self._defFormInfoMap[i].pos) do
					local icon = cell.fmts[posId]

					if icon and petId > 0 then
						if petId > 100000000 then
							local cfg = SurvivalKingConfig.instance:getSupportPetCfgById(self._activityId, petId)

							if cfg then
								self._powerPetMo:fromChallengeCreepCo(cfg)

								local bagPetMo = self._powerPetMo:toBaseBagPetMo()

								bagPetMo.isSupportedPet = true

								MaterialMgr.setCellByMo(bagPetMo, icon)
							end
						else
							local petMo = BagPetsController.instance:getPet(petId)

							if petMo then
								local maxPetMo = FightingPowerPetMo.getMaxPetMoByData(petMo)

								maxPetMo.attrMo:resetPublicAttr()
								maxPetMo.attrMo:calcTotalAttrs()
								maxPetMo:refreshAllAttr()
								MaterialMgr.setCellByMo(maxPetMo, icon)
							end
						end
					end
				end
			end
		end
	end
end

function SurvivalKingLevelPresetView:_updateBuffInfo()
	self._defLevelBuffs = SurvivalKingModel.instance:getLevelBuffSelections(self._activityId) or {}
	self._levelBuffLevel = SurvivalKingModel.instance:getLevelBuffLevel(self._activityId)

	if self._txtCurrentLevel then
		self._txtCurrentLevel.text = langPara("当前增益等级：LV%s", self._levelBuffLevel or 1)
	end

	self._tableViewBuff:reloadData(self._roundCfgs)
end

function SurvivalKingLevelPresetView:_updateSignUpInfo()
	self._hasSignInTime = 0
	self._hasSignInIds = {}

	local baseInfo = SurvivalKingModel.instance:getBaseInfo(self._activityId)

	if baseInfo then
		if not baseInfo.signUps then
			for _, v in ipairs(baseInfo.signUps) do
				if v.signUp == true then
					table.insert(self._hasSignInIds, v.sessionId)

					self._hasSignInTime = self._hasSignInTime + 1
				end
			end
		end
	end

	self._tableViewSign:reloadData(self._hasSignInIds)
	GameUtil.SetActive(self._txtTip, #self._hasSignInIds == 0)

	self._txtTips.text = langPara("今日奖励次数：<color=#feeea4>%s</color>/%s", Mathf.Max(self._prizeTimeMax - self._hasSignInTime, 0), self._prizeTimeMax)
end

function SurvivalKingLevelPresetView:_onClickSignUp()
	if SurvivalKingModel.instance:isAllEmptyForm(self._activityId) then
		TipsFacade.instance:openCommonTips(lang("请先预设守阵"))

		return
	end

	local timeStatus = SurvivalKingController.instance:getCurStatusByTime(self._activityId)

	if timeStatus ~= SurvivalKingController.TimeStatus.SignUp then
		TipsFacade.instance:openCommonTips(lang("仅可在报名时间内调整，请在场次结束后修改！"))

		return
	end

	UIStateManager.instance:push(ViewName.SurvivalKingSignView, self._activityId)
end

function SurvivalKingLevelPresetView:_updateCellSign(view, cell, data, tag)
	local go = cell.gameObject
	local txt = goutil.findChildTextComponent(go, "txt")
	local sessionCfg = SurvivalKingConfig.instance:getSessionCfg(self._activityId, checknumber(data))

	if sessionCfg == nil then
		return
	end

	txt.text = sessionCfg.sessionName or ""
end

function SurvivalKingLevelPresetView:_clearCellSign(cell)
	return
end

function SurvivalKingLevelPresetView:_updateCellBuff(view, cell, data, tag)
	local go = cell.gameObject
	local item = goutil.findChild(go, "info/item")
	local goInfo = goutil.findChild(go, "info")
	local txtRound = goutil.findChildTextComponent(go, "txtRound")
	local txtName = goutil.findChildTextComponent(go, "info/txtName")
	local txtCount = goutil.findChildTextComponent(go, "info/txtCount")
	local txtDesc = goutil.findChildTextComponent(go, "info/img/desc/viewport/txtDesc")
	local btnChange = goutil.findChild(go, "btnChange")
	local redPoint = goutil.findChild(go, "btnChange/redPoint")
	local tipsEmpty = goutil.findChild(go, "tipsEmpty")

	if not data.roundId then
		local roundId = 0
		local canSetBuff = SurvivalKingConfig.instance:canSetLevelBuff(self._activityId, roundId)
		local upgradeInfo = SurvivalKingController.instance:getLevelBuffUpgradeInfo(self._activityId)

		txtRound.text = langPara("第%s轮", GameUtil.getChineseNumber(roundId))

		if not self._defLevelBuffs[roundId] then
			if self._defLevelBuffs[roundId] > 0 then
				if not SurvivalKingConfig.instance:getLevelBuffCfg(self._activityId, self._defLevelBuffs[roundId], self._levelBuffLevel or 1) then
					local levelCfg

					if levelCfg then
						local iconUrl = levelCfg.iconUrl

						if not string.nilorempty(iconUrl) then
							local iconPath = string.format("%s.png", iconUrl)

							uGuiUtil.setSpriteToImage(item, uGuiUtil.SpriteType.BigBg, iconPath)
						end

						if txtCount then
							txtCount.text = langPara("当前等级Lv%s", self._levelBuffLevel or 1)

							GameUtil.SetActive(txtCount.gameObject, true)
						end

						if txtDesc then
							txtDesc.text = levelCfg.desc or ""
						end

						GameUtil.SetActive(goInfo, true)
						GameUtil.SetActive(tipsEmpty, false)

						txtName.text = levelCfg.name or ""
					else
						GameUtil.SetActive(goInfo, false)
						GameUtil.SetActive(tipsEmpty, true)

						if txtCount then
							txtCount.text = ""

							GameUtil.SetActive(txtCount.gameObject, false)
						end

						if txtDesc then
							txtDesc.text = ""
						end
					end

					GameUtil.SetActive(btnChange, canSetBuff)

					if redPoint then
						GameUtil.SetActive(redPoint, canSetBuff and upgradeInfo.canUpgrade)
					end

					GameUtil.addClickHandler(btnChange, GameUtil.handler(self._onClickChangeBuff, self, roundId))
				end
			end
		end
	end
end

function SurvivalKingLevelPresetView:_clearCellBuff(cell)
	local go = cell.gameObject
	local item = goutil.findChild(go, "info/item")
	local btnChange = goutil.findChild(go, "btnChange")
	local txtDesc = goutil.findChildTextComponent(go, "info/img/desc/viewport/txtDesc")
	local txtCount = goutil.findChildTextComponent(go, "info/txtCount")

	uGuiUtil.clearImage(item)

	if txtDesc then
		txtDesc.text = ""
	end

	if txtCount then
		txtCount.text = ""

		GameUtil.SetActive(txtCount.gameObject, false)
	end

	GameUtil.rmClickHandler(btnChange)
end

function SurvivalKingLevelPresetView:_onClickChangeBuff(roundId)
	if not SurvivalKingConfig.instance:canSetLevelBuff(self._activityId, roundId) then
		TipsFacade.instance:openCommonTips(lang("本轮不可设置buff"))

		return
	end

	if SurvivalKingModel.instance:isAllEmptyForm(self._activityId) then
		TipsFacade.instance:openCommonTips(lang("请先预设守阵"))

		return
	end

	local timeStatus = SurvivalKingController.instance:getCurStatusByTime(self._activityId)

	if timeStatus ~= SurvivalKingController.TimeStatus.SignUp then
		TipsFacade.instance:openCommonTips(lang("仅可在报名时间内调整，请在场次结束后修改！"))

		return
	end

	UIStateManager.instance:push(ViewName.SurvivalKingLevelBuffView, self._activityId, roundId)
end

function SurvivalKingLevelPresetView:_onClickChangeFmt(groupId)
	local timeStatus = SurvivalKingController.instance:getCurStatusByTime(self._activityId)

	if timeStatus ~= SurvivalKingController.TimeStatus.SignUp then
		TipsFacade.instance:openCommonTips(lang("仅可在报名时间内调整，请在场次结束后修改！"))

		return
	end

	SurvivalKingController.instance:showDefMissionFormation(self._activityId, groupId)
end

return SurvivalKingLevelPresetView
