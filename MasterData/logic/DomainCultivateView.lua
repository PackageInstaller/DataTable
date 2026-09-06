-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domaincultivate/view/DomainCultivateView.lua

module("logic.extensions.domaincultivate.view.DomainCultivateView", package.seeall)

local DomainCultivateView = class("DomainCultivateView", ViewComponent)
local SHEN_WEI = "神威"
local CELL_MAX_NUM = 3

function DomainCultivateView:ctor()
	DomainCultivateView.super.ctor(self)
end

function DomainCultivateView:unbindEvents()
	DomainCultivateView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnActive:RemoveClickListener()
	self._btnBuffView:RemoveClickListener()
	self._btnRule:RemoveClickListener()
end

function DomainCultivateView:bindEvents()
	DomainCultivateView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnReset:AddClickListener(self._reset, self)
	self._btnActive:AddClickListener(self._active, self)
	self._btnBuffView:AddClickListener(self._buffView, self)
	self._btnRule:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "shenqiyangchengrule")
	end, self)
end

function DomainCultivateView:buildUI()
	DomainCultivateView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnReset = self:getBtn("activeState/matCost/btnReset")
	self._btnActive = self:getBtn("activeState/matCost/btnActive")
	self._btnBuffView = self:getBtn("btnBuffView")
	self._btnRule = self:getBtn("btnRule")
	self._txtTip = self:getTxt("activeState/info/txtTip")
	self._txtName = self:getTxt("activeState/info/txtName")
	self._fazhen = self:getGo("activeState/info/fazhen")
	self._iconSkill = self:getGo("activeState/info/fazhen/skill")
	self._sleepState = self:getGo("activeState/info/sleep")
	self._matCost = self:getGo("activeState/matCost")
	self._itemCells = {}

	for i = 1, CELL_MAX_NUM do
		obj = {}
		obj.go = self:getGo("activeState/matCost/mat/item_" .. i)
		obj.txt = goutil.findChildTextComponent(obj.go, "txtNum")
		obj.item = goutil.findChild(obj.go, "con")

		table.insert(self._itemCells, obj)
	end

	self._cell = self:getGo("cell")

	self._cell:SetActive(false)

	self._container = self:getGo("container")
	self._containerPlan = self._container:GetComponent(typeof(TestRecordPos))
	self._cells = {}
	self._rightEffect = self:getGo("effect")
	self._activeEffect = {}
end

function DomainCultivateView:onExit()
	DomainCultivateView.super.onExit(self)

	for k, v in pairs(self._activeEffect) do
		if v then
			UIEffectManager.instance:stopEffect(v)

			v = nil
		end
	end

	if self._rightEff then
		UIEffectManager.instance:stopEffect(self._rightEff)

		self._rightEff = nil
	end

	self._selectId = nil

	GlobalDispatcher:removeListener(GlobalNotify.KamuiCultivateChange, self._refreshAll, self)
	GlobalDispatcher:removeListener(GlobalNotify.KamuiCultivateActive, self._activeRes, self)

	for k, v in pairs(self._cells) do
		self:_clearCell(v)
	end

	table.clear(self._cells)

	for i = 1, CELL_MAX_NUM do
		MaterialMgr.resetAll(self._itemCells[i].item)
	end

	uGuiUtil.clearImage(self._iconSkill)
end

function DomainCultivateView:onEnter()
	DomainCultivateView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.KamuiCultivateChange, self._refreshAll, self)
	GlobalDispatcher:addListener(GlobalNotify.KamuiCultivateActive, self._activeRes, self)
	self:_refreshAll()
end

function DomainCultivateView:_refreshAll()
	self:_refreshData()
	self:_refresh()
end

