-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamchat/view/DreamteamnewsView.lua

module("logic.extensions.dreamchat.view.DreamteamnewsView", package.seeall)

local DreamteamnewsView = class("DreamteamnewsView", ViewComponent)

function DreamteamnewsView:ctor()
	DreamteamnewsView.super.ctor(self)
end

function DreamteamnewsView:buildUI()
	DreamteamnewsView.super.buildUI(self)

	self._close = self:getBtn("btnClose")
	self._showImg = self:getGo("imgPoster")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtIssue")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txtDesc")
	self._scrollObj = self:getGo("tableview")
	self._tableCell = self:getGo("tabCell")

	self._tableCell:SetActive(false)

	self._tableview = ScrollerList.create(self._scrollObj, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))
end

function DreamteamnewsView:bindEvents()
	DreamteamnewsView.super.bindEvents(self)
	self._close:AddClickListener(self._closeAction, self)
end

function DreamteamnewsView:unbindEvents()
	DreamteamnewsView.super.unbindEvents(self)
	self._close:RemoveClickListener()
end

function DreamteamnewsView:destroyUI()
	DreamteamnewsView.super.destroyUI(self)
end

function DreamteamnewsView:onEnter()
	DreamteamnewsView.super.onEnter(self)

	local params = self:getOpenParam()

	self._curOpenTab = params[1]
	self._curIndex = params[2] or self._curOpenTab[#self._curOpenTab]
	self._titleBtns = {}

	if #self._curOpenTab > 0 then
		local titleTab = {}

		for i, v in pairs(self._curOpenTab) do
			table.insert(titleTab, v)
		end

		self._tableview:reloadData(titleTab)
	end

	self._scrollObj:SetActive(#self._curOpenTab > 0)
	self:_onClickView(self._curIndex)
end

function DreamteamnewsView:onEnterFinished()
	DreamteamnewsView.super.onEnterFinished(self)
end

function DreamteamnewsView:onExit()
	DreamteamnewsView.super.onExit(self)
	uGuiUtil.clearImage(self._showImg)
end

function DreamteamnewsView:onExitFinished()
	DreamteamnewsView.super.onExitFinished(self)
end

function DreamteamnewsView:_updateCell(view, cell, data)
	local txtSel = goutil.findChildTextComponent(cell, "Text")

	txtSel.text = "Vol." .. data

	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickView, self, data))

	local imgTagChange = cell:GetComponent("UIImageSpriteChange")

	imgTagChange:SetState(self._curIndex == data and 1 or 0)
end

function DreamteamnewsView:_onClickView(index)
	self._curIndex = index

	self._tableview:refresh()

	local cfg = OperationSignInConfig.instance:getSignDreamCfg(index)

	self._txtTitle.text = "Vol." .. index
	self._txtDesc.text = cfg.content

	uGuiUtil.setSpriteToImage(self._showImg, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/dreamteamnews/%s.png", cfg.image))
end

function DreamteamnewsView:_clearTableview(cell)
	GameUtil.rmClickHandler(cell)
end

function DreamteamnewsView:_closeAction()
	self.mainGO.transform:DOScale(Vector3.New(0, 0, 0), 0.5):OnComplete(function()
		self:close()
		GlobalDispatcher:dispatch(GlobalNotify.DreamnewsClose)
	end)
end

return DreamteamnewsView
