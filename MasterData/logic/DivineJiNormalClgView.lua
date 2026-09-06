-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/view/DivineJiNormalClgView.lua

module("logic.extensions.divinejiclg.view.DivineJiNormalClgView", package.seeall)

local DivineJiNormalClgView = class("DivineJiNormalClgView", ViewComponent)

function DivineJiNormalClgView:ctor()
	DivineJiNormalClgView.super.ctor(self)
end

function DivineJiNormalClgView:buildUI()
	DivineJiNormalClgView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._buffView = self:getGo("buffs/tableview")
	self._buffCell = self:getGo("buffs/tableview/tablecell")
	self._buffSl = ScrollerList.create(self._buffView, self._buffCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))

	self._buffSl:regReloadFinish(GameUtil.handler(self._reloadBuffFinish, self))

	self._stageView = self:getGo("stageSl")
	self._stageCell = self:getGo("stageSl/tablecell")
	self._stageSl = ScrollerList.create(self._stageView, self._stageCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._prizeview = self:getGo("prizeSl")
	self._prizecell = self:getGo("prizeSl/tablecell")
	self._prizeSl = ScrollerList.create(self._prizeview, self._prizecell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

	self._prizeSl:regReloadFinish(GameUtil.handler(self._reloadPrizeFinish, self))

	self._progBar = self:getGo("prizeSl/viewport/content/slider"):GetComponent("Slider")
	self._progTxt = self:getGo("prizeSl/progress/prog"):GetComponent(typeof(UnityEngine.UI.Text))
	self._przRectTrans = self._prizeview:GetComponent(typeof(UnityEngine.RectTransform))
end

function DivineJiNormalClgView:bindEvents()
	DivineJiNormalClgView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTipBtn, self)
end

function DivineJiNormalClgView:unbindEvents()
	DivineJiNormalClgView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DivineJiNormalClgView:onExit()
	DivineJiNormalClgView.super.onExit(self)

	if self._prizeBtnMap then
		for _, btn in pairs(self._prizeBtnMap) do
			GameUtil.rmClickHandler(btn)
		end
	end

	self._buffSl:dispose()
	self._stageSl:dispose()
	self._prizeSl:dispose()
end

function DivineJiNormalClgView:onEnter()
	DivineJiNormalClgView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineJiClgGetInfoRes, self._refresh, self)

	self._activityId = checknumber(self:getFirstParam())

	if not self._activityId then
		FloatWordMgr.instance:show("活动Id为空")
		self:close()

		return
	end

	self:_getViewConfig()

	self._effectMap = {}
	self._prizeBtnMap = {}
	self._info = DivineJiClgModel.instance:getActivityInfo(self._activityId)
	self._maxClgProg = self._progCfg[#self._progCfg].progress

	if not self._info then
		DivineJiClgAgent.instance:sendPM_DivineJiClgGetInfoReq(self._activityId)

		return
	end

	self:_refresh()
end

function DivineJiNormalClgView:_onClickTipBtn()
	local challengeCfg = TimeLimitedConfig.instance:getCfgById(198)

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function DivineJiNormalClgView:_onClickFmtBtn(data, teamOrderId)
	if data and data.right == 1 then
		TipsFacade.instance:openCommonTips("当前关卡已通关")

		return
	end

	if self._curClgProg >= self._maxClgProg then
		TipsFacade.instance:openCommonTips("已达到最大积分")

		return
	end

	DivineJiClgController.instance:openNormalClgFmtView(self._activityId, data.left, teamOrderId)
end

function DivineJiNormalClgView:_onClickBtnPrize(dataBitId)
	DivineJiClgAgent.instance:sendPM_DivineJiGainNormalClgPrizeReq(self._activityId, dataBitId)
end

function DivineJiNormalClgView:_getViewConfig()
	self._activityCfg = DivineJiClgConfig.instance:getActivityCfgByActId(self._activityId)
	self._buffCfg = DivineJiClgConfig.instance:getNormalBuffCfgByActId(self._activityId)
	self._progCfg = DivineJiClgConfig.instance:getNormalProgressCfgByActId(self._activityId)
end

function DivineJiNormalClgView:_refresh()
	self._info = DivineJiClgModel.instance:getActivityInfo(self._activityId)

	if not self._info.normalClgMonsterInfo then
		local normalClgMonsterInfo = {}

		self._curClgProg = self._info.normalClgProgress or 0

		if not self._info.normalClgPrizeGainedBitId then
			local normalClgPrizeGainedBitId = {}
			local gainedAllCanGainPrz = true

			DivineJiClgController.instance:setSliderValue(self._progBar, self._progTxt, self._progCfg, self._curClgProg)

			for i, v in ipairs(normalClgPrizeGainedBitId) do
				if i < v then
					gainedAllCanGainPrz = false
					self._curGainPrizeId = i

					break
				end
			end

			if gainedAllCanGainPrz then
				self._curGainPrizeId = #normalClgPrizeGainedBitId + 1 or self._curGainPrizeId
			end

			if self._curGainPrizeId > #self._progCfg then
				self:close()

				return
			end

			self._activeBuffId = self._info.normalClgBuffId
			self._nextBuffId = self._info.normalClgBuffId % #self._buffCfg + 1

			self._buffSl:reloadData(self._buffCfg)
			self._stageSl:setCenterMode(true)
			self._stageSl:reloadData(normalClgMonsterInfo)
			self._prizeSl:reloadData(self._progCfg)
		end
	end
end

function DivineJiNormalClgView:_updateBuffCell(view, cell, data)
	local mask = goutil.findChild(cell, "mask")
	local tag = goutil.findChild(cell, "tag")
	local title = goutil.findChildTextComponent(cell, "title")
	local desc = goutil.findChildTextComponent(cell, "desc")
	local tagTxt = goutil.findChildTextComponent(cell, "tag/txt")
	local tagImg = goutil.findChild(cell, "tag/img"):GetComponent(ComponentType.UIImageSpriteChange)
	local cfg = string.split(data.desc, "buff-")
	local name, details = cfg[1], cfg[2]
	local isActiveBuff = data.buffId == self._activeBuffId
	local isNextBuff = data.buffId == self._nextBuffId

	title.text = name .. "属性加成"
	desc.text = details
	tagTxt.text = isActiveBuff and "今日激活" or "明日激活"

	goutil.setActive(tag, isActiveBuff or isNextBuff)
	goutil.setActive(mask, not isActiveBuff)
	tagImg:SetState(isActiveBuff and 1 or 0)
end

function DivineJiNormalClgView:_clearBuffCell(cell)
	return
end

function DivineJiNormalClgView:_reloadBuffFinish()
	if self._info then
		if not self._info.normalClgBuffId then
			local curIndex = 1

			if curIndex then
				self._buffSl:MoveCellToCenter(curIndex - 1)
			end
		end
	end
end

function DivineJiNormalClgView:_updateStageCell(view, cell, data)
	local pass = goutil.findChild(cell, "fmt/pass")
	local fmt = goutil.findChild(cell, "fmt")
	local creepsCfg = DivineJiClgConfig.instance:getNormalCreepsCfgByCreepsId(data.left) or {}
	local isPass = data.right == 1
	local map = {}

	for i = 1, 9 do
		local go = goutil.findChild(cell, "fmt/cell_" .. i)

		map[i] = go

		GameUtil.SetActive(go, false)
	end

	for i, v in ipairs(creepsCfg) do
		local posId = checknumber(v.posId)

		if posId > 0 then
			local go = map[posId]

			GameUtil.SetActive(go, true)

			local con = goutil.findChild(go, "con")

			MaterialMgr.setIcon(con, MatType.Pet, v.raceId)
		end
	end

	goutil.setActive(pass, isPass)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickFmtBtn, self, data, cell.index + 1), self)
