-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/mainhud/SeasonTeamsView.lua

module("logic.extensions.season.view.SeasonTeamsView", package.seeall)

local SeasonTeamsView = class("SeasonTeamsView", TableViewComponent)

function SeasonTeamsView:ctor()
	self._curViewDatas = {}
end

function SeasonTeamsView:buildUI()
	self._tableview = self:getGo("teamNode/teamsView/View/layout/item"):GetComponent("UITableviewForLua")
	self._tableCell = self:getGo("teamNode/teamCell")

	self._tableCell:SetActive(false)

	self._targetsView = self:getGo("teamNode/teamsView")
	self._btnHide = self:getBtn("teamNode/btnHide")
	self._targetFadeNode = self:getGo("teamNode/teamsView/View")

	self._btnHide:IngoreGlobalClickListener(true)
	self:registCallbacks()

	self._buffScrollercell = self:getGo("teamNode/teamCell/buffCell")
	self._buffsScrollListDic = {}
	self._tipBuffDesc = self:getGo("tipBuffDesc")
	self._txtTipBuffDesc = self:getTxt("tipBuffDesc/txtDesc")

	if self._tipBuffDesc then
		self._tipBuffDescTipCustomInput = UICustomInput.Get(self._tipBuffDesc)
	end
end

function SeasonTeamsView:bindEvents()
	SeasonTeamsView.super.bindEvents(self)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish)
	self._btnHide:AddClickListener(self._onClickHideTargets, self)

	if self._tipBuffDescTipCustomInput then
		self._tipBuffDescTipCustomInput:AddListener(self._ontipBuffDescTipInputChanged, self)
	end
end

function SeasonTeamsView:unbindEvents()
	self._btnHide:RemoveClickListener()
	SeasonTeamsView.super.unbindEvents(self)

	if self._tipBuffDescTipCustomInput then
		self._tipBuffDescTipCustomInput:RemoveListener()
	end
end

function SeasonTeamsView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.SeasonPVEDataUpdated, self._reloadTeams, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonServerAddTeam, self._reloadTeams, self)
	GlobalDispatcher:addListener(GlobalNotify.ChangeFocusTeam, self._reloadTeams, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonStrengInfoUpdate, self._reloadTeams, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtTeamInfo, self._reloadTeams, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonLockTeamStateUpdated, self._reloadTeams, self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonGetMapBuffInfo, self._reloadTeams, self)
	self:_reloadTeams()
	SeasonController.instance:sendGetAllTeamInfo()
	SeasonModePvePlusAgent.instance:sendPM_SMPVEGetMapBuffInfoReq()
end

function SeasonTeamsView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.SeasonPVEDataUpdated, self._reloadTeams, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonServerAddTeam, self._reloadTeams, self)
	GlobalDispatcher:removeListener(GlobalNotify.ChangeFocusTeam, self._reloadTeams, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonStrengInfoUpdate, self._reloadTeams, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtTeamInfo, self._reloadTeams, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonLockTeamStateUpdated, self._reloadTeams, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonGetMapBuffInfo, self._reloadTeams, self)

	self._curViewDatas = nil

	self._tableview:Travel(self._clearTableview, self)
	SeasonTeamsView.super.onExit(self)
end

function SeasonTeamsView:_reloadTeams()
	GameUtil.SetActive(self._tipBuffDesc, false)

	local list = {}
	local seasonId = SeasonModel.instance:getSeasonId()
	local tgCfg = SeasonMainCampConfig.instance:getTrainingGroundConfig(seasonId)

	if tgCfg then
		local teamPlanId = tgCfg.teamPlanId
		local teamCfg = SeasonMainCampConfig.instance:getTeamConfigList(teamPlanId)

		for k, v in pairs(teamCfg) do
			table.insert(list, v)
		end
	end

	self._curViewDatas = list

	self._tableview:SetOffsetWithoutRefresh(0)
	self._tableview:ReloadData()
end

