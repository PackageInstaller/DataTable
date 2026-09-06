-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/view/copy/OrizhmoyanlevelselectView.lua

module("logic.extensions.fantian.view.copy.OrizhmoyanlevelselectView", package.seeall)

local OrizhmoyanlevelselectView = class("OrizhmoyanlevelselectView", ViewComponent)

function OrizhmoyanlevelselectView:ctor()
	OrizhmoyanlevelselectView.super.ctor(self)
end

function OrizhmoyanlevelselectView:unbindEvents()
	OrizhmoyanlevelselectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnTip)
end

function OrizhmoyanlevelselectView:bindEvents()
	OrizhmoyanlevelselectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function OrizhmoyanlevelselectView:buildUI()
	OrizhmoyanlevelselectView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnChallenge = self:getGo("btnChallenge")
	self._txtTip = self:getTxt("info/txtTip")
	self._formation = self:getGo("info/formation")
	self._stage = self:getGo("stage")
	self._level = self:getGo("level")
	self._powerPetMo = FightingPowerPetMo.New()
	self._txtDesc = self:getTxt("info/txtDesc")
end

function OrizhmoyanlevelselectView:onExit()
	OrizhmoyanlevelselectView.super.onExit(self)

	for i = 1, 9 do
		local cell = self:getGo("info/formation/cell_" .. i)
		local con = goutil.findChild(cell, "con")

		MaterialMgr.clearIcon(con)
	end

	for i = 1, 5 do
		local go = self:getGo("level/level_" .. i)
		local petIcon = goutil.findChild(go, "petIcon")

		GameUtil.rmClickHandler(go)
		MaterialMgr.clearIcon(petIcon)
	end
end

function OrizhmoyanlevelselectView:onEnter()
	OrizhmoyanlevelselectView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 313001
	end

	self:_refreshUI()
	self.addGEvent(self, GlobalNotify.FanTianChallengeUpdate, self._refreshUI, self)
	FanTianChallengeController.instance:sendGetInfo(self._activityId)
end

