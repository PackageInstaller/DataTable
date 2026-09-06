-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestCheckView.lua

module("logic.extensions.goddesscontest.view.GoddessContestCheckView", package.seeall)

local GoddessContestCheckView = class("GoddessContestCheckView", ViewComponent)

function GoddessContestCheckView:buildUI()
	GoddessContestCheckView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._goCell = self:getGo("petCom/cell")
	self._goTableView = self:getGo("petCom/tableview")
	self._tableView = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function GoddessContestCheckView:bindEvents()
	GoddessContestCheckView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function GoddessContestCheckView:unbindEvents()
	GoddessContestCheckView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function GoddessContestCheckView:onEnter()
	GoddessContestCheckView.super.onEnter(self)

	self._showSkinIds = self:getFirstParam() or {}

	self._tableView:reloadData(self._showSkinIds)
	self._tableView:MoveCellToBegin(0)
end

function GoddessContestCheckView:onExit()
	GoddessContestCheckView.super.onExit(self)
	self._tableView:dispose()
end

function GoddessContestCheckView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local faceId = checknumber(data)
	local modelCo = CharacterConfig.instance:getModelCo(faceId)

	uGuiUtil.setSpriteToImage(cell.petIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	cell.txtName.text = PetSkinConfig.instance:getPetSkinName(faceId)

	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickSkin, self, faceId))

	cell.txtVote.text = langPara("人气值：%s", GoddessContestModel.instance:getCurGoddessVoteValue(faceId))
end

function GoddessContestCheckView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.petCard = goutil.findChildComponent(cell.go, "petCard", "UIImageSpriteChange")
	cell.petIcon = goutil.findChild(cell.go, "pet/petIcon")
	cell.txtName = goutil.findChildTextComponent(cell.go, "name/txtName")
	cell.txtVote = goutil.findChildTextComponent(cell.go, "vote/txt")

	uGuiUtil.clearImage(cell.petIcon)
	GameUtil.rmClickHandler(cell.go)

	return cell
end

function GoddessContestCheckView:_onClickSkin(faceId)
	self:close()
	UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_SHOP, faceId)
end

return GoddessContestCheckView