function SeasonTeamsView:_onClickHideTargets()
	self._isTargetsHided = not self._isTargetsHided

	if self._isTargetsHided then
		local x, y, z = Framework.TransformUtil.GetLocalPos(self._targetsView.transform, 0, 0, 0)

		self._targetsView.transform:DOLocalMoveX(x - 245, 0.3, false)
		self._btnHide.transform:DOLocalRotate(Vector3.New(0, 0, 180), 0.3, DG.Tweening.RotateMode.Fast)

		local tween = UnityTweens.UITweenFadeTo.StartTween(self._targetFadeNode, 0, 0.3, UnityTweens.EaseType.easeOutSine)

		tween:AddListener(function()
			self._targetFadeNode:SetActive(false)
		end, nil)
	else
		local x, y, z = Framework.TransformUtil.GetLocalPos(self._targetsView.transform, 0, 0, 0)

		self._targetsView.transform:DOLocalMoveX(x + 245, 0.3, false)
		self._btnHide.transform:DOLocalRotate(Vector3.New(0, 0, 0), 0.1, DG.Tweening.RotateMode.Fast)

		local tween = UnityTweens.UITweenFadeTo.StartTween(self._targetFadeNode, 1, 0.3, UnityTweens.EaseType.easeOutSine)

		tween:RemoveListener()
		self._targetFadeNode:SetActive(true)
	end

	GlobalDispatcher:dispatch(GlobalNotify.SpreadButton, not self._isTargetsHided)
end

function SeasonTeamsView:_clearTableview(cell)
	Framework.ButtonAdapter.GetFrom(cell.gameObject, "team/bg"):RemoveClickListener()

	local icon = goutil.findChild(cell.gameObject, "team/bg/icon")

	uGuiUtil.clearImage(icon)

	local buffScrollList = self._buffsScrollListDic[cell.gameObject]

	if buffScrollList then
		buffScrollList:dispose()

		self._buffsScrollListDic[cell.gameObject] = nil
	end
end

function SeasonTeamsView:_numInView()
	return #self._curViewDatas
end

function SeasonTeamsView:_cellSize(view, idx)
	return 272, 79
end

function SeasonTeamsView:_updateCell(view, cell, cfg)
	local iconObj = goutil.findChild(cell.gameObject, "team/bg/icon")
	local bg = goutil.findChild(cell.gameObject, "team/bg")
	local teamStrength = goutil.findChildTextComponent(cell.gameObject, "team/bg/teamStrength")
	local teamZdl = goutil.findChildTextComponent(cell.gameObject, "team/bg/teamZdl")
	local txtNumber = goutil.findChildTextComponent(cell.gameObject, "team/bg/number/txtNumber")
	local btnTired = goutil.findChild(cell.gameObject, "team/bg/btnTired")
	local btnAnim = goutil.findChild(cell.gameObject, "team/bg/btnAnim")
	local selected = goutil.findChild(cell.gameObject, "team/bg/selected")
	local lock = goutil.findChild(cell.gameObject, "team/lock")
	local txtNumber2 = goutil.findChildTextComponent(cell.gameObject, "team/lock/number/txtNumber")
	local txtLockTip = goutil.findChildTextComponent(cell.gameObject, "team/lock/txtLockTip")
	local txtTeamLv = goutil.findChildTextComponent(cell.gameObject, "team/bg/txtTeamLv")
	local buffScrollerview = goutil.findChild(cell.gameObject, "buffsScrollerview")

	GameUtil.SetActive(bg, false)
	GameUtil.SetActive(lock, false)
	GameUtil.SetActive(btnTired, false)
	GameUtil.SetActive(btnAnim, false)

	txtNumber.text = cfg.teamId
	txtNumber2.text = cfg.teamId
	txtTeamLv.text = ""

	local data = SeasonTeamsModel.instance:getTeam(cfg.teamId)

	if data then
		GameUtil.SetActive(bg, true)

		local modelCo = CharacterConfig.instance:getModelCo(checknumber(data.leaderSkinId))

		if modelCo then
			uGuiUtil.setSpriteToImage(iconObj.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
		end

		local seasonId = SeasonModel.instance:getSeasonId()
		local mainLevel = SeasonMainCampModel.instance:getCampLv()
		local cfg = SeasonConfig.instance:getSeasonEnergyCfg(seasonId, mainLevel)

		teamStrength.text = data.teamStrength .. "/" .. checknumber(cfg.recoveryLimit)
		teamZdl.text = data.teamZdl
		txtTeamLv.text = langPara("小队等级：%s", data.teamLv)

		local isTired = data:isServerLocked()

		if isTired then
			GameUtil.SetActive(btnTired, true)
		else
			GameUtil.SetActive(btnAnim, SeasonTeamsModel.instance:getCurrTeamId() == data.teamId)
		end

		GameUtil.addClickHandler(btnTired, GameUtil.handler(self.onClickTired, self, data))
		GameUtil.addClickHandler(btnAnim, GameUtil.handler(self.onClickAnim, self, data))
		Framework.ButtonAdapter.Get(bg):RemoveClickListener()
		Framework.ButtonAdapter.Get(bg):AddClickListener(function()
			SeasonController.instance:changeFocusTeam(data.teamId)
			ViewMgr.instance:close(ViewName.SeasonSceneOperateView)
			self._tableview:Refresh()
		end)
		selected:SetActive(SeasonTeamsModel.instance:getCurrTeamId() == data.teamId)

		if buffScrollerview and self._buffScrollercell then
			local buffs = SeasonModel.instance:getMapBuffInfoByTeam(data.teamId)

			if not self._buffsScrollListDic[cell.gameObject] then
				local buffScrollList = ScrollerList.create(buffScrollerview, self._buffScrollercell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))

				self._buffsScrollListDic[cell.gameObject] = self._buffsScrollListDic[cell.gameObject]

				self._buffsScrollListDic[cell.gameObject]:reloadData(buffs)
			end
		end
	else
		GameUtil.SetActive(lock, true)

		txtLockTip.text = cfg.lockTips

		GameUtil.addClickHandler(lock, function()
			TipsFacade.instance:openCommonTips(cfg.lockTips)
		end)
	end