function OrizhmoyanlevelselectView:_refreshUI()
	self._actCfg = FanTianChallengeConfig.instance:getActivityCfgById(self._activityId)

	local info = FanTianChallengeModel.instance:getInfo(self._activityId) or {}

	self._curProgress = checknumber(info.dragonSoulProgress)
	self._prizeGainedBitIdList = info.prizeGainedBitId or {}

	local curTierId = checknumber(info.curTierId)

	self._stageCfgList = FanTianChallengeConfig.instance:getStageCfgList(self._activityId)
	self._curSelectTierId = math.min(curTierId, #self._stageCfgList)
	self._curSelectTierId = math.max(self._curSelectTierId, 1)

	self:_upateStage(info)
	self:_onClickStage(self._curSelectTierId)
end

function OrizhmoyanlevelselectView:_upateStage(info)
	self._stageList = {}

	for i = 1, 3 do
		local go = self:getGo("stage/stage_" .. i)
		local pass = goutil.findChild(go, "pass")
		local select = goutil.findChild(go, "select")
		local lock = goutil.findChild(go, "lock")
		local txtLock = goutil.findChildTextComponent(lock, "txt")
		local txtNum = goutil.findChildTextComponent(go, "itemNum/txtNum")
		local txtName = goutil.findChildTextComponent(go, "txtName")
		local total = 0
		local cur = 0
		local tierList = FanTianChallengeConfig.instance:getStageTierList(self._activityId, i) or {}

		for lvlId, v in ipairs(tierList) do
			local creepsMasterId = v.creepsMasterId
			local creepcfg = FanTianChallengeConfig.instance:getCreepsCfgById(creepsMasterId) or {}

			for k, crCfg in pairs(creepcfg) do
				if not string.nilorempty(crCfg.dragonSoulDesc) then
					total = total + 1

					local hasGet = FanTianChallengeModel.instance:checkStageHasGain(self._activityId, i, lvlId, crCfg.creepsId)

					if hasGet then
						cur = cur + 1
					end
				end
			end
		end

		local firstStageCfg = FanTianChallengeConfig.instance:getStageCfgById(self._activityId, i, 1)

		txtNum.text = langPara("%s/%s", cur, total)

		GameUtil.SetActive(select, self._curSelectTierId == i)
		GameUtil.SetActive(pass, i < checknumber(info.curTierId))
		GameUtil.SetActive(lock, i > checknumber(info.curTierId))

		txtLock.text = "未开启"

		if not firstStageCfg or GameUtil.getTimePeriod(firstStageCfg.openTime, "") == GameUtil.inTimePeriod then
			-- block empty
		else
			local dateTime = GameUtil.string2date(firstStageCfg.openTime)

			txtLock.text = string.format("%d.%d开启", dateTime.month, dateTime.day)

			GameUtil.SetActive(lock, true)
		end

		GameUtil.rmClickHandler(go)
		GameUtil.addClickHandler(go, GameUtil.handler(self._onClickStage, self, i))
		table.insert(self._stageList, go)

		txtName.text = string.format("第<size=36>%s</size>层", i)
	end
end

function OrizhmoyanlevelselectView:_onClickStage(index)
	self._curSelectTierId = index
	self._curSelectLevel = 1

	for i, go in ipairs(self._stageList) do
		local select = goutil.findChild(go, "select")

		GameUtil.SetActive(select, self._curSelectTierId == i)
	end

	local map = {}
	local tierList = FanTianChallengeConfig.instance:getStageTierList(self._activityId, index) or {}

	for lvlId, v in ipairs(tierList) do
		local creepsMasterId = v.creepsMasterId
		local creepcfg = FanTianChallengeConfig.instance:getCreepsCfgById(creepsMasterId) or {}

		for k, crCfg in pairs(creepcfg) do
			if not string.nilorempty(crCfg.dragonSoulDesc) then
				map[lvlId] = map[lvlId] or {}

				table.insert(map[lvlId], crCfg.creepsId)
			end
		end
	end

	self._levelList = {}

	local isCheck = false

	for i = 1, 5 do
		local go = self:getGo("level/level_" .. i)
		local petIcon = goutil.findChild(go, "petIcon")
		local pass = goutil.findChild(go, "pass")
		local select = goutil.findChild(go, "select")

		GameUtil.rmClickHandler(go)
		MaterialMgr.clearIcon(petIcon)
		GameUtil.SetActive(pass, false)
		GameUtil.SetActive(select, false)

		if not tierList[i] then
			local cfg = {}
			local creepsMasterId = cfg.creepsMasterId
			local creepcfg = FanTianChallengeConfig.instance:getCreepsCfgById(creepsMasterId) or {}

			if creepcfg[1] then
				if not creepcfg[1].raceId then
					local raceId = 10016

					MaterialMgr.setIcon(petIcon, MatType.Pet, raceId)

					local finish = true

					for j = 1, 3 do
						local itemCon = goutil.findChild(go, "itemCon/item_" .. j)

						if map[i] then
							local creepsId = checknumber(map[i][j] or 0)

							GameUtil.SetActive(itemCon, creepsId > 0)

							if creepsId > 0 then
								local hasGet = FanTianChallengeModel.instance:checkStageHasGain(self._activityId, self._curSelectTierId, i, creepsId)

								GameUtil.SetGray(itemCon, not hasGet)

								if not hasGet then
									finish = false
								end

								if not isCheck and not hasGet then
									self._curSelectLevel = i
									isCheck = true
								end
							end
						end
					end

					GameUtil.SetActive(pass, finish)
					GameUtil.addClickHandler(go, GameUtil.handler(self._onClickLevel, self, i))
					table.insert(self._levelList, go)
				end
			end
		end
	end

	self:_onClickLevel(self._curSelectLevel)
end

function OrizhmoyanlevelselectView:_onClickLevel(index)
	self._curSelectLevel = index

	for i, go in ipairs(self._levelList) do
		local select = goutil.findChild(go, "select")

		GameUtil.SetActive(select, self._curSelectLevel == i)
	end

	local petMap = {}
	local list = {}
	local cfg = FanTianChallengeConfig.instance:getStageCfgById(self._activityId, self._curSelectTierId, index) or {}
	local creepsMasterId = cfg.creepsMasterId
	local creepcfg = FanTianChallengeConfig.instance:getCreepsCfgById(creepsMasterId) or {}

	for k, crCfg in pairs(creepcfg) do
		if not string.nilorempty(crCfg.dragonSoulDesc) then
			table.insert(list, crCfg)
		end

		petMap[crCfg.posId] = crCfg
	end

	for i = 1, 9 do
		local cell = self:getGo("info/formation/cell_" .. i)
		local con = goutil.findChild(cell, "con")
		local itemNum = goutil.findChild(cell, "itemNum")
		local select = goutil.findChild(cell, "select")
		local txtNum = goutil.findChildTextComponent(cell, "itemNum/txtNum")

		GameUtil.SetActive(itemNum, false)
		GameUtil.SetActive(select, false)
		GameUtil.rmClickHandler(con)
		MaterialMgr.clearIcon(con)

		local crCfg = petMap[i]

		GameUtil.SetActive(cell, false)

		if crCfg then
			GameUtil.SetActive(cell, true)
			self._powerPetMo:fromChallengeCreepCo(crCfg)

			local bagPetMo = self._powerPetMo:toBaseBagPetMo()
			local proxy = MaterialMgr.setCellByMo(bagPetMo, con)

			if proxy then
				proxy.binder:setAutoTips(false)
				proxy:setCallBack(function()
					CommonTipsMgr.instance:showPetTips(bagPetMo)
				end)
			end

			local idx = table.indexof(list, crCfg)

			if idx ~= false then
				GameUtil.SetActive(select, true)
				GameUtil.SetActive(itemNum, true)

				txtNum.text = idx
			end
		end
	end

	local isFinish = true
	local strList = {}

	for i = 1, 3 do
		if i <= #list then
			local crCfg = list[i]
			local hasGet = FanTianChallengeModel.instance:checkStageHasGain(self._activityId, self._curSelectTierId, index, crCfg.creepsId)

			if hasGet then
				table.insert(strList, i .. "、" .. crCfg.dragonSoulDesc .. "<color=#20b376>（已获得）</color>")
			else
				isFinish = false

				table.insert(strList, i .. "、" .. crCfg.dragonSoulDesc .. "<color=#a29f9f>（未获得）</color>")
			end
		end
	end

	self._txtDesc.text = table.concat(strList, "\n")

	local info = FanTianChallengeModel.instance:getInfo(self._activityId) or {}
	local curTierId = checknumber(info.curTierId)

	GameUtil.SetGray(self._btnChallenge, self._curSelectTierId ~= curTierId or isFinish)

	if self._curSelectTierId == curTierId then
		local cfg = FanTianChallengeConfig.instance:getStageCfgById(self._activityId, self._curSelectTierId, self._curSelectLevel) or {}

		if GameUtil.getTimePeriod(cfg.openTime, "") == GameUtil.inTimePeriod then
			-- block empty
		else
			GameUtil.SetGray(self._btnChallenge, true)
		end
	end
end

function OrizhmoyanlevelselectView:_onClickBtnTip()
	TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
end

function OrizhmoyanlevelselectView:_onClickChallenge()
	local info = FanTianChallengeModel.instance:getInfo(self._activityId) or {}
	local curTierId = checknumber(info.curTierId)

	if curTierId > self._curSelectTierId or curTierId > #self._stageCfgList then
		TipsFacade.instance:openCommonTips(langPara("本层%s已经全部收集", self:getItemDesc()))
	elseif curTierId < self._curSelectTierId then
		TipsFacade.instance:openCommonTips(langPara("请先收集上一层的所有%s", self:getItemDesc()))
	else
		local isFinish = true
		local cfg = FanTianChallengeConfig.instance:getStageCfgById(self._activityId, self._curSelectTierId, self._curSelectLevel) or {}

		if GameUtil.getTimePeriod(cfg.openTime, "") == GameUtil.inTimePeriod then
			-- block empty
		else
			local dateTime = GameUtil.string2date(cfg.openTime)

			TipsFacade.instance:openCommonTips(string.format("%d.%d 5:00后开启", dateTime.month, dateTime.day))

			return
		end

		local creepsMasterId = cfg.creepsMasterId
		local creepcfg = FanTianChallengeConfig.instance:getCreepsCfgById(creepsMasterId) or {}

		for k, crCfg in pairs(creepcfg) do
			if not string.nilorempty(crCfg.dragonSoulDesc) then
				local hasGet = FanTianChallengeModel.instance:checkStageHasGain(self._activityId, self._curSelectTierId, self._curSelectLevel, crCfg.creepsId)

				if not hasGet then
					isFinish = false
				end
			end
		end

		if isFinish then
			TipsFacade.instance:openCommonTips(langPara("本关%s已经全部收集", self:getItemDesc()))
		else
			FanTianChallengeController.instance:openFmtView(self._activityId, self._curSelectTierId, self._curSelectLevel, self:getResultViewName())
		end
	end
end

function OrizhmoyanlevelselectView:getItemDesc()
	return "龙魂"
end

function OrizhmoyanlevelselectView:getResultViewName()
	return ViewName.OrizhmoyanchallengeresultView
end

return OrizhmoyanlevelselectView
