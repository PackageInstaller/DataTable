-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickupidea/view/PickupideastoryView.lua

module("logic.extensions.pickupidea.view.PickupideastoryView", package.seeall)

local PickupideastoryView = class("PickupideastoryView", ViewComponent)

function PickupideastoryView:ctor()
	PickupideastoryView.super.ctor(self)
end

function PickupideastoryView:unbindEvents()
	PickupideastoryView.super.unbindEvents(self)
	self._btnJumpTo:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function PickupideastoryView:bindEvents()
	PickupideastoryView.super.bindEvents(self)
	self._btnJumpTo:AddClickListener(self._onClickbtnJumpTo, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function PickupideastoryView:buildUI()
	PickupideastoryView.super.buildUI(self)

	self._btnJumpTo = self:getBtn("btnJumpTo")
	self._btnClose = self:getBtn("btnClose")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._roleImgGo = self:getGo("roleImg")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function PickupideastoryView:onExit()
	PickupideastoryView.super.onExit(self)
	self._scrollerList:dispose()
	uGuiUtil.clearImage(self._roleImgGo)
end

function PickupideastoryView:onEnter()
	PickupideastoryView.super.onEnter(self)

	self._id = self:getFirstParam()
	self._activityId = PickupideaModel.instance:getActivityId()
	self._roleCfg = PickupideaConfig.instance:getRoleCfg(self._activityId, self._id)
	self._storyCfgs = PickupideaConfig.instance:getStoryCfgs(self._activityId, self._id)
	self._progress = PickupideaController.instance:getGoodFeelProgress(self._activityId, self._id)
	self._matName = MaterialMgr.getMaterialsNameByCfg(string.format("10:%s", self._roleCfg.activityItemId))

	self:_updateUI()
end

function PickupideastoryView:_onClickbtnJumpTo()
	GotoMgr.gotoByString(self._roleCfg.jumpTo)
	self:close()
end

function PickupideastoryView:_onClickbtnClose()
	self:close()
end

function PickupideastoryView:_updateUI()
	self._scrollerList:reloadData(self._storyCfgs)
	self:_setRoleImg()
end

function PickupideastoryView:_updateCell(view, cell, cfg, tag)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtTitle = goutil.findChildTextComponent(cell.gameObject, "txtTitle")
	local btnBg = Framework.ButtonAdapter.GetFrom(cell.gameObject, "bg")
	local redpointGo = goutil.findChild(cell.gameObject, "redpoint")
	local pass = self._progress >= cfg.progress
	local content = ""

	content = self._progress >= cfg.progress and cfg.desc or string.format("获得%s个%s后解锁", cfg.progress, self._matName)
	txtDesc.text = content
	txtTitle.text = string.format("剧情%s简介", cell.data)

	btnBg:AddClickListener(function()
		if not pass then
			FloatWordMgr.instance:show(content)

			return
		end

		GlobalDispatcher:dispatch(GlobalNotify.StartStory, cfg.storyId)
		PickupideaController.instance:setIsViewStory(self._activityId, self._roleCfg.roleId, cfg.index)
	end)
	RedPointController.instance:unregRedPoint(redpointGo)

	local key = PickupideaController.instance:getStoryViewKey(self._activityId, self._roleCfg.roleId, cfg.index)

	RedPointController.instance:regRedPoint(redpointGo, key)
end

function PickupideastoryView:_clearCell(cell)
	return
end

function PickupideastoryView:_setRoleImg()
	local modelCo = CharacterConfig.instance:getModelCo(self._roleCfg.skinId)

	uGuiUtil.setSpriteToImage(self._roleImgGo, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
end

return PickupideastoryView
