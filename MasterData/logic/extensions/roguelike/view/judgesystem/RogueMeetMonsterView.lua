-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/judgesystem/RogueMeetMonsterView.lua

module("logic.extensions.roguelike.view.judgesystem.RogueMeetMonsterView", package.seeall)

local M = class("RogueMeetMonsterView", ViewComponent)

function M:buildUI()
	self._btnFight = self:getBtn("run_group_battle_view_1906473080")
	self._btnHint = self:getBtn("3&btn_explain_-1936547904")
	self._imgMonsterIcon = self:getImage("run_group_battle_view_514269694")
	self._imgMonsterIcon2 = self:getImage("run_group_battle_view_1072856343")
	self._txtMonsterName = self:getText("run_group_battle_view_1084974166")
	self._txtMonsterDesc = self:getText("run_group_battle_view_-1956682578")
	self._txtDiff = self:getText("run_group_battle_view_341944733")
	self._txtCapacity = self:getText("run_group_battle_view_-309084848")
	self._txtDesc = self:getText("run_group_battle_view_-1625860201")
	self._txtSkillName = self:getText("run_group_battle_view_-80930823")
	self._txtSkillDesc = self:getText("run_group_battle_view_1797182967")
	self._traFeatures = self:getGo("run_group_battle_view_449110105").transform
	self._goFeaturesItem = self:getGo("run_group_battle_view_1360905062")
	self._goFItems = {}
	self._imgHead = self:getImage("run_group_battle_view_129952241")
	self._imgHead2 = self:getImage("run_group_battle_view_1912469432")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnFight:AddClickListener(self._onClickFight, self)
	self._btnHint:AddClickListener(self._onClickHint, self)
end

function M:unbindEvents()
	self._btnFight:RemoveClickListener()
	self._btnHint:RemoveClickListener()
end

function M:onEnter()
	RoguelikeAgent.instance:sendJudgeArchiveRequest(nil)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Dice)
	self:delayUpdateMonsterInfo()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open1")
end

function M:delayUpdateMonsterInfo()
	local monsterId = self:getFirstParam()

	self._monsterId = monsterId

	local monsterCo = RoguelikeConfig.instance:getRoguelikeMonsterById(monsterId)

	if monsterCo then
		self:updateInfoByCo(monsterCo)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_GUIDE_INFO, GuideEnum.GuideRoguelikeTriggerType.Monster, monsterId)
	else
		print("找不到怪物", monsterId)
	end
end

function M:updateInfoByCo(co)
	self._txtMonsterName.text = co.name
	self._txtMonsterDesc.text = co.desc
	self._txtDiff.text = co.fighting
	self._txtDesc.text = StringUtil.replaceAllGraphicText2(co.passiveDesc)
	self._txtCapacity.text = co.totalDice

	local effectIds = {}
	local tempEffect = ""

	for k, v in pairs(effectIds) do
		local effectCo = RoguelikeConfig.instance:getEffectById(v)

		tempEffect = tempEffect .. " " .. effectCo.description
	end

	self._txtSkillDesc.text = #effectIds == 0 and lang("tip_r_monster_not_atk") or StringUtil.replaceAllGraphicText2(tempEffect)

	IconLoader.setSprite(self._imgMonsterIcon, IconType.RunGroup, string.format("rungroup_monster/%s", co.staticRes), self._monsterImgLoadCallback, self)
	IconLoader.setSprite(self._imgMonsterIcon2, IconType.RunGroup, string.format("rungroup_monster/%s", co.staticRes), self._monsterImgLoadCallback, self)
	IconLoader.setSprite(self._imgHead, IconType.RunGroup, string.format("rungoup_monster_head/%s", co.head), self._monsterImgLoadCallback, self)
	IconLoader.setSprite(self._imgHead2, IconType.RunGroup, string.format("rungoup_monster_head/%s", co.head), self._monsterImgLoadCallback, self)

	for i = 0, self._traFeatures.childCount - 1 do
		goutil.setActive(self._traFeatures:GetChild(i).gameObject, false)
	end

	local features = co.features

	for i = 1, #features do
		local item = self._goFItems[i]

		item = item or Astral.GameObjectUtil.CloneAndSetParent(self._goFeaturesItem, self._traFeatures, nil)

		local icon = item.transform:Find("icon"):GetComponent("Image")
		local actionCo = RoguelikeConfig.instance:getMonsterActionById(features[i])

		IconLoader.setSprite(icon, IconType.DynSpriteAtlas_Dice, string.format("dice_%d", actionCo.icon))
		goutil.setActive(item, true)
	end
end

function M:onExit()
	return
end

function M:_monsterImgLoadCallback()
	self._imgMonsterIcon:SetNativeSize()
	self._imgMonsterIcon2:SetNativeSize()
end

function M:_onClickClose()
	self:close()
end

function M:_onClickFight()
	local result = RogueMgr.instance:getModel() and RogueMgr.instance:getModel():setFirstActiveRoleIndex() or 0

	if result ~= 0 then
		RogueMgr.instance:getModel():setCurMonsterId(self._monsterId)
		RoguelikeController.instance:enterRunGroupJudgeScene(function()
			RoguelikeController.instance:closeMapView()
			ViewMgr.instance:open(ViewName.RogueMonsterJudge, self._monsterId)
			RogueMgr.instance:getModel():setCurMonsterId(nil)
		end)
	end

	self:_onClickClose()
end

function M:_onClickHint()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		CommEnum.ManualKey.RogueMeetMonster
	})
end

function M:_refreshSpine(modelId)
	return
end

return M
