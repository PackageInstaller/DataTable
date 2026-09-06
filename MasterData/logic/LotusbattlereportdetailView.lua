-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlereportdetailView.lua

module("logic.extensions.lotusbattle.view.LotusbattlereportdetailView", package.seeall)

local LotusbattlereportdetailView = class("LotusbattlereportdetailView", ViewComponent)

function LotusbattlereportdetailView:ctor()
	LotusbattlereportdetailView.super.ctor(self)
end

function LotusbattlereportdetailView:unbindEvents()
	LotusbattlereportdetailView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function LotusbattlereportdetailView:bindEvents()
	LotusbattlereportdetailView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function LotusbattlereportdetailView:buildUI()
	LotusbattlereportdetailView.super.buildUI(self)

	self._bufftablecellGo = self:getGo("top/bufftablecell")
	self._tableviewGo = self:getGo("tableview")
	self._pettableviewGo = self:getGo("top/pettableview")
	self._bufftableviewGo = self:getGo("top/bufftableview")
	self._pettablecellGo = self:getGo("top/pettablecell")
	self._tablecellGo = self:getGo("tablecell")
	self._buffscrollerList = ScrollerList.create(self._bufftableviewGo, self._bufftablecellGo, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._petscrollerList = ScrollerList.create(self._pettableviewGo, self._pettablecellGo, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._detailscrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateDetailCell, self), GameUtil.handler(self._clearDetailCell, self))
	self._btnClose = self:getBtn("btnClose")
	self._noDetailGo = self:getGo("noDetail")
end

function LotusbattlereportdetailView:onExit()
	LotusbattlereportdetailView.super.onExit(self)
	self._petscrollerList:dispose()
	self._buffscrollerList:dispose()
	self._detailscrollerList:dispose()
end

function LotusbattlereportdetailView:onEnter()
	LotusbattlereportdetailView.super.onEnter(self)

	self._activityId = LotusbattleModel.instance:getActivityId()
	self._battlerecordMsg = self:getFirstParam()

	self:_updateUI()
end

function LotusbattlereportdetailView:_onClickbtnClose()
	self:close()
end

function LotusbattlereportdetailView:_updateBuffCell(view, cell, buffCfg, tag)
	local btnIcon = Framework.ButtonAdapter.GetFrom(cell.gameObject, "icon")

	uGuiUtil.clearImage(btnIcon.gameObject)

	local spriteName = GameUrl.getExpEventUrl(buffCfg.iconPath)

	uGuiUtil.setSpriteToImage(btnIcon.gameObject, nil, spriteName)
	btnIcon:AddClickListener(function()
		local data = LotusbattleConfig.instance:getBuffTipSimpleData(buffCfg.buffPlanId, buffCfg.buffId)

		CommonTipsMgr.instance:openBuffTipView(data, cell.gameObject)
	end)
end

function LotusbattlereportdetailView:_clearBuffCell(cell)
	local btnIcon = goutil.findChild(cell.gameObject, "icon")

	uGuiUtil.clearImage(btnIcon)
end

function LotusbattlereportdetailView:_updatePetCell(view, cell, petMo, tag)
	local proxy = MaterialMgr.setCellByMo(petMo, cell.gameObject)

	proxy.binder:setCallBack(function()
		CommonTipsMgr.instance:showPetTips(petMo)
	end)
end

function LotusbattlereportdetailView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function LotusbattlereportdetailView:_updateDetailCell(view, cell, data, tag)
	local btnVideo = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnVideo")
	local imgChangeImgResult = goutil.findChild(cell.gameObject, "imgResult"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtTime = goutil.findChildTextComponent(cell.gameObject, "txtTime")

	imgChangeImgResult:SetState(data.result == 1 and 0 or 1)

	txtTime.text = self:_getTimeFormat(data.recordTime)

	btnVideo:AddClickListener(function()
		LotusbattleController.instance:getBattleVideoReq(data.battleId)
	end)

	local rootleft = goutil.findChild(cell.gameObject, "left")
	local rootright = goutil.findChild(cell.gameObject, "right")

	self:_updateDetail(rootleft, data.myTeamId == GameEnum.BattleTeam.Left)
	self:_updateDetail(rootright, data.myTeamId ~= GameEnum.BattleTeam.Left, data.opHeadInfo)
end

function LotusbattlereportdetailView:_updateDetail(root, isAttacker, headInfo)
	local goHead = goutil.findChild(root, "head")
	local imgChangeState = goutil.findChild(root, "state"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtName = goutil.findChildTextComponent(root, "txtName")

	HeadItemController.instance:resetHeadCell(goHead)
	imgChangeState:SetState(isAttacker and 0 or 1)

	if headInfo then
		HeadItemController.instance:setHeadCellByInfo(goHead, headInfo)

		txtName.text = headInfo.userName
	else
		HeadItemController.instance:setMyHeadCell(goHead)

		txtName.text = RoleModel.instance:getUserName()
	end
end

function LotusbattlereportdetailView:_clearDetailCell(cell)
	return
end

function LotusbattlereportdetailView:_getTimeFormat(time)
	time = checknumber(time)
	time = math.floor(time / 1000)

	local date = GameUtil.time2date(time)

	return string.format("%s月%s日 %02d:%02d", date.month, date.day, date.hour, date.min)
end

function LotusbattlereportdetailView:_updateUI()
	self:_setBuff()
	self:_setPets()
	self:_setDetails()
end

function LotusbattlereportdetailView:_setDetails()
	table.sort(self._battlerecordMsg.battleRecord, function(a, b)
		return checknumber(a.recordTime) > checknumber(b.recordTime)
	end)
	self._detailscrollerList:reloadData(self._battlerecordMsg.battleRecord)
	goutil.setActive(self._noDetailGo, self._battlerecordMsg.battleRecord and #self._battlerecordMsg.battleRecord <= 0)
end

function LotusbattlereportdetailView:_setBuff()
	local buffIds = self._battlerecordMsg.buffIds
	local buffCfgs = {}
	local modelId = self._battlerecordMsg.modelId
	local modelCfg = LotusbattleConfig.instance:getModelCfg(self._activityId, modelId)

	for i, buffId in ipairs(buffIds) do
		local buffCfg = LotusbattleConfig.instance:getBuffCfg(modelCfg.buffPlanId, buffId)

		table.insert(buffCfgs, buffCfg)
	end

	self._buffscrollerList:reloadData(buffCfgs)
end

function LotusbattlereportdetailView:_setPets()
	local creepIds = self._battlerecordMsg.creepIds
	local petMos = {}

	for i, creepId in ipairs(creepIds) do
		local petMo = LotusbattleModel.instance:getPetMoByCreepsId(creepId)

		table.insert(petMos, petMo)
	end

	self._petscrollerList:reloadData(petMos)
end

return LotusbattlereportdetailView
