-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neverland/view/NeverLandBuffView.lua

module("logic.extensions.neverland.view.NeverLandBuffView", package.seeall)

local NeverLandBuffView = class("NeverLandBuffView", ViewComponent)

function NeverLandBuffView:ctor()
	NeverLandBuffView.super.ctor(self)
end

function NeverLandBuffView:unbindEvents()
	NeverLandBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnLevelUp)
end

function NeverLandBuffView:bindEvents()
	NeverLandBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnLevelUp, self._onClickLevelUp, self)
end

function NeverLandBuffView:buildUI()
	NeverLandBuffView.super.buildUI(self)

	self._cell = self:getGo("cell")
	self._container = self:getGo("container")
	self._goldBar = self:getGo("goldBarCon")
	self._max = self:getGo("detail/max")
	self._matCost = self:getGo("detail/matCost")
	self._buff = self:getGo("detail/info/buff")
	self._lock = self:getGo("detail/info/lock")
	self._activated = self:getGo("detail/activated")
	self._txtTip = self:getTxt("detail/info/txtTip")
	self._txtName = self:getTxt("detail/info/txtName")
	self._txtLevelUp = self:getTxt("detail/matCost/btnLevelUp/txt")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnReset = self:getBtn("detail/matCost/btnReset")
	self._btnLevelUp = self:getBtn("detail/matCost/btnLevelUp")
	self._containerPlan = self._container:GetComponent(typeof(TestRecordPos))
	self._itemCells = {}

	for i = 1, 3 do
		cell = {}
		cell.go = self:getGo("detail/matCost/mat/item_" .. i)
		cell.item = goutil.findChild(cell.go, "con")
		cell.txt = goutil.findChildTextComponent(cell.go, "txtNum")

		table.insert(self._itemCells, cell)
	end
end

function NeverLandBuffView:onExit()
	NeverLandBuffView.super.onExit(self)
	uGuiUtil.clearImage(self._buff)

	for _, v in ipairs(self._itemCells) do
		MaterialMgr.resetAll(v.item)
	end

	for _, buff in ipairs(self._buffCells) do
		uGuiUtil.clearImage(buff.icon)
		goutil.destroy(buff.go, true)
	end
end

function NeverLandBuffView:onEnter()
	NeverLandBuffView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.NeverLand)

	self.addGEvent(self, GlobalNotify.NeverLandInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.NeverLandUpgradeBuffLvRes, self._sendGetInfoReq, self)
	self:_sendGetInfoReq()

	self._buffCfg = NeverLandConfig.instance:getBuffCfg(self._activityId)
	self._actCfg = NeverLandConfig.instance:getActCfg(self._activityId)

	local name = self._actCfg.buff_res
	local cellList = {
		{
			showAdd = false,
			id = name
		}
	}

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, cellList)

	self._selectBuffId = 1

	self:initBuff()
end

function NeverLandBuffView:_sendGetInfoReq()
	NeverLandController.instance:sendPM_NeverLandInfoReq(self._activityId)
end

function NeverLandBuffView:initBuff()
	self._buffCells = {}

	for i = 1, #self._buffCfg do
		local buff = {}

		buff.go = goutil.cloneAndSetParent(self._cell, self._container.transform, "cell" .. i)
		buff.icon = goutil.findChild(buff.go, "buff")
		buff.select = goutil.findChild(buff.go, "select")
		buff.lock = goutil.findChild(buff.go, "lock")
		buff.txtName = goutil.findChildTextComponent(buff.go, "name/txtName")

		table.insert(self._buffCells, buff)
		GameUtil.addClickHandler(buff.go, GameUtil.handler(self._onClickBuff, self, i))
	end
end

function NeverLandBuffView:_refreshBuff()
	for buffId, buff in ipairs(self._buffCells) do
		local level = NeverLandModel.instance:getBuffLevel(buffId)
		local cfg = level <= 0 and NeverLandConfig.instance:getBuffCfgById(self._activityId, buffId, 1) or NeverLandConfig.instance:getBuffCfgById(self._activityId, buffId, level)

		uGuiUtil.setSpriteToImage(buff.icon, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("expevents", cfg.icon))
		GameUtil.SetActive(buff.lock, level <= 0)
		GameUtil.SetActive(buff.select, buffId == self._selectBuffId)

		buff.txtName.text = cfg.name
	end
end

function NeverLandBuffView:_refreshDetailInfo()
	local level = NeverLandModel.instance:getBuffLevel(self._selectBuffId)
	local isMax = NeverLandController.instance:isBuffMaxLevel(self._activityId, self._selectBuffId, level)

	GameUtil.SetActive(self._max, isMax)
	GameUtil.SetActive(self._matCost, not isMax)

	if level <= 0 then
		cfg = NeverLandConfig.instance:getBuffCfgById(self._activityId, self._selectBuffId, level + 1)
		self._txtLevelUp.text = "激活"
	elseif isMax then
		cfg = NeverLandConfig.instance:getBuffCfgById(self._activityId, self._selectBuffId, level)
		self._txtLevelUp.text = "已满级"
	else
		cfg = NeverLandConfig.instance:getBuffCfgById(self._activityId, self._selectBuffId, level)
		self._txtLevelUp.text = "升级"
	end

	self._txtName.text = cfg.name
	self._txtTip.text = cfg.describ

	uGuiUtil.setSpriteToImage(self._buff, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("expevents", cfg.icon))

	if not isMax then
		local upCfg = NeverLandConfig.instance:getBuffCfgById(self._activityId, self._selectBuffId, level + 1)
		local upgradeCost = string.split(upCfg.upgradeCost, "#")

		for i, v in ipairs(self._itemCells) do
			MaterialMgr.resetAll(v.item)

			if upgradeCost[i] then
				GameUtil.SetActive(v.go, true)

				local proxy = MaterialMgr.setCellByCfg(upgradeCost[i], v.item)
				local matType, matId, matNum = MaterialMgr.getMatParams(upgradeCost[i])
				local hasNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

				proxy.binder:setNumStr("")
				proxy.binder:setAutoTips(false)
				proxy:setCallBack(function()
					if hasNum < matNum then
						MaterialMgr.openGetSource(matType, matId)
					else
						CommonTipsMgr.instance:openMaterialTips(v.item, matType, matId, 0)
					end
				end)

				local color = matNum <= hasNum and "20b376" or "eb4642"

				self._itemCells[i].txt.text = string.format("<color=#%s>%s</color>/%s", color, hasNum, matNum)
			else
				GameUtil.SetActive(v.go, false)
			end
		end
	end
end

function NeverLandBuffView:_refresh()
	self:_refreshBuff()
	self:_refreshDetailInfo()
	self._containerPlan:LoadPlan(0)
end

function NeverLandBuffView:_onClickTip()
	TipsFacade.instance:openRulesView("neverland_buff_rule")
end

function NeverLandBuffView:_onClickBuff(buffId)
	self._selectBuffId = buffId

	self:_refreshBuff()
	self:_refreshDetailInfo()
end

function NeverLandBuffView:_onClickLevelUp()
	local level = NeverLandModel.instance:getBuffLevel(self._selectBuffId)

	if NeverLandController.instance:isBuffMaxLevel(self._activityId, self._selectBuffId, level) then
		FloatWordMgr.instance:show("当前buff已满级~")

		return
	end

	NeverLandController.instance:sendPM_NeverLandUpgradeBuffLvReq(self._activityId, self._selectBuffId)
end

return NeverLandBuffView
