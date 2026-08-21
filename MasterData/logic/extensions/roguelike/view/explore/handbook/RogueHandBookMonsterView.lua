-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/handbook/RogueHandBookMonsterView.lua

module("logic.extensions.roguelike.view.explore.handbook.RogueHandBookMonsterView", package.seeall)

local M = class("RogueHandBookMonsterView", ViewComponent)

function M:buildUI()
	self._imgMonsterIcon = self:getImage("run_group_moster_tips_1431790172")
	self._txtMonsterName = self:getText("run_group_moster_tips_783714692")
	self._txtDiff = self:getText("run_group_moster_tips_68189599")
	self._txtCapacity = self:getText("run_group_moster_tips_1438135471")
	self._txtDesc = self:getText("run_group_moster_tips_-1639819856")
	self._txtSkillDesc = self:getText("run_group_moster_tips_2004313222")
	self._traFeatures = self:getGo("run_group_moster_tips_112021800").transform
	self._goFeaturesItem = self:getGo("run_group_moster_tips_1299477015")
	self._goFItems = {}
end

function M:destroyUI()
	return
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Dice)

	local monsterId = self:getFirstParam()

	self._monsterId = monsterId

	local monsterCo = RoguelikeConfig.instance:getRoguelikeMonsterById(monsterId)

	if monsterCo then
		self:updateInfoByCo(monsterCo)
	else
		print("找不到怪物", monsterId)
	end
end

function M:updateInfoByCo(co)
	self._txtMonsterName.text = co.name
	self._txtDiff.text = "x" .. co.fighting
	self._txtDesc.text = StringUtil.replaceAllGraphicText2(co.passiveDesc)
	self._txtCapacity.text = "x" .. co.totalDice

	local effectIds = {}
	local tempEffect = ""

	for k, v in pairs(effectIds) do
		local effectCo = RoguelikeConfig.instance:getEffectById(v)

		tempEffect = tempEffect .. " " .. effectCo.description
	end

	self._txtSkillDesc.text = #effectIds == 0 and lang("tip_r_monster_not_atk") or StringUtil.replaceAllGraphicText2(tempEffect)

	IconLoader.setSprite(self._imgMonsterIcon, IconType.RunGroup, string.format("rungroup_monster/%d", co.staticRes), self._monsterImgLoadCallback, self)

	for i = 0, self._traFeatures.childCount - 1 do
		goutil.setActive(self._traFeatures:GetChild(i).gameObject, false)
	end

	local features = co.features

	for i = 1, #features do
		local item = self._goFItems[i]

		item = item or Astral.GameObjectUtil.CloneAndSetParent(self._goFeaturesItem, self._traFeatures, nil)

		local icon = item.transform:Find("icon"):GetComponent("Image")

		IconLoader.setSprite(icon, IconType.DynSpriteAtlas_Dice, string.format("dice_%d", RoguelikeConst.GetPatterIcon(features[i])))
		goutil.setActive(item, true)
	end
end

function M:onExit()
	return
end

function M:_monsterImgLoadCallback()
	self._imgMonsterIcon:SetNativeSize()
end

function M:_onClickClose()
	self:close()
end

return M
