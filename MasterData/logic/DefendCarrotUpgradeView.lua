-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/view/DefendCarrotUpgradeView.lua

module("logic.extensions.defendcarrot.view.DefendCarrotUpgradeView", package.seeall)

local DefendCarrotUpgradeView = class("DefendCarrotUpgradeView", ViewComponent)

function DefendCarrotUpgradeView:ctor()
	DefendCarrotUpgradeView.super.ctor(self)
end

function DefendCarrotUpgradeView:unbindEvents()
	DefendCarrotUpgradeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DefendCarrotUpgradeView:bindEvents()
	DefendCarrotUpgradeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DefendCarrotUpgradeView:buildUI()
	DefendCarrotUpgradeView.super.buildUI(self)

	self._btnClose = self:getGo("topLeft/btnClose")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tableview/tablecell")
	self._tableview = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._descCell = self:getGo("descCell")

	goutil.setActive(self._descCell, false)

	self._goldBarCon = self:getGo("goldcon")
end

function DefendCarrotUpgradeView:onExit()
	DefendCarrotUpgradeView.super.onExit(self)

	for i, v in pairs(self._subTableViewDic) do
		v:dispose()
	end

	self._subTableViewDic = nil

	self._tableview:dispose()
end

function DefendCarrotUpgradeView:onEnter()
	DefendCarrotUpgradeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DefendCarrotUpgradeWeapon, self._updateUIByInfo, self)

	self._subTableViewDic = {}
	self._curActivityId = 0

	local params = self:getOpenParam()

	if params then
		self._curActivityId = checknumber(params[1])
	end

	if self._curActivityId <= 0 then
		self._curActivityId = 517001
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
end