end

function SeasonTeamsView:onClickTired(teamMo)
	TipsFacade.instance:openSeasonPopupWindow(lang("tip"), lang("精灵小队击败分身后，正处于疲劳状态，是否需要重置挑战进行阵容调整？"), function()
		if teamMo then
			SeasonPVEBossController.instance:sendDoppelgangerResetTeam(teamMo.teamId)
		end
	end)
end

function SeasonTeamsView:onClickAnim(teamMo)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.gridUnitsMgr then
		if scene.gridUnitsMgr:isAimmingGrid() then
			scene.gridUnitsMgr:aimGrid(false)
		else
			scene.gridUnitsMgr:aimGrid(true)
		end
	end
end

function SeasonTeamsView:_updateBuffCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgCon = goutil.findChild(go, "imgCon")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local btnInfo = GameUtil.asBtn(goutil.findChild(go, "btnInfo"))

	GameUtil.SetActive(go, true)

	txtNum.text = txtNum and data.num > 0 and data.num or ""

	local seasonId = SeasonModel.instance:getSeasonId()
	local cfg = SeasonConfig.instance:getMapBuffCfg(seasonId, data.buffId)

	if imgCon then
		uGuiUtil.setSpriteToImage(imgCon, nil, GameUrl.getExpEventUrl(cfg.icon))
	end

	if btnInfo and self._tipBuffDesc then
		btnInfo:AddClickListener(function()
			self._txtTipBuffDesc.text = data.num > 0 and langPara(cfg.desc, data.num) or lang(cfg.desc)

			GameUtil.SetActive(self._tipBuffDesc, true)

			local pos = GameUtil.getPos(go)

			GameUtil.setPos(self._tipBuffDesc, pos.x, pos.y, pos.z)
		end)
	end
end

function SeasonTeamsView:_clearBuffCell(cell)
	local go = cell.gameObject
	local imgCon = goutil.findChild(go, "imgCon")
	local btnInfo = GameUtil.asBtn(goutil.findChild(go, "btnInfo"))

	if imgCon then
		uGuiUtil.clearImage(imgCon)
	end

	if btnInfo then
		btnInfo:RemoveClickListener()
	end
end

function SeasonTeamsView:_ontipBuffDescTipInputChanged(hover)
	if isHover == false then
		GameUtil.SetActive(self._tipBuffDesc, false)
	end
end

return SeasonTeamsView
