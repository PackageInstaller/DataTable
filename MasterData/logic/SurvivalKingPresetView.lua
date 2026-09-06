-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingPresetView.lua

module("logic.extensions.survivalking.view.SurvivalKingPresetView", package.seeall)

local SurvivalKingPresetView = class("SurvivalKingPresetView", ViewComponent)

function SurvivalKingPresetView:ctor()
	SurvivalKingPresetView.super.ctor(self)
end

function SurvivalKingPresetView:unbindEvents()
	SurvivalKingPresetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSignUp)

	for i, cell in ipairs(self._groupCells) do
		GameUtil.rmClickHandler(cell.btnEnter)
	end
end

function SurvivalKingPresetView:bindEvents()
	SurvivalKingPresetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSignUp, self._onClickSignUp, self)

	for i, cell in ipairs(self._groupCells) do
		GameUtil.addClickHandler(cell.btnEnter, GameUtil.handler(self._onClickChangeFmt, self, i))
	end
end

function SurvivalKingPresetView:buildUI()
	SurvivalKingPresetView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")

	local goTabSign = self:getGo("signup/tableview")
	local goCellSign = self:getGo("signup/tableview/tablecell")

	self._tableViewSign = ScrollerList.create(goTabSign, goCellSign, GameUtil.handler(self._updateCellSign, self), GameUtil.handler(self._clearCellSign, self))
	self._btnSignUp = self:getGo("signup/btnSignUp")

	local goTabBuff = self:getGo("buff/tableview")
	local goCellBuff = self:getGo("buff/tableview/tablecell")

	self._tableViewBuff = ScrollerList.create(goTabBuff, goCellBuff, GameUtil.handler(self._updateCellBuff, self), GameUtil.handler(self._clearCellBuff, self))
	self._groupCells = {}

	for i = 1, 2 do
		local cell = {}

		cell.go = self:getGo(string.format("fmts/group%d", i))
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
end

function SurvivalKingPresetView:onExit()
	SurvivalKingPresetView.super.onExit(self)
	self._tableViewSign:dispose()
	self._tableViewBuff:dispose()

	for i, cell in ipairs(self._groupCells) do
		for posId, icon in ipairs(cell.fmts) do
			MaterialMgr.resetAll(icon)
		end
	end
end

function SurvivalKingPresetView:onEnter()
	SurvivalKingPresetView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SurvivalKingUpdatePresetInfo, self._updatePresetInfo, self)
	self.addGEvent(self, GlobalNotify.SurvivalKingSignUp, self._updateSignUpInfo, self)
	self.addGEvent(self, GlobalNotify.SurvivalKingGetBaseInfo, self._updateSignUpInfo, self)
	self.addGEvent(self, GlobalNotify.SurvivalKingBuyBuff, self._updateBuffInfo, self)

	self._activityId = 529001

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	SurvivalKingController.instance:sendGetPresetInfo(self._activityId)
	SurvivalKingController.instance:getBaseInfo(self._activityId)
end

function SurvivalKingPresetView:_updateUIByCfg()
	self._roundCfgs = SurvivalKingConfig.instance:getAllRoundCfgs(self._activityId) or {}
	self._actCfg = SurvivalKingConfig.instance:getActivityCfg(self._activityId)
	self._prizeTimeMax = self._actCfg.prizeTimes or 0
end

function SurvivalKingPresetView:_updateUIByInfo()
	self:_updatePresetInfo()
	self:_updateSignUpInfo()
	self:_updateBuffInfo()
end

function SurvivalKingPresetView:_updatePresetInfo()
	self:_updateBuffInfo()

	self._defFormInfoMap = SurvivalKingModel.instance:getDefFormInfos(self._activityId) or {}

	for i, cell in ipairs(self._groupCells) do
		if not self._defFormInfoMap[i] then
			for posId, icon in ipairs(cell.fmts) do
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

function SurvivalKingPresetView:_updateBuffInfo()
	self._defBuffs = SurvivalKingModel.instance:getDefBuffs(self._activityId) or {}

	self._tableViewBuff:reloadData(self._roundCfgs)
end

function SurvivalKingPresetView:_updateSignUpInfo()
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

	self._txtTips.text = string.format("今日奖励次数：<color=#feeea4>%d</color>/%d", Mathf.Max(self._prizeTimeMax - self._hasSignInTime, 0), self._prizeTimeMax)
