-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlewinselectView.lua

module("logic.extensions.lotusbattle.view.LotusbattlewinselectView", package.seeall)

local LotusbattlewinselectView = class("LotusbattlewinselectView", TableViewComponent)

function LotusbattlewinselectView:ctor()
	LotusbattlewinselectView.super.ctor(self)

	self._petMos = {}
end

function LotusbattlewinselectView:unbindEvents()
	LotusbattlewinselectView.super.unbindEvents(self)
	self._btnCancel:RemoveClickListener()
	self._btnOk:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnGiveup:RemoveClickListener()
end

function LotusbattlewinselectView:bindEvents()
	LotusbattlewinselectView.super.bindEvents(self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
	self._btnOk:AddClickListener(self._onClickbtnOk, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnGiveup:AddClickListener(self._onClickbtnGiveup, self)
end

function LotusbattlewinselectView:buildUI()
	LotusbattlewinselectView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txtTime")
	self._txtBtnOk = self:getTxt("btns/btnOk/txt")
	self._txtBuffDest = self:getTxt("getbuff/txtDest")
	self._buffIconGo = self:getGo("getbuff/buffIcon")
	self._btnCancel = self:getBtn("btns/btnCancel")
	self._btnOk = self:getBtn("btns/btnOk")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._getbuffGo = self:getGo("getbuff")
	self._emptyGo = self:getGo("empty")
	self._btnGiveup = self:getBtn("btns/btnGiveup")
	self._btnsSingleLine = self:getGo("btns"):GetComponent(ComponentType.UILayoutSingleLine)
	self._txtTipsGo = self:getGo("txtTips")
	self._petsSingleLine = self:getGo("cellcon"):GetComponent(ComponentType.UILayoutSingleLine)
	self._ContentTr = self:getGo("tableview/Viewport/Content").transform
	self._txtDesc = self:getTxt("rule/txtDesc")
end

function LotusbattlewinselectView:onExit()
	LotusbattlewinselectView.super.onExit(self)
	GlobalDispatcher:removeListener(LotusBattleFieldAgent.LBFNotifySelectBattleSpoilsOverTimeRes, self._onTimeout, self)
	removetimer(self._tick, self)
end

function LotusbattlewinselectView:onEnter()
	LotusbattlewinselectView.super.onEnter(self)
	GlobalDispatcher:addListener(LotusBattleFieldAgent.LBFNotifySelectBattleSpoilsOverTimeRes, self._onTimeout, self)

	self._activityId = LotusbattleModel.instance:getActivityId()
	self._modelId = LotusbattleModel.instance:getModelId()

	local selectSpoilsTime = LotusbattleConfig.instance:getStageTime(self._activityId, "selectSpoilsTime")

	self._targetTickTime = ServerTime.now() + selectSpoilsTime
	self._selectCreepsId = 0
	self._battleMsg = LotusbattleModel.instance:getResultViewDatas()

	self:_updateUI()
	settimer(1, self._tick, self, true)
	self:_tick()
end

function LotusbattlewinselectView:_tick()
	local leftTime = self._targetTickTime - ServerTime.now()

	self._txtTime.text = string.format("倒计时:<color=#ffefd8>%s</color>秒", leftTime)

	if leftTime <= 0 then
		self:_onClickbtnGiveup()
		removetimer(self._tick, self)
	end
end

function LotusbattlewinselectView:_onTimeout()
	FloatWordMgr.instance:show("战利品选择超时")
end

function LotusbattlewinselectView:_onClickbtnCancel()
	local text = "是否确认放弃此次选择?"

	local function okFunc()
		LotusBattleFieldAgent.instance:sendPM_LBFSelectBattleSpoilsReq(-1)
	end

	TipsFacade.instance:openTipWindow("提示", text, okFunc)
end

function LotusbattlewinselectView:_onClickbtnOk()
	if self._selectCreepsId <= 0 then
		FloatWordMgr.instance:show("先选择战利品")

		return
	end

	LotusBattleFieldAgent.instance:sendPM_LBFSelectBattleSpoilsReq(self._selectCreepsId)
	self:close()
end

function LotusbattlewinselectView:_onClickbtnClose(giveUp)
	if giveUp then
		self:_onClickbtnCancel()
	end
end

function LotusbattlewinselectView:_onClickbtnGiveup()
	LotusBattleFieldAgent.instance:sendPM_LBFSelectBattleSpoilsReq(-1)
end

function LotusbattlewinselectView:_updateUI()
	self:_setBuff()
	self:_setPets()
	self:_setBtnOkTxt()
	self:_setWinDesc()
end

function LotusbattlewinselectView:_setBuff()
	local buffId = LotusbattleModel.instance:getResultOpBuffId()

	goutil.setActive(self._getbuffGo, buffId > 0)

	if buffId <= 0 then
		print("没有获取到对方buff")

		return
	end

	local buffCfg = LotusbattleConfig.instance:getBuffCfgByParams(self._activityId, self._modelId, buffId)

	self._txtBuffDest.text = string.format("已获取敌方[%s]祝福", buffCfg.name)

	local spriteName = GameUrl.getExpEventUrl(buffCfg.iconPath)

	uGuiUtil.setSpriteToImage(self._buffIconGo, nil, spriteName)
end

function LotusbattlewinselectView:_setPets()
	local bagPets = LotusbattleModel.instance:getBagPets()
	local bagPets_kv = {}

	for i, v in ipairs(bagPets) do
		bagPets_kv[v.petId] = true
	end

	local creepIds = LotusbattleModel.instance:getResultOpCreepIds()

	self._curViewDatas = {}

	for i, creepId in ipairs(creepIds) do
		if not bagPets_kv[creepId] then
			local cfg = LotusbattleConfig.instance:getCreepsCfg(creepId)

			table.insert(self._curViewDatas, cfg)
		end
	end

	local isEmpty = #self._curViewDatas <= 0

	goutil.setActive(self._emptyGo, isEmpty)
	goutil.setActive(self._btnOk.gameObject, not isEmpty)
	goutil.setActive(self._btnCancel.gameObject, not isEmpty)
	goutil.setActive(self._btnGiveup.gameObject, isEmpty)
	goutil.setActive(self._txtTipsGo, not isEmpty)
	self._btnsSingleLine:Layout()
	self:reloadData()
end

function LotusbattlewinselectView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function LotusbattlewinselectView:_updateCell(view, cell, creepsCfg)
	local btnDetail = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnDetail")
	local btnSelect = Framework.ButtonAdapter.Get(cell.gameObject)
	local goCon = goutil.findChild(cell.gameObject, "mask/con")
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "name/txtName")
	local goAttr = goutil.findChild(cell.gameObject, "attr/Img_attr")
	local attrIcon = goAttr:GetComponent("UIImageSpriteChange")
	local txtLevel = goutil.findChildTextComponent(cell.gameObject, "txtLvl")
	local imgChangeImgC_Job = goutil.findChild(cell.gameObject, "job/Nego_Job/ImgC_Job"):GetComponent(ComponentType.UIImageSpriteChange)
	local imgChangeImgC_Job1 = goutil.findChild(cell.gameObject, "job/Nego_Job1/ImgC_Job"):GetComponent(ComponentType.UIImageSpriteChange)
	local faceId = creepsCfg.raceId
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(faceId)
	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(faceId)

	imgChangeImgC_Job:SetState(firstJobIdx - 1)
	goutil.setActive(imgChangeImgC_Job1.gameObject, secondJobIdx > 20)

	if secondJobIdx > 20 then
		imgChangeImgC_Job1:SetState(secondJobIdx - 1 - 20)
	end

	local targetValue = LotusbattleController.instance:getAttrIconIndex(creepsCfg.raceId)

	attrIcon:SetState(targetValue)

	txtLevel.text = creepsCfg.lv
	txtName.text = creepsCfg.name

	goutil.setActive(goSelect, self._selectCreepsId == creepsCfg.creepsId)

	local modelCo = CharacterConfig.instance:getModelCo(creepsCfg.raceId)

	uGuiUtil.setSpriteToImage(goCon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	btnDetail:AddClickListener(function()
		local petMo = LotusbattleModel.instance:getPetMoByCreepsId(creepsCfg.creepsId)

		CommonTipsMgr.instance:showPetTips(petMo)
	end)
	btnSelect:AddClickListener(function()
		if self._selectCreepsId == creepsCfg.creepsId then
			return
		end

		self._selectCreepsId = creepsCfg.creepsId

		self:reloadData()
		self:_setBtnOkTxt()
	end)
end

function LotusbattlewinselectView:_clearTableview(cell)
	local goCon = goutil.findChild(cell.gameObject, "mask/con")

	uGuiUtil.clearImage(goCon)
end

function LotusbattlewinselectView:_setBtnOkTxt()
	local selectNum = self._selectCreepsId > 0 and 1 or 0

	self._txtBtnOk.text = string.format("确认(%s/%s)", selectNum, 1)
end

function LotusbattlewinselectView:_onReloadFinish()
	if self._curViewDatas and #self._curViewDatas <= 4 then
		for i = self._ContentTr.childCount, 1, -1 do
			self._ContentTr:GetChild(i - 1):SetParent(self._petsSingleLine.gameObject.transform)
		end

		self._petsSingleLine:Layout()
	end
end

function LotusbattlewinselectView:_setWinDesc()
	local modelCfg = LotusbattleConfig.instance:getModelCfg(self._activityId, self._modelId)
	local winBuffCfg = LotusbattleConfig.instance:getWinBuffCfg(modelCfg.winBuffPlanId, self._battleMsg.winStreak)

	if winBuffCfg then
		self._txtDesc.text = winBuffCfg.buffDesc
	end
end

return LotusbattlewinselectView
