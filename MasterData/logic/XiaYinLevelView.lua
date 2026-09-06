-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiayin/view/XiaYinLevelView.lua

module("logic.extensions.xiayin.view.XiaYinLevelView", package.seeall)

local XiaYinLevelView = class("XiaYinLevelView", ViewComponent)

function XiaYinLevelView:buildUI()
	XiaYinLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnChallenge = self:getBtn("enemyFmt/btnChallenge")
	self._tabList = {}

	for i = 1, 3 do
		local go = self:getGo("tabs/tab" .. i)
		local info = {}

		info.btn = Framework.ButtonAdapter.Get(go)
		info.txtName = goutil.findChildTextComponent(go, "txtName")
		info.nameColorChange = info.txtName.gameObject:GetComponent(ComponentType.UITextColorChange)
		info.lockGo = goutil.findChild(go, "lock")
		info.passGo = goutil.findChild(go, "pass")
		info.selectGo = goutil.findChild(go, "select")
		info.unSelectGo = goutil.findChild(go, "img")

		table.insert(self._tabList, info)
	end

	self._levelList = {}

	for i = 1, 5 do
		local go = self:getGo("levels/level" .. i)
		local info = {}

		info.btn = Framework.ButtonAdapter.Get(go)
		info.node = goutil.findChild(go, "node")
		info.passGo = goutil.findChild(go, "pass")
		info.selectGo = goutil.findChild(go, "select")

		table.insert(self._levelList, info)
	end

	self._txtName = self:getTxt("enemyFmt/txtName")
	self._txtPass = self:getTxt("enemyFmt/txtPass")
	self._txtRule = self:getTxt("enemyFmt/txtRule")
	self._fmtList = {}

	for i = 1, 9 do
		local item = {}

		item.go = self:getGo(string.format("enemyFmt/fmt/cell_%d", i))
		item.con = self:getGo(string.format("enemyFmt/fmt/cell_%d/con", i))
		item.tagGo = goutil.findChild(item.go, "tag")
		item.tagChange = item.tagGo:GetComponent(ComponentType.UIImageSpriteChange)
		item.txtTag = goutil.findChildTextComponent(item.tagGo, "txt")

		table.insert(self._fmtList, item)
	end

	self._powerPetMo = FightingPowerPetMo.New()
end

function XiaYinLevelView:bindEvents()
	XiaYinLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)

	for i, v in ipairs(self._levelList) do
		GameUtil.addClickHandler(v.btn, GameUtil.handler(self._onClickLevel, self, i))
	end
end

function XiaYinLevelView:unbindEvents()
	XiaYinLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)

	for i, v in ipairs(self._levelList) do
		GameUtil.rmClickHandler(v.btn)
	end
end

function XiaYinLevelView:onEnter()
	XiaYinLevelView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._curTier = 0

	local curTier = XiaYinModel.instance:getCurTier(self._activityId)

	self._selectLevelIndex = 0

	self:_initEnemyFmtInfo()
	self:_onClickTab(curTier)
end

function XiaYinLevelView:onExit()
	XiaYinLevelView.super.onExit(self)

	self._curTier = nil

	self:_clearEnemyFmt()
	self:_clearLevels()
end

function XiaYinLevelView:_onClickChallenge()
	if self._selectLevelIndex == 0 then
		FloatWordMgr.instance:show("请先选择关卡")

		return
	end

	local cfg = XiaYinConfig.instance:getTierCfg(self._activityId, self._curTier)
	local creepsMasterId = cfg.stages[self._selectLevelIndex]

	if XiaYinModel.instance:isStagePass(self._activityId, self._curTier, self._selectLevelIndex) then
		FloatWordMgr.instance:show("已通过关卡")

		return
	end

	XiaYinController.instance:openMissionView(self._activityId, self._curTier, creepsMasterId, self._selectLevelIndex, ViewName.XiaYinTagView)
end

function XiaYinLevelView:_onClickTab(tierId)
	if self._curTier == tierId then
		return
	end

	self._curTier = tierId

	self:_updateTabs()
end

function XiaYinLevelView:_onClickLevel(index)
	if self._selectLevelIndex == index then
		return
	end

	self._selectLevelIndex = index

	self:_updateLevels()
	self:_updateEnemyFmtInfo(index)
end

