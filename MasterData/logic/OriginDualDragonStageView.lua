-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindualdragon/view/OriginDualDragonStageView.lua

module("logic.extensions.origindualdragon.view.OriginDualDragonStageView", package.seeall)

local OriginDualDragonStageView = class("OriginDualDragonStageView", ViewComponent)
local STAGE_TYPE_KINDNESS = 1
local STAGE_TYPE_EVIL = 2
local LEVEL_TABLE_CELL_POS_X_KINDNESS = -290
local LEVEL_TABLE_CELL_POS_X_EVIL = 315

function OriginDualDragonStageView:ctor()
	OriginDualDragonStageView.super.ctor(self)
end

function OriginDualDragonStageView:buildUI()
	OriginDualDragonStageView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._goLevelTableView = self:getGo("levelTableview")
	self._goLevelCell = self:getGo("levelTableview/levelTablecell")
	self._btnChallenge = self:getGo("info/btnChallenge")
	self._btnReset = self:getGo("info/btnReset")
	self._txtRuleDesc = self:getTxt("info/txtRuleDesc")
	self._levelTableList = ScrollerList.New()
end

function OriginDualDragonStageView:bindEvents()
	OriginDualDragonStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
end

function OriginDualDragonStageView:unbindEvents()
	OriginDualDragonStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnReset)
end

function OriginDualDragonStageView:onEnter()
	OriginDualDragonStageView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 618001
	end

	self._activityCfg = OriginDualDragonConfig.instance:getActivity(self._activityId) or {}
	self._stageCfgMap = OriginDualDragonConfig.instance:getStages(self._activityId) or {}

	self.addGEvent(self, GlobalNotify.PM_OriginDualDragonInfoRes, self._onInfoRes, self)
	self.addGEvent(self, GlobalNotify.PM_OriginDualDragonNotifyChallengeRes, self._onChallengeRes, self)
	self.addGEvent(self, GlobalNotify.PM_OriginDualDragonResetStageRes, self._onResetStage, self)
	self._levelTableList:init(self._goLevelTableView, self._goLevelCell, GameUtil.handler(self._updateLevelTableCell, self), GameUtil.handler(self._clearLevelTableCell, self))
	self:_selectCurrentSelectableStage()
	self:_refreshView()
	OriginDualDragonController.instance:sendInfoReq(self._activityId)

	local changeSetId = OriginDualDragonModel.instance:getTempPrizeChangeSet()

	if changeSetId then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
		OriginDualDragonModel.instance:saveTempPrizeChangeSet(nil)
	end
end

function OriginDualDragonStageView:onExit()
	OriginDualDragonStageView.super.onExit(self)
	self._levelTableList:dispose()
end

function OriginDualDragonStageView:_refreshView()
	self._cellDataList = self:_buildCellDataList()

	self._levelTableList:reloadData(self._cellDataList)

	self._txtRuleDesc.text = lang(self._activityCfg.ruleDesc) or ""
end

function OriginDualDragonStageView:_onInfoRes()
	self:_selectCurrentSelectableStage()
	self:_refreshView()
end

function OriginDualDragonStageView:_onChallengeRes()
	self:_selectCurrentSelectableStage()
	self:_refreshView()
end

function OriginDualDragonStageView:_onClickTip()
	if not GameUtil.isEmptyString(self._activityCfg.ruleKeyMain) then
		TipsFacade.instance:openRulesView(self._activityCfg.ruleKeyMain)
	end
end

function OriginDualDragonStageView:_buildCellDataList()
	local dataList = {}

	if not self._stageCfgMap[STAGE_TYPE_KINDNESS] then
		if not self._stageCfgMap[STAGE_TYPE_EVIL] then
			local evilCfgs = {}

			for stageId, kindnessCfg in ipairs(self._stageCfgMap[STAGE_TYPE_KINDNESS]) do
				table.insert(dataList, {
					stageType = STAGE_TYPE_KINDNESS,
					stageId = checknumber(kindnessCfg.stageId),
					cfg = kindnessCfg
				})

				if evilCfgs[stageId] then
					table.insert(dataList, {
						stageType = STAGE_TYPE_EVIL,
						stageId = checknumber(evilCfgs[stageId].stageId),
						cfg = evilCfgs[stageId]
					})
				end
			end

			return dataList
		end
	end
end

function OriginDualDragonStageView:_selectCurrentSelectableStage()
	local stageType, stageId = OriginDualDragonController.instance:getCurrentSelectableStage(self._activityId)

	self._selectStageType = stageType
	self._selectStageId = stageId
end

