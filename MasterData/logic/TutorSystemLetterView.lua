-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/TutorSystemLetterView.lua

module("logic.extensions.tutorsystem.view.TutorSystemLetterView", package.seeall)

local TutorSystemLetterView = class("TutorSystemLetterView", ViewComponent)

function TutorSystemLetterView:buildUI()
	TutorSystemLetterView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txtDesc")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._prizeCol = goutil.findChild(self.mainGO, "prizeCol")
	self._prizeScrollerview = goutil.findChild(self.mainGO, "prizeCol/prizeScrollerview")
	self._prizeScrollercell = goutil.findChild(self.mainGO, "prizeCol/prizeScrollercell")
	self._prizeScrollList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function TutorSystemLetterView:bindEvents()
	TutorSystemLetterView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
end

function TutorSystemLetterView:unbindEvents()
	TutorSystemLetterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function TutorSystemLetterView:onEnter()
	TutorSystemLetterView.super.onEnter(self)
	self:_onUpdate()
end

function TutorSystemLetterView:onExit()
	TutorSystemLetterView.super.onExit(self)
	self._prizeScrollList:dispose()
end

function TutorSystemLetterView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TutorSystemLetterView:_onUpdateData()
	self._info = TutorSystemModel.instance:popGraduateInfoStack()

	if self._info == nil then
		self:_onClickBtnClose()

		return
	end
end

function TutorSystemLetterView:_onUpdateUI()
	self:_updatePrizeScrollerList()
	self:_updatePlaneUI()
end

function TutorSystemLetterView:_updatePlaneUI()
	self._txtDesc.text = TutorSystemConfig.instance:getFinishTutorTextContent()
	self._txtName.text = self._info.userName
end

function TutorSystemLetterView:_updatePrizeScrollerList()
	local dataList = {}
	local finishPrizeStr = TutorSystemConfig.instance:getFinishTutorPrize()
	local prizeArr = string.split(finishPrizeStr, "#")

	for _, prizeStr in ipairs(prizeArr) do
		local data = {
			prizeStr = prizeStr
		}

		table.insert(dataList, data)
	end

	self._prizeScrollList:reloadData(dataList)
end

function TutorSystemLetterView:_updatePrizeCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local prizeItem = goutil.findChild(mainGo, "prizeItem")

	MaterialMgr.setCellByCfg(data.prizeStr, prizeItem)
end

function TutorSystemLetterView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local prizeItem = goutil.findChild(mainGo, "prizeItem")

	MaterialMgr.resetAll(prizeItem)
end

function TutorSystemLetterView:_onClickBtnClose()
	self:close()

	if self._info then
		MaterialController.instance:showChangeSetInTemp(self._info.changeSetId)
	end

	TutorSystemController.instance:ifHaveLetterThenOpenIt()
end

return TutorSystemLetterView
