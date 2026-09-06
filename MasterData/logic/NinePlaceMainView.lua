-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NinePlaceMainView.lua

module("logic.extensions.nineplace.view.NinePlaceMainView", package.seeall)

local NinePlaceMainView = class("NinePlaceMainView", TableViewComponent)

function NinePlaceMainView:ctor()
	NinePlaceMainView.super.ctor(self)

	self.model = NinePlaceModel.instance
	self.config = NinePlaceConfig.instance
end

function NinePlaceMainView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function NinePlaceMainView:buildUI()
	NinePlaceMainView.super.buildUI(self)

	self.leftBtn = self:getBtn("leftBtn")
	self.rightBtn = self:getBtn("rightBtn")
	self.winCon = self:getGo("winCon")
	self._tableview.gridWidth = 340
	self._tableview.gridHeight = 260
end

function NinePlaceMainView:bindEvents()
	NinePlaceMainView.super.bindEvents(self)
end

function NinePlaceMainView:unbindEvents()
	NinePlaceMainView.super.unbindEvents(self)
end

function NinePlaceMainView:destroyUI()
	NinePlaceMainView.super.destroyUI(self)
end

function NinePlaceMainView:onEnter()
	NinePlaceMainView.super.onEnter(self)

	self.isInitOper = true

	local function clickTip()
		TipsFacade.instance:openRulesView("nineplacebattle")
	end

	ViewMgr.instance:openAt(self.winCon, ViewName.FullwincomponentView, self._viewPresentor, self, "九宫八阵", clickTip)
	self.leftBtn:AddClickListener(self.onClickLeft, self)
	self.rightBtn:AddClickListener(self.onClickRight, self)
	GlobalDispatcher:addListener(NinePlaceModel.GetNinePlaceProcessInfoRes, self.initView, self)
	NinePlaceController.instance:sendPM_GetNinePlaceProcessInfoReq()
	self:initView()
end

function NinePlaceMainView:onEnterFinished()
	NinePlaceMainView.super.onEnterFinished(self)
end

function NinePlaceMainView:onExit()
	NinePlaceMainView.super.onExit(self)
	self.leftBtn:RemoveClickListener()
	self.rightBtn:RemoveClickListener()
	GlobalDispatcher:removeListener(NinePlaceModel.GetNinePlaceProcessInfoRes, self.initView, self)
end

function NinePlaceMainView:onExitFinished()
	NinePlaceMainView.super.onExitFinished(self)
end

function NinePlaceMainView:initView()
	self._curViewDatas = self.config:getStageCfgs()

	self:reloadData()
end

function NinePlaceMainView:_updateCell(view, cell, data)
	local component = GameUtil.AddLuaOnce(cell.gameObject, NinePlaceMainItem)

	component:setData(data)
end

function NinePlaceMainView:_onReloadFinish()
	if self.isInitOper then
		self.isInitOper = false

		local currId = NinePlaceModel.instance.currViewStageId
		local index = false

		for i, v in ipairs(self._curViewDatas) do
			if currId then
				NinePlaceModel.instance.currViewStageId = false

				if currId == v.stageId then
					index = i

					break
				end
			elseif self.model:isStageCanChalenge(v.stageId) then
				index = i

				break
			end
		end

		if index then
			self._tableview:ForceMoveCellToCenter(index)
		end
	end
end

function NinePlaceMainView:onClickLeft()
	return
end

function NinePlaceMainView:onClickRight()
	return
end

return NinePlaceMainView
