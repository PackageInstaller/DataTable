-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jigsawcollect/view/JigsawcollectsecretctView.lua

module("logic.extensions.jigsawcollect.view.JigsawcollectsecretctView", package.seeall)

local JigsawcollectsecretctView = class("JigsawcollectsecretctView", TableViewComponent)

function JigsawcollectsecretctView:ctor()
	JigsawcollectsecretctView.super.ctor(self)
end

function JigsawcollectsecretctView:buildUI()
	JigsawcollectsecretctView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
end

function JigsawcollectsecretctView:bindEvents()
	JigsawcollectsecretctView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function JigsawcollectsecretctView:unbindEvents()
	JigsawcollectsecretctView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function JigsawcollectsecretctView:destroyUI()
	JigsawcollectsecretctView.super.destroyUI(self)
end

function JigsawcollectsecretctView:onEnter()
	JigsawcollectsecretctView.super.onEnter(self)
	self:_updateView()
end

function JigsawcollectsecretctView:onEnterFinished()
	JigsawcollectsecretctView.super.onEnterFinished(self)
end

function JigsawcollectsecretctView:onExit()
	JigsawcollectsecretctView.super.onExit(self)
end

function JigsawcollectsecretctView:onExitFinished()
	JigsawcollectsecretctView.super.onExitFinished(self)
end

function JigsawcollectsecretctView:_onClickbtnClose()
	self:close()
end

function JigsawcollectsecretctView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function JigsawcollectsecretctView:_cellSize(view, index)
	return 100, 100
end

function JigsawcollectsecretctView:_updateCell(view, cell, data)
	local numText = goutil.findChildTextComponent(cell.gameObject, "txtNum")
	local descText = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local lock = goutil.findChild(cell.gameObject, "lock")
	local txtLock = goutil.findChildTextComponent(cell.gameObject, "lock/txtLock")

	goutil.setActive(lock, data.isLock)

	if lock then
		txtLock.text = string.format("解锁拼图碎片%s可揭秘", data.pieceId)
	end

	descText.text = data.isLock and "" or data.content
	numText.text = cell.data
end

function JigsawcollectsecretctView:_clearTableview(cell)
	return
end

function JigsawcollectsecretctView:_updateView()
	local actId = JigsawcollectModel.instance:getActId()
	local collectInfo = JigsawcollectModel.instance:getCollectInfos()
	local cfg = JigsawcollectConfig.instance:getJigsawCfg(actId)

	if not cfg then
		return
	end

	local planCfgs = JigsawcollectConfig.instance:getPiecePlanCfgs(cfg.piecePlan)
	local finalList = {}
	local collectedPiecesKv = {}

	if collectInfo.collectedPieces then
		for i, v in ipairs(collectInfo.collectedPieces) do
			collectedPiecesKv[v.collectedPiece] = true
		end
	end

	for i, v in ipairs(planCfgs) do
		if not string.nilorempty(v.content) then
			table.insert(finalList, {
				pieceId = v.pieceId,
				isLock = not collectedPiecesKv[v.pieceId],
				content = v.content
			})
		end
	end

	self._curViewDatas = finalList

	self:reloadData()
end

return JigsawcollectsecretctView
