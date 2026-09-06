-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclenuoya/view/MiraclenuoyanorView.lua

module("logic.extensions.miraclenuoya.view.MiraclenuoyanorView", package.seeall)

local MiraclenuoyanorView = class("MiraclenuoyanorView", ViewComponent)

function MiraclenuoyanorView:ctor()
	MiraclenuoyanorView.super.ctor(self)
end

function MiraclenuoyanorView:unbindEvents()
	MiraclenuoyanorView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function MiraclenuoyanorView:bindEvents()
	MiraclenuoyanorView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function MiraclenuoyanorView:buildUI()
	MiraclenuoyanorView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._con = self:getGo("con")
	self._tableview = self:getGo("worldRoot/worldPrize/prize/tableview")
	self._tablecell = self:getGo("worldRoot/worldPrize/prize/tablecell")
	self._progressBar = self:getSlider("worldRoot/worldPrize/prize/tableview/viewport/content/progBar")
	self._imgNum = self:getGo("totalPower/imgNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._rectTrans = self:getGo("worldRoot/worldPrize/prize/tableview/viewport").transform
	self._txtScore = self:getTxt("worldRoot/worldPrize/prize/score/txtScore")
	self._rankScrollerview = self:getGo("ruleCol/rankScrollerview")
	self._rankScrollercell = self:getGo("ruleCol/rankScrollercell")
	self._btnChallenge = self:getGo("ruleCol/btnChallenge/btn")
	self._txtDesc = self:getTxt("ruleCol/desc/txt")
	self._scrollerList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollerListRank = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function MiraclenuoyanorView:onExit()
	MiraclenuoyanorView.super.onExit(self)
	self._scrollerList:dispose()
	self._scrollerListRank:dispose()

	self._role = RoleObjectPool.instance:removeRole(self._role)
end

function MiraclenuoyanorView:onEnter()
	MiraclenuoyanorView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = MiracleNuoyaController.instance:getActivityId()
	end

	self._isMaxProgress = false
	self._actCfg = MiracleNuoyaConfig.instance:getActivityCfgById(self._activityId)

	self:_initView()
	self.addGEvent(self, GlobalNotify.MiracleNuoYaInfoUpdate, self._refreshUI, self)
	MiracleNuoyaController.instance:sendGetInfo(self._activityId)
	self:_refreshUI()
end

function MiraclenuoyanorView:_onClickTip()
	local ruleKey = self._actCfg.ruleKeyNor

	TipsFacade.instance:openRulesView(ruleKey)
end

function MiraclenuoyanorView:_onClickChallenge()
	if self._isMaxProgress then
		FloatWordMgr.instance:show("已达最大进度")

		return
	end

	MiracleNuoyaController.instance:openNorFmtView(self._activityId, self._groupId)
end

function MiraclenuoyanorView:_initView()
	local cfg = MiracleNuoyaConfig.instance:getDamageListCfgById(self._activityId) or {}

	self._scrollerListRank:reloadData(cfg)

	self._txtDesc.text = self._actCfg.norRuleDesc or "无"
end

function MiraclenuoyanorView:_refreshUI()
	local info = MiracleNuoyaModel.instance:getInfo(self._activityId) or {}

	if not info.normalClgInfo then
		local normalClgInfo = {}
		local normalClgTodayGroupId = checknumber(normalClgInfo.normalClgTodayGroupId)
		local normalClgTodayMaxDamage = checknumber(normalClgInfo.normalClgTodayMaxDamage)
		local normalClgProgress = checknumber(normalClgInfo.normalClgProgress)

		if not normalClgInfo.normalClgProgressPrizeGainedBitId then
			self._curProgress = normalClgProgress
			self._prizeGainedBitIdList = normalClgInfo.normalClgProgressPrizeGainedBitId
			self._groupId = normalClgTodayGroupId

			local progressCfg = MiracleNuoyaConfig.instance:getProgressListCfg(self._activityId) or {}
			local list = {}

			for k, v in pairs(progressCfg) do
				table.insert(list, v)
			end

			ArraySort.sortOn(list, "dataBitId", ArraySort.NUMERIC)

			local stepArr = {
				0
			}
			local scoreArr = {}
			local lastCanGetidx = -1
			local lastIdx = 0
			local firstStep = 0.147
			local gap = (1 - firstStep) / (#list - 1)

			for i, v in ipairs(list) do
				table.insert(scoreArr, v.progress)
				table.insert(stepArr, math.min(1, firstStep + (i - 1) * gap))

				local isCanGet = self._curProgress >= v.progress

				if isCanGet then
					lastIdx = i - 1
				end

				if lastCanGetidx == -1 then
					local isGainPrize = table.indexof(self._prizeGainedBitIdList, v.dataBitId) ~= false

					if isCanGet and not isGainPrize then
						lastCanGetidx = i - 1
					end
				end
			end

			local idx = lastCanGetidx

			if lastCanGetidx == -1 then
				idx = lastIdx
			end

			self._isMaxProgress = lastIdx + 1 == #list

			ArraySort.sortOn(list, "dataBitId", ArraySort.DESCENDING)
			self._scrollerList:reloadData(list)
			self._scrollerList:updateUnderSlider(self._progressBar, normalClgProgress, scoreArr, stepArr)
			self._scrollerList:MoveCellToCenter(Mathf.Clamp(#list - 1 - idx, 0, #list - 1))
			self._imgNum:SetNum(normalClgTodayMaxDamage)

			self._txtScore.text = langPara("%s", normalClgProgress)

			local groupData = MiracleNuoyaConfig.instance:getGroupCfgById(self._activityId, self._groupId)

			if groupData then
				if not groupData.pos then
					local pos = {}
					local x, y = checknumber(pos[1]), checknumber(pos[2])

					if not groupData.pos[3] then
						local scale = 1

						GameUtil.setLocalPos(self._con, x, y, 0)
						GameUtil.setLocalScale(self._con, scale)

						self._role = RoleObjectPool.instance:addRoleToParent(self._role, groupData.skinId, self._con, 1, nil, true, 0, 0)
					end
				end
			else
				self._role = RoleObjectPool.instance:removeRole(self._role)
			end
		end
	end
end

function MiraclenuoyanorView:_clearCell(cell)
	local canGet = goutil.findChild(cell, "canGet")
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
	self:_clearEffect(canGet)
end

function MiraclenuoyanorView:_updateCell(view, cell, data, tag)
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local geted = goutil.findChild(cell, "geted")
	local item = goutil.findChild(cell, "item")
	local top = goutil.findChild(cell, "top")

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.progress

	local isCanGet = self._curProgress >= data.progress
	local isGainPrize = table.indexof(self._prizeGainedBitIdList, data.dataBitId) ~= false

	GameUtil.SetActive(canGet, isCanGet)
	GameUtil.SetActive(geted, isGainPrize)
	GameUtil.SetActive(top, isCanGet and not isGainPrize)
	self:_clearEffect(canGet)

	if isCanGet and not isGainPrize then
		self:_playEffect(canGet)
	end

	GameUtil.addClickHandler(top, GameUtil.handler(self._onClickGetPrize, self, data.dataBitId))
end

function MiraclenuoyanorView:_onClickGetPrize(id)
	MiracleNuoyaController.instance:sendGetProgressPrize(self._activityId, id)
end

function MiraclenuoyanorView:_playEffect(effGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self._rectTrans)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function MiraclenuoyanorView:_clearRankCell(cell)
	return
end

function MiraclenuoyanorView:_updateRankCell(view, cell, data, tag)
	local imgNum = goutil.findChildComponent(cell, "imgNum", ComponentType.UIImgNumeralText)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")

	imgNum:SetNum(data.subId or 0)

	txtDesc.text = data.desc or ""
	txtScore.text = data.score or ""
end

function MiraclenuoyanorView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

return MiraclenuoyanorView
