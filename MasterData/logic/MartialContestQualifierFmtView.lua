-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestQualifierFmtView.lua

module("logic.extensions.martialcontest.view.MartialContestQualifierFmtView", package.seeall)

local MartialContestQualifierFmtView = class("MartialContestQualifierFmtView", ViewComponent)

function MartialContestQualifierFmtView:ctor()
	MartialContestQualifierFmtView.super.ctor(self)
end

function MartialContestQualifierFmtView:unbindEvents()
	MartialContestQualifierFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._btnArrow)
	GameUtil.rmClickHandler(self._btnGo)
	GameUtil.rmClickHandler(self._btnUnload)
	GameUtil.rmClickHandler(self._btnEquip)

	for i = 1, 9 do
		GameUtil.rmClickHandler(self._equipPowShow[i].btn)
	end
end

function MartialContestQualifierFmtView:bindEvents()
	MartialContestQualifierFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnHide, self._onClickHide, self)
	GameUtil.addClickHandler(self._btnArrow, self._onClickArrow, self)
	GameUtil.addClickHandler(self._btnGo, self._onClickGo, self)
	GameUtil.addClickHandler(self._btnUnload, self._onClickUnload, self)
	GameUtil.addClickHandler(self._btnEquip, self._onClickEquip, self)

	for i = 1, 9 do
		GameUtil.addClickHandler(self._equipPowShow[i].btn, function()
			self:_onClickPosEquip(i)
		end, self)
	end
end

function MartialContestQualifierFmtView:buildUI()
	MartialContestQualifierFmtView.super.buildUI(self)

	self._btnHide = self:getBtn("btnHide")
	self._btnArrow = self:getBtn("moveNode/btnArrow")
	self._moveNode = self:getGo("moveNode")
	self._arrowRectTrans = self:getGo("moveNode/btnArrow/arrowTran")
	self._equipTableview = self:getGo("moveNode/equipTableview")
	self._eqiupTablecell = self:getGo("eqiupTablecell")
	self._equipTableList = ScrollerList.create(self._equipTableview, self._eqiupTablecell, GameUtil.handler(self._updateEquipCell, self), GameUtil.handler(self._clearEquipCell, self))
	self._dragcell = self:getGo("dragCell")
	self._dragCellImage = self:getImg("dragCell/con")
	self._posContainer = self:getGo("posContainer")

	self._equipTableList:getView():RegisterDraggingCallback(nil, GameUtil.handler(self._onDragCellStart, self), nil, nil, GameUtil.handler(self._onCloneDragObj, self), nil)
	self._equipTableList:getView():RegisterDragEndedCallback(self._onDragCellEnd, self)

	self._goEmpty = self:getGo("moveNode/goEmpty")
	self._btnGo = self:getGo("moveNode/goEmpty/btnGo")
	self._equipPowShow = {}

	local posEquipShowGo = self:getGo("posEquipShow")

	for i = 1, 9 do
		local posInfo = {}

		posInfo.go = goutil.findChild(posEquipShowGo, "pos_" .. i)
		posInfo.img = goutil.findChild(posInfo.go, "img")
		posInfo.btn = posInfo.img
		self._equipPowShow[i] = posInfo
	end

	self._btnUnload = self:getGo("moveNode/btnUnload")
	self._btnEquip = self:getGo("moveNode/btnEquip")
end

function MartialContestQualifierFmtView:onExit()
	MartialContestQualifierFmtView.super.onExit(self)
end

function MartialContestQualifierFmtView:onEnter()
	MartialContestQualifierFmtView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FormationChangeFinish, self._onFormationChanged, self)
	self.addGEvent(self, GlobalNotify.FormationGroupInfoUpdate, self._onFormationChanged, self)

	local params = self:getOpenParam()

	self.customFmtMo = params[1]
	self._enterStepId = self.customFmtMo.enterStepId

	GameUtil.SetActive(self._dragcell, false)
	GameUtil.SetActive(self._posContainer, false)
	self:_refreshView()

	self._isPopupState = true

	GameUtil.SetActive(self._btnHide, true)
	GameUtil.setAnchoredPos(self._moveNode, -110, 80)
	GameUtil.setLocalRotation(self._arrowRectTrans, 0, 0, 0)
end

