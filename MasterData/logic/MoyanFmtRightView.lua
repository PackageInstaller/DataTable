-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/moyan/mission/MoyanFmtRightView.lua

module("logic.extensions.mangtower.view.MoyanFmtRightView", package.seeall)

local MoyanFmtRightView = class("MoyanFmtRightView", FormationRightView)
local moveOffset = 15

function MoyanFmtRightView:buildUI()
	MoyanFmtRightView.super.buildUI(self)

	local Nego_Pet = self:getGo("Nego_Right/SrlC_Pet/Nego_Viewport/Nego_Pet")
	local posx, posy, _ = Framework.TransformUtil.GetLocalPos(Nego_Pet.transform, nil, nil, nil)

	if self.posXRcd == nil then
		self.posXRcd = posx
		self.posYRcd = posy
	end

	local Nego_Viewport = self:getGo("Nego_Right/SrlC_Pet/Nego_Viewport").transform
	local sizeDeltaViewport = Nego_Viewport.sizeDelta

	if self.sizeDeltaViewportRcd == nil then
		self.sizeDeltaViewportRcd = sizeDeltaViewport
	end
end

function MoyanFmtRightView:onEnter()
	MoyanFmtRightView.super.onEnter(self)
	settimer(0, self._updateCellOrders, self, -1)

	local params = self._viewPresentor:getFirstParam()

	self.curParams = params

	local Nego_Viewport = self:getGo("Nego_Right/SrlC_Pet/Nego_Viewport").transform
	local Nego_Pet = self:getGo("Nego_Right/SrlC_Pet/Nego_Viewport/Nego_Pet")
	local posx, posy = self.posXRcd, self.posYRcd
	local sizeDeltaViewport = Vector2.New(self.sizeDeltaViewportRcd.x, self.sizeDeltaViewportRcd.y)

	if params then
		local type = params.type

		if type == MoyanModel.TYPE_1 or type == MoyanModel.TYPE_2 then
			sizeDeltaViewport.y = sizeDeltaViewport.y + moveOffset
			posy = posy + moveOffset
		end
	end

	Framework.TransformUtil.SetLocalPos(Nego_Pet.transform, posx, posy, 0)

	Nego_Viewport.sizeDelta = sizeDeltaViewport
end

function MoyanFmtRightView:onExit()
	MoyanFmtRightView.super.onExit(self)
	removetimer(self._updateCellOrders, self)
end

function MoyanFmtRightView:_clearTableview(cell)
	local component = ItemPet.AddOnce(cell.gameObject)

	component:OnDestroy()
end

function MoyanFmtRightView:_updateCellOrders()
	local cnt = self._tableview:GetVisibleCount() - 1

	for i = 0, cnt do
		local cell = self._tableview:GetCellByIndex(i)
		local petState = goutil.findChild(cell.gameObject, "PetState")

		if petState then
			petState.transform:SetAsLastSibling()
		end
	end
end

function MoyanFmtRightView:_updateCell(view, cell, data)
	MoyanFmtRightView.super._updateCell(self, view, cell, data)
	self:_updatePetState(cell, data)
end

function MoyanFmtRightView:_updatePetState(cell, data)
	local petState = goutil.findChild(cell.gameObject, "PetState")

	if not petState then
		petState = self._viewPresentor:getResInstance(ExpeditionMissionViewPresentor.itemExpPet)

		if not petState then
			return
		end

		petState.transform:SetParent(cell.transform)
		Framework.TransformUtil.SetLocalPos(petState.transform, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(petState.transform, 1, 1, 1)

		petState.name = "PetState"
	end

	local bloodbar = Framework.SliderAdapter.GetFrom(petState, "bloodbar")
	local vigourbar = Framework.SliderAdapter.GetFrom(petState, "vigourbar")
	local vigourVal = 0
	local hpVal = MoyanController.instance:getPetHpById(self.curParams, data.petId)

	bloodbar:SetValue(hpVal)
	vigourbar:SetValue(vigourVal)
end

function MoyanFmtRightView:getAllShowPetList()
	return MoyanController.instance:getPetListInMission(self.curParams)
end

function MoyanFmtRightView:_getCurFormation()
	return MoyanController.instance:GetCurFormation(self.curParams)
end

function MoyanFmtRightView:rankNow()
	local names, opt = BagModel.instance:GetSortParms(self:getPetAtCurFormationFunc())

	table.insert(names, 2, function(petMo)
		local hpVal = MoyanController.instance:getPetHpById(self.curParams, petMo.petId)
		local isDead = hpVal <= 0

		if isDead then
			return 1
		else
			return 0
		end
	end)
	table.insert(opt, 2, ArraySort.NONE)

	if FormationController.instance:checkCanSort(self._curViewDatas) then
		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._tableview:ReloadData()
	self._tableview:Refresh()
end

function MoyanFmtRightView:updateForbit(data)
	local inTeam = self:getInTeam(data)
	local hasOneHire = self:getHasHireInTeam(data)
	local hasUp = false
	local canNotUp, hasOne = false, false
	local canNotUpWithYuan = self:getYuanLimit(data)
	local hpVal = MoyanController.instance:getPetHpById(self.curParams, data.petId)
	local isDead = hpVal <= 0

	data.isDead = isDead

	data:setPetForbit(not inTeam and (hasUp or hasOneHire or canNotUp or hasOne or isDead or canNotUpWithYuan))
end

function MoyanFmtRightView:_onClickPet(data)
	if data.forbit then
		self:_onForbidDragTips(data)

		return
	end

	MoyanFmtRightView.super._onClickPet(self, data)
end

function MoyanFmtRightView:_onForbidDragTips(petData)
	local hpVal = MoyanController.instance:getPetHpById(self.curParams, petData.petId)
	local isDead = hpVal <= 0

	if isDead then
		FloatWordMgr.instance:show(lang("moyanfmtrightview__1"))
	else
		MoyanFmtRightView.super._onForbidDragTips(self, petData)
	end
end

return MoyanFmtRightView
