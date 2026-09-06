-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapterMultMainView.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapterMultMainView", package.seeall)

local DreamTeamChapterMultMainView = class("DreamTeamChapterMultMainView", ViewComponent)

function DreamTeamChapterMultMainView:ctor()
	DreamTeamChapterMultMainView.super.ctor(self)
end

function DreamTeamChapterMultMainView:unbindEvents()
	DreamTeamChapterMultMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
end

function DreamTeamChapterMultMainView:bindEvents()
	DreamTeamChapterMultMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onBtnIntroduceClg, self)
end

function DreamTeamChapterMultMainView:buildUI()
	DreamTeamChapterMultMainView.super.buildUI(self)

	self._con = self:getGo("con")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._petInfo = self:getGo("petInfo")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtName = self:getTxt("petInfo/txtName")
	self._txtTip = self:getTxt("tip/txtTip")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DreamTeamChapterMultMainView:onExit()
	DreamTeamChapterMultMainView.super.onExit(self)
	MaterialMgr.resetAll(self._role)
	self._scrollList:dispose()

	for k, scroll in pairs(self._scrollMap) do
		scroll:dispose()
	end
end

function DreamTeamChapterMultMainView:onEnter()
	DreamTeamChapterMultMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 595001
	end

	self._mmId = checknumber(params[2])
	self._actCfg = DreamTeamChapterConfig.instance:getActivityCfg(self._activityId)
	self._awakeMMCfg = DreamTeamChapterConfig.instance:getAwakeMMCfgById(self._activityId, self._mmId)

	local challengeId = self._awakeMMCfg.challengeId
	local battleStageCfgs = DreamTeamChapterConfig.instance:getBattleStageCfgs(self._activityId, challengeId)
	local challengeInfoMap = DreamTeamChapterModel.instance:getChallengeInfoMap(self._activityId) or {}

	self._challengeInfo = checktable(challengeInfoMap[challengeId])
	self._scrollMap = {}

	self:_onSetUI()
	self._scrollList:reloadData(battleStageCfgs)

	local mmKey = ""

	if self._mmId == DreamTeamChapterController.awakeMMId.KingMM then
		mmKey = DreamTeamChapterController.KING_MM_DAY_KEY
	elseif self._mmId == DreamTeamChapterController.awakeMMId.LoveMM then
		mmKey = DreamTeamChapterController.LOVE_MM_DAY_KEY
	elseif self._mmId == DreamTeamChapterController.awakeMMId.DarkMM then
		mmKey = DreamTeamChapterController.DARK_MM_DAY_KEY
	end

	local key = string.format(mmKey, self._activityId)

	GameUtil.saveUserDayData(key, true)
end

function DreamTeamChapterMultMainView:_onSetUI()
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

					if self._awakeMMCfg then
						self._txtTip.text = self._awakeMMCfg.tipStr or ""
					end

					if self._awakeMMCfg then
						self._txtTitle.text = self._awakeMMCfg.mmName or ""
					end

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

function DreamTeamChapterMultMainView:_getSkinId()
	return (self._awakeMMCfg or nil) and (self._awakeMMCfg.skinId or 0)
end

function DreamTeamChapterMultMainView:_updateCell(view, cell, data)
	local btnClg = goutil.findChild(cell, "btnClg")
	local tableviewReward = goutil.findChild(cell, "tableviewReward")
	local tablecellReward = goutil.findChild(cell, "tablecellReward")
	local txtStage = goutil.findChildTextComponent(cell, "stage/txtStage")
	local txtBtnClg = goutil.findChildTextComponent(cell, "btnClg/txt")

	self._scrollMap[cell] = self._scrollMap[cell] or ScrollerList.create(tableviewReward, tablecellReward, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))

	local scroll = self._scrollMap[cell]
	local passStageIdList = checktable(self._challengeInfo.passStageId)
	local prizeList = string.split(data.prize, "#")
	local canNotFight = data.stageId > #passStageIdList + 1
	local hasPass = table.indexof(passStageIdList, data.stageId)

	txtStage.text = string.format(lang("第<size=48>%s</size>关"), data.stageId)
	txtBtnClg.text = lang("挑战")

	if hasPass then
		txtBtnClg.text = lang("挑战成功")
	end

	scroll:reloadData(prizeList)
	GameUtil.addClickHandler(btnClg, function()
		if data.challengeId ~= DreamTeamChapterController.battleTypeEnum.KingMM and canNotFight then
			FloatWordMgr.instance:show(lang("请先通过前置关卡"))

			return
		end

		DreamTeamChapterController.instance:enterMultMMBattleClg(self._activityId, data.challengeId, data.stageId)
	end, self)
end

function DreamTeamChapterMultMainView:_clearCell(cell)
	local btnClg = goutil.findChild(cell, "btnClg")
	local scroll = self._scrollMap[cell]

	if scroll then
		scroll:dispose()
	end

	GameUtil.rmClickHandler(btnClg)
end

function DreamTeamChapterMultMainView:_updateRewardCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function DreamTeamChapterMultMainView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell)
end

function DreamTeamChapterMultMainView:_onClickBtnTip()
	if self._actCfg then
		TipsFacade.instance:openRulesView(self._actCfg)
	end
end

function DreamTeamChapterMultMainView:_onBtnSkillClg()
	local skinId = self:_getSkinId()

	if skinId > 0 then
		PetbookController.instance:previewBattle(skinId)
	end
end

function DreamTeamChapterMultMainView:_onBtnIntroduceClg()
	local skinId = self:_getSkinId()

	if skinId > 0 then
		PetbookController.instance:openPetinfoView(skinId)
	end
end

return DreamTeamChapterMultMainView
