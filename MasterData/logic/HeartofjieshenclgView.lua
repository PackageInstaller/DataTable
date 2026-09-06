-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofjieshen/view/HeartofjieshenclgView.lua

module("logic.extensions.heartofjieshen.view.HeartofjieshenclgView", package.seeall)

local HeartofjieshenclgView = class("HeartofjieshenclgView", ViewComponent)

function HeartofjieshenclgView:ctor()
	HeartofjieshenclgView.super.ctor(self)
end

function HeartofjieshenclgView:unbindEvents()
	HeartofjieshenclgView.super.unbindEvents(self)
	self._btnRank:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function HeartofjieshenclgView:bindEvents()
	HeartofjieshenclgView.super.bindEvents(self)
	self._btnRank:AddClickListener(self._onClickbtnRank, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function HeartofjieshenclgView:buildUI()
	HeartofjieshenclgView.super.buildUI(self)

	self._btnRank = self:getBtn("btnRank")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._tipsCol = goutil.findChild(self.mainGO, "tipsCol")
	self._tipsCol_txt = goutil.findChildTextComponent(self.mainGO, "tipsCol/txt")
	self._singleLine = self:getGo("fmtCol/fmtView"):GetComponent(ComponentType.UILayoutSingleLine)
	self._fmtCol_fmtView = goutil.findChild(self.mainGO, "fmtCol/fmtView")
	self._fmtCol_fmtCell = goutil.findChild(self.mainGO, "fmtCol/fmtCell")

	GameUtil.SetActive(self._fmtCol_fmtCell, false)

	self._txtMaxDamage = self:getTxt("txtMaxDamage")
	self._pointItemGo = self:getGo("reward/pointItem")
	self._txtTip = self:getTxt("txtTip")
	self._txtTip.text = ""
end

function HeartofjieshenclgView:onExit()
	HeartofjieshenclgView.super.onExit(self)
	self:_onClearFmtColUI()
	MaterialMgr.resetAll(self._pointItemGo)
end

function HeartofjieshenclgView:onEnter()
	HeartofjieshenclgView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HeartOfJieShenClgGetInfoRes, self._updateUI, self)

	self._activityId = self:getFirstParam()
	self._actCfg = HeartofjieshenConfig.instance:getActCfg(self._activityId) or {}

	self:_updateDesc()
	self:_onUpdateFmtColUI()
	self:_updateReward()
	HeartOfJieShenClgAgent.instance:sendPM_HeartOfJieShenClgGetInfoReq(self._activityId)
end

function HeartofjieshenclgView:_updateUI()
	self:_updateMaxDamage()
	self:_updateTip()
end

function HeartofjieshenclgView:_onClickbtnRank()
	UIStateManager.instance:push(ViewName.HeartofjieshenrankView, self._activityId, HeartofjieshenModel.TAB_HISTORY)
end

function HeartofjieshenclgView:_onClickbtnTip()
	TipsFacade.instance:openRulesView(HeartofjieshenConfig.instance:getCommonValue(self._activityId, "ruleKey"))
end

function HeartofjieshenclgView:_onClickbtnClose()
	self:close()
end

function HeartofjieshenclgView:_updateDesc()
	local key = HeartofjieshenConfig.instance:getRuleKey(self._activityId, "gameRuleKey")
	local ruleCo = RulesConfig.instance:getRuleCo(key)

	self._tipsCol_txt.text = ruleCo.rules
end

function HeartofjieshenclgView:_onUpdateFmtColUI()
	local parentTran = self._fmtCol_fmtView.transform
	local childGo = self._fmtCol_fmtCell
	local children = GameUtil.getChildren(parentTran)
	local cfgs = HeartofjieshenConfig.instance:getCreepsMasterCfgs(self._activityId)
	local length = #cfgs

	for idx, cfg in ipairs(cfgs) do
		local mainGo = children[idx]

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))
		end

		self:_updateFmtCell(mainGo, cfg)
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= length)
	end

	self._singleLine:Layout()
end

function HeartofjieshenclgView:_onClearFmtColUI()
	local parentTran = self._fmtCol_fmtView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in pairs(children) do
		self:_clearFmtCell(mainGo)
	end
