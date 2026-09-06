-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/WaterTianYanClgMainView.lua

module("logic.extensions.watertianyan.view.WaterTianYanClgMainView", package.seeall)

local WaterTianYanClgMainView = class("WaterTianYanClgMainView", ViewComponent)

function WaterTianYanClgMainView:ctor()
	WaterTianYanClgMainView.super.ctor(self)
end

function WaterTianYanClgMainView:buildUI()
	WaterTianYanClgMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtBottom = self:getTxt("progress/slider/txtBottom")
	self._txtTop = self:getTxt("progress/slider/txtTop")

	local imgFillGo = self:getGo("progress/slider/imgFill")

	self._imgFill = imgFillGo:GetComponent(goutil.Type_UIImage)
	self._fillHeight = imgFillGo:GetComponent(goutil.Type_RectTransform).rect.width
	self._handleRect = self:getGo("progress/slider/handle"):GetComponent(goutil.Type_RectTransform)
	self._itemIcon = self:getGo("progress/slider/handle/itemIcon")
	self._txtCurLevel = self:getTxt("progress/slider/handle/txtCurLevel")

	local stageInfo = self:getGo("stageInfo")

	self._txtTitle = goutil.findChildTextComponent(stageInfo, "txtTitle")
	self._txtDesc1 = goutil.findChildTextComponent(stageInfo, "txtDesc1")
	self._txtDesc2 = goutil.findChildTextComponent(stageInfo, "txtDesc2")
	self.cellGo = goutil.findChild(stageInfo, "tablecell")
	self.scrollerGo = goutil.findChild(stageInfo, "tableview")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	local buffs = goutil.findChild(stageInfo, "buffs")

	self._buffList = {}

	for i = 1, 2 do
		local go = goutil.findChild(buffs, "buff" .. i)
		local element = {}

		element.go = go
		element.con = goutil.findChild(go, "con")

		goutil.setActive(element.con, false)

		element.btn = Framework.ButtonAdapter.GetFrom(go, "btn")
		element.txtDesc = goutil.findChildTextComponent(go, "txtDesc")
		element.img = goutil.findChild(go, "img")
		element.img2 = goutil.findChild(go, "img2")
		self._buffList[i] = element
	end

	self._btnChallenge = Framework.ButtonAdapter.GetFrom(stageInfo, "btnChallenge")
	self._btnReset = Framework.ButtonAdapter.GetFrom(stageInfo, "btnReset")
	self._btnPrev = Framework.ButtonAdapter.GetFrom(stageInfo, "btnPrev")
	self._btnNext = Framework.ButtonAdapter.GetFrom(stageInfo, "btnNext")
	self._passGo = goutil.findChild(stageInfo, "pass")
	self._lockGo = goutil.findChild(stageInfo, "lock")
	self._con = self:getGo("con")
end

function WaterTianYanClgMainView:bindEvents()
	WaterTianYanClgMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnPrev:AddClickListener(self._onClickPrev, self)
	self._btnNext:AddClickListener(self._onClickNext, self)

	for i, v in ipairs(self._buffList) do
		v.btn:AddClickListener(function()
			self:_onClickBuff(index)
		end)
	end
end

function WaterTianYanClgMainView:unbindEvents()
	WaterTianYanClgMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnPrev:RemoveClickListener()
	self._btnNext:RemoveClickListener()
end

function WaterTianYanClgMainView:onEnter()
	WaterTianYanClgMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.WaterTianYanResetMainStageRes, self._onResetMainStageRes, self)
	GlobalDispatcher:addListener(GlobalNotify.WaterTianYanSetBuff, self._onSetBuff, self)
	GlobalDispatcher:addListener(GlobalNotify.WaterTianYanUpgradeBuffRes, self._onUpgradeBuffRes, self)

	self._activityId = self:getFirstParam()
	self._cfgActivity = WaterTianYanConfig.instance:getActivityCfg(self._activityId)
	self._cfgStages = WaterTianYanConfig.instance:getMainStageCfgList(self._activityId)

	local cfgChallenge = TimeLimitedConfig.instance:getCfgById(self._cfgActivity.challengeId)

	if cfgChallenge then
		self._raceId = cfgChallenge.raceId or 0
	end

	self._maxStageNum = #self._cfgStages
	self._maxBuffNum = 2

	self:_initGos()
	self:_initStageId()

	self._buffItemIds = {}
	self._buffItemIds[1] = WaterTianYanController.instance:getSelectBuff(self._activityId, self._curStageId, 1)
	self._buffItemIds[2] = WaterTianYanController.instance:getSelectBuff(self._activityId, self._curStageId, 2)

	self:_updateProgress()
	self:_updateStageInfo()
	self:_showRoleModel()
end

function WaterTianYanClgMainView:onExit()
	WaterTianYanClgMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.WaterTianYanResetMainStageRes, self._onResetMainStageRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.WaterTianYanSetBuff, self._onSetBuff, self)
	GlobalDispatcher:removeListener(GlobalNotify.WaterTianYanUpgradeBuffRes, self._onUpgradeBuffRes, self)
	self:_clearProgress()
	self:_clearBuffs()
	self:_resetRoleModel()
