-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractskillpopView.lua

module("logic.extensions.contract.view.ContractskillpopView", package.seeall)

local ContractskillpopView = class("ContractskillpopView", ViewComponent)
local localDataKey = "contract_skill_reset_skip_ani"

function ContractskillpopView:unbindEvents()
	ContractskillpopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnSkip)
	GameUtil.rmClickHandler(self._btnTips)
	GameUtil.rmClickHandler(self._freeGo)
end

function ContractskillpopView:bindEvents()
	ContractskillpopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnSkip, self._onClickSkip, self)
	GameUtil.addClickHandler(self._btnTips, self._onClickTips, self)
	GameUtil.addClickHandler(self._freeGo, self._onClickTips2, self)
end

function ContractskillpopView:buildUI()
	ContractskillpopView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("layout/btnSure")
	self._btnCancel = self:getGo("layout/btnCancel")
	self._btnReset = self:getGo("layout/reset/btnReset")
	self._resetGo = self:getGo("layout/reset")
	self._txtCost = self:getTxt("layout/reset/txtCost")
	self._itemIcon = self:getGo("layout/reset/txtCost/icon")
	self._icon = self:getGo("left/petCell/icon")
	self._txtName = self:getTxt("left/petCell/txtName")
	self._item = self:getGo("item")
	self._tableview = self:getGo("left/tableview")
	self._topSkillCell = self:getGo("right/topSkillCell")
	self._tableviewTop = self:getGo("right/tableviewTop")
	self._skillCell = self:getGo("right/skillCell")
	self._down = self:getGo("right/down")
	self._scrollTopList = ScrollerList.create(self._tableviewTop, self._topSkillCell, GameUtil.handler(self._updateTopCell, self), GameUtil.handler(self._clearTopCell, self))

	self._scrollTopList:setCenterMode(true)

	self._scrollLeftList = ScrollerList.create(self._tableview, self._item, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._huamianTitle = self:getGo("right/huamianTitle")
	self._imgArrow = self:getGo("right/imgArrow")
	self._goldBarItem = self:getGo("goldBar/img")
	self._goldBarNum = self:getTxt("goldBar/txt")
	self._btnSkip = self:getGo("btnSkip")
	self._imgSelect = self:getGo("btnSkip/imgSelect")
	self._freeGo = self:getGo("freeGo")
	self._txtCount = self:getTxt("layout/reset/txtCount")
	self._btnTips = self:getGo("layout/reset/txtCount/btnTips")
	self._freeTxtGo = self:getGo("freeTxt")
	self._time = self:getGo("time")
	self._txtTime = self:getTxt("time/txt")
end

function ContractskillpopView:onExit()
	ContractskillpopView.super.onExit(self)
	self._scrollTopList:dispose()
	self._scrollLeftList:dispose()
	MaterialMgr.resetAll(self._goldBarItem)
	removetimer(self._onSelectDown, self)
end

function ContractskillpopView:onEnter()
	ContractskillpopView.super.onEnter(self)

	self._isfreeNow = false
	self._curSelectSkillId = 0
	self._petMo = self:getFirstParam()

	local proxy = MaterialMgr.setCellByMo(self._petMo, self._icon)

	self._txtName.text = self._petMo.name

	if proxy then
		proxy.binder:setClickCallBack(function()
			CommonTipsMgr.instance:showPetTips(self._petMo)
		end)
	end

	local map = ContractConfig.instance:getItsMasterList(self._petMo.raceId)
	local list = {}

	for k, v in pairs(map or {}) do
		table.insert(list, k)
	end

	self._scrollLeftList:reloadData(list)

	local costStr = ContractConfig.instance:getConstValueByKey("RESET_CONTRACT_SKILL_COST")

	self._curCostStr = costStr
	self._isSkip = GameUtil.getUserData(localDataKey) or false

	goutil.setActive(self._imgSelect, self._isSkip)

	self._costNum = self:_setGoldBar(costStr)

	self:_updateMatCount()
	self:_updateSkillList()
	self.addGEvent(self, GlobalNotify.NEW_CONTRACT_SKILL_INFO_UPDATE, self._onRefreshUI, self)
	self.addGEvent(self, GlobalNotify.NEW_CONTRACT_SKILL_INFO_RESET, self._onResetAni, self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._updateMatCount, self)
	self:_onRefreshUI()
	ContractController.instance:sendGetNewContractSkillInfo()
end

function ContractskillpopView:_onResetAni()
	local info = ContractModel.instance:getNewTempSkill(self._petMo.petId)

	if info then
		local newSkillId = checknumber(info.tempContractSkillId)
		local index = 0
		local cfgStrategys = ContractConfig.instance:getSkillStrategyById() or {}

		for i, data in ipairs(cfgStrategys) do
			if data.contractSkillId == newSkillId then
				index = i - 1

				break
			end
		end

		if self._isSkip then
			self:_onSelectDown(index)
			self:_onRefreshUI()
		else
			local len = #cfgStrategys
			local total = index + #cfgStrategys * 3

			self.tween = TweenUtil.ValueTo(0, total, 2, function(val)
				local idx = math.round(val)

				idx = idx % len

				self:_onSelectDown(idx)
			end, function()
				self.tween = nil

				self:_onRefreshUI()
			end, self, DG.Tweening.Ease.InOutSine)
		end
	end
end

function ContractskillpopView:_onSelectDown(idx)
	if idx == nil then
		idx = -1
	end

	for i, v in pairs(self._downSelectMap) do
		GameUtil.SetActive(v, i == idx + 1)
	end
end

function ContractskillpopView:_onRefreshUI()
	GameUtil.SetActive(self._huamianTitle, false)
	GameUtil.SetActive(self._resetGo, false)
	GameUtil.SetActive(self._btnSure, false)
	GameUtil.SetActive(self._btnCancel, false)
	GameUtil.SetActive(self._topSkillCell, false)
	GameUtil.SetActive(self._imgArrow, false)
	GameUtil.SetActive(self._freeGo, false)
	GameUtil.SetActive(self._freeGo, false)

	local selectInfo = ContractModel.instance:getSelfSelectInfo(self._petMo.raceId) or {}
	local count = checknumber(selectInfo.resetTimes)
	local total = checknumber(ContractConfig.instance:getConstValueByKey("SELF_SELECT_NEED_RESETS_TIMES"))
	local actId = checknumber(ContractConfig.instance:getConstValueByKey("ACTIVITY_ID"))

	GameUtil.SetActive(self._time, false)

	if actId > 0 and ActivityDefineController.instance:checkIsInActivityTimeByActivityId(actId) then
		local campaignCfg = ActivityPopupConfig.instance:getCampaignCfg(actId)

		if campaignCfg and campaignCfg.effect == GameEnum.CampaignType.petContractSkillSelfSelect then
			total = checknumber(campaignCfg.featureParam)

			GameUtil.SetActive(self._time, true)

			self._txtTime.text = TimeGateController.instance:getActTimeShow(actId)
		end
	end

	self._txtCount.text = count .. "/" .. total
	self._isfreeNow = total <= count or checkbool(selectInfo.hadSelfSelect)

	GameUtil.SetActive(self._freeGo, self._isfreeNow)
	GameUtil.SetActive(self._resetGo, not self._isfreeNow)
	GameUtil.SetActive(self._btnSkip, not self._isfreeNow)

	local info = ContractModel.instance:getNewTempSkill(self._petMo.petId)

	if info and not self._isfreeNow then
		local newSkillId = checknumber(info.tempContractSkillId)

		self:_showContractSkillView(newSkillId)
	else
		self:_showContractSkillView(0)
	end
end

function ContractskillpopView:_showContractSkillView(newSkillId)
	self._curSelectSkillId = newSkillId

	local list = {}
	local tem = {}

	tem.skillId = self._petMo.contractSkillId
	tem.isNew = false

	table.insert(list, tem)

	if checknumber(newSkillId) > 0 then
		local tem2 = {}

		tem2.skillId = newSkillId
		tem2.isNew = true

		table.insert(list, tem2)
		GameUtil.SetActive(self._btnSure, true)
		GameUtil.SetActive(self._btnCancel, true)
		GameUtil.SetActive(self._imgArrow, true)
		GameUtil.SetActive(self._topSkillCell, false)
		GameUtil.SetActive(self._freeTxtGo, false)
		self._scrollTopList:reloadData(list)
	else
		GameUtil.SetActive(self._btnSure, false)
		GameUtil.SetActive(self._btnCancel, false)
		GameUtil.SetActive(self._huamianTitle, true)
		GameUtil.SetActive(self._topSkillCell, true)
		GameUtil.SetActive(self._freeTxtGo, self._isfreeNow)
		self._scrollTopList:reloadData({})
		self._updateTopCell(self, self, self._topSkillCell, tem)
	end
end

function ContractskillpopView:_updateTopCell(view, cell, data, tag)
	local imgNew = goutil.findChild(cell, "imgNew")
	local skillIcon = goutil.findChild(cell, "skillIcon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")

	MaterialMgr.setCell(MatType.Skill, data.skillId, skillIcon)

	local cfg = MaterialMgr.getMatCfg(MatType.Skill, data.skillId)

	if cfg then
		txtName.text = cfg.name
		txtDesc.text = cfg.desc
	end

	GameUtil.SetActive(imgNew, data.isNew)
end

function ContractskillpopView:_clearTopCell(cell)
	local skillIcon = goutil.findChild(cell, "skillIcon")

	MaterialMgr.resetAll(skillIcon)
end

function ContractskillpopView:_updatePetCell(view, cell, data, tag)
	local node = goutil.findChild(cell, "node")
	local btn = goutil.findChild(cell, "btn")

	GameUtil.SetActive(btn, false)

	local proxy = MaterialMgr.setCell(MatType.Pet, data, node)
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, data)
end

