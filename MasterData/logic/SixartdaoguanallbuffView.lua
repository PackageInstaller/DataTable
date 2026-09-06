-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartdaoguanallbuffView.lua

module("logic.extensions.sixartdaoguan.view.SixartdaoguanallbuffView", package.seeall)

local SixartdaoguanallbuffView = class("SixartdaoguanallbuffView", ViewComponent)

function SixartdaoguanallbuffView:ctor()
	SixartdaoguanallbuffView.super.ctor(self)
end

function SixartdaoguanallbuffView:unbindEvents()
	SixartdaoguanallbuffView.super.unbindEvents(self)
	self._btnRefresh:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function SixartdaoguanallbuffView:bindEvents()
	SixartdaoguanallbuffView.super.bindEvents(self)
	self._btnRefresh:AddClickListener(self._onClickbtnRefresh, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function SixartdaoguanallbuffView:buildUI()
	SixartdaoguanallbuffView.super.buildUI(self)

	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnRefresh = self:getBtn("btnRefresh")
	self._emptyGo = self:getGo("empty")
	self._btnClose = self:getBtn("btnClose")
end

function SixartdaoguanallbuffView:onExit()
	SixartdaoguanallbuffView.super.onExit(self)
	self._scrollerList:dispose()
end

function SixartdaoguanallbuffView:onEnter()
	SixartdaoguanallbuffView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SixArtDaoguanReShuffleDropBuffRes, self._onSixArtDaoguanReShuffleDropBuffRes, self)
	self.addGEvent(self, GlobalNotify.SixArtDaoguanSelectDropBuffRes, self._updateUI, self)

	self._activityId = self:getFirstParam()
	self._info = SixartdaoguanModel.instance:getInfo(self._activityId)

	self:_updateUI()
end

function SixartdaoguanallbuffView:_updateCell(view, cell, buffId, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local goBuffIcon = goutil.findChild(cell.gameObject, "BuffIcon")
	local buffIcon = Framework.ImageBigBG.Get(goBuffIcon)
	local imgChangeLevel = goutil.findChild(cell.gameObject, "level"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local cfg = SixartdaoguanConfig.instance:getBuffCfg(self._activityId, buffId)

	txtDesc.text = cfg.buffDesc
	txtName.text = cfg.buffName

	buffIcon:SetImage(GameUrl.getExpEventUrl(cfg.iconPath))
	btn:AddClickListener(function()
		return
	end)
end

function SixartdaoguanallbuffView:_clearCell(cell)
	local goBuffIcon = goutil.findChild(cell.gameObject, "BuffIcon")
	local buffIcon = Framework.ImageBigBG.Get(goBuffIcon)

	buffIcon:ClearImage()
end

function SixartdaoguanallbuffView:_initSelectBuffId()
	local dropBuffInfo

	for i, v in ipairs(self._info.challenges) do
		if v.challengeId == SixartdaoguanController.ChallengeType.Defense then
			dropBuffInfo = v.dropBuffInfo

			break
		end
	end

	if dropBuffInfo then
		self._selectedDropBuffId = dropBuffInfo.selectedDropBuffId or {}
	end
end

function SixartdaoguanallbuffView:_updateUI()
	self:_initSelectBuffId()
	self._scrollerList:reloadData(self._selectedDropBuffId)

	if self._selectedDropBuffId then
		local hasData = #self._selectedDropBuffId > 0

		goutil.setActive(self._emptyGo, not hasData)
		goutil.setActive(self._btnRefresh.gameObject, hasData)
	end
end

function SixartdaoguanallbuffView:_onClickbtnRefresh()
	local challengeCfg = SixartdaoguanConfig.instance:getChallengeCfg(self._activityId, SixartdaoguanController.ChallengeType.Defense)
	local matType, matId, matNum = MaterialMgr.getMatParams(challengeCfg.resetDropBuffCost)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local text = string.format("是否花费%s%s清除所有祝福，并重新选择", matNum, matName)

	TipsFacade.instance:openTipWindow("提示", text, function()
		SixArtDaoguanAgent.instance:sendPM_SixArtDaoguanReShuffleDropBuffReq(self._activityId, SixartdaoguanController.ChallengeType.Defense)
	end)
end

function SixartdaoguanallbuffView:_onClickbtnClose()
	self:close()
end

function SixartdaoguanallbuffView:_onSixArtDaoguanReShuffleDropBuffRes()
	self:_updateUI()
end

return SixartdaoguanallbuffView
