-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessbattle/view/EndlessBuffListView.lua

module("logic.extensions.endlessbattle.view.EndlessBuffListView", package.seeall)

local EndlessBuffListView = class("EndlessBuffListView", ViewComponent)

function EndlessBuffListView:unbindEvents()
	EndlessBuffListView.super.unbindEvents(self)
	self._btnOk:RemoveClickListener()
end

function EndlessBuffListView:bindEvents()
	EndlessBuffListView.super.bindEvents(self)
	self._btnOk:AddClickListener(self._onClickOk, self)
	goutil.setActive(self._btnOk.gameObject, false)
end

function EndlessBuffListView:onExit()
	EndlessBuffListView.super.onExit(self)
	self:_recycleCells()
	self:_stopSelectEffect()
end

function EndlessBuffListView:buildUI()
	EndlessBuffListView.super.buildUI(self)

	self._btnOk = self:getBtn("topCanvas/btnOk")
	self._cloneCell = self:getGo("topCanvas/cell")
	self._gridLayoutGroup = self:getGo("topCanvas/GridLayoutGroup")
	self._topCanvas = goutil.findChildComponent(self.mainGO, "topCanvas", typeof(UnityEngine.Canvas))
	self._bomCanvas = goutil.findChildComponent(self.mainGO, "bomCanvas", typeof(UnityEngine.Canvas))

	goutil.setActive(self._cloneCell, false)
end

function EndlessBuffListView:onEnter()
	EndlessBuffListView.super.onEnter(self)
	EndlessBattleController.instance:infiniteFightBuffReq(self._updateUI, self)

	local mainCanvas = UGUIToolHelper.FindCanvas(self.mainGO)

	self._sortingOrder = mainCanvas.sortingOrder
	self._topCanvas.sortingOrder = self._sortingOrder + 10
	self._bomCanvas.sortingOrder = self._sortingOrder + 1
end

function EndlessBuffListView:_onClickClose()
	self:close()
end

function EndlessBuffListView:_updateBuffCell(go, data)
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

function EndlessBuffListView:_updateUI(msg)
	local buffIdList = msg.buffs

	if not msg.planId then
		local planId = 1

		for _, buffId in ipairs(buffIdList) do
			local cfg = EndlessBattleConfig.instance:getBuffCfg(planId, buffId)

			if cfg then
				local cell = self:_getFreeCell()

				cell:SetActive(true)
				self:_updateBuffCell(cell, cfg)
			end
		end

		goutil.setActive(self._btnOk.gameObject, false)
	end
end

function EndlessBuffListView:_onClickBuff(go, data)
	self:_updateCurSelected(false)

	self._selectedCell = go

	self:_updateCurSelected(true)
	goutil.setActive(self._btnOk.gameObject, true)

	self._selectedBuffId = data.buffId
end

function EndlessBuffListView:_updateCurSelected(isActive)
	if self._selectedCell then
		local selected = goutil.findChild(self._selectedCell, "container/selected")

		goutil.setActive(selected, isActive)

		if isActive then
			self:_playSelectEffect(selected)
		end
	end
end

function EndlessBuffListView:_playSelectEffect(go)
	self:_stopSelectEffect()

	local eff = UIEffectManager.instance:playEffectBrief(self, "fx_ui_yuanzheng/fx_ui_yuanzheng_xuanka.prefab", go.transform, true)

	eff:setParent(go.transform)
	eff:setLocalPos(0, 0, 0)
	eff:setScale(1)
	eff:setSortingOrder(self._sortingOrder + 2)

	self._selectEff = eff
end

function EndlessBuffListView:_stopSelectEffect()
	if self._selectEff then
		UIEffectManager.instance:stopEffect(self._selectEff)

		self._selectEff = nil
	end
end

function EndlessBuffListView:_getFreeCell()
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

function EndlessBuffListView:_recycleCells()
	for _, go in ipairs(self._cells) do
		local container = goutil.findChild(go, "container")
		local btn = Framework.ButtonAdapter.Get(container)
		local buffIcon = Framework.ImageBigBG.GetFrom(container, "BuffIcon")

		buffIcon:ClearImage()
		btn:RemoveClickListener()
		go:SetActive(false)
	end
end

function EndlessBuffListView:_onClickOk()
	self:close()
	EndlessBattleModel.instance:setBuffId(self._selectedBuffId)
	print("click buff id = " .. self._selectedBuffId)
	GlobalDispatcher:dispatch(GlobalNotify.EndlessBuffSelected)
end

return EndlessBuffListView