function ContractskillpopView:_clearPetCell(cell)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.resetAll(node)
end

function ContractskillpopView:_setGoldBar(costStr)
	local type, id, costNum = MaterialMgr.getMatParams(costStr)

	MaterialMgr.setIcon(self._itemIcon, type, id)

	self._txtCost.text = costNum

	MaterialMgr.setIcon(self._goldBarItem, type, id)
end

function ContractskillpopView:_updateSkillList()
	local cfgStrategys = ContractConfig.instance:getSkillStrategyById()

	goutil.clearChildren(self._down)
	GameUtil.SetActive(self._skillCell, false)

	self._downList = {}
	self._downSelectMap = {}

	for i, data in ipairs(cfgStrategys or {}) do
		local cell = goutil.cloneAndSetParent(self._skillCell, self._down.transform, "skill_" .. i)

		GameUtil.SetActive(cell, true)

		local skillIcon = goutil.findChild(cell, "skillIcon")
		local txtName = goutil.findChildTextComponent(cell, "txtName")
		local select = goutil.findChild(cell, "select")

		GameUtil.SetActive(select, false)

		local proxy = MaterialMgr.setCell(MatType.Skill, data.contractSkillId, skillIcon)

		if proxy then
			proxy.binder:setDownCallBack(function()
				if self._isfreeNow == false then
					CommonTipsMgr.instance:openMaterialTips(cell, MatType.Skill, data.contractSkillId)
				elseif data.contractSkillId ~= self._petMo.contractSkillId then
					self:_onSelectDown(i - 1)
					self:_showContractSkillView(data.contractSkillId)
				else
					TipsFacade.instance:openCommonTips("切换一个不一样的契约技吧~")
				end
			end)
		end

		local cfg = MaterialMgr.getMatCfg(MatType.Skill, data.contractSkillId)

		if cfg then
			txtName.text = cfg.name
		end

		table.insert(self._downList, cell)

		self._downSelectMap[i] = select
	end
