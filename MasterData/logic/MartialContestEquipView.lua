-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestEquipView.lua

module("logic.extensions.martialcontest.view.MartialContestEquipView", package.seeall)

local MartialContestEquipView = class("MartialContestEquipView", ViewComponent)

function MartialContestEquipView:ctor()
	MartialContestEquipView.super.ctor(self)
end

function MartialContestEquipView:unbindEvents()
	MartialContestEquipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnUpgrade)
	GameUtil.rmClickHandler(self._btnTip)
end

function MartialContestEquipView:bindEvents()
	MartialContestEquipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnUpgrade, self._onClickUpgrade, self)
end

function MartialContestEquipView:buildUI()
	MartialContestEquipView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._eqiupTablecell = self:getGo("eqiupTablecell")
	self._equipTableview = self:getGo("equipTableview")
	self._equipTableList = ScrollerList.create(self._equipTableview, self._eqiupTablecell, GameUtil.handler(self._updateEquipCell, self), GameUtil.handler(self._clearEquipCell, self))
	self._maxLvInfo = self:getGo("maxLvInfo")
	self._upgradInfo = self:getGo("upgradInfo")
	self._txtNextDesc = self:getTxt("upgradInfo/txtNextDesc")
	self._txtUpgradeCurDesc = self:getTxt("upgradInfo/txtCurDesc")
	self._txtMaxCurDesc = self:getTxt("maxLvInfo/txtCurDesc")
	self._curEqiup = self:getGo("curEqiup")
	self._costCon = self:getGo("upgradInfo/costCon")
	self._txtCost = self:getTxt("upgradInfo/costCon/txtCost")
	self._btnUpgrade = self:getGo("upgradInfo/btnUpgrade")
	self._txtUpgrade = self:getTxt("upgradInfo/btnUpgrade/txt")
	self._goldBarCon = self:getGo("goldBar")
end

function MartialContestEquipView:onExit()
	MartialContestEquipView.super.onExit(self)
end

function MartialContestEquipView:onEnter()
	MartialContestEquipView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MCGetInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._equipList = {}

	local equipCfgs = MartialContestConfig.instance:getEquipTypeCfgs(self._activityId)

	for i, v in ipairs(equipCfgs or {}) do
		table.insert(self._equipList, v[1].equipId)
	end

	self._selectEquipId = self._equipList[1]
	self._activityCfg = MartialContestConfig.instance:getActivityCfg(self._activityId)

	MartialContestAgent.instance:sendPM_MCGetFinalsEquipInfoReq(self._activityId)
end

function MartialContestEquipView:_refreshView()
	local equipShowList = {}
	local equipMap = {}

	for i, v in ipairs(self._equipList) do
		local petId = MartialContestController.instance:getPetIdWithEquip(self._activityId, v)

		table.insert(equipShowList, v)

		equipMap[v] = petId
	end

	table.sort(equipShowList, function(a, b)
		local aEquip = checknumber(equipMap[a]) > 0
		local bEquip = checknumber(equipMap[b]) > 0

		if aEquip ~= bEquip then
			return aEquip
		end

		local aLv = MartialContestModel.instance:getEquipLevel(self._activityId, a)
		local bLv = MartialContestModel.instance:getEquipLevel(self._activityId, b)

		if aLv ~= bLv then
			return bLv < aLv
		end

		return a < b
	end)
	self._equipTableList:reloadData(equipShowList)

	local selectEquipLv = MartialContestModel.instance:getEquipLevel(self._activityId, self._selectEquipId)

	self:_setEquipItem(self._curEqiup, self._selectEquipId, selectEquipLv)

	local curEquipCfg = MartialContestConfig.instance:getEquipCfg(self._activityId, self._selectEquipId, selectEquipLv)

	if curEquipCfg then
		self._txtUpgradeCurDesc.text = curEquipCfg.desc
		self._txtMaxCurDesc.text = curEquipCfg.desc
	else
		self._txtUpgradeCurDesc.text = lang("无")
		self._txtMaxCurDesc.text = lang("无")
	end

	local nextEquipCfg = MartialContestConfig.instance:getEquipCfg(self._activityId, self._selectEquipId, selectEquipLv + 1)

	if nextEquipCfg then
		self._txtNextDesc.text = nextEquipCfg.desc

		local matType, matId, matNum = MaterialMgr.getMatParams(nextEquipCfg.cost)
		local getMyMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

		MaterialMgr.setIcon(self._costCon, matType, matId)

		self._txtCost.text = string.format("<color=%s>%d</color>", matNum <= getMyMatNum and "#5EFF1EFF" or "#FF1E2CFF", matNum)
		self._txtUpgrade.text = selectEquipLv > 0 and lang("升级") or lang("激活")
	end

	GameUtil.SetActive(self._upgradInfo, nextEquipCfg ~= nil)
	GameUtil.SetActive(self._maxLvInfo, nextEquipCfg == nil)
	self:_setTopGoldBar()
