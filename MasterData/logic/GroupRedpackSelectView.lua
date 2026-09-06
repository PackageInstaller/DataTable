-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupredpack/view/GroupRedpackSelectView.lua

module("logic.extensions.groupredpack.view.GroupRedpackSelectView", package.seeall)

local GroupRedpackSelectView = class("GroupRedpackSelectView", ViewComponent)

function GroupRedpackSelectView:ctor()
	GroupRedpackSelectView.super.ctor(self)
end

function GroupRedpackSelectView:unbindEvents()
	GroupRedpackSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCanel)
end

function GroupRedpackSelectView:bindEvents()
	GroupRedpackSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCanel, self._onClickClose, self)
end

function GroupRedpackSelectView:buildUI()
	GroupRedpackSelectView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._btnCanel = self:getBtn("btnCancel")
	self._tableview = self:getGo("ScrollView")
	self._tablecell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function GroupRedpackSelectView:onExit()
	GroupRedpackSelectView.super.onExit(self)
	self._scrollList:dispose()
end

function GroupRedpackSelectView:onEnter()
	GroupRedpackSelectView.super.onEnter(self)

	local param = self:getOpenParam()

	self._petId = param[1]
	self._activity = GroupRedpackModel.instance:getActivityId()
	self._cfgs = GroupRedpackConfig.instance:getGroupRedpackCfgsByActId(self._activity)
	self._selectId = 1
	self._groupId = GroupRedpackModel.instance:getGroupId()

	self:_initPreSelect()
	self:_reloadData()
end

function GroupRedpackSelectView:_initPreSelect()
	local coverCfg = GroupRedpackConfig.instance:getGroupRedpackCoverCfgsById(self._cfgs.coverPlanId, self._groupId)
	local coverIds = string.split(coverCfg.coverIds, ";")

	for i, v in ipairs(coverIds) do
		if v == self._petId then
			self:_onClickCover(i, v)

			break
		end
	end
end

function GroupRedpackSelectView:_reloadData()
	local coverCfgs = GroupRedpackConfig.instance:getGroupRedpackCoverCfgsById(self._cfgs.coverPlanId, self._groupId)
	local petIds = string.split(coverCfgs.coverIds, ";")
	local list = {}

	for i, v in ipairs(petIds) do
		local data = {}

		data.id = i
		data.coverId = v

		local petCo = CharacterConfig.instance:getModelCo(checknumber(v))

		data.cardName = petCo.cardName

		table.insert(list, data)
	end

	self._scrollList:reloadData(list)
end

function GroupRedpackSelectView:_updateCell(view, goCell, data, tag)
	local cell = self:_clearCell(goCell)

	uGuiUtil.setSpriteToImage(cell.item, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(data.cardName))
	GameUtil.SetActive(cell.select, data.id == self._selectId)

	cell.txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, data.coverId)

	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickCover, self, data.id, data.coverId))
end

function GroupRedpackSelectView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.select = goutil.findChild(cell.go, "imgSelect")
	cell.item = goutil.findChild(cell.go, "item")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")

	uGuiUtil.clearImage(cell.item)
	GameUtil.rmClickHandler(cell.go)

	return cell
end

function GroupRedpackSelectView:_onClickClose()
	self:close()
end

function GroupRedpackSelectView:_onClickSure()
	GlobalDispatcher:dispatch(GlobalNotify.GroupRedPackSelectCover, self._petId)
	self:close()
end

function GroupRedpackSelectView:_onClickCover(selectId, petId)
	self._selectId = selectId
	self._petId = petId

	self._scrollList:refresh()
end

return GroupRedpackSelectView
