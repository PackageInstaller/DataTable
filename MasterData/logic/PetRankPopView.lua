-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/rank/PetRankPopView.lua

module("logic.extensions.handbook.view.rank.PetRankPopView", package.seeall)

local PetRankPopView = class("PetRankPopView", TableViewComponent)

function PetRankPopView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function PetRankPopView:_cellSize(view, index)
	return 460, 98
end

function PetRankPopView:ctor()
	PetRankPopView.super.ctor(self)
end

function PetRankPopView:unbindEvents()
	PetRankPopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PetRankPopView:bindEvents()
	PetRankPopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PetRankPopView:buildUI()
	PetRankPopView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

function PetRankPopView:onExit()
	PetRankPopView.super.onExit(self)
end

function PetRankPopView:onEnter()
	PetRankPopView.super.onEnter(self)

	local strengths = self:getFirstParam()

	if TableUtil.isTableEmpty(strengths) then
		self:close()

		return
	end

	self:updateListData(strengths)
end

function PetRankPopView:initCell(cell)
	return
end

function PetRankPopView:_updateCell(view, cell, data)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local btnSure = goutil.findChildButtonComponent(cell, "btnSure")
	local config = ItemConfig.instance:getSourceCfg(data)

	if config then
		txtDesc.text = config.name

		goutil.setActive(btnSure.gameObject, true)
	else
		txtDesc.text = ""

		goutil.setActive(btnSure.gameObject, false)
	end

	GameUtil.addClickHandler(btnSure, GameUtil.handler(self._onClickGo, self, config))
end

function PetRankPopView:_onClickGo(data)
	if data then
		local isOpen = self:getFuncIsOpen(data.funcId)

		if not string.nilorempty(data.jumpTo) then
			local list = string.split(data.jumpTo, "#")
			local tag = list[1]

			if tag == "fb" then
				isOpen = isOpen and PlotCopyModel.instance:isStageUnlock(checknumber(list[2]), checknumber(list[3]))
			end
		end

		local params = string.split(data.jumpTo, "#")
		local goKey = params[1]

		if goKey == "func" then
			local funcId = params[2]

			isOpen = isOpen and FuncOpenController.instance:getOtherReachedById(funcId)
		end

		local isLock = not isOpen

		if isLock then
			local isFound = false
			local arr = string.splitToNumber(data.funcId)

			for i, v in ipairs(arr) do
				if v > 0 and FuncOpenController.instance:checkFuncIdOrShowLockTips(v) == false then
					isFound = true

					break
				end
			end

			if isFound == false then
				FloatWordMgr.instance:show(data.lockedTips)
			end
		else
			self:close()
			GotoMgr.gotoByString(data.jumpTo)
		end
	end
end

function PetRankPopView:getFuncIsOpen(funcId)
	local arr = string.splitToNumber(funcId, "#")
	local boo = true

	for i, v in ipairs(arr) do
		if v > 0 then
			boo = boo and FuncOpenModel.instance:getFuncIsOpen(v)
		end
	end

	return boo
end

return PetRankPopView
