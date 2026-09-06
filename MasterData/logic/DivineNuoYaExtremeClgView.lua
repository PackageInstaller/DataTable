-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/view/DivineNuoYaExtremeClgView.lua

module("logic.extensions.divinenuoyachallenge.view.DivineNuoYaExtremeClgView", package.seeall)

local DivineNuoYaExtremeClgView = class("DivineNuoYaExtremeClgView", ViewComponent)

function DivineNuoYaExtremeClgView:buildUI()
	DivineNuoYaExtremeClgView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnReset = self:getBtn("btnReset")
	self._btnLook = self:getBtn("btnLook")
	self._txtTitle = self:getTxt("txtTitle")
	self._con = self:getGo("con")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._powerPetMo = FightingPowerPetMo.New()
end

function DivineNuoYaExtremeClgView:bindEvents()
	DivineNuoYaExtremeClgView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnLook:AddClickListener(self._onClickLook, self)
end

function DivineNuoYaExtremeClgView:unbindEvents()
	DivineNuoYaExtremeClgView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnLook:RemoveClickListener()
end

function DivineNuoYaExtremeClgView:onEnter()
	DivineNuoYaExtremeClgView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DivineNuoYaExtremeClgResetStageRes, self._onResetStageRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stageId = params[2]

	local cfgStage = DivineNuoYaChallengeConfig.instance:getExtremeStage(self._activityId, self._stageId)

	self._txtTitle.text = cfgStage and cfgStage.name or ""

	local passNum = DivineNuoYaChallengeModel.instance:getExtremeSmallStageProgress()
	local monsterId = passNum + 1
	local cfg = DivineNuoYaChallengeConfig.instance:getMonster(self._activityId, self._stageId, monsterId)

	if cfg then
		local cfgCreeps = DivineNuoYaChallengeConfig.instance:getCreeps(cfg.creepsMasterId)

		if cfgCreeps and cfgCreeps[1] then
			self._raceId = cfgCreeps[1].raceId

			self:_showRoleModel()
		end
	end

	self:_refreshView()
end

function DivineNuoYaExtremeClgView:onExit()
	DivineNuoYaExtremeClgView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DivineNuoYaExtremeClgResetStageRes, self._onResetStageRes, self)
	self._scrollList:dispose()
	self:_resetRoleModel()
end

function DivineNuoYaExtremeClgView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "divinenuoyaextremeclgview_rule")
end

function DivineNuoYaExtremeClgView:_onClickReset()
	local isPassAll = DivineNuoYaChallengeModel.instance:isPassExtremeClgStageProgress(self._activityId)

	if isPassAll then
		return
	end

	local isSelectedPet = DivineNuoYaChallengeModel.instance:isExtremeSelectedPet()

	if not isSelectedPet then
		FloatWordMgr.instance:show("请先选择精灵进入挑战")

		return
	end

	local text = "即将重置此关卡的进度，并重新选择精灵"

	local function okFunc()
		DivineNuoYaChallengeAgent.instance:sendPM_DivineNuoYaExtremeClgResetStageReq(self._activityId)
		self:close()
	end

	local alignment = UnityEngine.TextAnchor.MiddleCenter

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc, cencelFunc, okFuncText, cancelFuncText, alignment)
end

function DivineNuoYaExtremeClgView:_onClickLook()
	UIStateManager.instance:push(ViewName.DivineNuoYaSelectView, self._activityId, self._stageId, DivineNuoYaChallengeModel.LookOverPet)
end

function DivineNuoYaExtremeClgView:_onResetStageRes()
	self:_refreshView()
	UIStateManager.instance:push(ViewName.DivineNuoYaTipView, self._activityId, DivineNuoYaChallengeModel.ResetPet)
end

function DivineNuoYaExtremeClgView:_refreshView()
	local cfgs = DivineNuoYaChallengeConfig.instance:getMonsterList(self._activityId, self._stageId)

	self._scrollList:reloadData(cfgs)
end

function DivineNuoYaExtremeClgView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local lock = goutil.findChild(cell, "lock")
	local pass = goutil.findChild(cell, "pass")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local fmtList = {}

	for i = 1, 9 do
		local item = {}

		item.go = goutil.findChild(cell, string.format("fmt/cell_%d", i))
		item.con = goutil.findChild(cell, string.format("fmt/cell_%d/con", i))

		table.insert(fmtList, item)
	end

	for i, v in ipairs(fmtList) do
		MaterialMgr.resetAll(v.con)
		goutil.setActive(v.go, false)
	end

	local cfgCreeps = DivineNuoYaChallengeConfig.instance:getCreeps(data.creepsMasterId)

	for i, cfgEnemy in ipairs(cfgCreeps) do
		local item = fmtList[cfgEnemy.posId]

		if item.go then
			goutil.setActive(item.go, true)
			GameUtil.setLocalScale(item.con, 0.7, 0.7, 0.7)
			self._powerPetMo:fromChallengeCreepCo(cfgEnemy)

			local bagPetMo = self._powerPetMo:toBaseBagPetMo()
			local proxy = MaterialMgr.setCellByMo(bagPetMo, item.con)

			proxy.binder:setAutoTips(false)
			proxy:setCallBack(function()
				CommonTipsMgr.instance:showPetTips(bagPetMo)
			end)
		end
	end

	local cfgMaster = DivineNuoYaChallengeConfig.instance:getMaster(data.creepsMasterId)

	txtName.text = cfgMaster.name
	txtDesc.text = data.desc or ""

	local passNum = DivineNuoYaChallengeModel.instance:getExtremeSmallStageProgress()
	local isPass = passNum >= data.monsterId
	local isLock = data.monsterId > passNum + 1

	goutil.setActive(lock, isLock)
	goutil.setActive(pass, isPass)
	goutil.setActive(btnClick.gameObject, not isPass and not isLock)
	btnClick:AddClickListener(function()
		if not isPass and not isLock then
			DivineNuoYaChallengeController.instance:openExtremeMissionView(self._activityId, self._stageId, data.monsterId)
		end
	end)
end

function DivineNuoYaExtremeClgView:_clearCell(cell)
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")

	btnClick:RemoveClickListener()

	for i = 1, 9 do
		local go = goutil.findChild(cell, string.format("fmt/cell_%d", i))
		local con = goutil.findChild(cell, string.format("fmt/cell_%d/con", i))

		MaterialMgr.resetAll(con)
		goutil.setActive(go, false)
	end
end

function DivineNuoYaExtremeClgView:_showRoleModel()
	local curFaceId = self._raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._con, scale, nil, true, x, y)
end

function DivineNuoYaExtremeClgView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

return DivineNuoYaExtremeClgView
