-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenyaolongzunshengzhu/view/ShenyaolongzunshengzhustageView.lua

module("logic.extensions.shenyaolongzunshengzhu.view.ShenyaolongzunshengzhustageView", package.seeall)

local ShenyaolongzunshengzhustageView = class("ShenyaolongzunshengzhustageView", ViewComponent)

function ShenyaolongzunshengzhustageView:ctor()
	ShenyaolongzunshengzhustageView.super.ctor(self)
end

function ShenyaolongzunshengzhustageView:unbindEvents()
	ShenyaolongzunshengzhustageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ShenyaolongzunshengzhustageView:bindEvents()
	ShenyaolongzunshengzhustageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnStart, self.onClickStart, self)
end

function ShenyaolongzunshengzhustageView:buildUI()
	ShenyaolongzunshengzhustageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnStart = self:getGo("info/btnStart")
	self._txtDesc = self:getTxt("info/txtDesc")
	self._con = self:getGo("con")
	self._container = self:getGo("bottom/container")
	self._item = self:getGo("bottom/item")

	GameUtil.SetActive(self._item, false)

	self._empty = self:getGo("bottom/empty")
	self._tabScrollercell = self:getGo("tabCol/tabScrollercell")
	self._tabScrollerview = self:getGo("tabCol/tabScrollerview")
	self._cell = self:getGo("info/cell")
	self._tableview = self:getGo("info/tableview")
	self._scrollList = ScrollerList.create(self._tabScrollerview, self._tabScrollercell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self._rightScrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateRightCell, self), GameUtil.handler(self.clearRightCell, self))
end

function ShenyaolongzunshengzhustageView:onExit()
	ShenyaolongzunshengzhustageView.super.onExit(self)
	self._scrollList:dispose()
	self._rightScrollList:dispose()

	self._role = RoleObjectPool.instance:removeRole(self._role)
end

function ShenyaolongzunshengzhustageView:onEnter()
	ShenyaolongzunshengzhustageView.super.onEnter(self)

	self._activityId = ShenyaolongzunshengzhuController.instance:getCurrActivity()

	self:_refreshUI()

	self._txtDesc.text = ShenyaolongzunshengzhuConfig.instance:getCommonValue("DESC_STAGE")

	self.addGEvent(self, GlobalNotify.ShenyaolongzunshengzhuInfoUpdate, self._refreshUI, self)
	ShenyaolongzunshengzhuController.instance:sendGetInfo(self._activityId)
end

function ShenyaolongzunshengzhustageView:_refreshUI()
	local stageList = ShenyaolongzunshengzhuConfig.instance:getStageListById(self._activityId) or {}

	self._scrollList:reloadData(stageList)

	self._selectStageId = 0

	if #stageList > 0 then
		self._selectStageId = stageList[1].stageId
	end

	local lastStageId = ShenyaolongzunshengzhuModel.instance:getLastStageId()

	if lastStageId > 0 then
		self._selectStageId = lastStageId
	end

	self:_updateMidInfo()

	local list = ShenyaolongzunshengzhuConfig.instance:getRuleCfgById(self._activityId) or {}

	self._rightScrollList:reloadData(list)
end

function ShenyaolongzunshengzhustageView:_updateMidInfo()
	local cfg = ShenyaolongzunshengzhuConfig.instance:getStageCfgById(self._activityId, self._selectStageId) or {}

	self:_setPetInfo(cfg.skinId)

	local info = ShenyaolongzunshengzhuModel.instance:getStageInfo(self._activityId, self._selectStageId) or {}

	if not info.tagInfo then
		local list = {}

		GameUtil.SetActive(self._empty, #list == 0)
		goutil.clearChildren(self._container)

		for i, v in ipairs(list) do
			local item = goutil.cloneAndSetParent(self._item, self._container.transform, "cell_" .. i)

			GameUtil.SetActive(item, true)

			local img = goutil.findChild(item, "img")

			GameUtil.setUIImageSpriteIdx(img, v.id - 1)

			for j = 1, 6 do
				local go = goutil.findChild(item, "txt_" .. j)

				GameUtil.SetActive(go, v.id == j)
			end

			local txtNum = goutil.findChildTextComponent(item, "txtNum")

			txtNum.text = v.num
		end
	end
end

function ShenyaolongzunshengzhustageView:_setPetInfo(skinId)
	self._role = RoleObjectPool.instance:removeRole(self._role)

	if skinId > 0 then
		local displayBagOffset = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)
		local x, y, scale = 0, 0, 1

		if displayBagOffset then
			x = checknumber(displayBagOffset[1])
			y = checknumber(displayBagOffset[2])
			scale = displayBagOffset[3] or 1
		end

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, x, y)
	end
end

function ShenyaolongzunshengzhustageView:onClickStart()
	ShenyaolongzunshengzhuController.instance:openFmtView(self._activityId, self._selectStageId)
end

function ShenyaolongzunshengzhustageView:_updateCell(view, cell, data, tag)
	local btn = goutil.findChild(cell, "headTabCell")
	local img = goutil.findChild(cell, "headTabCell/img/img")
	local select = goutil.findChild(cell, "headTabCell/select")
	local finish = goutil.findChild(cell, "headTabCell/finish")

	MaterialMgr.setIcon(img, MatType.PET_SKIN, data.skinId)
	GameUtil.SetActive(finish, false)
	GameUtil.SetActive(select, self._selectStageId == data.stageId)
	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickBtn, self, data))
end

function ShenyaolongzunshengzhustageView:_onClickBtn(data)
	self._selectStageId = data.stageId

	ShenyaolongzunshengzhuModel.instance:setLastStageId(self._selectStageId)
	self._scrollList:refresh()
	self:_updateMidInfo()
end

function ShenyaolongzunshengzhustageView:clearCell(cell)
	return
end

function ShenyaolongzunshengzhustageView:_updateRightCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")

	txtName.text = data.name
	txtNum.text = ShenyaolongzunshengzhuModel.instance:getTotalTagTypeCount(self._activityId, data.tagType)
end

function ShenyaolongzunshengzhustageView:clearRightCell(cell)
	return
end

return ShenyaolongzunshengzhustageView
