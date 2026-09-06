-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/view/SelectBuffView.lua

module("logic.extensions.mangtower.view.SelectBuffView", package.seeall)

local SelectBuffView = class("SelectBuffView", ViewComponent)

function SelectBuffView:unbindEvents()
	SelectBuffView.super.unbindEvents(self)
	self._btnOk:RemoveClickListener()
end

function SelectBuffView:bindEvents()
	SelectBuffView.super.bindEvents(self)
	self._btnOk:AddClickListener(self._onClickOk, self)
	goutil.setActive(self._btnOk.gameObject, false)
end

function SelectBuffView:onExit()
	SelectBuffView.super.onExit(self)
	self:_recycleCells()
	self:_stopSelectEffect()
end

function SelectBuffView:buildUI()
	SelectBuffView.super.buildUI(self)

	self._btnOk = self:getBtn("topCanvas/btnOk")
	self._cloneCell = self:getGo("topCanvas/cell")
	self._gridLayoutGroup = self:getGo("topCanvas/GridLayoutGroup")
	self._topCanvas = goutil.findChildComponent(self.mainGO, "topCanvas", typeof(UnityEngine.Canvas))
	self._bomCanvas = goutil.findChildComponent(self.mainGO, "bomCanvas", typeof(UnityEngine.Canvas))

	goutil.setActive(self._cloneCell, false)
end

function SelectBuffView:onEnter()
	SelectBuffView.super.onEnter(self)

	local param = self._viewPresentor:getFirstParam()

	self.selectCallBack = param.selectCallBack

	local allBuff = param.buffIdList
	local selectBuff = {}

	for k, v in pairs(allBuff) do
		local cha = checknumber(math.pow(math.random(), 1 / v.weight))

		if #selectBuff < 3 then
			local obj = v

			obj.cha = cha

			table.insert(selectBuff, obj)
		else
			local index

			for i = 1, 3 do
				if cha > selectBuff[i].cha then
					index = i
				end
			end

			if checknumber(index) > 0 then
				local obj = v

				obj.cha = cha
				selectBuff[index] = obj
			end
		end
	end

	self:_updateUI(selectBuff)

	local mainCanvas = UGUIToolHelper.FindCanvas(self.mainGO)

	self._sortingOrder = mainCanvas.sortingOrder
	self._topCanvas.sortingOrder = self._sortingOrder + 10
	self._bomCanvas.sortingOrder = self._sortingOrder + 1
end

function SelectBuffView:_onClickClose()
	BattleController.instance:endBattle()
end

function SelectBuffView:_updateBuffCell(go, data)
	local container = goutil.findChild(go, "container")
	local btn = Framework.ButtonAdapter.Get(container)
	local txtName = goutil.findChildTextComponent(container, "txtName")
	local txtDesc = goutil.findChildTextComponent(container, "txtDesc")
	local buffIcon = Framework.ImageBigBG.GetFrom(container, "BuffIcon")
	local levelImgChange = goutil.findChildComponent(container, "level", typeof(UIImageSpriteChange))
	local selected = goutil.findChild(container, "selected")

	btn:AddClickListener(function()
		self:_onClickBuff(go, data)
	end)
	buffIcon:SetImage(GameUrl.getExpEventUrl(data.icon))
	levelImgChange:SetState(data.quality - 1)

	txtName.text = data.name
	txtDesc.text = data.desc

	goutil.setActive(selected, false)
end

function SelectBuffView:_updateUI(buffIdList)
	for k, data in ipairs(buffIdList) do
		if data then
			local cell = self:_getFreeCell()

			cell:SetActive(true)
			self:_updateBuffCell(cell, data)
		end
	end

	goutil.setActive(self._btnOk.gameObject, false)
end

function SelectBuffView:_onClickBuff(go, data)
	self:_updateCurSelected(false)

	self._selectedCell = go

	self:_updateCurSelected(true)
	goutil.setActive(self._btnOk.gameObject, true)

	self._selectedBuffId = data.id
end

function SelectBuffView:_updateCurSelected(isActive)
	if self._selectedCell then
		local selected = goutil.findChild(self._selectedCell, "container/selected")

		goutil.setActive(selected, isActive)

		if isActive then
			self:_playSelectEffect(selected)
		end
	end
end

function SelectBuffView:_playSelectEffect(go)
	self:_stopSelectEffect()

	local eff = UIEffectManager.instance:playEffectBrief(self, "fx_ui_yuanzheng/fx_ui_yuanzheng_xuanka.prefab", go.transform, true)

	eff:setParent(go.transform)
	eff:setLocalPos(0, 0, 0)
	eff:setScale(1)
	eff:setSortingOrder(self._sortingOrder + 2)

	self._selectEff = eff
end

function SelectBuffView:_stopSelectEffect()
	if self._selectEff then
		UIEffectManager.instance:stopEffect(self._selectEff)

		self._selectEff = nil
	end
end

function SelectBuffView:_getFreeCell()
	self._useCount = self._useCount or 0
	self._useCount = self._useCount + 1
	self._cells = self._cells or {}

	if self._cells[self._useCount] ~= nil then
		return self._cells[self._useCount]
	else
		local cell = goutil.cloneAndSetParent(self._cloneCell, self._gridLayoutGroup.transform)

		Framework.TransformUtil.SetLocalScale(cell.transform, 1, 1, 1)
		table.insert(self._cells, cell)

		return cell
	end
end

function SelectBuffView:_recycleCells()
	for _, go in ipairs(self._cells) do
		local container = goutil.findChild(go, "container")
		local btn = Framework.ButtonAdapter.Get(container)
		local buffIcon = Framework.ImageBigBG.GetFrom(container, "BuffIcon")

		buffIcon:ClearImage()
		btn:RemoveClickListener()
		go:SetActive(false)
	end
end

function SelectBuffView:_onClickOk()
	self:close()

	if self.selectCallBack then
		self.selectCallBack(self._selectedBuffId)
	end
end

return SelectBuffView