end

function WaterTianYanClgMainView:_onUpgradeBuffRes()
	self:_updateBuffInfo()
end

function WaterTianYanClgMainView:_initGos()
	for i, v in ipairs(self._buffList) do
		goutil.setActive(v.con, false)
	end
end

function WaterTianYanClgMainView:_onClickTip()
	local rule = self._cfgActivity.clgRule

	UIStateManager.instance:push(ViewName.RulesView, rule)
end

function WaterTianYanClgMainView:_onClickChallenge()
	local isPassCurStage = WaterTianYanModel.instance:isPassMainStage(self._activityId, self._curStageId)

	if not isPassCurStage then
		local buffItemIds = {}

		for i, v in pairs(self._buffItemIds) do
			if checknumber(v) > 0 then
				table.insert(buffItemIds, checknumber(v))
			end
		end

		WaterTianYanController.instance:openMainMissionView(self._activityId, self._curStageId, buffItemIds)
	else
		FloatWordMgr.instance:show("已通关")
	end
end

function WaterTianYanClgMainView:_onClickReset()
	local text = "即将重置你的关卡进度，并恢复道具的使用次数\n已领取的奖励不可重复领取"

	local function okFunc()
		WaterTianYanAgent.instance:sendPM_WaterTianYanResetMainStageReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
end

function WaterTianYanClgMainView:_onClickPrev()
	if self._previewStageId == 1 then
		return
	end

	self._previewStageId = self._previewStageId - 1
	self._previewStageId = Mathf.Clamp(self._previewStageId, 1, self._maxStageNum)

	self:_updateStageInfo()
end

function WaterTianYanClgMainView:_onClickNext()
	if self._previewStageId == self._maxStageNum then
		return
	end

	self._previewStageId = self._previewStageId + 1
	self._previewStageId = Mathf.Clamp(self._previewStageId, 1, self._maxStageNum)

	self:_updateStageInfo()
end

function WaterTianYanClgMainView:_getBuffView()
	return WaterTianYanEnum.ViewNames[self._activityId][WaterTianYanEnum.ViewTypes_BuffView]
end

function WaterTianYanClgMainView:_onClickBuff(index)
	if self._previewStageId == self._curStageId then
		UIStateManager.instance:push(self:_getBuffView(), self._activityId, WaterTianYanModel.BuffViewMain, index, self._curStageId)
	elseif self._previewStageId < self._curStageId then
		FloatWordMgr.instance:show("已完成本关的挑战")
	else
		FloatWordMgr.instance:show("请完成上一关的挑战")
	end
end

function WaterTianYanClgMainView:_onResetMainStageRes()
	WaterTianYanController.instance:setBuffFlag()

	self._buffItemIds = {}
	self._buffItemIds[1] = WaterTianYanController.instance:getSelectBuff(self._activityId, self._curStageId, 1)
	self._buffItemIds[2] = WaterTianYanController.instance:getSelectBuff(self._activityId, self._curStageId, 2)

	self:_initStageId()
	self:_updateProgress()
	self:_updateStageInfo()
end

function WaterTianYanClgMainView:_onSetBuff(buffItemId)
	local cfgBuffItem = WaterTianYanConfig.instance:getBuffItemCfg(self._activityId, buffItemId)

	if cfgBuffItem then
		local buffType = Mathf.Clamp(cfgBuffItem.type, 1, 2)

		if self._buffItemIds[buffType] ~= buffItemId then
			FloatWordMgr.instance:show("设置成功")

			self._buffItemIds[buffType] = buffItemId

			WaterTianYanController.instance:saveSelectBuff(self._activityId, self._curStageId, buffType, buffItemId)

			local element = self._buffList[buffType]

			goutil.setActive(element.con, true)

			local level = WaterTianYanModel.instance:getBuffLevel(self._activityId, buffItemId)
			local cfgBuff = WaterTianYanConfig.instance:getBuffCfgByBuffItemId(self._activityId, buffItemId, level > 0 and level or 1)

			if cfgBuff then
				element.txtDesc.text = cfgBuff.desc

				uGuiUtil.setSpriteToImage(element.con, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfgBuff.buffIcon))
			end
		else
			FloatWordMgr.instance:show("已卸下此加成")

			self._buffItemIds[buffType] = nil

			WaterTianYanController.instance:saveSelectBuff(self._activityId, self._curStageId, buffType, 0)

			local element = self._buffList[buffType]

			goutil.setActive(element.con, false)

			element.txtDesc.text = "无加成"

			goutil.setActive(element.img, true)
			goutil.setActive(element.img2, false)
		end
	end
end

function WaterTianYanClgMainView:_clearBuffs()
	for i, v in ipairs(self._buffList) do
		uGuiUtil.clearImage(v.con)
		goutil.setActive(v.con, false)

		v.txtDesc.text = "无加成"

		goutil.setActive(v.img, true)
		goutil.setActive(v.img2, false)
	end
