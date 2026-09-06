-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/customfmt/view/CustomFmtRightView.lua

module("logic.extensions.customfmt.view.CustomFmtRightView", package.seeall)

local CustomFmtRightView = class("CustomFmtRightView", FormationRightView)

function CustomFmtRightView:buildUI()
	CustomFmtRightView.super.buildUI(self)
end

function CustomFmtRightView:onEnter()
	CustomFmtRightView.super.onEnter(self)

	self.customFmtMo = self:getFirstParam()

	self:_onValidateUI()
	self:_setPetFilterList()
	GlobalDispatcher:addListener(GlobalNotify.ForceChangeCurFormTab, self._onCurFormTabChange, self)
end

function CustomFmtRightView:_onCurFormTabChange()
	self:_RefreshPetList()
end

function CustomFmtRightView:_onBagPetChange(changePetMoMap)
	self:_RefreshPetList()
end

function CustomFmtRightView:getAllShowPetList()
	return self.customFmtMo:getAllShowPetList()
end

function CustomFmtRightView:_getCurFormation()
	return (self.customFmtMo:getCurFormation())
end

function CustomFmtRightView:rankNow()
	if FormationController.instance:checkCanSort(self._curViewDatas) then
		local names, opt = BagModel.instance:GetSortParms(self:getPetAtCurFormationFunc())

		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._tableview:ReloadData()
	self._tableview:Refresh()
end

function CustomFmtRightView:getPetAtCurFormationFunc()
	return function(petMo)
		local res = 2

		if self:getInTeam(petMo) then
			res = 3
		elseif self:getHasUp(petMo) then
			res = 1
		end

		return (self.customFmtMo:checkPetIsForbit(petMo) or nil) and 0
	end
end

function CustomFmtRightView:onExit()
	CustomFmtRightView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ForceChangeCurFormTab, self._onCurFormTabChange, self)
end

function CustomFmtRightView:_clearTableview(cell)
	local con = goutil.findChild(cell, "con")
	local component = ItemPet.AddOnce(con.gameObject)

	component:OnDestroy()

	local top = goutil.findChild(cell, "top")

	self.customFmtMo:clearCellTop(top)
end

function CustomFmtRightView:updateForbit(petMo)
	local forbit = self:checkPetIsForbit(petMo)

	petMo:setPetForbit(forbit)
end

function CustomFmtRightView:checkPetIsForbit(petMo)
	local inTeam = self:getInTeam(petMo)
	local hasUp = false
	local hasOneHire = self:getHasHireInTeam(petMo)
	local canNotUp, hasOne = false, false
	local canNotUpWithYuan = self:getYuanLimit(petMo)
	local baseCheck = not inTeam and (hasUp or hasOneHire or canNotUp or hasOne or canNotUpWithYuan)
	local forbit = self.customFmtMo:checkPetIsForbit(petMo, baseCheck)

	return baseCheck or forbit
end

function CustomFmtRightView:initCell(cell)
	local con = goutil.findChild(cell, "con")
	local component = ItemPet.AddOnce(con.gameObject)

	if not self._disableDrag then
		BeginDragHandler.Get(con.gameObject):AddLuaHandler(function(go, data)
			self:_OnDragPetBegin(go, data)
		end)
		DragHandler.Get(con.gameObject):AddLuaHandler(function(go, data)
			self:_OnDragPetMoved(go, data)
		end)
		EndDragHandler.Get(con.gameObject):AddLuaHandler(function(go, data)
			self:_OnDragPetEnded(go, data)
		end)
	end
end

function CustomFmtRightView:_updateCell(view, cell, petMo)
	local top = goutil.findChild(cell, "top")
	local con = goutil.findChild(cell, "con")
	local component = ItemPet.AddOnce(con.gameObject)

	self:updateForbit(petMo)
	component:Init(petMo)
	component:setSelected(false)

	local inTeam = self:getInTeam(petMo)

	component:SetInTeam(inTeam)
	component:setFormConditionLabel(self._jobLabelStr)

	local fmtMo = self:_getCurFormation()

	component:setContractTag(fmtMo:GetSummonMasterPetId(), fmtMo:GetSummonPetId())
	self.customFmtMo:updateCellTop(top, petMo)
	component:removeAllListener(ItemPet.Events.Click)
	component:addListener(ItemPet.Events.Click, function(data)
		self:_onClickPet(data)
	end)
end

function CustomFmtRightView:_onClickPet(petMo)
	if petMo.forbit then
		self:_onForbidDragTips(petMo)

		return
	end

	CustomFmtRightView.super._onClickPet(self, petMo)
end

function CustomFmtRightView:_onForbidDragTips(petMo)
	CustomFmtRightView.super._onForbidDragTips(self, petMo)
	self.customFmtMo:showForbitPetAlert(petMo)
end

function CustomFmtRightView:setCurViewDatas()
	self._curViewDatas = {}

	local pets = self:getAllShowPetList()

	for k, v in pairs(pets) do
		self._curPetMap[v.petId] = v

		if self:onFilter(v) and self.customFmtMo:onFilterPetShow(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end
end

function CustomFmtRightView:_onValidateUI()
	if self.customFmtMo then
		GameUtil.SetActive(self._Nego_Right, self.customFmtMo.isShowNegoRight)
	end
end

function CustomFmtRightView:_setPetFilterList()
	self.customFmtMo:setPetFilterList()
end

return CustomFmtRightView
