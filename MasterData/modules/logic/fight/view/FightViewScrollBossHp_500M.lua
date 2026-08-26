-- chunkname: @modules/logic/fight/view/FightViewScrollBossHp_500M.lua

module("modules.logic.fight.view.FightViewScrollBossHp_500M", package.seeall)

local FightViewScrollBossHp_500M = class("FightViewScrollBossHp_500M", FightViewSurvivalBossHp)
local lockLifePath = "ui/viewres/fight/fighttower/fighttowerbosshplock.prefab"

function FightViewScrollBossHp_500M:onInitView()
	FightViewScrollBossHp_500M.super.onInitView(self)

	self.hpPointList = {}
	self.root = gohelper.findChild(self.viewGO, "Alpha/bossHp")
	self.loader = PrefabInstantiate.Create(self.root)

	self.loader:startLoad(lockLifePath, self.onLoadFinish, self)
	self:initPlayedPoSuiAnimPoint()
end

function FightViewScrollBossHp_500M:initPlayedPoSuiAnimPoint()
	self.playedPoSuiAnimPointDict = {}

	local bossEntityMo = self:_getBossEntityMO()

	if bossEntityMo then
		local multiHpIdx = bossEntityMo.attrMO:getCurMultiHpIndex()

		for i = 1, multiHpIdx do
			self.playedPoSuiAnimPointDict[i] = true
		end
	end
end

function FightViewScrollBossHp_500M:onLoadFinish()
	self.lockLifeGo = self.loader:getInstGO()
	self.goHpLock = gohelper.findChild(self.lockLifeGo, "go_hpLock")
	self.lockHpAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.goHpLock)
	self.goPointItem = gohelper.findChild(self.lockLifeGo, "go_hpPoint/#image_point")
	self.goHpPoint = gohelper.findChild(self.lockLifeGo, "go_hpPoint")

	gohelper.setActive(self.goHpLock, false)
	gohelper.setActive(self.goPointItem, false)
	self:_detectBossMultiHp()
end

local LockHpBuffId = 102310003

function FightViewScrollBossHp_500M:_onBuffUpdate(entityId, effectType, buffId, buff_uid, configEffect)
	FightViewScrollBossHp_500M.super._onBuffUpdate(self, entityId, effectType, buffId, buff_uid, configEffect)

	if buffId ~= LockHpBuffId then
		return
	end

	self:_detectBossMultiHp()
end

function FightViewScrollBossHp_500M:_detectBossMultiHp()
	gohelper.setActive(self._multiHpRoot, false)

	self.hasLockHpBuff = false

	local entityDict = FightDataHelper.entityMgr:getAllEntityMO()

	for _, entityMo in pairs(entityDict) do
		local buffDict = entityMo:getBuffDic()

		for _, buffMo in pairs(buffDict) do
			if buffMo.buffId == LockHpBuffId then
				self.hasLockHpBuff = true

				break
			end
		end

		if self.hasLockHpBuff then
			break
		end
	end

	self:refreshPoint_500M()
	self:refreshLockHp_500M()
end

function FightViewScrollBossHp_500M:refreshPoint_500M()
	local bossEntityMo = self._bossEntityMO

	if not bossEntityMo then
		gohelper.setActive(self.goHpPoint, false)

		return
	end

	local multiHpNum = bossEntityMo.attrMO.multiHpNum

	if multiHpNum <= 1 then
		gohelper.setActive(self.goHpPoint, false)

		return
	end

	gohelper.setActive(self.goHpPoint, true)

	local multiHpIdx = bossEntityMo.attrMO:getCurMultiHpIndex()

	for i = 1, multiHpNum do
		local hpPointItem = self.hpPointList[i]

		if not hpPointItem then
			hpPointItem = self:getUserDataTb_()
			hpPointItem.go = gohelper.cloneInPlace(self.goPointItem)
			hpPointItem.image = hpPointItem.go:GetComponent(gohelper.Type_Image)
			self.hpPointList[i] = hpPointItem

			gohelper.setAsFirstSibling(hpPointItem.go)
		end

		gohelper.setActive(hpPointItem.go, true)

		local showHp = multiHpIdx < i

		if showHp then
			local co = lua_fight_tower_500m_boss_behaviour.configDict[i]
			local icon = co and co.param1

			if icon then
				UISpriteSetMgr.instance:setFightTowerSprite(hpPointItem.image, icon)
			end
		else
			UISpriteSetMgr.instance:setFightTowerSprite(hpPointItem.image, "fight_tower_hp_0")

			if not self.playedPoSuiAnimPointDict[i] then
				self.playedPoSuiAnimPointDict[i] = true

				local animGo = gohelper.findChild(hpPointItem.go, "ani_posui")

				gohelper.setActive(animGo, true)

				local anim = animGo:GetComponent(gohelper.Type_Animation)

				anim:Play()
			end
		end
	end

	for i = multiHpNum + 1, #self.hpPointList do
		local hpPointItem = self.hpPointList[i]

		if hpPointItem then
			gohelper.setActive(hpPointItem.go, false)
		end
	end