function OriginDualDragonStageView:_updateLevelTableCell(view, cell, data, tag)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")
	local btnSpChange = btn:GetComponent(ComponentType.UIImageSpriteChange)
	local btnImg = goutil.findChild(btn, "img")
	local btnImgSpChange = btnImg:GetComponent(ComponentType.UIImageSpriteChange)
	local btnImgImage = goutil.findChildImageComponent(btn, "img")
	local txt = goutil.findChildTextComponent(go, "btn/txt")
	local lock = goutil.findChild(go, "btn/lock")
	local lockSpChange = lock:GetComponent(ComponentType.UIImageSpriteChange)
	local pass = goutil.findChild(go, "btn/pass")
	local arrow = goutil.findChild(go, "arrow")
	local arrowImgSpChange = goutil.findChild(arrow, "img"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtArrowRuleDesc = goutil.findChildTextComponent(go, "arrow/txtArrowRuleDesc")
	local stageType = checknumber(data.stageType)
	local stageId = checknumber(data.stageId)
	local isUnlocked = OriginDualDragonController.instance:isStageUnlocked(self._activityId, stageType, stageId)
	local isPassed = OriginDualDragonController.instance:isStagePassed(self._activityId, stageType, stageId)
	local isSelected = self._selectStageType == stageType and self._selectStageId == stageId

	if stageType == STAGE_TYPE_KINDNESS then
		if not LEVEL_TABLE_CELL_POS_X_KINDNESS then
			local posX = LEVEL_TABLE_CELL_POS_X_EVIL
			local isShowArrow = stageType == STAGE_TYPE_KINDNESS and OriginDualDragonConfig.instance:getStage(self._activityId, STAGE_TYPE_EVIL, stageId) ~= nil or OriginDualDragonConfig.instance:getStage(self._activityId, STAGE_TYPE_KINDNESS, stageId + 1) ~= nil
			local isShowArrowRuleDesc = stageType == STAGE_TYPE_KINDNESS

			GameUtil.rmClickHandler(btn)
			GameUtil.addClickHandler(btn, function()
				self:_onClickStageCell(data)
			end)
			Framework.TransformUtil.SetLocalPos(btn.transform, posX, btn.transform.localPosition.y, btn.transform.localPosition.z)
			btnSpChange:SetState(stageType == STAGE_TYPE_KINDNESS and 0 or 1)
			btnImgSpChange:SetState(stageType == STAGE_TYPE_KINDNESS and 0 or 1)

			if btnImgImage then
				btnImgImage:SetNativeSize()
			end

			lockSpChange:SetState(stageType == STAGE_TYPE_KINDNESS and 0 or 1)
			GameUtil.SetActive(btnImg, isSelected)

			txt.text = data.cfg and lang(data.cfg.stageName) or ""

			GameUtil.SetActive(lock, not isUnlocked)
			GameUtil.SetActive(pass, isPassed)
			GameUtil.SetActive(arrow, isShowArrow)

			if stageType == STAGE_TYPE_KINDNESS then
				local isEvilSelected = self._selectStageType == STAGE_TYPE_EVIL and self._selectStageId == stageId

				arrowImgSpChange:SetState((isSelected or isEvilSelected) and 0 or 3)
			else
				arrowImgSpChange:SetState(1)
			end

			if txtArrowRuleDesc then
				if isShowArrowRuleDesc then
					local kindnessStageCfg = OriginDualDragonConfig.instance:getStage(self._activityId, STAGE_TYPE_KINDNESS, stageId)

					txtArrowRuleDesc.text = kindnessStageCfg and lang(kindnessStageCfg.buffDesc) or ""
				else
					txtArrowRuleDesc.text = ""
				end

				GameUtil.SetActive(txtArrowRuleDesc.gameObject, isShowArrowRuleDesc)
			end
		end
	end
end

function OriginDualDragonStageView:_clearLevelTableCell(cell)
	local btn = goutil.findChild(cell.gameObject, "btn")

	GameUtil.rmClickHandler(btn)
end

function OriginDualDragonStageView:_onClickStageCell(data)
	local stageType = checknumber(data.stageType)
	local stageId = checknumber(data.stageId)
	local isUnlocked = OriginDualDragonController.instance:isStageUnlocked(self._activityId, stageType, stageId)

	if not isUnlocked then
		FloatWordMgr.instance:show(lang("请先通关前置关卡"))

		return
	end

	self._selectStageType = stageType
	self._selectStageId = stageId

	self:_refreshView()
end

function OriginDualDragonStageView:_onClickChallenge()
	local stageType = checknumber(self._selectStageType)
	local stageId = checknumber(self._selectStageId)

	if not OriginDualDragonController.instance:isStageUnlocked(self._activityId, stageType, stageId) then
		FloatWordMgr.instance:show(lang("请先通关前置关卡"))

		return
	end

	if OriginDualDragonController.instance:isStagePassed(self._activityId, stageType, stageId) then
		FloatWordMgr.instance:show(lang("已通关"))

		return
	end

	OriginDualDragonController.instance:openMissionView(self._activityId, stageType, stageId)
end

function OriginDualDragonStageView:_onClickReset()
	local stageType = checknumber(self._selectStageType)
	local stageId = checknumber(self._selectStageId)
	local canReset = OriginDualDragonController.instance:isStageUnlocked(self._activityId, stageType, stageId) and OriginDualDragonController.instance:isStagePassed(self._activityId, stageType, stageId)

	if not canReset then
		FloatWordMgr.instance:show(lang("无需重置"))

		return
	end

	local tipsContent = lang("是否重置该关卡，重置后将退回该关卡的初始状态")

	local function okFunc()
		OriginDualDragonAgent.instance:sendPM_OriginDualDragonResetStageReq(self._activityId, stageId)
	end

	TipsFacade.instance:openPopupWindow(lang("提示"), tipsContent, okFunc, nil, lang("确定"), lang("取消"))
end

function OriginDualDragonStageView:_onResetStage()
	OriginDualDragonController.instance:sendInfoReq(self._activityId)
end

return OriginDualDragonStageView