function XiaYinLevelView:_updateTabs()
	for i, v in ipairs(self._tabList) do
		local tierId = i
		local cfg = XiaYinConfig.instance:getTierCfg(self._activityId, tierId)

		v.txtName.text = cfg.name

		local isTierPass = XiaYinModel.instance:isTierPass(self._activityId, tierId)
		local isTierLock = XiaYinModel.instance:isTierLock(self._activityId, tierId)

		GameUtil.SetActive(v.lockGo, isTierLock)
		GameUtil.SetActive(v.passGo, isTierPass)
		GameUtil.SetActive(v.selectGo, not isTierLock and not isTierPass)
		GameUtil.SetActive(v.unSelectGo, isTierLock or isTierPass)
		v.nameColorChange:SetState((isTierLock or isTierPass) and 0 or 1)
	end

	self:_initLevels()
end

function XiaYinLevelView:_initLevels()
	local isFirstSelect = true
	local cfg = XiaYinConfig.instance:getTierCfg(self._activityId, self._curTier)
	local stages = cfg.stages
	local selectIndex = 1

	for i, v in ipairs(self._levelList) do
		local creepsMasterId = stages[i]
		local cfgCreeps = XiaYinConfig.instance:getSortCreeps(creepsMasterId)

		MaterialMgr.setIcon(v.node, MatType.Pet, cfgCreeps[1].raceId)

		local isPassStage = XiaYinModel.instance:isStagePass(self._activityId, self._curTier, i)

		GameUtil.SetActive(v.passGo, isPassStage)

		if isFirstSelect and not isPassStage then
			selectIndex = i
			isFirstSelect = false

			GameUtil.SetActive(v.selectGo, true)
		else
			GameUtil.SetActive(v.selectGo, false)
		end
	end

	if self._selectLevelIndex == 0 and isFirstSelect then
		selectIndex = #self._levelList

		GameUtil.SetActive(self._levelList[#self._levelList].selectGo, true)
	end

	self:_onClickLevel(selectIndex)
end

function XiaYinLevelView:_updateLevels()
	for i, v in ipairs(self._levelList) do
		GameUtil.SetActive(v.selectGo, self._selectLevelIndex == i)
	end
end

function XiaYinLevelView:_clearLevels()
	for i, v in ipairs(self._levelList) do
		MaterialMgr.clearIcon(v.node)
	end
end

function XiaYinLevelView:_initEnemyFmtInfo()
	self._txtName.text = ""
	self._txtPass.text = ""
	self._txtRule.text = ""

	self:_clearEnemyFmt()
end

function XiaYinLevelView:_updateEnemyFmtInfo(index)
	self:_clearEnemyFmt()

	local cfg = XiaYinConfig.instance:getTierCfg(self._activityId, self._curTier)
	local creepsMasterId = cfg.stages[index]
	local cfgMonster = XiaYinConfig.instance:getMonsterCfg(creepsMasterId)

	self._txtName.text = cfgMonster.name
	self._txtPass.text = cfgMonster.WinDesc
	self._txtRule.text = cfg.stageDesc

	local cfgCreeps = XiaYinConfig.instance:getCreeps(creepsMasterId)

	for i, cfgEnemy in ipairs(cfgCreeps) do
		local item = self._fmtList[cfgEnemy.posId]

		if item and item.go then
			goutil.setActive(item.go, true)
			GameUtil.setLocalScale(item.con, 0.8, 0.8, 0.8)

			if cfgEnemy.buffMark ~= "" then
				if not XiaYinTagView.Word2Index[cfgEnemy.buffMark] then
					local buffMark = 0

					item.tagChange:SetState(Mathf.Clamp(buffMark, 0, 2))

					item.txtTag.text = cfgEnemy.buffMark

					GameUtil.SetActive(item.tagGo, buffMark > 0)
					self._powerPetMo:fromChallengeCreepCo(cfgEnemy)

					local bagPetMo = self._powerPetMo:toBaseBagPetMo()
					local proxy = MaterialMgr.setCellByMo(bagPetMo, item.con)

					proxy.binder:setAutoTips(false)
					proxy:setCallBack(function()
						CommonTipsMgr.instance:showPetTips(bagPetMo)
					end)
				end
			end
		end
	end
end

function XiaYinLevelView:_clearEnemyFmt()
	for i, v in ipairs(self._fmtList) do
		MaterialMgr.resetAll(v.con)
		goutil.setActive(v.go, false)
	end
end

return XiaYinLevelView