end

function MartialContestEquipView:_updateEquipCell(view, cell, data, tag)
	local go = cell.gameObject
	local selectGo = goutil.findChild(go, "select")
	local redpoint = goutil.findChild(go, "redpoint")
	local level = MartialContestModel.instance:getEquipLevel(self._activityId, data)

	self:_setEquipItem(go, data, level)
	GameUtil.SetActive(selectGo, data == self._selectEquipId)
	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickEquip(data)
	end)

	local isEnough = false
	local nextEquipCfg = MartialContestConfig.instance:getEquipCfg(self._activityId, data, level + 1)

	if nextEquipCfg then
		local matType, matId, matNum = MaterialMgr.getMatParams(nextEquipCfg.cost)

		isEnough = MaterialModel.instance:IsEnough(matType, matId, matNum)
	end

	GameUtil.SetActive(redpoint, isEnough)
end

function MartialContestEquipView:_clearEquipCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
	self:_clearEquipItem(go)
end

function MartialContestEquipView:_setEquipItem(go, equipId, lv)
	local lvGo = goutil.findChild(go, "lv")
	local txtLv = goutil.findChildTextComponent(go, "lv/txt")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local icon = goutil.findChild(go, "con")
	local equipPetGo = goutil.findChild(go, "petIconGo")
	local equipPetCon = goutil.findChild(equipPetGo, "petIcon")

	GameUtil.SetActive(lvGo, lv ~= 0)

	if lv == 0 then
		lv = 1
	end

	local equipCfg = MartialContestConfig.instance:getEquipCfg(self._activityId, equipId, lv)

	txtName.text = equipCfg.name
	txtLv.text = string.format("Lv.%d", lv)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(equipCfg.icon))
	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		if not self._drag then
			MartialContestController.instance:openEquipTips(icon, self._activityId, equipId, lv)
		end
	end, self)

	local petId = MartialContestController.instance:getPetIdWithEquip(self._activityId, equipId)

	if checknumber(petId) > 0 then
		local petMo = BagPetsController.instance:getPet(petId)

		if petMo then
			MaterialMgr.setIcon(equipPetCon, MatType.PET_SKIN, petMo.curFaceId)
			GameUtil.SetActive(equipPetGo, true)
		else
			GameUtil.SetActive(equipPetGo, false)
			MaterialMgr.resetAll(equipPetCon)
		end
	else
		GameUtil.SetActive(equipPetGo, false)
		MaterialMgr.resetAll(equipPetCon)
	end
end

function MartialContestEquipView:_clearEquipItem(go)
	local icon = goutil.findChild(go, "con")
	local equipPetGo = goutil.findChild(go, "petIconGo")
	local equipPetCon = goutil.findChild(equipPetGo, "petIcon")

	MaterialMgr.resetAll(equipPetCon)
	uGuiUtil.clearImage(icon)
end

function MartialContestEquipView:_setTopGoldBar()
	local btn_list = {}
	local curEquipCfg = MartialContestConfig.instance:getEquipCfg(self._activityId, self._selectEquipId, 1)
	local itemArry = string.split(self._activityCfg.costItem, "#")

	for i, v in ipairs(itemArry) do
		table.insert(btn_list, {
			showAdd = false,
			id = v
		})
	end

	table.insert(btn_list, {
		showAdd = false,
		id = curEquipCfg.cost
	})
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function MartialContestEquipView:_onClickUpgrade()
	local selectEquipLv = MartialContestModel.instance:getEquipLevel(self._activityId, self._selectEquipId)
	local nextEquipCfg = MartialContestConfig.instance:getEquipCfg(self._activityId, self._selectEquipId, selectEquipLv + 1)

	if nextEquipCfg then
		local matType, matId, matNum = MaterialMgr.getMatParams(nextEquipCfg.cost)
		local getMyMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

		if matNum <= getMyMatNum then
			MartialContestAgent.instance:sendPM_MCUpgradeFinalsEquipReq(self._activityId, self._selectEquipId)
		else
			TipsFacade.instance:openItemSourceView(nextEquipCfg.cost)
		end
	else
		FloatWordMgr.instance:show(lang("已满级"))
	end
end

function MartialContestEquipView:_onClickEquip(equipId)
	self._selectEquipId = equipId

	self:_refreshView()
end

function MartialContestEquipView:_onClickTip()
	TipsFacade.instance:openRulesView("martial_contest_clg_rule")
end

return MartialContestEquipView