end

function ContractskillpopView:_onClickReset()
	local matType, cfgId, num = MaterialMgr.getMatParams(self._curCostStr)
	local name = MaterialMgr.getMaterialsName(matType, cfgId)
	local content = string.format("是否消耗%d个%s，进行技能重置？", num, name)

	TipsFacade.instance:openPopupCostMatViewNew(matType, cfgId, num, content, function()
		ContractController.instance:sendResetNewContractSkill(self._petMo.petId)
	end)
end

function ContractskillpopView:_onClickSure()
	if self._isfreeNow then
		ContractController:sendContractSkillSelfSelect(self._petMo.petId, self._curSelectSkillId)
		self:_onSelectDown()
		self:_showContractSkillView(0)
	else
		local info = ContractModel.instance:getNewTempSkill(self._petMo.petId) or {}
		local newSkillId = checknumber(info.tempContractSkillId)

		if newSkillId > 0 then
			self._petMo.contractSkillId = newSkillId
		end

		self:_onSelectDown()
		ContractController.instance:sendNewConfirmContractSkill(self._petMo.petId, true)
	end
end

function ContractskillpopView:_onClickCancel()
	if self._isfreeNow then
		self:_onSelectDown()
		self:_showContractSkillView(0)
	else
		local content = "是否放弃替换新的契约技?"

		TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
			self:_onSelectDown()
			ContractController.instance:sendNewConfirmContractSkill(self._petMo.petId, false)
		end)
	end
end

function ContractskillpopView:_updateMatCount()
	local matType, matId = MaterialMgr.getMatParams(self._curCostStr)

	self._goldBarNum.text = MaterialModel.instance:getMaterialsNumber(matType, matId)
end

function ContractskillpopView:_onClickSkip()
	self._isSkip = not self._isSkip

	GameUtil.saveUserData(localDataKey, self._isSkip)
	goutil.setActive(self._imgSelect, self._isSkip)
end

function ContractskillpopView:_onClickTips()
	local tips = ContractConfig.instance:getConstValueByKey("SELF_SELECT_COUNT_TIPS")

	CommonTipsMgr.instance:showTextTips(tips, self._btnTips)
end

function ContractskillpopView:_onClickTips2()
	local tips = ContractConfig.instance:getConstValueByKey("SELF_SELECT_FREE_TIPS")

	CommonTipsMgr.instance:showTextTips(tips, self._freeGo)
end

return ContractskillpopView
