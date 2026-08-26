-- chunkname: @modules/logic/playercard/view/PlayerCardView.lua

module("modules.logic.playercard.view.PlayerCardView", package.seeall)

local PlayerCardView = class("PlayerCardView", BaseView)

function PlayerCardView:onInitView()
	self.goRight = gohelper.findChild(self.viewGO, "Right")
	self.btnDetail = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_detail/#btn_click")
	self.goPlayerInfo = gohelper.findChild(self.goRight, "#go_playerinfo")
	self.goAssit = gohelper.findChild(self.goRight, "#go_assit")
	self.goChapter = gohelper.findChild(self.goRight, "#go_chapter")
	self.goCardGroup = gohelper.findChild(self.goRight, "#go_cardgroup")
	self.goAchievement = gohelper.findChild(self.goRight, "#go_achievement")

	self:loadRight()
	self:initRightLayout()

	self.gotips = gohelper.fiNewPlayerCardContentViewndChild(self.viewGO, "#go_tips")
	self.btnCloseTips = gohelper.findChildButtonWithAudio(self.gotips, "#btn_close")
	self.goTipsNode = gohelper.findChild(self.gotips, "node")
	self.btnLayout = gohelper.findChildButtonWithAudio(self.goTipsNode, "#btn_layout")
	self.btnChangeSkin = gohelper.findChildButtonWithAudio(self.goTipsNode, "#btn_changeskin")
end

function PlayerCardView:addEvents()
	self.addClickCb(self, self.btnCloseTips, self.onClickCloseTips, self)
	self.addClickCb(self, self.btnLayout, self.onClickLayout, self)
	self.addClickCb(self, self.btnChangeSkin, self.onClickChangeSkin, self)
	self.addClickCb(self, self.btnDetail, self.onClickDetail, self)
	self.addEventCb(self, PlayerController.instance, PlayerEvent.PlayerbassinfoChange, self.onPlayerBaseInfoChange, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.UpdateCardInfo, self.refreshView, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.ShowListBtn, self.onShowListBtn, self)
end

function PlayerCardView:removeEvents()
	return
end

function PlayerCardView:onShowListBtn(btn)
	gohelper.setActive(self.gotips, true)

	local transform = btn.transform
	local x, y = recthelper.rectToRelativeAnchorPos2(transform.position, self.gotips.transform)

	recthelper.setAnchor(self.goTipsNode.transform, x - 190, y - 105)
end

function PlayerCardView:onClickCloseTips()
	gohelper.setActive(self.gotips, false)
end

function PlayerCardView:onClickLayout()
	gohelper.setActive(self.gotips, false)
	ViewMgr.instance:openView(ViewName.PlayerCardLayoutView, {
		userId = self.userId
	})
end

function PlayerCardView:onClickChangeSkin()
	gohelper.setActive(self.gotips, false)
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.ShowTheme)
end

function PlayerCardView:onClickDetail()
	local info = self:getCardInfo()

	if not info then
		return
	end

	self:closeThis()
	PlayerController.instance:openPlayerView(info:getPlayerInfo(), info:isSelf())
end

function PlayerCardView:initRightLayout()
	self.rightLayout = MonoHelper.addNoUpdateLuaComOnceToGo(self.goRight, PlayerCardLayout)

	local layoutList = {}

	table.insert(layoutList, self:getLayoutItem(self.goAssit, PlayerCardEnum.RightLayout.Assit))
	table.insert(layoutList, self:getLayoutItem(self.goChapter, PlayerCardEnum.RightLayout.Chapter))
	table.insert(layoutList, self:getLayoutItem(self.goCardGroup, PlayerCardEnum.RightLayout.CardGroup, PlayerCardLayoutItemCardGroup, self.cardGroupComp))
	table.insert(layoutList, self:getLayoutItem(self.goAchievement, PlayerCardEnum.RightLayout.Achievement))
	self.rightLayout:setLayoutList(layoutList)
end

function PlayerCardView:getLayoutItem(go, layoutKey, layoutComp, cardComp)
	local param = {}

	param.layoutKey = layoutKey
	param.viewRoot = self.viewGO
	param.layout = self.rightLayout
	param.cardComp = cardComp
	layoutComp = layoutComp or PlayerCardLayoutItem

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, layoutComp, param)
end

function PlayerCardView:refreshLayout(info)
	local layoutData = info:getLayoutData()

	self.rightLayout:setEditMode(false)
	self.rightLayout:setData(layoutData)
end

function PlayerCardView:loadRight()
	self.compList = {}

	local otherRes = self.viewContainer:getSetting().otherRes

	self:loadGO(self.goPlayerInfo, PlayerCardPlayerInfo, otherRes.infoview)
	self:loadGO(self.goAssit, PlayerCardAssit, otherRes.assitview)
	self:loadGO(self.goChapter, PlayerCardChapter, otherRes.chapterview)

	local achieveParam = {
		itemRes = self.viewContainer:getRes(otherRes.achieveitem)
	}

	self:loadGO(self.goAchievement, PlayerCardAchievement, otherRes.achieveview, achieveParam)

	local param = {
		itemRes = self.viewContainer:getRes(otherRes.carditem)
	}

	self.cardGroupComp = self:loadGO(self.goCardGroup, PlayerCardCardGroup, otherRes.groupview, param)
end

function PlayerCardView:loadGO(go, cls, resPath, param)
	local parent = gohelper.findChild(go, "card")
	local resGO = self:getResInst(resPath, parent or go)

	gohelper.setAsFirstSibling(resGO)

	param = param or {}
	param.compType = PlayerCardEnum.CompType.Normal

	local comp = MonoHelper.addNoUpdateLuaComOnceToGo(resGO, cls, param)

	table.insert(self.compList, comp)

	return comp
end

function PlayerCardView:onPlayerBaseInfoChange(info)
	if info.userId == self.userId then
		self:refreshView()
	end
end

function PlayerCardView:onOpen()
	self:_updateParam()
	self:refreshView()
end

function PlayerCardView:onUpdateParam()
	self:_updateParam()
	self:refreshView()
end

function PlayerCardView:_updateParam()
	local param = self.viewParam

	self.userId = param.userId
end

function PlayerCardView:getCardInfo()
	return PlayerCardModel.instance:getCardInfo(self.userId)
end

function PlayerCardView:refreshView()
	local info = self:getCardInfo()

	if not info then
		return
	end

	self:refreshCompList(info)
	self:refreshLayout(info)
end

function PlayerCardView:refreshCompList(info)
	if not self.compList then
		return
	end

	for i, v in ipairs(self.compList) do
		v:refreshView(info)
	end
end

function PlayerCardView:onClose()
	return
end

return PlayerCardView
