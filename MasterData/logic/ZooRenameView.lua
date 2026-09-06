-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooRenameView.lua

module("logic.extensions.zoo.view.ZooRenameView", package.seeall)

local ZooRenameView = class("ZooRenameView", ViewComponent)

function ZooRenameView:buildUI()
	ZooRenameView.super.buildUI(self)

	self._icon = self:getGo("icon")
	self._iconBtn = GameUtil.asBtn(self.mainGO, "icon")
	self._btnOk = self:getBtn("btnOK")
	self._btnClose = self:getBtn("btnClose")
	self._costNumText = self:getGo("txtNum"):GetComponent(goutil.Type_UIText)
	self._inputName = self:getInput("inputName")

	self._inputName:SetCharacterLimit(14)
end

function ZooRenameView:bindEvents()
	ZooRenameView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnOk:AddClickListener(self._onClickOk, self)
	self._iconBtn:AddClickListener(self._onClickIcon, self)
	self._inputName:AddOnValueChanged(self._onInputValueChange, self)
end

function ZooRenameView:unbindEvents()
	ZooRenameView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnOk:RemoveClickListener()
	self._iconBtn:RemoveClickListener()
	self._inputName:RemoveOnValueChanged()
end

function ZooRenameView:onEnter()
	ZooRenameView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooChangeAnimalName, self._onZooAnimalRename, self)
	self:_initView()
end

function ZooRenameView:onExit()
	ZooRenameView.super.onExit(self)
	uGuiUtil.clearImage(self._icon)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooChangeAnimalName, self._onZooAnimalRename, self)
end

function ZooRenameView:_onClickOk()
	local newName = self._inputName:GetText()
	local isValid = ZooController.instance:checkNameValid(newName)

	if isValid and MaterialFacade.instance:checkMatEnough(self._matType, self._matId, self._useNum) then
		ZooController.instance:sendPM_ZooSetAnimalNameReq(self._animalId, newName)
	end
end

function ZooRenameView:_onClickIcon()
	if self._matType and self._matId then
		CommonTipsMgr.instance:openMaterialTips(self._icon, self._matType, self._matId, 0)
	end
end

function ZooRenameView:_initView()
	self._animalId = self:getFirstParam()

	local myZoo = ZooModel.instance:getMyZoo()
	local animalMo = myZoo:getAnimalById(self._animalId)

	self._inputName:SetText(animalMo.name)

	self._currName = ""

	local cost = ZooConfig.instance:getChangeAnimalNameCost()

	self._matType, self._matId, self._useNum = MaterialMgr.getMatParams(cost)

	local has_num = MaterialFacade.instance:getMatNumber(self._matType, self._matId)
	local cfg = MaterialMgr.getMatCfg(self._matType, self._matId)

	self._costNumText.text = "(<color=" .. (has_num >= self._useNum and "#4eae1a" or "#eb4642") .. ">" .. has_num .. "</color>/" .. self._useNum .. ")"

	uGuiUtil.setSpriteToImage(self._icon, nil, GameUrl.getItemIconUrl(cfg.icon))
end

function ZooRenameView:_onInputValueChange(str)
	local value = str
	local t = StringUtil.utf8split(value)
	local result = ""
	local count = math.min(7, #t)

	for i = 1, count do
		result = result .. t[i]
	end

	self._inputName:SetText(result)
end

function ZooRenameView:_onZooAnimalRename(animalId, status)
	if animalId == self._animalId and status == 0 then
		self:close()
	end
end

return ZooRenameView