end

function FightViewScrollBossHp_500M:refreshLockHp_500M()
	if self.hasLockHpBuff then
		gohelper.setActive(self.goHpLock, true)

		if not self.playedLockHpAudio then
			self.playedLockHpAudio = true

			AudioMgr.instance:trigger(310002)
		end

		return
	end

	local active = self.goHpLock.activeInHierarchy

	if active then
		self.lockHpAnimatorPlayer:Play("close", self.onCloseCallback, self)

		self.playedLockHpAudio = false

		AudioMgr.instance:trigger(310003)
	end
end

function FightViewScrollBossHp_500M:onCloseCallback()
	gohelper.setActive(self.goHpLock, false)
	self:_detectBossMultiHp()
end

local Threshold = {
	0.2,
	0.4,
	0.6,
	0.8,
	1
}
local Color = {
	{
		"#B33E2D",
		"#6F2216"
	},
	{
		"#D9852B",
		"#693700"
	},
	{
		"#69995E",
		"#243B1E"
	},
	{
		"#69995E",
		"#243B1E"
	},
	{
		"#69995E",
		"#243B1E"
	}
}

function FightViewScrollBossHp_500M:refreshHpColor()
	if not self._bossEntityMO then
		SLFramework.UGUI.GuiHelper.SetColor(self.hp, "#B33E2D")
		gohelper.setActive(self.bgHpGo, false)

		return
	end

	local curStage = FightHelper.getBossCurStageCo_500M(self._bossEntityMO)

	if not curStage then
		SLFramework.UGUI.GuiHelper.SetColor(self.hp, "#B33E2D")
		gohelper.setActive(self.bgHpGo, false)

		return
	end

	local curHp = self.tweenHp

	SLFramework.UGUI.GuiHelper.SetColor(self.hp, string.format("#%s", curStage.hpColor))

	if curHp <= self.oneMaxHp then
		local nextStage = curStage.level + 1
		local nextStageCo = lua_fight_tower_500m_boss_behaviour.configDict[nextStage]

		if not nextStageCo then
			gohelper.setActive(self.bgHpGo, false)
		else
			gohelper.setActive(self.bgHpGo, true)
			SLFramework.UGUI.GuiHelper.SetColor(self.bgHp, string.format("#%s", nextStageCo.hpBgColor))
		end
	else
		gohelper.setActive(self.bgHpGo, true)
		SLFramework.UGUI.GuiHelper.SetColor(self.bgHp, string.format("#%s", curStage.hpBgColor))
	end
end

function FightViewScrollBossHp_500M:getThreshold()
	return Threshold
end

function FightViewScrollBossHp_500M:getColor()
	return Color
end

function FightViewScrollBossHp_500M:refreshImageIcon()
	if not self._bossEntityMO then
		return
	end

	local modelId = self._bossEntityMO.modelId
	local co = lua_fight_sp_500m_model.configDict[modelId]
	local headIcon = co and co.headIconName

	if not string.nilorempty(headIcon) then
		gohelper.setActive(self._imgHead.gameObject, true)
		gohelper.getSingleImage(self._imgHead.gameObject):LoadImage(ResUrl.monsterHeadIcon(headIcon))

		local monsterCO = lua_monster.configDict[self._bossEntityMO.modelId]

		if monsterCO.heartVariantId ~= 0 then
			IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPath(monsterCO.heartVariantId), self._imgHeadIcon)
		end
	else
		gohelper.setActive(self._imgHead.gameObject, false)
	end
end

return FightViewScrollBossHp_500M
