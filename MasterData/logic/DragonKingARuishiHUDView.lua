-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishihud/view/DragonKingARuishiHUDView.lua

module("logic.extensions.dragonkingaruishihud.view.DragonKingARuishiHUDView", package.seeall)

local DragonKingARuishiHUDView = class("DragonKingARuishiHUDView", ActivityGrandSummaryView)

function DragonKingARuishiHUDView:ctor()
	DragonKingARuishiHUDView.super.ctor(self)
end

function DragonKingARuishiHUDView:unbindEvents()
	DragonKingARuishiHUDView.super.unbindEvents(self)

	for i, cell in ipairs(self._buffList) do
		GameUtil.rmClickHandler(cell.btn)
	end

	GameUtil.rmClickHandler(self._btnTip)
end

function DragonKingARuishiHUDView:bindEvents()
	DragonKingARuishiHUDView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)

	for i, cell in ipairs(self._buffList) do
		GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickBuff, self, i))
	end
end

function DragonKingARuishiHUDView:buildUI()
	DragonKingARuishiHUDView.super.buildUI(self)

	self._buffList = {}

	for i = 1, 2 do
		local cell = {}

		cell.go = self:getGo("buffCon/buff" .. i)
		cell.txtDesc = goutil.findChildTextComponent(cell.go, "txtDesc")
		cell.btn = goutil.findChild(cell.go, "btnGain")
		cell.eff = goutil.findChild(cell.go, "eff")
		cell.txtCurProgress = goutil.findChildTextComponent(cell.go, "curProgress/txt")

		table.insert(self._buffList, cell)
	end

	self._con = goutil.findChild(self.mainGO, "con")
	self._goldBarCon = self:getGo("goldcon")
	self._btnTip = goutil.findChild(self.mainGO, "btnTips")
end

function DragonKingARuishiHUDView:onExit()
	DragonKingARuishiHUDView.super.onExit(self)

	if self._bianBaiEff then
		UIEffectManager.instance:stopEffect(self._bianBaiEff)
	end

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end
end

function DragonKingARuishiHUDView:onEnter()
	DragonKingARuishiHUDView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DragonDishitianGetInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.DragonDishitianChargeBuffRes, self._handleChange, self)

	self._addActivityId = 343002

	if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._addActivityId) then
		DragonDishitianAgent.instance:sendPM_DragonDishitianGetInfoReq(self._addActivityId)
	else
		for i, buffCell in ipairs(self._buffList) do
			goutil.setActive(buffCell.go, false)
		end
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
end

function DragonKingARuishiHUDView:_getSumActivityId()
	return 17163
end

function DragonKingARuishiHUDView:_updateUIByCfg()
	self._buffTypeCfgs = DragonDishitianConfig.instance:getBuffTypeCfgs(self._addActivityId) or {}
	self._curSkinId = 14036

	local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("display", self._curSkinId)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._curSkinId, self._con, displayBagOffset[3], nil, true, displayBagOffset[1], displayBagOffset[2])

	if self._buffTypeCfgs[1] then
		if not self._buffTypeCfgs[1].itemId then
			local firstItemId = 1

			if self._buffTypeCfgs[2] then
				if not self._buffTypeCfgs[2].itemId then
					local secondItemId = 1
					local btn_list = {
						{
							showAdd = false,
							id = MatType.ACTIVITY_ITEM .. ":" .. firstItemId
						},
						{
							showAdd = false,
							id = MatType.ACTIVITY_ITEM .. ":" .. secondItemId
						}
					}

					MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
				end
			end
		end
	end
end

function DragonKingARuishiHUDView:_updateUIByInfo()
	for i, buffCell in ipairs(self._buffList) do
		local buffTypeCfg = self._buffTypeCfgs[i]

		if buffTypeCfg then
			local info = DragonDishitianModel.instance:getBuffInfo(self._addActivityId, i)
			local curLv = 0
			local cfg = DragonDishitianConfig.instance:getBuffCfgByprogress(self._addActivityId, i, (info or nil) and info.progress)
			local nextCfg

			if cfg then
				buffCell.txtDesc.text = cfg.buffdesc
				curLv = cfg.level
			else
				nextCfg = DragonDishitianConfig.instance:getBuffCfg(self._addActivityId, i, 1)
				buffCell.txtDesc.text = string.format("进度达到%s后可激活", nextCfg.progress)
			end

			local buffTypeCfg = self._buffTypeCfgs[i]
			local count = MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, buffTypeCfg.itemId)

			nextCfg = DragonDishitianConfig.instance:getBuffCfg(self._addActivityId, i, curLv + 1)
			buffCell.txtCurProgress.text = nextCfg and string.format("%d/%d", count, nextCfg.progress) or "已满级"

			goutil.setActive(buffCell.go, true)
		else
			goutil.setActive(buffCell.go, false)
		end
	end
end

function DragonKingARuishiHUDView:_handleChange()
	TipsFacade.instance:openCommonTips("充能成功")

	local effParent = self.mainGO

	if self._lastBuffType then
		local buffCell = self._buffList[self._lastBuffType]

		if buffCell and buffCell.eff then
			effParent = buffCell.eff
		end
	end

	local path = "20230825/yonghengguodu/fx_ui_yonghengguodu_shu.prefab"

	if self._bianBaiEff then
		UIEffectManager.instance:stopEffect(self._bianBaiEff)
	end

	local function loadedHandler(handlerTarget, eff)
		eff:setParent(effParent.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1, 1, 1)

		eff.hideEffWhileNotOnTop = true
	end

	self._bianBaiEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, false, false, nil, loadedHandler, nil)

	self:_updateUIByInfo()
end

function DragonKingARuishiHUDView:_onClickBuff(buffType)
	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._addActivityId) then
		TipsFacade.instance:openCommonTips("不在buff活动时间")

		return
	end

	local progress = 0
	local info = DragonDishitianModel.instance:getBuffInfo(self._addActivityId, buffType)

	if info then
		progress = info.progress
	end

	local cfg = DragonDishitianConfig.instance:getBuffCfgByprogress(self._addActivityId, buffType, progress)

	if not DragonDishitianConfig.instance:getBuffCfg(self._addActivityId, buffType, ((cfg or nil) and cfg.level) + 1) then
		TipsFacade.instance:openCommonTips("该buff已满级")

		return
	end

	local buffTypeCfg = self._buffTypeCfgs[buffType]

	if buffTypeCfg then
		local count = MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, buffTypeCfg.itemId)

		if count > 0 and progress < count then
			DragonDishitianAgent.instance:sendPM_DragonDishitianChargeReq(self._addActivityId, buffType, count)

			self._lastBuffType = buffType
		else
			local matName = MaterialModel.instance:getMaterialsName(MatType.ACTIVITY_ITEM, buffTypeCfg.itemId)

			TipsFacade.instance:openCommonTips(string.format("%s数量不足", matName))
		end
	else
		TipsFacade.instance:openCommonTips("配置不存在")
	end
end

function DragonKingARuishiHUDView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("dragonaruisimainview_rule")
end

return DragonKingARuishiHUDView