end

function SurvivalKingPresetView:_onClickSignUp()
	if SurvivalKingModel.instance:isAllEmptyForm(self._activityId) then
		TipsFacade.instance:openCommonTips("请先预设守阵")

		return
	end

	local timeStatus = SurvivalKingController.instance:getCurStatusByTime(self._activityId)

	if timeStatus ~= SurvivalKingController.TimeStatus.SignUp then
		TipsFacade.instance:openCommonTips("仅可在报名时间内调整，请在场次结束后修改！")

		return
	end

	UIStateManager.instance:push(ViewName.SurvivalKingSignView, self._activityId)
end

function SurvivalKingPresetView:_updateCellSign(view, cell, data, tag)
	local go = cell.gameObject
	local txt = goutil.findChildTextComponent(go, "txt")
	local sessionCfg = SurvivalKingConfig.instance:getSessionCfg(self._activityId, checknumber(data))

	if sessionCfg == nil then
		return
	end

	txt.text = sessionCfg.sessionName or ""
end

function SurvivalKingPresetView:_clearCellSign(cell)
	return
end

function SurvivalKingPresetView:_updateCellBuff(view, cell, data, tag)
	local go = cell.gameObject
	local item = goutil.findChild(go, "info/item")
	local goInfo = goutil.findChild(go, "info")
	local txtRound = goutil.findChildTextComponent(go, "txtRound")
	local txtName = goutil.findChildTextComponent(go, "info/txtName")
	local txtCount = goutil.findChildTextComponent(go, "info/txtCount")
	local btnChange = goutil.findChild(go, "btnChange")
	local tipsEmpty = goutil.findChild(go, "tipsEmpty")

	if not data.roundId then
		local roundId = 0

		txtRound.text = string.format("第\n%s\n轮", GameUtil.getChineseNumber(roundId))

		if not self._defBuffs[roundId] then
			local buffId = 0

			if buffId > 0 then
				local buffCfg = SurvivalKingConfig.instance:getBuffCfgById(self._activityId, buffId)

				if buffCfg then
					local iconPath = string.format("%s.png", buffCfg.iconUrl)

					uGuiUtil.setSpriteToImage(item, uGuiUtil.SpriteType.BigBg, iconPath)

					txtCount.text = string.format("剩余%d个", SurvivalKingModel.instance:getBuffNum(self._activityId, buffId))

					goutil.setActive(goInfo, true)
					goutil.setActive(tipsEmpty, false)

					txtName.text = buffCfg.name
				else
					goutil.setActive(goInfo, false)
					goutil.setActive(tipsEmpty, true)

					txtCount.text = ""
				end
			else
				goutil.setActive(goInfo, false)
				goutil.setActive(tipsEmpty, true)

				txtCount.text = ""
			end

			GameUtil.addClickHandler(btnChange, GameUtil.handler(self._onClickChangeBuff, self, roundId))
		end
	end
end

function SurvivalKingPresetView:_clearCellBuff(cell)
	local go = cell.gameObject
	local item = goutil.findChild(go, "info/item")

	uGuiUtil.clearImage(item)

	local btnChange = goutil.findChild(go, "btnChange")

	GameUtil.rmClickHandler(btnChange)
end

function SurvivalKingPresetView:_onClickChangeBuff(roundId)
	if SurvivalKingModel.instance:isAllEmptyForm(self._activityId) then
		TipsFacade.instance:openCommonTips("请先预设守阵")

		return
	end

	local timeStatus = SurvivalKingController.instance:getCurStatusByTime(self._activityId)

	if timeStatus ~= SurvivalKingController.TimeStatus.SignUp then
		TipsFacade.instance:openCommonTips("仅可在报名时间内调整，请在场次结束后修改！")

		return
	end

	UIStateManager.instance:push(ViewName.SurvivalKingBuffView, self._activityId, roundId)
end

function SurvivalKingPresetView:_onClickChangeFmt(groupId)
	local timeStatus = SurvivalKingController.instance:getCurStatusByTime(self._activityId)

	if timeStatus ~= SurvivalKingController.TimeStatus.SignUp then
		TipsFacade.instance:openCommonTips("仅可在报名时间内调整，请在场次结束后修改！")

		return
	end

	SurvivalKingController.instance:showDefMissionFormation(self._activityId, groupId)
end

return SurvivalKingPresetView
