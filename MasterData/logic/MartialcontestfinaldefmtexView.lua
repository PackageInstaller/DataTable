-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinaldefmtexView.lua

module("logic.extensions.martialcontest.view.MartialcontestfinaldefmtexView", package.seeall)

local MartialcontestfinaldefmtexView = class("MartialcontestfinaldefmtexView", ViewComponent)

function MartialcontestfinaldefmtexView:ctor()
	MartialcontestfinaldefmtexView.super.ctor(self)
end

function MartialcontestfinaldefmtexView:unbindEvents()
	MartialcontestfinaldefmtexView.super.unbindEvents(self)
	GameUtil.addClickHandler(self._btnEquip)
	GameUtil.addClickHandler(self._btnEquipChange)
end

function MartialcontestfinaldefmtexView:bindEvents()
	MartialcontestfinaldefmtexView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnEquip, self._onClickEquip, self)
	GameUtil.addClickHandler(self._btnEquipChange, self._onClickEquipChange, self)
end

function MartialcontestfinaldefmtexView:buildUI()
	MartialcontestfinaldefmtexView.super.buildUI(self)

	self._txtTips = self:getTxt("txtTips")
	self._btnEquip = self:getGo("btnEquip")
	self._btnEquipChange = self:getGo("btnEquipChange")
	self._equipIconChange = self:getGo("btnEquipChange/img"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtBtnName = self:getTxt("btnEquipChange/txt")
	self._equipInfo = self:getGo("equipInfo")
	self._equipTableview = self:getGo("equipInfo/equipTableview")
	self._eqiupTablecell = self:getGo("eqiupTablecell")
	self._equipTableList = ScrollerList.create(self._equipTableview, self._eqiupTablecell, GameUtil.handler(self._updateEquipCell, self), GameUtil.handler(self._clearEquipCell, self))
	self._dragcell = self:getGo("dragCell")
	self._dragCellImage = self:getImg("dragCell/con")
	self._posContainer = self:getGo("equipInfo/posContainer")

	self._equipTableList:getView():RegisterDraggingCallback(nil, GameUtil.handler(self._onDragCellStart, self), nil, nil, GameUtil.handler(self._onCloneDragObj, self), nil)
	self._equipTableList:getView():RegisterDragEndedCallback(self._onDragCellEnd, self)

	self._goEmpty = self:getGo("equipInfo/goEmpty")
	self._equipPowShow = {}

	local posEquipShowGo = self:getGo("posEquipShow")

	for i = 1, 9 do
		local posInfo = {}

		posInfo.go = goutil.findChild(posEquipShowGo, "pos_" .. i)
		posInfo.img = goutil.findChild(posInfo.go, "img")
		self._equipPowShow[i] = posInfo
	end

	self._btnGo = self:getBtn("equipInfo/goEmpty/btnGo")
end

function MartialcontestfinaldefmtexView:onExit()
	MartialcontestfinaldefmtexView.super.onExit(self)
end

function MartialcontestfinaldefmtexView:onEnter()
	MartialcontestfinaldefmtexView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FormationChangeFinish, self._onFormationChanged, self)
	self.addGEvent(self, GlobalNotify.FormationGroupInfoUpdate, self._onFormationChanged, self)

	local params = self:getOpenParam()

	self.customFmtMo = params[1]
	self._txtTips.text = "将以此阵应对他人挑战，勿忘装备功法秘籍"

	GameUtil.SetActive(self._equipInfo, false)

	self._state = 0
	self._txtBtnName.text = lang("装备功法")

	self._equipIconChange:SetState(0)
	GameUtil.SetActive(self._dragcell, false)
	self:_refreshView()
end

function MartialcontestfinaldefmtexView:_refreshView()
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

function MartialcontestfinaldefmtexView:_updateEquipCell(view, cell, data, tag)
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

function MartialcontestfinaldefmtexView:_clearEquipCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function MartialcontestfinaldefmtexView:_onDragCellStart(startContainer, cell)
	local con = goutil.findChild(cell.gameObject, "con")
	local image = con:GetComponent(ComponentType.Image)

	self._dragCellImage.sprite = image.sprite

	GameUtil.SetActive(self._dragcell, true)
	GameUtil.SetActive(self._posContainer, true)

	self._drag = true
end

function MartialcontestfinaldefmtexView:_onDragCellEnd(startContainer, cell, endContainer)
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

function MartialcontestfinaldefmtexView:_onCloneDragObj(table, cell)
	local targetPos = GameUtil.getPos(cell.gameObject)

	GameUtil.setPos(self._dragcell, targetPos.x, targetPos.y, targetPos.z)

	return self._dragcell
end

function MartialcontestfinaldefmtexView:_onClickEquipChange()
	if self._state == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.FormationShowRightInfo, false)
		GameUtil.SetActive(self._equipInfo, true)

		self._state = 1
		self._txtBtnName.text = lang("上阵精灵")

		self._equipIconChange:SetState(1)
	else
		GlobalDispatcher:dispatch(GlobalNotify.FormationShowRightInfo, true)
		GameUtil.SetActive(self._equipInfo, false)

		self._state = 0
		self._txtBtnName.text = lang("装备功法")

		self._equipIconChange:SetState(0)
	end
end

function MartialcontestfinaldefmtexView:_onClickEquip()
	UIStateManager.instance:push(ViewName.MartialContestEquipView, self.customFmtMo.activityId)
end

function MartialcontestfinaldefmtexView:_onFormationChanged()
	self.customFmtMo:refreshCurEquipState()
	self:_refreshView()
end

return MartialcontestfinaldefmtexView
