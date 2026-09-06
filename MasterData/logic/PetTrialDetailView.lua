-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettrial/view/PetTrialDetailView.lua

module("logic.extensions.pettrial.view.PetTrialDetailView", package.seeall)

local PetTrialDetailView = class("PetTrialDetailView", TableViewComponent)

function PetTrialDetailView:_getPath()
	return {
		cellPath = "main/prize/tablecell",
		viewPath = "main/prize/tableview"
	}
end

function PetTrialDetailView:_updateCell(view, cell, data)
	local node = goutil.findChild(cell.gameObject, "node")

	MaterialMgr.setCellByCfg(data, node)
end

function PetTrialDetailView:ctor()
	PetTrialDetailView.super.ctor(self)
end

function PetTrialDetailView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
end

function PetTrialDetailView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnStart:RemoveClickListener()
end

function PetTrialDetailView:buildUI()
	PetTrialDetailView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")

	local main = self:getGo("main")

	self._txtTitle = goutil.findChildTextComponent(main, "txtTitle")
	self._txtDesc = goutil.findChildTextComponent(main, "txtDesc")
	self._btnStart = self:getBtn("main/btnStart")
	self._txtCost = goutil.findChildTextComponent(main, "txtCost")
	self._rules = ItemGroup.New(self:getGo("main/rule/rules"))
	self._txtRecmdPower = goutil.findChildTextComponent(main, "fightpower/txtRecmdPower")
end

function PetTrialDetailView:onEnter()
	local data = self:getFirstParam()

	self._txtTitle.text = data.name
	self._txtDesc.text = ""

	local strengthCost = checknumber(data.strengthCost)

	self._txtCost.text = "消耗：" .. strengthCost

	goutil.setActive(self._txtCost.gameObject, strengthCost > 0)

	local t = {}

	if not string.nilorempty(data.description) then
		t = string.split(data.description, "\n")
	end

	self._rules:updateWithLen(#t, function(item, i)
		local txtRule = item.mainGO:GetComponent("Text")

		txtRule.text = t[i]
	end)

	self._curViewDatas = string.split(data.prize, "#")

	self:reloadData()

	local curStage = PetTrialModel.instance:getCurStage()
	local pos = GameUtil.getLocalPos(self._tableview)
	local isActiveAndChangePos = data.stageId == curStage + 1

	goutil.setActive(self._btnStart.gameObject, isActiveAndChangePos)
	GameUtil.setLocalPos(self._tableview, pos.x, isActiveAndChangePos and -90 or -120, pos.z)

	self._txtRecmdPower.text = checknumber(data.recommendZdl)

	if checknumber(data.recommendZdl) == 0 then
		local cCfgs = PetTrialConfig.instance:getCreepCfgByStageId(data.stageId)
		local levelCfg = PetTrialConfig.instance:getStageCfgById(data.stageId)

		self._txtRecmdPower.text = FightingPowerFormula.instance:getFightingPowerOfFmt(cCfgs, (levelCfg or nil) and checknumber(levelCfg.heroSkillId))
	end
end

function PetTrialDetailView:_initPrizeItems(maxNum, t, parent)
	for i = 1, maxNum do
		local go = goutil.cloneAndSetParent(self._prizeCell, parent.transform, tostring(i))
		local item = {}

		item.mainGO = go
		item.point = goutil.findChild(go, "point")

		table.insert(t, item)
		goutil.setActive(go, false)
	end
end

function PetTrialDetailView:destroyUI()
	return
end

function PetTrialDetailView:_updateView()
	PetTrialController.instance:unregisterLocalNotify("GetMyTrialInfo", self._updateView, self)
	self._blurBg:Release()
	self._blurBg:Capture(self.mainGO)

	local curStageId = PetTrialModel.instance:getCurStageId()
	local curTeamId = PetTrialModel.instance:getCurTeamId()

	self._stageId = checknumber(self:getFirstParam())

	local finishTeamId = PetTrialModel.instance:getFinishTeamId(self._stageId)
	local t = PetTrialConfig.instance:getTeamCfgs(self._stageId)

	self._teamId = math.min(finishTeamId + 1, #t)
	self._stageCfg = PetTrialConfig.instance:getStageCfgById(self._stageId)
	self._teamCfg = PetTrialConfig.instance:getTeamCfgByKeys(self._stageId, self._teamId)
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._stageCfg.petId, self._petContainer, 1, nil, false)
	self._txtName.text = self._stageCfg.name
	self._txtDegree.text = degreeText[self._stageCfg.degree]
	self._txtPeriod.text = string.format("%s/%s", self._teamId, #t)
	self._txtDes.text = self._stageCfg.description
	self._txtFightPower.text = self._stageCfg.fightPower

	self:_updateStars(finishTeamId, #t)

	self._txtStart.text = PetTrialModel.instance:getIsClearAll(self._stageId) and "扫 荡" or "前往挑战"

	self:_updatePrizes(self._normalPrizes, self._stageCfg.gift, true)
	self:_updatePrizes(self._sweepPrizes, self._stageCfg.sweepGift)
end

function PetTrialDetailView:_updatePrizes(t, itemStr, isFirst)
	local mats = string.split(itemStr, "#")
	local matsLen = #mats

	for i = 1, #t do
		goutil.setActive(t[i].mainGO, i <= matsLen)

		if i <= matsLen then
			MaterialMgr.setCellByCfg(mats[i], t[i].point)
			goutil.setActive(t[i].goReceived, isFirst and PetTrialModel.instance:getIsClearAll(self._stageId))

			local x = (i - matsLen / 2 - 0.5) * 100

			Framework.TransformUtil.SetLocalPos(t[i].mainGO.transform, x, 0, 0)
		end
	end
end

function PetTrialDetailView:_updateStars(a, b)
	self._starEffs = {}

	for i = 1, 10 do
		local x = (i - 1) % 5
		local y = math.floor((i - 1) / 5)

		goutil.setActive(self._stars[i].gameObject, i <= b)
		self._stars[i]:SetState(i <= a and 1 or 0)
		Framework.TransformUtil.SetLocalPos(self._stars[i].transform, 57 * (x + y * 0.5), -y * 46, 0)

		if i <= a then
			local eff = UIEffectManager.instance:playHUDEffect("fx_ui_jinglingshilian/fx_ui_jinglingshilian_saoguang_01.prefab", self._stars[i].gameObject, true, nil, nil, function(finishHandlerTarget, eff)
				GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(self._stars[i].gameObject) + 1)

				eff.effGo.transform.localScale = Vector3.one
			end, nil, false)

			table.insert(self._starEffs, eff)
		end
	end

	Framework.TransformUtil.SetLocalPos(self._starContainer.transform, -449.7, b > 5 and -148 or -176, 0)
end

function PetTrialDetailView:onEnterFinished()
	return
end

function PetTrialDetailView:onExit()
	return
end

function PetTrialDetailView:onExitFinished()
	return
end

function PetTrialDetailView:_onClickClose()
	self:close()
end

function PetTrialDetailView:_onClickStart()
	self:close()
end

return PetTrialDetailView