end

function DivineJiNormalClgView:_clearStageCell(cell)
	GameUtil.rmClickHandler(cell)

	for i = 1, 9 do
		local con = goutil.findChild(cell, "fmt/cell_" .. i .. "/con")

		MaterialMgr.resetAll(con)
	end
end

function DivineJiNormalClgView:_updatePrizeCell(view, cell, data)
	self:_clearPrizeCell(cell)

	local item = goutil.findChild(cell, "cell/item")
	local effect = goutil.findChild(cell, "cell/effect")
	local got = goutil.findChild(cell, "cell/got")
	local progress = goutil.findChildTextComponent(cell, "progress")
	local proxy = MaterialMgr.setCellByCfg(data.prize, item)

	if not self._info.normalClgPrizeGainedBitId then
		local isGot = table.keyof(self._info.normalClgPrizeGainedBitId, data.dataBitId) or false
		local canGet = not isGot and data.progress <= self._curClgProg

		self._prizeBtnMap[cell] = self._prizeBtnMap[cell] or goutil.findChild(cell, "cell/btn")

		if canGet then
			self._effectMap[cell] = self:_loadEffect(effect, self._przRectTrans)

			GameUtil.addClickHandler(self._prizeBtnMap[cell], GameUtil.handler(self._onClickBtnPrize, self, data.dataBitId), self)
		end

		progress.text = tostring(data.progress)

		goutil.setActive(got, isGot)
		goutil.setActive(self._prizeBtnMap[cell], canGet)
	end
end

function DivineJiNormalClgView:_clearPrizeCell(cell)
	local item = goutil.findChild(cell, "cell/item")
	local got = goutil.findChild(cell, "cell/got")

	goutil.setActive(got, false)

	if self._effectMap and self._effectMap[cell] then
		self:_unloadEffect(self._effectMap[cell])
	end

	if self._prizeBtnMap and self._prizeBtnMap[cell] then
		GameUtil.rmClickHandler(self._prizeBtnMap[cell])
		goutil.setActive(self._prizeBtnMap[cell], false)
	end

	MaterialMgr.resetAll(item)
end

function DivineJiNormalClgView:_reloadPrizeFinish()
	local curIndex = checknumber(self._curGainPrizeId) > 0 and math.min(self._curGainPrizeId, #self._progCfg) or 1

	if curIndex then
		self._prizeSl:MoveCellToCenter(curIndex - 1)
	end
end

function DivineJiNormalClgView:_loadEffect(root, rectTrans)
	local effectPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local effect

	effect = UIEffectManager.instance:playEffect(self, effectPath, root.transform, 0, 0, true, false, nil, function()
		if rectTrans then
			effect:setClipping(rectTrans)
		end
	end)

	effect:setParent(root.transform)
	effect:setScale(1)
	effect:setLocalPos(0, 0, 0)

	return effect
end

function DivineJiNormalClgView:_unloadEffect(effect)
	if effect then
		UIEffectManager.instance:stopEffect(effect)

		effect = nil
	end
end

return DivineJiNormalClgView