end

function HeartofjieshenclgView:_updateFmtCell(mainGo, masterCfg)
	local fmt = goutil.findChild(mainGo, "fmt")
	local fmtView = goutil.findChild(mainGo, "fmt/fmtView")
	local imgPass = goutil.findChild(mainGo, "fmt/imgPass")
	local btnFormation = goutil.findChild(mainGo, "fmt/btnFormation")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local creepsCfgs = HeartofjieshenConfig.instance:getCreepsCfgs(masterCfg.creepsMasterId)
	local isPass = HeartofjieshenModel.instance:isClgFinish(masterCfg.fmtType)

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "icon")
		local creepsData

		for _, cData in ipairs(creepsCfgs) do
			if cData.posId == posId then
				creepsData = cData

				break
			end
		end

		if creepsData then
			local skinId = checknumber(creepsData.faceId)

			if skinId == 0 then
				skinId = creepsData.raceId
			end

			local proxy = MaterialMgr.setCell(MatType.Pet, skinId, icon)

			if proxy then
				proxy.binder:setClickCallBack(nil)
			end
		else
			MaterialMgr.resetAll(icon)
		end
	end

	GameUtil.SetActive(imgPass, false)

	txtName.text = masterCfg.name

	GameUtil.addClickHandler(btnFormation, GameUtil.handler(self._onClickFmtCellBtnFormation, self, masterCfg))
end

function HeartofjieshenclgView:_clearFmtCell(mainGo)
	local fmtView = goutil.findChild(mainGo, "fmt/fmtView")
	local btnFormation = goutil.findChild(mainGo, "fmt/btnFormation")

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "icon")

		MaterialMgr.resetAll(icon)
	end

	GameUtil.rmClickHandler(btnFormation)
end

function HeartofjieshenclgView:_onClickFmtCellBtnFormation(masterCfg)
	if masterCfg.fmtType == GameEnum.HeartofjieshenclgFmtType.Chi then
		local isPass = HeartofjieshenModel.instance:isClgFinish(GameEnum.HeartofjieshenclgFmtType.Yi)

		if not isPass then
			local cfgs = HeartofjieshenConfig.instance:getCreepsMasterCfgs(self._activityId)

			for i, v in ipairs(cfgs) do
				if v.fmtType == GameEnum.HeartofjieshenclgFmtType.Yi then
					FloatWordMgr.instance:show(string.format("请从%s挑战开始进入", v.name))

					return
				end
			end

			return
		end
	end

	HeartofjieshenController.instance:enterMission(self._activityId, masterCfg.creepsMasterId, masterCfg.fmtType, self:_getResultViewName())
end

function HeartofjieshenclgView:_getResultViewName()
	return ViewName.HeartofjieshenyiresultView
end

function HeartofjieshenclgView:_updateMaxDamage()
	local maxDamage = HeartofjieshenModel.instance:getHistoryMaxDamage(self._activityId)

	self._txtMaxDamage.text = maxDamage < 10000 and maxDamage or string.format("%.2f万", maxDamage / 10000)
end

function HeartofjieshenclgView:_updateReward()
	MaterialMgr.resetAll(self._pointItemGo)

	local itemStr = HeartofjieshenConfig.instance:getCommonValue(self._activityId, "reward")

	if not string.nilorempty(itemStr) then
		MaterialMgr.setCellByCfg(itemStr, self._pointItemGo)
	end
end

function HeartofjieshenclgView:_updateTip()
	local finish = HeartofjieshenModel.instance:isClgFinish(GameEnum.HeartofjieshenclgFmtType.Yi)

	if finish then
		local info = HeartofjieshenModel.instance:getInfo(self._activityId)
		local hasGain = HeartofjieshenModel.instance:hasGainDailyBalancePrize(self._activityId)

		self._txtTip.text = hasGain and "您已获得奖励榜奖励内容，快去试试冲刺伤害榜吧" or checknumber(info.myCurDailyRank) > 0 and string.format("您在每日榜上第%s名", info.myCurDailyRank) or "您未能上榜奖励榜，再接再厉"
	else
		self._txtTip.text = ""
	end
end

return HeartofjieshenclgView
