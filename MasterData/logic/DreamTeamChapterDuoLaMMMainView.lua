-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapterDuoLaMMMainView.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapterDuoLaMMMainView", package.seeall)

local DreamTeamChapterDuoLaMMMainView = class("DreamTeamChapterDuoLaMMMainView", ViewComponent)

function DreamTeamChapterDuoLaMMMainView:ctor()
	DreamTeamChapterDuoLaMMMainView.super.ctor(self)
end

function DreamTeamChapterDuoLaMMMainView:unbindEvents()
	DreamTeamChapterDuoLaMMMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function DreamTeamChapterDuoLaMMMainView:bindEvents()
	DreamTeamChapterDuoLaMMMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onBtnIntroduceClg, self)
end

function DreamTeamChapterDuoLaMMMainView:buildUI()
	DreamTeamChapterDuoLaMMMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._txtName = self:getTxt("petInfo/txtName")
	self._con = self:getGo("con")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DreamTeamChapterDuoLaMMMainView:onExit()
	DreamTeamChapterDuoLaMMMainView.super.onExit(self)
	self._scrollList:dispose()
	MaterialMgr.resetAll(self._role)

	for k, scroll in pairs(self._scrollMap) do
		scroll:dispose()
	end
end

function DreamTeamChapterDuoLaMMMainView:onEnter()
	DreamTeamChapterDuoLaMMMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_GearGameInfoRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 595001
	end

	self._mmId = checknumber(params[2])
	self._actCfg = DreamTeamChapterConfig.instance:getActivityCfg(self._activityId)
	self._awakeMMCfg = DreamTeamChapterConfig.instance:getAwakeMMCfgById(self._activityId, self._mmId)
	self._scrollMap = {}

	if self._actCfg then
		self._gearActId = self._actCfg.duolaMMActId or 604001
	end

	self:_onSetUI()
	GearGameController.instance:sendPM_GearGameInfoReq(self._gearActId)

	local key = string.format(DreamTeamChapterController.DUOLA_MM_DAY_KEY, self._activityId)

	GameUtil.saveUserDayData(key, true)
end

function DreamTeamChapterDuoLaMMMainView:_onSetUI()
	if self._awakeMMCfg then
		if not self._awakeMMCfg.posNScale then
			local posNScale = {}
			local x = checknumber(posNScale[1])
			local y = checknumber(posNScale[2])
			local scale = checknumber(posNScale[3])

			if self._txtOpenTime then
				self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
			end

			if self._awakeMMCfg then
				if not self._awakeMMCfg.skinId then
					local skinId = 0
					local petName
					local petData = CharacterConfig.instance:getPetCo(skinId)

					self._txtName.text = (petData or nil) and petData.name or ""

					GameUtil.setLocalPos(self._con, x, y, 1)
					GameUtil.setLocalScale(self._con, scale, scale, scale)

					self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

					if skinId > 0 then
						MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
					end
				end
			end
		end
	end
end

function DreamTeamChapterDuoLaMMMainView:_onUpdate()
	self._gearInfo = GearGameModel.instance:getInfo(self._gearActId)

	if self._gearInfo then
		self._passStage = self._gearInfo.passStage or {}
	end

	local stageCfgs = GearGameConfig.instance:getStageCfgs(self._gearActId)

	self._scrollList:reloadData(stageCfgs)
end

function DreamTeamChapterDuoLaMMMainView:_updateCell(view, cell, data)
	local btnClg = goutil.findChild(cell, "btnClg")
	local tableviewReward = goutil.findChild(cell, "tableviewReward")
	local tablecellReward = goutil.findChild(cell, "tableviewReward/tablecellReward")
	local txtStage = goutil.findChildTextComponent(cell, "stage/txtStage")
	local txtBtnClg = goutil.findChildTextComponent(cell, "btnClg/txt")
	local hasPass = table.indexof(self._passStage, data.stageId)

	self._scrollMap[cell] = self._scrollMap[cell] or ScrollerList.create(tableviewReward, tablecellReward, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))

	local scroll = self._scrollMap[cell]
	local prizeList = string.split(data.prize, "#")

	txtStage.text = string.format(lang("第<size=48>%s</size>关"), data.stageId)
	txtBtnClg.text = hasPass and lang("已通关") or lang("挑战")

	scroll:reloadData(prizeList)
	GameUtil.addClickHandler(btnClg, function()
		UIStateManager.instance:push(ViewName.GearGameGameView, self._gearActId, data.stageId)
	end, self)
end

function DreamTeamChapterDuoLaMMMainView:_clearCell(cell)
	local btnClg = goutil.findChild(cell, "btnClg")
	local scroll = self._scrollMap[cell]

	if scroll then
		scroll:dispose()
	end

	GameUtil.rmClickHandler(btnClg)
end

function DreamTeamChapterDuoLaMMMainView:_updateRewardCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function DreamTeamChapterDuoLaMMMainView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell)
end

function DreamTeamChapterDuoLaMMMainView:_onClickBtnTip()
	local ruleCfg = GearGameConfig.instance:getGameRuleCfgs(self._actCfg.ruleIdDuolaMM)
	local ruleList = {}

	for i, v in ipairs(ruleCfg) do
		local obj = {}

		obj.url = v.resPath
		obj.desc = v.desc

		table.insert(ruleList, obj)
	end

	TipsFacade.instance:openImageRuleView(ruleList, lang("游戏规则"), function()
		self._isPause = false
	end)
end

return DreamTeamChapterDuoLaMMMainView
