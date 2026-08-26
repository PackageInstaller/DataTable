-- chunkname: @modules/logic/fight/view/FightDouQuQuBossViewDeer.lua

module("modules.logic.fight.view.FightDouQuQuBossViewDeer", package.seeall)

local FightDouQuQuBossViewDeer = class("FightDouQuQuBossViewDeer", FightBaseView)

function FightDouQuQuBossViewDeer:onConstructor(entityData)
	self.entityData = entityData
end

function FightDouQuQuBossViewDeer:onInitView()
	self.headRoot = gohelper.findChild(self.viewGO, "head")
	self.levelUpRoot = gohelper.findChild(self.viewGO, "go_levelUp")
	self.energyRoot = gohelper.findChild(self.viewGO, "go_energy")
	self.pointObjList = {}
	self.pointLightList = {}

	for i = 1, 5 do
		self.pointObjList[i] = gohelper.findChild(self.viewGO, "go_energy/" .. i)
		self.pointLightList[i] = gohelper.findChild(self.viewGO, "go_energy/" .. i .. "/light")
	end

	self.totalTimesRoot = gohelper.findChild(self.viewGO, "go_totalTimes")

	gohelper.setActive(self.totalTimesRoot, false)

	self.skillTotalTimesText = gohelper.findChildText(self.viewGO, "go_totalTimes/bg/#txt_totalTimes")
	self.click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "clickarea")
end

function FightDouQuQuBossViewDeer:addEvents()
	self:com_registClick(self.click, self.onClick)
	self:com_registFightEvent(FightEvent.UpdateFightParam, self.onUpdateFightParam)
end

function FightDouQuQuBossViewDeer:onClick()
	if not self.config then
		return
	end

	local screenPos = recthelper.uiPosToScreenPos(self.viewGO.transform)

	FightCommonTipController.instance:openCommonView("", self.config.bossDesc, screenPos, nil, nil, -600)
end

function FightDouQuQuBossViewDeer:onUpdateFightParam(id, oldValue, currentValue, offset)
	if not self.config then
		return
	end

	if id ~= FightParamData.ParamKey.ACT191_GLOBAL_ACTION_COUNT then
		return
	end

	self:refreshUI(offset)
end

function FightDouQuQuBossViewDeer:onOpen()
	transformhelper.setLocalScale(self.viewGO.transform, 0.8, 0.8, 0.8)
	recthelper.setAnchor(self.viewGO.transform, 54, 0)

	local skinId = self.entityData.skin
	local configList = lua_activity191_assist_boss.configList

	self.config = lua_activity191_assist_boss.configList[1]

	for k, config in pairs(configList) do
		if config.skinId == skinId then
			self.config = config

			break
		end
	end

	if not self.config then
		self:closeThis()

		return
	end

	self.maxCount = 5

	local skinId = self.entityData.skin

	if skinId == 6704042 or skinId == 6704043 then
		self.maxCount = 3
	end

	for i = self.maxCount + 1, #self.pointObjList do
		gohelper.setActive(self.pointObjList[i], false)
	end

	self:refreshUI()
end

function FightDouQuQuBossViewDeer:refreshUI(offset)
	local curNum = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_GLOBAL_ACTION_COUNT]
	local skinId = self.entityData.skin

	if curNum ~= 0 then
		curNum = (skinId == 6704042 or skinId == 6704043) and (curNum - 1) % 3 + 1 or (curNum - 1) % 5 + 1
	end

	for i = 1, self.maxCount do
		gohelper.setActive(self.pointLightList[i], i <= curNum)
	end

	if curNum == self.maxCount then
		AudioMgr.instance:trigger(380045)
	end

	gohelper.setActive(self.levelUpRoot, curNum == self.maxCount)
end

return FightDouQuQuBossViewDeer
