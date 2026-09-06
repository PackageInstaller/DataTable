-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckydraw/view/LuckyDrawPreviewView.lua

module("logic.extensions.luckydraw.view.LuckyDrawPreviewView", package.seeall)

local LuckyDrawPreviewView = class("LuckyDrawPreviewView", ViewComponent)

function LuckyDrawPreviewView:buildUI()
	LuckyDrawPreviewView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("cell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtDesc = self:getTxt("left/txtDesc")
end

function LuckyDrawPreviewView:bindEvents()
	LuckyDrawPreviewView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function LuckyDrawPreviewView:unbindEvents()
	LuckyDrawPreviewView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function LuckyDrawPreviewView:onEnter()
	LuckyDrawPreviewView.super.onEnter(self)

	self._actId = LuckyDrawModel.instance:getActId()
	self._prizeCfgs = LuckyDrawConfig.instance:getPrizeCfg(self._actId)

	local dataHash = {}

	for i, v in ipairs(self._prizeCfgs) do
		local type = v.prizePreType

		if type > 0 then
			local data = dataHash[type]

			if not data then
				data = {
					type = type
				}
				data.prizeStr = ""
				dataHash[type] = data
			end

			data.prizeStr = data.prizeStr .. "#" .. v.prize
		end
	end

	local dataList = {}

	for k, v in pairs(dataHash) do
		table.insert(dataList, v)
	end

	table.sort(dataList, function(a, b)
		return a.type < b.type
	end)
	self._tableView:reloadData(dataList)

	self._txtDesc.text = langPara("lucky_draw_preview_tip")
end

function LuckyDrawPreviewView:onExit()
	LuckyDrawPreviewView.super.onExit(self)
	self._tableView:dispose()
end

function LuckyDrawPreviewView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	MaterialMgr.setCellListByCfg(data.prizeStr, cell.petList)
	cell.bgChange:SetState(checkint(data.type) - 1)
end

function LuckyDrawPreviewView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.petList = goutil.findChild(cell.go, "petList")
	cell.bgChange = goutil.findChildComponent(cell.go, "rateTitle/rareImg", "UIImageSpriteChange")

	MaterialMgr.resetAll(cell.petList)

	return cell
end

return LuckyDrawPreviewView