end

function WaterTianYanClgMainView:_updateCell(view, cell, data, tag)
	local node = goutil.findChild(cell, "node")
	local fPowerPet = FightingPowerPetMo.New()

	fPowerPet:fromChallengeCreepCo(data)

	local petMo = fPowerPet:toBaseBagPetMo()
	local proxy = MaterialMgr.setCellByMo(petMo, node)

	proxy.binder:setCallBack(function()
		CommonTipsMgr.instance:showPetTips(petMo)
	end)
end

function WaterTianYanClgMainView:_clearCell(cell)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.resetAll(node)
end

function WaterTianYanClgMainView:_initStageId()
	local passNum = WaterTianYanModel.instance:getMainStagePassId(self._activityId)

	self._curStageId = Mathf.Min(passNum + 1, self._maxStageNum)
	self._previewStageId = self._curStageId
end

function WaterTianYanClgMainView:_updateProgress()
	local curStage = self._curStageId

	self._txtBottom.text = "1层"
	self._txtTop.text = self._maxStageNum .. "层"
	self._txtCurLevel.text = string.format("第%s层", curStage)

	local percent = Mathf.Clamp01(curStage / self._maxStageNum)

	self._handleRect.anchoredPosition = Vector2.New(self._handleRect.anchoredPosition.x, self._fillHeight * percent)
	self._imgFill.fillAmount = percent

	local cfg = WaterTianYanConfig.instance:getMainStageCfg(self._activityId, self._curStageId)

	if cfg then
		MaterialMgr.setCellByCfg(cfg.passPrize, self._itemIcon)
	end
end

function WaterTianYanClgMainView:_clearProgress()
	MaterialMgr.resetAll(self._itemIcon)
end

function WaterTianYanClgMainView:_updateStageInfo()
	local cfg = WaterTianYanConfig.instance:getMainStageCfg(self._activityId, self._previewStageId)

	if cfg then
		self._txtDesc1.text = cfg.buffDesc

		local cfgMonster = WaterTianYanConfig.instance:getMonsterCfg(cfg.creepsMasterId)

		if cfgMonster then
			self._txtTitle.text = cfgMonster.name
			self._txtDesc2.text = cfgMonster.WinDesc
		end

		local cfgCreeps = WaterTianYanConfig.instance:getCreepsCfgs(cfg.creepsMasterId)

		self._scrollList:reloadData(cfgCreeps)
	end

	local isPassCurStage = WaterTianYanModel.instance:isPassMainStage(self._activityId, self._curStageId)

	goutil.setActive(self._btnChallenge.gameObject, self._previewStageId == self._curStageId and not isPassCurStage)
	goutil.setActive(self._passGo, self._previewStageId < self._curStageId or isPassCurStage)
	goutil.setActive(self._lockGo, self._previewStageId > self._curStageId)
	goutil.setActive(self._btnPrev.gameObject, self._previewStageId > 1)
	goutil.setActive(self._btnNext.gameObject, self._previewStageId < self._maxStageNum)
	self:_updateBuffInfo()
end

function WaterTianYanClgMainView:_updateBuffInfo()
	self:_clearBuffs()

	if self._previewStageId < self._curStageId then
		self:_updatePassedStageBuff(self._previewStageId)
	elseif self._previewStageId == self._curStageId then
		for i, buffItemId in pairs(self._buffItemIds) do
			self:_updateSingleBuff(buffItemId)
		end
	else
		self:_updateUnPassStageBuff()
	end
end

function WaterTianYanClgMainView:_updateUnPassStageBuff()
	for i, v in pairs(self._buffList) do
		goutil.setActive(v.img, false)
		goutil.setActive(v.img2, true)
	end
end

function WaterTianYanClgMainView:_updatePassedStageBuff(stageId)
	local buffItemIds = WaterTianYanModel.instance:getUsedBuffItemIdList(self._activityId, stageId)

	for i, buffItemId in ipairs(buffItemIds) do
		self:_updateSingleBuff(buffItemId)
	end
end

function WaterTianYanClgMainView:_updateSingleBuff(buffItemId)
	local cfgBuffItem = WaterTianYanConfig.instance:getBuffItemCfg(self._activityId, buffItemId)

	if cfgBuffItem then
		local buffType = Mathf.Clamp(cfgBuffItem.type, 1, 2)
		local element = self._buffList[buffType]
		local level = WaterTianYanModel.instance:getBuffLevel(self._activityId, buffItemId)

		goutil.setActive(element.con, true)

		local cfgBuff = WaterTianYanConfig.instance:getBuffCfgByBuffItemId(self._activityId, buffItemId, level)

		if cfgBuff then
			element.txtDesc.text = cfgBuff.desc

			uGuiUtil.setSpriteToImage(element.con, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfgBuff.buffIcon))
		end
	end
end

function WaterTianYanClgMainView:_showRoleModel()
	local curFaceId = self._raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._con, scale, nil, true, x, y)
end

function WaterTianYanClgMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

return WaterTianYanClgMainView
