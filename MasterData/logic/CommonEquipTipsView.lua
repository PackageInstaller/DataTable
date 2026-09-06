-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/CommonEquipTipsView.lua

module("logic.extensions.common.instruction.view.CommonEquipTipsView", package.seeall)

local CommonEquipTipsView = class("CommonEquipTipsView", ViewComponent)

function CommonEquipTipsView:ctor()
	CommonEquipTipsView.super.ctor(self)
end

function CommonEquipTipsView:destroyUI()
	CommonEquipTipsView.super.destroyUI(self)
end

function CommonEquipTipsView:onExitFinished()
	CommonEquipTipsView.super.onExitFinished(self)
end

function CommonEquipTipsView:onEnterFinished()
	CommonEquipTipsView.super.onEnterFinished(self)
end

function CommonEquipTipsView:unbindEvents()
	CommonEquipTipsView.super.unbindEvents(self)
	self._btnInteractive:RemoveClickListener()
end

function CommonEquipTipsView:bindEvents()
	CommonEquipTipsView.super.bindEvents(self)
	self._btnInteractive:AddClickListener(self._onClickInteractive, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function CommonEquipTipsView:onExit()
	CommonEquipTipsView.super.onExit(self)
end

function CommonEquipTipsView:buildUI()
	CommonEquipTipsView.super.buildUI(self)

	local Nego_Content = self:getGo("Nego_Content")

	self._customInput = UICustomInput.Get(Nego_Content)
	self._adjustPosition = Nego_Content:GetComponent("UIAdjustPosition")
	self._Nego_Content = Nego_Content

	local Nego_Top = goutil.findChild(Nego_Content, "Nego_Top")

	self._equipCell = EquipCell.New(Nego_Top)
	self._txtCount = goutil.findChildComponent(Nego_Top, "TxtC_Count", "Text")
	self._btnInteractive = self:getBtn("Nego_Content/Nego_Bottom/btnInteractive")
	self._txtInteractive = goutil.findChildComponent(self._btnInteractive.gameObject, "Text", "Text")

	local attrs = goutil.findChild(Nego_Content, "scrollrect/content/attrs")

	self._attrs = ItemEquipAttrs.New(attrs)
end

function CommonEquipTipsView:onEnter()
	CommonEquipTipsView.super.onEnter(self)
	GameUtil.SetActive(self.mainGO, false)

	local params = self:getOpenParam()
	local data = params[1]
	local pos = params[2]
	local txtBtn = params[3]

	self._btnCallback = params[4]

	local sizeDelta = params[5]
	local equipId = data.equipmentId
	local equipLv = math.max(1, checknumber(data.level))
	local equipCfg = StarEquipmentConfig.instance:getEquipCfg(equipId)

	self._equipCell:onSetMo(equipCfg, checknumber(data.level))

	local equipLvCfg = StarEquipmentConfig.instance:getEquipLvCfg(equipId, equipLv)

	self._attrs:updateAttrs(equipLvCfg.propertyApp)

	local matNum = MaterialFacade.instance:getMatNumber(MatType.StarEquipment, equipId)

	self._txtCount.text = string.format("拥有%s个", matNum)

	goutil.setActive(self._txtCount.gameObject, checknumber(data.level) == 0)

	if not string.nilorempty(txtBtn) then
		self._txtInteractive.text = txtBtn

		goutil.setActive(self._btnInteractive.gameObject, true)
	else
		goutil.setActive(self._btnInteractive.gameObject, false)
	end

	self:_updatePos(pos, sizeDelta)
end

function CommonEquipTipsView:_updatePos(pos, sizeDelta)
	if sizeDelta == nil then
		Framework.TransformUtil.SetPos(self._Nego_Content.transform, pos[1], pos[2], pos[3])
		GameUtil.SetActive(self.mainGO, true)
	else
		settimer(0.02, function()
			GameUtil.SetActive(self.mainGO, true)
			Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
			self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
		end, nil, false)
	end
end

function CommonEquipTipsView:_onClickClose()
	self:close()
end

function CommonEquipTipsView:_onClickInteractive()
	if self._btnCallback ~= nil then
		self:close()
		self._btnCallback()
	end
end

function CommonEquipTipsView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

return CommonEquipTipsView
