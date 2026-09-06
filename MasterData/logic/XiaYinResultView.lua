-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiayin/view/XiaYinResultView.lua

module("logic.extensions.xiayin.view.XiaYinResultView", package.seeall)

local XiaYinResultView = class("XiaYinResultView", ViewComponent)

function XiaYinResultView:ctor()
	XiaYinResultView.super.ctor(self)
end

function XiaYinResultView:buildUI()
	XiaYinResultView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtDesc = self:getTxt("txtDesc")
	self._fmtList = {}

	for i = 1, 9 do
		local item = {}

		item.go = self:getGo(string.format("fmt/cell_%d", i))
		item.con = self:getGo(string.format("fmt/cell_%d/con", i))
		item.tagGo = goutil.findChild(item.go, "tag")
		item.tagChange = item.tagGo:GetComponent(ComponentType.UIImageSpriteChange)
		item.txtTag = goutil.findChildTextComponent(item.tagGo, "txt")
		item.deadGo = goutil.findChild(item.go, "dead")

		table.insert(self._fmtList, item)
	end

	self._powerPetMo = FightingPowerPetMo.New()
end

function XiaYinResultView:bindEvents()
	XiaYinResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function XiaYinResultView:unbindEvents()
	XiaYinResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function XiaYinResultView:onEnter()
	XiaYinResultView.super.onEnter(self)

	local params = self:getOpenParam()

	self._creepsMasterId = params[1]
	self._isWin = params[2]

	local cfg = XiaYinConfig.instance:getMonsterCfg(self._creepsMasterId)

	self._txtTitle.text = self._isWin and "挑战成功" or "挑战失败"

	local str = self._isWin and "已在" or "未在"

	self._txtDesc.text = str .. cfg.WinDesc

	self:_initFmts()
end

function XiaYinResultView:onExit()
	XiaYinResultView.super.onExit(self)
	self:_clearEnemyFmt()
end

function XiaYinResultView:_onClickClose()
	self:close()
	BattleController.instance:endBattle()
end

function XiaYinResultView:_onClickSure()
	self:_onClickClose()
end

function XiaYinResultView:_initFmts()
	self:_clearEnemyFmt()

	local cfgCreeps = XiaYinConfig.instance:getCreeps(self._creepsMasterId)

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

					local isDead = self:_isDead(cfgEnemy.raceId)

					GameUtil.SetActive(item.deadGo, isDead)
				end
			end
		end
	end
end

function XiaYinResultView:_clearEnemyFmt()
	for i, v in ipairs(self._fmtList) do
		MaterialMgr.resetAll(v.con)
		goutil.setActive(v.go, false)
		goutil.setActive(v.deadGo, false)
		GameUtil.SetActive(v.tagGo, false)
	end
end

function XiaYinResultView:_isDead(raceId)
	local units = BattleModel.instance:getEnemyUnits()

	printInfo("test XiaYinResultView:_isDead", raceId, units)

	for i, v in pairs(units) do
		printInfo("test XiaYinResultView:_isDead1", v.attrs:getOriginRaceId(), raceId, v.attrs:getOriginRaceId() == raceId)

		if v.attrs:getOriginRaceId() == raceId then
			local isDead = v:isDead() or v.attrs:getCurHp() == 0

			printInfo("test XiaYinResultView:_isDead2", raceId, v:isDead(), v.attrs:getCurHp(), v.attrs:getCurHp() == 0, isDead)

			return isDead
		end
	end

	printInfo("test XiaYinResultView:_isDead3", raceId)

	return false
end

return XiaYinResultView