function DomainCultivateView:_refreshData()
	self._petId = self:getFirstParam()

	if self._petId then
		DomainCultivateController.instance:getInfo(self._petId)
	end

	self._petMo = BagModel.instance:getPet(self._petId)
	self._kamuiInfos = self._petMo:getKamuiInfos()

	local petCfg = CharacterConfig.instance:getPetCo(self._petMo.raceId)
	local planId = petCfg.kamuiProgramId

	if planId == nil then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("该精灵不能神启"), GameUtil.handler(self.close, self))

		return
	end

	self._levelCfg = DomainCultivateConfig.instance:getLevelCfg(planId)

	if self._levelCfg == nil then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("找不到养成方案"), GameUtil.handler(self.close, self))

		return
	end

	self._selectId = self._selectId or math.max(#self._kamuiInfos, 1)

	for i = 1, #self._levelCfg do
		local go = goutil.cloneAndSetParent(self._cell, self._container.transform, "cell" .. i)

		go:SetActive(false)

		obj = {}
		obj.go = go
		obj.sleep = goutil.findChild(go, "sleep")
		obj.img = goutil.findChild(go, "active/img")
		obj.redPoint = goutil.findChild(go, "redPoint")
		obj.select = goutil.findChild(go, "select")
		obj.txtPass = goutil.findChildTextComponent(go, "txtPass")
		obj.effect = goutil.findChild(go, "effect")
		obj.btn = GameUtil.asBtn(go)

		obj.btn:AddClickListener(GameUtil.handler(self._onClickSkill, self, i))
		table.insert(self._cells, obj)
	end

	self._containerPlan:LoadPlan(0)

	for i = 1, #self._levelCfg do
		self._cells[i].go:SetActive(true)
	end
end

function DomainCultivateView:_refresh()
	self._txtName.text = SHEN_WEI .. GameUtil.toRomanNumber(self._selectId)
	self._isRed = DomainCultivateController.instance:getIfKamuiActive(self._petId)

	for i = 1, #self._levelCfg do
		self:_setCell(self._cells[i], i)
	end

	local consume
	local active = self._kamuiInfos[self._selectId] ~= nil

	goutil.setActive(self._fazhen, active)
	goutil.setActive(self._sleepState, not active)
	self._btnReset.gameObject:SetActive(active)
	self._btnActive.gameObject:SetActive(not active)

	if active then
		consume = self._levelCfg[self._selectId].resetCost

		local id = self._kamuiInfos[self._selectId].kamuiId
		local kamuiCfg = DomainCultivateConfig.instance:getDefineCfg(id)

		uGuiUtil.setSpriteToImage(self._iconSkill, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(kamuiCfg.icon))

		self._txtTip.text = kamuiCfg.name .. "\n" .. kamuiCfg.desc

		goutil.setActive(self._matCost, true)
	else
		consume = self._levelCfg[self._selectId].upgradeCost

		if self._selectId > #self._kamuiInfos + 1 then
			self._txtTip.text = "需要先激活上一个神威"

			goutil.setActive(self._matCost, false)
		else
			self._txtTip.text = "激活后随机获得神威"

			goutil.setActive(self._matCost, true)
		end
	end

	consume = string.split(consume, "#")

	for i = 1, CELL_MAX_NUM do
		if consume[i] then
			goutil.setActive(self._itemCells[i].go, true)
			MaterialMgr.resetAll(self._itemCells[i].item)

			local proxy = MaterialMgr.setCellByCfg(consume[i], self._itemCells[i].item)
			local matType, id, needNum = MaterialMgr.getMatParams(consume[i])
			local hasNum = MaterialModel.instance:getMaterialsNumber(matType, id)

			proxy.binder:setNumStr("")
			proxy.binder:setAutoTips(false)
			proxy:setCallBack(function()
				if hasNum < needNum then
					MaterialMgr.openGetSource(matType, id)
				else
					CommonTipsMgr.instance:openMaterialTips(self._itemCells[i].item, matType, id, 0)
				end
			end)

			local color = needNum <= hasNum and "20b376" or "eb4642"

			self._itemCells[i].txt.text = string.format("<color=#%s>%s</color>/%s", color, hasNum, needNum)
		else
			goutil.setActive(self._itemCells[i].go, false)
		end
	end
end

function DomainCultivateView:_reset()
	DomainCultivateController.instance:resetKamui(self._petId, self._selectId)
end

function DomainCultivateView:_active()
	DomainCultivateController.instance:activeKamuiReq(self._petId, self._selectId)
end

function DomainCultivateView:_buffView()
	UIStateManager.instance:open(ViewName.DomainCultivateDetailView, self._petId)
end

function DomainCultivateView:_onClickSkill(i)
	self._selectId = i

	self:_refresh()
end

function DomainCultivateView:_setCell(cell, i)
	local data = self._kamuiInfos[i]
	local active = data ~= nil

	cell.sleep:SetActive(not active)
	cell.img:SetActive(active)

	if active then
		local id = data.kamuiId
		local kamuiCfg = DomainCultivateConfig.instance:getDefineCfg(id)

		uGuiUtil.setSpriteToImage(cell.img, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(kamuiCfg.icon))
	end

	cell.select:SetActive(i == self._selectId)
	cell.redPoint:SetActive(i == #self._kamuiInfos + 1 and self._isRed)
end

function DomainCultivateView:_clearCell(cell)
	uGuiUtil.clearImage(cell.img)
	cell.btn:RemoveClickListener()
	goutil.destroy(cell.go)
end

function DomainCultivateView:_activeRes()
	self:_refreshAll()

	local path = "fx_ui_2021930/fx_ui_shenqi/fx_ui_01_shenqishenwei.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._cells[self._selectId].effect.transform, 0, 0, false, false)

	uiEffect:setParent(self._cells[self._selectId].effect.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._activeEffect[self._selectId] = uiEffect

	local path1 = "fx_ui_2021930/fx_ui_shenqi/fx_ui_02_shenqishenwei.prefab"

	self._rightEff = UIEffectManager.instance:playEffect(self, path1, self._rightEffect, 0, 0, false, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(self._rightEffect.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)

		eff.hideEffWhileNotOnTop = true
	end)
end

return DomainCultivateView
