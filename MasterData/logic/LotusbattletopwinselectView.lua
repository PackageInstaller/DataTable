-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattletopwinselectView.lua

module("logic.extensions.lotusbattle.view.LotusbattletopwinselectView", package.seeall)

local LotusbattletopwinselectView = class("LotusbattletopwinselectView", TableViewComponent)

function LotusbattletopwinselectView:ctor()
	LotusbattletopwinselectView.super.ctor(self)

	self._petMos = {}
end

function LotusbattletopwinselectView:unbindEvents()
	LotusbattletopwinselectView.super.unbindEvents(self)
	self._btnCancel:RemoveClickListener()
	self._btnOk:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function LotusbattletopwinselectView:bindEvents()
	LotusbattletopwinselectView.super.bindEvents(self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
	self._btnOk:AddClickListener(self._onClickbtnOk, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function LotusbattletopwinselectView:buildUI()
	LotusbattletopwinselectView.super.buildUI(self)

	self._txtBtnOk = self:getTxt("btnOk/txt")
	self._btnCancel = self:getBtn("btnCancel")
	self._btnOk = self:getBtn("btnOk")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._imgNum = self:getGo("winDesc/imgNum"):GetComponent(ComponentType.UIImgNumeralText)
	self._txtPetNum = self:getTxt("winDesc/txtPetNum")
end

function LotusbattletopwinselectView:onExit()
	LotusbattletopwinselectView.super.onExit(self)
	LotusbattleController.instance:closeTopWinSelectPetView()
end

function LotusbattletopwinselectView:onEnter()
	LotusbattletopwinselectView.super.onEnter(self)

	self._activityId = LotusbattleModel.instance:getActivityId()
	self._modelId = LotusbattleModel.instance:getModelId()

	local modelCfg = LotusbattleConfig.instance:getModelCfg(self._activityId, self._modelId)
	local rank = LotusbattleModel.instance:getTopWinRank()

	self._maxSelectNum = LotusbattleConfig.instance:getSpoilsNumByRank(self._activityId, self._modelId, rank)
	self._txtPetNum.text = string.format("队伍中带出%s只精灵", self._maxSelectNum)
	self._battleMsg = LotusbattleModel.instance:getResultViewDatas()
	self._selectCreepsIds = {}

	self:_updateUI()
end

function LotusbattletopwinselectView:_onClickbtnCancel()
	local text = "是否确认放弃此次选择?"

	local function okFunc()
		self:_onClickbtnClose()
	end

	TipsFacade.instance:openTipWindow("提示", text, okFunc)
end

function LotusbattletopwinselectView:_onClickbtnOk()
	local selectNum = self:_getSelectNum()

	if selectNum < 1 then
		FloatWordMgr.instance:show("需要选择精灵")

		return
	end

	local creepsIds = {}

	for id, _ in pairs(self._selectCreepsIds) do
		table.insert(creepsIds, id)
	end

	if #creepsIds > 0 then
		LotusBattleFieldAgent.instance:sendPM_LBFSelectSpoilsReq(self._activityId, creepsIds)
		self:_onClickbtnClose()
	end
end

function LotusbattletopwinselectView:_onClickbtnClose()
	self:close()
end

function LotusbattletopwinselectView:_updateUI()
	self:_setRank()
	self:_setPets()
	self:_setBtnOkTxt()
end

function LotusbattletopwinselectView:_setPets()
	local creepIds = LotusbattleModel.instance:getTopWinCreepsIds()

	self._curViewDatas = {}

	for i, creepId in ipairs(creepIds) do
		local cfg = LotusbattleConfig.instance:getCreepsCfg(creepId)

		table.insert(self._curViewDatas, cfg)
	end

	self:reloadData()
end

function LotusbattletopwinselectView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function LotusbattletopwinselectView:_updateCell(view, cell, creepsCfg)
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

	goutil.setActive(goSelect, self._selectCreepsIds[creepsCfg.creepsId])

	local modelCo = CharacterConfig.instance:getModelCo(creepsCfg.raceId)

	uGuiUtil.setSpriteToImage(goCon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	btnDetail:AddClickListener(function()
		local petMo = LotusbattleModel.instance:getPetMoByCreepsId(creepsCfg.creepsId)

		CommonTipsMgr.instance:showPetTips(petMo)
	end)
	btnSelect:AddClickListener(function()
		local selectNum = self:_getSelectNum()

		if not self._selectCreepsIds[creepsCfg.creepsId] and selectNum >= self._maxSelectNum then
			local tip = string.format("只可以选择%s只精灵", self._maxSelectNum)

			FloatWordMgr.instance:show(tip)

			return
		end

		if self._selectCreepsIds[creepsCfg.creepsId] then
			self._selectCreepsIds[creepsCfg.creepsId] = nil
		else
			self._selectCreepsIds[creepsCfg.creepsId] = creepsCfg.creepsId
		end

		self:reloadData()
		self:_setBtnOkTxt()
	end)
end

function LotusbattletopwinselectView:_clearTableview(cell)
	local goCon = goutil.findChild(cell.gameObject, "mask/con")

	uGuiUtil.clearImage(goCon)
end

function LotusbattletopwinselectView:_setBtnOkTxt()
	local selectNum = self:_getSelectNum()

	self._txtBtnOk.text = string.format("确认(%s/%s)", selectNum, self._maxSelectNum)
end

function LotusbattletopwinselectView:_getSelectNum()
	return table.nums(self._selectCreepsIds)
end

function LotusbattletopwinselectView:_setRank()
	local rank = LotusbattleModel.instance:getTopWinRank()

	self._imgNum:SetNum(rank)
end

return LotusbattletopwinselectView
