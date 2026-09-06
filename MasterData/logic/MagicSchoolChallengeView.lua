-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolChallengeView.lua

module("logic.extensions.magicschool.view.MagicSchoolChallengeView", package.seeall)

local MagicSchoolChallengeView = class("MagicSchoolChallengeView", ViewComponent)
local MAGIC_BLACK_CAMP_IDX = 1

function MagicSchoolChallengeView:ctor()
	MagicSchoolChallengeView.super.ctor(self)
end

function MagicSchoolChallengeView:unbindEvents()
	MagicSchoolChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnLevel)
end

function MagicSchoolChallengeView:bindEvents()
	MagicSchoolChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
	GameUtil.addClickHandler(self._btnLevel, self._onClickBtnLevel, self)
end

function MagicSchoolChallengeView:buildUI()
	MagicSchoolChallengeView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._txtRule = self:getTxt("tip/scrView/Viewport/Content")
	self._imgCampChangeComp = self:getGo("buff/imgCamp"):GetComponent("UIImageSpriteChange")
	self._txtNameCamp = self:getTxt("buff/txtName")
	self._txtBuff = self:getTxt("buff/txtBuff")
	self._btnBuff = self:getGo("buff/btnBuff")
	self._btnLevel = self:getGo("buff/btnLevel")
	self._tablecellChallenge = self:getGo("tableviewChallenge/tablecell")
	self._tableviewChallenge = self:getGo("tableviewChallenge")
	self._scrollList = ScrollerList.create(self._tableviewChallenge, self._tablecellChallenge, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function MagicSchoolChallengeView:onExit()
	MagicSchoolChallengeView.super.onExit(self)
	self._scrollList:dispose()
end

function MagicSchoolChallengeView:onEnter()
	MagicSchoolChallengeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MagicSchoolGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_MagicSchoolSelectBuffRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 514001
	end

	self._campId = checknumber(params[2])

	if self._campId <= 0 then
		local info = MagicSchoolModel.instance:getInfo(self._activityId)
		local campId = info.campId
		local actCfg = MagicSchoolConfig.instance:getActCfg(self._activityId)
		local hasVisitAll = MagicSchoolController.instance:hasVisitAll(self._activityId)
		local acceptInvite = info.acceptInvite

		if not acceptInvite then
			TipsFacade.instance:openPopupWindow(lang("tip"), "尚未接受邀请函，接受并拜访完所有院长后可选择阵营", function()
				UIStateManager.instance:push(ViewName.MagicSchoolMainView, self._activityId)
				UIStateManager.instance:push(ViewName.InvitationCardView, actCfg.activitySummaryId)
			end, function()
				GameUtil.callBack(self:close())
			end)
		elseif not hasVisitAll then
			TipsFacade.instance:openPopupWindow(lang("tip"), "尚未拜访完所有院长，拜访后可选择阵营", function()
				UIStateManager.instance:push(ViewName.MagicSchoolMainView, self._activityId)
			end, function()
				GameUtil.callBack(self:close())
			end)
		elseif campId == 0 then
			TipsFacade.instance:openPopupWindow(lang("tip"), "尚未选择阵营，请先选择阵营", function()
				UIStateManager.instance:push(ViewName.MagicSchoolChooseView, self._activityId)
			end, function()
				GameUtil.callBack(self:close())
			end)
		else
			self._campId = campId
		end
	end

	self._info = MagicSchoolModel.instance:getInfo(self._activityId)
	self._rewardScrollListMap = {}
	self._actCfg = MagicSchoolConfig.instance:getActCfg(self._activityId)
	self._stageCfgs = MagicSchoolConfig.instance:getStageCfgsByCampId(self._activityId, self._campId)

	self:_onSetUI()

	local changeSetId = MagicSchoolModel.instance:popChangeSetId()

	if changeSetId then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end

	MagicSchoolController.instance:sendPM_MagicSchoolGetInfoReq(self._activityId)
end

function MagicSchoolChallengeView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	self._txtRule.text = self._actCfg.ruleRenZheng

	self._scrollList:reloadData(self._stageCfgs)
	self._imgCampChangeComp:SetState(self._campId - 1)

	self._txtNameCamp.text = "白魔法挑战"

	if self._campId == MAGIC_BLACK_CAMP_IDX then
		self._txtNameCamp.text = "黑魔法挑战"
	end
end

function MagicSchoolChallengeView:_onUpdate()
	self._info = MagicSchoolModel.instance:getInfo(self._activityId)

	local curSelectBuffId = self._info.curSelectBuffId
	local curBuffCfg = MagicSchoolConfig.instance:getBuffCfgData(self._activityId, self._campId, curSelectBuffId)

	if curBuffCfg then
		local buffDesc = curBuffCfg.desc

		self._txtBuff.text = string.format("当前能力\n%s", buffDesc)
	end

	self._scrollList:reloadData(self._stageCfgs)
end

function MagicSchoolChallengeView:_setFmt(fmtView, cfg)
	local map = {}

	for _, data in ipairs(cfg) do
		map[data.posId] = data
	end

	for posId = 1, 9 do
		local creepsData = map[posId]
		local go = fmtView.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.clearIcon(con)
		GameUtil.SetActive(go, false)

		if creepsData then
			MaterialMgr.setIcon(con, MatType.PET_SKIN, (checknumber(creepsData.faceId) > 0 or nil) and checknumber(creepsData.faceId))
			GameUtil.SetActive(go, true)
			GameUtil.SetActive(con, true)
		end
	end
end

function MagicSchoolChallengeView:_clearFmt(fmt)
	for posId = 1, 9 do
		local go = fmt.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.clearIcon(con)
	end
end

function MagicSchoolChallengeView:_updateCell(view, cell, data)
	local fmtView = goutil.findChild(cell, "stageFmt/fmt")
	local btnChallenge = goutil.findChild(cell, "btnChallenge")
	local tableview = goutil.findChild(cell, "tableview")
	local tablecell = goutil.findChild(cell, "tableview/tablecell")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtTip = goutil.findChildTextComponent(cell, "tip/txtTip")
	local creepMasterId = data.creepsMasterId
	local creepMasterCfg = MagicSchoolConfig.instance:getCreepsCfgs(creepMasterId)
	local prizeCfg = MagicSchoolConfig.instance:getPrizeCfg(self._activityId)
	local prizeArr = string.split(data.stagePrize, "#")

	if self._rewardScrollListMap[cell] == nil then
		self._rewardScrollListMap[cell] = ScrollerList.create(tableview, tablecell, GameUtil.handler(self._updateCellReward, self), GameUtil.handler(self._clearCellReward, self))
	end

	local prizeList = {}

	for i, prize in ipairs(prizeArr) do
		local prizeData = {}

		prizeData.stageId = data.stageId
		prizeData.prize = prize

		table.insert(prizeList, prizeData)
	end

	txtName.text = data.name
	txtTip.text = data.passTip

	local scrollList = self._rewardScrollListMap[cell]

	scrollList:reloadData(prizeList)
	scrollList:setCenterMode(true)
	self:_setFmt(fmtView, creepMasterCfg)
	GameUtil.addClickHandler(btnChallenge, GameUtil.handler(self._onClickBtnChallenge, self, data.stageId))
end

function MagicSchoolChallengeView:_clearCell(cell)
	local fmtView = goutil.findChild(cell, "stageFmt/fmt")
	local btnChallenge = goutil.findChild(cell, "btnChallenge")
	local scrollList = self._rewardScrollListMap[cell]

	if scrollList then
		scrollList:dispose()

		self._rewardScrollListMap[cell] = nil
	end

	GameUtil.rmClickHandler(btnChallenge)
	self:_clearFmt(fmtView)
end

function MagicSchoolChallengeView:_updateCellReward(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local passedStageId = checknumber(self._info.passedStageId)

	MaterialMgr.setCellByCfg(data.prize, item)
	GameUtil.SetActive(geted, passedStageId >= data.stageId)
end

function MagicSchoolChallengeView:_clearCellReward(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function MagicSchoolChallengeView:_onClickBtnBuff()
	UIStateManager.instance:push(ViewName.MagicSchoolChooseBuffView, self._activityId, self._campId)
end

function MagicSchoolChallengeView:_onClickBtnLevel()
	UIStateManager.instance:push(ViewName.MagicSchoolLevelRewardView, self._activityId)
end

function MagicSchoolChallengeView:_onClickBtnChallenge(stageId)
	local curStageId = checknumber(self._info.passedStageId) + 1
	local stageNum = #self._stageCfgs

	curStageId = math.min(curStageId, stageNum)

	if curStageId < stageId then
		FloatWordMgr.instance:show("请先完成之前关卡挑战")

		return
	end

	MagicSchoolController.instance:enterBattleClg(self._activityId, self._campId, stageId)
end

return MagicSchoolChallengeView
