-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/judgesystem/RogueMonsterSettlementView.lua

module("logic.extensions.roguelike.view.judgesystem.RogueMonsterSettlementView", package.seeall)

local M = class("RogueMonsterSettlementView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._cardItems = {}
end

function M:buildUI()
	self._btnClose = self:getBtn("1&empty_mask_tips_29887572")
	self._btnHint = self:getBtn("3&btn_explain_-1936547904")
	self._goType1 = self:getGo("run_group_battle_view_839871384")
	self._goType2 = self:getGo("run_group_battle_view_1219704795")

	goutil.setActive(self._goType1, false)
	goutil.setActive(self._goType2, true)

	self._imgMonsterIcon = self:getImage("run_group_battle_view_514269694")
	self._imgMonsterIcon2 = self:getImage("run_group_battle_view_1072856343")
	self._imgHead = self:getImage("run_group_battle_view_129952241")
	self._imgHead2 = self:getImage("run_group_battle_view_1912469432")
	self._txtMonsterName = self:getText("run_group_battle_view_1084974166")
	self._txtMonsterDesc = self:getText("run_group_battle_view_-1956682578")
	self._txtDesc = self:getText("run_group_battle_view_1601699128")
	self._txtSettlement = self:getText("run_group_battle_view_1749194902")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._passEvent = self._btnClose.gameObject:GetComponent(ComponentType.PassEvent)

	if self._passEvent then
		self._passEvent.isPassEvent = false
	end

	self.mainGO.name = "run_group_monster_settlement"

	goutil.setActive(self._btnHint.gameObject, false)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnHint:AddClickListener(self._onClickHint, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnHint:RemoveClickListener()
end

function M:_onClickHint()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		CommEnum.ManualKey.RogueMeetMonster
	})
end

function M:onEnter()
	if RogueMgr.instance:getRogueFlow() then
		RogueMgr.instance:getRogueFlow().diceMgr:recoveryAllDiceObj()
	end

	self:showMonsterInfo()
	self:showChangeAnimation()

	self._canTouch = false
end

function M:showMonsterInfo()
	if not RogueMgr.instance:getModel() then
		self:close()

		return
	end

	local monsterId = RogueMgr.instance:getModel():getMeetMonsterId()
	local isWin = RogueMgr.instance:getModel():getJudgeResult()

	self._isWin = isWin

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open2")

	local monsterCo = RoguelikeConfig.instance:getRoguelikeMonsterById(monsterId)
	local co = monsterCo

	self._monsterCo = monsterCo

	IconLoader.setSprite(self._imgMonsterIcon, IconType.RunGroup, string.format("rungroup_monster/%s", co.staticRes), self._monsterImgLoadCallback, self)
	IconLoader.setSprite(self._imgMonsterIcon2, IconType.RunGroup, string.format("rungroup_monster/%s", co.staticRes), self._monsterImgLoadCallback, self)
	IconLoader.setSprite(self._imgHead, IconType.RunGroup, string.format("rungoup_monster_head/%s", co.head), self._monsterImgLoadCallback, self)
	IconLoader.setSprite(self._imgHead2, IconType.RunGroup, string.format("rungoup_monster_head/%s", co.head), self._monsterImgLoadCallback, self)

	self._txtMonsterName.text = monsterCo.name
	self._txtMonsterDesc.text = monsterCo.desc

	if isWin then
		self._txtDesc.text = monsterCo.successDesc

		local str = ""

		for i, effectId in ipairs(monsterCo.successEffectId or {}) do
			if i ~= 1 then
				str = str .. ","
			end

			local successEffectCo = RoguelikeConfig.instance:getEffectById(effectId)

			str = string.format("%s%s", str, successEffectCo.description)
		end

		self._txtSettlement.text = StringUtil.replaceAllGraphicText2(str)
	else
		self._txtDesc.text = monsterCo.failDesc

		local str = lang("tip_r_judge_fail")

		self._txtSettlement.text = StringUtil.replaceAllGraphicText2(str)
	end

	if RoguelikeController.instance:getIsAllDeath() then
		self._txtSettlement.text = lang("tip_r_role_die_quit")
	end
end

function M:_monsterImgLoadCallback()
	self._imgMonsterIcon:SetNativeSize()
	self._imgMonsterIcon2:SetNativeSize()
end

function M:showChangeAnimation()
	goutil.setActive(self._goPainting, true)
	goutil.setActive(self._goRoleParent, false)
end

function M:updateRoleInfos()
	for i = 0, self._traCardParent.childCount - 1 do
		goutil.setActive(self._traCardParent:GetChild(i).gameObject, false)
	end

	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()

	for i = 1, #allRoles do
		local item = self._cardItems[i]

		if not item then
			local go = Astral.GameObjectUtil.CloneAndSetParent(self._goRoleCardItem, self._traCardParent, nil)

			item = Astral.LuaComponentContainer.Add(go, RogueRoleSpineItem)
			self._cardItems[i] = item
		end

		local data = {}
		local index = i

		data.roleId = allRoles[i].roleProp:getRoleId()

		function data.callback()
			return
		end

		item:updateData(data)
	end
end

function M:_onChangeToRoleCards()
	goutil.setActive(self._goPainting, false)
	goutil.setActive(self._goRoleParent, true)

	self._canTouch = true
end

function M:onExit()
	removetimer(self._onChangeToRoleCards, self)
	RoguelikeController.instance:exitSettlementView()

	if not RogueMgr.instance:getRogueFlow() then
		return
	end

	RogueMgr.instance:getRogueFlow().model:setInSettlement(false)
	RogueMgr.instance:getRogueFlow().judgeMgr:saveEmptyJudgeArchive(0)
	RoguelikeController.instance:checkNeedQuit()

	if RogueMgr.instance:getHackToolModel() then
		return
	end
end

function M:_onClickClose()
	if self._monsterCo and self._isWin then
		local effectId = self._monsterCo.successEffectId

		RoguelikeController.instance:execEffectIds(effectId, function()
			RogueMgr.instance:getModel():setCurReplyCo(nil)
		end)
	end

	self:close()
end

return M
