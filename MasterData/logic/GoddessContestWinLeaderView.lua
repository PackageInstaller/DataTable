-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestWinLeaderView.lua

module("logic.extensions.goddesscontest.view.GoddessContestWinLeaderView", package.seeall)

local GoddessContestWinLeaderView = class("GoddessContestWinLeaderView", ViewComponent)

function GoddessContestWinLeaderView:buildUI()
	GoddessContestWinLeaderView.super.buildUI(self)

	self._modelCam = self:getGo("modelCam")
	self._rolePoint = goutil.findChild(self._modelCam, "rolePoint")
	self._goTableView = self:getGo("com/tableview")
	self._goCell = self:getGo("com/cell")
	self._tableview = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	self._avatar:setParent(self._rolePoint.transform)
	self._avatar:setLayer(SceneLayer.UI3D_Value)

	self._txtName = self:getTxt("leader/txtName")
	self._txtArea = self:getTxt("leader/area/txt")
	self._headLeader = self:getGo("leader/head")
end

function GoddessContestWinLeaderView:bindEvents()
	GoddessContestWinLeaderView.super.bindEvents(self)
end

function GoddessContestWinLeaderView:unbindEvents()
	GoddessContestWinLeaderView.super.unbindEvents(self)
end

function GoddessContestWinLeaderView:onEnter()
	GoddessContestWinLeaderView.super.onEnter(self)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	goutil.addChildToParent(self._modelCam)
	GlobalModel.instance:visibleSceneHUDs(false)

	self._winGroupInfo = GoddessContestModel.instance:getWinGroupInfo()

	if self._winGroupInfo then
		self._tableview:reloadData(self._winGroupInfo.secLeaderHeadInfos)
		HeadItemController.instance:setHeadCellByInfo(self._headLeader, self._winGroupInfo.leaderHeadInfo)

		self._txtArea.text = self._winGroupInfo.leaderHeadInfo.areaName
		self._txtName.text = self._winGroupInfo.leaderHeadInfo.userName
	end
end

function GoddessContestWinLeaderView:onEnterFinished()
	GoddessContestWinLeaderView.super.onEnterFinished(self)

	if self._winGroupInfo then
		local avatarMo = DressModel.instance:getAvatarMoWithDefaultSuit(self._winGroupInfo.leadergender)

		for _, clothe in ipairs(self._winGroupInfo.leaderClothes) do
			avatarMo:dressCloth(clothe)
		end

		self._avatar:updateByMo(avatarMo)
	end
end

function GoddessContestWinLeaderView:onExit()
	GoddessContestWinLeaderView.super.onExit(self)
	LightMgr.instance:setLightForNormalScene()
	goutil.addChildToParent(self._modelCam, self.mainGO)
	GlobalModel.instance:visibleSceneHUDs(true)
	self._tableview:dispose()
	HeadItemController.instance:resetHeadCell(self._headLeader)
end

function GoddessContestWinLeaderView:destroyUI()
	GoddessContestWinLeaderView.super.destroyUI(self)

	if self._avatar then
		AvatarsMgrNew.instance:removeAvatar(self._avatar)

		self._avatar = nil
	end
end

function GoddessContestWinLeaderView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	HeadItemController.instance:setHeadCellByInfo(cell.head, data)

	cell.txtArea.text = data.areaName
	cell.txtName.text = data.userName
end

function GoddessContestWinLeaderView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.head = goutil.findChild(cell.go, "head")
	cell.txtArea = goutil.findChildTextComponent(cell.go, "area/txt")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")

	HeadItemController.instance:resetHeadCell(cell.head)

	return cell
end

return GoddessContestWinLeaderView
