-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintsdragonclg/view/OriginTSDragonClgSelectPuzView.lua

module("logic.extensions.origintsdragonclg.view.OriginTSDragonClgSelectPuzView", package.seeall)

local OriginTSDragonClgSelectPuzView = class("OriginTSDragonClgSelectPuzView", ViewComponent)

function OriginTSDragonClgSelectPuzView:ctor()
	OriginTSDragonClgSelectPuzView.super.ctor(self)
end

function OriginTSDragonClgSelectPuzView:unbindEvents()
	OriginTSDragonClgSelectPuzView.super.unbindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function OriginTSDragonClgSelectPuzView:bindEvents()
	OriginTSDragonClgSelectPuzView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function OriginTSDragonClgSelectPuzView:buildUI()
	OriginTSDragonClgSelectPuzView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._Content = self:getTxt("scrView/Viewport/Content")
	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function OriginTSDragonClgSelectPuzView:onExit()
	OriginTSDragonClgSelectPuzView.super.onExit(self)
	self._scrollList:dispose()
end

function OriginTSDragonClgSelectPuzView:onEnter()
	OriginTSDragonClgSelectPuzView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 591001
	end

	self._phaseId = checknumber(params[2])
	self._stageId = checknumber(params[3])

	local bePointedToMap = checktable(params[4])

	self._pointedList = checktable(bePointedToMap[self._phaseId][self._stageId])

	local phaseInfoMaps = OriginTSDragonClgModel.instance:getPhaseInfoMaps(self._activityId)

	self._phaseInfoMap = phaseInfoMaps and checktable(phaseInfoMaps) or {}
	self._curSelectPuzId = OriginTSDragonClgModel.instance:getSelectPuzId(self._activityId, self._phaseId)
	self._curPhasePuzNum = OriginTSDragonClgModel.instance:getCurPuzNum(self._activityId, self._phaseId)
	self._curPhaseCfg = OriginTSDragonClgConfig.instance:getPhaseCfgById(self._activityId, self._phaseId)
	self._puzzleCfgs = OriginTSDragonClgConfig.instance:getPuzzleCfgs(self._activityId, self._phaseId)

	local puzEffDesc = self:_getPuzEffDesc()

	self._Content.text = string.nilorempty(puzEffDesc) and "暂无" or puzEffDesc

	self._scrollList:reloadData(self._puzzleCfgs)
end

function OriginTSDragonClgSelectPuzView:_updateCell(view, cell, data)
	local content = goutil.findChild(cell.gameObject, "content")
	local bg = goutil.findChild(content, "bg")
	local imgPuz = goutil.findChild(content, "imgPuz")
	local imgPuzChange = imgPuz:GetComponent(ComponentType.UIImageSpriteChange)
	local select = goutil.findChild(cell, "select")
	local txtDirect = goutil.findChildTextComponent(content, "txtDirect")
	local txtDesc = goutil.findChildTextComponent(content, "txtDesc")
	local puzzleType = data.puzzleType
	local hasBeUsed = OriginTSDragonClgModel.instance:hasUsePuzId(self._activityId, self._phaseId, data.puzzleId)

	txtDirect.text = puzzleType == OriginTSDragonClgController.PuzType.AllDirect and lang("指向性：九宫") or lang("指向性：左右")
	txtDesc.text = data.puzEffectDesc

	imgPuzChange:ChangeSprite(data.puzImageName)
	GameUtil.SetActive(select, self._curSelectPuzId == data.puzzleId)
	GameUtil.SetGray(content, hasBeUsed)
	GameUtil.addClickHandler(cell, function()
		if hasBeUsed then
			FloatWordMgr.instance:show(lang("已被其他关卡选择"))

			return
		end

		self._curSelectPuzId = self._curSelectPuzId == data.puzzleId and 0 or data.puzzleId

		self._scrollList:reloadData(self._puzzleCfgs)
	end)
end

function OriginTSDragonClgSelectPuzView:_clearCell(cell)
	local imgPuz = goutil.findChild(cell, "imgPuz")

	GameUtil.rmClickHandler(cell)
end

function OriginTSDragonClgSelectPuzView:_onClickBtnSure()
	if self._curPhaseCfg then
		if not self._curPhaseCfg.puzzleLimit then
			local puzzleLimit = 0

			if puzzleLimit <= self._curPhasePuzNum then
				FloatWordMgr.instance:show(lang("已超出本层的碎片数"))

				return
			end

			if puzzleLimit > self._curPhasePuzNum and self._curSelectPuzId == 0 then
				TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否确认本关不使用碎片，若不选择可能影响通关"), function()
					OriginTSDragonClgModel.instance:setSelectPuzId(self._activityId, self._phaseId, 0)
					self:close()
				end)
			else
				OriginTSDragonClgModel.instance:setSelectPuzId(self._activityId, self._phaseId, self._curSelectPuzId)
				self:close()
			end
		end
	end
end

function OriginTSDragonClgSelectPuzView:_onClickBtnClose()
	if self._curPhaseCfg then
		if not self._curPhaseCfg.puzzleLimit then
			local puzzleLimit = 0
			local curPuzId = OriginTSDragonClgModel.instance:getSelectPuzId(self._activityId, self._phaseId)

			if puzzleLimit > self._curPhasePuzNum and curPuzId == 0 then
				TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否确认本关不使用碎片，若不选择可能影响通关"), function()
					OriginTSDragonClgModel.instance:setSelectPuzId(self._activityId, self._phaseId, 0)
					self:close()
				end)
			else
				self:close()
			end
		end
	end
end

function OriginTSDragonClgSelectPuzView:_getPuzEffDesc()
	local desc = ""

	if #self._pointedList > 0 then
		for i, puzId in ipairs(self._pointedList) do
			local puzCfg = OriginTSDragonClgConfig.instance:getPuzzleCfg(self._activityId, self._phaseId, puzId)

			desc = i ~= #self._pointedList and desc .. puzCfg.puzEffectDesc .. "、" or desc .. puzCfg.puzEffectDesc
		end
	end

	return desc
end

return OriginTSDragonClgSelectPuzView
