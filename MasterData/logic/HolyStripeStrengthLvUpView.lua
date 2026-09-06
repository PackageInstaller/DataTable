-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeStrengthLvUpView.lua

module("logic.extensions.holystripe.view.HolyStripeStrengthLvUpView", package.seeall)

local HolyStripeStrengthLvUpView = class("HolyStripeStrengthLvUpView", ViewComponent)

function HolyStripeStrengthLvUpView:buildUI()
	HolyStripeStrengthLvUpView.super.buildUI()

	self._btnClose = GameUtil.asBtn(self:getGo("viewBoxGo"))
	self._mainTableview = self:getGo("attrs/baseattrsScr")
	self._subTableview = self:getGo("attrs/quenchingScr")
	self._cell = self:getGo("attrs/cell")
	self._moCon = self:getGo("itemCell/item")
	self._moName = self:getTxt("itemCell/nameText")
end

function HolyStripeStrengthLvUpView:bindEvents()
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function HolyStripeStrengthLvUpView:unbindEvents()
	GameUtil.rmClickHandler(self._btnClose)
end

function HolyStripeStrengthLvUpView:onEnter()
	HolyStripeStrengthLvUpView.super.onEnter(self)

	self._mainTable = ScrollerList.create(self._mainTableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._subTable = ScrollerList.create(self._subTableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tempMo = self:getFirstParam()
	self._nowMo = HolyStripeModel.instance:getHolyStripeMo(self._tempMo:getId())

	local paramStr = self._tempMo:getBasePropertyParam()
	local attrList = string.split(paramStr, "#")
	local attrNextList = {}

	if self._tempMo:getLv() ~= self._nowMo:getLv() then
		paramStr = self._nowMo:getBasePropertyParam()
		attrNextList = string.split(paramStr, "#")
	end

	local baseFinalList = {}

	for i, v in ipairs(attrList) do
		table.insert(baseFinalList, {
			nowValueStr = v,
			nextValueStr = attrNextList[i],
			idx = i
		})
	end

	self._mainTable:reloadData(baseFinalList)

	paramStr = self._nowMo:getQuenchingPropertyDoc()
	attrList = {}

	if not string.nilorempty(paramStr) then
		attrList = string.split(paramStr, "#")
	end

	paramStr = self._tempMo:getQuenchingPropertyDoc()
	attrNextList = {}

	if not string.nilorempty(paramStr) then
		attrNextList = string.split(paramStr, "#")
	end

	local finalList = {}

	for i, v in ipairs(attrList) do
		if attrNextList[i] then
			table.insert(finalList, {
				nowValueStr = v,
				idx = i
			})
		else
			table.insert(finalList, {
				nextValueStr = "新属性",
				nowValueStr = v,
				idx = i
			})
		end
	end

	self._subTable:reloadData(finalList)

	proxy = MaterialMgr.setCellByMo(self._nowMo, self._moCon)

	if proxy then
		proxy.binder:setNumStr("")
		proxy.binder:setAutoTips(false)
	end

	_, color = PetEquipController:GetQualityStrByNum(self._nowMo:getQuality())
	self._moName.text = langPara("<color=%s>%s</color>", color, self._nowMo:getName())
end

function HolyStripeStrengthLvUpView:onExit()
	HolyStripeStrengthLvUpView.super.onExit(self)
	self._mainTable:dispose()
	self._subTable:dispose()
	HolyStripeModel.instance:saveTempHolyStripe()
end

function HolyStripeStrengthLvUpView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local attrIcon = goutil.findChild(go, "attrIcon"):GetComponent(ComponentType.UIImageSpriteChange)
	local imgArrow = goutil.findChild(go, "imgArrow")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtNow = goutil.findChildTextComponent(go, "txtNow")
	local txtNext = goutil.findChildTextComponent(go, "txtNext")
	local bgChange = goutil.findChildComponent(go, "bg", "UIImageColorChange")
	local arr = string.split(data.nowValueStr, "+")
	local name = arr[1]
	local value = tonumber(arr[2])
	local index = table.indexof(GameEnum.HolyStripeAttrTypeName, name)

	if bgChange and data.idx then
		bgChange:SetState((data.idx - 1) % 2)
	end

	if index then
		attrIcon:SetState(index - 1)
	end

	if value == nil then
		value = arr[2]
		txtNow.text = arr[2]
	else
		txtNow.text = value > 0 and value < 1 and string.format("%s%%", value * 100) or value
	end

	txtName.text = name

	GameUtil.SetActive(imgArrow, false)
	GameUtil.SetActive(txtNext, not string.nilorempty(data.nextValueStr))

	if not string.nilorempty(data.nextValueStr) then
		local arr = string.split(data.nextValueStr, "+")
		local value = tonumber(arr[2])

		if value == nil then
			txtNext.text = data.nextValueStr
		else
			txtNext.text = value > 0 and value < 1 and string.format("%s%%", value * 100) or value

			GameUtil.SetActive(imgArrow, true)
		end
	else
		txtNext.text = ""
	end
end

function HolyStripeStrengthLvUpView:_clearCell(cell)
	return
end

return HolyStripeStrengthLvUpView