function MartialContestQualifierFmtView:_refreshView()
	local equipTypeCfgs = MartialContestConfig.instance:getEquipTypeCfgs(self.customFmtMo.activityId)
	local equipList = {}

	for i, v in ipairs(equipTypeCfgs) do
		local equipCfg = v[1]
		local lv = MartialContestModel.instance:getEquipLevel(self.customFmtMo.activityId, equipCfg.equipId)

		if lv > 0 then
			table.insert(equipList, {
				id = equipCfg.equipId,
				lv = lv
			})
		end
	end

	table.sort(equipList, function(a, b)
		local aEquip = checknumber(self.customFmtMo:getCurEquipPetId(a.id)) > 0
		local bEquip = checknumber(self.customFmtMo:getCurEquipPetId(b.id)) > 0

		if aEquip ~= bEquip then
			return aEquip
		end

		if a.lv ~= b.lv then
			return a.lv > b.lv
		end

		return a.id < b.id
	end)
	self._equipTableList:reloadData(equipList)
	GameUtil.SetActive(self._goEmpty, #equipList <= 0)

	for i = 1, 9 do
		GameUtil.SetActive(self._equipPowShow[i].go, false)

		local petId = self.customFmtMo:getCurFormation():GetPosition(i)
		local equipId = self.customFmtMo:getCurEquipId(petId)

		if equipId and equipId > 0 then
			local equipCfg = MartialContestConfig.instance:getEquipCfg(self.customFmtMo.activityId, equipId, 1)

			uGuiUtil.setSpriteToImage(self._equipPowShow[i].img, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(equipCfg.icon))
			GameUtil.SetActive(self._equipPowShow[i].go, true)
		end
	end
end

function MartialContestQualifierFmtView:_updateEquipCell(view, cell, data, tag)
	local go = cell.gameObject

	go.name = "equip_" .. data.id

	local con = goutil.findChild(go, "con")
	local petIconGo = goutil.findChild(go, "petIconGo")
	local petIcon = goutil.findChild(petIconGo, "petIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtLv = goutil.findChildTextComponent(go, "lv/txt")
	local equipCfg = MartialContestConfig.instance:getEquipCfg(self.customFmtMo.activityId, data.id, data.lv)

	txtName.text = equipCfg.name
	txtLv.text = "Lv." .. data.lv

	uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(equipCfg.icon))

	local petId = self.customFmtMo:getCurEquipPetId(data.id)

	if petId and petId > 0 then
		local petMo = self.customFmtMo:getPetMoById(petId)

		MaterialMgr.setIcon(petIcon, MatType.PET_SKIN, petMo.curFaceId)
		GameUtil.SetActive(petIconGo, true)
	else
		MaterialMgr.resetAll(petIcon)
		GameUtil.SetActive(petIconGo, false)
	end

	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		if not self._drag then
			MartialContestController.instance:openEquipTips(con, self.customFmtMo.activityId, data.id, data.lv)
		end
	end, self)
end

function MartialContestQualifierFmtView:_clearEquipCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function MartialContestQualifierFmtView:_onDragCellStart(startContainer, cell)
	local con = goutil.findChild(cell.gameObject, "con")
	local image = con:GetComponent(ComponentType.Image)

	self._dragCellImage.sprite = image.sprite

	GameUtil.SetActive(self._dragcell, true)
	GameUtil.SetActive(self._posContainer, true)

	self._drag = true
end

function MartialContestQualifierFmtView:_onDragCellEnd(startContainer, cell, endContainer)
	if endContainer then
		local equipNameStrArr = string.split(cell.name, "_")
		local posGoStrArr = string.split(endContainer.name, "_")
		local equipId = checknumber(equipNameStrArr[2])
		local posId = checknumber(posGoStrArr[2])
		local petId = self.customFmtMo:getCurFormation():GetPosition(posId)

		if petId > 0 then
			local curEquipPetId = self.customFmtMo:getCurEquipPetId(equipId)

			if curEquipPetId and curEquipPetId ~= petId then
				local equipCfg = MartialContestConfig.instance:getEquipCfg(self.customFmtMo.activityId, equipId, 1)
				local selectPetMo = self.customFmtMo:getPetMoById(petId)
				local curEquipPetMo = self.customFmtMo:getPetMoById(curEquipPetId)
				local selectPetCfg = CharacterConfig.instance:getPetCo(selectPetMo.raceId)
				local curEquipPetCfg = CharacterConfig.instance:getPetCo(curEquipPetMo.raceId)
				local content = langPara("是否将%s的%s卸下，并装备到%s上？", curEquipPetCfg.name, equipCfg.name, selectPetCfg.name)

				TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
					self.customFmtMo:setEquipInfo(petId, equipId)
					self:_refreshView()
				end)
			else
				self.customFmtMo:setEquipInfo(petId, equipId)
				self:_refreshView()
			end
		end
	end

	GameUtil.SetActive(self._dragcell, false)
	GameUtil.SetActive(self._posContainer, false)

	self._drag = false

	return true
end

function MartialContestQualifierFmtView:_onCloneDragObj(table, cell)
	local targetPos = GameUtil.getPos(cell.gameObject)

	GameUtil.setPos(self._dragcell, targetPos.x, targetPos.y, targetPos.z)

	return self._dragcell
end

function MartialContestQualifierFmtView:_onClickGo()
	UIStateManager.instance:push(ViewName.MartialContestEquipView, self.customFmtMo.activityId)
end

function MartialContestQualifierFmtView:_onClickEquip()
	UIStateManager.instance:push(ViewName.MartialContestEquipView, self.customFmtMo.activityId)
end

function MartialContestQualifierFmtView:_onClickUnload()
	for i, v in ipairs(self.customFmtMo:getCurFormation():GetPositions()) do
		if v ~= 0 then
			self.customFmtMo:resetEquipInfo(v)
		end
	end

	self:_refreshView()
end

function MartialContestQualifierFmtView:_onClickHide()
	if self._isPopupState then
		self._isPopupState = false

		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(-110, 80, 0), Vector3.New(400, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	end
end

function MartialContestQualifierFmtView:_onClickArrow()
	if self._isPopupState then
		self._isPopupState = false

		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(-110, 80, 0), Vector3.New(400, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	else
		self._isPopupState = true

		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(400, 80, 0), Vector3.New(-110, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 180), Vector3.New(0, 0, 0), 0.2)
	end
end

function MartialContestQualifierFmtView:_onClickPosEquip(index)
	local petId = self.customFmtMo:getCurFormation():GetPosition(index)
	local equipId = self.customFmtMo:getCurEquipId(petId)

	if equipId and equipId > 0 then
		local con = self._equipPowShow[index].img
		local equipLv = MartialContestModel.instance:getEquipLevel(self.customFmtMo.activityId, equipId)

		MartialContestController.instance:openEquipTips(con, self.customFmtMo.activityId, equipId, equipLv)
	end
end

function MartialContestQualifierFmtView:_onFormationChanged()
	self.customFmtMo:refreshCurEquipState()
	self:_refreshView()
end

return MartialContestQualifierFmtView