function DefendCarrotUpgradeView:_updateUIByCfg()
	self._curActCfg = DefendCarrotConfig.instance:getActivityCfg(self._curActivityId) or {}
	self._weaponCfgs = DefendCarrotConfig.instance:getAllWeaponCfgs(self._curActivityId) or {}

	local btn_list = {
		{
			showAdd = false,
			id = self._curActCfg.costItem
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function DefendCarrotUpgradeView:_updateUIByInfo()
	self._curMaxStageId = 0

	local baseInfo = DefendCarrotModel.instance:getBaseInfo(self._curActivityId)

	if baseInfo then
		if not baseInfo.stages then
			do
				local stages = {}

				self._curMaxStageId = #stages
			end

			local datalist = {}

			for i, cfg in ipairs(self._weaponCfgs) do
				table.insert(datalist, cfg)
			end

			ArraySort.sortOn(datalist, {
				function(data)
					local weaponId = data.weaponId
					local weaponCurLv = DefendCarrotModel.instance:getWeaponLevel(self._curActivityId, weaponId)
					local weaponCfg = DefendCarrotConfig.instance:getWeaponCfg(self._curActivityId, weaponId)
					local unlockStageId = weaponCfg.unlockStageId
					local isLvMax = not DefendCarrotConfig.instance:getWeaponLevelCfgByWeapon(self._curActivityId, weaponId, weaponCurLv + 1)

					if isLvMax then
						return 0
					elseif unlockStageId > self._curMaxStageId then
						return 1
					else
						return 2
					end
				end,
				function(data)
					return data.weaponId
				end
			}, {
				ArraySort.DESCENDING,
				ArraySort.NUMERIC
			})
			self._tableview:reloadData(datalist)
		end
	end
end

function DefendCarrotUpgradeView:_updateCell(view, cell, data)
	local weaponId = data.weaponId
	local weaponDes = data.weaponDes

	if not data.unlockStageId then
		local unlockStageId = 0
		local weaponCurLv = DefendCarrotModel.instance:getWeaponLevel(self._curActivityId, weaponId)
		local curLvCfg = DefendCarrotConfig.instance:getWeaponLevelCfgByWeapon(self._curActivityId, weaponId, weaponCurLv)
		local nextLvCfg = DefendCarrotConfig.instance:getWeaponLevelCfgByWeapon(self._curActivityId, weaponId, weaponCurLv + 1)
		local isLvMax = nextLvCfg == nil
		local go = cell.gameObject
		local txtDesc = goutil.findChildTextComponent(go, "showDesc/Viewport/txt")
		local txtLvBefore = goutil.findChildTextComponent(go, "desc/txtLvBefore")
		local txtLvAfter = goutil.findChildTextComponent(go, "desc/txtLvAfter")
		local cost = goutil.findChild(go, "cost")
		local txtCost = goutil.findChildTextComponent(cost, "txtNum")
		local iconCost = goutil.findChild(cost, "icon")
		local isLock = unlockStageId > self._curMaxStageId
		local btnUpGrade = goutil.findChild(go, "btnUpgrade")
		local txtTips = goutil.findChildTextComponent(go, "txtTips")
		local txtTips2 = goutil.findChildTextComponent(go, "txtTips2")
		local effPos = goutil.findChild(go, "effPos")

		self:_clearCellEffect(effPos)

		txtDesc.text = weaponDes

		GameUtil.setAnchoredPos(txtDesc.gameObject, 0, 0)
		GameUtil.addClickHandler(btnUpGrade, GameUtil.handler(self._onClickUpgrade, self, data, effPos), self)

		if isLvMax then
			txtLvBefore.text = string.format("等级%d", weaponCurLv)
			txtLvAfter.text = ""

			goutil.setActive(cost, false)
			goutil.setActive(btnUpGrade, false)

			txtTips2.text = "已满级"
		else
			txtLvBefore.text = string.format("等级%d", weaponCurLv)
			txtLvAfter.text = string.format("等级%d", weaponCurLv + 1)

			goutil.setActive(cost, true)
		end

		if not nextLvCfg.cost then
			do
				local costStr = ""
				local costType, costId, costNum = MaterialMgr.getMatParams(costStr)

				txtCost.text = string.format("%d", costNum)

				MaterialMgr.setIcon(iconCost, costType, costId)
				GameUtil.SetGray(btnUpGrade, isLock)
				goutil.setActive(btnUpGrade, true)

				txtTips2.text = ""
			end

			if isLock then
				txtTips.text = string.format("守护关卡达到%d关后可升级", unlockStageId)

				goutil.setActive(cost, false)

				goto label_11_1
			end
		end

		txtTips.text = ""

		::label_11_1::

		local showCfgs = DefendCarrotConfig.instance:getWeaponShowCfgs(curLvCfg.descPlanId) or {}
		local subDataList = {}

		for i, cfg in ipairs(showCfgs) do
			local showData = {}

			showData.cfg = cfg
			showData.weaponId = weaponId
			showData.weaponCurLv = weaponCurLv

			table.insert(subDataList, showData)
		end

		local subTableViewGo = goutil.findChild(go, "desc/tableview")

		if subTableViewGo and self._descCell then
			if not self._subTableViewDic[cell] then
				do
					local subTableView = ScrollerList.create(subTableViewGo, self._descCell, GameUtil.handler(self._updateSubCell, self), GameUtil.handler(self._clearSubCell, self))

					self._subTableViewDic[cell] = subTableView

					subTableView:reloadData(subDataList)
					subTableView:MoveCellToBegin(0)
					subTableView:dragNotifyParent()
				end

				local icon = goutil.findChildComponent(go, "weaponicon", "UIImageSpriteChange")
				local imageIcon = icon:GetComponent(goutil.Type_UIImage)

				icon:ChangeSprite(data.weaponPic)
				imageIcon:SetNativeSize()
			end
		end
	end
end

function DefendCarrotUpgradeView:_clearCell(cell)
	local go = cell.gameObject
	local iconCost = goutil.findChild(go, "cost/icon")
	local btnUpGrade = goutil.findChild(go, "btnUpgrade")
	local effPos = goutil.findChild(go, "effPos")

	GameUtil.rmClickHandler(btnUpGrade)
	MaterialMgr.resetAll(iconCost)
	self:_clearCellEffect(effPos)
end

function DefendCarrotUpgradeView:_onClickUpgrade(data, effGo)
	local weaponId = data.weaponId

	if not data.unlockStageId then
		local unlockStageId = 0
		local weaponCurLv = DefendCarrotModel.instance:getWeaponLevel(self._curActivityId, weaponId)
		local nextLvCfg = DefendCarrotConfig.instance:getWeaponLevelCfgByWeapon(self._curActivityId, weaponId, weaponCurLv + 1)
		local isLvMax = nextLvCfg == nil

		if isLvMax then
			TipsFacade.instance:openCommonTips("当前已达到最大等级")

			return
		end

		if unlockStageId > self._curMaxStageId then
			TipsFacade.instance:openCommonTips(string.format("需通关第%d关解锁", unlockStageId))

			return
		end

		if not nextLvCfg.cost then
			local costStr = ""

			if not MaterialMgr.getMatEnough(costStr) then
				TipsFacade.instance:openCommonTips("材料不足，无法升级")

				return
			end

			DefendCarrotController.instance:upgradeWeapon(self._curActivityId, weaponId)
		end
	end
end

function DefendCarrotUpgradeView:_updateSubCell(view, cell, data)
	local go = cell.gameObject
	local bg = goutil.findChild(go, "bg")
	local cfg = data.cfg
	local txtShowDesc = goutil.findChildTextComponent(go, "txtShowDesc")
	local txtBefore = goutil.findChildTextComponent(go, "txtBefore")
	local txtAfter = goutil.findChildTextComponent(go, "txtAfter")

	txtShowDesc.text = cfg.showDesc or ""
	txtBefore.text = cfg.beforeDesc or ""
	txtAfter.text = cfg.afterDesc or ""

	goutil.setActive(bg, cfg.sortId % 2 == 0)

	if not cfg.overwriteType then
		local overwriteType = ""

		if not GameUtil.isEmptyString(overwriteType) then
			local weaponId = data.weaponId
			local weaponCurLv = data.weaponCurLv
			local curLvCfg = DefendCarrotConfig.instance:getWeaponLevelCfgByWeapon(self._curActivityId, weaponId, weaponCurLv)
			local nextLvCfg = DefendCarrotConfig.instance:getWeaponLevelCfgByWeapon(self._curActivityId, weaponId, weaponCurLv + 1)

			if curLvCfg then
				txtBefore.text = curLvCfg[overwriteType] or txtBefore.text
			end

			if nextLvCfg then
				txtAfter.text = nextLvCfg[overwriteType] or txtAfter.text
			end
		end
	end
end

function DefendCarrotUpgradeView:_clearSubCell(cell)
	return
end

function DefendCarrotUpgradeView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

return DefendCarrotUpgradeView
